Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8567099DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjESOco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjESOck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:32:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C64E60
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:32:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2537909d28cso777896a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684506723; x=1687098723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAHgbKUGLDFGyzp+XWYZ2sseIunYBsYQIO/Xldf05CU=;
        b=GvXGvNsaT7/5inshDPfJkzj0LWRNaGcBA3Ja8kveCoTlHDPcoyIo62P2bRx/jlufmp
         5ND1hfWqZ7qMQbxbjvT19uSrYM0qycwqu++VsvfHja0ofRz2g7WzSIH++lohamsrwWPb
         Br1/35TWmItJVR+41jgSKnCl3ru/XHdzFuDiK5bDf6mnriLKSA1rb9+65F539O96rYE7
         P1ke++e4vMO58Phpz29rS6is6e3cq/pWnWpDOy0OcoBJF/VIZ18TEawpwD99DUmfJ0qn
         F05QWqEXVVDUhjJjK2pS8vHBlekfiChQhY6Tnoh1M09SlNCw6pWJqsoChpm5ggulP3wY
         82Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684506723; x=1687098723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAHgbKUGLDFGyzp+XWYZ2sseIunYBsYQIO/Xldf05CU=;
        b=OFMirUBNDFYXt8gsp5jtyGQQJygao3pjjjFZApI1Itq/Rt87USGGra5sJ7kGlo9yKq
         dN72hPhCh1V1GgPLSe+uQjjvIFD8/ei+ML6gwCrxpHs0L/YWKS4DjL7Ia1mh0HdrpIxK
         FoE0EXQQzc0hExiKPg3A1TMRJ0wsE5G8/PtR2W9vJ1nCfJnQgVVoYItUMbebQQ4xR2wz
         cPzgCETPpDz8GG+q01+MRH/jLEIqwvfALQk/9IIqUKi9qNy3e46munn5HfJsxH28PY6R
         2FKAinf2LGgF9SfnHLp0z2mfDf7y6xt9xdbzzOWk4pl5pSO/LGrgDrC9tF1hKxdz2Elj
         W2wg==
X-Gm-Message-State: AC+VfDxAPWhY0/1CcSUJxC88h8OWfbmYFti6T2PUNvQt/T8D7aeLqdiK
        dqm6276R9MMp3Uk/2AjDdtcy
X-Google-Smtp-Source: ACHHUZ7/XjprjaCK6xRs1WdONtFFs1DjhFLoZ10cR5Cz0B+lSKNv3kPgBw75xSodoC0Keq0vr1mFUQ==
X-Received: by 2002:a17:90a:aa92:b0:253:3662:9825 with SMTP id l18-20020a17090aaa9200b0025336629825mr2387535pjq.8.1684506723555;
        Fri, 19 May 2023 07:32:03 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.13])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a09a100b00250d908a771sm1634845pjo.50.2023.05.19.07.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:32:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 8/8] PCI: qcom: Do not advertise hotplug capability for IP v2.1.0
Date:   Fri, 19 May 2023 20:01:17 +0530
Message-Id: <20230519143117.23875-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519143117.23875-1-manivannan.sadhasivam@linaro.org>
References: <20230519143117.23875-1-manivannan.sadhasivam@linaro.org>
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

SoCs making use of Qcom PCIe controller IP v2.1.0 do not support hotplug
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
index 612266fb849a..7a87a47eb7ed 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -438,6 +438,8 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	writel(CFG_BRIDGE_SB_INIT,
 	       pci->dbi_base + AXI_MSTR_RESP_COMP_CTRL1);
 
+	qcom_pcie_clear_hpc(pcie->pci);
+
 	return 0;
 }
 
-- 
2.25.1

