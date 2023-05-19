Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21991709A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjESOn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjESOmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:42:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA13510C6
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:42:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso563507b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684507360; x=1687099360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY5A5rnt2NOAJyTtKsWtQc3JsasD9KssrsfBlXW2O/Q=;
        b=UsMDNEkH/NKMsUEzMi+uoxnGqxKL43ZIh3lA078aAOE1UWb3mEpwFG2/zFL1W6gbao
         vy1pS65vTGjv8eaGTf2NCAbJlXFFvKsuxhK8uLPPS5iGo2hEkgn+y4u6UbkqlgeEzvh1
         eKeqbCuy+WioZG92pis2hxd4+WzP5CGHk4Y/35/Q1hfGADcb7mas7/zYR9W9AsAMq6tB
         wZfgVULVVyGh6VkQvVPHQKumhJGAiYIXG+JL4BDTqo33uS/fSvsPQbioD7bxh9NGED1i
         2TkoGecc+A2g3D/7zNo2XkYWNN6oXPmW51epgxwzxoMpVRM/PnctJB7+s+mt8XBREk7i
         5p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507360; x=1687099360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sY5A5rnt2NOAJyTtKsWtQc3JsasD9KssrsfBlXW2O/Q=;
        b=B4DBiHgaUV8ehClb8BS6VSmR6lOW+6raL/40cRWwrhxnNf9V3T6rXsHIOK3qz80Ijs
         8KSV4xncWIgtvQTxixZA7o2mg/k5u6uJ1aPrFze+aev2VO+RZa36YtEyVwC/iKKnoMOu
         +kz7YOCdC/Y5QLKv+IrW0HEfL1iRcvKAN73aW6E9DBD9ERCUVpY2wxcmROYws+yLWA/3
         MgqrvT7YOGDntDny6airZWlJMIWAgn+HUrizNO3oHL6x19SOSoOVCpViU2b5U5bt+6G9
         SVrNxa5Bp6+6pQOJFwjehhiNscl/J9G3rsVOvUOAXQkGzy+nGoIzg5PNzxsJjL9p/HUq
         +pGg==
X-Gm-Message-State: AC+VfDx5dFTjVjWYvQ04QTc53qUcNFIeKz1YC7hs5soCwNIT4HDET/h3
        HQxZTvvfsLaMFhMKhKCWuHJyqYWcoFIPBiBVSQ==
X-Google-Smtp-Source: ACHHUZ4LLIDu6RLxgOMPAp5NGHq5BXIhGnL3IRy2y1vA29xMv1OAci7rny0m+fy3Fe83bE0IJb5NXg==
X-Received: by 2002:aa7:8887:0:b0:646:b944:4e1d with SMTP id z7-20020aa78887000000b00646b9444e1dmr3986533pfe.32.1684507360202;
        Fri, 19 May 2023 07:42:40 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.13])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7808b000000b005d22639b577sm3089611pff.165.2023.05.19.07.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:42:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 5/7] PCI: qcom-ep: Add support for Link down notification
Date:   Fri, 19 May 2023 20:12:13 +0530
Message-Id: <20230519144215.25167-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
References: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
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

