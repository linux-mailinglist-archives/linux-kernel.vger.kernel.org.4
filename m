Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F126F900C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjEFHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjEFHb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:31:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C737AD0A
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:31:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643995a47f7so2455330b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683358316; x=1685950316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMSlOb87FN5avnZVZsaz4/X3lkPSsnKywRngv2+jGMo=;
        b=IqOL4+Lh/a97EkERAXTgr7jujAWGzCQz0IsxYCGxnLDPs7bvD06IyTDppzQ3FtiPHP
         zvviPIGyG8KOIVzO/L75hGSk23gAPKURAvWnp3ifjSIaK416CkdWV4WEwB+MVCZlFyaY
         wIc3WX12RTKSKFBhkki9mQXczsUa34OgL2dsTsIUeGgGHCk4gwDIgm+fciAsXcizuS/M
         9J68zAnzHCqOqL0/Kd/x/p720kpbpVj2YvD6BTpVlS9Ok920YzIcmqbTLhyTojIvfJT/
         zGE2yT0Nqq4XGVazSquKuCLamnF27oPDv2IpDBl7KG+0Wwe72mmHM4BOOtu73OWOQM4A
         2qjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683358316; x=1685950316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMSlOb87FN5avnZVZsaz4/X3lkPSsnKywRngv2+jGMo=;
        b=G6l8Cu1MPjQj20tc9LgoCG16YVQzUhB++pcsBq5l8BToNRJ25cMVy96Ly6kUtGQLrK
         dePyw3D0rn7AYsnFdn0kn/REVjXO2w7A6RkoEkj4sVyCOwYDZJdCLKLGdA9ZuyFVZb4B
         QVwJWUJbs0Q0FxF74r80YaT1Z44iN9qBocr2c1zHWP3L9UvbY1OcuwKvLjCuz+DCRvUv
         3MWFBGWx5qgAfzhZd+luYLe5xrS12xK+fVDIfb/VfFnAzekTmFo9n//m3tSfi95GhzaE
         WbZRwPwD+pRAsfh0d4pptprj5CFzqzQoqrwx0c4aKK0hoBWlfkVin368oqPU9cunRDlO
         AeNw==
X-Gm-Message-State: AC+VfDyUzYeXWvQ1dCTF1FwA9BVopPFdL23uPLvFnJPtliCaDspgeJ6O
        QAWi4jP/xrwaAwNdtC1swKgq
X-Google-Smtp-Source: ACHHUZ6/7k3ICwpUmarOSL3/lK2C2lS+5gVq0mwo9Jc3d6Nd/xkTRpbwLxvQ9ya+kYA9UCoZSN4jBA==
X-Received: by 2002:a05:6a00:849:b0:643:980:65b with SMTP id q9-20020a056a00084900b006430980065bmr5241008pfk.2.1683358315860;
        Sat, 06 May 2023 00:31:55 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.87])
        by smtp.gmail.com with ESMTPSA id z16-20020aa785d0000000b0062a56e51fd7sm2627373pfn.188.2023.05.06.00.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:31:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/8] PCI: qcom: Disable write access to read only registers for IP v2.9.0
Date:   Sat,  6 May 2023 13:01:33 +0530
Message-Id: <20230506073139.8789-3-manivannan.sadhasivam@linaro.org>
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

In the post init sequence of v2.9.0, write access to read only registers
are not disabled after updating the registers. Fix it by disabling the
access after register update.

Fixes: 0cf7c2efe8ac ("PCI: qcom: Add IPQ60xx support")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 01795ee7ce45..391a45d1e70a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1136,6 +1136,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	writel(0, pcie->parf + PARF_Q2A_FLUSH);
 
 	dw_pcie_dbi_ro_wr_en(pci);
+
 	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
 	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
@@ -1145,6 +1146,8 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
 			PCI_EXP_DEVCTL2);
 
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	for (i = 0; i < 256; i++)
 		writel(0, pcie->parf + PARF_BDF_TO_SID_TABLE_N + (4 * i));
 
-- 
2.25.1

