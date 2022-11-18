Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3587F62F02F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbiKRIyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241618AbiKRIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:53:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F64B63CC9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:53:53 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a14so8243156wru.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZM+/eA5EeYgU6vVbsCp5elFhU52KA03Cvx4YSfR2fc=;
        b=ISJ9rEXISkwZ7jZ+xw2nFd42wbqUUrS9KtVTxT0F8TpEmfuvVTuyKqSH0dN6xVGn+d
         YbokNeDKP3b3NA9Ltkhxx46muzphG6zJ6ewb7Od+5r6q2D9TlmM0PZl/mxrAuzQ4LuXv
         8YWmFY/ZXPCUKYwaSfpnHXVvlDVWiDpLuD2gNo0IQMit37lppX1xq8zdHlWAlIoRaIJx
         fp1jyYlGZ9aTvXsyHwuIDNUvliQXnn/rJ33QUwWJVT/YzrUfV1s0cGUkem4U2VGproNR
         EezPg1IHfsJ6jQx/NNHvJ6EV61rDEPhm+4hmpKQCOVX4YO/71yIiky67pG2/HUXzBVT7
         ctiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZM+/eA5EeYgU6vVbsCp5elFhU52KA03Cvx4YSfR2fc=;
        b=c2uj09Ei7X8A3lzqpyIZW/uz0sd/OXy5pHQ2cntdhcv0iRVU2GX/1Ksr6UfX4WYCxd
         2DNFNOOC5mKxKemR2pDhpB4i3R3iei+R/4e/YXhQTs59Tt6xT9Fgqz/zCCsQ0lchsCom
         9Cc7MkEM+3ktR2LUwBuLrxZf+3MN+yUuNspjS0g/6xRKgp6yJtzYoQxHrZz8ji4ucNLJ
         d3s36kQcv6r5dMPnC2Qob8nxm1847J9O1L4BB8ZzcYvtlC3IAjBRVyAouO7npWeZDmL6
         e4THFnwXKQOxydnymEs9GlFcMfzXKRu5od666zpFFUPN2mmCYdKQzSk7oN2fOBGLO8f2
         F+Sg==
X-Gm-Message-State: ANoB5pmc6xf+LAQ98WNjEGkCLPb9ooOI2lanHvvvRG6DjOV3LaedpdrI
        8zdPREEDKrjGG+JfigPC8GvDCA==
X-Google-Smtp-Source: AA0mqf49sAoUGo4U6vUD/SoNWKrkDJHvMZdu1vEWWxXTQLuO4XuQTJtsxKvr4nx0BFStN2Yb/56KAg==
X-Received: by 2002:adf:ea0b:0:b0:236:695b:6275 with SMTP id q11-20020adfea0b000000b00236695b6275mr3789781wrm.116.1668761631867;
        Fri, 18 Nov 2022 00:53:51 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d53cd000000b002383edcde09sm2971264wrw.59.2022.11.18.00.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:53:51 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 18 Nov 2022 09:53:49 +0100
Subject: [PATCH v2 2/2] soc: qcom: add MDSS DSM memory driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v2-2-f7c65d6f0e55@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v2-0-f7c65d6f0e55@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v2-0-f7c65d6f0e55@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Qualcomm Modem Processing SubSystem DSM memory
used to assign such regions of memory with remote MPSS processors.

