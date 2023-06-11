Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A167E72B22E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjFKOEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjFKOEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:04:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612E5E7C
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f7fc9014fdso24723985e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492235; x=1689084235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkkYoGg7O7g8BuRI7isftewyd52BKcFbodz8lfEfrU4=;
        b=YN8DyzS+ZrSaiXqczhEpxt2mAkjYgIti/f/+MDWyuYdUg2Ehat2zDGjlQ408b9V35N
         Bmy80cu2kk40DHSX/Kxksv7Ansap9jGqxSFou1pGmDdSJhnQ81z4F/YmabIY+06buipu
         Z8gnpk1SnyOVFLpNAoJQR0fUAtVRt9+dI2pxSv7CQG3jktVKcf0gzPUIXcvMz3Z0dJ9A
         hlRoEW2U9UMxqEqFSQbrZIPs8jN2OJ1l/KMppFfYkefefHg3KmBm4dRPx78BKwvl0bBy
         3fGj6aTPXhqjDymRC+0pU0oDBp0aEBj6Zp4q1jRZEazSegnPev4Es4kWBvunbJTX1SBQ
         gwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492235; x=1689084235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkkYoGg7O7g8BuRI7isftewyd52BKcFbodz8lfEfrU4=;
        b=CZjVhmXYw9iKYYPXR1XpIOCaCdjPZd9G7HfCioFuudj2zcMNWs6N+a2WpW5x6CHM8K
         sNJrFSOXUP6Kf2+mDN0uxNRORtV+P/KgsColC+DwR9chVV8wZa6VyIiG0ROVxUbIoBOC
         lMVSaz34kflkyuxvhW8lPU2AxUmYoAbiyU5sB5AoRYG23lwyd1sMowMhI624OyqELL0h
         Z9VuSHBszhPRLGqKt4tmEUd0GnRv/8SElLGudiGzbOQfWhPpn9V4sHs1m4eawb1Uyiv0
         HDBCHx9EkryY8AUXLXGYv5zWF40pJtKq+gcSX+o1xViMj7Kvm/ZxguF9YDINUyetX+2R
         4mHA==
X-Gm-Message-State: AC+VfDw79M1Am0scJIz/VqqqotdWlcroc31BChGkxGfew8v5n6UmEXrW
        cI0PFWGPmXqi7wsLr0tXI7/KFnZSTxmGG96aCEs=
X-Google-Smtp-Source: ACHHUZ7rVZqy/vg/k6u+pYYYAWnHdu/6pckM6le3cmNPc9ihvqRBxrm8yScJe9njj9uyRo98n2huNw==
X-Received: by 2002:a1c:ed15:0:b0:3f7:f584:579d with SMTP id l21-20020a1ced15000000b003f7f584579dmr4850036wmh.0.1686492235769;
        Sun, 11 Jun 2023 07:03:55 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:03:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/26] nvmem: rockchip-otp: Add clks and reg_read to rockchip_data
Date:   Sun, 11 Jun 2023 15:03:13 +0100
Message-Id: <20230611140330.154222-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

In preparation to support new Rockchip OTP memory devices with different
clock configurations and register layout, extend rockchip_data struct
with the related members: clks, num_clks, reg_read.

Additionally, to avoid managing redundant driver data, drop num_clks
member from rockchip_otp struct and update all references to point to
the equivalent member in rockchip_data.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Vincent Legoll <vincent.legoll@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rockchip-otp.c | 79 ++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 9f53bcce2f87..b5a84b379da4 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -54,21 +54,19 @@
 
 #define OTPC_TIMEOUT			10000
 
+struct rockchip_data {
+	int size;
+	const char * const *clks;
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
+	.clks = px30_otp_clocks,
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
+		otp->clks[i].id = data->clks[i];
 
-	ret = devm_clk_bulk_get(dev, otp->num_clks, otp->clks);
+	ret = devm_clk_bulk_get(dev, data->num_clks, otp->clks);
 	if (ret)
 		return ret;
 
-- 
2.25.1

