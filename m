Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A264560CF93
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiJYOv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiJYOvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:51:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A16819E00C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:51:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c24so11148129pls.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlR6S9guDT9sPWfcvESvWKmdq7t2wt4CcZ/x6tOD8xg=;
        b=X8hhfHjP0ZTomxWkO4/xuAcDDkxtY8PakMk51H+wqHBEn4jVYn2wMHVizShCttm02p
         RlSOodLMjzDprEhF00Y08hBCBy/rUHPuNPpvEVN7yoJLWsuEK0VKflDMgQTpNfPyZG8X
         NcoxL++w7sMiyvAv4n9x34NbvvOb2wwEB680t2KzQAXLHYf9W+gt8t3YBCS7/rX+TKAr
         ZFb/b+oxQajUVk5pOeGS94yP96EU93RgXWslI1p9TRbrCQzbFCiGPkk4iIBjjkUmUBIE
         /ykkGGBlkfe7C/6EiYpOx8jlUjzUOf3wSp215wI9ohcP8AFDRQlwOu2/Y328fv8p8aY6
         0qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlR6S9guDT9sPWfcvESvWKmdq7t2wt4CcZ/x6tOD8xg=;
        b=jpJBbtKBVS6Q+aAaKOirhGdp/UNCdzXrjGRLYtXfvOvctrMdQDCdSC2NmIWnhui+BY
         /q1i134i7Hidlu3fqixwPDp1NwM7TLO/2sWCiF4y6M9itqDqBVtxJ2K1aKlqwDcgLwMf
         1UkVz3SX9Zcbpkvxy9YyLiboLrEJrHV0EGB8mBA6RUOCCYklkqArrZ18h3P7c6FO20e5
         oBq3WXeREkLJfQOa/hcY2FUUs7IrmAWM3bsJN85sFlhHlnHq3W7Ua+7gKYU+im7OW4Lu
         nPH3/c0s3g99LG9RHYi7+bDB8Qaoz4p86CmexbhpHNk5xy6r5jMhM0jBjZzRtW19qi7M
         PlnQ==
X-Gm-Message-State: ACrzQf1EX85b7l3jIC2y5j1z7K0suus+pSFRPgRlP2z4YKYHd2y4SX4S
        wRI/UiF5YdteIBkjfS3teVzH
X-Google-Smtp-Source: AMsMyM4DgEweMnPWakcf68XJgk0hgLxtXUagZ9Nbzs4lrDl+Vh1j4S1Zz79bYf0vSQiYXBcvvHpAlA==
X-Received: by 2002:a17:902:bd05:b0:179:bbad:acff with SMTP id p5-20020a170902bd0500b00179bbadacffmr38091051pls.170.1666709483815;
        Tue, 25 Oct 2022 07:51:23 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.236])
        by smtp.gmail.com with ESMTPSA id n14-20020a170903110e00b00180cf894b67sm1318765plh.130.2022.10.25.07.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:51:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
Date:   Tue, 25 Oct 2022 20:20:58 +0530
Message-Id: <20221025145101.116393-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
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

dw_pcie_ep_linkup() may take more time to execute depending on the EPF
driver implementation. Calling this API in the hard IRQ handler is not
encouraged since the hard IRQ handlers are supposed to complete quickly.

So move the dw_pcie_ep_linkup() call to threaded IRQ handler.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1b6b437823d2..a0d231b7a435 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -287,6 +287,7 @@ struct tegra_pcie_dw {
 	struct gpio_desc *pex_refclk_sel_gpiod;
 	unsigned int pex_rst_irq;
 	int ep_state;
+	long link_status;
 };
 
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
@@ -450,9 +451,13 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
 static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 {
 	struct tegra_pcie_dw *pcie = arg;
+	struct dw_pcie_ep *ep = &pcie->pci.ep;
 	struct dw_pcie *pci = &pcie->pci;
 	u32 val, speed;
 
+	if (test_and_clear_bit(0, &pcie->link_status))
+		dw_pcie_ep_linkup(ep);
+
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
 		PCI_EXP_LNKSTA_CLS;
 	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
@@ -499,7 +504,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 {
 	struct tegra_pcie_dw *pcie = arg;
-	struct dw_pcie_ep *ep = &pcie->pci.ep;
 	int spurious = 1;
 	u32 status_l0, status_l1, link_status;
 
@@ -515,7 +519,8 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 			link_status = appl_readl(pcie, APPL_LINK_STATUS);
 			if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
 				dev_dbg(pcie->dev, "Link is up with Host\n");
-				dw_pcie_ep_linkup(ep);
+				set_bit(0, &pcie->link_status);
+				return IRQ_WAKE_THREAD;
 			}
 		}
 
-- 
2.25.1

