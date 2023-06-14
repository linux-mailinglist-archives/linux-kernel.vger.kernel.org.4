Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887E773051E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjFNQhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjFNQgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:36:47 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE92E62;
        Wed, 14 Jun 2023 09:36:43 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id BE29ACFDAF;
        Wed, 14 Jun 2023 16:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1686760570; bh=UYXnMctzgGjbbadSnEuPjVT8RCUV5VfXXmHjVfoOibo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=wA+XiKeBtGN6GMSTX5e1oi7/z6XgDwt7+3jUj29l1ni6lL4w23/jqqkreDk2wcVjE
         MMM1nUFWWd8aqIs4QOh1mPHlb7wo7fP24HvEuwKcGtTTOYCrFqRAMZUyLayI4jQWRb
         HWN1mWmvQn5COg50iKLhBzhlAPZFyqPDpgn5vsPY=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 14 Jun 2023 18:35:48 +0200
Subject: [PATCH v3 2/6] soc: qcom: ocmem: Use dev_err_probe where
 appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v3-2-79da95a2581f@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v3-0-79da95a2581f@z3ntu.xyz>
In-Reply-To: <20230506-msm8226-ocmem-v3-0-79da95a2581f@z3ntu.xyz>
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
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2190; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=UYXnMctzgGjbbadSnEuPjVT8RCUV5VfXXmHjVfoOibo=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkiex1EvDlh0l16NTUdVdGYGuATCym7G2cRt0lj
 SXH0W1bVI+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZInsdQAKCRBy2EO4nU3X
 Vh7rD/9CywBQ8OuCcA8kGTFpjO+zzsF4FW8sLiLeFiL/4/HUqU+0VktLnBbPSDLVS4j4GFPZbNK
 tNlPZ+IMch07xfpPyq8UmSe9K9/Uubocc2PAGhO8zkt25SL406h72GhggPchNvQCmAmpgtQmYsu
 SoBSOnO5SCA7HXFvGu01L4ju1YmA6zfdRIal62/KPNkPHQuF0c78M8hLIroGcLNvvSrPNgXmmrh
 quw7aeZq6hCRb930xBoZpErBdN84PS31VYyt6HpD5Cpkxcxdqj5LoHDoNkOspDOB6BIpBz2Hy1I
 L6uIm2/IwZrRkzp9/x1RnWHQ4xtrUkcsCKJdCptEhvzEvbZ6h1UdgSsWUS4iogm0edEEjO3xjKp
 rNl4b5y6rV1ogwC3x4NuwjATdlmuQSAEVRkCQaImFM42VyMuy5LfQXtyvLPl4Gyf1MqBqv2dA7T
 6YLYyjA6qAjuIqsCPH7rAUSWX2AJ8+kGx19ILL5rbhvdq6exjvc113xTSUK2yIGZ6TD2iNDVwJZ
 fNww2a5gYJSBf9WYKCI1kzKLVmFimDRN+DZhu4/RC+WKinc9b2P4RbsvxWxNmyAewJlSPP3hGG4
 EBYLgafwkGVnRb0pejuWKRd1jddbvG5t//KLIXhYBIH1VFbEtsJKFjTtGV6QfuEOP37F7UKscfS
 nD1M96KnPqsNVpA==
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

Use dev_err_probe in the driver probe function where useful, to simplify
getting PTR_ERR and to ensure the underlying errors are included in the
error message.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/soc/qcom/ocmem.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index ef7c1748242a..462514dfd9e3 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -321,18 +321,13 @@ static int ocmem_dev_probe(struct platform_device *pdev)
 	ocmem->config = device_get_match_data(dev);
 
 	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(ocmem_clks), ocmem_clks);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Unable to get clocks\n");
-
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to get clocks\n");
 
 	ocmem->mmio = devm_platform_ioremap_resource_byname(pdev, "ctrl");
-	if (IS_ERR(ocmem->mmio)) {
-		dev_err(&pdev->dev, "Failed to ioremap ocmem_ctrl resource\n");
-		return PTR_ERR(ocmem->mmio);
-	}
+	if (IS_ERR(ocmem->mmio))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ocmem->mmio),
+				     "Failed to ioremap ocmem_ctrl resource\n");
 
 	ocmem->memory = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						     "mem");
@@ -345,16 +340,14 @@ static int ocmem_dev_probe(struct platform_device *pdev)
 	WARN_ON(clk_set_rate(ocmem_clks[OCMEM_CLK_CORE_IDX].clk, 1000) < 0);
 
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(ocmem_clks), ocmem_clks);
-	if (ret) {
-		dev_info(ocmem->dev, "Failed to enable clocks\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(ocmem->dev, ret, "Failed to enable clocks\n");
 
 	if (qcom_scm_restore_sec_cfg_available()) {
 		dev_dbg(dev, "configuring scm\n");
 		ret = qcom_scm_restore_sec_cfg(QCOM_SCM_OCMEM_DEV_ID, 0);
 		if (ret) {
-			dev_err(dev, "Could not enable secure configuration\n");
+			dev_err_probe(dev, ret, "Could not enable secure configuration\n");
 			goto err_clk_disable;
 		}
 	}

-- 
2.41.0

