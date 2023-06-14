Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF271EF49
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjFAQjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjFAQj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:39:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8DE198
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:39:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-651ffcc1d3dso324187b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685637562; x=1688229562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnYTPbLQMWkMCSqucReygW86UFXzEWRo6n6RYpHSl6Q=;
        b=wBzO85j2VUs9YE2cSVZyHuuo6cJgjcFFmWfUvTqI0j03fYivOlmMQ0LUG54ux43OkI
         YX2IM7GvQoBOyrdcJ6+WLeCNU92B5P7+zTZfu3T84UNy15g3EQeqYr6n7NrPSrpjEWI7
         uc5Cg/Ropok7Dzj/CSBJva9AnzFYzsIcvVPQiUN5cAf8mK5G8o05Q31BLPO0bA0rgJRz
         Ez62Tzxe/0uXDbeJ+noflCx5tH47XEOQLu7jE9Mm2tXBqbxX4Gb8mCe/mwPhwa3uKDLG
         gCqA6/sFEgneY2tp8vT29T5h5tb7A+/7o+1PEKeHuPFy+6WHQHaJjaGk5/hze40aI4xQ
         n21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637562; x=1688229562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnYTPbLQMWkMCSqucReygW86UFXzEWRo6n6RYpHSl6Q=;
        b=L7u/BfCwaw9wTM0/qj8J8UNAZd70x1hE+6ihpykg0HLtZ6q2D0PX/mkQ8yhh3ItW/D
         4Ottkq7XdeNri5wC2z9TMLI9cilWpZJGCnGSwnHO50mzaS0KNP6IA70Z0Cr29Ou4+gph
         JIXAhN/n8xxseQAcvVH31CnPv5JkTQ+GP88NYYu/J+HGxkT9Fsyr9gemhJ/bdaLSBYYI
         c8WOGAHc872R/48AeZjrkzsG7mYxaOvLqTGIMrhbMVjm3yyFBwjPAvNsqZBeOoTXdGzp
         oNJzlA7klfJTtFz1LuBvlN94YNUa47JTJUyk4cT37ZdP/hpQ8nW/1fHjoiVBIvMrEkRw
         T+Eg==
X-Gm-Message-State: AC+VfDzhUGry9C90reSgINmzXPAV8rUVOhSdvzMweDPQsumocRZd8b8x
        XDgVwzSk4oTKtlDb2/hHbXwU
X-Google-Smtp-Source: ACHHUZ7GGUssnqY3zrsliP+PpnBqOwj5ZWl9h6filq5WyYsAf+Pa3qWRDc/MTA7S3oORNC1o9xF9MQ==
X-Received: by 2002:a05:6a00:1594:b0:64f:daa6:3e3f with SMTP id u20-20020a056a00159400b0064fdaa63e3fmr9799969pfk.5.1685637562607;
        Thu, 01 Jun 2023 09:39:22 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b0064f83595bbcsm5273630pfo.58.2023.06.01.09.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:39:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 2/8] PCI: qcom: Disable write access to read only registers for IP v2.9.0
Date:   Thu,  1 Jun 2023 22:08:54 +0530
Message-Id: <20230601163900.15500-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601163900.15500-1-manivannan.sadhasivam@linaro.org>
References: <20230601163900.15500-1-manivannan.sadhasivam@linaro.org>
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

In the post init sequence of v2.9.0, write access to read only registers
are not disabled after updating the registers. Fix it by disabling the
access after register update.

While at it, let's also add a newline after existing dw_pcie_dbi_ro_wr_en()
guard function to align with rest of the driver.

Fixes: 0cf7c2efe8ac ("PCI: qcom: Add IPQ60xx support")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

