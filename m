Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468756FDA43
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbjEJJAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbjEJJAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:00:33 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13A81991
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 02:00:31 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230510090029epoutp04ffcb8da21d6fff2967244644673de629~dvJ_zWSMz0275802758epoutp04V
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:00:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230510090029epoutp04ffcb8da21d6fff2967244644673de629~dvJ_zWSMz0275802758epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683709229;
        bh=wje4+70dQGpdS69u2rE7bX4B832hSjQqhr75qyzguy4=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=kqhxbcPSaXcHOAsTgBGMGwm6YMedZCqxm6NhZsPtvidMrw0TQYSXo3t1TL3e3V4aZ
         s3XjZK5KaBGeCUInbvdLn6FJvNZzS/7Qwein6X4MVcSn56wH4Kt1c+Ynba6AtS6uqJ
         1V/YEzJFik18+sROJmWlMXWngEiRRf69GgrjAuhc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230510090029epcas2p4bf8726b14940f028d6ff4c6aedc737fb~dvJ_PgxYW3236532365epcas2p4S;
        Wed, 10 May 2023 09:00:29 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QGTWc466Bz4x9Q0; Wed, 10 May
        2023 09:00:28 +0000 (GMT)
X-AuditID: b6c32a45-465ff70000020cc1-e1-645b5d2c08f0
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.2F.03265.C2D5B546; Wed, 10 May 2023 18:00:28 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 13/14] block: blk-integrity: change sg-table
 configuration method for integrity
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
Message-ID: <20230510090028epcms2p6bdffebacbdf4784bbf03a62b7101dd98@epcms2p6>
Date:   Wed, 10 May 2023 18:00:28 +0900
X-CMS-MailID: 20230510090028epcms2p6bdffebacbdf4784bbf03a62b7101dd98
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmma5ObHSKwf4Pchar7/azWbw8pGmx
        cvVRJove/q1sFotubGOy+Nt1j8li0qFrjBZPr85isth7S9vi8q45bBbLj/9jslj3+j2Lxe8f
        c9gceD3O39vI4rF5hZbH5bOlHptWdbJ5TFh0gNFj980GNo/e5ndsHh+f3mLx6NuyitHj8yY5
        j/YD3UwB3FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+Abpu
        mTlA5ysplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwN
        DIxMgQoTsjMWNa1jLuhSrJj45xprA+MsqS5GTg4JAROJi+/72boYuTiEBHYwSmzpfsHcxcjB
        wSsgKPF3hzBIjbBAisS7lR3sILaQgJLEuTWzGEFKhAUMJG71moOE2QT0JH4umQE2RkRgJ4vE
        9/tHGSHm80rMaH/KAmFLS2xfvhWsl1PAT6L1sSVEWEPix7JeZghbVOLm6rfsMPb7Y/OhxohI
        tN47C1UjKPHg526ouKTEoUNf2UBGSgjkS2w4EAgRrpF4u/wAVIm+xLWOjWAX8Ar4Ssw7eBEs
        ziKgKjHn5QomiBoXic3tU8DWMgvIS2x/OwccCMwCmhLrd+lDTFeWOHKLBaKCT6Lj8F92mP8a
        Nv7Gyt4x7wkTRKuaxKImI4iwjMTXw/PZJzAqzUIE8iwka2chrF3AyLyKUSy1oDg3PbXYqMAQ
        Hq/J+bmbGMGJWMt1B+Pktx/0DjEycTAeYpTgYFYS4fUOjUoR4k1JrKxKLcqPLyrNSS0+xGgK
        9PBEZinR5HxgLsgriTc0sTQwMTMzNDcyNTBXEueVtj2ZLCSQnliSmp2aWpBaBNPHxMEp1cCk
        zntdeHOUfohO9J+NjBunlB83EtfweHv00fdizuKksl8eK2r+yyZ6OH02vHVFI0mtgD/+zamH
        FZ8+6urcUko4pX5pUZxFgWiiy5GO9rwlnZzrKz+wxPfWmwq6FJv8v8x7PFaOZeoCS4ttUevs
        +c4VzemJ82LPWXz3lWC8Z5NBSIjspRar3PDGMo2LZ0Wnatn8/Hu2pX9BnnRsuSrLr4d71mX4
        ls2Y0l3fdSJd98zmbXuV0g7xdJqwnRby6YuZaR4n99rR8dH0UDPF6fM+HUpketj2bYvGDK2w
        qyava6pNT8y1XH2SdfZjm/+8pVO/R2yX/+ojosDctPb84kezr/7uiV++zML5kMKud6avtiqx
        FGckGmoxFxUnAgBw8ne9TQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, a bio_vec of bip was made of one page in the block layer, and
