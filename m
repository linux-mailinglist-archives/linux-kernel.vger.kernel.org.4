Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29BC6F97E9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 11:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjEGJNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 05:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjEGJNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 05:13:05 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9D293E2;
        Sun,  7 May 2023 02:13:04 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id DEF16CECD0;
        Sun,  7 May 2023 09:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683450782; bh=E9biyDI0DLfbEBqzwl+YBfznH2gNa4Wog6B7dyC2CpE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=rochLcLlq/GwnKaGjqG6zMTk2CtFbnQ7KW2dDmmbooN/YmigA3DVS5t/dFGhhaDqG
         N9/rLuJCGyUE2NEfaaby4oXzmQp5FE7ATaBjZmzz0rC6apDNV6HhiAIEX14BwGTCTu
         NTTa7U2oRejkiBoRW47UEaQcdXfNHf9+I59cBGg4=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 07 May 2023 11:12:19 +0200
Subject: [PATCH 2/6] soc: qcom: ocmem: Use dev_err_probe where appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v1-2-3e24e2724f01@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2078; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=E9biyDI0DLfbEBqzwl+YBfznH2gNa4Wog6B7dyC2CpE=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkV2uYkTqSmoNdinvDWXQg0A55V40l2a/IxNNBx
 WB7YuikTkmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZFdrmAAKCRBy2EO4nU3X
 Vi/JD/9ZcJj/mqviz3iy/mdm570hSsWfyw80mEYheJnimMGcsgckJK7Or5uJzTGgPCetG9dxHOM
 McYB33PT5yiHMvAG2XHBmVvOSdlrZEniHGVNMhVBMS2ogcd/i7MUEkJhuNxPk0Y3tX3RDBYgWQ3
 W9lje/OcxPtfjCYm5Yg75qaJ1Mx+LIOGw78rKIjtwMTi5iFQKLVRU3SUw9OS0Bnm1ANjXa0VjPu
 uy+HxU8heH5GEMJ/aENf2VJ1DZJWwOoh3RSfJL3M6w4jD5vMqxu9F1b1g/CJCGpZ/FgA4OAyg0V
 EPXmtzXitaklNNCVUA/O/cYdkpaCYMSDGvx77xWZk0xwHeWNcG6NajA7J4qDGhej4XZmKT8Owih
 THxQJLa/NumrMYPZ+rlb5W16KMdpBGUtaTazI36YdKNEg2yectgukCnjbPQyyWYnAtpyrADFil0
 SH5uYu5wmZY6LRwUfEdHgpEsNf6Oo13Aw9ZgmWNwR3ohjnol7KOLg41shkkic0wwaGkyztFzefl
 8AqNauuF6oH16tQiWBgEMnxTLUiwzrsUTp54bPHOA7JTdcWgi/LF60QIM6WMhyBair97HMDiaxo
 OynDMpiFtto7xy8ZFfGszYG8tIoSBy2mIQmq3duK9CeCSv90eSMXJsAh04OJBUBgtTOBYrrlM2f
 LwSuQTNOOk0HMfw==
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

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/soc/qcom/ocmem.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index c3e78411c637..a11a955a1327 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -317,18 +317,13 @@ static int ocmem_dev_probe(struct platform_device *pdev)
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
@@ -341,16 +336,14 @@ static int ocmem_dev_probe(struct platform_device *pdev)
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
2.40.1

