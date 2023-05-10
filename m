Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F8F6FD9E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjEJItH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbjEJItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:49:03 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8B96188
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:48:57 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230510084856epoutp02bc5ca10fcf12b20eaeee93610509ade8~du-43bRgX3185231852epoutp02L
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:48:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230510084856epoutp02bc5ca10fcf12b20eaeee93610509ade8~du-43bRgX3185231852epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683708536;
        bh=Tz77v0EHvEPWfXqlEtqfHLelknA3uibxNOyXoCv2mHI=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=a/tkjC2Zn2ZmfdsOspgH4sqVfeqOfVRRzlVSMAF+Bj8JcAIyiIMmEeZpM5kIjGwi1
         cgMW7rOFJm3RunZ9e6sGgDzcVs6ZoTcRlomQxL0Ei8sPJjzUGct4IPzuiVLC91GnE8
         RoSMmLa5NlP+fbU1rIgC/ALz/00vyXKy0LVJYJDE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230510084855epcas2p23743e3f954c737e37af22c644fb94869~du-4dDxCw2852728527epcas2p2B;
        Wed, 10 May 2023 08:48:55 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QGTGH1kbZz4x9Pv; Wed, 10 May
        2023 08:48:55 +0000 (GMT)
X-AuditID: b6c32a45-465ff70000020cc1-fd-645b5a77e407
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.E7.03265.77A5B546; Wed, 10 May 2023 17:48:55 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 02/14] block: bio-integrity: modify
 bio_integrity_add_page()
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230510084854epcms2p756a3e1055399ead6bf539d3419c74c3e@epcms2p7>
Date:   Wed, 10 May 2023 17:48:54 +0900
X-CMS-MailID: 20230510084854epcms2p756a3e1055399ead6bf539d3419c74c3e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmhW55VHSKwdK1HBar7/azWbw8pGmx
        cvVRJove/q1sFotubGOy+Nt1j8li0qFrjBZPr85isth7S9vi8q45bBbLj/9jslj3+j2Lxe8f
        c9gceD3O39vI4rF5hZbH5bOlHptWdbJ5TFh0gNFj980GNo/e5ndsHh+f3mLx6NuyitHj8yY5
        j/YD3UwB3FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+Abpu
        mTlA5ysplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwN
        DIxMgQoTsjN6dl9gK7jnWTG/5StbA+Msqy5GTg4JAROJi1u+sHYxcnEICexglOh/OJupi5GD
        g1dAUOLvDmGQGmGBQInjB28zgdhCAkoS59bMYgQpERYwkLjVaw4SZhPQk/i5ZAYbyBgRgZ0s
        Et/vH2WEmM8rMaP9KQuELS2xfflWsF5OAT+J1seWEGENiR/LepkhbFGJm6vfssPY74/Nhxoj
        ItF67yxUjaDEg5+7oeKSEocOfWUDGSkhkC+x4UAgRLhG4u3yA1Al+hLXOjaCXcAr4Cux/PRP
        sDiLgKrE1CM3oVa5SGxeMwEsziwgL7H97RxmkJHMApoS63fpQ0xXljhyiwWigk+i4/Bfdpj/
        Gjb+xsreMe8JE0SrmsSiJiOIsIzE18Pz2ScwKs1CBPIsJGtnIaxdwMi8ilEstaA4Nz212KjA
        EB6vyfm5mxjBiVjLdQfj5Lcf9A4xMnEwHmKU4GBWEuH1Do1KEeJNSaysSi3Kjy8qzUktPsRo
        CvTwRGYp0eR8YC7IK4k3NLE0MDEzMzQ3MjUwVxLnlbY9mSwkkJ5YkpqdmlqQWgTTx8TBKdXA
        lOJvf2rhU2W5Lqcb82IunTzWN2HNLK+0HRM5KgQORz3J5v/dYMEmw/rviums7uIf786cD10r
        ul5lifOx6Ftnq7f7aN55dzFIhTtf/NL30LkTawzlEzbvMlLK+TLjMWfscynmM0s2MIToOGi8
        n7LhakbOwjgljkM8rtES9XNUtK3mL65mMiv4pTAreIXOv9uf2QzuZEw1/VHOsPkLR6vqxCA2
        5YKYi/pnL+v0GCZfnMC8975KSYxfd8tO9foXwte8nCuCP/rIxS9h8laLuvXt0RPBXt3fJf3s
        eqf+qy+2fmd9+/GE1bOnW3m6yzssi2bl5NvcN0H3x6pfTCE9/4NWuM/d4r0m9uYCu139WkVZ
        SizFGYmGWsxFxYkAxjrOmE0EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering the constraints of hardware, the physically continuous pages
were to be composed of one bio_vec.
Previously, bio_vec was created separately for each page entering the
parameter.

