Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E035705AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjEPXC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEPXC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:02:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0009F76AF;
        Tue, 16 May 2023 16:02:54 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 408CE6605905;
        Wed, 17 May 2023 00:02:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684278173;
        bh=qwN88J0Rbr1Da7hiHvEJ/DwurFUZhOrTurH08fXFxNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSyKsZlJHjDNtWbgK6zTYddhTRMPaoXFGWoFYgaVNp0cCHk0Jt0L1qx+0KOGTcLbB
         zTwezVjSvDkmPhIuTrJEgaxsfepa1wlGz9ZB80IsFwsiU+hHE8T1ISACNlP6W9tyxQ
         cZdl/7aXaRXkzYhNDDnLcqnYQDzfp6MXJpgWyuFK7IOrIxxqdWWtNckXazjfgShY5c
         CpvAFYM3K6W5Usbji2YxIjVXG37pzjZ/imDXPqf+4wpIJdEOvvxY1YHIT9bF+ENcQ5
         mfFesaOKIyHAk4l6CpouHfS2ICXXRHMli+b2h0cF2LAU7mtYhkfx2IAUGsHExaCnfD
         XjhrOItU95aBw==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Simon Xue <xxm@rock-chips.com>
Subject: [PATCH 1/7] iio: adc: rockchip_saradc: Add support for RK3588
Date:   Wed, 17 May 2023 04:30:45 +0530
Message-Id: <20230516230051.14846-2-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516230051.14846-1-shreeya.patel@collabora.com>
References: <20230516230051.14846-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor conversion operation to support rk3588 saradc and
add separate start, read, powerdown in respective hooks.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 drivers/iio/adc/rockchip_saradc.c | 127 +++++++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 79448c5ffc2a..ac6fdf8e673b 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -38,10 +38,29 @@
 #define SARADC_TIMEOUT			msecs_to_jiffies(100)
 #define SARADC_MAX_CHANNELS		8
 
