Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDE45F6853
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiJFNi6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Oct 2022 09:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiJFNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:38:53 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B528AC382;
        Thu,  6 Oct 2022 06:38:47 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 0413F3A170F;
        Thu,  6 Oct 2022 15:38:45 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id DC1FE3A1625;
        Thu,  6 Oct 2022 15:38:44 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (sbdeex04.sbitdom.lan [10.149.2.42])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Thu,  6 Oct 2022 15:38:44 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 6 Oct 2022
 15:38:40 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Thu, 6 Oct 2022 15:38:40 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
Subject: [PATCH 1/2] mmc: block: Remove error check of hw_reset on reset
Thread-Topic: [PATCH 1/2] mmc: block: Remove error check of hw_reset on reset
Thread-Index: AdjZiMURb3moNmapTDOMC5quWhQ63Q==
Date:   Thu, 6 Oct 2022 13:38:40 +0000
Message-ID: <cc0d807fbd2f4001adef8728f957c696@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.46]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27184.007
X-TMASE-Result: 10-4.612300-10.000000
X-TMASE-MatchedRID: h20DFeLkM89gljMcj2tyXt5x7RpGJf1a0U0UWSZVhAriKUaoIhea7dAY
        WUo4HSIkSrqDabEvLXFgvuOVbAf7tqGGOyqBK41vEXjPIvKd74BMkOX0UoduuTQM0/COoudwiE9
        RqXHGrIfTnPJMGpZGuwR2KsmNWZajcgDifvL5MeqeAiCmPx4NwItuikALUpnGpuP9zg477pEqtq
        5d3cxkNfAxRSAc0OEN9v+NNOVSdf8awsaFNipvKlkxhpwN50f7hfSmVWfOpMhaMOUu/TgNueVvw
        BMCJ5qI
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: f14a20e7-1d43-420b-aaa1-e96bb1c30d59-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before switching back to the right partition in mmc_blk_reset
there used to be a check if hw_reset was even supported.
This return value was removed, so there is no reason to check.

Fixes: fefdd3c91e0a ("mmc: core: Drop superfluous validations in mmc_hw|sw_reset()")
Cc: stable@vger.kernel.org

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ce89611a136e..8531f92fd0cb 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -991,6 +991,8 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 			 int type)
 {
 	int err;
+	struct mmc_blk_data *main_md = dev_get_drvdata(&host->card->dev);
+	int part_err;
 
 	if (md->reset_done & type)
 		return -EEXIST;
@@ -998,20 +1000,14 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 	md->reset_done |= type;
 	err = mmc_hw_reset(host->card);
 	/* Ensure we switch back to the correct partition */
-	if (err) {
-		struct mmc_blk_data *main_md =
-			dev_get_drvdata(&host->card->dev);
-		int part_err;
-
-		main_md->part_curr = main_md->part_type;
-		part_err = mmc_blk_part_switch(host->card, md->part_type);
-		if (part_err) {
-			/*
-			 * We have failed to get back into the correct
-			 * partition, so we need to abort the whole request.
-			 */
-			return -ENODEV;
-		}
+	main_md->part_curr = main_md->part_type;
+	part_err = mmc_blk_part_switch(host->card, md->part_type);
+	if (part_err) {
+		/*
+		 * We have failed to get back into the correct
+		 * partition, so we need to abort the whole request.
+		 */
+		return -ENODEV;
 	}
 	return err;
 }
-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

