Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50615F5600
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiJEN7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJEN7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:59:06 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8F27C1DB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:59:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 2so9755355pgl.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=4GHAQq3Ab8Hgu7Ai+ngirQfvBonZmF3ZDCHqLz0H/hg=;
        b=XjqIdx98+RPbrIVN9x5rxVQdyVxFqNW1PsqYrs6fnku6XD08LmcJAgbMYXNAPtQe27
         mAdIGrBnRRjg6QYUj3XBD8CX/UaFznIA3XqhMGh4bqy0Yu4/Jl3sW4wRzZrYphVTULAc
         DESez5aqx5JoCGiuLzkhWUOSSRZtdLmPg6dChh0SdX+aoI1nMlo6HUBq+CgkpcuYq/Gu
         3ZBBzRkLRLkDeVhQLVkyzZexhd2u5di9h9fIGxnq5ktB2X1Lb2bbXvCKH6JMCh82F88u
         XsLUXVQNNwtYVBtGpZI39Fkv4hzzshc84XicOYwPTz/e1Sp2dPzxoSz6PmlcZHYVFOKH
         WX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=4GHAQq3Ab8Hgu7Ai+ngirQfvBonZmF3ZDCHqLz0H/hg=;
        b=EaMVu1QoNYQVBDrQl2ZsMbmkAvnJRoiCMtRoXl9st3kktgyk0nDzCkFoSeFFbJcr5b
         vmZ6acytIWprpJDfNzW81VYc4uwhpANEgQ/hJeNNVxTRsOK0LChbRgCtT3p0lVZLCTYp
         kM0k+7OEcXG1hz2dQOkPFtYe6bdfGX5FZf6IADvjw8/9bWFv5dQ1/5wq7YrCTXyTyz4H
         SNfHNWfP5kQQlni5bvI0fpqlIq0QPYhu24rr5vfQLNZRe1cVUo/gYql3W+yS1NPa4frV
         tF8fGwHi/h4Vsfcb9bXcrX8N8Y2mngShMNZL87d0vusegi95eFJHMN4suXvn5IwOrHNl
         BM3A==
X-Gm-Message-State: ACrzQf3cK4C9+ZOCb74OnBdx5Iic2V3ueutX9/z5um037M67Cl78Y62X
        /P++o7EiDhRKdfUAgdyj2zFJ
X-Google-Smtp-Source: AMsMyM6dl84w13wlxG5aIyhuXwtgyoO0gr2xNXwnNTdnpSE5e1R/wwqZWvtY02Zi2Ke1u+TvmV+c+A==
X-Received: by 2002:a05:6a02:186:b0:431:25fb:f1fe with SMTP id bj6-20020a056a02018600b0043125fbf1femr7334pgb.130.1664978342707;
        Wed, 05 Oct 2022 06:59:02 -0700 (PDT)
Received: from localhost.localdomain ([220.158.159.173])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0017f74cab9eesm2787957plb.128.2022.10.05.06.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:59:02 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] PCI: qcom-ep: Fix disabling global_irq in error path
Date:   Wed,  5 Oct 2022 19:28:52 +0530
Message-Id: <20221005135852.22634-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

After commit 6a534df3da88 ("PCI: qcom-ep: Disable IRQs during driver
remove"), the global irq is stored in the "global_irq" member of pcie_ep
structure. This eliminates the need of local "irq" variable but that
commit didn't remove the "irq" variable usage completely and it is still
used for disable_irq() in error path which is wrong since the variable is
uninitialized.

Fix this by removing the local "irq" variable and using
"pcie_ep->global_irq" for disable_irq() in error path.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 6a534df3da88 ("PCI: qcom-ep: Disable IRQs during driver remove")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 16bb8f166c3b..00a0728d5ecd 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -614,7 +614,7 @@ static irqreturn_t qcom_pcie_ep_perst_irq_thread(int irq, void *data)
 static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
 					     struct qcom_pcie_ep *pcie_ep)
 {
-	int irq, ret;
+	int ret;
 
 	pcie_ep->global_irq = platform_get_irq_byname(pdev, "global");
 	if (pcie_ep->global_irq < 0)
@@ -637,7 +637,7 @@ static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
 					"perst_irq", pcie_ep);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request PERST IRQ\n");
-		disable_irq(irq);
+		disable_irq(pcie_ep->global_irq);
 		return ret;
 	}
 
-- 
2.25.1

