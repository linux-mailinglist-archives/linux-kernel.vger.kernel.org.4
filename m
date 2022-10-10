Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4955F9FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJJODr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Oct 2022 10:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJJODo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:03:44 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538773ED46;
        Mon, 10 Oct 2022 07:03:42 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id D8AD646317A;
        Mon, 10 Oct 2022 16:03:39 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C69D4460E71;
        Mon, 10 Oct 2022 16:03:39 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Mon, 10 Oct 2022 16:03:39 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Mon, 10 Oct
 2022 16:03:38 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Mon, 10 Oct 2022 16:03:38 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
Subject: [PATCHv3 1/2] mmc: block: Remove error check of hw_reset on reset
Thread-Topic: [PATCHv3 1/2] mmc: block: Remove error check of hw_reset on
 reset
Thread-Index: AdjcrIZ8W48yAN4GQUaGB+oWYInfkQ==
Date:   Mon, 10 Oct 2022 14:03:38 +0000
Message-ID: <0d0ef6651ed44fc780e95c8797294708@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.46]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27194.000
X-TMASE-Result: 10-3.068200-10.000000
X-TMASE-MatchedRID: dwNgap4H9hhgljMcj2tyXt5x7RpGJf1a0U0UWSZVhAriKUaoIhea7dAY
        WUo4HSIkSrqDabEvLXFgvuOVbAf7tqGGOyqBK41vEXjPIvKd74BMkOX0UoduuRA7RG59gG0fiv8
        GLGO2mRMtjQqbqQUNMkIiZV10Im2jw2u1xPaqnyYZgmFGHqyx60fLPdsHmQbn7mKObFAiT2L+8j
        lqHfykNVml27ZC+eUCfyYDewMOrQC1ULtRjWfrIuJGF26G8SWy8lP6F/raTZj6CxJ5baM0J7H3f
        YdLnnYjBLdgmKx0ECfREToL1EgKScoDYQE0jYB3CStjCuOR/hg=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 61be56cd-a28e-44a4-80bb-8c56dc3dff80-0-0-200-0
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
Furthermore ensure part_curr is not falsely set to a valid value
on reset or partition switch error.

Fixes: fefdd3c91e0a ("mmc: core: Drop superfluous validations in mmc_hw|sw_reset()")
Cc: stable@vger.kernel.org

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
-v3: Ensure invalid part_curr on error
-v2: Do not attempt to switch partitions if reset failed

 drivers/mmc/core/block.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ce89611a136e..45a44edcc31a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -134,6 +134,7 @@ struct mmc_blk_data {
 	 * track of the current selected device partition.
 	 */
 	unsigned int	part_curr;
+#define MMC_BLK_PART_INVALID	UINT_MAX	/* Unknown partition active */
 	int	area_type;
 
 	/* debugfs files (only in main mmc_blk_data) */
@@ -991,29 +992,27 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 			 int type)
 {
 	int err;
+	struct mmc_blk_data *main_md = dev_get_drvdata(&host->card->dev);
+	int part_err;
 
 	if (md->reset_done & type)
 		return -EEXIST;
 
 	md->reset_done |= type;
+	main_md->part_curr = MMC_BLK_PART_INVALID;
 	err = mmc_hw_reset(host->card);
+	if (err)
+		return err;
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
+	part_err = mmc_blk_part_switch(host->card, md->part_type);
+	if (part_err) {
+		/*
+		 * We have failed to get back into the correct
+		 * partition, so we need to abort the whole request.
+		 */
+		return -ENODEV;
 	}
-	return err;
+	return 0;
 }
 
 static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
-- 
2.37.3
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

