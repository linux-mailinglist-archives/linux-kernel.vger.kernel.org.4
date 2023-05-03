Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4126F5623
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjECK11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjECK1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:27:25 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F1244B2
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:27:23 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230503102721epoutp0402f1460007fe98e7f00d4cc06d4e3dec~bm00QjVwE3161231612epoutp04W
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:27:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230503102721epoutp0402f1460007fe98e7f00d4cc06d4e3dec~bm00QjVwE3161231612epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683109641;
        bh=2tjd0O0lZWt8c5dIoxfFDYaBGx6V9lKhttI7UOkE/aI=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=svugPknYSM4UTmlHhT7iqGAew3dqoA/scXQ+mDa88AbXhtZKESyDXlUxbZfljlZnr
         MeF3ER7Z9pXyaBCbhOPYy7KXJOFyoLEY8RfcxTqY+uUKF5LkoKGoEUuV2Ts3R+w+JI
         psxjXTZIpRBr19E0J1iSDxG6QhhHc9G3KDXZWs9Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230503102720epcas2p15ada5b8e729e3e2e82e00e5bc0baba27~bm0zvRyUY0379803798epcas2p1Z;
        Wed,  3 May 2023 10:27:20 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QBCn36psCz4x9Q1; Wed,  3 May
        2023 10:27:19 +0000 (GMT)
X-AuditID: b6c32a48-6d3fa70000005998-6c-6452370710a0
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.A0.22936.70732546; Wed,  3 May 2023 19:27:19 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 14/15] block: blk-integrity: change sg-table configuration
 method for integrity
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230503102719epcms2p457434fefd535ee43d502eff854227919@epcms2p4>
Date:   Wed, 03 May 2023 19:27:19 +0900
X-CMS-MailID: 20230503102719epcms2p457434fefd535ee43d502eff854227919
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmuS67eVCKwcXpxhar7/azWbw8pGmx
        cvVRJove/q1sFntvaVtc3jWHzWL58X9MDuwel8+Weuy+2cDm8fHpLRaPvi2rGD0+b5ILYI3K
        tslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBukFJoSwx
        pxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ2x
        4/l/9oI9ChWbpt5ja2C8ItnFyMkhIWAicenOAvYuRi4OIYEdjBJPX95g62Lk4OAVEJT4u0MY
        pEZYIFHi7qleNhBbSEBJ4tyaWYwgJcICBhK3es1BwmwCehI/l8wAKxERWM0k0fy8BmI8r8SM
        9qcsELa0xPblWxlBbE4BP4nHG24xQsQ1JH4s62WGsEUlbq5+yw5jvz82H6pGRKL13lmoGkGJ
        Bz93Q8UlJQ4d+gp2sYRAvsSGA4EQ4RqJt8sPQJXoS1zr2Ah2Aq+Ar8S1FX/BzmQRUJXY/+Ie
        VI2LxKWjr8HizALyEtvfzmEGGcksoCmxfpc+xHRliSO3WCAq+CQ6Dv9lh3mwYeNvrOwd854w
        QbSqSSxqMoIIy0h8PTyffQKj0ixEIM9CsnYWwtoFjMyrGMVSC4pz01OLjQpM4PGanJ+7iRGc
        ErU8djDOfvtB7xAjEwfjIUYJDmYlEd4PhX4pQrwpiZVVqUX58UWlOanFhxhNgR6eyCwlmpwP
        TMp5JfGGJpYGJmZmhuZGpgbmSuK8HzuUU4QE0hNLUrNTUwtSi2D6mDg4pRqYZp4IZ0uR/HDE
        YJcjy2Gve+/bOncUz9l2m8Vsmaua0YaXVy7om1Y62vkf4n5hdnGLpWDCBksbXnG3Goe1/U61
        u9bE77dkY5+V36LktHTpc+YZXadzgi7H8jSvdkj4ovfixlcFBu3laU1zD54+0Pb3+lqFwkI/
        x4z+bXecv+WcPsy/J8ApwSqp7vIZhiMPPPnenzEIzn06ZeGaR9UeWvnREW+edb/Ze35zhErJ
        O4FI38tFTuHJW9pu/7+7/VmMWVj3XseQk/HS3msY/q1LljgT6tWb3p21IG/BvyMrDKMVN5VL
        Gro7GW3duvlNSMjF77ErLr/vKDb/8mu3/Y7ZGekWfR7LeduDwrRFeKptLLSVWIozEg21mIuK
        EwFnQNY1EgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 block/blk-integrity.c | 52 -------------------------------------------
 block/blk-merge.c     | 52 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 52 deletions(-)

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
index c6a0958e8df1..71539d88ffe6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -524,6 +524,58 @@ __blk_segment_map_sg_merge(struct request_queue *q, struct bio_vec *bvec,
 	return true;
 }
 
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
+
 static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 			     struct scatterlist *sglist,
 			     struct scatterlist **sg)
-- 
2.34.1
