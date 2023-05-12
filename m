Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA7B700960
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbjELNn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240443AbjELNn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:43:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F784132B2;
        Fri, 12 May 2023 06:43:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6171D68AA6; Fri, 12 May 2023 15:43:23 +0200 (CEST)
Date:   Fri, 12 May 2023 15:43:23 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/14] block: bio-integrity: modify
 bio_integrity_add_page()
Message-ID: <20230512134323.GA32242@lst.de>
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1> <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p7> <20230510084854epcms2p756a3e1055399ead6bf539d3419c74c3e@epcms2p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510084854epcms2p756a3e1055399ead6bf539d3419c74c3e@epcms2p7>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinyoung,

can you work a bit on the commit log and especially the subject line?

I'd word this as something like:

"Subject: bio-integrity: create multi-page bvecs in bio_integrity_add_page()

Allow bio_integrity_add_page to create multi-page bvecs, just like
the bio payloads.  This simplifies adding larger payloads, and fixes
support for non-tiny workloads with nvme, which stopped using scatterlist
for metadata a while ago"

It should probably also mentioned somewhere that you did an audit to
ensure all drivers and the core code is fine with these multi-page
segments.  If it's not, this patch should only be added after that
has been made the case.

I think the extra arguments struct is a bit overcompliated, and mostly
due to me making the existing code to weird things in the low-level
helpers.  With the "rationalize the flow in bio_add_page and friends"
series I just sent out, I think we can drop the previous patch and
simplify this one down to:

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4533eb49166109..85d70dc723f0ed 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -118,26 +118,44 @@ void bio_integrity_free(struct bio *bio)
  * @len:	number of bytes of integrity metadata in page
  * @offset:	start offset within page
  *
- * Description: Attach a page containing integrity metadata to bio.
+ * Add a page containing integrity metadata to a bio while respecting
+ * the hardware max_sectors, max_segment and gap limitations.
  */
 int bio_integrity_add_page(struct bio *bio, struct page *page,
 			   unsigned int len, unsigned int offset)
 {
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 
-	if (bip->bip_vcnt >= bip->bip_max_vcnt) {
-		printk(KERN_ERR "%s: bip_vec full\n", __func__);
+	if (((bip->bip_iter.bi_size + len) >> SECTOR_SHIFT) >
+	    queue_max_hw_sectors(q))
 		return 0;
-	}
 
-	if (bip->bip_vcnt &&
-	    bvec_gap_to_prev(&bdev_get_queue(bio->bi_bdev)->limits,
-			     &bip->bip_vec[bip->bip_vcnt - 1], offset))
-		return 0;
+	if (bip->bip_vcnt > 0) {
+		struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
+		bool same_page = false;
+
+		if (bvec_try_merge_hw_page(q, bv, page, len, offset,
+				&same_page)) {
+			bip->bip_iter.bi_size += len;
+			return len;
+		}
+
+		if (bip->bip_vcnt >=
+		    min(bip->bip_max_vcnt, queue_max_integrity_segments(q)))
+			return 0;
+
+		/*
+		 * If the queue doesn't support SG gaps and adding this segment
+		 * would create a gap, disallow it.
+		 */
+		if (bvec_gap_to_prev(&q->limits, bv, offset))
+			return 0;
+	}
 
 	bvec_set_page(&bip->bip_vec[bip->bip_vcnt], page, len, offset);
 	bip->bip_vcnt++;
-
+	bip->bip_iter.bi_size += len;
 	return len;
 }
 EXPORT_SYMBOL(bio_integrity_add_page);
@@ -249,7 +267,6 @@ bool bio_integrity_prep(struct bio *bio)
 	}
 
 	bip->bip_flags |= BIP_BLOCK_INTEGRITY;
-	bip->bip_iter.bi_size = len;
 	bip_set_seed(bip, bio->bi_iter.bi_sector);
 
 	if (bi->flags & BLK_INTEGRITY_IP_CHECKSUM)
diff --git a/block/bio.c b/block/bio.c
index 79e8aa600ddbe2..050b57e09ac362 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -934,7 +934,7 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
  * size limit.  This is not for normal read/write bios, but for passthrough
  * or Zone Append operations that we can't split.
  */
-static bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
+bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 		struct page *page, unsigned len, unsigned offset,
 		bool *same_page)
 {
diff --git a/block/blk.h b/block/blk.h
index 45547bcf111938..1e67f738b52191 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -486,4 +486,8 @@ static inline int req_ref_read(struct request *req)
 	return atomic_read(&req->ref);
 }
 
+bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
+		struct page *page, unsigned len, unsigned offset,
+		bool *same_page);
+
 #endif /* BLK_INTERNAL_H */
-- 
2.39.2

