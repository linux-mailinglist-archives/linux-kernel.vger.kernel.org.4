Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9542C6F55B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjECKN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjECKNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:13:55 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E7446AB
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:13:53 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230503101352epoutp031b5c8741aad3a357ea56a5cc9f2f6cf6~bmpC3bK3p2141521415epoutp036
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:13:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230503101352epoutp031b5c8741aad3a357ea56a5cc9f2f6cf6~bmpC3bK3p2141521415epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683108832;
        bh=5spsBQ/UOnjOahi0JzD6hmV/5aBQ7IGxHCQ9KefOjyE=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=T5sgQtkLpfPBVjNcR07b57q0MOgTYpZ55yuIkkUazLw+zQJm1hqvV36LeGkBgicdp
         335d2dUOkbZ/WLFrFD1LI9FLzS8ULUjO0rm77wikVguHawEPzUYBWa40ucY8RDhb3h
         Dobr//mzyxWoLgZ0GwZG4qMF4Kgf/zisKe6++AI8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230503101351epcas2p40434afb19b942994ca0612bb822eeeeb~bmpCOdERn3032830328epcas2p4s;
        Wed,  3 May 2023 10:13:51 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QBCTV6GwDz4x9Pw; Wed,  3 May
        2023 10:13:50 +0000 (GMT)
X-AuditID: b6c32a47-c29ff70000002007-98-645233dec14f
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.4F.08199.ED332546; Wed,  3 May 2023 19:13:50 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 07/15] block: blk-merge: fix merging two requests in
 ll_merge_requests_fn
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
Message-ID: <20230503101350epcms2p63c31a0642156d56853acdcd4754abb50@epcms2p6>
Date:   Wed, 03 May 2023 19:13:50 +0900
X-CMS-MailID: 20230503101350epcms2p63c31a0642156d56853acdcd4754abb50
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmme4946AUg62X9C1W3+1ns3h5SNNi
        5eqjTBa9/VvZLPbe0ra4vGsOm8Xy4/+YHNg9Lp8t9dh9s4HN4+PTWywefVtWMXp83iQXwBqV
        bZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdIOSQlli
        TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj
        X+8cxoJNvBUb2/rYGxgncncxcnJICJhIvNyzkLWLkYtDSGAHo8S1ZXOAHA4OXgFBib87hEFM
        YYFoiXtb00HKhQSUJM6tmcUIETaQuNVrDhJmE9CT+LlkBhuILSKwmkmi+XkNxHReiRntT1kg
        bGmJ7cu3MoLYnAJ+Eo833GKEiGtI/FjWywxhi0rcXP2WHcZ+f2w+VI2IROu9s1A1ghIPfu6G
        iktKHDr0lQ3kHAmBfIkNBwIhwjUSb5cfgCrRl7jWsRHsBF4BX4kVL1aAjWcRUJVo+DgZ6jQX
        idPXFoGNZxaQl9j+dg4zyEhmAU2J9bv0IaYrSxy5xQJRwSfRcfgvO8yDDRt/Y2XvmPeECaJV
        TWJRkxFEWEbi6+H57BMYlWYhwngWkrWzENYuYGRexSiWWlCcm55abFRgDI/W5PzcTYzghKjl
        voNxxtsPeocYmTgYDzFKcDArifB+KPRLEeJNSaysSi3Kjy8qzUktPsRoCvTwRGYp0eR8YErO
        K4k3NLE0MDEzMzQ3MjUwVxLnlbY9mSwkkJ5YkpqdmlqQWgTTx8TBKdXA1L5mLzfj+qCkRM8Z
        +25lT9zvv7fAKvzd05q1625/87n/4XXroXOHX+6sO51n6yxbZhNbU/zwxS5BhSfaInG7nnXb
        Tuxd3vt9efm0Xqu2A/OF/S1t7nKvDOf7lXVz5b2F2/omFnaFrt/CtkxjenFT8q27Vnbnds+1
        P8QQWs46NVmfcY93TclhpVm3lJ9HT1mibPfl7Inwh3uzIwPD24OK9rKv2xe4Z+Xiz/9nztiy
        94KL8jv9GK7w9KCPMp5XSw7dj1/jI/88vXZXTNLrrNntKscXXb6sZW+dYulSzCjs7in1p+zI
        0QPprmUh3tNCWjU4Fj284Hkzcf+sUJGgZMN/nvciLi9uji+doX2xZH/QMiWW4oxEQy3mouJE
        AMEW8/cRBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p6>
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

blk_integrity_merge_rq() merges integrity segment information of two
requests. However, it is only a condition check and does not perform the
actual integrity information update. So this was modified.

After it is called, the merge process of the requests may fail
due to other conditions. At this time, there is an error in the integrity
segment information of request. So the call location was also changed.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

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
