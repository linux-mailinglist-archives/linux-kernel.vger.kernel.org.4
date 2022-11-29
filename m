Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A8E63C0C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiK2NOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiK2NNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:13:37 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCB162EA2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:12:13 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so33665152ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul+lwQyOfdRNmyDNNVAk+tB3eSuGvcR72I1mqSswuTg=;
        b=CBy9sgSq/348dxG0qmYQzOUtwg16HSWQeOTp6rH9arrnOEQ4xFiXGdKTvQYeNYctIN
         2y7q8Ra46Lkz5eq1gLttjMaK7OTo3Hs4p9tRj1FV7L75rvrxuKhQuZeQU6y8eP6kb8Wf
         /CbKj9t9g5P8Na5TDNpVMsL45wPplcrSZqAQqe8DmLcz5S4DBY4hplQ8PoWT2Ezdpw5T
         KpD52bk2r2WtYzhHw+Y6+F1deuS0CdtnBU9/ZDSYX1gWNSgUgRFBgciFMSWoH0jeyhP5
         fhlmfkwKND/G3NfEnISF4X44gM6WkxMXSr9Rr4DwKhHd0sEhNMMjTj+xW/mq+RDwnhdy
         fL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ul+lwQyOfdRNmyDNNVAk+tB3eSuGvcR72I1mqSswuTg=;
        b=FzrWY5NmogxoBsQAiJvu1P3Ed9e6oGh+c4F8LhvkPBe7HyWz7XzDxomXh8LDzfEiqK
         2irbfp89zghzF9zGtx+6NtM/U6f8hJvOYJ5RK/NFBDaujQvdApgiOxTCQkMJt+s1a13a
         3j2fp+UMdOeZ6zzoTY7Q9m8bFGQW4S9Dm56PDIhU3IFIz7XmHJQyw+rAyrL2DcWd1CBv
         ++QCMID+mB+6LCgApsgmqMzecYxX4IDThQVI6TA0OP4j2NxWR/da1f9llfAF3s2Q29vF
         B9Drs0Iw+DDdYbRe5MoWh8s4QG8XurXX1OfnqOctymeCIfdtGdx6Ge9pR3nyEztH4KFN
         yXtg==
X-Gm-Message-State: ANoB5pkJ2l+WKqnZMRVLZY2aPwKUFpqU7ZfRxWM0KPTZz5LYvD1sOlhm
        cMhXFuba1QpjIdYcTUX5O9hz/w==
X-Google-Smtp-Source: AA0mqf6BoBund/J/otjflZtjW0+XeDVSEKn2ie4Z1PdxQGlvrD8IzQV+9iEYEjkG/78D7VNzDW9nfQ==
X-Received: by 2002:a17:906:7f96:b0:7b2:b782:73 with SMTP id f22-20020a1709067f9600b007b2b7820073mr32107194ejr.641.1669727531346;
        Tue, 29 Nov 2022 05:12:11 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p21-20020a05640210d500b0046b25b93451sm2620541edu.85.2022.11.29.05.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:12:10 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 2/2] interconnect: qcom: Add SM8550 interconnect provider driver
Date:   Tue, 29 Nov 2022 15:12:03 +0200
Message-Id: <20221129131203.2197959-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129131203.2197959-1-abel.vesa@linaro.org>
References: <20221129131203.2197959-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the Qualcomm interconnect buses found in SM8550 based
platforms. The topology consists of several NoCs that are controlled by
a remote processor that collects the aggregated bandwidth for each
master-slave pairs.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/interconnect/qcom/Kconfig  |    9 +
 drivers/interconnect/qcom/Makefile |    2 +
 drivers/interconnect/qcom/sm8550.c | 2319 ++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sm8550.h |  178 +++
 4 files changed, 2508 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sm8550.c
 create mode 100644 drivers/interconnect/qcom/sm8550.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 1a1c941635a2..75f63a58507a 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -200,5 +200,14 @@ config INTERCONNECT_QCOM_SM8450
 	  This is a driver for the Qualcomm Network-on-Chip on SM8450-based
 	  platforms.
 
+config INTERCONNECT_QCOM_SM8550
+	tristate "Qualcomm SM8550 interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on SM8550-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SMD_RPM
 	tristate
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 8e357528185d..c720e6742ea8 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -25,6 +25,7 @@ qnoc-sm8150-objs			:= sm8150.o
 qnoc-sm8250-objs			:= sm8250.o
 qnoc-sm8350-objs			:= sm8350.o
 qnoc-sm8450-objs			:= sm8450.o
+qnoc-sm8550-objs			:= sm8550.o
 icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o
 
 obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
