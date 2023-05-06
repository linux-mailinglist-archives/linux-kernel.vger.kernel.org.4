Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE896F9013
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjEFHcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjEFHcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:32:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852D611B4F
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:32:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6439f186366so1096287b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 00:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683358323; x=1685950323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0cuEgJuHushMGf06sKVJF54IdMYX1ODr1anndZly5Y=;
        b=MASRw1jou8CKtdgS0fQmjwHGCCa0uKGPWDJcRBGuMkFMrTrYiGd+dfR5QBz80yO6ic
         tGl1k/gAMJvS51WuYXPTwRiD5HuwNXHiR6aDRX60RYwTLwsob9gKrLB9rJG1Z4cUictd
         9CRp7FweEoNHsPDldzl9uFJjsZMleaUhO7fgsGJPZnUABoPjFznBYs2dwaetwK/5Rfcp
         N3bhWCcAktcKONAgp6cqHDjNdORlCi3K+bSLb+eSJWX+4oMqveP8s4siRySszE/mmbPP
         NYgo1fdMbL50BzL5vMSbnqgkPJGtKnOinAk7QkGIEgu1EokbWLksMJzbcA+t6PAswPD/
         3Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683358323; x=1685950323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0cuEgJuHushMGf06sKVJF54IdMYX1ODr1anndZly5Y=;
        b=EL61ZY2OafP00p97pfZT6H3jhIDHQRPZ+ec5qFMUpyEdWyD4OJhAWnBx3ctw3zMyuS
         +0KTkj0Y9S7AExg4Axbbo09zU1kurKexMYm0+8aO2LRQB9wJyhJLCq9wkKHibD2Eoi5p
         EBt6U+VCsC/HYJefhb1yMaFk6ChbudLiak+eEssyA2iEZxvtSPpTcIPqjtZvVbPslMkN
         rcQnxGZNSe/fUeHGaJHvtHj3HIAIMBB5Uz5LjS5P7n1S1vK/4rlaJ+5uASezqND/aDGP
         u0lP50unbL3VrbnRS7oMye/gtfywA+x4m5ZahIXPIXmpIiu990IZYIkO2oZWWqgf/yK1
         AiEA==
X-Gm-Message-State: AC+VfDy3ZlIdHUXQfXaOanNUrufz8frJZI+cLJzR38p4G7O3uOZh/b+W
        31NRDNdr1ygF63t1qp/HEq1m0TiTkRrPHfmzWQ==
X-Google-Smtp-Source: ACHHUZ6e4AlNdAuSV+wPJZwngbB8YCfuQ4gKcqQiAJ0dAUbc6XCgodp/GGwwEBIoJtIJDDTpVDgFEg==
X-Received: by 2002:a05:6a20:4401:b0:ef:44da:9418 with SMTP id ce1-20020a056a20440100b000ef44da9418mr5387055pzb.17.1683358323105;
        Sat, 06 May 2023 00:32:03 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.87])
        by smtp.gmail.com with ESMTPSA id z16-20020aa785d0000000b0062a56e51fd7sm2627373pfn.188.2023.05.06.00.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:32:02 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/8] PCI: qcom: Do not advertise hotplug capability for IPs v2.3.3 and v2.9.0
Date:   Sat,  6 May 2023 13:01:35 +0530
Message-Id: <20230506073139.8789-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
References: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 00246726c21d..3d5b3ce9e2da 100644
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

