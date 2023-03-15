Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6148F6BA826
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjCOGoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjCOGoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:44:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE86A311FA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:43:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so824884pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678862619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amLlMnvqqV/ACQXsqFtaJlfI0hCQH92ixpD+YcVSgsE=;
        b=jKLK4gVYLPa9G9JyxIK2GAbQZu1DEgACJv9GKniPZJ8zx/Nn1vf+fBghOhS5cvY7j3
         sU/UStylKkS4BvaPZ7Q7qNWkduvNyFoKgawVGO1EQMvdRfEUsJS8cQlR3WrS1vJbrbOC
         GKskZijBdd3WiXs4cjHaCFvBW2eSRhs6/EtB/QinxocpVFwXD9Eix3iIBMj7UptuUctm
         uushCDonH9UILg1yGtkIMU0P0jPMA0G+ePCdBS8mmghPBU6s+SLadNftMujs8qezU9wt
         FZ0u50Fqbdk/vAQdFzIk+HLM6a9Q3juKW8Y4bx1+wfS9Rh/Dg/Ud86uz3mFJ5OY+SDoJ
         8hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678862619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amLlMnvqqV/ACQXsqFtaJlfI0hCQH92ixpD+YcVSgsE=;
        b=K5D2bHb8LWFFxNSlbUc9PlQjQdqOwEqbzL83AdWfEc1DIAsduO46Ve6dNn9hCpRlzz
         4RGOx42PDJJc7vI10BKsoEd5y5tE2T/U/p3Hx+vhOXaL72RlSNbaXl3X8iaxqVyq4iOB
         Q6VwZBW82lj1F8XlG98MWOoYqwCbFl85Ia05TdFmuKSOKbO51otOnhDFOj0utCiFgTHE
         eOYSRrLEnYE62/Sus8o0N6vPM+eWk1bMfnYzenpZvDRb+Chs5/Z2LPH8Yl8ljtynstD7
         Fu/6Py/Ri/groi9v1s1UYy0cPof4E571YTQzLXYcA3+emsMx7M5i/4pq/uYjAy4/ugUI
         zKfQ==
X-Gm-Message-State: AO0yUKXG97KSWFzbQ0DnyYhq/yxYa8X+fkg0IO+uBMtC6TKKWHndN1c0
        MTzXYILkheu0RLVo6q8oRY8w
X-Google-Smtp-Source: AK7set/OLIL0dlm3soaelmkE4HF6q7PL0oGAawIHO4a8Rp8pUmo7GtCxOutkAqfjtGCDGxKI1ZmtWg==
X-Received: by 2002:a17:902:dac8:b0:1a0:763f:2445 with SMTP id q8-20020a170902dac800b001a0763f2445mr1914923plx.11.1678862619159;
        Tue, 14 Mar 2023 23:43:39 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.35])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a6a8400b002367325203fsm550747pjj.50.2023.03.14.23.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 23:43:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 08/18] PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.2
Date:   Wed, 15 Mar 2023 12:12:45 +0530
Message-Id: <20230315064255.15591-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
References: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the clocks are enabled and disabled at the same time. So the bulk clock
APIs can be used to handle them together. This simplifies the code a lot.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 72 ++++++--------------------
 1 file changed, 15 insertions(+), 57 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0bb27d3c95a0..939973733a1e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -162,12 +162,10 @@ struct qcom_pcie_resources_2_1_0 {
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
 };
 
-#define QCOM_PCIE_2_3_2_MAX_SUPPLY	2
+#define QCOM_PCIE_2_3_2_MAX_CLOCKS		4
+#define QCOM_PCIE_2_3_2_MAX_SUPPLY		2
 struct qcom_pcie_resources_2_3_2 {
-	struct clk *aux_clk;
-	struct clk *master_clk;
-	struct clk *slave_clk;
-	struct clk *cfg_clk;
+	struct clk_bulk_data clks[QCOM_PCIE_2_3_2_MAX_CLOCKS];
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
 };
 
@@ -539,21 +537,14 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
 	if (ret)
 		return ret;
 
-	res->aux_clk = devm_clk_get(dev, "aux");
-	if (IS_ERR(res->aux_clk))
-		return PTR_ERR(res->aux_clk);
-
-	res->cfg_clk = devm_clk_get(dev, "cfg");
-	if (IS_ERR(res->cfg_clk))
-		return PTR_ERR(res->cfg_clk);
-
-	res->master_clk = devm_clk_get(dev, "bus_master");
-	if (IS_ERR(res->master_clk))
-		return PTR_ERR(res->master_clk);
+	res->clks[0].id = "aux";
+	res->clks[1].id = "cfg";
+	res->clks[2].id = "bus_master";
+	res->clks[3].id = "bus_slave";
 
-	res->slave_clk = devm_clk_get(dev, "bus_slave");
-	if (IS_ERR(res->slave_clk))
-		return PTR_ERR(res->slave_clk);
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -562,11 +553,7 @@ static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
 
-	clk_disable_unprepare(res->slave_clk);
-	clk_disable_unprepare(res->master_clk);
-	clk_disable_unprepare(res->cfg_clk);
-	clk_disable_unprepare(res->aux_clk);
-
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
@@ -583,43 +570,14 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(res->aux_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable aux clock\n");
-		goto err_aux_clk;
-	}
-
-	ret = clk_prepare_enable(res->cfg_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable cfg clock\n");
-		goto err_cfg_clk;
-	}
-
-	ret = clk_prepare_enable(res->master_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable master clock\n");
-		goto err_master_clk;
-	}
-
-	ret = clk_prepare_enable(res->slave_clk);
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
 	if (ret) {
-		dev_err(dev, "cannot prepare/enable slave clock\n");
-		goto err_slave_clk;
+		dev_err(dev, "cannot prepare/enable clocks\n");
+		regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
+		return ret;
 	}
 
 	return 0;
-
-err_slave_clk:
-	clk_disable_unprepare(res->master_clk);
-err_master_clk:
-	clk_disable_unprepare(res->cfg_clk);
-err_cfg_clk:
-	clk_disable_unprepare(res->aux_clk);
-
-err_aux_clk:
-	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
-
-	return ret;
 }
 
 static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
-- 
2.25.1

