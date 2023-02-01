Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306196791A6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 08:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjAXHMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 02:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjAXHMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:12:34 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725463E614
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:12:31 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c6so13898740pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6TJHrpo+wQjh8G+Bpvtwzy9BlHNumqlezIB2u99WO4=;
        b=GeJ+GXDW0L3U8uA1nL30L/UfUQeHnVsWfi1yq4/NGW6iWDCHRbYG/jYCuPOmtuPH/v
         iHGQa+an4s606maYVETnrsK1eEWZqJeiMdC4cI8v4m3UkUx0hFPATyB5xmHFzidk+SxB
         5PRh1/pe6WJG8FjRS3dAB8wkH7XAGaynp9aMtkqOoS2YwW+8U7LnCvsSMpqQhyWLWkAi
         z7GVJN5c39WrC2ifzNmeXcN4E2vArsbzCiCmoWRpIsfpQNoo3s6HqqlhyjjPy+K69atF
         uxFFSGJ9TOO610N1+G62qJ/wDNVYhOWlN3HU5o2Ct+lOxcVLZ0ywS0gKCpzn23dhzVbA
         /llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6TJHrpo+wQjh8G+Bpvtwzy9BlHNumqlezIB2u99WO4=;
        b=gw/vJgLx7/tGcnAPx+H2XebIV6XVlJcZaVUCB5W15zaf5aR7cJVbpSapDRmjZsWw5V
         k+QyJugjumo97hUUqKSQUoRq57yBkaE7QGai++HT60kwR8f4GYOFz2pow5A5VMbs13EB
         5zfCK6+Zmp/evta8+LmQuhY4IJcmt6qmOftIy+yTJvWPYDznPEZdGxdO2qrQKNHLDske
         usmDDFw7KB9BFmtN9gLKtv9Kr9sjdvr9qDky3SpfRl3Fya/gx33+sKVK6ckyDyBKuNlL
         GHvPIW7V4vPKMQVaUQzM6aKiCUesipS50cv4FUvB0rqJVIcngPMAKbaWXyXR95/Qn87L
         6p/Q==
X-Gm-Message-State: AFqh2kqPiOVKdlK3Yce5GiKxYQebc7WLSULus9oOzSRELYbmst95LnQ1
        Zpp5UcvO9P3COWM5gqy/zidX
X-Google-Smtp-Source: AMrXdXuDLcIeayQcgMm6SdnW8ha84YxymgPgzq0gzXrdkG7ilkBwck9VJFzux5NgWdryyOllc5z2ww==
X-Received: by 2002:a17:90b:1bc7:b0:22b:bbe3:672b with SMTP id oa7-20020a17090b1bc700b0022bbbe3672bmr13307290pjb.9.1674544350857;
        Mon, 23 Jan 2023 23:12:30 -0800 (PST)
Received: from localhost.localdomain ([117.193.209.165])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a174700b00219220edf0dsm736041pjm.48.2023.01.23.23.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 23:12:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
Date:   Tue, 24 Jan 2023 12:41:55 +0530
Message-Id: <20230124071158.5503-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
References: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dw_pcie_ep_linkup() may take more time to execute depending on the EPF
driver implementation. Calling this API in the hard IRQ handler is not
encouraged since the hard IRQ handlers are supposed to complete quickly.

So move the dw_pcie_ep_linkup() call to threaded IRQ handler.

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
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

