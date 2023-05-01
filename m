Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA0B6F2F60
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 10:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjEAIou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 04:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjEAIoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 04:44:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D581010FD;
        Mon,  1 May 2023 01:44:24 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0A4876602F6A;
        Mon,  1 May 2023 09:44:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682930663;
        bh=eFpFeWyImJpFwgodlftFerx7HEWYmMUA01PlcCUlrro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFTI9Pf9U4RPcD9XXPwfu/CVDrBtiM4yD72KEGx3dNlWSaV/qWZxI3W157KB967UO
         ukEVanU1quhqoOsERuxQEs66gOnBHm7bmebpxtFoI5tJZK1jHVb2jXx9c+Zhm4GUpa
         nNi5xD5sY1cO3cBOzyfjlndWGOeVXc4mYK/iT2I21tyff3yLllzBeS8m53RZELmKuY
         u4Gq8DCXieEX3lZJ2C+OlXfVCcrpdrnhs9EZy8DSQnRnuKGHB40O2P27uZqUVp5Ycu
         OOOgfrtb3MJTdWr0JTD6/Ex6xNseScCt9kNJAJcaOWTCc68DRhQ+vpOb4etdlQ0aJl
         J6k3z0sUjXPHw==
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
Subject: [PATCH 6/8] nvmem: rockchip-otp: Improve probe error handling
Date:   Mon,  1 May 2023 11:43:58 +0300
Message-Id: <20230501084401.765169-7-cristian.ciocaltea@collabora.com>
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

Enhance error handling in the probe function by making use of
dev_err_probe(), which ensures the error code is always printed, in
addition to the specified error message.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/nvmem/rockchip-otp.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index b74d98f82ae5..4370d6c5e4e9 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -235,10 +235,8 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 	int ret, i;
 
 	data = of_device_get_match_data(dev);
-	if (!data) {
-		dev_err(dev, "failed to get match data\n");
-		return -EINVAL;
-	}
+	if (!data)
+		return dev_err_probe(dev, -EINVAL, "failed to get match data\n");
 
 	otp = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_otp),
 			   GFP_KERNEL);
@@ -249,7 +247,8 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 	otp->dev = dev;
 	otp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(otp->base))
-		return PTR_ERR(otp->base);
+		return dev_err_probe(dev, PTR_ERR(otp->base),
+				     "failed to ioremap resource\n");
 
 	otp->clks = devm_kcalloc(dev, data->num_clks, sizeof(*otp->clks),
 				 GFP_KERNEL);
@@ -261,18 +260,22 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 
 	ret = devm_clk_bulk_get(dev, data->num_clks, otp->clks);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to get clocks\n");
 
 	otp->rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(otp->rst))
-		return PTR_ERR(otp->rst);
+		return dev_err_probe(dev, PTR_ERR(otp->rst),
+				     "failed to get resets\n");
 
 	otp_config.size = data->size;
 	otp_config.priv = otp;
 	otp_config.dev = dev;
-	nvmem = devm_nvmem_register(dev, &otp_config);
 
-	return PTR_ERR_OR_ZERO(nvmem);
+	nvmem = devm_nvmem_register(dev, &otp_config);
+	if (IS_ERR(nvmem))
+		return dev_err_probe(dev, PTR_ERR(nvmem),
+				     "failed to register nvmem device\n");
+	return 0;
 }
 
 static struct platform_driver rockchip_otp_driver = {
-- 
2.40.0

