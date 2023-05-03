Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80C66F5628
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjECK20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjECK2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:28:23 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06BD10F3
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:28:21 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230503102820epoutp0130881227ee3bfab8d46b6d0f1f935703~bm1rYOfJB2902729027epoutp01V
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:28:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230503102820epoutp0130881227ee3bfab8d46b6d0f1f935703~bm1rYOfJB2902729027epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683109700;
        bh=z1Pr/BMubVK5gm0MNy0PUzgA5DYmQXK+i/O5omA92XA=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=DfghvSUUIX54ioWeOM+ZO960qSwEM4DlGHKy0OxHqVyGAfRbtPzHFx2J97sZpjl8t
         y64Ej5j55frDtqnQjXxWq/WoEluvVlbA9hWPsMgppBpGanyxMUWkEwQyMY6+gADH7N
         JpaiuNbKN6dFO1sbpQavJyJ3xNP8E5Mh4vlaCPoY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230503102819epcas2p3d5d48480285c6355b70b4be904d57435~bm1q5sKgY2240622406epcas2p35;
        Wed,  3 May 2023 10:28:19 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.90]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QBCpC1Sy5z4x9Px; Wed,  3 May
        2023 10:28:19 +0000 (GMT)
X-AuditID: b6c32a45-465ff70000020cc1-47-64523743bffa
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.12.03265.34732546; Wed,  3 May 2023 19:28:19 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 15/15] block: blk-integrity: remove
 blk_rq_count_integrity_sg()
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
Message-ID: <20230503102818epcms2p8fe187efd29182c441c2670f890c8f9c1@epcms2p8>
Date:   Wed, 03 May 2023 19:28:18 +0900
X-CMS-MailID: 20230503102818epcms2p8fe187efd29182c441c2670f890c8f9c1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmha6zeVCKwY59HBar7/azWbw8pGmx
        cvVRJove/q1sFntvaVtc3jWHzWL58X9MDuwel8+Weuy+2cDm8fHpLRaPvi2rGD0+b5ILYI3K
        tslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBukFJoSwx
        pxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ1x
        dtEZxoJuoYqVC/vZGhhf8nUxcnJICJhI7P/zgLmLkYtDSGAHo8Tt7WeAHA4OXgFBib87hEFq
        hAUCJa68/cIKYgsJKEmcWzOLEaREWMBA4lavOUiYTUBP4ueSGWwgtojAaiaJ5uc1EON5JWa0
        P2WBsKUlti/fyghicwr4STzecIsRIq4h8WNZLzOELSpxc/Vbdhj7/bH5UDUiEq33zkLVCEo8
        +LkbKi4pcejQVzaQcyQE8iU2HAiECNdIvF1+AKpEX+Jax0awE3gFfCVm7HjABGKzCKhKnFxx
        Auo0F4m7e86CfcgsIC+x/e0ccCAwC2hKrN+lDzFdWeLILRaICj6JjsN/2WEebNj4Gyt7x7wn
        TBCtahKLmowgwjISXw/PZ5/AqDQLEcizkKydhbB2ASPzKkax1ILi3PTUYqMCQ3i8JufnbmIE
        p0Qt1x2Mk99+0DvEyMTBeIhRgoNZSYT3Q6FfihBvSmJlVWpRfnxRaU5q8SFGU6CHJzJLiSbn
        A5NyXkm8oYmlgYmZmaG5kamBuZI4r7TtyWQhgfTEktTs1NSC1CKYPiYOTqkGJmuVqChxF3Up
        9/gp9lssKoJiL2bLKDXNNnonfX5Og8x9s1qzYi79DZkucTKaSl+Wn5/od2FWecyqhfHXGP9t
        i3rYcVj1S0xr3DzJdxyqPd0vVUr+v/RiC1DY0TAze9XJSx/06yUPJjk863k3cUJGyYN/e4vO
        J1zImeeXtFP5tbfPS/e5M797Vf0snpBje1eym19qrmN6j/z+P1vTfS0/3+eumf1siwf3lP21
        G/b/PnPd7/rSVTNbF9btTTvnrlzr99Duhl0UwyNrKb782YdYt8cVx4u4vlu518nPZ2EfQ0z6
        w8otzeHmFUGXpN0PdN0+Pd9n85MrYr9+8desCdxVvbCz91n+LKMfrixrFfT2KrEUZyQaajEX
        FScCANZ+dCoSBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p8>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_rq_nr_nr_integrity_segments() allows you to obtain the number of
integrity. Therefore, blk_rq_count_integrity_sg() is no longer necessary.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/blk-integrity.c         | 39 -----------------------------------
 include/linux/blk-integrity.h |  1 -
 2 files changed, 40 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index c50954652177..9bac2836c3ff 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -16,45 +16,6 @@
 
 #include "blk.h"
 
-/**
- * blk_rq_count_integrity_sg - Count number of integrity scatterlist elements
- * @q:		request queue
- * @bio:	bio with integrity metadata attached
- *
- * Description: Returns the number of elements required in a
- * scatterlist corresponding to the integrity metadata in a bio.
- */
-int blk_rq_count_integrity_sg(struct request_queue *q, struct bio *bio)
-{
-	struct bio_vec iv, ivprv = { NULL };
-	unsigned int segments = 0;
-	unsigned int seg_size = 0;
-	struct bvec_iter iter;
-	int prev = 0;
-
-	bio_for_each_integrity_vec(iv, bio, iter) {
-
-		if (prev) {
-			if (!biovec_phys_mergeable(q, &ivprv, &iv))
-				goto new_segment;
-			if (seg_size + iv.bv_len > queue_max_segment_size(q))
-				goto new_segment;
-
-			seg_size += iv.bv_len;
-		} else {
-new_segment:
-			segments++;
-			seg_size = iv.bv_len;
-		}
-
-		prev = 1;
-		ivprv = iv;
-	}
-
-	return segments;
-}
-EXPORT_SYMBOL(blk_rq_count_integrity_sg);
-
 /**
  * blk_integrity_compare - Compare integrity profile of two disks
  * @gd1:	Disk to compare
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index 45b9fde1fee1..a2a9d72e8fab 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -41,7 +41,6 @@ void blk_integrity_unregister(struct gendisk *);
 int blk_integrity_compare(struct gendisk *, struct gendisk *);
 int blk_rq_map_integrity_sg(struct request_queue *, struct bio *,
 				   struct scatterlist *);
-int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
 
 static inline unsigned short blk_rq_nr_integrity_segments(struct request *rq)
 {
-- 
2.34.1
