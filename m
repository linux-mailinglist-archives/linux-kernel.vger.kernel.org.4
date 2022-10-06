Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365735F687E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiJFNt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiJFNtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:49:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82A2B493
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:49:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so4386324pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pAOyHNo2Ogz8benvCK0BMK/ZXWCdH9NtvY9tUBlmQgQ=;
        b=oTowoydDyAkpARgML6g7GzRmeF311CW8HrohiULAiRheYMxj6z6voHc8PfiRDQLJZk
         SeZw8sGXTS3+F0uR90r3XWrTaDY+dMkWEyHdsEzIWq0bDGc+Yhy18zyRhJLUrTfv0mJ6
         wyjZegco+9RmBprKj1PbsUoZN0s6CuT76Y9ONE9W/0IZzsP11OcW8DazvxDUTIteCNg7
         gS8ZYO8ClzaVr4ppD82Ji05lS2BlZ6IqNH5y520tFmU3NMXffLvKS4t/47riODMHPhb/
         ephjK7oyDc5COw37/or/6RQhjg5/yuN1Ga03gPyTPPStucja6tvOt6HRcywSaaArQrIu
         +qDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pAOyHNo2Ogz8benvCK0BMK/ZXWCdH9NtvY9tUBlmQgQ=;
        b=ocUJDsOvZR/RfO4kQmrFkaGJ8ZuM2aYMSAVrykENRiiB9sKyOkwE3q8kW9PZRZkIHG
         EAFgQqGgC72hi5AH7Dcs6a2xjJTm7f4A+ngnPChuPQMQQb5iUx0tpxLp11CUh33PGo39
         YQ4kIvRAH2ftjg5Cu9Zq/1EOg6YJwl9SFM/WVsIHaPLCJvo0ye1ZqZbQBXwrveNmIt82
         k9W/gaHaWUUJEiiBSCn8I/Chc0n5gEWAgZ4XH0LbZQBUC4hwjM3HBeT7wQ2N4zuGIvSZ
         wliK5qVOpRsIpb0yb+PVJL7yYEJZ6KNWOdf/a479x5+iwkybfIMJ67bHl0zkBx1PWku1
         errA==
X-Gm-Message-State: ACrzQf3gAk54PCDYwUWyUVtRTb1mqJRbC14pcaUfE0nn0nSvGnVAUnZ2
        fSG7kRR0y3k3QURGjSThy+K1
X-Google-Smtp-Source: AMsMyM5cCrhHsinO11H0aWRdW1l/kf7wzsq5ZSXzHZMnGUbODs1FP0WILk8VIRrN2z+giOjEXAHBxw==
X-Received: by 2002:a17:90b:1d85:b0:20b:20b0:29cd with SMTP id pf5-20020a17090b1d8500b0020b20b029cdmr580300pjb.131.1665064185925;
        Thu, 06 Oct 2022 06:49:45 -0700 (PDT)
Received: from localhost.localdomain ([220.158.158.220])
        by smtp.gmail.com with ESMTPSA id k25-20020a635a59000000b00434760ee36asm1874053pgm.16.2022.10.06.06.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:49:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/5] PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
Date:   Thu,  6 Oct 2022 19:19:23 +0530
Message-Id: <20221006134927.41437-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
References: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
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

The "dra7xx-pcie-main" hard IRQ handler is just printing the IRQ status
and calling the dw_pcie_ep_linkup() API if LINK_UP status is set. But the
execution of dw_pcie_ep_linkup() depends on the EPF driver and may take
more time depending on the EPF implementation.

In general, hard IRQ handlers are supposed to return quickly and not block
for so long. Moreover, there is no real need of the current IRQ handler to
be a hard IRQ handler. So switch to the threaded IRQ handler for the
"dra7xx-pcie-main" IRQ.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 38462ed11d07..4ae807e7cf79 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -840,7 +840,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	}
 	dra7xx->mode = mode;
 
-	ret = devm_request_irq(dev, irq, dra7xx_pcie_irq_handler,
+	ret = devm_request_threaded_irq(dev, irq, NULL, dra7xx_pcie_irq_handler,
 			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-- 
2.25.1

