Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F106F900B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjEFHcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjEFHbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:31:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDCF5FFC
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:31:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-643912bca6fso2122261b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 00:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683358312; x=1685950312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hact0AkOI0DQGjwOBLvh9UZ6v/o0AVZ+jUuWAd19+iA=;
        b=wJ4krpkCp5ZCptdV4UrMvJ+qeZN41nNkdJIsci6UVWSmEmJx9CvJ3GNjm7F7MfzO8a
         yoWYEh6WGORd50He6SvmmvtM9EJ1iRFZwUAgNRvRU95AV0yGyefdM6oDltaqs3w7+Km5
         nF+0xdPTR69pMUyECu7ParKjkA6FdqfkIyvKujvTWa9ElWNliRYW8mg3RfXvZs60l0O5
         ekle4syynvnWw3Ask8JJciKu5Xp7HOwHInTXSL0wmYlBjT8Bb6T+EqvyhwRMLr4IiG82
         OgBPYLO0mJTLglkAnPsLdcIQxfeOZv7jW8JlLhNco6BrIWncAoqTBUweQ2LsBhonrWwH
         OI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683358312; x=1685950312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hact0AkOI0DQGjwOBLvh9UZ6v/o0AVZ+jUuWAd19+iA=;
        b=gmoTRYnJyEPJdUhrGpQ7HZqVrQ7l5Q0PMiruCkqzjoLoBbst/C+RX8RmtISsmcKWBa
         drepT3iWf+6aDHtEG8V8lPyR3PXEU99ByzVRFaqwimLWg1Rk2ViNzyRMddtiKGVcoJsr
         opAAqdLphB5JuKZksPj/sCFvhTfmw/HREhsetOQN1ZmhHd0h7CtcWnpoLsEsMtb+qlA/
         IZpX/+RlSE9/pG2o8zTSJ5QyaG8MVljB+fiDaYsvv1YH1ZxptHPhNAHcWkuUpmaYOO/5
         KrKlVhsc392hYllktgi4vtl2SKO6Jhw3tz55qTTwh2GEn2u2nZGMAAtbFv4UqRoBtZJp
         mtCQ==
X-Gm-Message-State: AC+VfDyrtw1aW2gzRlWqNIDeSRaYh6bZCs1cZtiiI2XtVIq6QljvkLZm
        0JIZRA89bDnJRSRuKCgyASBR
X-Google-Smtp-Source: ACHHUZ7hypBGwQX24ol8sl49Bwl+NCMY4kFJd6l0NwJZglho60oxwejFXJgLIkTJFM2lVMQvEESSGw==
X-Received: by 2002:a05:6a00:179b:b0:63b:62d1:d868 with SMTP id s27-20020a056a00179b00b0063b62d1d868mr6139777pfg.8.1683358312233;
        Sat, 06 May 2023 00:31:52 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.87])
        by smtp.gmail.com with ESMTPSA id z16-20020aa785d0000000b0062a56e51fd7sm2627373pfn.188.2023.05.06.00.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:31:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/8] PCI: qcom: Use DWC helpers for modifying the read-only DBI registers
Date:   Sat,  6 May 2023 13:01:32 +0530
Message-Id: <20230506073139.8789-2-manivannan.sadhasivam@linaro.org>
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

DWC core already exposes dw_pcie_dbi_ro_wr_{en/dis} helper APIs for
enabling and disabling the write access to read only DBI registers. So
let's use them instead of doing it manually.

Also, the existing code doesn't disable the write access when it's done.
This is also fixed now.

Fixes: 5d76117f070d ("PCI: qcom: Add support for IPQ8074 PCIe controller")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 4ab30892f6ef..01795ee7ce45 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -61,7 +61,6 @@
 /* DBI registers */
 #define AXI_MSTR_RESP_COMP_CTRL0		0x818
 #define AXI_MSTR_RESP_COMP_CTRL1		0x81c
-#define MISC_CONTROL_1_REG			0x8bc
 
 /* MHI registers */
 #define PARF_DEBUG_CNT_PM_LINKST_IN_L2		0xc04
@@ -132,9 +131,6 @@
 /* AXI_MSTR_RESP_COMP_CTRL1 register fields */
 #define CFG_BRIDGE_SB_INIT			BIT(0)
 
-/* MISC_CONTROL_1_REG register fields */
-#define DBI_RO_WR_EN				1
-
 /* PCI_EXP_SLTCAP register fields */
 #define PCIE_CAP_SLOT_POWER_LIMIT_VAL		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, 250)
 #define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		FIELD_PREP(PCI_EXP_SLTCAP_SPLS, 1)
@@ -826,7 +822,9 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	writel(0, pcie->parf + PARF_Q2A_FLUSH);
 
 	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
-	writel(DBI_RO_WR_EN, pci->dbi_base + MISC_CONTROL_1_REG);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
 	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
 	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
@@ -836,6 +834,8 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
 		PCI_EXP_DEVCTL2);
 
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	return 0;
 }
 
-- 
2.25.1

