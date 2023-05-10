Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5846FDA49
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbjEJJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbjEJJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:01:21 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF9530D5
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 02:01:10 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230510090108epoutp0302d7688a387a80e8ab1a0f310f69f3c1~dvKjBk19G2631026310epoutp039
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:01:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230510090108epoutp0302d7688a387a80e8ab1a0f310f69f3c1~dvKjBk19G2631026310epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683709268;
        bh=z1Pr/BMubVK5gm0MNy0PUzgA5DYmQXK+i/O5omA92XA=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=Ur//sbmPlheyjRb/jGdMMFtWBDOXIcVc9PpOnEkdyaKTVyBEWfqZ4rH04zONMmVFP
         OcRo7HxITKgZET3RKCTCchg5Mal6gNt9P1yznhDWslp9ei9kkOMuLk6Ruu1d5jwwKK
         +KuHAwuP6+xESzKLdIiMi9PTpmlJljdPgHQkXhzg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230510090107epcas2p39eda11ef0936574572a88fbb7d09ff2f~dvKiRERyR0699206992epcas2p38;
        Wed, 10 May 2023 09:01:07 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QGTXM2DDjz4x9Pr; Wed, 10 May
        2023 09:01:07 +0000 (GMT)
X-AuditID: b6c32a46-b23fd7000001438d-2c-645b5d5361cb
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.AB.17293.35D5B546; Wed, 10 May 2023 18:01:07 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 14/14] block: blk-integrity: remove
 blk_rq_count_integrity_sg()
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
Message-ID: <20230510090106epcms2p74a9f34d7f2202c8e5336615cc12b89a6@epcms2p7>
Date:   Wed, 10 May 2023 18:01:06 +0900
X-CMS-MailID: 20230510090106epcms2p74a9f34d7f2202c8e5336615cc12b89a6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmmW5wbHSKwdK1Ahar7/azWbw8pGmx
        cvVRJove/q1sFotubGOy+Nt1j8li0qFrjBZPr85isth7S9vi8q45bBbLj/9jslj3+j2Lxe8f
        c9gceD3O39vI4rF5hZbH5bOlHptWdbJ5TFh0gNFj980GNo/e5ndsHh+f3mLx6NuyitHj8yY5
        j/YD3UwB3FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+Abpu
        mTlA5ysplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwN
        DIxMgQoTsjPOLjrDWNAtVLFyYT9bA+NLvi5GTg4JAROJnY+XsnUxcnEICexglHjXOpuxi5GD
        g1dAUOLvDmGQGmGBEIkNfc+YQGwhASWJc2tmgZUICxhI3Oo1BwmzCehJ/FwyA2yMiMBOFonv
        948yQsznlZjR/pQFwpaW2L58K1gvp4CfROtjS4iwhsSPZb3MELaoxM3Vb9lh7PfH5kONEZFo
        vXcWqkZQ4sHP3VBxSYlDh76ygYyUEMiX2HAgECJcI/F2+QGoEn2Jax0bwS7gFfCV2L9wG5jN
        IqAqse/bX6iRLhJ/Hs8FizMLyEtsfzuHGWQks4CmxPpd+hDTlSWO3IKq4JPoOPyXHea/ho2/
        sbJ3zHvCBNGqJrGoyQgiLCPx9fB89gmMSrMQgTwLydpZCGsXMDKvYhRLLSjOTU8tNiowgsdr
        cn7uJkZwItZy28E45e0HvUOMTByMhxglOJiVRHi9Q6NShHhTEiurUovy44tKc1KLDzGaAj08
        kVlKNDkfmAvySuINTSwNTMzMDM2NTA3MlcR5pW1PJgsJpCeWpGanphakFsH0MXFwSjUwLbn9
        TMn0xfKSuiclt3PurdEomXYyo/zjhKtNqQ8/+885c/6zaPZnLTkjz47NKb7uN5uzbpRWzzzl
        YHo+2W2nEeO0Ka2G113+Vu6cfEvei+Xn38/n26T+LFOO27l1t8rmiN6FInF7588KqzVtk/t8
        R7vziVWMbcdS+zJRp68XuBZb3PGa03x1Yxn/UQf52exbNsXI+9U8vX7oYnyjoY9o2yvFWu9P
        G+zvT6nfHdRmpHmi9Z/oo8X2d9dVem3eOnkR/6ucG/X9AnO4nCQFVtW1hDa9DO4LFnz7699p
        q8qpis6aizc4rIiQXp962n33juJajdl3436Luv4yfLTXYWEck9H/DP+GaTPLctv4fRaaK7EU
        ZyQaajEXFScCAG/Gcr1NBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
