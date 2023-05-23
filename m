Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D297E70E6FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbjEWU41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbjEWU4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:56:25 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7E6E46;
        Tue, 23 May 2023 13:55:53 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1D8F0CFBBD;
        Tue, 23 May 2023 20:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684875320; bh=KbyN660P4K9nXZQ1uRPCzoYIz9+m7zFQSZkHmEEPGaw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=QTR7zoe3edw+1NnWiN68jjpa/etlAj/tvj0gcD8+tF0V67Yc44WeLtx9NzLDdUdyG
         OrkcdojcFGMMJ9WKHMTRLWmM5ybmEHUdo9av+y8GuirOWp3Hp+gLIVccsCzj9IK7Ma
         cIxECV5hKrXQU9dl12XwY8JZXFnoc8ls7FY41Ths=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 23 May 2023 22:55:10 +0200
Subject: [PATCH v2 3/6] soc: qcom: ocmem: make iface clock optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v2-3-177d697e43a9@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz>
In-Reply-To: <20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3432; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=KbyN660P4K9nXZQ1uRPCzoYIz9+m7zFQSZkHmEEPGaw=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkbSgyRTnZM3H5u4pMaBwi7IpVq0Wll25i/4497
 qr8wpmLne2JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZG0oMgAKCRBy2EO4nU3X
 VktQEACfUvu7M189YLfnMWagUJPnYZEXeChN2/F3H8GtZwUxS1w6HlFvRB6EuRMbkTQ+2YyDsre
 QXV/F7bywppTH4ShrGckIYBuOHdTzFViXOvuNz/0OaL92T9yxubIv3kfXrwt26Qnz2zYJAppve4
 qEbGo5/xhqfmzBUBQELzwg6hmHg6s8lVQ8scQJecvW0+NmrQk44cJ1KHHoZ9RmsVNXf0naDyk+S
 KgPa7oTW2rUjd9u4V7C2OKJX1c2htUo6ucEU2VNdevMGfjNGmsPBRHaJSFTcin+pSbgmmHM5wwh
 /S5yYgb3Jl8RwpBI5SctdFFSyjI1vrYdfYrhQwQvVovxlE5lU8vS8iUk6FA62gocMKab2WUGzwQ
 EqJzANheNdRBApZVTqJVFieibtSDgVBxEXZFDWjAR1caKg9JaXF4w1OaO2Nj6in44UfqTgjnCho
 HTxeSgUFzYd2pjKgeK2nevN2z7y1r4lQk8IHnKEAMGe4bJi1X2+nsPbgSSzrsuvgdTwJsY+m3C0
 RGM6h4YkmknI3ZSmZctd9Zu5WPcbmoQmVRCKg3VECfJKO1lWsPpmN8nvgj7BEN2Zjj0DI5Ad3Wq
 OXzJPil74rkMB7MPvSsX3LtEduq669HxNou3ayIbLHoDUFUz6dcXI+j912yJ2cj5zNc01yp2WXn
 lBz0kbIz/mLjIug==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms such as msm8226 do not have an iface clk. Since clk_bulk
APIs don't offer to a way to treat some clocks as optional simply add
core_clk and iface_clk members to our drvdata.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/soc/qcom/ocmem.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index a11a955a1327..6235065d3bc9 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -54,6 +54,8 @@ struct ocmem {
 	const struct ocmem_config *config;
 	struct resource *memory;
 	void __iomem *mmio;
+	struct clk *core_clk;
+	struct clk *iface_clk;
 	unsigned int num_ports;
 	unsigned int num_macros;
 	bool interleaved;
@@ -91,16 +93,6 @@ struct ocmem {
 #define OCMEM_PSGSC_CTL_MACRO2_MODE(val)	FIELD_PREP(0x00000700, (val))
 #define OCMEM_PSGSC_CTL_MACRO3_MODE(val)	FIELD_PREP(0x00007000, (val))
 
-#define OCMEM_CLK_CORE_IDX			0
-static struct clk_bulk_data ocmem_clks[] = {
-	{
-		.id = "core",
-	},
-	{
-		.id = "iface",
-	},
-};
-
 static inline void ocmem_write(struct ocmem *ocmem, u32 reg, u32 data)
 {
 	writel(data, ocmem->mmio + reg);
@@ -316,9 +308,15 @@ static int ocmem_dev_probe(struct platform_device *pdev)
 	ocmem->dev = dev;
 	ocmem->config = device_get_match_data(dev);
 
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(ocmem_clks), ocmem_clks);
-	if (ret)
-		return dev_err_probe(dev, ret, "Unable to get clocks\n");
+	ocmem->core_clk = devm_clk_get(dev, "core");
+	if (IS_ERR(ocmem->core_clk))
+		return dev_err_probe(dev, PTR_ERR(ocmem->core_clk),
+				     "Unable to get core clock\n");
+
+	ocmem->iface_clk = devm_clk_get_optional(dev, "iface");
+	if (IS_ERR(ocmem->iface_clk))
+		return dev_err_probe(dev, PTR_ERR(ocmem->iface_clk),
+				     "Unable to get iface clock\n");
 
 	ocmem->mmio = devm_platform_ioremap_resource_byname(pdev, "ctrl");
 	if (IS_ERR(ocmem->mmio))
@@ -333,11 +331,15 @@ static int ocmem_dev_probe(struct platform_device *pdev)
 	}
 
 	/* The core clock is synchronous with graphics */
-	WARN_ON(clk_set_rate(ocmem_clks[OCMEM_CLK_CORE_IDX].clk, 1000) < 0);
+	WARN_ON(clk_set_rate(ocmem->core_clk, 1000) < 0);
+
+	ret = clk_prepare_enable(ocmem->core_clk);
+	if (ret)
+		return dev_err_probe(ocmem->dev, ret, "Failed to enable core clock\n");
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(ocmem_clks), ocmem_clks);
+	ret = clk_prepare_enable(ocmem->iface_clk);
 	if (ret)
-		return dev_err_probe(ocmem->dev, ret, "Failed to enable clocks\n");
+		return dev_err_probe(ocmem->dev, ret, "Failed to enable iface clock\n");
 
 	if (qcom_scm_restore_sec_cfg_available()) {
 		dev_dbg(dev, "configuring scm\n");
@@ -396,13 +398,17 @@ static int ocmem_dev_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk_disable:
-	clk_bulk_disable_unprepare(ARRAY_SIZE(ocmem_clks), ocmem_clks);
+	clk_disable_unprepare(ocmem->core_clk);
+	clk_disable_unprepare(ocmem->iface_clk);
 	return ret;
 }
 
 static int ocmem_dev_remove(struct platform_device *pdev)
 {
-	clk_bulk_disable_unprepare(ARRAY_SIZE(ocmem_clks), ocmem_clks);
+	struct ocmem *ocmem = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(ocmem->core_clk);
+	clk_disable_unprepare(ocmem->iface_clk);
 
 	return 0;
 }

-- 
2.40.1

