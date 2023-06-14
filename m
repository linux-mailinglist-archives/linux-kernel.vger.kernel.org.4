Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6423C7200E1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjFBLuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbjFBLtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:49:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DD0E79
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:49:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-973f78329e3so290573766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 04:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685706521; x=1688298521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjhhtMDiVxTVno+SPO1SHJkYSl5NdViRdJrBhSZBSq0=;
        b=D1n/ahAjHoJwmX1Pd+G0DOzH8PHh8fuZj+RlDGayhTmxtwTHa90OhfHxAfNOWrwmFA
         YBmrShea8Wc5NueobvdT5Gd3H3LoOTy3MPZf+tcOQ/zqfw/cRcbUv0OFKGzS1VCqTAPY
         osO6Sqj4WwFOHNhf4mTDuGNdUlStL43Ta0c6lel1IOoBuVjM5NOmjqeTSgWALErCEAu6
         mnkoyuZSYcRsEKhg/cjW1twH/CJze1HlNAo96GHbtQvUjO1K8RIWv7UfAnIiqXbOZbq9
         ETqSFttf24CcT+GqrmYPtc8CPv0SXnjhQ7kCdewQqSJ2QHozViMBIrE0hkjuFD7N+06M
         7s6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685706521; x=1688298521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjhhtMDiVxTVno+SPO1SHJkYSl5NdViRdJrBhSZBSq0=;
        b=CAQFAm0T7VkVCQ80n+X5JpmMJPTIcI532jFELLbrEMtSn6Ug5V8119rNenxXIAF9W3
         UhsLjJmBlcUJ9tacLHXiYcRQs16bT68R5tYdgoePDRqIE2jNUNh1NFmj/quVHqZOCv9U
         Arapd3pPrPZPAvYNu7pmnejCzepO4ZfUwBOqj1OKvyYXl/Ze1G9gJN7Lk+A4Qw/5W4X1
         vudhjfszAxGxwnoFyfT6DX63Idh/Asg83IgH6pZWoIhpHzjHKwa26iMi7oalSTcEuhl+
         L+/tHuVbgm3EKZWQhHPYRVqozmOq+NLMDfwqXM01IDBs4S82LPVKcsKnDiZMqtlQT9IR
         TaUw==
X-Gm-Message-State: AC+VfDxYiiy6LkmuyOz+GBnhjLQJ52GGzzdMD9L+hDvo/CEOSKsP/OCl
        x91Pn0z/w3q/bvWy0pkXJhJC
X-Google-Smtp-Source: ACHHUZ4FH+Poh79HPfqj3RwtHxqHDNDnhHxHGHZkuRDhzM9YGJ0QeJyjLnAVcUfFGHl2vbdOaKfpuw==
X-Received: by 2002:a17:907:748:b0:94e:116:8581 with SMTP id xc8-20020a170907074800b0094e01168581mr11513927ejb.5.1685706521632;
        Fri, 02 Jun 2023 04:48:41 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.79])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b00974530bb44dsm658924ejb.183.2023.06.02.04.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:48:41 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 6/9] PCI: qcom-ep: Add support for Link down notification
Date:   Fri,  2 Jun 2023 17:17:53 +0530
Message-Id: <20230602114756.36586-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to pass Link down notification to Endpoint function driver
so that the LINK_DOWN event can be processed by the function.

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 19b32839ea26..4ce01ff7527c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -569,6 +569,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
 		dev_dbg(dev, "Received Linkdown event\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_DOWN;
+		pci_epc_linkdown(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
-- 
2.25.1

