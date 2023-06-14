Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4687E71576F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjE3HoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjE3HnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:43:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEDA11B;
        Tue, 30 May 2023 00:43:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b041ccea75so12702515ad.2;
        Tue, 30 May 2023 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685432581; x=1688024581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wh4S3DCs0K/sx0d0emXPkFW/k+nrYsVpD6MXHagOka8=;
        b=BeuzAaT4hlrlDV5Bta7Tqvjr3FA9SzJDD3BDaQwbLad69CE1q9SF4yagSulQ3znqAz
         P6gTRS6z5GjXBXdltMkG84IXAVsJtsSK5qaO/DQNbW7YD+uLIcOqX4ka2ofMvpVLEshq
         NooJfzAFBjF0/Y0yZ1pC+5zL6a8Ct+EHwdBuY5ImL04YRrFLF1DiOWzzRQW2C8FhaQd0
         CilVUmZ+Bfe3i2OizJnEOmlDbfdPvvJZx52uHT5TQdM/+WhWr3lqQFRlDS9Q3P653L7t
         kZunIGCZN3W8/CvOvxNFVEVKWQyIfcvIbM9pP8fICDvgSEqzO7ZDO21YEaADQwR7BBx6
         lngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685432581; x=1688024581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wh4S3DCs0K/sx0d0emXPkFW/k+nrYsVpD6MXHagOka8=;
        b=iYEK2ga/buzivWqGouaozRch365rC81NROWc6WH9wSKtl8SapnCB+QXURoAA79rcpm
         u+fuFfIR25JX2+50WsDL+M4uQs1AhY7mwc6kTLfCK9Iwr4himyIZQ21YzSMb9JHDYepf
         joXQQQRSAAQh7qrFSf851rNVltCqrMKxE4a3LniSPMRy+hB2GuGu+ghMD/ov1q94nNxB
         L+2BqXEK01fdevRXa5ez474FerbqGKDZEVU324ax4hn0JOYFWKU8KAx5xE3M0tZAIR6q
         HbBieXbHEQ0nUWDuYVBP03qBI2LPkAu6R7bvA29PUOmwDsRtkGU5yRHqE6rUyuuCgZ/N
         Z2RA==
X-Gm-Message-State: AC+VfDyZOyY8M5Liuhss6E1Ys95nLgmiHANfGJQb8+C/4fZDLqml+482
        PgItJzi3/vhEh+r37lKgmPKyVx099mk=
X-Google-Smtp-Source: ACHHUZ7GBF4O1qXSBR/+7WtyXCA4nLQdc7hJRuWJqP7HUZg6KWOLcb9FCYsYwmXRQXhrVrMEWZJ5Bw==
X-Received: by 2002:a17:903:182:b0:1b0:2bc1:94bc with SMTP id z2-20020a170903018200b001b02bc194bcmr1910322plg.65.1685432581221;
        Tue, 30 May 2023 00:43:01 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b001afb96f4b90sm5930793plh.274.2023.05.30.00.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:43:00 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v12 09/10] reset: Add Nuvoton ma35d1 reset driver support
Date:   Tue, 30 May 2023 07:42:20 +0000
Message-Id: <20230530074221.1031011-10-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530074221.1031011-1-ychuang570808@gmail.com>
References: <20230530074221.1031011-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

This driver supports individual IP reset for the MA35D1. The reset
control registers are a subset of the system control registers.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/reset/Kconfig        |   6 +
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-ma35d1.c | 235 +++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 drivers/reset/reset-ma35d1.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 6aa8f243b30c..07499177a266 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -143,6 +143,12 @@ config RESET_NPCM
 	  This enables the reset controller driver for Nuvoton NPCM
 	  BMC SoCs.
 
+config RESET_NUVOTON_MA35D1
+	bool "Nuvton MA35D1 Reset Driver"
+	default ARCH_MA35 || COMPILE_TEST
+	help
+	  This enables the reset controller driver for Nuvoton MA35D1 SoC.
+
 config RESET_OXNAS
 	bool
 
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 7fec5af6c964..411b45ba0da7 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
 obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
