Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3106F55A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjECKMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjECKMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:12:14 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F020F3C01
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:12:12 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230503101210epoutp04c1d2dbefd7b530e0f7b29f0f044b8a39~bmnkrR4-B1848018480epoutp04j
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:12:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230503101210epoutp04c1d2dbefd7b530e0f7b29f0f044b8a39~bmnkrR4-B1848018480epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683108731;
        bh=zvETEJpKps7CgoP+0aNXfFiUkdNh7m7B7nh+qhAE130=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=EdUw5aMyi7rcmSIDmFkf8q0TJeS5f/+H3M5nKe1TQrTVqyjt/pDnPxG6VBQwP0dqe
         o+ym4JrdgBuq7uSvj1lhyrEsQKUyLQbl0WdbKlQeGnOaW/UpZcEEA83oSwV/PL0C0Y
         G++C3r36qCXbWsMHHsK8bEFBLCEYzJZr82wBs1FM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230503101210epcas2p348dac10e0ac642bdfafcb7aeac0625e5~bmnj-qOF71815318153epcas2p3S;
        Wed,  3 May 2023 10:12:10 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.89]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QBCRY4phbz4x9Pr; Wed,  3 May
        2023 10:12:09 +0000 (GMT)
X-AuditID: b6c32a46-8b7ff7000001438d-04-64523379883f
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.74.17293.97332546; Wed,  3 May 2023 19:12:09 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 06/15] block: blk-merge: fix to add the number of integrity
 segments to the request twice
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
Message-ID: <20230503101208epcms2p217be9d66b1e07c4e2ce3741e659e158f@epcms2p2>
Date:   Wed, 03 May 2023 19:12:08 +0900
X-CMS-MailID: 20230503101208epcms2p217be9d66b1e07c4e2ce3741e659e158f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmqW6lcVCKQdtNRYvVd/vZLF4e0rRY
        ufook0Vv/1Y2i723tC0u75rDZrH8+D8mB3aPy2dLPXbfbGDz+Pj0FotH35ZVjB6fN8kFsEZl
        22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA3aCkUJaY
        UwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM54
        sH0Ga8EJtYqP02ayNjBuke9i5OSQEDCRuPqol7GLkYtDSGAHo8TqJd0sXYwcHLwCghJ/dwiD
        1AgLZEv87tjMDGILCShJnFszixGkRFjAQOJWrzlImE1AT+LnkhlsILaIwGomiebnNRDjeSVm
        tD9lgbClJbYv38oIYnMK+Ek83nCLESKuIfFjWS8zhC0qcXP1W3YY+/2x+VA1IhKt985C1QhK
        PPi5GyouKXHo0Fc2kHMkBPIlNhwIhAjXSLxdfgCqRF/iWsdGqKd8JR69jQQJswioSux9vYwV
        osRFov1HE5jNLCAvsf3tHGaQcmYBTYn1u/QhhitLHLnFAlHBJ9Fx+C87zH8NG39jZe+Y94QJ
        olVNYlGTEURYRuLr4fnsExiVZiHCeBaStbMQ1i5gZF7FKJZaUJybnlpsVGAEj9bk/NxNjOCE
        qOW2g3HK2w96hxiZOBgPMUpwMCuJ8H4o9EsR4k1JrKxKLcqPLyrNSS0+xGgK9PBEZinR5Hxg
        Ss4riTc0sTQwMTMzNDcyNTBXEueVtj2ZLCSQnliSmp2aWpBaBNPHxMEp1cCk5bYpeOEal4Tl
        R74UfOi7KRvwQFExZlPrrBgv/tur/6ycGFsVvGJ1o2Sa+9//U+f5emc8v3zWXOftzJVP0trv
        MF0qyz3/bkVTjMp555JbxwTWvlulK6pxq+OlwJSbIjWBt29p2pQcmM8+a8eVxxLiU6cWpsUo
        9aycpbxP5bUw13r1968+vr7+benClU/1/Gef6Jl/4aLWhos5ImWNR1WffnR9uTumKUWy2SJi
        ZuQLxT9P/l2OUrlWVXgxyrIgNODDrciK3TnMk9NXPeb5sehFkvCTkzltFgpX4t9rv7f6IfWO
        N2nDywOzGczElXd7H8s4+KTHdabqhMz5Aor3O+ZwSelZmpf/ilFe+jRCc23yDSWW4oxEQy3m
        ouJEAF4Mg6YRBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p2>
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
index 45547bcf1119..5923d2190d91 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -189,6 +189,8 @@ static inline bool bio_integrity_endio(struct bio *bio)
 
 bool blk_integrity_merge_rq(struct request_queue *, struct request *,
 		struct request *);
+bool blk_integrity_mergeable(struct request_queue *rq, struct request *r,
+		struct bio *b);
 bool blk_integrity_merge_bio(struct request_queue *, struct request *,
 		struct bio *);
 
@@ -221,6 +223,11 @@ static inline bool blk_integrity_merge_rq(struct request_queue *rq,
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
