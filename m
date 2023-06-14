Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4718471EF44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjFAQkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjFAQkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:40:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE976E53
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:39:43 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-652699e72f7so178447b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685637583; x=1688229583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkQkFXSrqR5MDMbqBcH7Nxin9P2rGGa9soJkqC/yxfY=;
        b=B341daAOj2uN3XSIUlP1VcnuxzKjCIfk1SWh8pVAtepYMfhkydQ5wmsSXtxJ4mJ8Lf
         lvBF1ARTk4lwamQZXgAdcZ/Jd7HD4kseHqPognfcSnPBTufXm2GJaN3Rx7NWvPHviPW2
         cWEfldgLVniflYncZdFarISJodJymcbJwES66t0ZUWO8nk9HR1bV5ryFVMspTIHQ4UI9
         d5+M1huNAlHbh1mOQXTiRRBQY+S6qXmIm0gL3ob0kT+r9tZja4A+6+PUAAWq8BFuEDpt
         fysNlcxESgrNOSr9YCxNvAa15+3C48zgHETr5q/zYA0F8geyUmEfOeemyEApTuAMg6E5
         KDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637583; x=1688229583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkQkFXSrqR5MDMbqBcH7Nxin9P2rGGa9soJkqC/yxfY=;
        b=k7dnGibE514u1oA5AlOQORe9WDB5rYAaKho7Iv5bpyur1pshAewTa2bxztkfNAVrVw
         CUIXQA8DIFwD6urih/91KzhUuuyIpv+qhe5mGgOKFdhcCpqP+g1sCbbzWxAVWAuokjUP
         NPXNYB50eyW8BOsnu1FhjDYIpfWQPw9KOQPVrt/HDit+laxtaG1XoBhBz0fNbXjY1OSw
         L2hIK58OcN0z1OXw8VQzixYUEhlH095rfMJM4er0p1z76oFJmjKIL1dWg8HkHK/iUOJo
         mCiSHqzBga8SA6TdYMG2YkyjIf5a0EDAvr6SPNsAA8eTXOyPCDmE1ZwTsTARlZ3bRUSV
         6TkQ==
X-Gm-Message-State: AC+VfDwltsLDvCZr82VXEj8jO5VeMlDko5HKvJFcvhGNxk7P3crA3MQG
        c6skgitBbdNSfmrRwfHy6xOP
X-Google-Smtp-Source: ACHHUZ7Pvb3CcXxxu+Wa3w24gX++w34Ip6NVCoreX56/MrrIXw8gaZkOS9sqBqM54jlhghRwgYwhGg==
X-Received: by 2002:a05:6a00:986:b0:63b:19e5:a9ec with SMTP id u6-20020a056a00098600b0063b19e5a9ecmr9215482pfg.33.1685637582956;
        Thu, 01 Jun 2023 09:39:42 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b0064f83595bbcsm5273630pfo.58.2023.06.01.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:39:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 7/8] PCI: qcom: Do not advertise hotplug capability for IP v1.0.0
Date:   Thu,  1 Jun 2023 22:08:59 +0530
Message-Id: <20230601163900.15500-8-manivannan.sadhasivam@linaro.org>
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

SoCs making use of Qcom PCIe controller IP v1.0.0 do not support hotplug
functionality. But the hotplug capability bit is set by default in the
hardware. This causes the kernel PCI core to register hotplug service for
the controller and send hotplug commands to it. But those commands will
timeout generating messages as below during boot and suspend/resume.

[    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
[    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
[    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
[    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)

This not only spams the console output but also induces a delay of a
couple of seconds. To fix this issue, let's clear the HPC bit in
PCI_EXP_SLTCAP register as a part of the post init sequence to not
advertise the hotplug capability for the controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e6db9e551752..612266fb849a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -521,6 +521,8 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
+	qcom_pcie_clear_hpc(pcie->pci);
+
 	return 0;
 }
 
-- 
2.25.1

