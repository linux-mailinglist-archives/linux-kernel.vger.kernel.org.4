Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C126F97F3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 11:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjEGJOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 05:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjEGJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 05:14:01 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F263E18DC5;
        Sun,  7 May 2023 02:13:45 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 2CF0FCED42;
        Sun,  7 May 2023 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683450782; bh=7KtnS7Z+etOjmKrOyowpeMfEieUCur9/xBWzDiV//qM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=oFZt2cFig6qgSnBk2+zaN8QNc6lgs1R7D3YHe8UoE7TMByAcU+R6mtQD8T3iKl9ss
         ROapqefpVN4YZq2D+QuotC0hTyHCWcBQTdLAeOS18M1rVUdjTwMOKOjDR0dTlpftwu
         On0CQT0ZR/DNypgZ3ZUgri0DCa44YDdN/gFKKhtA=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 07 May 2023 11:12:20 +0200
Subject: [PATCH 3/6] soc: qcom: ocmem: make iface clock optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v1-3-3e24e2724f01@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
In-Reply-To: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3377; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=7KtnS7Z+etOjmKrOyowpeMfEieUCur9/xBWzDiV//qM=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkV2uZ0+L8JdjISj+5P1ZXupY/dHokPjna72Ot7
 sNVXd2PtB2JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZFdrmQAKCRBy2EO4nU3X
 VgcREACUq7S1p9RsFUHU5Iny4N3ctDjH3jdSBvkmpF2wkDw/Xq2iSwNxXyodKttmnjcGSxqXoDy
 R9Qq8VwEg2Rg8uClBJbxdwHUI/T1KM9+fJdvP8AwgyX9i6kgeBhlsmiRLEqs72zBkCf75vCfA+L
 B1toXx12VTlXCjJXBI84THzbD5dUASoh+Mh+z/EJyCJDwGm+PnAUoWot+fcJ5ImY/USMAD8Rs47
 kUNA6P1agnLQcHcqzC3+3jFr/9Y9TEO40cUT2imaYLV/jx5YZ0K79JmKXiW04SaTyOSBAjb8rwY
 KRi5mj3c+UAIHY4PTFCHSrGBDBbjeePguWYmQCFGRrL38EoJnEHNhoKlPRCGpb16cUo55kYiWck
 k3mcr7sUZDMmLyLS2tbH36zFRtlx96NLM/Ppr1e4SmYAMThEMysQUsPv/P7rOb+hlBK7Ur64bSV
 4qfOxf/rvCxK/inU8ejBKXzntXSEo88e+b4cQSLrbNyUCQPEBuLq/EUzD8ycn8HT2+en4q+qtHr
 nh+TMDQrsh1LgKYNHSXCyNs1fn6Jr6vjlrRCAChzJPc2XJfVTNfOmFXUJctUusv1RHu9DvuYE4A
 nEjd0qBRRo627Z9q5B4bevrGGXfVj2Jk5SQCnR3m2O1JYHH/J230pBu2wLvrUWVPeUA6OGLQhSx
 eFSIRAGajsBSQ7A==
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

