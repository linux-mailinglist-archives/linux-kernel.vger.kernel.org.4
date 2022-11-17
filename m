Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C4062DCC8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbiKQNaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbiKQNaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:30:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92163716C7;
        Thu, 17 Nov 2022 05:30:06 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D30176602A9F;
        Thu, 17 Nov 2022 13:30:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668691805;
        bh=tOq+qh5dsx2Gm7yk2Gp32cqUGPckPRG/YW7a6MjMYxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cl2VKa4WsON9PTstBiRldYdl+Kh2rQCAWfVXpM8nLpIRvKZxd7NATERPVp1UgdWVo
         tl2XwcWu9yqywm5YdTnJTSG3yAALXuO9Nha72dMA3u22wZ+tAKIx85mxhn6YTDAw4W
         B7YU+2sdPiQxzlPJU4XwoHVwzeZ9tWjxK7ezOPDocAPCKaOjOfqgc0VuCJlN8Jl09G
         By/Kr8+FpcZ5MV2XerRyRX0rObOiXJg3CYrYbreG2g3QRT4rRS9IdKf/eELureG+GW
         oFeZup5BS3mPDqp+33CIKwCs5gBRTmfrAWgcjKi6R3P4Rfi5Ks9SMN1I1/sH12DgEx
         knlH+DvfjHKpA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com
Subject: [PATCH v4 2/2] soc: qcom: Add Qualcomm Ramp Controller driver
Date:   Thu, 17 Nov 2022 14:29:56 +0100
Message-Id: <20221117132956.169432-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117132956.169432-1-angelogioacchino.delregno@collabora.com>
References: <20221117132956.169432-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ramp Controller is used to program the sequence ID for pulse
swallowing, enable sequence and linking sequence IDs for the CPU
cores on some Qualcomm SoCs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/qcom/Kconfig           |   9 +
 drivers/soc/qcom/Makefile          |   1 +
 drivers/soc/qcom/ramp_controller.c | 342 +++++++++++++++++++++++++++++
 3 files changed, 352 insertions(+)
 create mode 100644 drivers/soc/qcom/ramp_controller.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 024e420f1bb7..d174183a26f7 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -95,6 +95,15 @@ config QCOM_QMI_HELPERS
 	tristate
 	depends on NET
 
+config QCOM_RAMP_CTRL
+	tristate "Qualcomm Ramp Controller driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  The Ramp Controller is used to program the sequence ID for pulse
+	  swallowing, enable sequence and link sequence IDs for the CPU
+	  cores on some Qualcomm SoCs.
+	  Say y here to enable support for the ramp controller.
+
 config QCOM_RMTFS_MEM
 	tristate "Qualcomm Remote Filesystem memory driver"
 	depends on ARCH_QCOM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index d66604aff2b0..6e02333c4080 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
 obj-$(CONFIG_QCOM_PDR_HELPERS)	+= pdr_interface.o
 obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
 qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
+obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
 obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
 obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
 qcom_rpmh-y			+= rpmh-rsc.o
