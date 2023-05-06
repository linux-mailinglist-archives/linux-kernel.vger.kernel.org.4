Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B66A6F9019
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjEFHcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjEFHcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:32:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B344CA5F4
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:32:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64115e652eeso24375742b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 00:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683358327; x=1685950327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shRj8ftKXp337A2020wykIm+2u6OMQWOSQ5tcyDxEKE=;
        b=hxv1KxFuTlv4Tsnr7ZmqXer+eNX48oCZLX02AzcyHqkZItHhulNrlXaKKcMCaZQB1b
         vGK1GZG4HdObP7FU8u9bKKI+pEKRzOD4l0vLrtQN1DLWwDcWFfgRgJCBtE2aoW/pxcma
         ewPEYsWXnAOEVbz0R4icvIeOL9yKH7rZTR+gP27SQF0n9P3++ezkz69+IBRVJNKVG75G
         hHPGUA5TgH2oKIMdPgUZ4HoITNKGlDvtY5nAFsryTKN6yrlTokoLgooGEax8J4oyEs2l
         NcFY/phTAeyzN0wgQbvZizS4Icoq8lFlWYlWlsFEed1oDk8ZZhragCCCwjDOmDgpbJUu
         GUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683358327; x=1685950327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shRj8ftKXp337A2020wykIm+2u6OMQWOSQ5tcyDxEKE=;
        b=AaqmGnNWCZLqc/vycCwPioCpBCvfUmljigvuPmLI2gaATOSxYyoGs8Zz3/xo/fCZrj
         lVjE4K1GiecIbehS6c46Z2FSNRlQxqqUI4XGWT7N4bdK7qVnP6hrUAoq3E9Dj7l63wny
         Bx1mI/4677O5VPGEfIs3H2UbdVkn7q2F0eo7hjazusE3oayQV9Re5JcMV/fiR1D/trOD
         VIRdZOcrsgBnmn925hbpLI4E1/T2rr1ielXNK43wQzt70TpXdVxo+HNFQ+o0fyjVYMKE
         X4fTVygCDyBWVUDfUlii2zZaz7TVQ435u/T6fSW99hMCzakXIdCLo1j4aApNonX80UzF
         RvJQ==
X-Gm-Message-State: AC+VfDy3O2e+/DJ1eOS5CFxnWrX9bnQ44uud5/3sy+vNQBIbJI5aYdx1
        podPPhBYZKd6emMonqmPRaxllvdCA6EiDZH9Aw==
X-Google-Smtp-Source: ACHHUZ7dpcd0D4YsaxVcHI1w4f6c80ydAdAbkjtOOgUMJANudB+JuI1nwYOlQqQhDq08MYkGpUwMaQ==
X-Received: by 2002:a05:6a00:198a:b0:643:5455:2577 with SMTP id d10-20020a056a00198a00b0064354552577mr4523912pfl.3.1683358326780;
        Sat, 06 May 2023 00:32:06 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.87])
        by smtp.gmail.com with ESMTPSA id z16-20020aa785d0000000b0062a56e51fd7sm2627373pfn.188.2023.05.06.00.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:32:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/8] PCI: qcom: Do not advertise hotplug capability for IP v2.3.2
Date:   Sat,  6 May 2023 13:01:36 +0530
Message-Id: <20230506073139.8789-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
References: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoCs making use of Qcom PCIe controller IP v2.3.2 do not support hotplug
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
 drivers/pci/controller/dwc/pcie-qcom.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3d5b3ce9e2da..33353be396ec 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -579,6 +579,8 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 
 static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 {
+	struct dw_pcie *pci = pcie->pci;
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
 	/* enable PCIe clocks and resets */
@@ -602,6 +604,14 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
+	val &= ~PCI_EXP_SLTCAP_HPC;
+	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	return 0;
 }
 
-- 
2.25.1

