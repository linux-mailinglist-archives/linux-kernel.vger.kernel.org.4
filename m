Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD660DC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiJZHbD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Oct 2022 03:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiJZHay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:30:54 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769D779682;
        Wed, 26 Oct 2022 00:30:47 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id AA6F83A1CC8;
        Wed, 26 Oct 2022 09:30:45 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 9BD3D3A19AE;
        Wed, 26 Oct 2022 09:30:45 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (sbdeex04.sbitdom.lan [10.149.2.42])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Wed, 26 Oct 2022 09:30:45 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 26 Oct
 2022 09:30:45 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Wed, 26 Oct 2022 09:30:45 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
Subject: [PATCH 3/3] mmc: block: Requeue on block size restrictions
Thread-Topic: [PATCH 3/3] mmc: block: Requeue on block size restrictions
Thread-Index: AdjpDHb57shE0br7QqOZ9olY8otAMg==
Date:   Wed, 26 Oct 2022 07:30:44 +0000
Message-ID: <f3b05a9103ba4c46ae78a96f8cdc700d@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.46]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27224.006
X-TMASE-Result: 10--5.321200-10.000000
X-TMASE-MatchedRID: 9886Ub8IUanFkQpHLCk4oQXtykVcrvpNqf/efKFN1nDVjNsehGf0vVkI
        Tz82Kc4AioDiaHUgJaTMdqKz1jxx8S/7QU2czuUNA9lly13c/gFHyz3bB5kG52fIvzHS0qU76bn
        ve26xmNDsq6KOq5NL8H8mA3sDDq0AtVC7UY1n6yI7AFczfjr/7GCs+UIIAXsCzZ/ZSwfkDNqvOj
        krw6MD5tw3n/ubs2J3W7oWrwszBSc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: eac11117-5080-402d-a60f-b2191784507e-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The block layer does not conform to all our sector count restrictions, so
requeue in case we had to modify the number of blocks sent instead of
going through the normal completion.

Note that the normal completion used before does not lead to a bug,
this change is just the nicer thing to do.
An example of such a restriction is max_blk_count = 1 and 512 blksz,
but the block layer continues to use requests of size PAGE_SIZE.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 54cd009aee50..c434d3964880 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1519,8 +1519,10 @@ static void mmc_blk_cqe_req_done(struct mmc_request *mrq)
 	/*
 	 * Block layer timeouts race with completions which means the normal
 	 * completion path cannot be used during recovery.
+	 * Also do not use it if we had to modify the block count to satisfy
+	 * host controller needs.
 	 */
-	if (mq->in_recovery)
+	if (mq->in_recovery || mrq->data->blocks != blk_rq_sectors(req))
 		mmc_blk_cqe_complete_rq(mq, req);
 	else if (likely(!blk_should_fake_timeout(req->q)))
 		blk_mq_complete_request(req);
@@ -2051,8 +2053,10 @@ static void mmc_blk_hsq_req_done(struct mmc_request *mrq)
 	/*
 	 * Block layer timeouts race with completions which means the normal
 	 * completion path cannot be used during recovery.
+	 * Also do not use it if we had to modify the block count to satisfy
+	 * host controller needs.
 	 */
-	if (mq->in_recovery)
+	if (mq->in_recovery || mrq->data->blocks != blk_rq_sectors(req))
 		mmc_blk_cqe_complete_rq(mq, req);
 	else if (likely(!blk_should_fake_timeout(req->q)))
 		blk_mq_complete_request(req);
@@ -2115,8 +2119,10 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
 	/*
 	 * Block layer timeouts race with completions which means the normal
 	 * completion path cannot be used during recovery.
+	 * Also do not use it if we had to modify the block count to satisfy
+	 * host controller needs.
 	 */
-	if (mq->in_recovery) {
+	if (mq->in_recovery || mrq->data->blocks != blk_rq_sectors(req)) {
 		mmc_blk_mq_complete_rq(mq, req);
 	} else if (likely(!blk_should_fake_timeout(req->q))) {
 		if (can_sleep)
-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