@@ -49,4 +50,5 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) += qnoc-sm8350.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8450) += qnoc-sm8450.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SM8550) += qnoc-sm8550.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
new file mode 100644
index 000000000000..077e98a07e14
--- /dev/null
+++ b/drivers/interconnect/qcom/sm8550.c
@@ -0,0 +1,2319 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/interconnect/qcom,sm8550.h>
+
+#include "bcm-voter.h"
+#include "icc-common.h"
+#include "icc-rpmh.h"
+#include "sm8550.h"
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.id = SM8550_MASTER_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.id = SM8550_MASTER_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.id = SM8550_MASTER_SDCC_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SM8550_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = SM8550_MASTER_USB3_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SM8550_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_A2NOC_SNOC },
+};
+
+
+static struct qcom_icc_node qhm_qup2 = {
+	.name = "qhm_qup2",
+	.id = SM8550_MASTER_QUP_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SM8550_MASTER_CRYPTO,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = SM8550_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_sp = {
+	.name = "qxm_sp",
+	.id = SM8550_MASTER_SP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr_0 = {
+	.name = "xm_qdss_etr_0",
+	.id = SM8550_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr_1 = {
+	.name = "xm_qdss_etr_1",
+	.id = SM8550_MASTER_QDSS_ETR_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = SM8550_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qup0_core_master = {
+	.name = "qup0_core_master",
+	.id = SM8550_MASTER_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_QUP_CORE_0 },
+};
+
+static struct qcom_icc_node qup1_core_master = {
+	.name = "qup1_core_master",
+	.id = SM8550_MASTER_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_QUP_CORE_1 },
+};
+
+static struct qcom_icc_node qup2_core_master = {
+	.name = "qup2_core_master",
+	.id = SM8550_MASTER_QUP_CORE_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_QUP_CORE_2 },
+};
+
+static struct qcom_icc_node qsm_cfg = {
+	.name = "qsm_cfg",
+	.id = SM8550_MASTER_CNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 44,
+	.links = { SM8550_SLAVE_AHB2PHY_SOUTH, SM8550_SLAVE_AHB2PHY_NORTH,
+		   SM8550_SLAVE_APPSS, SM8550_SLAVE_CAMERA_CFG,
+		   SM8550_SLAVE_CLK_CTL, SM8550_SLAVE_RBCPR_CX_CFG,
+		   SM8550_SLAVE_RBCPR_MMCX_CFG, SM8550_SLAVE_RBCPR_MXA_CFG,
+		   SM8550_SLAVE_RBCPR_MXC_CFG, SM8550_SLAVE_CPR_NSPCX,
+		   SM8550_SLAVE_CRYPTO_0_CFG, SM8550_SLAVE_CX_RDPM,
+		   SM8550_SLAVE_DISPLAY_CFG, SM8550_SLAVE_GFX3D_CFG,
+		   SM8550_SLAVE_I2C, SM8550_SLAVE_IMEM_CFG,
+		   SM8550_SLAVE_IPA_CFG, SM8550_SLAVE_IPC_ROUTER_CFG,
+		   SM8550_SLAVE_CNOC_MSS, SM8550_SLAVE_MX_RDPM,
+		   SM8550_SLAVE_PCIE_0_CFG, SM8550_SLAVE_PCIE_1_CFG,
+		   SM8550_SLAVE_PDM, SM8550_SLAVE_PIMEM_CFG,
+		   SM8550_SLAVE_PRNG, SM8550_SLAVE_QDSS_CFG,
+		   SM8550_SLAVE_QSPI_0, SM8550_SLAVE_QUP_1,
+		   SM8550_SLAVE_QUP_2, SM8550_SLAVE_SDCC_2,
+		   SM8550_SLAVE_SDCC_4, SM8550_SLAVE_SPSS_CFG,
+		   SM8550_SLAVE_TCSR, SM8550_SLAVE_TLMM,
+		   SM8550_SLAVE_UFS_MEM_CFG, SM8550_SLAVE_USB3_0,
+		   SM8550_SLAVE_VENUS_CFG, SM8550_SLAVE_VSENSE_CTRL_CFG,
+		   SM8550_SLAVE_LPASS_QTB_CFG, SM8550_SLAVE_CNOC_MNOC_CFG,
+		   SM8550_SLAVE_NSP_QTB_CFG, SM8550_SLAVE_PCIE_ANOC_CFG,
+		   SM8550_SLAVE_QDSS_STM, SM8550_SLAVE_TCU },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.id = SM8550_MASTER_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 6,
+	.links = { SM8550_SLAVE_AOSS, SM8550_SLAVE_TME_CFG,
+		   SM8550_SLAVE_CNOC_CFG, SM8550_SLAVE_DDRSS_CFG,
+		   SM8550_SLAVE_BOOT_IMEM, SM8550_SLAVE_IMEM },
+};
+
+static struct qcom_icc_node qnm_gemnoc_pcie = {
+	.name = "qnm_gemnoc_pcie",
+	.id = SM8550_MASTER_GEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM8550_SLAVE_PCIE_0, SM8550_SLAVE_PCIE_1 },
+};
+
+static struct qcom_icc_node alm_gpu_tcu = {
+	.name = "alm_gpu_tcu",
+	.id = SM8550_MASTER_GPU_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM8550_SLAVE_GEM_NOC_CNOC, SM8550_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.id = SM8550_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM8550_SLAVE_GEM_NOC_CNOC, SM8550_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.id = SM8550_MASTER_APPSS_PROC,
+	.channels = 3,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SM8550_SLAVE_GEM_NOC_CNOC, SM8550_SLAVE_LLCC,
+		   SM8550_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.id = SM8550_MASTER_GFX3D,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM8550_SLAVE_GEM_NOC_CNOC, SM8550_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_lpass_gemnoc = {
+	.name = "qnm_lpass_gemnoc",
+	.id = SM8550_MASTER_LPASS_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SM8550_SLAVE_GEM_NOC_CNOC, SM8550_SLAVE_LLCC,
+		   SM8550_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_mdsp = {
+	.name = "qnm_mdsp",
+	.id = SM8550_MASTER_MSS_PROC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SM8550_SLAVE_GEM_NOC_CNOC, SM8550_SLAVE_LLCC,
+		   SM8550_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SM8550_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM8550_SLAVE_GEM_NOC_CNOC, SM8550_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SM8550_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM8550_SLAVE_GEM_NOC_CNOC, SM8550_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_nsp_gemnoc = {
+	.name = "qnm_nsp_gemnoc",
+	.id = SM8550_MASTER_COMPUTE_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM8550_SLAVE_GEM_NOC_CNOC, SM8550_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.id = SM8550_MASTER_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 2,
+	.links = { SM8550_SLAVE_GEM_NOC_CNOC, SM8550_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SM8550_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SM8550_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SM8550_SLAVE_GEM_NOC_CNOC, SM8550_SLAVE_LLCC,
+		   SM8550_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_lpiaon_noc = {
+	.name = "qnm_lpiaon_noc",
+	.id = SM8550_MASTER_LPIAON_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LPASS_GEM_NOC },
+};
+
+static struct qcom_icc_node qnm_lpass_lpinoc = {
+	.name = "qnm_lpass_lpinoc",
+	.id = SM8550_MASTER_LPASS_LPINOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LPIAON_NOC_LPASS_AG_NOC },
+};
+
+static struct qcom_icc_node qxm_lpinoc_dsp_axim = {
+	.name = "qxm_lpinoc_dsp_axim",
+	.id = SM8550_MASTER_LPASS_PROC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LPICX_NOC_LPIAON_NOC },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SM8550_MASTER_LLCC,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node qnm_camnoc_hf = {
+	.name = "qnm_camnoc_hf",
+	.id = SM8550_MASTER_CAMNOC_HF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_icp = {
+	.name = "qnm_camnoc_icp",
+	.id = SM8550_MASTER_CAMNOC_ICP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_sf = {
+	.name = "qnm_camnoc_sf",
+	.id = SM8550_MASTER_CAMNOC_SF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_mdp = {
+	.name = "qnm_mdp",
+	.id = SM8550_MASTER_MDP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_vapss_hcp = {
+	.name = "qnm_vapss_hcp",
+	.id = SM8550_MASTER_CDSP_HCP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video = {
+	.name = "qnm_video",
+	.id = SM8550_MASTER_VIDEO,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video_cv_cpu = {
+	.name = "qnm_video_cv_cpu",
+	.id = SM8550_MASTER_VIDEO_CV_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video_cvp = {
+	.name = "qnm_video_cvp",
+	.id = SM8550_MASTER_VIDEO_PROC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video_v_cpu = {
+	.name = "qnm_video_v_cpu",
+	.id = SM8550_MASTER_VIDEO_V_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qsm_mnoc_cfg = {
+	.name = "qsm_mnoc_cfg",
+	.id = SM8550_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node qxm_nsp = {
+	.name = "qxm_nsp",
+	.id = SM8550_MASTER_CDSP_PROC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_CDSP_MEM_NOC },
+};
+
+static struct qcom_icc_node qsm_pcie_anoc_cfg = {
+	.name = "qsm_pcie_anoc_cfg",
+	.id = SM8550_MASTER_PCIE_ANOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_SERVICE_PCIE_ANOC },
+};
+
+static struct qcom_icc_node xm_pcie3_0 = {
+	.name = "xm_pcie3_0",
+	.id = SM8550_MASTER_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie3_1 = {
+	.name = "xm_pcie3_1",
+	.id = SM8550_MASTER_PCIE_1,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node qhm_gic = {
+	.name = "qhm_gic",
+	.id = SM8550_MASTER_GIC_AHB,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SM8550_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SM8550_MASTER_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SM8550_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf_disp = {
+	.name = "qnm_mnoc_hf_disp",
+	.id = SM8550_MASTER_MNOC_HF_MEM_NOC_DISP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LLCC_DISP },
+};
+
+static struct qcom_icc_node qnm_pcie_disp = {
+	.name = "qnm_pcie_disp",
+	.id = SM8550_MASTER_ANOC_PCIE_GEM_NOC_DISP,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LLCC_DISP },
+};
+
+static struct qcom_icc_node llcc_mc_disp = {
+	.name = "llcc_mc_disp",
+	.id = SM8550_MASTER_LLCC_DISP,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_EBI1_DISP },
+};
+
+static struct qcom_icc_node qnm_mdp_disp = {
+	.name = "qnm_mdp_disp",
+	.id = SM8550_MASTER_MDP_DISP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_HF_MEM_NOC_DISP },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf_cam_ife_0 = {
+	.name = "qnm_mnoc_hf_cam_ife_0",
+	.id = SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_0,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LLCC_CAM_IFE_0 },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf_cam_ife_0 = {
+	.name = "qnm_mnoc_sf_cam_ife_0",
+	.id = SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_0,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LLCC_CAM_IFE_0 },
+};
+
+static struct qcom_icc_node qnm_pcie_cam_ife_0 = {
+	.name = "qnm_pcie_cam_ife_0",
+	.id = SM8550_MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LLCC_CAM_IFE_0 },
+};
+
+static struct qcom_icc_node llcc_mc_cam_ife_0 = {
+	.name = "llcc_mc_cam_ife_0",
+	.id = SM8550_MASTER_LLCC_CAM_IFE_0,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_EBI1_CAM_IFE_0 },
+};
+
+static struct qcom_icc_node qnm_camnoc_hf_cam_ife_0 = {
+	.name = "qnm_camnoc_hf_cam_ife_0",
+	.id = SM8550_MASTER_CAMNOC_HF_CAM_IFE_0,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_0 },
+};
+
+static struct qcom_icc_node qnm_camnoc_icp_cam_ife_0 = {
+	.name = "qnm_camnoc_icp_cam_ife_0",
+	.id = SM8550_MASTER_CAMNOC_ICP_CAM_IFE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_0 },
+};
+
+static struct qcom_icc_node qnm_camnoc_sf_cam_ife_0 = {
+	.name = "qnm_camnoc_sf_cam_ife_0",
+	.id = SM8550_MASTER_CAMNOC_SF_CAM_IFE_0,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_0 },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf_cam_ife_1 = {
+	.name = "qnm_mnoc_hf_cam_ife_1",
+	.id = SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_1,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LLCC_CAM_IFE_1 },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf_cam_ife_1 = {
+	.name = "qnm_mnoc_sf_cam_ife_1",
+	.id = SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_1,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LLCC_CAM_IFE_1 },
+};
+
+static struct qcom_icc_node qnm_pcie_cam_ife_1 = {
+	.name = "qnm_pcie_cam_ife_1",
+	.id = SM8550_MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_1,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LLCC_CAM_IFE_1 },
+};
+
+static struct qcom_icc_node llcc_mc_cam_ife_1 = {
+	.name = "llcc_mc_cam_ife_1",
+	.id = SM8550_MASTER_LLCC_CAM_IFE_1,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_EBI1_CAM_IFE_1 },
+};
+
+static struct qcom_icc_node qnm_camnoc_hf_cam_ife_1 = {
+	.name = "qnm_camnoc_hf_cam_ife_1",
+	.id = SM8550_MASTER_CAMNOC_HF_CAM_IFE_1,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_1 },
+};
+
+static struct qcom_icc_node qnm_camnoc_icp_cam_ife_1 = {
+	.name = "qnm_camnoc_icp_cam_ife_1",
+	.id = SM8550_MASTER_CAMNOC_ICP_CAM_IFE_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_1 },
+};
+
+static struct qcom_icc_node qnm_camnoc_sf_cam_ife_1 = {
+	.name = "qnm_camnoc_sf_cam_ife_1",
+	.id = SM8550_MASTER_CAMNOC_SF_CAM_IFE_1,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_1 },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf_cam_ife_2 = {
+	.name = "qnm_mnoc_hf_cam_ife_2",
+	.id = SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_2,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LLCC_CAM_IFE_2 },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf_cam_ife_2 = {
+	.name = "qnm_mnoc_sf_cam_ife_2",
+	.id = SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_2,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LLCC_CAM_IFE_2 },
+};
+
+static struct qcom_icc_node qnm_pcie_cam_ife_2 = {
+	.name = "qnm_pcie_cam_ife_2",
+	.id = SM8550_MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_2,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_LLCC_CAM_IFE_2 },
+};
+
+static struct qcom_icc_node llcc_mc_cam_ife_2 = {
+	.name = "llcc_mc_cam_ife_2",
+	.id = SM8550_MASTER_LLCC_CAM_IFE_2,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_EBI1_CAM_IFE_2 },
+};
+
+static struct qcom_icc_node qnm_camnoc_hf_cam_ife_2 = {
+	.name = "qnm_camnoc_hf_cam_ife_2",
+	.id = SM8550_MASTER_CAMNOC_HF_CAM_IFE_2,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_2 },
+};
+
+static struct qcom_icc_node qnm_camnoc_icp_cam_ife_2 = {
+	.name = "qnm_camnoc_icp_cam_ife_2",
+	.id = SM8550_MASTER_CAMNOC_ICP_CAM_IFE_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_2 },
+};
+
+static struct qcom_icc_node qnm_camnoc_sf_cam_ife_2 = {
+	.name = "qnm_camnoc_sf_cam_ife_2",
+	.id = SM8550_MASTER_CAMNOC_SF_CAM_IFE_2,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_2 },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SM8550_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SM8550_SLAVE_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_MASTER_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qup0_core_slave = {
+	.name = "qup0_core_slave",
+	.id = SM8550_SLAVE_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup1_core_slave = {
+	.name = "qup1_core_slave",
+	.id = SM8550_SLAVE_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup2_core_slave = {
+	.name = "qup2_core_slave",
+	.id = SM8550_SLAVE_QUP_CORE_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.id = SM8550_SLAVE_AHB2PHY_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy1 = {
+	.name = "qhs_ahb2phy1",
+	.id = SM8550_SLAVE_AHB2PHY_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SM8550_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SM8550_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SM8550_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = SM8550_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_mmcx = {
+	.name = "qhs_cpr_mmcx",
+	.id = SM8550_SLAVE_RBCPR_MMCX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_mxa = {
+	.name = "qhs_cpr_mxa",
+	.id = SM8550_SLAVE_RBCPR_MXA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_mxc = {
+	.name = "qhs_cpr_mxc",
+	.id = SM8550_SLAVE_RBCPR_MXC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_nspcx = {
+	.name = "qhs_cpr_nspcx",
+	.id = SM8550_SLAVE_CPR_NSPCX,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SM8550_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cx_rdpm = {
+	.name = "qhs_cx_rdpm",
+	.id = SM8550_SLAVE_CX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = SM8550_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SM8550_SLAVE_GFX3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_i2c = {
+	.name = "qhs_i2c",
+	.id = SM8550_SLAVE_I2C,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SM8550_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SM8550_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.id = SM8550_SLAVE_IPC_ROUTER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.id = SM8550_SLAVE_CNOC_MSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_mx_rdpm = {
+	.name = "qhs_mx_rdpm",
+	.id = SM8550_SLAVE_MX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.id = SM8550_SLAVE_PCIE_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie1_cfg = {
+	.name = "qhs_pcie1_cfg",
+	.id = SM8550_SLAVE_PCIE_1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SM8550_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg = {
+	.name = "qhs_pimem_cfg",
+	.id = SM8550_SLAVE_PIMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SM8550_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SM8550_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.id = SM8550_SLAVE_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.id = SM8550_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup2 = {
+	.name = "qhs_qup2",
+	.id = SM8550_SLAVE_QUP_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = SM8550_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.id = SM8550_SLAVE_SDCC_4,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_spss_cfg = {
+	.name = "qhs_spss_cfg",
+	.id = SM8550_SLAVE_SPSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SM8550_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.id = SM8550_SLAVE_TLMM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SM8550_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.id = SM8550_SLAVE_USB3_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SM8550_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = SM8550_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_lpass_qtb_cfg = {
+	.name = "qss_lpass_qtb_cfg",
+	.id = SM8550_SLAVE_LPASS_QTB_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_mnoc_cfg = {
+	.name = "qss_mnoc_cfg",
+	.id = SM8550_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qss_nsp_qtb_cfg = {
+	.name = "qss_nsp_qtb_cfg",
+	.id = SM8550_SLAVE_NSP_QTB_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_pcie_anoc_cfg = {
+	.name = "qss_pcie_anoc_cfg",
+	.id = SM8550_SLAVE_PCIE_ANOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_MASTER_PCIE_ANOC_CFG },
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SM8550_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SM8550_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SM8550_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tme_cfg = {
+	.name = "qhs_tme_cfg",
+	.id = SM8550_SLAVE_TME_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_cfg = {
+	.name = "qss_cfg",
+	.id = SM8550_SLAVE_CNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8550_MASTER_CNOC_CFG },
+};
+
+static struct qcom_icc_node qss_ddrss_cfg = {
+	.name = "qss_ddrss_cfg",
+	.id = SM8550_SLAVE_DDRSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qxs_boot_imem = {
+	.name = "qxs_boot_imem",
+	.id = SM8550_SLAVE_BOOT_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SM8550_SLAVE_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.id = SM8550_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_1 = {
+	.name = "xs_pcie_1",
+	.id = SM8550_SLAVE_PCIE_1,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gem_noc_cnoc = {
+	.name = "qns_gem_noc_cnoc",
+	.id = SM8550_SLAVE_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_MASTER_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SM8550_SLAVE_LLCC,
+	.channels = 4,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_pcie = {
+	.name = "qns_pcie",
+	.id = SM8550_SLAVE_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_MASTER_GEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
+	.name = "qns_lpass_ag_noc_gemnoc",
+	.id = SM8550_SLAVE_LPASS_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_MASTER_LPASS_GEM_NOC },
+};
+
+static struct qcom_icc_node qns_lpass_aggnoc = {
+	.name = "qns_lpass_aggnoc",
+	.id = SM8550_SLAVE_LPIAON_NOC_LPASS_AG_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_MASTER_LPIAON_NOC },
+};
+
+static struct qcom_icc_node qns_lpi_aon_noc = {
+	.name = "qns_lpi_aon_noc",
+	.id = SM8550_SLAVE_LPICX_NOC_LPIAON_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_MASTER_LPASS_LPINOC },
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SM8550_SLAVE_EBI1,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SM8550_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.id = SM8550_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = SM8550_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_nsp_gemnoc = {
+	.name = "qns_nsp_gemnoc",
+	.id = SM8550_SLAVE_CDSP_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_MASTER_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node qns_pcie_mem_noc = {
+	.name = "qns_pcie_mem_noc",
+	.id = SM8550_SLAVE_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_MASTER_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node srvc_pcie_aggre_noc = {
+	.name = "srvc_pcie_aggre_noc",
+	.id = SM8550_SLAVE_SERVICE_PCIE_ANOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gemnoc_gc = {
+	.name = "qns_gemnoc_gc",
+	.id = SM8550_SLAVE_SNOC_GEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8550_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SM8550_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_llcc_disp = {
+	.name = "qns_llcc_disp",
+	.id = SM8550_SLAVE_LLCC_DISP,
+	.channels = 4,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_MASTER_LLCC_DISP },
+};
+
+static struct qcom_icc_node ebi_disp = {
+	.name = "ebi_disp",
+	.id = SM8550_SLAVE_EBI1_DISP,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf_disp = {
+	.name = "qns_mem_noc_hf_disp",
+	.id = SM8550_SLAVE_MNOC_HF_MEM_NOC_DISP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_MASTER_MNOC_HF_MEM_NOC_DISP },
+};
+
+static struct qcom_icc_node qns_llcc_cam_ife_0 = {
+	.name = "qns_llcc_cam_ife_0",
+	.id = SM8550_SLAVE_LLCC_CAM_IFE_0,
+	.channels = 4,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_MASTER_LLCC_CAM_IFE_0 },
+};
+
+static struct qcom_icc_node ebi_cam_ife_0 = {
+	.name = "ebi_cam_ife_0",
+	.id = SM8550_SLAVE_EBI1_CAM_IFE_0,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf_cam_ife_0 = {
+	.name = "qns_mem_noc_hf_cam_ife_0",
+	.id = SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_0,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_0 },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf_cam_ife_0 = {
+	.name = "qns_mem_noc_sf_cam_ife_0",
+	.id = SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_0,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_0 },
+};
+
+static struct qcom_icc_node qns_llcc_cam_ife_1 = {
+	.name = "qns_llcc_cam_ife_1",
+	.id = SM8550_SLAVE_LLCC_CAM_IFE_1,
+	.channels = 4,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_MASTER_LLCC_CAM_IFE_1 },
+};
+
+static struct qcom_icc_node ebi_cam_ife_1 = {
+	.name = "ebi_cam_ife_1",
+	.id = SM8550_SLAVE_EBI1_CAM_IFE_1,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf_cam_ife_1 = {
+	.name = "qns_mem_noc_hf_cam_ife_1",
+	.id = SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_1,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_1 },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf_cam_ife_1 = {
+	.name = "qns_mem_noc_sf_cam_ife_1",
+	.id = SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_1,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_1 },
+};
+
+static struct qcom_icc_node qns_llcc_cam_ife_2 = {
+	.name = "qns_llcc_cam_ife_2",
+	.id = SM8550_SLAVE_LLCC_CAM_IFE_2,
+	.channels = 4,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8550_MASTER_LLCC_CAM_IFE_2 },
+};
+
+static struct qcom_icc_node ebi_cam_ife_2 = {
+	.name = "ebi_cam_ife_2",
+	.id = SM8550_SLAVE_EBI1_CAM_IFE_2,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf_cam_ife_2 = {
+	.name = "qns_mem_noc_hf_cam_ife_2",
+	.id = SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_2,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_2 },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf_cam_ife_2 = {
+	.name = "qns_mem_noc_sf_cam_ife_2",
+	.id = SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_2,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_2 },
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.num_nodes = 54,
+	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
+		   &qhs_ahb2phy1, &qhs_apss,
+		   &qhs_camera_cfg, &qhs_clk_ctl,
+		   &qhs_cpr_cx, &qhs_cpr_mmcx,
+		   &qhs_cpr_mxa, &qhs_cpr_mxc,
+		   &qhs_cpr_nspcx, &qhs_crypto0_cfg,
+		   &qhs_cx_rdpm, &qhs_gpuss_cfg,
+		   &qhs_i2c, &qhs_imem_cfg,
+		   &qhs_ipa, &qhs_ipc_router,
+		   &qhs_mss_cfg, &qhs_mx_rdpm,
+		   &qhs_pcie0_cfg, &qhs_pcie1_cfg,
+		   &qhs_pdm, &qhs_pimem_cfg,
+		   &qhs_prng, &qhs_qdss_cfg,
+		   &qhs_qspi, &qhs_qup1,
+		   &qhs_qup2, &qhs_sdc2,
+		   &qhs_sdc4, &qhs_spss_cfg,
+		   &qhs_tcsr, &qhs_tlmm,
+		   &qhs_ufs_mem_cfg, &qhs_usb3_0,
+		   &qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+		   &qss_lpass_qtb_cfg, &qss_mnoc_cfg,
+		   &qss_nsp_qtb_cfg, &qss_pcie_anoc_cfg,
+		   &xs_qdss_stm, &xs_sys_tcu_cfg,
+		   &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie,
+		   &qhs_aoss, &qhs_tme_cfg,
+		   &qss_cfg, &qss_ddrss_cfg,
+		   &qxs_boot_imem, &qxs_imem,
+		   &xs_pcie_0, &xs_pcie_1 },
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.num_nodes = 1,
+	.nodes = { &qhs_display_cfg },
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.num_nodes = 2,
+	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
+};
+
+static struct qcom_icc_bcm bcm_lp0 = {
+	.name = "LP0",
+	.num_nodes = 2,
+	.nodes = { &qnm_lpass_lpinoc, &qns_lpass_aggnoc },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.num_nodes = 8,
+	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
+		   &qnm_camnoc_sf, &qnm_vapss_hcp,
+		   &qnm_video_cv_cpu, &qnm_video_cvp,
+		   &qnm_video_v_cpu, &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup0_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup1 = {
+	.name = "QUP1",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup1_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup2 = {
+	.name = "QUP2",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup2_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh1 = {
+	.name = "SH1",
+	.num_nodes = 13,
+	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
+		   &chm_apps, &qnm_gpu,
+		   &qnm_mdsp, &qnm_mnoc_hf,
+		   &qnm_mnoc_sf, &qnm_nsp_gemnoc,
+		   &qnm_pcie, &qnm_snoc_gc,
+		   &qnm_snoc_sf, &qns_gem_noc_cnoc,
+		   &qns_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.num_nodes = 3,
+	.nodes = { &qhm_gic, &xm_gic,
+		   &qns_gemnoc_gc },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn7 = {
+	.name = "SN7",
+	.num_nodes = 1,
+	.nodes = { &qns_pcie_mem_noc },
+};
+
+static struct qcom_icc_bcm bcm_acv_disp = {
+	.name = "ACV",
+	.num_nodes = 1,
+	.nodes = { &ebi_disp },
+};
+
+static struct qcom_icc_bcm bcm_mc0_disp = {
+	.name = "MC0",
+	.num_nodes = 1,
+	.nodes = { &ebi_disp },
+};
+
+static struct qcom_icc_bcm bcm_mm0_disp = {
+	.name = "MM0",
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf_disp },
+};
+
+static struct qcom_icc_bcm bcm_sh0_disp = {
+	.name = "SH0",
+	.num_nodes = 1,
+	.nodes = { &qns_llcc_disp },
+};
+
+static struct qcom_icc_bcm bcm_sh1_disp = {
+	.name = "SH1",
+	.num_nodes = 2,
+	.nodes = { &qnm_mnoc_hf_disp, &qnm_pcie_disp },
+};
+
+static struct qcom_icc_bcm bcm_acv_cam_ife_0 = {
+	.name = "ACV",
+	.num_nodes = 1,
+	.nodes = { &ebi_cam_ife_0 },
+};
+
+static struct qcom_icc_bcm bcm_mc0_cam_ife_0 = {
+	.name = "MC0",
+	.num_nodes = 1,
+	.nodes = { &ebi_cam_ife_0 },
+};
+
+static struct qcom_icc_bcm bcm_mm0_cam_ife_0 = {
+	.name = "MM0",
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf_cam_ife_0 },
+};
+
+static struct qcom_icc_bcm bcm_mm1_cam_ife_0 = {
+	.name = "MM1",
+	.num_nodes = 4,
+	.nodes = { &qnm_camnoc_hf_cam_ife_0, &qnm_camnoc_icp_cam_ife_0,
+		   &qnm_camnoc_sf_cam_ife_0, &qns_mem_noc_sf_cam_ife_0 },
+};
+
+static struct qcom_icc_bcm bcm_sh0_cam_ife_0 = {
+	.name = "SH0",
+	.num_nodes = 1,
+	.nodes = { &qns_llcc_cam_ife_0 },
+};
+
+static struct qcom_icc_bcm bcm_sh1_cam_ife_0 = {
+	.name = "SH1",
+	.num_nodes = 3,
+	.nodes = { &qnm_mnoc_hf_cam_ife_0, &qnm_mnoc_sf_cam_ife_0,
+		   &qnm_pcie_cam_ife_0 },
+};
+
+static struct qcom_icc_bcm bcm_acv_cam_ife_1 = {
+	.name = "ACV",
+	.num_nodes = 1,
+	.nodes = { &ebi_cam_ife_1 },
+};
+
+static struct qcom_icc_bcm bcm_mc0_cam_ife_1 = {
+	.name = "MC0",
+	.num_nodes = 1,
+	.nodes = { &ebi_cam_ife_1 },
+};
+
+static struct qcom_icc_bcm bcm_mm0_cam_ife_1 = {
+	.name = "MM0",
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf_cam_ife_1 },
+};
+
+static struct qcom_icc_bcm bcm_mm1_cam_ife_1 = {
+	.name = "MM1",
+	.num_nodes = 4,
+	.nodes = { &qnm_camnoc_hf_cam_ife_1, &qnm_camnoc_icp_cam_ife_1,
+		   &qnm_camnoc_sf_cam_ife_1, &qns_mem_noc_sf_cam_ife_1 },
+};
+
+static struct qcom_icc_bcm bcm_sh0_cam_ife_1 = {
+	.name = "SH0",
+	.num_nodes = 1,
+	.nodes = { &qns_llcc_cam_ife_1 },
+};
+
+static struct qcom_icc_bcm bcm_sh1_cam_ife_1 = {
+	.name = "SH1",
+	.num_nodes = 3,
+	.nodes = { &qnm_mnoc_hf_cam_ife_1, &qnm_mnoc_sf_cam_ife_1,
+		   &qnm_pcie_cam_ife_1 },
+};
+
+static struct qcom_icc_bcm bcm_acv_cam_ife_2 = {
+	.name = "ACV",
+	.num_nodes = 1,
+	.nodes = { &ebi_cam_ife_2 },
+};
+
+static struct qcom_icc_bcm bcm_mc0_cam_ife_2 = {
+	.name = "MC0",
+	.num_nodes = 1,
+	.nodes = { &ebi_cam_ife_2 },
+};
+
+static struct qcom_icc_bcm bcm_mm0_cam_ife_2 = {
+	.name = "MM0",
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf_cam_ife_2 },
+};
+
+static struct qcom_icc_bcm bcm_mm1_cam_ife_2 = {
+	.name = "MM1",
+	.num_nodes = 4,
+	.nodes = { &qnm_camnoc_hf_cam_ife_2, &qnm_camnoc_icp_cam_ife_2,
+		   &qnm_camnoc_sf_cam_ife_2, &qns_mem_noc_sf_cam_ife_2 },
+};
+
+static struct qcom_icc_bcm bcm_sh0_cam_ife_2 = {
+	.name = "SH0",
+	.num_nodes = 1,
+	.nodes = { &qns_llcc_cam_ife_2 },
+};
+
+static struct qcom_icc_bcm bcm_sh1_cam_ife_2 = {
+	.name = "SH1",
+	.num_nodes = 3,
+	.nodes = { &qnm_mnoc_hf_cam_ife_2, &qnm_mnoc_sf_cam_ife_2,
+		   &qnm_pcie_cam_ife_2 },
+};
+
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
+	[MASTER_QSPI_0] = &qhm_qspi,
+	[MASTER_QUP_1] = &qhm_qup1,
+	[MASTER_SDCC_4] = &xm_sdc4,
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[MASTER_USB3_0] = &xm_usb3_0,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+};
+
+static const struct qcom_icc_desc sm8550_aggre1_noc = {
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms = aggre1_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
+	&bcm_ce0,
+};
+
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
+	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
+	[MASTER_QUP_2] = &qhm_qup2,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_IPA] = &qxm_ipa,
+	[MASTER_SP] = &qxm_sp,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr_0,
+	[MASTER_QDSS_ETR_1] = &xm_qdss_etr_1,
+	[MASTER_SDCC_2] = &xm_sdc2,
+	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
+};
+
+static const struct qcom_icc_desc sm8550_aggre2_noc = {
+	.nodes = aggre2_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms = aggre2_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
+	&bcm_qup0,
+	&bcm_qup1,
+	&bcm_qup2,
+};
+
+static struct qcom_icc_node * const clk_virt_nodes[] = {
+	[MASTER_QUP_CORE_0] = &qup0_core_master,
+	[MASTER_QUP_CORE_1] = &qup1_core_master,
+	[MASTER_QUP_CORE_2] = &qup2_core_master,
+	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
+	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
+	[SLAVE_QUP_CORE_2] = &qup2_core_slave,
+};
+
+static const struct qcom_icc_desc sm8550_clk_virt = {
+	.nodes = clk_virt_nodes,
+	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
+	.bcms = clk_virt_bcms,
+	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
+	&bcm_cn0,
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const config_noc_nodes[] = {
+	[MASTER_CNOC_CFG] = &qsm_cfg,
+	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_NORTH] = &qhs_ahb2phy1,
+	[SLAVE_APPSS] = &qhs_apss,
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
+	[SLAVE_RBCPR_MMCX_CFG] = &qhs_cpr_mmcx,
+	[SLAVE_RBCPR_MXA_CFG] = &qhs_cpr_mxa,
+	[SLAVE_RBCPR_MXC_CFG] = &qhs_cpr_mxc,
+	[SLAVE_CPR_NSPCX] = &qhs_cpr_nspcx,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_CX_RDPM] = &qhs_cx_rdpm,
+	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
+	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
+	[SLAVE_I2C] = &qhs_i2c,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
+	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
+	[SLAVE_MX_RDPM] = &qhs_mx_rdpm,
+	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
+	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_PIMEM_CFG] = &qhs_pimem_cfg,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QSPI_0] = &qhs_qspi,
+	[SLAVE_QUP_1] = &qhs_qup1,
+	[SLAVE_QUP_2] = &qhs_qup2,
+	[SLAVE_SDCC_2] = &qhs_sdc2,
+	[SLAVE_SDCC_4] = &qhs_sdc4,
+	[SLAVE_SPSS_CFG] = &qhs_spss_cfg,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+	[SLAVE_USB3_0] = &qhs_usb3_0,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
+	[SLAVE_LPASS_QTB_CFG] = &qss_lpass_qtb_cfg,
+	[SLAVE_CNOC_MNOC_CFG] = &qss_mnoc_cfg,
+	[SLAVE_NSP_QTB_CFG] = &qss_nsp_qtb_cfg,
+	[SLAVE_PCIE_ANOC_CFG] = &qss_pcie_anoc_cfg,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc sm8550_config_noc = {
+	.nodes = config_noc_nodes,
+	.num_nodes = ARRAY_SIZE(config_noc_nodes),
+	.bcms = config_noc_bcms,
+	.num_bcms = ARRAY_SIZE(config_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc_main_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node * const cnoc_main_nodes[] = {
+	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
+	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_TME_CFG] = &qhs_tme_cfg,
+	[SLAVE_CNOC_CFG] = &qss_cfg,
+	[SLAVE_DDRSS_CFG] = &qss_ddrss_cfg,
+	[SLAVE_BOOT_IMEM] = &qxs_boot_imem,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_PCIE_0] = &xs_pcie_0,
+	[SLAVE_PCIE_1] = &xs_pcie_1,
+};
+
+static const struct qcom_icc_desc sm8550_cnoc_main = {
+	.nodes = cnoc_main_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
+	.bcms = cnoc_main_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_main_bcms),
+};
+
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh1,
+	&bcm_sh0_disp,
+	&bcm_sh1_disp,
+	&bcm_sh0_cam_ife_0,
+	&bcm_sh1_cam_ife_0,
+	&bcm_sh0_cam_ife_1,
+	&bcm_sh1_cam_ife_1,
+	&bcm_sh0_cam_ife_2,
+	&bcm_sh1_cam_ife_2,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] = {
+	[MASTER_GPU_TCU] = &alm_gpu_tcu,
+	[MASTER_SYS_TCU] = &alm_sys_tcu,
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_GFX3D] = &qnm_gpu,
+	[MASTER_LPASS_GEM_NOC] = &qnm_lpass_gemnoc,
+	[MASTER_MSS_PROC] = &qnm_mdsp,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_COMPUTE_NOC] = &qnm_nsp_gemnoc,
+	[MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
+	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
+	[MASTER_MNOC_HF_MEM_NOC_DISP] = &qnm_mnoc_hf_disp,
+	[MASTER_ANOC_PCIE_GEM_NOC_DISP] = &qnm_pcie_disp,
+	[SLAVE_LLCC_DISP] = &qns_llcc_disp,
+	[MASTER_MNOC_HF_MEM_NOC_CAM_IFE_0] = &qnm_mnoc_hf_cam_ife_0,
+	[MASTER_MNOC_SF_MEM_NOC_CAM_IFE_0] = &qnm_mnoc_sf_cam_ife_0,
+	[MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_0] = &qnm_pcie_cam_ife_0,
+	[SLAVE_LLCC_CAM_IFE_0] = &qns_llcc_cam_ife_0,
+	[MASTER_MNOC_HF_MEM_NOC_CAM_IFE_1] = &qnm_mnoc_hf_cam_ife_1,
+	[MASTER_MNOC_SF_MEM_NOC_CAM_IFE_1] = &qnm_mnoc_sf_cam_ife_1,
+	[MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_1] = &qnm_pcie_cam_ife_1,
+	[SLAVE_LLCC_CAM_IFE_1] = &qns_llcc_cam_ife_1,
+	[MASTER_MNOC_HF_MEM_NOC_CAM_IFE_2] = &qnm_mnoc_hf_cam_ife_2,
+	[MASTER_MNOC_SF_MEM_NOC_CAM_IFE_2] = &qnm_mnoc_sf_cam_ife_2,
+	[MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_2] = &qnm_pcie_cam_ife_2,
+	[SLAVE_LLCC_CAM_IFE_2] = &qns_llcc_cam_ife_2,
+};
+
+static const struct qcom_icc_desc sm8550_gem_noc = {
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
+};
+
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
+	[MASTER_LPIAON_NOC] = &qnm_lpiaon_noc,
+	[SLAVE_LPASS_GEM_NOC] = &qns_lpass_ag_noc_gemnoc,
+};
+
+static const struct qcom_icc_desc sm8550_lpass_ag_noc = {
+	.nodes = lpass_ag_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
+	.bcms = lpass_ag_noc_bcms,
+	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const lpass_lpiaon_noc_bcms[] = {
+	&bcm_lp0,
+};
+
+static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
+	[MASTER_LPASS_LPINOC] = &qnm_lpass_lpinoc,
+	[SLAVE_LPIAON_NOC_LPASS_AG_NOC] = &qns_lpass_aggnoc,
+};
+
+static const struct qcom_icc_desc sm8550_lpass_lpiaon_noc = {
+	.nodes = lpass_lpiaon_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
+	.bcms = lpass_lpiaon_noc_bcms,
+	.num_bcms = ARRAY_SIZE(lpass_lpiaon_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const lpass_lpicx_noc_bcms[] = {
+};
+
+static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
+	[MASTER_LPASS_PROC] = &qxm_lpinoc_dsp_axim,
+	[SLAVE_LPICX_NOC_LPIAON_NOC] = &qns_lpi_aon_noc,
+};
+
+static const struct qcom_icc_desc sm8550_lpass_lpicx_noc = {
+	.nodes = lpass_lpicx_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
+	.bcms = lpass_lpicx_noc_bcms,
+	.num_bcms = ARRAY_SIZE(lpass_lpicx_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
+	&bcm_acv,
+	&bcm_mc0,
+	&bcm_acv_disp,
+	&bcm_mc0_disp,
+	&bcm_acv_cam_ife_0,
+	&bcm_mc0_cam_ife_0,
+	&bcm_acv_cam_ife_1,
+	&bcm_mc0_cam_ife_1,
+	&bcm_acv_cam_ife_2,
+	&bcm_mc0_cam_ife_2,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+	[MASTER_LLCC_DISP] = &llcc_mc_disp,
+	[SLAVE_EBI1_DISP] = &ebi_disp,
+	[MASTER_LLCC_CAM_IFE_0] = &llcc_mc_cam_ife_0,
+	[SLAVE_EBI1_CAM_IFE_0] = &ebi_cam_ife_0,
+	[MASTER_LLCC_CAM_IFE_1] = &llcc_mc_cam_ife_1,
+	[SLAVE_EBI1_CAM_IFE_1] = &ebi_cam_ife_1,
+	[MASTER_LLCC_CAM_IFE_2] = &llcc_mc_cam_ife_2,
+	[SLAVE_EBI1_CAM_IFE_2] = &ebi_cam_ife_2,
+};
+
+static const struct qcom_icc_desc sm8550_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
+	&bcm_mm0,
+	&bcm_mm1,
+	&bcm_mm0_disp,
+	&bcm_mm0_cam_ife_0,
+	&bcm_mm1_cam_ife_0,
+	&bcm_mm0_cam_ife_1,
+	&bcm_mm1_cam_ife_1,
+	&bcm_mm0_cam_ife_2,
+	&bcm_mm1_cam_ife_2,
+};
+
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
+	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
+	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
+	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
+	[MASTER_MDP] = &qnm_mdp,
+	[MASTER_CDSP_HCP] = &qnm_vapss_hcp,
+	[MASTER_VIDEO] = &qnm_video,
+	[MASTER_VIDEO_CV_PROC] = &qnm_video_cv_cpu,
+	[MASTER_VIDEO_PROC] = &qnm_video_cvp,
+	[MASTER_VIDEO_V_PROC] = &qnm_video_v_cpu,
+	[MASTER_CNOC_MNOC_CFG] = &qsm_mnoc_cfg,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
+	[MASTER_MDP_DISP] = &qnm_mdp_disp,
+	[SLAVE_MNOC_HF_MEM_NOC_DISP] = &qns_mem_noc_hf_disp,
+	[MASTER_CAMNOC_HF_CAM_IFE_0] = &qnm_camnoc_hf_cam_ife_0,
+	[MASTER_CAMNOC_ICP_CAM_IFE_0] = &qnm_camnoc_icp_cam_ife_0,
+	[MASTER_CAMNOC_SF_CAM_IFE_0] = &qnm_camnoc_sf_cam_ife_0,
+	[SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_0] = &qns_mem_noc_hf_cam_ife_0,
+	[SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_0] = &qns_mem_noc_sf_cam_ife_0,
+	[MASTER_CAMNOC_HF_CAM_IFE_1] = &qnm_camnoc_hf_cam_ife_1,
+	[MASTER_CAMNOC_ICP_CAM_IFE_1] = &qnm_camnoc_icp_cam_ife_1,
+	[MASTER_CAMNOC_SF_CAM_IFE_1] = &qnm_camnoc_sf_cam_ife_1,
+	[SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_1] = &qns_mem_noc_hf_cam_ife_1,
+	[SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_1] = &qns_mem_noc_sf_cam_ife_1,
+	[MASTER_CAMNOC_HF_CAM_IFE_2] = &qnm_camnoc_hf_cam_ife_2,
+	[MASTER_CAMNOC_ICP_CAM_IFE_2] = &qnm_camnoc_icp_cam_ife_2,
+	[MASTER_CAMNOC_SF_CAM_IFE_2] = &qnm_camnoc_sf_cam_ife_2,
+	[SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_2] = &qns_mem_noc_hf_cam_ife_2,
+	[SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_2] = &qns_mem_noc_sf_cam_ife_2,
+};
+
+static const struct qcom_icc_desc sm8550_mmss_noc = {
+	.nodes = mmss_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
+	.bcms = mmss_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const nsp_noc_bcms[] = {
+	&bcm_co0,
+};
+
+static struct qcom_icc_node * const nsp_noc_nodes[] = {
+	[MASTER_CDSP_PROC] = &qxm_nsp,
+	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
+};
+
+static const struct qcom_icc_desc sm8550_nsp_noc = {
+	.nodes = nsp_noc_nodes,
+	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
+	.bcms = nsp_noc_bcms,
+	.num_bcms = ARRAY_SIZE(nsp_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const pcie_anoc_bcms[] = {
+	&bcm_sn7,
+};
+
+static struct qcom_icc_node * const pcie_anoc_nodes[] = {
+	[MASTER_PCIE_ANOC_CFG] = &qsm_pcie_anoc_cfg,
+	[MASTER_PCIE_0] = &xm_pcie3_0,
+	[MASTER_PCIE_1] = &xm_pcie3_1,
+	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
+	[SLAVE_SERVICE_PCIE_ANOC] = &srvc_pcie_aggre_noc,
+};
+
+static const struct qcom_icc_desc sm8550_pcie_anoc = {
+	.nodes = pcie_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
+	.bcms = pcie_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn2,
+	&bcm_sn3,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_GIC_AHB] = &qhm_gic,
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
+	[MASTER_GIC] = &xm_gic,
+	[SLAVE_SNOC_GEM_NOC_GC] = &qns_gemnoc_gc,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+};
+
+static const struct qcom_icc_desc sm8550_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static int qnoc_probe(struct platform_device *pdev)
+{
+	const struct qcom_icc_desc *desc;
+	struct icc_onecell_data *data;
+	struct icc_provider *provider;
+	struct qcom_icc_node * const *qnodes;
+	struct qcom_icc_provider *qp;
+	struct icc_node *node;
+	size_t num_nodes, i;
+	int ret;
+
+	desc = device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	qnodes = desc->nodes;
+	num_nodes = desc->num_nodes;
+
+	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
+	if (!qp)
+		return -ENOMEM;
+
+	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	provider = &qp->provider;
+	provider->dev = &pdev->dev;
+	provider->set = qcom_icc_set;
+	provider->pre_aggregate = qcom_icc_pre_aggregate;
+	provider->aggregate = qcom_icc_aggregate;
+	provider->xlate_extended = qcom_icc_xlate_extended;
+	INIT_LIST_HEAD(&provider->nodes);
+	provider->data = data;
+
+	qp->dev = &pdev->dev;
+	qp->bcms = desc->bcms;
+	qp->num_bcms = desc->num_bcms;
+
+	qp->voter = of_bcm_voter_get(qp->dev, NULL);
+	if (IS_ERR(qp->voter))
+		return PTR_ERR(qp->voter);
+
+	ret = icc_provider_add(provider);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret,
+				"error adding interconnect provider\n");
+		return ret;
+	}
+
+	for (i = 0; i < qp->num_bcms; i++)
+		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
+
+	for (i = 0; i < num_nodes; i++) {
+		size_t j;
+
+		if (!qnodes[i])
+			continue;
+
+		node = icc_node_create(qnodes[i]->id);
+		if (IS_ERR(node)) {
+			ret = PTR_ERR(node);
+			goto err;
+		}
+
+		node->name = qnodes[i]->name;
+		node->data = qnodes[i];
+		icc_node_add(node, provider);
+
+		for (j = 0; j < qnodes[i]->num_links; j++)
+			icc_link_create(node, qnodes[i]->links[j]);
+
+		data->nodes[i] = node;
+	}
+	data->num_nodes = num_nodes;
+
+	platform_set_drvdata(pdev, qp);
+
+	return 0;
+err:
+	icc_nodes_remove(provider);
+	icc_provider_del(provider);
+	return ret;
+}
+
+static int qnoc_remove(struct platform_device *pdev)
+{
+	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
+
+	icc_nodes_remove(&qp->provider);
+	icc_provider_del(&qp->provider);
+
+	return 0;
+}
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,sm8550-aggre1-noc",
+	  .data = &sm8550_aggre1_noc},
+	{ .compatible = "qcom,sm8550-aggre2-noc",
+	  .data = &sm8550_aggre2_noc},
+	{ .compatible = "qcom,sm8550-clk-virt",
+	  .data = &sm8550_clk_virt},
+	{ .compatible = "qcom,sm8550-config-noc",
+	  .data = &sm8550_config_noc},
+	{ .compatible = "qcom,sm8550-cnoc-main",
+	  .data = &sm8550_cnoc_main},
+	{ .compatible = "qcom,sm8550-gem-noc",
+	  .data = &sm8550_gem_noc},
+	{ .compatible = "qcom,sm8550-lpass-ag-noc",
+	  .data = &sm8550_lpass_ag_noc},
+	{ .compatible = "qcom,sm8550-lpass-lpiaon-noc",
+	  .data = &sm8550_lpass_lpiaon_noc},
+	{ .compatible = "qcom,sm8550-lpass-lpicx-noc",
+	  .data = &sm8550_lpass_lpicx_noc},
+	{ .compatible = "qcom,sm8550-mc-virt",
+	  .data = &sm8550_mc_virt},
+	{ .compatible = "qcom,sm8550-mmss-noc",
+	  .data = &sm8550_mmss_noc},
+	{ .compatible = "qcom,sm8550-nsp-noc",
+	  .data = &sm8550_nsp_noc},
+	{ .compatible = "qcom,sm8550-pcie-anoc",
+	  .data = &sm8550_pcie_anoc},
+	{ .compatible = "qcom,sm8550-system-noc",
+	  .data = &sm8550_system_noc},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qnoc_probe,
+	.remove = qnoc_remove,
+	.driver = {
+		.name = "qnoc-sm8550",
+		.of_match_table = qnoc_of_match,
+	},
+};
+
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
+
+MODULE_DESCRIPTION("sm8550 NoC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/interconnect/qcom/sm8550.h b/drivers/interconnect/qcom/sm8550.h
new file mode 100644
index 000000000000..8d5862c04bca
--- /dev/null
+++ b/drivers/interconnect/qcom/sm8550.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SM8450 interconnect IDs
+ *
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SM8450_H
+#define __DRIVERS_INTERCONNECT_QCOM_SM8450_H
+
+#define SM8550_MASTER_A1NOC_SNOC			0
+#define SM8550_MASTER_A2NOC_SNOC			1
+#define SM8550_MASTER_ANOC_PCIE_GEM_NOC			2
+#define SM8550_MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_0	3
+#define SM8550_MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_1	4
+#define SM8550_MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_2	5
+#define SM8550_MASTER_ANOC_PCIE_GEM_NOC_DISP		6
+#define SM8550_MASTER_APPSS_PROC			7
+#define SM8550_MASTER_CAMNOC_HF				8
+#define SM8550_MASTER_CAMNOC_HF_CAM_IFE_0		9
+#define SM8550_MASTER_CAMNOC_HF_CAM_IFE_1		10
+#define SM8550_MASTER_CAMNOC_HF_CAM_IFE_2		11
+#define SM8550_MASTER_CAMNOC_ICP			12
+#define SM8550_MASTER_CAMNOC_ICP_CAM_IFE_0		13
+#define SM8550_MASTER_CAMNOC_ICP_CAM_IFE_1		14
+#define SM8550_MASTER_CAMNOC_ICP_CAM_IFE_2		15
+#define SM8550_MASTER_CAMNOC_SF				16
+#define SM8550_MASTER_CAMNOC_SF_CAM_IFE_0		17
+#define SM8550_MASTER_CAMNOC_SF_CAM_IFE_1		18
+#define SM8550_MASTER_CAMNOC_SF_CAM_IFE_2		19
+#define SM8550_MASTER_CDSP_HCP				20
+#define SM8550_MASTER_CDSP_PROC				21
+#define SM8550_MASTER_CNOC_CFG				22
+#define SM8550_MASTER_CNOC_MNOC_CFG			23
+#define SM8550_MASTER_COMPUTE_NOC			24
+#define SM8550_MASTER_CRYPTO				25
+#define SM8550_MASTER_GEM_NOC_CNOC			26
+#define SM8550_MASTER_GEM_NOC_PCIE_SNOC			27
+#define SM8550_MASTER_GFX3D				28
+#define SM8550_MASTER_GIC				29
+#define SM8550_MASTER_GIC_AHB				30
+#define SM8550_MASTER_GPU_TCU				31
+#define SM8550_MASTER_IPA				32
+#define SM8550_MASTER_LLCC				33
+#define SM8550_MASTER_LLCC_CAM_IFE_0			34
+#define SM8550_MASTER_LLCC_CAM_IFE_1			35
+#define SM8550_MASTER_LLCC_CAM_IFE_2			36
+#define SM8550_MASTER_LLCC_DISP				37
+#define SM8550_MASTER_LPASS_GEM_NOC			38
+#define SM8550_MASTER_LPASS_LPINOC			39
+#define SM8550_MASTER_LPASS_PROC			40
+#define SM8550_MASTER_LPIAON_NOC			41
+#define SM8550_MASTER_MDP				42
+#define SM8550_MASTER_MDP_DISP				43
+#define SM8550_MASTER_MNOC_HF_MEM_NOC			44
+#define SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_0		45
+#define SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_1		46
+#define SM8550_MASTER_MNOC_HF_MEM_NOC_CAM_IFE_2		47
+#define SM8550_MASTER_MNOC_HF_MEM_NOC_DISP		48
+#define SM8550_MASTER_MNOC_SF_MEM_NOC			49
+#define SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_0		50
+#define SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_1		51
+#define SM8550_MASTER_MNOC_SF_MEM_NOC_CAM_IFE_2		52
+#define SM8550_MASTER_MSS_PROC				53
+#define SM8550_MASTER_PCIE_0				54
+#define SM8550_MASTER_PCIE_1				55
+#define SM8550_MASTER_PCIE_ANOC_CFG			56
+#define SM8550_MASTER_QDSS_BAM				57
+#define SM8550_MASTER_QDSS_ETR				58
+#define SM8550_MASTER_QDSS_ETR_1			59
+#define SM8550_MASTER_QSPI_0				60
+#define SM8550_MASTER_QUP_1				61
+#define SM8550_MASTER_QUP_2				62
+#define SM8550_MASTER_QUP_CORE_0			63
+#define SM8550_MASTER_QUP_CORE_1			64
+#define SM8550_MASTER_QUP_CORE_2			65
+#define SM8550_MASTER_SDCC_2				66
+#define SM8550_MASTER_SDCC_4				67
+#define SM8550_MASTER_SNOC_GC_MEM_NOC			68
+#define SM8550_MASTER_SNOC_SF_MEM_NOC			69
+#define SM8550_MASTER_SP				70
+#define SM8550_MASTER_SYS_TCU				71
+#define SM8550_MASTER_UFS_MEM				72
+#define SM8550_MASTER_USB3_0				73
+#define SM8550_MASTER_VIDEO				74
+#define SM8550_MASTER_VIDEO_CV_PROC			75
+#define SM8550_MASTER_VIDEO_PROC			76
+#define SM8550_MASTER_VIDEO_V_PROC			77
+#define SM8550_SLAVE_A1NOC_SNOC				78
+#define SM8550_SLAVE_A2NOC_SNOC				79
+#define SM8550_SLAVE_AHB2PHY_NORTH			80
+#define SM8550_SLAVE_AHB2PHY_SOUTH			81
+#define SM8550_SLAVE_ANOC_PCIE_GEM_NOC			82
+#define SM8550_SLAVE_AOSS				83
+#define SM8550_SLAVE_APPSS				84
+#define SM8550_SLAVE_BOOT_IMEM				85
+#define SM8550_SLAVE_CAMERA_CFG				86
+#define SM8550_SLAVE_CDSP_MEM_NOC			87
+#define SM8550_SLAVE_CLK_CTL				88
+#define SM8550_SLAVE_CNOC_CFG				89
+#define SM8550_SLAVE_CNOC_MNOC_CFG			90
+#define SM8550_SLAVE_CNOC_MSS				91
+#define SM8550_SLAVE_CPR_NSPCX				92
+#define SM8550_SLAVE_CRYPTO_0_CFG			93
+#define SM8550_SLAVE_CX_RDPM				94
+#define SM8550_SLAVE_DDRSS_CFG				95
+#define SM8550_SLAVE_DISPLAY_CFG			96
+#define SM8550_SLAVE_EBI1				97
+#define SM8550_SLAVE_EBI1_CAM_IFE_0			98
+#define SM8550_SLAVE_EBI1_CAM_IFE_1			99
+#define SM8550_SLAVE_EBI1_CAM_IFE_2			100
+#define SM8550_SLAVE_EBI1_DISP				101
+#define SM8550_SLAVE_GEM_NOC_CNOC			102
+#define SM8550_SLAVE_GFX3D_CFG				103
+#define SM8550_SLAVE_I2C				104
+#define SM8550_SLAVE_IMEM				105
+#define SM8550_SLAVE_IMEM_CFG				106
+#define SM8550_SLAVE_IPA_CFG				107
+#define SM8550_SLAVE_IPC_ROUTER_CFG			108
+#define SM8550_SLAVE_LLCC				109
+#define SM8550_SLAVE_LLCC_CAM_IFE_0			110
+#define SM8550_SLAVE_LLCC_CAM_IFE_1			111
+#define SM8550_SLAVE_LLCC_CAM_IFE_2			112
+#define SM8550_SLAVE_LLCC_DISP				113
+#define SM8550_SLAVE_LPASS_GEM_NOC			114
+#define SM8550_SLAVE_LPASS_QTB_CFG			115
+#define SM8550_SLAVE_LPIAON_NOC_LPASS_AG_NOC		116
+#define SM8550_SLAVE_LPICX_NOC_LPIAON_NOC		117
+#define SM8550_SLAVE_MEM_NOC_PCIE_SNOC			118
+#define SM8550_SLAVE_MNOC_HF_MEM_NOC			119
+#define SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_0		120
+#define SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_1		121
+#define SM8550_SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_2		122
+#define SM8550_SLAVE_MNOC_HF_MEM_NOC_DISP		123
+#define SM8550_SLAVE_MNOC_SF_MEM_NOC			124
+#define SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_0		125
+#define SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_1		126
+#define SM8550_SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_2		127
+#define SM8550_SLAVE_MX_RDPM				128
+#define SM8550_SLAVE_NSP_QTB_CFG			129
+#define SM8550_SLAVE_PCIE_0				130
+#define SM8550_SLAVE_PCIE_0_CFG				131
+#define SM8550_SLAVE_PCIE_1				132
+#define SM8550_SLAVE_PCIE_1_CFG				133
+#define SM8550_SLAVE_PCIE_ANOC_CFG			134
+#define SM8550_SLAVE_PDM				135
+#define SM8550_SLAVE_PIMEM_CFG				136
+#define SM8550_SLAVE_PRNG				137
+#define SM8550_SLAVE_QDSS_CFG				138
+#define SM8550_SLAVE_QDSS_STM				139
+#define SM8550_SLAVE_QSPI_0				140
+#define SM8550_SLAVE_QUP_1				141
+#define SM8550_SLAVE_QUP_2				142
+#define SM8550_SLAVE_QUP_CORE_0				143
+#define SM8550_SLAVE_QUP_CORE_1				144
+#define SM8550_SLAVE_QUP_CORE_2				145
+#define SM8550_SLAVE_RBCPR_CX_CFG			146
+#define SM8550_SLAVE_RBCPR_MMCX_CFG			147
+#define SM8550_SLAVE_RBCPR_MXA_CFG			148
+#define SM8550_SLAVE_RBCPR_MXC_CFG			149
+#define SM8550_SLAVE_SDCC_2				150
+#define SM8550_SLAVE_SDCC_4				151
+#define SM8550_SLAVE_SERVICE_MNOC			152
+#define SM8550_SLAVE_SERVICE_PCIE_ANOC			153
+#define SM8550_SLAVE_SNOC_GEM_NOC_GC			154
+#define SM8550_SLAVE_SNOC_GEM_NOC_SF			155
+#define SM8550_SLAVE_SPSS_CFG				156
+#define SM8550_SLAVE_TCSR				157
+#define SM8550_SLAVE_TCU				158
+#define SM8550_SLAVE_TLMM				159
+#define SM8550_SLAVE_TME_CFG				160
+#define SM8550_SLAVE_UFS_MEM_CFG			161
+#define SM8550_SLAVE_USB3_0				162
+#define SM8550_SLAVE_VENUS_CFG				163
+#define SM8550_SLAVE_VSENSE_CTRL_CFG			164
+
+#endif
-- 
2.34.1