+obj-$(CONFIG_RESET_NUVOTON_MA35D1) += reset-ma35d1.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_POLARFIRE_SOC) += reset-mpfs.o
diff --git a/drivers/reset/reset-ma35d1.c b/drivers/reset/reset-ma35d1.c
new file mode 100644
index 000000000000..54e53863c98a
--- /dev/null
+++ b/drivers/reset/reset-ma35d1.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Nuvoton Technology Corp.
+ * Author: Chi-Fang Li <cfli0@nuvoton.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+#include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+
+struct ma35d1_reset_data {
+	struct reset_controller_dev rcdev;
+	struct notifier_block restart_handler;
+	void __iomem *base;
+	/* protect registers against concurrent read-modify-write */
+	spinlock_t lock;
+};
+
+static const struct {
+	u32 reg_ofs;
+	u32 bit;
+} ma35d1_reset_map[] = {
+	[MA35D1_RESET_CHIP] =    {0x20, 0},
+	[MA35D1_RESET_CA35CR0] = {0x20, 1},
+	[MA35D1_RESET_CA35CR1] = {0x20, 2},
+	[MA35D1_RESET_CM4] =     {0x20, 3},
+	[MA35D1_RESET_PDMA0] =   {0x20, 4},
+	[MA35D1_RESET_PDMA1] =   {0x20, 5},
+	[MA35D1_RESET_PDMA2] =   {0x20, 6},
+	[MA35D1_RESET_PDMA3] =   {0x20, 7},
+	[MA35D1_RESET_DISP] =    {0x20, 9},
+	[MA35D1_RESET_VCAP0] =   {0x20, 10},
+	[MA35D1_RESET_VCAP1] =   {0x20, 11},
+	[MA35D1_RESET_GFX] =     {0x20, 12},
+	[MA35D1_RESET_VDEC] =    {0x20, 13},
+	[MA35D1_RESET_WHC0] =    {0x20, 14},
+	[MA35D1_RESET_WHC1] =    {0x20, 15},
+	[MA35D1_RESET_GMAC0] =   {0x20, 16},
+	[MA35D1_RESET_GMAC1] =   {0x20, 17},
+	[MA35D1_RESET_HWSEM] =   {0x20, 18},
+	[MA35D1_RESET_EBI] =     {0x20, 19},
+	[MA35D1_RESET_HSUSBH0] = {0x20, 20},
+	[MA35D1_RESET_HSUSBH1] = {0x20, 21},
+	[MA35D1_RESET_HSUSBD] =  {0x20, 22},
+	[MA35D1_RESET_USBHL] =   {0x20, 23},
+	[MA35D1_RESET_SDH0] =    {0x20, 24},
+	[MA35D1_RESET_SDH1] =    {0x20, 25},
+	[MA35D1_RESET_NAND] =    {0x20, 26},
+	[MA35D1_RESET_GPIO] =    {0x20, 27},
+	[MA35D1_RESET_MCTLP] =   {0x20, 28},
+	[MA35D1_RESET_MCTLC] =   {0x20, 29},
+	[MA35D1_RESET_DDRPUB] =  {0x20, 30},
+	[MA35D1_RESET_TMR0] =    {0x24, 2},
+	[MA35D1_RESET_TMR1] =    {0x24, 3},
+	[MA35D1_RESET_TMR2] =    {0x24, 4},
+	[MA35D1_RESET_TMR3] =    {0x24, 5},
+	[MA35D1_RESET_I2C0] =    {0x24, 8},
+	[MA35D1_RESET_I2C1] =    {0x24, 9},
+	[MA35D1_RESET_I2C2] =    {0x24, 10},
+	[MA35D1_RESET_I2C3] =    {0x24, 11},
+	[MA35D1_RESET_QSPI0] =   {0x24, 12},
+	[MA35D1_RESET_SPI0] =    {0x24, 13},
+	[MA35D1_RESET_SPI1] =    {0x24, 14},
+	[MA35D1_RESET_SPI2] =    {0x24, 15},
+	[MA35D1_RESET_UART0] =   {0x24, 16},
+	[MA35D1_RESET_UART1] =   {0x24, 17},
+	[MA35D1_RESET_UART2] =   {0x24, 18},
+	[MA35D1_RESET_UART3] =   {0x24, 19},
+	[MA35D1_RESET_UART4] =   {0x24, 20},
+	[MA35D1_RESET_UART5] =   {0x24, 21},
+	[MA35D1_RESET_UART6] =   {0x24, 22},
+	[MA35D1_RESET_UART7] =   {0x24, 23},
+	[MA35D1_RESET_CANFD0] =  {0x24, 24},
+	[MA35D1_RESET_CANFD1] =  {0x24, 25},
+	[MA35D1_RESET_EADC0] =   {0x24, 28},
+	[MA35D1_RESET_I2S0] =    {0x24, 29},
+	[MA35D1_RESET_SC0] =     {0x28, 0},
+	[MA35D1_RESET_SC1] =     {0x28, 1},
+	[MA35D1_RESET_QSPI1] =   {0x28, 4},
+	[MA35D1_RESET_SPI3] =    {0x28, 6},
+	[MA35D1_RESET_EPWM0] =   {0x28, 16},
+	[MA35D1_RESET_EPWM1] =   {0x28, 17},
+	[MA35D1_RESET_QEI0] =    {0x28, 22},
+	[MA35D1_RESET_QEI1] =    {0x28, 23},
+	[MA35D1_RESET_ECAP0] =   {0x28, 26},
+	[MA35D1_RESET_ECAP1] =   {0x28, 27},
+	[MA35D1_RESET_CANFD2] =  {0x28, 28},
+	[MA35D1_RESET_ADC0] =    {0x28, 31},
+	[MA35D1_RESET_TMR4] =    {0x2C, 0},
+	[MA35D1_RESET_TMR5] =    {0x2C, 1},
+	[MA35D1_RESET_TMR6] =    {0x2C, 2},
+	[MA35D1_RESET_TMR7] =    {0x2C, 3},
+	[MA35D1_RESET_TMR8] =    {0x2C, 4},
+	[MA35D1_RESET_TMR9] =    {0x2C, 5},
+	[MA35D1_RESET_TMR10] =   {0x2C, 6},
+	[MA35D1_RESET_TMR11] =   {0x2C, 7},
+	[MA35D1_RESET_UART8] =   {0x2C, 8},
+	[MA35D1_RESET_UART9] =   {0x2C, 9},
+	[MA35D1_RESET_UART10] =  {0x2C, 10},
+	[MA35D1_RESET_UART11] =  {0x2C, 11},
+	[MA35D1_RESET_UART12] =  {0x2C, 12},
+	[MA35D1_RESET_UART13] =  {0x2C, 13},
+	[MA35D1_RESET_UART14] =  {0x2C, 14},
+	[MA35D1_RESET_UART15] =  {0x2C, 15},
+	[MA35D1_RESET_UART16] =  {0x2C, 16},
+	[MA35D1_RESET_I2S1] =    {0x2C, 17},
+	[MA35D1_RESET_I2C4] =    {0x2C, 18},
+	[MA35D1_RESET_I2C5] =    {0x2C, 19},
+	[MA35D1_RESET_EPWM2] =   {0x2C, 20},
+	[MA35D1_RESET_ECAP2] =   {0x2C, 21},
+	[MA35D1_RESET_QEI2] =    {0x2C, 22},
+	[MA35D1_RESET_CANFD3] =  {0x2C, 23},
+	[MA35D1_RESET_KPI] =     {0x2C, 24},
+	[MA35D1_RESET_GIC] =     {0x2C, 28},
+	[MA35D1_RESET_SSMCC] =   {0x2C, 30},
+	[MA35D1_RESET_SSPCC] =   {0x2C, 31}
+};
+
+static int ma35d1_restart_handler(struct notifier_block *this, unsigned long mode, void *cmd)
+{
+	struct ma35d1_reset_data *data =
+				 container_of(this, struct ma35d1_reset_data, restart_handler);
+	u32 id = MA35D1_RESET_CHIP;
+
+	writel_relaxed(BIT(ma35d1_reset_map[id].bit),
+		       data->base + ma35d1_reset_map[id].reg_ofs);
+	return 0;
+}
+
+static int ma35d1_reset_update(struct reset_controller_dev *rcdev, unsigned long id, bool assert)
+{
+	struct ma35d1_reset_data *data = container_of(rcdev, struct ma35d1_reset_data, rcdev);
+	unsigned long flags;
+	u32 reg;
+
+	if (WARN_ON_ONCE(id >= ARRAY_SIZE(ma35d1_reset_map)))
+		return -EINVAL;
+
+	spin_lock_irqsave(&data->lock, flags);
+	reg = readl_relaxed(data->base + ma35d1_reset_map[id].reg_ofs);
+	if (assert)
+		reg |= BIT(ma35d1_reset_map[id].bit);
+	else
+		reg &= ~(BIT(ma35d1_reset_map[id].bit));
+	writel_relaxed(reg, data->base + ma35d1_reset_map[id].reg_ofs);
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static int ma35d1_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return ma35d1_reset_update(rcdev, id, true);
+}
+
+static int ma35d1_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return ma35d1_reset_update(rcdev, id, false);
+}
+
+static int ma35d1_reset_status(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct ma35d1_reset_data *data = container_of(rcdev, struct ma35d1_reset_data, rcdev);
+	u32 reg;
+
+	if (WARN_ON_ONCE(id >= ARRAY_SIZE(ma35d1_reset_map)))
+		return -EINVAL;
+
+	reg = readl_relaxed(data->base + ma35d1_reset_map[id].reg_ofs);
+	return !!(reg & BIT(ma35d1_reset_map[id].bit));
+}
+
+static const struct reset_control_ops ma35d1_reset_ops = {
+	.assert = ma35d1_reset_assert,
+	.deassert = ma35d1_reset_deassert,
+	.status = ma35d1_reset_status,
+};
+
+static const struct of_device_id ma35d1_reset_dt_ids[] = {
+	{ .compatible = "nuvoton,ma35d1-reset" },
+	{ },
+};
+
+static int ma35d1_reset_probe(struct platform_device *pdev)
+{
+	struct ma35d1_reset_data *reset_data;
+	struct device *dev = &pdev->dev;
+	int err;
+
+	if (!pdev->dev.of_node) {
+		dev_err(&pdev->dev, "Device tree node not found\n");
+		return -EINVAL;
+	}
+
+	reset_data = devm_kzalloc(dev, sizeof(*reset_data), GFP_KERNEL);
+	if (!reset_data)
+		return -ENOMEM;
+
+	reset_data->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reset_data->base))
+		return PTR_ERR(reset_data->base);
+
+	reset_data->rcdev.owner = THIS_MODULE;
+	reset_data->rcdev.nr_resets = MA35D1_RESET_COUNT;
+	reset_data->rcdev.ops = &ma35d1_reset_ops;
+	reset_data->rcdev.of_node = dev->of_node;
+	reset_data->restart_handler.notifier_call = ma35d1_restart_handler;
+	reset_data->restart_handler.priority = 192;
+	spin_lock_init(&reset_data->lock);
+
+	err = register_restart_handler(&reset_data->restart_handler);
+	if (err)
+		dev_warn(&pdev->dev, "failed to register restart handler\n");
+
+	return devm_reset_controller_register(dev, &reset_data->rcdev);
+}
+
+static struct platform_driver ma35d1_reset_driver = {
+	.probe = ma35d1_reset_probe,
+	.driver = {
+		.name = "ma35d1-reset",
+		.of_match_table	= ma35d1_reset_dt_ids,
+	},
+};
+
+builtin_platform_driver(ma35d1_reset_driver);
-- 
2.34.1

