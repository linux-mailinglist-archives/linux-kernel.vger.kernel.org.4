Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D0D7099C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjESObm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjESObi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:31:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B11187
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:31:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25332b3915bso2672073a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684506697; x=1687098697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zLG4dTgi3xTplGTrfZB0o1fFz0ivS0ryK10HN6uoQ0=;
        b=qGdwPEmy69hz5bwluW7Fq1zj0cnJ763Juy1Q9I0nI60SqhiOMAI8IPYFfjjUoKmMh7
         Z9rFHOxQmXWKEMJcqr9ebxI6WhpQLQxaMvFD6YkvQW1txWwTE+0341WLdr4r0AfmFlbp
         cCcsBAwjjNgAqRCKPBpIvyEMoZh666Jzw2ZPnL6epW++0h/lWQozK6G9CyBihIo6HK7s
         x7IM+fG1ck6w6IWX3LXHo/VTTEKXIYw7pR1AHukHHugbm5I04nkIkC9Goj/fqaS9nxuI
         9eD6O0dt/eCA+q07GH2Nuaob+YogjGYjEjt0JXz90qDzXSG4dAtug95Hl/APgOpxoeFn
         1pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684506697; x=1687098697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zLG4dTgi3xTplGTrfZB0o1fFz0ivS0ryK10HN6uoQ0=;
        b=QaQfrnPoC8F3jq0gZQwRR7scSJMNmHZx1tIpeiWcLFdC6mMdRIFMzs1RUvEFlhEMjG
         75BJwfgSmr/ckx2DLVQmah9+/9apGmI8Vt5D9SDJbzn7kfykHdmkslsHC5ZQMjd0qTgO
         jMJskJz9D3vGN/xEZlo/M+u5fitfn7TvpPXEDRm68cLq1y5TQ64n2sQOY5UAmmueLYpP
         aDy4rm2e8YOToR623E2PjgSWDAZzhkOGw4JGFTU9UaUdIxi6lZgV3mXhqEjPpl8F7qWT
         IyfHWqlYUCUAXjQ4JBNar6jblZzSlpnqLwXV2WOG7z+yDIFEsbh9R7I0RkrlfOVyq6yM
         oe2w==
X-Gm-Message-State: AC+VfDxlGQUnanb5RuTXRcFQv6g7ytz5iZ1PaSy/fHrwDEKy6J7WrcKw
        EkYsXAOyarFwWYRupoCVTo0/
X-Google-Smtp-Source: ACHHUZ7dxJ79BWs/7muqKSgLBnCVO7scQ7im2fPjzEq7ZYtBAxNGC3l855k3KgDIKAgSJ5QGWlmbjQ==
X-Received: by 2002:a17:90b:3648:b0:253:927d:6a36 with SMTP id nh8-20020a17090b364800b00253927d6a36mr716888pjb.18.1684506696910;
        Fri, 19 May 2023 07:31:36 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.13])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a09a100b00250d908a771sm1634845pjo.50.2023.05.19.07.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:31:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@gmail.com>
Subject: [PATCH v2 2/8] PCI: qcom: Disable write access to read only registers for IP v2.9.0
Date:   Fri, 19 May 2023 20:01:11 +0530
Message-Id: <20230519143117.23875-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519143117.23875-1-manivannan.sadhasivam@linaro.org>
References: <20230519143117.23875-1-manivannan.sadhasivam@linaro.org>
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@gmail.com>
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

