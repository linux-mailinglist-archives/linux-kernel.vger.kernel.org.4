Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4F5604BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiJSPnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiJSPnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:43:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E76F27DC1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFF1061908
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4841BC433D6;
        Wed, 19 Oct 2022 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666193852;
        bh=0Pt8ZEBcDFoM+kJKswCp3Alo0JKy8gPb9ihepHTIFqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6/PnkUSuDkr0Us354pM/N4EBjSCHkV15kkVl//aq3vvlnYalb1JAoWZ6+h2+52XQ
         ljiD2oSQxLA9u8n4D2ScDbDYOCFLTXDvuJ+UDdjjyyRbgmY1bH9IWcvf1R0RJ0B8c7
         EuTL/tDag/30cd4OZjomdeO9FR/Z1Hri3OfTS70HYl6HGuFuSC6JVdDIkoA8w5RiJ2
         eatvOiGUHZuylTuMwQXg7EN+HWNICe82G2SD44CLxJFxk0MUKdAy1VNjgtz8RCcBFP
         ZBrEcwHrGSZivH3EA3pI4FyPYJxFR02dZfAtO6+8BJQRsIF2EIOQFqy97JhrbvoKJD
         Zzragzg5cOVjQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 10/14] mfd: remove davinci voicecodec driver
Date:   Wed, 19 Oct 2022 17:29:36 +0200
Message-Id: <20221019152947.3857217-11-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019152947.3857217-1-arnd@kernel.org>
References: <20221019152947.3857217-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The ASoC davinci voicecodec support is no longer used after
the removal of the dm3xx SoC platform, so the MFD driver is never
selected.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/Kconfig              |   5 --
 drivers/mfd/Makefile             |   2 -
 drivers/mfd/davinci_voicecodec.c | 136 -------------------------------
 3 files changed, 143 deletions(-)
 delete mode 100644 drivers/mfd/davinci_voicecodec.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 31751cd3c4ed..e05474ba687c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1423,11 +1423,6 @@ config MFD_SYSCON
 	  Select this option to enable accessing system control registers
 	  via regmap.
 
-config MFD_DAVINCI_VOICECODEC
-	tristate
-	select MFD_CORE
-	select REGMAP_MMIO
-
 config MFD_TI_AM335X_TSCADC
 	tristate "TI ADC / Touch Screen chip support"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a3a304f8c762..38d9bf03c249 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -22,8 +22,6 @@ obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
 
 obj-$(CONFIG_MFD_TI_LP873X)	+= lp873x.o
 obj-$(CONFIG_MFD_TI_LP87565)	+= lp87565.o
-
-obj-$(CONFIG_MFD_DAVINCI_VOICECODEC)	+= davinci_voicecodec.o
 obj-$(CONFIG_MFD_TI_AM335X_TSCADC)	+= ti_am335x_tscadc.o
 
 obj-$(CONFIG_MFD_STA2X11)	+= sta2x11-mfd.o
diff --git a/drivers/mfd/davinci_voicecodec.c b/drivers/mfd/davinci_voicecodec.c
deleted file mode 100644
index 965820481f1e..000000000000
--- a/drivers/mfd/davinci_voicecodec.c
+++ /dev/null
@@ -1,136 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * DaVinci Voice Codec Core Interface for TI platforms
- *
- * Copyright (C) 2010 Texas Instruments, Inc
- *
- * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/regmap.h>
-
-#include <sound/pcm.h>
-
-#include <linux/mfd/davinci_voicecodec.h>
-
-static const struct regmap_config davinci_vc_regmap = {
-	.reg_bits = 32,
-	.val_bits = 32,
-};
-
-static int __init davinci_vc_probe(struct platform_device *pdev)
-{
-	struct davinci_vc *davinci_vc;
-	struct resource *res;
-	struct mfd_cell *cell = NULL;
-	dma_addr_t fifo_base;
-	int ret;
-
-	davinci_vc = devm_kzalloc(&pdev->dev,
-				  sizeof(struct davinci_vc), GFP_KERNEL);
-	if (!davinci_vc)
-		return -ENOMEM;
-
-	davinci_vc->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(davinci_vc->clk)) {
-		dev_dbg(&pdev->dev,
-			    "could not get the clock for voice codec\n");
-		return -ENODEV;
-	}
-	clk_enable(davinci_vc->clk);
-
-	davinci_vc->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(davinci_vc->base)) {
-		ret = PTR_ERR(davinci_vc->base);
-		goto fail;
-	}
-	fifo_base = (dma_addr_t)res->start;
-
-	davinci_vc->regmap = devm_regmap_init_mmio(&pdev->dev,
-						   davinci_vc->base,
-						   &davinci_vc_regmap);
-	if (IS_ERR(davinci_vc->regmap)) {
-		ret = PTR_ERR(davinci_vc->regmap);
-		goto fail;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "no DMA resource\n");
-		ret = -ENXIO;
-		goto fail;
-	}
-
-	davinci_vc->davinci_vcif.dma_tx_channel = res->start;
-	davinci_vc->davinci_vcif.dma_tx_addr = fifo_base + DAVINCI_VC_WFIFO;
-
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!res) {
-		dev_err(&pdev->dev, "no DMA resource\n");
-		ret = -ENXIO;
-		goto fail;
-	}
-
-	davinci_vc->davinci_vcif.dma_rx_channel = res->start;
-	davinci_vc->davinci_vcif.dma_rx_addr = fifo_base + DAVINCI_VC_RFIFO;
-
-	davinci_vc->dev = &pdev->dev;
-	davinci_vc->pdev = pdev;
-
-	/* Voice codec interface client */
-	cell = &davinci_vc->cells[DAVINCI_VC_VCIF_CELL];
-	cell->name = "davinci-vcif";
-	cell->platform_data = davinci_vc;
-	cell->pdata_size = sizeof(*davinci_vc);
-
-	/* Voice codec CQ93VC client */
-	cell = &davinci_vc->cells[DAVINCI_VC_CQ93VC_CELL];
-	cell->name = "cq93vc-codec";
-	cell->platform_data = davinci_vc;
-	cell->pdata_size = sizeof(*davinci_vc);
-
-	ret = mfd_add_devices(&pdev->dev, pdev->id, davinci_vc->cells,
-			      DAVINCI_VC_CELLS, NULL, 0, NULL);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "fail to register client devices\n");
-		goto fail;
-	}
-
-	return 0;
-
-fail:
-	clk_disable(davinci_vc->clk);
-
-	return ret;
-}
-
-static int davinci_vc_remove(struct platform_device *pdev)
-{
-	struct davinci_vc *davinci_vc = platform_get_drvdata(pdev);
-
-	mfd_remove_devices(&pdev->dev);
-
-	clk_disable(davinci_vc->clk);
-
-	return 0;
-}
-
-static struct platform_driver davinci_vc_driver = {
-	.driver	= {
-		.name = "davinci_voicecodec",
-	},
-	.remove	= davinci_vc_remove,
-};
-
-module_platform_driver_probe(davinci_vc_driver, davinci_vc_probe);
-
-MODULE_AUTHOR("Miguel Aguilar");
-MODULE_DESCRIPTION("Texas Instruments DaVinci Voice Codec Core Interface");
-MODULE_LICENSE("GPL");
-- 
2.29.2

