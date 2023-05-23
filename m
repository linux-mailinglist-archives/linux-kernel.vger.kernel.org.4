Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D22E70E6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbjEWU4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjEWU4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:56:20 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D82FA;
        Tue, 23 May 2023 13:55:52 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 56C70CFBBC;
        Tue, 23 May 2023 20:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684875320; bh=T7XDh+PO9dz+QnCgA9kCzxLQh8WK3LvPi+JrZSIZVdM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=uSaa0LDPK97B2K7JfZBJuPf2Jl4BLU6Iy34vxzxaplWorAAIDL6aeXgKBCnYLfhDU
         mp8K1S5QsFB3zQlDlYXdTWiGfCq6U10NGpmA6aQaeAuXqLv4xxILBE9Ml1FFdQHYWn
         Pq/pX4oTx8gw7yZ21h5P4i+y+zxwhFk4JUCgSjzk=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 23 May 2023 22:55:09 +0200
Subject: [PATCH v2 2/6] soc: qcom: ocmem: Use dev_err_probe where
 appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v2-2-177d697e43a9@z3ntu.xyz>
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
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2190; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=T7XDh+PO9dz+QnCgA9kCzxLQh8WK3LvPi+JrZSIZVdM=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkbSgx9V7M2s527/6rSs9yPhD1WsiYQgMBAowr0
 BoqKZfJNmCJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZG0oMQAKCRBy2EO4nU3X
 VtIuD/9ESmXVIvHIGHlB1n0fs1ZmpGXzehXi5J+TxUR1hBIdvq6eQjOZj+jCkprY3RUQiJfpVH5
 3MUvvXejF69hfz3JJyfnDp9MFrg0w9pY11WNNWEpszES3bhCXJmKUNaENiYP4dWgTDfMdGw0OuO
 GG/OPwaNSTopWq/j2TWB7zMxCF1ZKA19WWvKlv60ayJbGGb9b92iYyudYy29w5iNLEQg0t36pvm
 foePjPNjyiQpnQShnrVVqONpIySZuoNqeWLJpz4rK4uz8l8b0vFORWBhT/KOlK7/SbtaRPp6Lzs
 2rTWUupANI+nnraOpcKPofBJ39n1MLt36EBhU35HKrsPb0OG2FNrsuFAVKydQayB7NeOM3jiaDI
 v8vkHPBgDSEmv3AeOIuOw3Rci/HrvCRN83oTLzzbejke6dwLufM5R4AyH82eHsBYdwIOZo2TSzb
 F25r3c9/56O/e1jTVAqrfGXEaL+ZSI7kmpYEiOODyQkEaW/U80WDGIS6WRDBFDDI6QXTrnyC44z
 xWK6MrGebNrlSOtfvS1ZlRu/FatVMX5sRtst4C6KdRN1tRbjADHtzHBoFHDVPkJ/Urd0a7khHGw
 dSNa/rCFUOaCaaSOvbrmh2w3thQadvxflHmHMqUL1Y094BGkU/8lUuIGnD3h7D4Ac/y3eUcNERF
 9iAJRpUsSFsVDQw==
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

