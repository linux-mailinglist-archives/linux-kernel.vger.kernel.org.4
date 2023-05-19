Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9627099CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjESObu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjESObq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:31:46 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30871E4C
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:31:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d1e96c082so1402405b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684506701; x=1687098701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOZDrOTir9e0F4bCVCZsnAsCgh/6hBvQB7yeRVQtUHA=;
        b=we37beDbxdZzher8V9DchuGEl11SJRpngPit9XLRgi3rTJwIZkIk60AT6f8eWHJEnx
         9psGkdAb/ZNpOiy7/BpBMf6rVM0ZCXHa9Rd7+WzBb6M/P+AU1zozVZ5sgRM2kM92pUsp
         EY7d35qecwpZlpr3Vi3I7bAJKxMItsV2oZOxBQEHfn5cPMk1WjesqEzbtjRK0ETNL8kg
         1bugU5bel6VYOgyX11W4bH2ps+b2e0UJtWD2KjRBLoN7ki/scD3bm2QPAapGgBvn7Jrz
         30xhxDt6V/0Xpmh+L74Tsy4gmDDCPvyMN7tLbcaPWfu/KF2fVa1uNNeIoSFzGcZnb7Xl
         dzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684506701; x=1687098701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOZDrOTir9e0F4bCVCZsnAsCgh/6hBvQB7yeRVQtUHA=;
        b=JIRBCKIjp+0uZorb44MSDqZHVufy6jbZ0/NS4rc8EdC8Nr3cvDOrxH+wsKjFM9Szh+
         7XlVyIcOa/tx/iR6dY0LnfKH+Bo04xdwzMdpRSJm6OFtnantlL2dwS8WgKM5x8Ud0jUs
         2D0ydyDFJi8mU4zG97d2e+uts5If+IMhZ2K0wRBjYzuyPkRnYVjiBQZgDgUNDPQqPOdi
         vML8T5sGeleGdUeVNv9P4E1IMLLHR2s6rC9bsv+5rEjAkOtE7MZN8mSGxtF7cvh29E4q
         DNuEuqExjBt9WiqCH/57l5HbtGdyHo1GsSd4NoFpYjTMm6UNQ1CO0xsnCT6jp2BSAuIc
         Ic1g==
X-Gm-Message-State: AC+VfDw+EMenGRaYbOEqPiudZqyZiUDKNEau0CmqQfbrIcbdWQ0XP+LF
        GdjG6wYVtpz8otG7+C/Y7SRP
X-Google-Smtp-Source: ACHHUZ7Ttof2PCmmd+oM41rgoBkFETTCwiSrdUrCEOIyErphm9VRnX70/cHBCdlc3FfPYN6aSKLGWA==
X-Received: by 2002:a05:6a20:d809:b0:109:f5f2:69a6 with SMTP id iv9-20020a056a20d80900b00109f5f269a6mr2282436pzb.5.1684506701321;
        Fri, 19 May 2023 07:31:41 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.13])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a09a100b00250d908a771sm1634845pjo.50.2023.05.19.07.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:31:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@gmail.com>
Subject: [PATCH v2 3/8] PCI: qcom: Do not advertise hotplug capability for IPs v2.7.0 and v1.9.0
Date:   Fri, 19 May 2023 20:01:12 +0530
Message-Id: <20230519143117.23875-4-manivannan.sadhasivam@linaro.org>
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

SoCs making use of Qcom PCIe controller IPs v2.7.0 and v1.9.0 do not
support hotplug functionality. But the hotplug capability bit is set by
default in the hardware. This causes the kernel PCI core to register
hotplug service for the controller and send hotplug commands to it. But
those commands will timeout generating messages as below during boot and
suspend/resume.

[    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
[    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
[    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
[    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)

This not only spams the console output but also induces a delay of a
couple of seconds. To fix this issue, let's clear the HPC bit in
PCI_EXP_SLTCAP register as a part of the post init sequence to not
advertise the hotplug capability for the controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 391a45d1e70a..8f448156eccc 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -270,6 +270,20 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
+static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
+{
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
+	val &= ~PCI_EXP_SLTCAP_HPC;
+	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -966,6 +980,13 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	return ret;
 }
 
+static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
+{
+	qcom_pcie_clear_hpc(pcie->pci);
+
+	return 0;
+}
+
 static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
@@ -1272,6 +1293,7 @@ static const struct qcom_pcie_ops ops_2_3_3 = {
 static const struct qcom_pcie_ops ops_2_7_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
+	.post_init = qcom_pcie_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
@@ -1280,6 +1302,7 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 static const struct qcom_pcie_ops ops_1_9_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
+	.post_init = qcom_pcie_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.config_sid = qcom_pcie_config_sid_1_9_0,
-- 
2.25.1