diff --git a/drivers/soc/qcom/ramp_controller.c b/drivers/soc/qcom/ramp_controller.c
new file mode 100644
index 000000000000..8f8c514b7288
--- /dev/null
+++ b/drivers/soc/qcom/ramp_controller.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm Ramp Controller driver
+ * Copyright (c) 2022, AngeloGioacchino Del Regno
+ *                     <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#define RC_UPDATE_EN		BIT(0)
+#define RC_ROOT_EN		BIT(1)
+
+#define RC_REG_CFG_UPDATE	0x60
+#define RC_CFG_UPDATE_EN	BIT(8)
+#define RC_CFG_ACK		GENMASK(31, 16)
+
+#define RC_DCVS_CFG_SID		2
+#define RC_LINK_SID		3
+#define RC_LMH_SID		6
+#define RC_DFS_SID		14
+
+#define RC_UPDATE_TIMEOUT_US	500
+
+/**
+ * struct qcom_ramp_controller_desc - SoC specific parameters
+ * @cfg_dfs_sid:      Dynamic Frequency Scaling SID configuration
+ * @cfg_link_sid:     Link SID configuration
+ * @cfg_lmh_sid:      Limits Management hardware SID configuration
+ * @cfg_ramp_en:      Ramp Controller enable sequence
+ * @cfg_ramp_dis:     Ramp Controller disable sequence
+ * @cmd_reg:          Command register offset
+ * @num_dfs_sids:     Number of DFS SIDs (max 8)
+ * @num_link_sids:    Number of Link SIDs (max 3)
+ * @num_lmh_sids:     Number of LMh SIDs (max 8)
+ * @num_ramp_en:      Number of entries in enable sequence
+ * @num_ramp_dis:     Number of entries in disable sequence
+ */
+struct qcom_ramp_controller_desc {
+	const struct reg_sequence *cfg_dfs_sid;
+	const struct reg_sequence *cfg_link_sid;
+	const struct reg_sequence *cfg_lmh_sid;
+	const struct reg_sequence *cfg_ramp_en;
+	const struct reg_sequence *cfg_ramp_dis;
+	u8 cmd_reg;
+	u8 num_dfs_sids;
+	u8 num_link_sids;
+	u8 num_lmh_sids;
+	u8 num_ramp_en;
+	u8 num_ramp_dis;
+};
+
+/**
+ * struct qcom_ramp_controller - Main driver structure
+ * @regmap: Regmap handle
+ * @desc:   SoC specific parameters
+ */
+struct qcom_ramp_controller {
+	struct regmap *regmap;
+	const struct qcom_ramp_controller_desc *desc;
+};
+
+/**
+ * rc_wait_for_update() - Wait for Ramp Controller root update
+ * @qrc: Main driver structure
+ *
+ * Return: Zero for success or negative number for failure
+ */
+static int rc_wait_for_update(struct qcom_ramp_controller *qrc)
+{
+	const struct qcom_ramp_controller_desc *d = qrc->desc;
+	struct regmap *r = qrc->regmap;
+	u32 val;
+	int ret;
+
+	ret = regmap_set_bits(r, d->cmd_reg, RC_ROOT_EN);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(r, d->cmd_reg, val, !(val & RC_UPDATE_EN),
+					1, RC_UPDATE_TIMEOUT_US);
+}
+
+/**
+ * rc_set_cfg_update() - Ramp Controller configuration update
+ * @qrc: Main driver structure
+ * @ce: Configuration entry to update
+ *
+ * Return: Zero for success or negative number for failure
+ */
+static int rc_set_cfg_update(struct qcom_ramp_controller *qrc, u8 ce)
+{
+	const struct qcom_ramp_controller_desc *d = qrc->desc;
+	struct regmap *r = qrc->regmap;
+	u32 ack, val;
+	int ret;
+
+	/* The ack bit is between bits 16-31 of RC_REG_CFG_UPDATE */
+	ack = FIELD_PREP(RC_CFG_ACK, BIT(ce));
+
+	/* Write the configuration type first... */
+	ret = regmap_set_bits(r, d->cmd_reg + RC_REG_CFG_UPDATE, ce);
+	if (ret)
+		return ret;
+
+	/* ...and after that, enable the update bit to sync the changes */
+	ret = regmap_set_bits(r, d->cmd_reg + RC_REG_CFG_UPDATE, RC_CFG_UPDATE_EN);
+	if (ret)
+		return ret;
+
+	/* Wait for the changes to go through */
+	ret = regmap_read_poll_timeout(r, d->cmd_reg + RC_REG_CFG_UPDATE, val,
+				       val & ack, 1, RC_UPDATE_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	/*
+	 * Configuration update success! The CFG_UPDATE register will not be
+	 * cleared automatically upon applying the configuration, so we have
+	 * to do that manually in order to leave the ramp controller in a
+	 * predictable and clean state.
+	 */
+	ret = regmap_write(r, d->cmd_reg + RC_REG_CFG_UPDATE, 0);
+	if (ret)
+		return ret;
+
+	/* Wait for the update bit cleared ack */
+	return regmap_read_poll_timeout(r, d->cmd_reg + RC_REG_CFG_UPDATE,
+					val, !(val & RC_CFG_ACK), 1,
+					RC_UPDATE_TIMEOUT_US);
+}
+
+/**
+ * rc_write_cfg - Send configuration sequence
+ * @qrc: Main driver structure
+ * @seq: Register sequence to send before asking for update
+ * @ce: Configuration SID
+ * @nsids: Total number of SIDs
+ *
+ * Returns: Zero for success or negative number for error
+ */
+static int rc_write_cfg(struct qcom_ramp_controller *qrc,
+			const struct reg_sequence *seq,
+			u16 ce, u8 nsids)
+{
+	int ret;
+	u8 i;
+
+	/* Check if, and wait until the ramp controller is ready */
+	ret = rc_wait_for_update(qrc);
+	if (ret)
+		return ret;
+
+	/* Write the sequence */
+	ret = regmap_multi_reg_write(qrc->regmap, seq, nsids);
+	if (ret)
+		return ret;
+
+	/* Pull the trigger: do config update starting from the last sid */
+	for (i = 0; i < nsids; i++) {
+		ret = rc_set_cfg_update(qrc, (u8)ce - i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * rc_ramp_ctrl_enable() - Enable Ramp up/down Control
+ * @qrc: Main driver structure
+ *
+ * Return: Zero for success or negative number for error
+ */
+static int rc_ramp_ctrl_enable(struct qcom_ramp_controller *qrc)
+{
+	const struct qcom_ramp_controller_desc *d = qrc->desc;
+	int i, ret;
+
+	for (i = 0; i < d->num_ramp_en; i++) {
+		ret = rc_write_cfg(qrc, &d->cfg_ramp_en[i], RC_DCVS_CFG_SID, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * qcom_ramp_controller_start() - Initialize and start the ramp controller
+ * @qrc: Main driver structure
+ *
+ * The Ramp Controller needs to be initialized by programming the relevant
+ * registers with SoC-specific configuration: once programming is done,
+ * the hardware will take care of the rest (no further handling required).
+ *
+ * Return: Zero for success or negative number for error
+ */
+static int qcom_ramp_controller_start(struct qcom_ramp_controller *qrc)
+{
+	const struct qcom_ramp_controller_desc *d = qrc->desc;
+	int ret;
+
+	/* Program LMH, DFS, Link SIDs */
+	ret = rc_write_cfg(qrc, d->cfg_lmh_sid, RC_LMH_SID, d->num_lmh_sids);
+	if (ret)
+		return ret;
+
+	ret = rc_write_cfg(qrc, d->cfg_dfs_sid, RC_DFS_SID, d->num_dfs_sids);
+	if (ret)
+		return ret;
+
+	ret = rc_write_cfg(qrc, d->cfg_link_sid, RC_LINK_SID, d->num_link_sids);
+	if (ret)
+		return ret;
+
+	/* Everything is ready! Enable the ramp up/down control */
+	return rc_ramp_ctrl_enable(qrc);
+}
+
+static const struct regmap_config qrc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register =	0x68,
+	.fast_io = true,
+};
+
+const struct reg_sequence msm8976_cfg_dfs_sid[] = {
+	{ 0x10, 0xfefebff7 },
+	{ 0x14, 0xfdff7fef },
+	{ 0x18, 0xfbffdefb },
+	{ 0x1c, 0xb69b5555 },
+	{ 0x20, 0x24929249 },
+	{ 0x24, 0x49241112 },
+	{ 0x28, 0x11112111 },
+	{ 0x2c, 0x8102 }
+};
+
+const struct reg_sequence msm8976_cfg_link_sid[] = {
+	{ 0x40, 0xfc987 }
+};
+
+const struct reg_sequence msm8976_cfg_lmh_sid[] = {
+	{ 0x30, 0x77706db },
+	{ 0x34, 0x5550249 },
+	{ 0x38, 0x111 }
+};
+
+const struct reg_sequence msm8976_cfg_ramp_en[] = {
+	{ 0x50, 0x800 }, /* pre_en */
+	{ 0x50, 0xc00 }, /* en */
+	{ 0x50, 0x400 }  /* post_en */
+};
+
+const struct reg_sequence msm8976_cfg_ramp_dis[] = {
+	{ 0x50, 0x0 }
+};
+
+static const struct qcom_ramp_controller_desc msm8976_rc_cfg = {
+	.cfg_dfs_sid = msm8976_cfg_dfs_sid,
+	.num_dfs_sids = ARRAY_SIZE(msm8976_cfg_dfs_sid),
+
+	.cfg_link_sid = msm8976_cfg_link_sid,
+	.num_link_sids = ARRAY_SIZE(msm8976_cfg_link_sid),
+
+	.cfg_lmh_sid = msm8976_cfg_lmh_sid,
+	.num_lmh_sids = ARRAY_SIZE(msm8976_cfg_lmh_sid),
+
+	.cfg_ramp_en = msm8976_cfg_ramp_en,
+	.num_ramp_en = ARRAY_SIZE(msm8976_cfg_ramp_en),
+
+	.cfg_ramp_dis = msm8976_cfg_ramp_dis,
+	.num_ramp_dis = ARRAY_SIZE(msm8976_cfg_ramp_dis),
+
+	.cmd_reg = 0x0,
+};
+
+static int qcom_ramp_controller_probe(struct platform_device *pdev)
+{
+	struct qcom_ramp_controller *qrc;
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	qrc = devm_kmalloc(&pdev->dev, sizeof(*qrc), GFP_KERNEL);
+	if (!qrc)
+		return -ENOMEM;
+
+	qrc->desc = device_get_match_data(&pdev->dev);
+	if (!qrc)
+		return -EINVAL;
+
+	qrc->regmap = devm_regmap_init_mmio(&pdev->dev, base, &qrc_regmap_config);
+	if (IS_ERR(qrc->regmap))
+		return PTR_ERR(qrc->regmap);
+
+	platform_set_drvdata(pdev, qrc);
+
+	return qcom_ramp_controller_start(qrc);
+}
+
+static int qcom_ramp_controller_remove(struct platform_device *pdev)
+{
+	struct qcom_ramp_controller *qrc = platform_get_drvdata(pdev);
+
+	return rc_write_cfg(qrc, qrc->desc->cfg_ramp_dis,
+			    RC_DCVS_CFG_SID, qrc->desc->num_ramp_dis);
+}
+
+static const struct of_device_id qcom_ramp_controller_match_table[] = {
+	{ .compatible = "qcom,msm8976-ramp-controller", .data = &msm8976_rc_cfg },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, qcom_ramp_controller_match_table);
+
+static struct platform_driver qcom_ramp_controller_driver = {
+	.driver = {
+		.name = "qcom-ramp-controller",
+		.of_match_table = qcom_ramp_controller_match_table,
+		.suppress_bind_attrs = true,
+	},
+	.probe  = qcom_ramp_controller_probe,
+	.remove = qcom_ramp_controller_remove,
+};
+
+static int __init qcom_ramp_controller_init(void)
+{
+	return platform_driver_register(&qcom_ramp_controller_driver);
+}
+arch_initcall(qcom_ramp_controller_init);
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_DESCRIPTION("Qualcomm Ramp Controller driver");
+MODULE_LICENSE("GPL");
-- 
2.38.1

