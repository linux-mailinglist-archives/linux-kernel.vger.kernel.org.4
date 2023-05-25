Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BE4711910
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbjEYV2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjEYV2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:28:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C2819A;
        Thu, 25 May 2023 14:28:01 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 056FD6606E81;
        Thu, 25 May 2023 22:27:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685050080;
        bh=jsynsw/ZbWVC0ttTQiwGX9l8Q++CdnsiAIG6M4Z8nRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nuCe0J0MsiSf6bFs8VW2iuq7HIenCb9alpkzMD4x6wwVGufdHwvXEYecDAZKz8B0n
         cVfiAtUDi5x31x6tTBlbUXL8pWVlQkWpPps14DllNKabi4Btrocm+jT1zJi7vKT8q1
         XgqsgcAMMXAnodxWdcw9feelnBcLA2fh6SeWCczmgYBwulT9Ni8+Hcpf9Ct0uPqg8u
         9bHzc0ALXZ3FqmR+hI8j2q0+ZAgmoAkXo39oz4YhCPb+eyoGnD49aBIc7gknRO+7A0
         Edo1XSBUdkcST0SD6LkCKp10Wp1Y46oNd87xeahGmph1jHdJnmgn9tlC70k31VoMTj
         dAReny5cei1Qw==
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
Subject: [PATCH v2 1/8] iio: adc: rockchip_saradc: Add callback functions
Date:   Fri, 26 May 2023 02:57:05 +0530
Message-Id: <20230525212712.255406-2-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525212712.255406-1-shreeya.patel@collabora.com>
References: <20230525212712.255406-1-shreeya.patel@collabora.com>
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

Add start, read and power_down callback functions,
which will help in adding new rockchip device support
cleanly.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---

Changes in v2
  - Add a from address.
  - Create a separate patch for changes done in the code for old
    devices.

 drivers/iio/adc/rockchip_saradc.c | 64 +++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 79448c5ffc2a..21f9d92a6af4 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -38,10 +38,15 @@
 #define SARADC_TIMEOUT			msecs_to_jiffies(100)
 #define SARADC_MAX_CHANNELS		8
 
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
@@ -60,27 +65,50 @@ struct rockchip_saradc {
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
@@ -123,7 +151,7 @@ static irqreturn_t rockchip_saradc_isr(int irq, void *dev_id)
 	struct rockchip_saradc *info = dev_id;
 
 	/* Read value */
-	info->last_val = readl_relaxed(info->regs + SARADC_DATA);
+	info->last_val = rockchip_saradc_read(info);
 	info->last_val &= GENMASK(info->last_chan->scan_type.realbits - 1, 0);
 
 	rockchip_saradc_power_down(info);
@@ -163,6 +191,9 @@ static const struct rockchip_saradc_data saradc_data = {
 	.channels = rockchip_saradc_iio_channels,
 	.num_channels = ARRAY_SIZE(rockchip_saradc_iio_channels),
 	.clk_rate = 1000000,
+	.start = rockchip_saradc_start_v1,
+	.read = rockchip_saradc_read_v1,
+	.power_down = rockchip_saradc_power_down_v1,
 };
 
 static const struct iio_chan_spec rockchip_rk3066_tsadc_iio_channels[] = {
@@ -174,6 +205,9 @@ static const struct rockchip_saradc_data rk3066_tsadc_data = {
 	.channels = rockchip_rk3066_tsadc_iio_channels,
 	.num_channels = ARRAY_SIZE(rockchip_rk3066_tsadc_iio_channels),
 	.clk_rate = 50000,
+	.start = rockchip_saradc_start_v1,
+	.read = rockchip_saradc_read_v1,
+	.power_down = rockchip_saradc_power_down_v1,
 };
 
 static const struct iio_chan_spec rockchip_rk3399_saradc_iio_channels[] = {
@@ -189,6 +223,9 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
 	.channels = rockchip_rk3399_saradc_iio_channels,
 	.num_channels = ARRAY_SIZE(rockchip_rk3399_saradc_iio_channels),
 	.clk_rate = 1000000,
+	.start = rockchip_saradc_start_v1,
+	.read = rockchip_saradc_read_v1,
+	.power_down = rockchip_saradc_power_down_v1,
 };
 
 static const struct iio_chan_spec rockchip_rk3568_saradc_iio_channels[] = {
@@ -206,6 +243,9 @@ static const struct rockchip_saradc_data rk3568_saradc_data = {
 	.channels = rockchip_rk3568_saradc_iio_channels,
 	.num_channels = ARRAY_SIZE(rockchip_rk3568_saradc_iio_channels),
 	.clk_rate = 1000000,
+	.start = rockchip_saradc_start_v1,
+	.read = rockchip_saradc_read_v1,
+	.power_down = rockchip_saradc_power_down_v1,
 };
 
 static const struct of_device_id rockchip_saradc_match[] = {
-- 
2.30.2

