Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC0A71A1CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjFAPEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjFAPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:03:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0962E42
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:02:48 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b02fcde49aso4869145ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685631700; x=1688223700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY5A5rnt2NOAJyTtKsWtQc3JsasD9KssrsfBlXW2O/Q=;
        b=qkwtr+3caPcrNzUHlEnueJTGwkGmT/ICcH4ZDX2YRSvbY6IvMtnGH7MXWH/eQMiwlF
         04TqeBB0E7MRDK8uSqHwM422fPAirj+Mr2LQQ7eFvyJPDPXLLJdGCXtRl1IEha1LQfAI
         cETUcUIr45csA2J0YWw7Wb32LqW3Zupfv/ogbzC62VTlAZTp/WDl9IN1xe4u+lHUp/9c
         DC1R74kTns/W82XGI6oXFKPHI+BxekP3MEg9TFtwDE/Gjtk2L37aPvpB5SWR1xPCEH8R
         Pj3VfaB5GNSqXu1s/AiWLPWO+xRwfPF5b5q6+GAe467W0hMreMEl/78l534bXC8KKaJT
         pl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631700; x=1688223700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sY5A5rnt2NOAJyTtKsWtQc3JsasD9KssrsfBlXW2O/Q=;
        b=FumfWq8+rFiDDkIk0alc+KDhFi4Vwx4ODA2XonjdEEnPsVgOCFs2kmTMovYiAXBsre
         5iZuR+jljgYpWRIfxrQz2VvfJ6UoZi51gBggZYA9f4bI+TMMgFFH6LzsyorBSx6U3Irc
         rIWQekOy2B2WUA1wj1KqwfSA2QprD2oS0l2Vr4l7NVtPEa+3juaS/LuIB9M8zwaemRw5
         4Q0wBPD9bmYKblw3VM6Y5uOKlt2HS6sxzTBOG/9GsDFNp8DEIBokz5W4VxKKvCbAl54t
         05quHisP1YrRKQrOi55RMixANV1kgg50l460LRosbbelY02pCzdjx8oT96MR/AhjFglo
         u6Rw==
X-Gm-Message-State: AC+VfDy2qhqP46gpBmfaeGMNdWlsYwWmyt6aa032ZHhyIY1Ttmz8XzIY
        fm4oVeRWRoD8S24NM/xevfAb
X-Google-Smtp-Source: ACHHUZ5QIApGEkASZ+/Sra/tPB5WJ3LGBnkl1wIBNCXuESJP9laCAO2TyzNYbYU4aiK7jZ1V2wBCzg==
X-Received: by 2002:a17:903:2643:b0:1af:e63f:5bb1 with SMTP id je3-20020a170903264300b001afe63f5bb1mr5811966plb.7.1685631699668;
        Thu, 01 Jun 2023 08:01:39 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001b0499bee11sm3595480plx.240.2023.06.01.08.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:01:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH v5 6/9] PCI: qcom-ep: Add support for Link down notification
Date:   Thu,  1 Jun 2023 20:31:00 +0530
Message-Id: <20230601150103.12755-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150103.12755-1-manivannan.sadhasivam@linaro.org>
References: <20230601150103.12755-1-manivannan.sadhasivam@linaro.org>
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

