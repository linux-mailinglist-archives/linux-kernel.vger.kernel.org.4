Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2980160DC1B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiJZHa7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Oct 2022 03:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiJZHax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:30:53 -0400
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0366EF07;
        Wed, 26 Oct 2022 00:30:42 -0700 (PDT)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id A2AFD122BF0;
        Wed, 26 Oct 2022 09:30:40 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 91580122BE9;
        Wed, 26 Oct 2022 09:30:40 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Wed, 26 Oct 2022 09:30:40 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 26 Oct
 2022 09:30:40 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Wed, 26 Oct 2022 09:30:40 +0200
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
Subject: [PATCH 1/3] block: Requeue req as head if driver touched it
Thread-Topic: [PATCH 1/3] block: Requeue req as head if driver touched it
Thread-Index: AdjpDEQm2rub+3iRTPCN7zrgvOwESA==
Date:   Wed, 26 Oct 2022 07:30:39 +0000
Message-ID: <22aa78389c9b4613841716c5b7bd89aa@hyperstone.com>
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
X-TMASE-Result: 10-1.026300-10.000000
X-TMASE-MatchedRID: mIinBA9F1pwet1TxvngNg/ZNLVgVojn/9v33UW8WNYDIgofMgahPrb8F
        Hrw7frluf146W0iUu2s1Wh0fHDSsUWm8qwfvyPv4Y6Gjtu6/t30yCs+pWvwBI5soi2XrUn/JExk
        bqSDWgw8UGm4zriL0oQtuKBGekqUpI/NGWt0UYPDdxPQXTiv8E731jVRFyIDgbQoGqwZjwmkJeO
        MxPAANXY4TDtwwKftL
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: e041678b-49f7-43a8-9ecd-1c6d54a9d864-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the driver set RQF_DONTPREP flag, requeue the request as head as
it is likely that the backing storage already had a request to an
adjacent region, so getting the requeued request out as soon as possible
may give us some performance benefit.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 33292c01875d..d863c826fb23 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1429,7 +1429,7 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		 * merge.
 		 */
 		if (rq->rq_flags & RQF_DONTPREP)
-			blk_mq_request_bypass_insert(rq, false, false);
+			blk_mq_request_bypass_insert(rq, true, false);
 		else
 			blk_mq_sched_insert_request(rq, true, false, false);
 	}
-- 
2.37.3
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

