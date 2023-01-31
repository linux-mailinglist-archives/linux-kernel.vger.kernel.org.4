Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50368383C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjAaVCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjAaVCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:02:41 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F6010CA;
        Tue, 31 Jan 2023 13:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1675198956; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=4cfcgyV3aGGoH7bkT08YeGcbkBQEHVw7y75FoDFtFug=;
        b=gmkm7HQaVu5zsURDq0L1yTEtMxxqPBeTqvJRLNLATyCSpS4AsarbmrsmaV3P0993HqzKQP
        yIB5M2CtpQ3aI+ksGKlfrJAt8yC1p/lA/UH19E95vVLi20MhYyXrJ+HeusdqlO0Xvacv3e
        pPDjCQbQbLE0yQeGpUGmFykPL2SH1fo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] mmc: jz4740: Work around bug on JZ4760(B)
Date:   Tue, 31 Jan 2023 21:02:28 +0000
Message-Id: <20230131210229.68129-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On JZ4760 and JZ4760B, SD cards fail to run if the maximum clock
rate is set to 50 MHz, even though the controller officially does
support it.

Until the actual bug is found and fixed, limit the maximum clock rate to
24 MHz.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mmc/host/jz4740_mmc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 319a2a79c9a0..eb8e9607b086 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1104,6 +1104,16 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	mmc->ops = &jz4740_mmc_ops;
 	if (!mmc->f_max)
 		mmc->f_max = JZ_MMC_CLK_RATE;
+
+	/*
+	 * There seems to be a problem with this driver on the JZ4760 and
+	 * JZ4760B SoCs. There, when using the maximum rate supported (50 MHz),
+	 * the communication fails with many SD cards.
+	 * Until this bug is sorted out, limit the maximum rate to 24 MHz.
+	 */
+	if (host->version == JZ_MMC_JZ4760 && mmc->f_max > JZ_MMC_CLK_RATE)
+		mmc->f_max = JZ_MMC_CLK_RATE;
+
 	mmc->f_min = mmc->f_max / 128;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
-- 
2.39.1

