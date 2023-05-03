Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2D6F55F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjECKVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjECKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:21:48 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F36AE43
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:21:47 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230503102145epoutp026c754d4c39cf36e2b10f4fa18193150a~bmv8GnkyF2929529295epoutp02f
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:21:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230503102145epoutp026c754d4c39cf36e2b10f4fa18193150a~bmv8GnkyF2929529295epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683109305;
        bh=ZfhC85BvKxKIuur1CoeZsaWeIlAnBRlkMNE/o0TIGEU=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=jyNXa3IL3Wf63GZMeW5DyDIFhXPN7xFgXXLQCFE7ziOOvvmXjUK0EeWobmCywJ+Pd
         C4UHvEhtFAgX5XWt4dzB7Ls22Z9RkSUyw04KdEKCHVpRyGLyGsJ4P5b2G4HD6+i4a8
         emHRb2n4pvR1aFR/66ZpzfOEbYi2B1CN5B8MDsC4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230503102145epcas2p3ebef196678b9f539e5eef8d92b0100c6~bmv7h2NWR1582715827epcas2p3Z;
        Wed,  3 May 2023 10:21:45 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QBCfc525gz4x9Pw; Wed,  3 May
        2023 10:21:44 +0000 (GMT)
X-AuditID: b6c32a45-6d1fd70000020cc1-fb-645235b806a6
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.70.03265.8B532546; Wed,  3 May 2023 19:21:44 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 11/15] block: blk-integrity: change how to find the number
 of integrity of bio
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
Message-ID: <20230503102144epcms2p5ba957092cb811a6ed6cce92debe6e10c@epcms2p5>
Date:   Wed, 03 May 2023 19:21:44 +0900
X-CMS-MailID: 20230503102144epcms2p5ba957092cb811a6ed6cce92debe6e10c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmme4O06AUg9aVqhar7/azWbw8pGmx
        cvVRJove/q1sFntvaVtc3jWHzWL58X9MDuwel8+Weuy+2cDm8fHpLRaPvi2rGD0+b5ILYI3K
        tslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBukFJoSwx
        pxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ1x
        dc511oINnBWdq28xNzA+Y+9i5OSQEDCR+DNzClMXIxeHkMAORokjp3oYuxg5OHgFBCX+7hAG
        qREWSJB43fKIFcQWElCSOLdmFliJsICBxK1ec5Awm4CexM8lM9hAbBGB1UwSzc9rIMbzSsxo
        f8oCYUtLbF++lRHE5hTwk3i84RYjRFxD4seyXmYIW1Ti5uq37DD2+2PzoWpEJFrvnYWqEZR4
        8HM3VFxS4tChr2wg50gI5EtsOBAIEa6ReLv8AFSJvsS1jo1gJ/AK+ErMaVoNNp5FQFWi5/lS
        VogaF4nJM1vBbGYBeYntb+cwg4xkFtCUWL9LH2K6ssSRWywQFXwSHYf/ssM82LDxN1b2jnlP
        mCBa1SQWNRlBhGUkvh6ezz6BUWkWIpBnIVk7C2HtAkbmVYxiqQXFuempxUYFhvB4Tc7P3cQI
        TolarjsYJ7/9oHeIkYmD8RCjBAezkgjvh0K/FCHelMTKqtSi/Pii0pzU4kOMpkAPT2SWEk3O
        ByblvJJ4QxNLAxMzM0NzI1MDcyVxXmnbk8lCAumJJanZqakFqUUwfUwcnFINTB5sOidzuEU/
        7mE7UurH28RrvXwz92TxttpkC+9/rq+1RP2u5/4K/i9g31y+l/t479v357K65DZOltDMvW53
        b02PHotc/zWHrgW9DGd1uZo4Lyo1H2tbv++uz3nP7Ss+9PN6bO//p/Hni17SwiPNVaJe1hwX
        3Ru1ysqKJrt9lV63nGfCJpYVotEHZjY6xc09zb1g8c8dVku2aq/f9Hdvd/YNx97qE9rXO4q8
        P0h873Hi9Cr8vLROK7e42mGLbEXTFkZT/TVmmV6eXnOq5y5nargXy3t3SmTTjdNXzR6dTSn/
        9mjJjIU3FCafsl7T4PxyDtfmvIMXC5xWab1733524/Od/6eo6PjtcCmZ2fcgVYmlOCPRUIu5
        qDgRAJUtFKESBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p5>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method of constructing a bip has been changed, the number of
segments can be obtained through bip_vcnt.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/blk-integrity.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index f97b7e8a6d4d..64407b412947 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -217,7 +217,6 @@ bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 			     struct bio *bio)
 {
 	int nr_integrity_segs;
-	struct bio *next = bio->bi_next;
 
 	if (blk_integrity_bypass_check(req, bio))
 		return true;
@@ -225,9 +224,7 @@ bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 	if (!__blk_integrity_mergeable(q, req, bio))
 		return false;
 
-	bio->bi_next = NULL;
-	nr_integrity_segs = blk_rq_count_integrity_sg(q, bio);
-	bio->bi_next = next;
+	nr_integrity_segs = bio_integrity(bio)->bip_vcnt;
 
 	if (req->nr_integrity_segments + nr_integrity_segs >
 	    q->limits.max_integrity_segments)
-- 
2.34.1
