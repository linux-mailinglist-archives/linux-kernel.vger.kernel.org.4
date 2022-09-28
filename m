Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C213B5EE103
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiI1P4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiI1Pzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3938E455
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:55:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 096A461F12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E0BC43470;
        Wed, 28 Sep 2022 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380537;
        bh=YZMOjgTNeBBMbRzzxRhwTWgxRv9J8huLdzYrUxYy2S4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDTZayabU/ZeTorlu4hi7Ad/PKqFked91GfMFoXSllA3SeMtQaU+YzGhjmRVAGfSp
         xSno8AB6nUj95qOxUEEyFCvOGXSmkp9ephJUkm7/MH1Nqr9DjX22PRaT/Bbx+HcUmO
         hRwQjJpRAl+/ghXII+VmJFuqmHeJ+Ot6ARqj9AAt5Qq/CZnUZudi2NIgm+9krrc9sj
         uAKfSHUCL0aY1fl75gOTzeYNW/zn+GtC+HrlfD719WNPXnKHGLpqmO2ADQDKW91pTi
         38xCscCcrUoW2agjtQMPNJH/Y0GfikiztG/Ymqr6vmdo6/ER2/necguZMEWhFDLhLX
         ePuAzGMgqdbKg==
From:   matthias.bgg@kernel.org
To:     roger.lu@mediatek.com, jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4/8] soc: mediatek: mtk-svs: delete superfluous platform data entries
Date:   Wed, 28 Sep 2022 17:55:15 +0200
Message-Id: <20220928155519.31977-5-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220928155519.31977-1-matthias.bgg@kernel.org>
References: <20220928155519.31977-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The platform name and efuse parsing function pointer are only used while
probing the device. Use them from the svs_platform_data struct instead.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 drivers/soc/mediatek/mtk-svs.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 8342627f8dea..482cc8d7e7cf 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -311,14 +311,12 @@ static const u32 svs_regs_v2[] = {
 
 /**
  * struct svs_platform - svs platform control
- * @name: svs platform name
  * @base: svs platform register base
  * @dev: svs platform device
  * @main_clk: main clock for svs bank
  * @pbank: svs bank pointer needing to be protected by spin_lock section
  * @banks: svs banks that svs platform supports
  * @rst: svs platform reset control
- * @efuse_parsing: svs platform efuse parsing function pointer
  * @efuse_max: total number of svs efuse
  * @tefuse_max: total number of thermal efuse
  * @regs: svs platform registers map
@@ -327,14 +325,12 @@ static const u32 svs_regs_v2[] = {
  * @tefuse: thermal efuse data received from NVMEM framework
  */
 struct svs_platform {
-	char *name;
 	void __iomem *base;
 	struct device *dev;
 	struct clk *main_clk;
 	struct svs_bank *pbank;
 	struct svs_bank *banks;
 	struct reset_control *rst;
-	bool (*efuse_parsing)(struct svs_platform *svsp);
 	size_t efuse_max;
 	size_t tefuse_max;
 	const u32 *regs;
@@ -2009,7 +2005,7 @@ static bool svs_is_efuse_data_correct(struct svs_platform *svsp)
 	svsp->efuse_max /= sizeof(u32);
 	nvmem_cell_put(cell);
 
-	return svsp->efuse_parsing(svsp);
+	return true;
 }
 
 static struct device *svs_get_subsys_device(struct svs_platform *svsp,
@@ -2338,9 +2334,7 @@ static int svs_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	svsp->dev = &pdev->dev;
-	svsp->name = svsp_data->name;
 	svsp->banks = svsp_data->banks;
-	svsp->efuse_parsing = svsp_data->efuse_parsing;
 	svsp->regs = svsp_data->regs;
 	svsp->bank_max = svsp_data->bank_max;
 
@@ -2351,6 +2345,12 @@ static int svs_probe(struct platform_device *pdev)
 	if (!svs_is_efuse_data_correct(svsp)) {
 		dev_notice(svsp->dev, "efuse data isn't correct\n");
 		ret = -EPERM;
+		goto svs_probe_free_efuse;
+	}
+
+	if (!svsp_data->efuse_parsing(svsp)) {
+		dev_notice(svsp->dev, "efuse data parsing failed\n");
+		ret = -EPERM;
 		goto svs_probe_free_resource;
 	}
 
@@ -2367,7 +2367,7 @@ static int svs_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
-					IRQF_ONESHOT, svsp->name, svsp);
+					IRQF_ONESHOT, svsp_data->name, svsp);
 	if (ret) {
 		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
 			svsp_irq, ret);
@@ -2416,11 +2416,13 @@ static int svs_probe(struct platform_device *pdev)
 	clk_disable_unprepare(svsp->main_clk);
 
 svs_probe_free_resource:
-	if (!IS_ERR_OR_NULL(svsp->efuse))
-		kfree(svsp->efuse);
 	if (!IS_ERR_OR_NULL(svsp->tefuse))
 		kfree(svsp->tefuse);
 
+svs_probe_free_efuse:
+	if (!IS_ERR_OR_NULL(svsp->efuse))
+		kfree(svsp->efuse);
+
 	return ret;
 }
 
-- 
2.37.3

