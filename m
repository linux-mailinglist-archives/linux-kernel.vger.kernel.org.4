Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307B4735AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjFSPGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjFSPFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:05:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2FA10DD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:04:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-25ec175b86bso2339437a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687187084; x=1689779084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/GAaoCJDXRESh8SzkgobGj/lkVGqp4sgMGqg7raF+w=;
        b=V9wXOuC0u6MhserqB+G6difAW8y4vzCRO18OAHl8pZnY48vHjoerHjTRsy+IVJqNcJ
         yRJh/pMYCSaxpRbcXAZFUsGHkqN5noXwbP/l5hlnO5r2kADG2CM0AQW5UtMji3Ppz+HK
         oTskUMwOIwrFfONX8n3SF9RSKCh3AOC19NJ12xPMVmOneKEpTzxmfyUAx+2pfBn5+AlB
         g1u2B4xEfnBiJo3IUVVaYLZuLmzh/0on5msGUMn1RuePtdM8wq4HTxrWZJupUxO/9MAd
         VhoNpR/Nu+8I11s4QzL5bA60jEWGz6kuipBuN5+njDVf+6Q8C3i7xutqeRTpI6rTbNPW
         wmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187084; x=1689779084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/GAaoCJDXRESh8SzkgobGj/lkVGqp4sgMGqg7raF+w=;
        b=Jl4uPkWtUQAiEF7IRGzQakvEGeMyE+Cr/OFmU4Za+cVKLfYYjTpAC70O5W3/R4LuvU
         gCDqCROo9FZh17Oy+iGjRWAyR9f65SV0KPlJPjgkge5nguAgVWFZBo+/GDoZC+B1cCeT
         o/uTaT95Z8hRsry2cAwvX8VlRivHcn9OpZOfkFbqh5wpm1roVWQQcWR44W6q8DUSh1Gy
         C9zwoTP1R0FI5V66KkX8iZbfL8HEsDsnQamETAmZinjbZHvcjxtugkQ2xtyHMg3i0ziy
         KPee93XRUOEze6GkP0ynWYcHiJiCatCVQVh2SzCKgv69dCKxSm1MJHlQfaJOloJu7uae
         +sbQ==
X-Gm-Message-State: AC+VfDwyl1sMQL0kQs5uZx2b2yFGKII+Aj8D0RRBosuiJus4rWjznY7H
        WSCRAKKmdUbiTSCyqCYYDrVi
X-Google-Smtp-Source: ACHHUZ6Lgv+CRaeHvpmMJL0dObGrC9m7WE8tCgI+82+fGfhWauNyHfgIcYA5lk5e88NN9cFcN1NqLA==
X-Received: by 2002:a17:90a:44:b0:260:a45e:751a with SMTP id 4-20020a17090a004400b00260a45e751amr1973170pjb.25.1687187084355;
        Mon, 19 Jun 2023 08:04:44 -0700 (PDT)
Received: from localhost.localdomain ([117.217.183.37])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a19ca00b0025efaf7a0d3sm2765480pjj.14.2023.06.19.08.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:04:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 7/9] PCI: qcom: Use post init sequence of IP v2.3.2 for v2.4.0
Date:   Mon, 19 Jun 2023 20:34:06 +0530
Message-Id: <20230619150408.8468-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619150408.8468-1-manivannan.sadhasivam@linaro.org>
References: <20230619150408.8468-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The post init sequence of IP v2.4.0 is same as v2.3.2. So let's reuse the
v2.3.2 sequence which now also disables hotplug capability of the
controller as it is not at all supported on any SoCs making use of this IP.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 30 +-------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 9c8dfd224e6e..e6db9e551752 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -703,34 +703,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
-{
-	u32 val;
-
-	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~PHY_TEST_PWR_DOWN;
-	writel(val, pcie->parf + PARF_PHY_CTRL);
-
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
-
-	/* MAC PHY_POWERDOWN MUX DISABLE  */
-	val = readl(pcie->parf + PARF_SYS_CTRL);
-	val &= ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;
-	writel(val, pcie->parf + PARF_SYS_CTRL);
-
-	val = readl(pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
-	val |= BYPASS;
-	writel(val, pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
-
-	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
-	val |= EN;
-	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
-
-	return 0;
-}
-
 static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
@@ -1276,7 +1248,7 @@ static const struct qcom_pcie_ops ops_2_3_2 = {
 static const struct qcom_pcie_ops ops_2_4_0 = {
 	.get_resources = qcom_pcie_get_resources_2_4_0,
 	.init = qcom_pcie_init_2_4_0,
-	.post_init = qcom_pcie_post_init_2_4_0,
+	.post_init = qcom_pcie_post_init_2_3_2,
 	.deinit = qcom_pcie_deinit_2_4_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
-- 
2.25.1

