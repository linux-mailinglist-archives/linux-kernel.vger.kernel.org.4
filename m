Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFA66BC88B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCPINI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjCPIMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:12:45 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E60AB371B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:12:24 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id z18so423964pgj.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufpEA84/gN4umfd5y1eYnNgnkoqBPgqB3sRHySwDW0Y=;
        b=pHP+s1h3owrLB2ZhglIt11yJpI1n9LlCXsLJ4A2gsdxTCANzCBXoIH7LFJ+UJ+BsRl
         oGiDekv5KsnrlsPggi2emte2GD7zcT5Tan/MVhP5BFIwCQN4d8eQuqlbBBk5FXHlFX+9
         BWbTkte9AcJFEovYt0DLZFpkaU5SMHVwEX+ZHB70Sq6mMbAxI8kqnXob25IQf8xi4QUK
         6rVsajpmEi7wByzaR77MhKf8mfcQ/XjLd+YNz4z8v/a7ubsrMIoj0xaV7XsIW+TkQuQa
         so0TwHCRj3Vxflz8mtV21YgAI3ZlBMp8vZjrEEhhC9LaShVJl7O2hJRZAQQhLC04P4GF
         eL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufpEA84/gN4umfd5y1eYnNgnkoqBPgqB3sRHySwDW0Y=;
        b=lygoB0m19rok1N4d8z4ht64v74HlGablY2gJGCxsFqbILBVvmoePxV5N3/08N95kO8
         tSoJAxlMCB3F/INDsu7EK3OjDpSH0fvK3b9Iqq4BjiL45sVFQvnrJ8DKjRv1hHEoPY4o
         MN/2yKN7VStEhiN5TNqmD+FGOZIghloqcYvoEYGvzrysjJuB+zFuTTi64INZJA8OjCUv
         EBQZc6I5MNTzcp3eLOCJayj3s84Y7Wq1W6+ULD1bmErK+A5znGacRzFcuGDtDCIcBPHR
         0x9a7PdMKaK1EHkPdJQvdXrLW7Sm30+bU3QgvgRkQ734RWLKDn7DJDfo/NLaE0VmwM3X
         xuCw==
X-Gm-Message-State: AO0yUKVBzDWTZ24zbPYwrmZ7R7NK6CNX8ro1W6TPkLrO8JzEJcacclMi
        9CaAdGjErNXo+QXx22s6edAa
X-Google-Smtp-Source: AK7set8vqYJJRJHg//I69+pxyUgVmk9YyW9psPIRxA9M3tOITR4ay59nQeNDWbOXJGKI2b5YC0T8cA==
X-Received: by 2002:a62:79c4:0:b0:622:c72a:d0e0 with SMTP id u187-20020a6279c4000000b00622c72ad0e0mr2819170pfc.13.1678954339802;
        Thu, 16 Mar 2023 01:12:19 -0700 (PDT)
Received: from localhost.localdomain ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b005d9984a947bsm4804422pfh.139.2023.03.16.01.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:12:19 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 11/19] PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.3.3
Date:   Thu, 16 Mar 2023 13:41:09 +0530
Message-Id: <20230316081117.14288-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
References: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 42b851bdf1a9..d673cb29c913 100644
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