sg_list was generated using hw information in lld.

This is done in the block layer and the bio_vec has been changed to
multi-page, so it is changed to configure the sg-table using the existing
api, such as the sg-table setting for the bio. (e.g. multi-page map)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/blk-integrity.c | 52 -----------------------------------------
 block/blk-merge.c     | 54 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 64407b412947..c50954652177 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -55,58 +55,6 @@ int blk_rq_count_integrity_sg(struct request_queue *q, struct bio *bio)
 }
 EXPORT_SYMBOL(blk_rq_count_integrity_sg);
 
-/**
- * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
- * @q:		request queue
- * @bio:	bio with integrity metadata attached
- * @sglist:	target scatterlist
- *
- * Description: Map the integrity vectors in request into a
- * scatterlist.  The scatterlist must be big enough to hold all
- * elements.  I.e. sized using blk_rq_count_integrity_sg().
- */
-int blk_rq_map_integrity_sg(struct request_queue *q, struct bio *bio,
-			    struct scatterlist *sglist)
-{
-	struct bio_vec iv, ivprv = { NULL };
-	struct scatterlist *sg = NULL;
-	unsigned int segments = 0;
-	struct bvec_iter iter;
-	int prev = 0;
-
-	bio_for_each_integrity_vec(iv, bio, iter) {
-
-		if (prev) {
-			if (!biovec_phys_mergeable(q, &ivprv, &iv))
-				goto new_segment;
-			if (sg->length + iv.bv_len > queue_max_segment_size(q))
-				goto new_segment;
-
-			sg->length += iv.bv_len;
-		} else {
-new_segment:
-			if (!sg)
-				sg = sglist;
-			else {
-				sg_unmark_end(sg);
-				sg = sg_next(sg);
-			}
-
-			sg_set_page(sg, iv.bv_page, iv.bv_len, iv.bv_offset);
-			segments++;
-		}
-
-		prev = 1;
-		ivprv = iv;
-	}
-
-	if (sg)
-		sg_mark_end(sg);
-
-	return segments;
-}
-EXPORT_SYMBOL(blk_rq_map_integrity_sg);
-
 /**
  * blk_integrity_compare - Compare integrity profile of two disks
  * @gd1:	Disk to compare
diff --git a/block/blk-merge.c b/block/blk-merge.c
index c6a0958e8df1..f17e19ff3a11 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -524,6 +524,60 @@ __blk_segment_map_sg_merge(struct request_queue *q, struct bio_vec *bvec,
 	return true;
 }
 
+#if defined(CONFIG_BLK_DEV_INTEGRITY)
+/**
+ * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
+ * @q:		request queue
+ * @bio:	bio with integrity metadata attached
+ * @sglist:	target scatterlist
+ *
+ * Description: Map the integrity vectors in request into a scatterlist.
+ * The scatterlist must be big enough to hold all elements.
+ */
+int blk_rq_map_integrity_sg(struct request_queue *q, struct bio *bio,
+			    struct scatterlist *sglist)
+{
+	struct bio_vec iv, ivprv = { NULL };
+	struct scatterlist *sg = NULL;
+	unsigned int nsegs = 0;
+	struct bvec_iter iter;
+	bool new_bio = false;
+
+	for_each_bio(bio) {
+		struct bio_integrity_payload *bip = bio->bi_integrity;
+
+		bip_for_each_mp_bvec(iv, bip, iter) {
+			/*
+			 * Only try to merge bvecs from two bios given we
+			 * have done bio internal merge when adding pages
+			 * to bio
+			 */
+			if (new_bio &&
+			    __blk_segment_map_sg_merge(q, &iv, &ivprv, &sg))
+				goto next_iv;
+
+			if (iv.bv_offset + iv.bv_len <= PAGE_SIZE)
+				nsegs += __blk_bvec_map_sg(iv, sglist, &sg);
+			else
+				nsegs += blk_bvec_map_sg(q, &iv, sglist, &sg);
+ next_iv:
+			new_bio = false;
+		}
+
+		if (likely(bip->bip_iter.bi_size)) {
+			ivprv = iv;
+			new_bio = true;
+		}
+	}
+
+	if (sg)
+		sg_mark_end(sg);
+
+	return nsegs;
+}
+EXPORT_SYMBOL(blk_rq_map_integrity_sg);
+#endif /* CONFIG_BLK_DEV_INTEGRITY */
+
 static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 			     struct scatterlist *sglist,
 			     struct scatterlist **sg)
-- 
2.34.1