The page merge process for data and integrity is almost the same. Thus,
the bio was not used as a parameter, but the values referred to in
the merge process were passed to the parameter. At this time, the
parameter could be more than seven, so the page_merge_ctx structure
was added.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Fixes: 783b94bd9250 ("nvme-pci: do not build a scatterlist to map metadata")
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio-integrity.c | 66 ++++++++++++++++++++++++++++++++++---------
 block/bio.c           | 56 +++++++++++++++++++++++-------------
 block/blk.h           | 13 +++++++++
 3 files changed, 102 insertions(+), 33 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4533eb491661..20444ec447cb 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -111,6 +111,23 @@ void bio_integrity_free(struct bio *bio)
 	bio->bi_opf &= ~REQ_INTEGRITY;
 }
 
+/**
+ * bip_full - check if the bip is full
+ * @bip:	bip to check
+ * @len:	length of one segment to be added
+ *
+ * Return true if @bip is full and one segment with @len bytes can't be
+ * added to the bip, otherwise return false
+ */
+static inline bool bip_full(struct bio_integrity_payload *bip, unsigned int len)
+{
+	if (bip->bip_vcnt >= bip->bip_max_vcnt)
+		return true;
+	if (bip->bip_iter.bi_size > UINT_MAX - len)
+		return true;
+	return false;
+}
+
 /**
  * bio_integrity_add_page - Attach integrity metadata
  * @bio:	bio to update
@@ -118,25 +135,53 @@ void bio_integrity_free(struct bio *bio)
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
+	if (((bip->bip_iter.bi_size + len) >> 9) > queue_max_hw_sectors(q))
+		return 0;
+
+	if (bip->bip_vcnt > 0) {
+		struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
+		bool same_page = false;
+		struct page_merge_ctx pmc = {
+			.bv = bv,
+			.bi_vcnt = bip->bip_vcnt,
+			.bi_iter = &bip->bip_iter,
+			.page = page,
+			.len = len,
+			.offset = offset,
+			.same_page = &same_page,
+		};
+
+		if (bio_try_merge_hw_seg(q, &pmc))
+			return len;
+
+		/*
+		 * If the queue doesn't support SG gaps and adding this segment
+		 * would create a gap, disallow it.
+		 */
+		if (bvec_gap_to_prev(&q->limits, bv, offset))
+			return 0;
+	}
+
+	if (bip_full(bip, len)) {
 		printk(KERN_ERR "%s: bip_vec full\n", __func__);
 		return 0;
 	}
 
-	if (bip->bip_vcnt &&
-	    bvec_gap_to_prev(&bdev_get_queue(bio->bi_bdev)->limits,
-			     &bip->bip_vec[bip->bip_vcnt - 1], offset))
+	if (bip->bip_vcnt >= queue_max_integrity_segments(q))
 		return 0;
 
 	bvec_set_page(&bip->bip_vec[bip->bip_vcnt], page, len, offset);
 	bip->bip_vcnt++;
+	bip->bip_iter.bi_size += len;
 
 	return len;
 }
@@ -249,7 +294,6 @@ bool bio_integrity_prep(struct bio *bio)
 	}
 
 	bip->bip_flags |= BIP_BLOCK_INTEGRITY;
-	bip->bip_iter.bi_size = len;
 	bip_set_seed(bip, bio->bi_iter.bi_sector);
 
 	if (bi->flags & BLK_INTEGRITY_IP_CHECKSUM)
