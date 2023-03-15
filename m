Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8E36BA832
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjCOGol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjCOGoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:44:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC977ABA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:43:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x11so18986906pln.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678862627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBoZXs7oWaG22XZASLiUsiWHjHyRIoI/eDEhjgIXc7Q=;
        b=JFASvWIhHeDbBo+WCQzzqwSgjh7K6BSUVYNxE6SIJetiiutCr0065wuVFoFx9M5Ttf
         V7cWeoix2msdqY9iWtHb1LcF1uH7cUQkWuICqTwC1Ko5uaZMDhgZlw4nUC/R88Er0Fyp
         cEslWv2eWR5u6g/C3Gk11sEzMhGhqr2bhUaw7HQXoHLQxk4cIDql5vfoLnt6i6N0OdJm
         yDBXH3Vsd80Y+gEbjd5MVZSus63KYyOm90XA2ga4vqpv8s/bAro9Ci8NAB7jJ6Elzs0y
         dwmcFI9CVNNi+//rB/FkuFsAnA6gXnPgsArKLfBsR5lmDCgywyHagUX5FxmQK/4swDfR
         xrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678862627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBoZXs7oWaG22XZASLiUsiWHjHyRIoI/eDEhjgIXc7Q=;
        b=t0pfbHuqUDKefiQjp4z9zRAZY1hrUnaKYJ3R3ZCF7BZiZ3SphIssdG9JDvAYOmo3BM
         6NgL/rmnUSTMNQSgYwQqpXYl0W92Dq1mE7FDy8xVO6nfltqTKGQlEevqIbA4z9PJxUbd
         gurTcCw0odPTtaMmJYCRKlXTUJTfZv4KMyfHP+QDLdqpy98eLXf8J1kHW5PiEIbPAF7A
         U0viWF/WAMa3aC0ZDiDhjVUvXHNitfpvhmLluJNsZmiTuLEmFzstfHxM9vvrNcyS8z9g
         Dl7k3N6STyaAK6dJaU136+eSAKPoGbqoqNeAg8ZB2BZRz6MSUXsList6D+dKSFQX8xxg
         VOKQ==
X-Gm-Message-State: AO0yUKXF18z7wtFj4SSDXBHgt4fJEWGHpuPrmpO/bdDeZK3bsR86LFTo
        FLrVDxy64heaG8P01QPgwK+E
X-Google-Smtp-Source: AK7set/6e6JCaM2aw8azs7vTQVD30WosM90fSOAg7fXNpFjqpSC2C5T/pNl6LRt3JoVYW3WjMJiGjQ==
X-Received: by 2002:a17:90a:2c47:b0:23d:2532:ae34 with SMTP id p7-20020a17090a2c4700b0023d2532ae34mr6015982pjm.2.1678862627343;
        Tue, 14 Mar 2023 23:43:47 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.35])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a6a8400b002367325203fsm550747pjj.50.2023.03.14.23.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 23:43:46 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 10/18] PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.3.3
Date:   Wed, 15 Mar 2023 12:12:47 +0530
Message-Id: <20230315064255.15591-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
References: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the resets are asserted and deasserted at the same time. So the bulk
reset APIs can be used to handle them together. This simplifies the code
a lot.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 49 ++++++++++++--------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6b83e3627336..8c39fc554a89 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -170,9 +170,10 @@ struct qcom_pcie_resources_2_3_2 {
 };
 
 #define QCOM_PCIE_2_3_3_MAX_CLOCKS		5
+#define QCOM_PCIE_2_3_3_MAX_RESETS		7
 struct qcom_pcie_resources_2_3_3 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_3_3_MAX_CLOCKS];
-	struct reset_control *rst[7];
+	struct reset_control_bulk_data rst[QCOM_PCIE_2_3_3_MAX_RESETS];
 };
 
 #define QCOM_PCIE_2_4_0_MAX_CLOCKS	4
@@ -889,10 +890,6 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	int i;
-	const char *rst_names[] = { "axi_m", "axi_s", "pipe",
-				    "axi_m_sticky", "sticky",
-				    "ahb", "sleep", };
 	int ret;
 
 	res->clks[0].id = "iface";
@@ -905,11 +902,17 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < ARRAY_SIZE(rst_names); i++) {
-		res->rst[i] = devm_reset_control_get(dev, rst_names[i]);
-		if (IS_ERR(res->rst[i]))
-			return PTR_ERR(res->rst[i]);
-	}
+	res->rst[0].id = "axi_m";
+	res->rst[1].id = "axi_s";
+	res->rst[2].id = "pipe";
+	res->rst[3].id = "axi_m_sticky";
+	res->rst[4].id = "sticky";
+	res->rst[5].id = "ahb";
+	res->rst[6].id = "sleep";
+
+	ret = devm_reset_control_bulk_get_exclusive(dev, ARRAY_SIZE(res->rst), res->rst);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -926,25 +929,20 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	int i, ret;
+	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
-		ret = reset_control_assert(res->rst[i]);
-		if (ret) {
-			dev_err(dev, "reset #%d assert failed (%d)\n", i, ret);
-			return ret;
-		}
+	ret = reset_control_bulk_assert(ARRAY_SIZE(res->rst), res->rst);
+	if (ret < 0) {
+		dev_err(dev, "cannot assert resets\n");
+		return ret;
 	}
 
 	usleep_range(2000, 2500);
 
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
-		ret = reset_control_deassert(res->rst[i]);
-		if (ret) {
-			dev_err(dev, "reset #%d deassert failed (%d)\n", i,
-				ret);
-			return ret;
-		}
+	ret = reset_control_bulk_deassert(ARRAY_SIZE(res->rst), res->rst);
+	if (ret < 0) {
+		dev_err(dev, "cannot deassert resets\n");
+		return ret;
 	}
 
 	/*
@@ -966,8 +964,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	 * Not checking for failure, will anyway return
 	 * the original failure in 'ret'.
 	 */
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
-		reset_control_assert(res->rst[i]);
+	reset_control_bulk_assert(ARRAY_SIZE(res->rst), res->rst);
 
 	return ret;
 }
-- 
2.25.1

