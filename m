Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562F15F7AC5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJGPn5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Oct 2022 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJGPnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:43:55 -0400
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901DAD73D2;
        Fri,  7 Oct 2022 08:43:54 -0700 (PDT)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id D48DF12328B;
        Fri,  7 Oct 2022 17:43:52 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C5BCA122E4A;
        Fri,  7 Oct 2022 17:43:52 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Fri,  7 Oct 2022 17:43:52 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 7 Oct 2022
 17:43:52 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Fri, 7 Oct 2022 17:43:52 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCHv2 2/2] mmc: queue: Cancel recovery work on cleanup
Thread-Topic: [PATCHv2 2/2] mmc: queue: Cancel recovery work on cleanup
Thread-Index: AdjaY4mpUK63rShYSiuVsWPm2cpIvA==
Date:   Fri, 7 Oct 2022 15:43:52 +0000
Message-ID: <c865c0c9789d428494b67b820a78923e@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.22]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27188.000
X-TMASE-Result: 10--3.999400-10.000000
X-TMASE-MatchedRID: mIinBA9F1pwt1HmDlgaHMkrOO5m0+0gE9LMB0hXFSejAuQ0xDMaXkH4q
        tYI9sRE/o5C9bTTxaUZasG44azv9echFlF8jsIKhEhGH3CRdKUVqYquCrLrVwq0ke9m+oOm00c8
        aNDRHFani8zVgXoAltnS4vQrt84k3IAcCikR3vq+mz1UsKPZv+AN9GFoDz2U6okUd4RWzj9V36u
        Ku+GTRipRRD7VMDAIa
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 06cddc11-3c48-4b79-a805-7e64a9b8e299-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent any recovery work running after the queue cleanup cancel it.
Any recovery running post-cleanup dereferenced mq->card as NULL
and was not meaningful to begin with.

Cc: stable@vger.kernel.org

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
-v2: Use cancel instead of flush

 drivers/mmc/core/queue.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index fefaa901b50f..86be55d7cf55 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -493,6 +493,13 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	if (blk_queue_quiesced(q))
 		blk_mq_unquiesce_queue(q);
 
+	/*
+	 * If the recovery completes the last (and only remaining) request in
+	 * the queue, and the card has been removed, we could end up here with
+	 * the recovery not quite finished yet, so cancel it.
+	 */
+	cancel_work_sync(&mq->recovery_work);
+
 	blk_mq_free_tag_set(&mq->tag_set);
 
 	/*
-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

