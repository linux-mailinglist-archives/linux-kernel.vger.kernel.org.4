Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5676FDA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbjEJIxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbjEJIxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:53:30 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0002783FF
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:53:10 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230510085309epoutp01ac7be1161f53ad4a179b7165bf69b673~dvDkpaouM1575315753epoutp01D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:53:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230510085309epoutp01ac7be1161f53ad4a179b7165bf69b673~dvDkpaouM1575315753epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683708789;
        bh=hAgsUYvwnAwGZ8MCXuf3w6+KGzCXW9Ae7hJz02geX9Y=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=jR+Xf2AEHZd8CzlaLwDcpQnCsA1+wjmvoIIaxRCHWrl9ELYKhHhXPdt/jUBrj/VVA
         /EMTwvMd6nGYlBf6IpsH036kDENRTDz/Tvg9aYhgMgKYmb/3FFkLEIsrOWkI46t1Cs
         7raEp9pSxJVoH2uY8neNDeEi1Yium1YtfN5I64lk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230510085308epcas2p19f03621cc47872e5931aeeeb9463f545~dvDj-t8151264312643epcas2p1U;
        Wed, 10 May 2023 08:53:08 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.101]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QGTM80VzXz4x9Q0; Wed, 10 May
        2023 08:53:08 +0000 (GMT)
X-AuditID: b6c32a45-6d1fd70000020cc1-4e-645b5b7392d8
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.6A.03265.37B5B546; Wed, 10 May 2023 17:53:08 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 06/14] block: blk-merge: fix merging two requests in
 ll_merge_requests_fn
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
Message-ID: <20230510085307epcms2p2118fe232ab7e7707c0fc70d5ede6aa58@epcms2p2>
Date:   Wed, 10 May 2023 17:53:07 +0900
X-CMS-MailID: 20230510085307epcms2p2118fe232ab7e7707c0fc70d5ede6aa58
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmhW5JdHSKwZbfjBar7/azWbw8pGmx
        cvVRJove/q1sFotubGOy+Nt1j8li0qFrjBZPr85isth7S9vi8q45bBbLj/9jslj3+j2Lxe8f
        c9gceD3O39vI4rF5hZbH5bOlHptWdbJ5TFh0gNFj980GNo/e5ndsHh+f3mLx6NuyitHj8yY5
        j/YD3UwB3FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+Abpu
        mTlA5ysplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwN
        DIxMgQoTsjMO9R5iLOjmq+i+c5atgfEudxcjJ4eEgInE+sVX2EFsIYEdjBJTP0t2MXJw8AoI
        SvzdIQwSFhaIk7j0eiVUiZLEuTWzGEFKhAUMJG71moOE2QT0JH4umcHWxcjFISKwk0Xi+/2j
        jBDjeSVmtD9lgbClJbYv3wrWyyngJ9H62BIirCHxY1kvM4QtKnFz9Vt2GPv9sflQY0QkWu+d
        haoRlHjwczdUXFLi0KGvbCAjJQTyJTYcCIQI10i8XX4AqkRf4lrHRrALeAV8Jd59aAIbzyKg
        KtF9bR3USBeJ9SeOgdUwC8hLbH87hxlkJLOApsT6XfoQ05UljtyCquCT6Dj8lx3mv4aNv7Gy
        d8x7wgTRqiaxqMkIIiwj8fXwfPYJjEqzEIE8C8naWQhrFzAyr2IUSy0ozk1PLTYqMIRHa3J+
        7iZGcBrWct3BOPntB71DjEwcjIcYJTiYlUR4vUOjUoR4UxIrq1KL8uOLSnNSiw8xmgI9PJFZ
        SjQ5H5gJ8kriDU0sDUzMzAzNjUwNzJXEeaVtTyYLCaQnlqRmp6YWpBbB9DFxcEo1MPXzPRD3
        dZHdpGGVvj+sKH1h6ddPFdKrTefYmd91F9Kxi5n6mS9PyrW0fv1Vv6eHPl9hU2fijdqyTsBs
        z3xLl2/cgboSt0zCNx64Xy/ccqjkH/fjn2tfNfWY+S7juKSyboNT/WztnE3bt17qXWiw4pGJ
        gvIfz8ePpwqx3P0SvY1nYaP7xczp2W/1Pp1OWMr7ycyT5ayp3us19y7M/fn91JN36cq+8/S1
        j7xP4Xr786PJtua1wmdbPrin/zp81W3Jhcz9q1/vzFb2lLn6Wsruk0S++XPvHpV1K8XvL+34
        svHP2dXm7ZY/W9/0M5/lPaDD9ltoaylzUYRrW8o0M96774rny6/iMvi/qF1oydv4bzVKLMUZ
        iYZazEXFiQAFrTqKTAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p2>
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

blk_integrity_merge_rq() merges integrity segment information of two
requests. However, it is only a condition check and does not perform the
actual integrity information update. So this was modified.

After it is called, the merge process of the requests may fail
due to other conditions. At this time, there is an error in the integrity
segment information of request. So the call location was also changed.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Fixes: 13f05c8d8e98 ("block/scsi: Provide a limit on the number of integrity segments")
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/blk-integrity.c | 2 ++
 block/blk-merge.c     | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 03a85e1f6d2e..f97b7e8a6d4d 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -181,6 +181,8 @@ bool blk_integrity_merge_rq(struct request_queue *q, struct request *req,
 	if (integrity_req_gap_back_merge(req, next->bio))
 		return false;
 
+	req->nr_integrity_segments += next->nr_integrity_segments;
+
 	return true;
 }
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8509f468d6d4..c6a0958e8df1 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -711,10 +711,11 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	if (!blk_cgroup_mergeable(req, next->bio))
 		return 0;
 
-	if (blk_integrity_merge_rq(q, req, next) == false)
+	if (!bio_crypt_ctx_merge_rq(req, next))
 		return 0;
 
-	if (!bio_crypt_ctx_merge_rq(req, next))
+	/* this will merge integrity segments */
+	if (!blk_integrity_merge_rq(q, req, next))
 		return 0;
 
 	/* Merge is OK... */
-- 
2.34.1
