Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CDC624532
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiKJPI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiKJPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:08:42 -0500
Received: from mx.msync.work (mx.msync.work [185.250.0.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF9F23149;
        Thu, 10 Nov 2022 07:08:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41848123166;
        Thu, 10 Nov 2022 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1668092467; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=ZftRKqAeH5kEZiPRpVJLIZ6Af/f8rleyvcwfQTNcp7I=;
        b=iBqP2MLxyMk8eCbFAdaeuExuIOALRKLLZSDpRtsRyVV6+urGSwF4pvBL4sqhn2FKo5pIcG
        9RukbBC9aFvVOD0PBymrIR8Yl5tG0APoGBPTtAZqYX0llwiGPdtkso+w3R5S5vx36iaKTd
        G1Oib53dVrYaq5ywCwggn5htG64J3Ifgku9cs9CZMYzXxYCfx2hbCdkfS9/Ne9qjRnm3jH
        KdJlzMNyepdljw4YnL0PXZjRxXWWscIGgIRPSVpCt0bIdzVhi1UsGE4yQbBKD9IMwzGBAL
        IcWrMtnp4/4GuFYrvG4QUS5q693UmEdH1f4hFdV4N3nk0etdMhYv0dF8Ku3hOw==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: amlogic: mmc: meson-gx: Add core, tx, rx eMMC/SD/SDIO phase clock settings from devicetree data
Date:   Thu, 10 Nov 2022 18:00:32 +0300
Message-Id: <20221110150035.2824580-2-adeep@lexina.in>
In-Reply-To: <20221110150035.2824580-1-adeep@lexina.in>
References: <20221110150035.2824580-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmc driver has the same phase values for all meson platforms. However,
some platforms (and even some boards) require different values. This patch
transfers the values from the set in the code to the variables in the
device-tree file.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index df05e60bed9a..c0f32054e472 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/bitfield.h>
 #include <linux/pinctrl/consumer.h>
+#include <dt-bindings/mmc/meson-gx-mmc.h>
 
 #define DRIVER_NAME "meson-gx-mmc"
 
@@ -36,8 +37,6 @@
 #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
 #define   CLK_TX_PHASE_MASK GENMASK(11, 10)
 #define   CLK_RX_PHASE_MASK GENMASK(13, 12)
-#define   CLK_PHASE_0 0
-#define   CLK_PHASE_180 2
 #define   CLK_V2_TX_DELAY_MASK GENMASK(19, 16)
 #define   CLK_V2_RX_DELAY_MASK GENMASK(23, 20)
 #define   CLK_V2_ALWAYS_ON BIT(24)
@@ -428,13 +427,22 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
 	const char *clk_parent[1];
 	u32 clk_reg;
+	u32 phase[3]; // <core_phase, tx_phase, rx_phase>
+
+	if (!(host->dev && host->dev->of_node) || (device_property_read_u32_array(host->dev,
+	    "amlogic,mmc-phase", phase, 3) < 0)) {
+		dev_dbg(host->dev, "get amlogic,mmc-phase failed, use default phase settings\n");
+		phase[0] = CLK_PHASE_180;
+		phase[1] = CLK_PHASE_0;
+		phase[2] = CLK_PHASE_0;
+	}
 
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
 	clk_reg = CLK_ALWAYS_ON(host);
 	clk_reg |= CLK_DIV_MASK;
-	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
-	clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
-	clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
+	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, phase[0]);
+	clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, phase[1]);
+	clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, phase[2]);
 	clk_reg |= CLK_IRQ_SDIO_SLEEP(host);
 	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
 
-- 
2.30.2

