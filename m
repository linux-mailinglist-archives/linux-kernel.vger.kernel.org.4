Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10A26FDA07
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbjEJIxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbjEJIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:52:42 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4C15249
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:52:18 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230510085210epoutp01a7bd9e70fe8cc0f7da799eb6ac71aef7~dvCuG1ry51396213962epoutp01p
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:52:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230510085210epoutp01a7bd9e70fe8cc0f7da799eb6ac71aef7~dvCuG1ry51396213962epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683708730;
        bh=g79vP8DDxL631oXd9xY9r2nKOWI/ZL7l+cinRRVML/o=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=igJTqMmMYgBixf1/e8+PAgF87edmcv2CPfNsrFD1sGpzaotmR9fF2OXmRQ9fDyFXq
         94FEPzH6grfjG94kwxpbWyxN5TzqRX+CpzfgAsSBNDiFdimJYpcMazoZM1LfMsqjHf
         EMRci5gZ7X+52vAY2RqbadMgCCQ6D1N/Ch1JiwJE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230510085210epcas2p2f37d467174700937f1d7d24aafd8c897~dvCtcMs_T0839608396epcas2p29;
        Wed, 10 May 2023 08:52:10 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QGTL1448mz4x9Q2; Wed, 10 May
        2023 08:52:09 +0000 (GMT)
X-AuditID: b6c32a47-e99fd70000002007-31-645b5b396bbe
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.86.08199.93B5B546; Wed, 10 May 2023 17:52:09 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 05/14] block: blk-merge: fix to add the number of
 integrity segments to the request twice
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
Message-ID: <20230510085208epcms2p52a6dec8da80152ec2101f11ce2ea5321@epcms2p5>
Date:   Wed, 10 May 2023 17:52:08 +0900
X-CMS-MailID: 20230510085208epcms2p52a6dec8da80152ec2101f11ce2ea5321
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmha5ldHSKwZep8har7/azWbw8pGmx
        cvVRJove/q1sFotubGOy+Nt1j8li0qFrjBZPr85isth7S9vi8q45bBbLj/9jslj3+j2Lxe8f
        c9gceD3O39vI4rF5hZbH5bOlHptWdbJ5TFh0gNFj980GNo/e5ndsHh+f3mLx6NuyitHj8yY5
        j/YD3UwB3FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+Abpu
        mTlA5ysplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwN
        DIxMgQoTsjO2TN7JWDBdvWLC5S72BsYf8l2MnBwSAiYSy6YeZe1i5OIQEtjBKPH+1jPmLkYO
        Dl4BQYm/O4RBaoQF8iQmP5zKBGILCShJnFszixGkRFjAQOJWrzlImE1AT+LnkhlsIGNEBHay
        SHy/f5QRYj6vxIz2pywQtrTE9uVbwXo5BfwkWh9bQoQ1JH4s62WGsEUlbq5+yw5jvz82H2qM
        iETrvbNQNYISD37uhopLShw69JUNZKSEQL7EhgOBEOEaibfLD0CV6Etc69gIdgGvgK/E452/
        wD5hEVCVmLDiCRtEjYvEl/sPwMYzC8hLbH87BxwIzAKaEut36UNMV5Y4cosFooJPouPwX3aY
        /xo2/sbK3jHvCRNEq5rEoiYjiLCMxNfD89knMCrNQgTyLCRrZyGsXcDIvIpRLLWgODc9tdio
        wBger8n5uZsYwYlYy30H44y3H/QOMTJxMB5ilOBgVhLh9Q6NShHiTUmsrEotyo8vKs1JLT7E
        aAr08ERmKdHkfGAuyCuJNzSxNDAxMzM0NzI1MFcS55W2PZksJJCeWJKanZpakFoE08fEwSnV
        wLR+TW1occmm0BVCGW1tlz9tyjwjH1CQGRnQeXCF1+ov4U2r8mJklGsTvpqvPxIecmNxqumi
        OtdjD8QCVJRld7fV1JzfrtAXXjrlTMwnQ89nv/1q307mPMqqULC4I2WPyJ2wQq6wCxMEllgs
        1coP8vz4YSWD5Y4/Sl0W+Vtjfu5O2uRfwnWNmZOF+VnGitD1b+5dXqV5/xLv8ZffH2evquia
        UDRTWzU3zLi3TXRiR1Oy7G7ZzHO6e7QijDsE9i35utch9lluftzkHXw5j+bP28k4U6zG/ub+
        vHaX5K6jfIF72JUiNy6+aiSyYuGs2s8veZrt3u+alvrsDXPwknkhjzbH1Wm0bDTUZsw4cqm0
        UYmlOCPRUIu5qDgRALPluVdNBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p5>
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

blk_integrity_merge_bio() not only performs conditional tests, but also
updates the integrity segment information of request.
It can be called twice when merging the bio into an existing request.

