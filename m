Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE195B449B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 08:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiIJGcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 02:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiIJGc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 02:32:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4665FA1D2C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 23:32:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso3200369wmr.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 23:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qIqmnnPPd/w9PevtCzz3I9Xl0se/j1JE8K0DzKiojlg=;
        b=q59Aqmj65oNIISK1rl2pZRTujcgyNmFG+KMRLvIIrNpSLuYSTUMlxcAC0y9HTW6dIP
         6tfiJiPidBdHD8i+G0u9j3xPddfn1GeQivetpwlB4y9pt7sBnKRaVEhub9+V5feCa0J0
         77xhtfsa5HRznnqYrujUbN4PHPDeUh++y3fSjV6JmUAr1+FqM/DccWNOG1n9T6qGwWup
         DsvbumDa9kbBr42gBdRf3DGBkhgDkC9fI2eCUkzLhOJ4vLiqFRxW6U4K8Bs7xGF+KnVx
         JN2OadJP50ESUbdKqsD3gwACjkFHU5npwkXcxtarNAKpdM/BL8h2zxUtFom5e3F0VU5T
         0lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qIqmnnPPd/w9PevtCzz3I9Xl0se/j1JE8K0DzKiojlg=;
        b=KITrFHqrSYH2LLNc3slWSvdl/t8ljYIuLRiR5CDO2qDpS/H9v9OUu+/DBaQJOtoK4k
         R3Nv7srmrNQru6W+evjnL0s5Rce6WyAF4vY+yuEdN2/MBWTdQGLNWjaIsaPrL+0Yp9my
         /qVwgV+vc6a1yDand3jC7O88cdSyuCfmVGOTqrZVv6+4nkdpAY3c8Tx3NWU5Nsh1VY6Z
         KqDpLKB10XhXLBt/w6LLni9ipD7h91pmfnFyLA6hdDUF9j6NltW/KxXtZ7uWH7H/6Vfu
         hs0cNPDP8/mXhUxWP/ZFxo3lK79AhFUb8w0xE+EF2VQmXU8eUoUSOTRYwLCKc+EH5HwT
         EnSg==
X-Gm-Message-State: ACgBeo1eTqun7/H0kQ53ihDNE9eBBBJdFz7oLXJzN04cHF4V4iYgM/qZ
        juOFqLUj07+bK+YA0pC1PxAn
X-Google-Smtp-Source: AA6agR73+dIsl2dTBdfX0mv220WTfqzFz8Oe5rFjI2mgdLRAnzrw1DseWA44GgJcpqGu3/vZsCJ1wQ==
X-Received: by 2002:a1c:f709:0:b0:3a6:3452:fcbe with SMTP id v9-20020a1cf709000000b003a63452fcbemr7618282wmh.164.1662791532608;
        Fri, 09 Sep 2022 23:32:12 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm2828122wmq.28.2022.09.09.23.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 23:32:12 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 09/12] PCI: qcom-ep: Make PERST separation optional
Date:   Sat, 10 Sep 2022 12:00:42 +0530
Message-Id: <20220910063045.16648-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
References: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PERST separation is an optional debug feature used to collect the crash
dump from the PCIe endpoint devices by the PCIe host when the endpoint
crashes. This feature keeps the PCIe link up by separating the PCIe IP
block from the SoC reset logic.

Hence, make the property optional in the driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 40f75a6c55df..92140a09aac5 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -220,8 +220,10 @@ static int qcom_pcie_ep_core_reset(struct qcom_pcie_ep *pcie_ep)
  */
 static void qcom_pcie_ep_configure_tcsr(struct qcom_pcie_ep *pcie_ep)
 {
-	regmap_write(pcie_ep->perst_map, pcie_ep->perst_en, 0);
-	regmap_write(pcie_ep->perst_map, pcie_ep->perst_sep_en, 0);
+	if (pcie_ep->perst_map) {
+		regmap_write(pcie_ep->perst_map, pcie_ep->perst_en, 0);
+		regmap_write(pcie_ep->perst_map, pcie_ep->perst_sep_en, 0);
+	}
 }
 
 static int qcom_pcie_dw_link_up(struct dw_pcie *pci)
@@ -478,8 +480,8 @@ static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,
 
 	syscon = of_parse_phandle(dev->of_node, "qcom,perst-regs", 0);
 	if (!syscon) {
-		dev_err(dev, "Failed to parse qcom,perst-regs\n");
-		return -EINVAL;
+		dev_dbg(dev, "PERST separation not available\n");
+		return 0;
 	}
 
 	pcie_ep->perst_map = syscon_node_to_regmap(syscon);
-- 
2.25.1

