Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393CB665A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjAKLnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjAKLmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:42:25 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FA81AA1C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:41:22 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9so16485555pll.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBCcpbqBKltUn44tui+CYGdLtqIOSH9tCT8fXxmRbaQ=;
        b=WkKs/lB4qKgCez6snkAVXh90NqldO1iAfTiVhNJAu8u/1wdTFAOq8Zip63AXq1OZlf
         dbDk3okO91/e6qDzfhPu8dVAdRl/Pu5ajO4QKtfPOmXKYajf41FJdFys0wKp9H9+nsvp
         EuWmnQ/RrwJvcAobXszxWeuvqz9bIQPhqUP2AKZXSKrZYZN2uv8ao0rjfh3G0eGJw0L8
         smRDbMgj4jV5abz4Ork0TCzv1fXJvNyx/lRM+fE4+hApHps3WTIsoF8fcFACaIjz0cB3
         //hj3zBBvsCMIGUJLYlWktzqFE3GssL/5/f4pIIVfkXlY4adtj4IhuRZrNvMdMK7PMNV
         ZajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBCcpbqBKltUn44tui+CYGdLtqIOSH9tCT8fXxmRbaQ=;
        b=cewA7bk51UmQbH8Y/IL1ORAVHSt9o/RoIkoYg+05rcCttY3Pq0TAbcmYx8c37jLp3/
         OlJXFi5zfc3M/Azdul4dEEbsBfjdLBSf9Q/dE34bglbJ/+r95HpFejhaaCJHaxPOOaCg
         uIvWO9cOKa05VngjEV3f14vGT2pLJEmC2yfvENyWDC8osJFnQuB5Qak4Q+H3ItC1oDUD
         vLYIUVYLMq+9Y207nmjGIJ+cI870AFECfyS695ana2U6Bl89cPr12P8Pr/ZGICT/33ph
         p1LIAljem8cOvH1xCu3A3Z+sYmoK2vE/QkRyQdNlYceFlkJvxGxvk30P9ZyJXVsb+f/Z
         uFLg==
X-Gm-Message-State: AFqh2kozBvZZ6S7mnMloEoeEC1YFb4H8Z8OtFVCoZw/FHpKvQZJB7a+J
        THPvK4NYFQcn3eO8LuJtj8NS
X-Google-Smtp-Source: AMrXdXu+Ys1FunK2Z52HKh7KxpuwpwRRWIT7VQsEKxdorap+3l/wew1mV9+LeIh2nb2hk1StnpjFTw==
X-Received: by 2002:a17:902:9a03:b0:192:d0a7:a0f4 with SMTP id v3-20020a1709029a0300b00192d0a7a0f4mr31215540plp.51.1673437281527;
        Wed, 11 Jan 2023 03:41:21 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.1])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b0018958a913a2sm9942688plf.223.2023.01.11.03.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 03:41:20 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND v4 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
Date:   Wed, 11 Jan 2023 17:10:56 +0530
Message-Id: <20230111114059.6553-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230111114059.6553-1-manivannan.sadhasivam@linaro.org>
References: <20230111114059.6553-1-manivannan.sadhasivam@linaro.org>
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

dw_pcie_ep_linkup() may take more time to execute depending on the EPF
driver implementation. Calling this API in the hard IRQ handler is not
encouraged since the hard IRQ handlers are supposed to complete quickly.

So move the dw_pcie_ep_linkup() call to threaded IRQ handler.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 02d78a12b6e7..09825b4a075e 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -286,6 +286,7 @@ struct tegra_pcie_dw {
 	struct gpio_desc *pex_refclk_sel_gpiod;
 	unsigned int pex_rst_irq;
 	int ep_state;
+	long link_status;
 };
 
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
@@ -449,9 +450,13 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
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
@@ -498,7 +503,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 {
 	struct tegra_pcie_dw *pcie = arg;
-	struct dw_pcie_ep *ep = &pcie->pci.ep;
 	int spurious = 1;
 	u32 status_l0, status_l1, link_status;
 
@@ -514,7 +518,8 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
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