This memory zone is shared between the APPS and the MPSS subsystem,
and must be configured during the whole lifetime of the system.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/of/platform.c           |  1 +
 drivers/soc/qcom/Kconfig        | 10 +++++
 drivers/soc/qcom/Makefile       |  1 +
 drivers/soc/qcom/mpss_dsm_mem.c | 95 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 3507095a69f6..d4bb03292f45 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -505,6 +505,7 @@ EXPORT_SYMBOL_GPL(of_platform_default_populate);
 
 static const struct of_device_id reserved_mem_matches[] = {
 	{ .compatible = "phram" },
+	{ .compatible = "qcom,mpss-dsm-mem" },
 	{ .compatible = "qcom,rmtfs-mem" },
 	{ .compatible = "qcom,cmd-db" },
 	{ .compatible = "qcom,smem" },
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 024e420f1bb7..7624a8af56bf 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -95,6 +95,16 @@ config QCOM_QMI_HELPERS
 	tristate
 	depends on NET
 
+config QCOM_MPSS_DSM_MEM
+	tristate "Qualcomm Modem Processing SubSystem DSM memory driver"
+	depends on ARCH_QCOM
+	select QCOM_SCM
+	help
+	  The Qualcomm Modem Processing SubSystem DSM memory driver is used to
+	  assign regions of DSM memory with remote MPSS processors.
+
+	  Say y here if you intend to boot the modem remoteproc.
+
 config QCOM_RMTFS_MEM
 	tristate "Qualcomm Remote Filesystem memory driver"
 	depends on ARCH_QCOM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index d66604aff2b0..0d0e850f1a18 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -16,6 +16,7 @@ qcom_rpmh-y			+= rpmh-rsc.o
 qcom_rpmh-y			+= rpmh.o
 obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
 obj-$(CONFIG_QCOM_SMEM) +=	smem.o
+obj-$(CONFIG_QCOM_MPSS_DSM_MEM) += mpss_dsm_mem.o
 obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
diff --git a/drivers/soc/qcom/mpss_dsm_mem.c b/drivers/soc/qcom/mpss_dsm_mem.c
new file mode 100644
index 000000000000..5584bd101aee
--- /dev/null
+++ b/drivers/soc/qcom/mpss_dsm_mem.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Linaro Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/slab.h>
+#include <linux/qcom_scm.h>
+
+struct qcom_mpss_dsm_mem {
+	phys_addr_t addr;
+	phys_addr_t size;
+
+	unsigned int perms;
+};
+
+static int qcom_mpss_dsm_mem_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct qcom_scm_vmperm perm;
+	struct reserved_mem *rmem;
+	struct qcom_mpss_dsm_mem *mpss_dsm_mem;
+	int ret;
+
+	if (!qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
+	rmem = of_reserved_mem_lookup(node);
+	if (!rmem) {
+		dev_err(&pdev->dev, "failed to acquire memory region\n");
+		return -EINVAL;
+	}
+
+	mpss_dsm_mem = kzalloc(sizeof(*mpss_dsm_mem), GFP_KERNEL);
+	if (!mpss_dsm_mem)
+		return -ENOMEM;
+
+	mpss_dsm_mem->addr = rmem->base;
+	mpss_dsm_mem->size = rmem->size;
+
+	perm.vmid = QCOM_SCM_VMID_MSS_MSA;
+	perm.perm = QCOM_SCM_PERM_RW;
+
+	mpss_dsm_mem->perms = BIT(QCOM_SCM_VMID_HLOS);
+	ret = qcom_scm_assign_mem(mpss_dsm_mem->addr, mpss_dsm_mem->size,
+				  &mpss_dsm_mem->perms, &perm, 1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "assign memory failed\n");
+		return ret;
+	}
+
+	dev_set_drvdata(&pdev->dev, mpss_dsm_mem);
+
+	return 0;
+}
+
+static int qcom_mpss_dsm_mem_remove(struct platform_device *pdev)
+{
+	struct qcom_mpss_dsm_mem *mpss_dsm_mem = dev_get_drvdata(&pdev->dev);
+	struct qcom_scm_vmperm perm;
+
+	perm.vmid = QCOM_SCM_VMID_HLOS;
+	perm.perm = QCOM_SCM_PERM_RW;
+
+	qcom_scm_assign_mem(mpss_dsm_mem->addr, mpss_dsm_mem->size,
+			    &mpss_dsm_mem->perms, &perm, 1);
+
+	return 0;
+}
+
+static const struct of_device_id qcom_mpss_dsm_mem_of_match[] = {
+	{ .compatible = "qcom,mpss-dsm-mem" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_mpss_dsm_mem_of_match);
+
+static struct platform_driver qcom_mpss_dsm_mem_driver = {
+	.probe = qcom_mpss_dsm_mem_probe,
+	.remove = qcom_mpss_dsm_mem_remove,
+	.driver  = {
+		.name  = "qcom_mpss_dsm_mem",
+		.of_match_table = qcom_mpss_dsm_mem_of_match,
+	},
+};
+
+module_platform_driver(qcom_mpss_dsm_mem_driver);
+
+MODULE_AUTHOR("Linaro Ltd");
+MODULE_DESCRIPTION("Qualcomm DSM memory driver");
+MODULE_LICENSE("GPL");

-- 
b4 0.10.1