bio_attempt_bio_merge() or blk_mq_sched_try_merge()
  blk_rq_merge_ok()
    blk_integrity_merge_bio()  -  1
  bio_attemp_{back|front}_merge()
    ll_{back|front}_merge_fn()
      ll_new_hw_segments()
        blk_integrity_merge_bio()  -  2

The part of checking the conditions and the code to update the
information of the actual request were separated. At this time, the
ll_back_merge_fn was called by passth-path, so the condition check was
called by all the separated functions.

And after success in blk_integrity_merge_bio(), the information of the
request may be wrong if it is impossible to merge due to other
conditional tests. Thus, it was changed to be called immediately before
merging the bio's segments.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Fixes: 4eaf99beadce ("block: Don't merge requests if integrity flags differ")
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/blk-integrity.c | 34 +++++++++++++++++++++++++++++-----
 block/blk-merge.c     |  9 +++++----
 block/blk.h           |  7 +++++++
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index d4e9b4556d14..03a85e1f6d2e 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -184,19 +184,43 @@ bool blk_integrity_merge_rq(struct request_queue *q, struct request *req,
 	return true;
 }
 
+static inline bool blk_integrity_bypass_check(struct request *req,
+					      struct bio *bio)
+{
+	return blk_integrity_rq(req) == 0 && bio_integrity(bio) == NULL;
+}
+
+static bool __blk_integrity_mergeable(struct request_queue *q,
+				      struct request *req, struct bio *bio)
+{
+	if (blk_integrity_rq(req) == 0 || bio_integrity(bio) == NULL)
+		return false;
+
+	if (bio_integrity(req->bio)->bip_flags != bio_integrity(bio)->bip_flags)
+		return false;
+
+	return true;
+}
+
+bool blk_integrity_mergeable(struct request_queue *q, struct request *req,
+			     struct bio *bio)
+{
+	if (blk_integrity_bypass_check(req, bio))
+		return true;
+
+	return __blk_integrity_mergeable(q, req, bio);
+}
+
 bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 			     struct bio *bio)
 {
 	int nr_integrity_segs;
 	struct bio *next = bio->bi_next;
 
-	if (blk_integrity_rq(req) == 0 && bio_integrity(bio) == NULL)
+	if (blk_integrity_bypass_check(req, bio))
 		return true;
 
-	if (blk_integrity_rq(req) == 0 || bio_integrity(bio) == NULL)
-		return false;
-
-	if (bio_integrity(req->bio)->bip_flags != bio_integrity(bio)->bip_flags)
+	if (!__blk_integrity_mergeable(q, req, bio))
 		return false;
 
 	bio->bi_next = NULL;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 65e75efa9bd3..8509f468d6d4 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -611,9 +611,6 @@ static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
 	if (!blk_cgroup_mergeable(req, bio))
 		goto no_merge;
 
-	if (blk_integrity_merge_bio(req->q, req, bio) == false)
-		goto no_merge;
-
 	/* discard request merge won't add new segment */
 	if (req_op(req) == REQ_OP_DISCARD)
 		return 1;
@@ -621,6 +618,10 @@ static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
 	if (req->nr_phys_segments + nr_phys_segs > blk_rq_get_max_segments(req))
 		goto no_merge;
 
+	/* This will merge integrity segments */
+	if (!blk_integrity_merge_bio(req->q, req, bio))
+		goto no_merge;
+
 	/*
 	 * This will form the start of a new hw segment.  Bump both
 	 * counters.
@@ -934,7 +935,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 		return false;
 
 	/* only merge integrity protected bio into ditto rq */
-	if (blk_integrity_merge_bio(rq->q, rq, bio) == false)
+	if (!blk_integrity_mergeable(rq->q, rq, bio))
 		return false;
 
 	/* Only merge if the crypt contexts are compatible */
diff --git a/block/blk.h b/block/blk.h
index dd7cbb57ce43..b7677a5bdff1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -202,6 +202,8 @@ static inline bool bio_integrity_endio(struct bio *bio)
 
 bool blk_integrity_merge_rq(struct request_queue *, struct request *,
 		struct request *);
+bool blk_integrity_mergeable(struct request_queue *rq, struct request *r,
+		struct bio *b);
 bool blk_integrity_merge_bio(struct request_queue *, struct request *,
 		struct bio *);
 
@@ -234,6 +236,11 @@ static inline bool blk_integrity_merge_rq(struct request_queue *rq,
 {
 	return true;
 }
+static inline bool blk_integrity_mergeable(struct request_queue *rq,
+		struct request *r, struct bio *b)
+{
+	return true;
+}
 static inline bool blk_integrity_merge_bio(struct request_queue *rq,
 		struct request *r, struct bio *b)
 {
-- 
2.34.1
