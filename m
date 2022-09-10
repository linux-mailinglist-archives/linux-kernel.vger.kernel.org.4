Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E8C5B4487
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 08:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiIJGby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 02:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIJGbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 02:31:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835AFA4B02
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 23:31:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so3195138wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 23:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xK6rQZk9RPmXG6rMhe5oBA83BpczBJE39eGNhUm9qAw=;
        b=eHjhdwlNaM3iDfDgBXBBx+PyXZr7kSYejrsu9q8FBnSqpYtMid7K/vIwG7/k21BBoA
         M8SL6UmG5Ni7yKPlneUTdRwnHWCHisGqM42VYzW/lYPgmrhRpNvI/ruXZJtt6XkZ39XU
         3NXOlqLjlOLYNOae/TFwlMdMC9wnOjq7INOjwspT1oqK0H20MeGMR/RGAWwT9r0n/F7o
         knNmH42ouvayRZ0YtT4GUHu9ITyWmQWa7Zr439JnSmi1yplH7LHG6zdZiWdMNSe3suhF
         cgoPTKJRXvLVfNBQK1Q5nq9g8D2Fir+IDJJbZHSqua4Voa/y/QXtA3hOCimM+ivugJVA
         PVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xK6rQZk9RPmXG6rMhe5oBA83BpczBJE39eGNhUm9qAw=;
        b=x4dtGD+yeOcru/6EGw3RUnGCbMLM51wIGuLlor/RjIvVbRxt28HxCmDTlStcp9VLrD
         AvY4ydrZZ5FUIGFqhLVE1EiqsDW+CVj4sKI24f1hMSJ4Snef2d703pPjdQig1nUI/yQH
         SE51Eq+2qMhslelShV6NT5y1wWKM30ILwY65S0jNhND3wRfjefltETtH7fUzGhxXDIgE
         D51x+VVzn0bx3JU2Gft02F644hVd5s9HbHhxUF5oGhcFsbINI+qX0L1HI7mRW9QeS3Ca
         Quvqavbt/O348scNbjZbWuaufzjw9/1+snvSqcTYRz9zluHGgL+WwbaRVmA+vZujdSsW
         rybw==
X-Gm-Message-State: ACgBeo1mK59gN6qHREeyDp2QAG+hrv/ICXR3ulMtf43unbjbaBJ6dWoa
        +KB1yUSjecO3o1CZapGAiqOm
X-Google-Smtp-Source: AA6agR68lncY+aFp4U6cqVvoZhEMCSGQc2siFytS5rr+gQFU8QDTyr/EYgGqFlyF/rgaSEZVjOHahA==
X-Received: by 2002:a05:600c:3487:b0:3a6:280b:bed1 with SMTP id a7-20020a05600c348700b003a6280bbed1mr7312534wmq.111.1662791493870;
        Fri, 09 Sep 2022 23:31:33 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm2828122wmq.28.2022.09.09.23.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 23:31:33 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 04/12] PCI: qcom-ep: Disable IRQs during driver remove
Date:   Sat, 10 Sep 2022 12:00:37 +0530
Message-Id: <20220910063045.16648-5-manivannan.sadhasivam@linaro.org>
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

Disable the Global and PERST IRQs during driver remove to avoid getting
spurious IRQs after resource deallocation.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 1e09eca5b3b2..72eb6cacdb3a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -585,11 +585,11 @@ static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
 {
 	int irq, ret;
 
-	irq = platform_get_irq_byname(pdev, "global");
-	if (irq < 0)
-		return irq;
+	pcie_ep->global_irq = platform_get_irq_byname(pdev, "global");
+	if (pcie_ep->global_irq < 0)
+		return pcie_ep->global_irq;
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+	ret = devm_request_threaded_irq(&pdev->dev, pcie_ep->global_irq, NULL,
 					qcom_pcie_ep_global_irq_thread,
 					IRQF_ONESHOT,
 					"global_irq", pcie_ep);
@@ -698,6 +698,9 @@ static int qcom_pcie_ep_remove(struct platform_device *pdev)
 {
 	struct qcom_pcie_ep *pcie_ep = platform_get_drvdata(pdev);
 
+	disable_irq(pcie_ep->global_irq);
+	disable_irq(pcie_ep->perst_irq);
+
 	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED)
 		return 0;
 
-- 
2.25.1