@@ -258,7 +302,6 @@ bool bio_integrity_prep(struct bio *bio)
 	/* Map it */
 	offset = offset_in_page(buf);
 	for (i = 0 ; i < nr_pages ; i++) {
-		int ret;
 		bytes = PAGE_SIZE - offset;
 
 		if (len <= 0)
@@ -267,18 +310,13 @@ bool bio_integrity_prep(struct bio *bio)
 		if (bytes > len)
 			bytes = len;
 
-		ret = bio_integrity_add_page(bio, virt_to_page(buf),
-					     bytes, offset);
-
-		if (ret == 0) {
+		if (bio_integrity_add_page(bio, virt_to_page(buf),
+					   bytes, offset) < bytes) {
 			printk(KERN_ERR "could not attach integrity payload\n");
 			status = BLK_STS_RESOURCE;
 			goto err_end_io;
 		}
 
-		if (ret < bytes)
-			break;
-
 		buf += bytes;
 		len -= bytes;
 		offset = 0;
diff --git a/block/bio.c b/block/bio.c
index 1be17dea603a..45af9e39acff 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -926,22 +926,23 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
 }
 
-static bool __bio_try_merge_page(struct bio *bio, struct page *page,
-				 unsigned int len, unsigned int off,
-				 bool *same_page)
+static bool __bio_try_merge_page(struct page_merge_ctx *pmc)
 {
-	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+	struct bio_vec *bv = pmc->bv;
+	struct bvec_iter *bi_iter = pmc->bi_iter;
+	unsigned int len = pmc->len;
+	bool *same_page = pmc->same_page;
 
-	if (!page_is_mergeable(bv, page, len, off, same_page))
+	if (!page_is_mergeable(bv, pmc->page, len, pmc->offset, same_page))
 		return false;
 
-	if (bio->bi_iter.bi_size > UINT_MAX - len) {
+	if (bi_iter->bi_size > UINT_MAX - len) {
 		*same_page = false;
 		return false;
 	}
 
 	bv->bv_len += len;
-	bio->bi_iter.bi_size += len;
+	bi_iter->bi_size += len;
 
 	return true;
 }
@@ -966,13 +967,23 @@ static bool bio_try_merge_page(struct bio *bio, struct page *page,
 			       unsigned int len, unsigned int off,
 			       bool *same_page)
 {
+	struct page_merge_ctx pmc;
+
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return false;
 
 	if (!bio->bi_vcnt)
 		return false;
 
-	return __bio_try_merge_page(bio, page, len, off, same_page);
+	pmc.bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+	pmc.bi_vcnt = bio->bi_vcnt;
+	pmc.bi_iter = &bio->bi_iter;
+	pmc.page = page;
+	pmc.len = len;
+	pmc.offset = off;
+	pmc.same_page = same_page;
+
+	return __bio_try_merge_page(&pmc);
 }
 
 /*
@@ -980,20 +991,19 @@ static bool bio_try_merge_page(struct bio *bio, struct page *page,
  * size limit.  This is not for normal read/write bios, but for passthrough
  * or Zone Append operations that we can't split.
  */
-static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
-				 struct page *page, unsigned len,
-				 unsigned offset, bool *same_page)
+bool bio_try_merge_hw_seg(struct request_queue *q, struct page_merge_ctx *pmc)
 {
-	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 	unsigned long mask = queue_segment_boundary(q);
+	struct bio_vec *bv = pmc->bv;
+	unsigned int len = pmc->len;
 	phys_addr_t addr1 = page_to_phys(bv->bv_page) + bv->bv_offset;
-	phys_addr_t addr2 = page_to_phys(page) + offset + len - 1;
+	phys_addr_t addr2 = page_to_phys(pmc->page) + pmc->offset + len - 1;
 
 	if ((addr1 | mask) != (addr2 | mask))
 		return false;
 	if (bv->bv_len + len > queue_max_segment_size(q))
 		return false;
-	return __bio_try_merge_page(bio, page, len, offset, same_page);
+	return __bio_try_merge_page(pmc);
 }
 
 /**
@@ -1013,8 +1023,6 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page)
 {
-	struct bio_vec *bvec;
-
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
 
@@ -1022,15 +1030,25 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
-		if (bio_try_merge_hw_seg(q, bio, page, len, offset, same_page))
+		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+		struct page_merge_ctx pmc = {
+			.bv = bv,
+			.bi_vcnt = bio->bi_vcnt,
+			.bi_iter = &bio->bi_iter,
+			.page = page,
+			.len = len,
+			.offset = offset,
+			.same_page = same_page,
+		};
+
+		if (bio_try_merge_hw_seg(q, &pmc))
 			return len;
 
 		/*
 		 * If the queue doesn't support SG gaps and adding this segment
 		 * would create a gap, disallow it.
 		 */
-		bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
-		if (bvec_gap_to_prev(&q->limits, bvec, offset))
+		if (bvec_gap_to_prev(&q->limits, bv, offset))
 			return 0;
 	}
 
diff --git a/block/blk.h b/block/blk.h
index 45547bcf1119..dd7cbb57ce43 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -118,6 +118,19 @@ static inline bool bvec_gap_to_prev(const struct queue_limits *lim,
 	return __bvec_gap_to_prev(lim, bprv, offset);
 }
 
+/* page merge context */
+struct page_merge_ctx {
+	struct bio_vec *bv;		/* bvec where @page will be merged */
+	unsigned short bi_vcnt;		/* how many bio_vec's */
+	struct bvec_iter *bi_iter;	/* actual i/o information on device */
+	struct page *page;		/* start page to add */
+	unsigned int len;		/* length of the data to add */
+	unsigned int offset;		/* offset of the data relative to @page */
+	bool *same_page;		/* return if the segment has been merged inside the same page*/
+};
+
+bool bio_try_merge_hw_seg(struct request_queue *q, struct page_merge_ctx *pmc);
+
 static inline bool rq_mergeable(struct request *rq)
 {
 	if (blk_rq_is_passthrough(rq))
-- 
2.34.1