+/* v2 registers */
+#define SARADC2_CONV_CON		0x0
+#define SARADC_T_PD_SOC			0x4
+#define SARADC_T_DAS_SOC		0xc
+#define SARADC2_END_INT_EN		0x104
+#define SARADC2_ST_CON			0x108
+#define SARADC2_STATUS			0x10c
+#define SARADC2_END_INT_ST		0x110
+#define SARADC2_DATA_BASE		0x120
+
+#define SARADC2_EN_END_INT		BIT(0)
+#define SARADC2_START			BIT(4)
+#define SARADC2_SINGLE_MODE		BIT(5)
+
+struct rockchip_saradc;
+
 struct rockchip_saradc_data {
 	const struct iio_chan_spec	*channels;
 	int				num_channels;
 	unsigned long			clk_rate;
+	void (*start)(struct rockchip_saradc *info, int chn);
+	int (*read)(struct rockchip_saradc *info);
+	void (*power_down)(struct rockchip_saradc *info);
 };
 
 struct rockchip_saradc {
@@ -60,27 +79,77 @@ struct rockchip_saradc {
 	struct notifier_block nb;
 };
 
-static void rockchip_saradc_power_down(struct rockchip_saradc *info)
+static void rockchip_saradc_reset_controller(struct reset_control *reset);
+
+static void rockchip_saradc_start_v1(struct rockchip_saradc *info, int chn)
+{
+	/* 8 clock periods as delay between power up and start cmd */
+	writel_relaxed(8, info->regs + SARADC_DLY_PU_SOC);
+	/* Select the channel to be used and trigger conversion */
+	writel(SARADC_CTRL_POWER_CTRL | (chn & SARADC_CTRL_CHN_MASK) |
+	       SARADC_CTRL_IRQ_ENABLE, info->regs + SARADC_CTRL);
+}
+
+static void rockchip_saradc_start_v2(struct rockchip_saradc *info, int chn)
+{
+	int val;
+
+	if (info->reset)
+		rockchip_saradc_reset_controller(info->reset);
+
+	writel_relaxed(0xc, info->regs + SARADC_T_DAS_SOC);
+	writel_relaxed(0x20, info->regs + SARADC_T_PD_SOC);
+	val = SARADC2_EN_END_INT << 16 | SARADC2_EN_END_INT;
+	writel_relaxed(val, info->regs + SARADC2_END_INT_EN);
+	val = SARADC2_START | SARADC2_SINGLE_MODE | chn;
+	writel(val << 16 | val, info->regs + SARADC2_CONV_CON);
+}
+
+static void rockchip_saradc_start(struct rockchip_saradc *info, int chn)
+{
+	info->data->start(info, chn);
+}
+
+static int rockchip_saradc_read_v1(struct rockchip_saradc *info)
+{
+	return readl_relaxed(info->regs + SARADC_DATA);
+}
+
+static int rockchip_saradc_read_v2(struct rockchip_saradc *info)
+{
+	int offset;
+
+	/* Clear irq */
+	writel_relaxed(0x1, info->regs + SARADC2_END_INT_ST);
+
+	offset = SARADC2_DATA_BASE + info->last_chan->channel * 0x4;
+
+	return readl_relaxed(info->regs + offset);
+}
+
+static int rockchip_saradc_read(struct rockchip_saradc *info)
+{
+	return info->data->read(info);
+}
+
+static void rockchip_saradc_power_down_v1(struct rockchip_saradc *info)
 {
-	/* Clear irq & power down adc */
 	writel_relaxed(0, info->regs + SARADC_CTRL);
 }
 
+static void rockchip_saradc_power_down(struct rockchip_saradc *info)
+{
+	if (info->data->power_down)
+		info->data->power_down(info);
+}
+
 static int rockchip_saradc_conversion(struct rockchip_saradc *info,
 				   struct iio_chan_spec const *chan)
 {
 	reinit_completion(&info->completion);
 
-	/* 8 clock periods as delay between power up and start cmd */
-	writel_relaxed(8, info->regs + SARADC_DLY_PU_SOC);
-
 	info->last_chan = chan;
-
-	/* Select the channel to be used and trigger conversion */
-	writel(SARADC_CTRL_POWER_CTRL
-			| (chan->channel & SARADC_CTRL_CHN_MASK)
-			| SARADC_CTRL_IRQ_ENABLE,
-		   info->regs + SARADC_CTRL);
+	rockchip_saradc_start(info, chan->channel);
 
 	if (!wait_for_completion_timeout(&info->completion, SARADC_TIMEOUT))
 		return -ETIMEDOUT;
@@ -123,7 +192,7 @@ static irqreturn_t rockchip_saradc_isr(int irq, void *dev_id)
 	struct rockchip_saradc *info = dev_id;
 
 	/* Read value */
-	info->last_val = readl_relaxed(info->regs + SARADC_DATA);
+	info->last_val = rockchip_saradc_read(info);
 	info->last_val &= GENMASK(info->last_chan->scan_type.realbits - 1, 0);
 
 	rockchip_saradc_power_down(info);
@@ -163,6 +232,9 @@ static const struct rockchip_saradc_data saradc_data = {
 	.channels = rockchip_saradc_iio_channels,
 	.num_channels = ARRAY_SIZE(rockchip_saradc_iio_channels),
 	.clk_rate = 1000000,
+	.start = rockchip_saradc_start_v1,
+	.read = rockchip_saradc_read_v1,
+	.power_down = rockchip_saradc_power_down_v1,
 };
 
 static const struct iio_chan_spec rockchip_rk3066_tsadc_iio_channels[] = {
@@ -174,6 +246,9 @@ static const struct rockchip_saradc_data rk3066_tsadc_data = {
 	.channels = rockchip_rk3066_tsadc_iio_channels,
 	.num_channels = ARRAY_SIZE(rockchip_rk3066_tsadc_iio_channels),
 	.clk_rate = 50000,
+	.start = rockchip_saradc_start_v1,
+	.read = rockchip_saradc_read_v1,
+	.power_down = rockchip_saradc_power_down_v1,
 };
 
 static const struct iio_chan_spec rockchip_rk3399_saradc_iio_channels[] = {
@@ -189,6 +264,9 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
 	.channels = rockchip_rk3399_saradc_iio_channels,
 	.num_channels = ARRAY_SIZE(rockchip_rk3399_saradc_iio_channels),
 	.clk_rate = 1000000,
+	.start = rockchip_saradc_start_v1,
+	.read = rockchip_saradc_read_v1,
+	.power_down = rockchip_saradc_power_down_v1,
 };
 
 static const struct iio_chan_spec rockchip_rk3568_saradc_iio_channels[] = {
@@ -206,6 +284,28 @@ static const struct rockchip_saradc_data rk3568_saradc_data = {
 	.channels = rockchip_rk3568_saradc_iio_channels,
 	.num_channels = ARRAY_SIZE(rockchip_rk3568_saradc_iio_channels),
 	.clk_rate = 1000000,
+	.start = rockchip_saradc_start_v1,
+	.read = rockchip_saradc_read_v1,
+	.power_down = rockchip_saradc_power_down_v1,
+};
+
+static const struct iio_chan_spec rockchip_rk3588_saradc_iio_channels[] = {
+	SARADC_CHANNEL(0, "adc0", 12),
+	SARADC_CHANNEL(1, "adc1", 12),
+	SARADC_CHANNEL(2, "adc2", 12),
+	SARADC_CHANNEL(3, "adc3", 12),
+	SARADC_CHANNEL(4, "adc4", 12),
+	SARADC_CHANNEL(5, "adc5", 12),
+	SARADC_CHANNEL(6, "adc6", 12),
+	SARADC_CHANNEL(7, "adc7", 12),
+};
+
+static const struct rockchip_saradc_data rk3588_saradc_data = {
+	.channels = rockchip_rk3588_saradc_iio_channels,
+	.num_channels = ARRAY_SIZE(rockchip_rk3588_saradc_iio_channels),
+	.clk_rate = 1000000,
+	.start = rockchip_saradc_start_v2,
+	.read = rockchip_saradc_read_v2,
 };
 
 static const struct of_device_id rockchip_saradc_match[] = {
@@ -221,6 +321,9 @@ static const struct of_device_id rockchip_saradc_match[] = {
 	}, {
 		.compatible = "rockchip,rk3568-saradc",
 		.data = &rk3568_saradc_data,
+	}, {
+		.compatible = "rockchip,rk3588-saradc",
+		.data = &rk3588_saradc_data,
 	},
 	{},
 };
-- 
2.30.2

