Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3518A735AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjFSPFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFSPFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:05:09 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148DC19A7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:04:23 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1a9d57f8f9fso3311473fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687187061; x=1689779061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0m9rhWOn8qYbjuVQmQ20zeGCmNCpO//YkkWL6MmvNwg=;
        b=X4rnGsDhhgcstlEOl2O8Xh0D75fvA4vp4Lp/Hch/7e27uzGYUexdfNn8ekHr0mFBme
         xRW2Jgigs40z3tnW83vRGWXtbHyCNxWMrMBZJ6b1+dj/QesU3nVfa2PCr01i4TxFgyl5
         JBfJcs93mVxfsGsi6e5la8UBwnx4Ipd7LNTUrMxmhu+eV0oXz/Fh8ARus8WzXPrPV/RS
         lHTfF2qz+tPJkpSeHgniix7/lRe+ods8MgZJ1EIpBI2htcjR7+uqSkL5vkczsm7R2HpG
         aU2lpY8HphbspEUze2dxaRhc3sjMSJ+IqLTvOqRFsi5UolLc0LtUzb8u+bMHAMdKZW1N
         WU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187061; x=1689779061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0m9rhWOn8qYbjuVQmQ20zeGCmNCpO//YkkWL6MmvNwg=;
        b=Kv8l4h1HWnKWtaE2ehEhjhik805PqHfJ3iOl7ca8nJfHVeFwrBL1KXtcWrGs9b8faK
         c8BsZkHl0wxoIy+zu+KTxEkAa8JADQiOhy08yFq3KaUteHljv/bs5yMm0pcmwgBwzQr7
         zqfHC+zEHyDZxMe+SEessxsCc5eQfXdYovYZ/2QC97fy+/Bnfrt+9IfRVyrvlQX76w03
         9zQtKsBg32V+EI+ObXNqFNLhthDqSwYH3jxj07ePylU996ecOuwm6/S6//8VFZS1La+m
         6MpJUElZ3ThR5+gWIRatbqx4ULtwRHWVoOWwc2E7krkEMgP6extqC5YTgy8ht2wjyzcI
         v5Wg==
X-Gm-Message-State: AC+VfDxLG2zuXsaZjm/crNNnr+PRiyqGV1Q549DkvIuuWVIipDHl/b5F
        NUdcg86RIP9h9zOJFDMqu5aI
X-Google-Smtp-Source: ACHHUZ5vRE7brlsRPe3Zp8R6nDsOTJqauqzXZH+wyitHVFyn/PXC/KWiff8ZoBlpQBA7Fut4l4DxOw==
X-Received: by 2002:a05:6870:4710:b0:18f:558a:1f51 with SMTP id b16-20020a056870471000b0018f558a1f51mr11017078oaq.53.1687187061309;
        Mon, 19 Jun 2023 08:04:21 -0700 (PDT)
Received: from localhost.localdomain ([117.217.183.37])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a19ca00b0025efaf7a0d3sm2765480pjj.14.2023.06.19.08.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:04:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v4 1/9] PCI: qcom: Disable write access to read only registers for IP v2.3.3
Date:   Mon, 19 Jun 2023 20:34:00 +0530
Message-Id: <20230619150408.8468-2-manivannan.sadhasivam@linaro.org>
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

In the post init sequence of v2.9.0, write access to read only registers
are not disabled after updating the registers. Fix it by disabling the
access after register update.

Cc: <stable@vger.kernel.org>
Fixes: 5d76117f070d ("PCI: qcom: Add support for IPQ8074 PCIe controller")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 4ab30892f6ef..ef385d36d653 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -836,6 +836,8 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
 		PCI_EXP_DEVCTL2);
 
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	return 0;
 }
 
-- 
2.25.1

