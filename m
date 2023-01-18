Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08F5671E49
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjARNn2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Jan 2023 08:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjARNmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:42:55 -0500
X-Greylist: delayed 242 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 05:12:28 PST
Received: from mail6.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DB2474FD;
        Wed, 18 Jan 2023 05:12:28 -0800 (PST)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id EC6572227A7;
        Wed, 18 Jan 2023 13:07:35 +0000 (UTC)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id DF3592227A3;
        Wed, 18 Jan 2023 13:07:35 +0000 (UTC)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx1.dmz.swissbit.com [10.181.10.103])
        by mail6.swissbit.com (Postfix) with ESMTPS;
        Wed, 18 Jan 2023 13:07:35 +0000 (UTC)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: RE: [PATCH 1/3] block: Requeue req as head if driver touched it
Thread-Topic: [PATCH 1/3] block: Requeue req as head if driver touched it
Thread-Index: AdjpDEQm2rub+3iRTPCN7zrgvOwESBCMHO2A
Date:   Wed, 18 Jan 2023 13:08:06 +0000
Message-ID: <4e2b1f4c81ca478cb7e5644f5ae892cb@hyperstone.com>
References: <22aa78389c9b4613841716c5b7bd89aa@hyperstone.com>
In-Reply-To: <22aa78389c9b4613841716c5b7bd89aa@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27392.007
X-TMASE-Result: 10--9.637700-10.000000
X-TMASE-MatchedRID: dwNgap4H9hjUL3YCMmnG4jo39wOA02LhlDt5PQMgj03kd9mvuqBe1m1d
        AMAJtyyxOuzeNmOGKnPgvgZ753XHBrnccJTUpEM4rMZ+BqQt2NqnHBIbyMjCFJm3OIVSf4P5oon
        zJ5ed8cDYgJy0r7VcQsLLQE2dzCJpL/tBTZzO5Q0D2WXLXdz+AUEe5VjFzwNbqIZZzG59lfQXnx
        dWTEAtaYdAx4ypyagHfyYDewMOrQBccB/zVZ7coklXctromFFi+gtHj7OwNO38o7Ys1NK4Y7R7t
        YRRx1roS/k5gHS6NuVwOxODheruVjSFiyUesjTO
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 6ddb0a30-efa8-4746-a997-ae18fdbdbf9b-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens could you consider this patch?
As far as I can see Barts series has not been merged in any form that would fix my problem and even if it does, requeuing RQF_DONTPREP as head seems on par at worst and a performance improvement at best.


-----Original Message-----
From: Christian Löhle 
Sent: Mittwoch, 26. Oktober 2022 09:29
To: axboe@kernel.dk; ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; 'linux-block@vger.kernel.org' <linux-block@vger.kernel.org>
Cc: 'Avri Altman' <Avri.Altman@wdc.com>; adrian.hunter@intel.com; vincent.whitchurch@axis.com; 'Christian Löhle' <CLoehle@hyperstone.com>
Subject: [PATCH 1/3] block: Requeue req as head if driver touched it

In case the driver set RQF_DONTPREP flag, requeue the request as head as it is likely that the backing storage already had a request to an adjacent region, so getting the requeued request out as soon as possible may give us some performance benefit.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c index 33292c01875d..d863c826fb23 100644
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

