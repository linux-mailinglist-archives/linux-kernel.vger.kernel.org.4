Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA96F7736
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjEDUj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjEDUjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:39:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CED19D4C;
        Thu,  4 May 2023 13:33:34 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 60EA866056FF;
        Thu,  4 May 2023 21:07:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683230834;
        bh=liP+soMrPQDOXxG2SMtxGxRaMcIPp5ZaL+QpnsunI+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mog/gRj1ztd5K51jKBGYdqmuisZiPHDnvVb5L5W0/NkdTgORXgtK2QJ29Rov0kYQP
         7dcSIu/NYIixTxqqAaljb1XMfnBGfY5giCriXv+sKPrVy0FfRtSlABBG9X8tysw5yZ
         8wzCHbvT9l84lc5cq96B4ax0XwxlClSGkBhmbky+fYLVTcNVvMdxwI0s2Xv/pc3TfL
         K0I8AhLvAzIKIHdacgqJY3n5wbpa0QukcYmipZbefRAy66o8fCaunv8MVGT4zXdwdQ
         bXTmiTONhmJe8jZE2dK4Bfn8YxjtEh3erIyoZewTqSWDafVguO4i2M0/4iPuM4Uybf
         57OYJEmZ9UVkg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Vincent Legoll <vincent.legoll@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 6/8] nvmem: rockchip-otp: Improve probe error handling
Date:   Thu,  4 May 2023 23:06:46 +0300
Message-Id: <20230504200648.1119866-7-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
References: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
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

Enhance error handling in the probe function by making use of
dev_err_probe(), which ensures the error code is always printed, in
addition to the specified error message.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Vincent Legoll <vincent.legoll@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/nvmem/rockchip-otp.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 439aea1f8874..84bf956cc4e1 100644
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

