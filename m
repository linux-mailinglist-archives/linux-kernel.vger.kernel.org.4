Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9294371EF51
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjFAQjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjFAQjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:39:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C85919D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:39:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso761891b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685637571; x=1688229571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzV1ZtX30jIpTNOGlDajFE+kq9Q8oevaq3YwpxK0i1A=;
        b=D+wcQzBeTbYTHWlZSm0qieGBvVgH+9eec35aDr7jm1X+DPUNgAodL/jJQRfmH14w1G
         5IKKjNbSifFMI2aN9uz4ncyxUkmF54jbIhlPGn8Vz0BDlLrh4OV4J5z/DSgEabWLDb+m
         kPyOvvnDZ+oW3yC8Obc+QPfrq7D7txM4gYEpZ0Ol6oS+PvsDBUZuz6bUhrDd20x7RzyE
         K+eKl6SGOwhdbr+MXvviHpTCi5QdWskCsqBSoY7fChNVHFmhxfeXsI4BVUVRUloyaz+p
         qYcCQ6Ieowk0rhvQ4AI4uyQVaoqRelhm3UhFTNQh3d0hkic5c2udq/FKN4dHggR4Hwyj
         MBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637571; x=1688229571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzV1ZtX30jIpTNOGlDajFE+kq9Q8oevaq3YwpxK0i1A=;
        b=dk7zZTGvgp8pcEzVplIY/VxA6vMAI6E5yxS3Q1q5w/SkRRaUaS7qk3jjF+tbBsGb0+
         4ymZVbSMCd8miax8Q/RiXHcZH92cffbmB5b5Ks6H5OPL6fLQdr5IrueAGIB4YPsxeM7L
         36IvATJegOYsRTbMlaNxAXM03YukmEHmAqcPg+S7dl0iDAAYAw/OSXYXfW1wO99QOxo8
         kHDghBFutbX7Zj+HeXiQfv44CKanoIEs1La4KQ9YDcA1S1M4xnoxWw5r9oWdRy7VEfFw
         Z1LHplAYh0yZ/MeqJByoFeT03r/sPRk482GzuZD/RGlAtrQsnAck4guoTwXW0phCoqj5
         gA3A==
X-Gm-Message-State: AC+VfDxvAaQEI7Cn8cJKKGEqVtID++s05pQp7x0l01F1xmBQnUNs7GDG
        LiGBS5z8xeuZ3HwuC/Udk9/3
X-Google-Smtp-Source: ACHHUZ4Jx8wtnSM84R9/MxZJSKPCYzukItjK/PIpjZjyIfvlM7fUGSVPHnGzfLuRrzq47Y9srH93/Q==
X-Received: by 2002:a05:6a20:7345:b0:10c:1076:ff69 with SMTP id v5-20020a056a20734500b0010c1076ff69mr8049876pzc.48.1685637570874;
        Thu, 01 Jun 2023 09:39:30 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b0064f83595bbcsm5273630pfo.58.2023.06.01.09.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:39:30 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 4/8] PCI: qcom: Do not advertise hotplug capability for IPs v2.3.3 and v2.9.0
Date:   Thu,  1 Jun 2023 22:08:56 +0530
Message-Id: <20230601163900.15500-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601163900.15500-1-manivannan.sadhasivam@linaro.org>
References: <20230601163900.15500-1-manivannan.sadhasivam@linaro.org>
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

