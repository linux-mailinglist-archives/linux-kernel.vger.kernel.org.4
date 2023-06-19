Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803B7735AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjFSPFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjFSPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:05:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6793F19B7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:04:37 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-543ae674f37so1821002a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687187077; x=1689779077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzV1ZtX30jIpTNOGlDajFE+kq9Q8oevaq3YwpxK0i1A=;
        b=fMVP0famGSK6/m4FcwKj+6ky062gCAOpAnkt/sZ2VGVyb9dams7xgPlZYxk2abPxAG
         M7rAhy87w27XFGQiuj/RBnSRZ1V9JweXWRs1qPWV20UAdE4D0VrCKnAxFS1q69ya3g7s
         GEBJia4tmb1PaEItzzIDpwgyf539obnQeFocpPD+XUEV94cQCtBCAs/RCrTaxpKuLsJi
         yzSwbHbtKHCaXldbqJ0COxxfYkOnD0rSu2TjNR0OWe4thdYAnTYcbAVtWgXnIj7Kb0Do
         CYIeAW2J7oEsqWd49SD8CVlzRIVEJJ8UZvLiuOLdzQzU5NMcYUQah2L/6cWtUTonDRdy
         ZC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187077; x=1689779077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzV1ZtX30jIpTNOGlDajFE+kq9Q8oevaq3YwpxK0i1A=;
        b=ePJk2CPckE+MRF9sXx1cbYl6QrzB6UET2yWPOUpC4l2zK8fws4VPcvL8siKmGuW3oH
         0Fbsm8lpi1bqjKx2fWc7SzKj4xVuYEjESECXoUGvY5ZJimDngwFyjKMoWY7m+eqR+CVA
         oHKy9tIvhTOTj44ssOEcjIcdsanb74toO2+5o4AIQKvnyWsArHsVTkx3c7G0v0ISZbah
         q7/45Zere2gjftlK749jlWwNEsUvvNc0yOipXgdcpdCiFDSYvef1Ija2YUTj9eJNQ1Ij
         j+PrtsUvI3OeYeiSEjYvTr7jP70agH2usZdzDkaRMckPo3wuIGhGR1zf76avCI6aXDuD
         0qbQ==
X-Gm-Message-State: AC+VfDxkM6F+vYyIo0y2V7E2cHWHQIALVF/F/ggmqRyIMQRFAw5JVGEJ
        gCOZByNbdhSCT6EqxE+bKrJu
X-Google-Smtp-Source: ACHHUZ60YQ5YnGIsrISqp6t96KlcerAHzAtsdaB8aBfOYilDFQxsVATkWg+lo2y3VZkqEC3vTnEmLQ==
X-Received: by 2002:a17:90a:656:b0:259:343:86b5 with SMTP id q22-20020a17090a065600b00259034386b5mr7427310pje.47.1687187076753;
        Mon, 19 Jun 2023 08:04:36 -0700 (PDT)
Received: from localhost.localdomain ([117.217.183.37])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a19ca00b0025efaf7a0d3sm2765480pjj.14.2023.06.19.08.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:04:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 5/9] PCI: qcom: Do not advertise hotplug capability for IPs v2.3.3 and v2.9.0
Date:   Mon, 19 Jun 2023 20:34:04 +0530
Message-Id: <20230619150408.8468-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619150408.8468-1-manivannan.sadhasivam@linaro.org>
References: <20230619150408.8468-1-manivannan.sadhasivam@linaro.org>
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

SoCs making use of Qcom PCIe controller IPs v2.3.3 and v2.9.0 do not
support hotplug functionality. But the hotplug capability bit is set by
default in the hardware. This causes the kernel PCI core to register
hotplug service for the controller and send hotplug commands to it. But
those commands will timeout generating messages as below during boot
and suspend/resume.

[    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
[    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
[    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
[    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)

This not only spams the console output but also induces a delay of a
couple of seconds. To fix this issue, let's not set the HPC bit in
PCI_EXP_SLTCAP register as a part of the post init sequence to not
advertise the hotplug capability for the controller.

Tested-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8f448156eccc..64b6a8c6a99d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -140,7 +140,6 @@
 						PCI_EXP_SLTCAP_AIP | \
 						PCI_EXP_SLTCAP_PIP | \
 						PCI_EXP_SLTCAP_HPS | \
-						PCI_EXP_SLTCAP_HPC | \
 						PCI_EXP_SLTCAP_EIP | \
 						PCIE_CAP_SLOT_POWER_LIMIT_VAL | \
 						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
-- 
2.25.1

