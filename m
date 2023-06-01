Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0078A71EF46
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjFAQkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjFAQjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:39:45 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815351BE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:39:35 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-528cdc9576cso619357a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685637574; x=1688229574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltCiTsDOD5ydUGLVe1beQMJS2WLXn803YOi09x8rHPs=;
        b=xxRQyB0umoYR4doJKWn2bRmQyS1b/dVaSXq9Fsga/Zdsnu0iSl1xFY1ixF0mHFVQhW
         ePRGU+WfpqNtH47KurdQ5NZIjjkpd8N3Ucgx9eDcqb1ClOW58wVqEM6tzWUahYJr0RkR
         XCxdivA7ir9XpmxhiCSxbIfGnelC0Ul974hGVQN7lo3Q+XaIPTr84eYixV1Bd+oim4eJ
         pxys22UBlDsjBTArd03E2bpDjVPrI+arhL72P+tj8Mx5mI8thcFLmiAGkHyhGAbR7pjB
         qkcFIo9RlDfUaNjBleY59vfj8BbcGiYxkiW7nJEGfgJpLa0v01Oe1MzS+zvAQg2LqRbg
         d4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637574; x=1688229574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltCiTsDOD5ydUGLVe1beQMJS2WLXn803YOi09x8rHPs=;
        b=BF8Y3NSvEXcci6VYlQoSKrGLUeOS5Se2mE3gmr2QTGtmCZlaTX0KmmBebRjZw9PXRH
         IaL3/GqsZaigC7wdHj+nA+XVAyDOMH1PL1kOTHlrpOfPmSt0kzoOlA3AuwDpaeGKerLm
         QQgc2d2uB/aRBaGciMq5nnBhnJkCblI31QJVzynANggXgOwEZVG3lsL0l25Zr5rlR1dY
         fd+HgIcMAxq1HwZIywRB7BvLDPe8VDqLETHwxiwOPZs9T44xZdQf6tfI4U+NgqK3X6Xc
         z5/OO3ACW5A1ex/AnFn/GeV0PAUOWwjeJjXf/pT6kpsp5nD2fI1wZNOOrj0PetGKg9eQ
         K3Pw==
X-Gm-Message-State: AC+VfDzmqzzrSFgi+x4Ks8ESDIjojEdjjTxIRu/k81kDf3ZlT7mijiFc
        Zw9YHKmBfYIE2bgqjNZpO0Og
X-Google-Smtp-Source: ACHHUZ7byDbzjNm8+urxPBG4an1LcDKnIV7vixubuE2mGJxqEjQYKFlNo+gcyvoJE0uxn4ylXwgA5Q==
X-Received: by 2002:a05:6a20:3d0f:b0:10f:9317:153a with SMTP id y15-20020a056a203d0f00b0010f9317153amr7926215pzi.62.1685637574709;
        Thu, 01 Jun 2023 09:39:34 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b0064f83595bbcsm5273630pfo.58.2023.06.01.09.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:39:34 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 5/8] PCI: qcom: Do not advertise hotplug capability for IP v2.3.2
Date:   Thu,  1 Jun 2023 22:08:57 +0530
Message-Id: <20230601163900.15500-6-manivannan.sadhasivam@linaro.org>
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
 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 64b6a8c6a99d..9c8dfd224e6e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -616,6 +616,8 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
+	qcom_pcie_clear_hpc(pcie->pci);
+
 	return 0;
 }
 
-- 
2.25.1

