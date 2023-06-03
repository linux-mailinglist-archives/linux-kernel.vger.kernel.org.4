Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966497211A1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 20:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjFCSyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 14:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjFCSyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 14:54:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9C81A8;
        Sat,  3 Jun 2023 11:54:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1E84D6603147;
        Sat,  3 Jun 2023 19:54:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685818474;
        bh=5qal4yReBLe0r8IINy7OGXm+hpHMLxOtRFTpvqe4d8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mpZaRIylG+JEVf4lXivK3l3Y2PgZQLThn9aewLTwnggkUKqVX2+/ms9MAn+EXm87G
         1jcUNMeBXCmRO+HJoH41W67jPPrth3d1aTY3gNbuOF2pm5k6UmHlMfSnfi/UaHU244
         nof49j+6GwwhuYH4tpD8jtMqRxaYVvDldSNraj+/JbMQZwgDi06f1PcFCpltxMZhie
         fGDXXGRw3IqX4UakQB3cG4Z6IghptSHb4Yl8H5O85k8gyex3P3QFaqNkvRkaidyFMG
         qWWoHq5t8D6FBvBeox5xLifhulAkkdOWM4Duc8kwQzpebMLMzCeb1Er+/LdU2Q8yPJ
         5QWAQRIOVuJIg==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        gustavo.padovan@collabora.com, kernel@collabora.com,
        serge.broslavsky@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Simon Xue <xxm@rock-chips.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 2/8] iio: adc: rockchip_saradc: Add support for RK3588
Date:   Sun,  4 Jun 2023 00:23:34 +0530
Message-Id: <20230603185340.13838-3-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230603185340.13838-1-shreeya.patel@collabora.com>
References: <20230603185340.13838-1-shreeya.patel@collabora.com>
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

From: Simon Xue <xxm@rock-chips.com>

Add new start and read functions to support rk3588 device.
Also, add a device compatible string for the same.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Changes in v3
  - Add bitfield.h header file.
  - Add a Reviewed-by tag.

Changes in v2
  - Add a from address.
  - Create separate patches for adding new device support and changes to
    the old device code.
  - Make use of FIELD_PREP.


 drivers/iio/adc/rockchip_saradc.c | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 21f9d92a6af4..312286ec91dc 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2014 ROCKCHIP, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
@@ -38,6 +39,22 @@
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
+#define SARADC2_CONV_CHANNELS GENMASK(15, 0)
+
 struct rockchip_saradc;
 
 struct rockchip_saradc_data {
@@ -76,6 +93,25 @@ static void rockchip_saradc_start_v1(struct rockchip_saradc *info, int chn)
 	       SARADC_CTRL_IRQ_ENABLE, info->regs + SARADC_CTRL);
 }
 
+static void rockchip_saradc_start_v2(struct rockchip_saradc *info, int chn)
+{
+	int val;
+
+	if (info->reset)
+		rockchip_saradc_reset_controller(info->reset);
+
+	writel_relaxed(0xc, info->regs + SARADC_T_DAS_SOC);
+	writel_relaxed(0x20, info->regs + SARADC_T_PD_SOC);
+	val = FIELD_PREP(SARADC2_EN_END_INT, 1);
+	val |= val << 16;
+	writel_relaxed(val, info->regs + SARADC2_END_INT_EN);
+	val = FIELD_PREP(SARADC2_START, 1) |
+	      FIELD_PREP(SARADC2_SINGLE_MODE, 1) |
+	      FIELD_PREP(SARADC2_CONV_CHANNELS, chn);
+	val |= val << 16;
+	writel(val, info->regs + SARADC2_CONV_CON);
+}
+
 static void rockchip_saradc_start(struct rockchip_saradc *info, int chn)
 {
 	info->data->start(info, chn);
@@ -86,6 +122,18 @@ static int rockchip_saradc_read_v1(struct rockchip_saradc *info)
 	return readl_relaxed(info->regs + SARADC_DATA);
 }
 
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
 static int rockchip_saradc_read(struct rockchip_saradc *info)
 {
 	return info->data->read(info);
@@ -248,6 +296,25 @@ static const struct rockchip_saradc_data rk3568_saradc_data = {
 	.power_down = rockchip_saradc_power_down_v1,
 };
 
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
+};
+
 static const struct of_device_id rockchip_saradc_match[] = {
 	{
 		.compatible = "rockchip,saradc",
@@ -261,6 +328,9 @@ static const struct of_device_id rockchip_saradc_match[] = {
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

