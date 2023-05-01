Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFCD6F2F5A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 10:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjEAIoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 04:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjEAIoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 04:44:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5B510E2;
        Mon,  1 May 2023 01:44:15 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D878D66031C9;
        Mon,  1 May 2023 09:44:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682930654;
        bh=vUSYcmRTpasIIy+WikTj0BrypHJmCXBFXT3CHvUXLpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1Sotb+dv7fMJXGyd8Y1FNhinwUu9t4HZHt2jXWROtdydHlblcwftM8S+QYCGLmaK
         RtTPupiZa3x/C/YAI5rmi+e/jndYcQO3e50Q0M9KDB0elVQoAwltQEV8HPpvVNNI8i
         IfIAXzBh+IYb5QPXw0+FUX7Gha0I6Pojp8PRKjFxrYDsbIi6lxdvTBLkEQFcpMASBZ
         MgkETPIftUASRUMWWUv6Q6qpRhU0J6xhJYgAIBvG7us9dKkzugrhJWCqGasGaOXN0s
         ewnFEagXJtYGspAYhMw7gQ3EiaMVu2959dxsGmDNn9Xup54OyRmS8svSwFsEcgR4ZZ
         tpgf2Xy7zksDA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 3/8] nvmem: rockchip-otp: Add clocks and reg_read to rockchip_data
Date:   Mon,  1 May 2023 11:43:55 +0300
Message-Id: <20230501084401.765169-4-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
References: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to support new Rockchip OTP memory devices with different
clock configurations and register layout, extend rockchip_data struct
with the related members: clocks, num_clks, reg_read.

Additionally, to avoid managing redundant driver data, drop num_clks
member from rockchip_otp struct and update all references to point to
the equivalent member in rockchip_data.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/nvmem/rockchip-otp.c | 79 ++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 9f53bcce2f87..a5b234e60735 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -54,21 +54,19 @@
 
 #define OTPC_TIMEOUT			10000
 
+struct rockchip_data {
+	int size;
+	const char * const *clocks;
+	int num_clks;
+	nvmem_reg_read_t reg_read;
+};
+
 struct rockchip_otp {
 	struct device *dev;
 	void __iomem *base;
-	struct clk_bulk_data	*clks;
-	int num_clks;
+	struct clk_bulk_data *clks;
 	struct reset_control *rst;
-};
-
-/* list of required clocks */
-static const char * const rockchip_otp_clocks[] = {
-	"otp", "apb_pclk", "phy",
-};
-
-struct rockchip_data {
-	int size;
+	const struct rockchip_data *data;
 };
 
 static int rockchip_otp_reset(struct rockchip_otp *otp)
@@ -132,29 +130,23 @@ static int rockchip_otp_ecc_enable(struct rockchip_otp *otp, bool enable)
 	return ret;
 }
 
-static int rockchip_otp_read(void *context, unsigned int offset,
-			     void *val, size_t bytes)
+static int px30_otp_read(void *context, unsigned int offset,
+			 void *val, size_t bytes)
 {
 	struct rockchip_otp *otp = context;
 	u8 *buf = val;
-	int ret = 0;
-
-	ret = clk_bulk_prepare_enable(otp->num_clks, otp->clks);
-	if (ret < 0) {
-		dev_err(otp->dev, "failed to prepare/enable clks\n");
-		return ret;
-	}
+	int ret;
 
 	ret = rockchip_otp_reset(otp);
 	if (ret) {
 		dev_err(otp->dev, "failed to reset otp phy\n");
-		goto disable_clks;
+		return ret;
 	}
 
 	ret = rockchip_otp_ecc_enable(otp, false);
 	if (ret < 0) {
 		dev_err(otp->dev, "rockchip_otp_ecc_enable err\n");
-		goto disable_clks;
+		return ret;
 	}
 
 	writel(OTPC_USE_USER | OTPC_USE_USER_MASK, otp->base + OTPC_USER_CTRL);
@@ -174,8 +166,28 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 
 read_end:
 	writel(0x0 | OTPC_USE_USER_MASK, otp->base + OTPC_USER_CTRL);
-disable_clks:
-	clk_bulk_disable_unprepare(otp->num_clks, otp->clks);
+
+	return ret;
+}
+
+static int rockchip_otp_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	struct rockchip_otp *otp = context;
+	int ret;
+
+	if (!otp->data || !otp->data->reg_read)
+		return -EINVAL;
+
+	ret = clk_bulk_prepare_enable(otp->data->num_clks, otp->clks);
+	if (ret < 0) {
+		dev_err(otp->dev, "failed to prepare/enable clks\n");
+		return ret;
+	}
+
+	ret = otp->data->reg_read(context, offset, val, bytes);
+
+	clk_bulk_disable_unprepare(otp->data->num_clks, otp->clks);
 
 	return ret;
 }
@@ -189,8 +201,15 @@ static struct nvmem_config otp_config = {
 	.reg_read = rockchip_otp_read,
 };
 
+static const char * const px30_otp_clocks[] = {
+	"otp", "apb_pclk", "phy",
+};
+
 static const struct rockchip_data px30_data = {
 	.size = 0x40,
+	.clocks = px30_otp_clocks,
+	.num_clks = ARRAY_SIZE(px30_otp_clocks),
+	.reg_read = px30_otp_read,
 };
 
 static const struct of_device_id rockchip_otp_match[] = {
@@ -225,21 +244,21 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 	if (!otp)
 		return -ENOMEM;
 
+	otp->data = data;
 	otp->dev = dev;
 	otp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(otp->base))
 		return PTR_ERR(otp->base);
 
-	otp->num_clks = ARRAY_SIZE(rockchip_otp_clocks);
-	otp->clks = devm_kcalloc(dev, otp->num_clks,
-				     sizeof(*otp->clks), GFP_KERNEL);
+	otp->clks = devm_kcalloc(dev, data->num_clks, sizeof(*otp->clks),
+				 GFP_KERNEL);
 	if (!otp->clks)
 		return -ENOMEM;
 
-	for (i = 0; i < otp->num_clks; ++i)
-		otp->clks[i].id = rockchip_otp_clocks[i];
+	for (i = 0; i < data->num_clks; ++i)
+		otp->clks[i].id = data->clocks[i];
 
-	ret = devm_clk_bulk_get(dev, otp->num_clks, otp->clks);
+	ret = devm_clk_bulk_get(dev, data->num_clks, otp->clks);
 	if (ret)
 		return ret;
 
-- 
2.40.0

