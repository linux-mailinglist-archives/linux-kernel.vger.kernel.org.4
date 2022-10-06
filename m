Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F185F657B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiJFL6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJFL61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:58:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EDE9C234
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 04:58:25 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F3BA166022F9;
        Thu,  6 Oct 2022 12:58:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665057504;
        bh=MV6gkw/usZ0HIx4r3l8+AwPedwSunrhou+wAhQ0kQoY=;
        h=From:To:Cc:Subject:Date:From;
        b=GxAwQVP3FoSWjRP1D3xfkybu8tpseMHA6KRT1y3xorVHHcsuChOmgIut/1aS64TlB
         svvHSbxkojS5W5xuQkHNPZYNvAAK1muzONzJVTKZV53O+Y6nvDly0+WB0czbwZnYK8
         IjjQGvhpCUe9eS8j/Y+QMQW7GKoMHiJzGT5revrGyE1uvXr20HoDWZ/Mf8pgC78jtt
         bonQwI/czkm9FDLN8VuR6iv0ui697cl3S3LV1z5nttw6mtgVLePCBh6YLbXxNOK7ze
         6qgmECPURsMbhUEuBTRXjPzdwRBvp7e/9ABbGTfyEZHZK7In7Ap9dEL1Bq45xFpU17
         vIXavmewhYoig==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        alyssa.rosenzweig@collabora.com, nfraprado@collabora.com,
        dmitry.osipenko@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [RESEND PATCH v3] soc: mediatek: Introduce mediatek-regulator-coupler driver
Date:   Thu,  6 Oct 2022 13:58:16 +0200
Message-Id: <20221006115816.66853-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
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

This driver currently deals with GPU-SRAM regulator coupling, ensuring
that the SRAM voltage is always between a specific range of distance to
the GPU voltage, depending on the SoC, necessary in order to achieve
system stability across the full range of supported GPU frequencies.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---

This driver was successfully tested for more than 3 months.
GPU DVFS works correctly with no stability issues.

Changes in RESEND,v3:
 Rebased over next-20221005

Changes in v3:
 - Added braces to else-if branch

Changes in v2:
 - Added check for n_coupled
 - Added check for vgpu to enforce attaching to vgpu<->sram coupling only

Context:
This driver is the last of the pieces of a bigger puzzle, aiming to finally
enable Dynamic Voltage/Frequency Scaling for Mali GPUs found on MediaTek
SoCs on the fully open source graphics stack (Panfrost driver).

No devicetree bindings are provided because this does not require any
driver-specific binding at all.

Last but not least: it was chosen to have this driver enabled for
( ARCH_MEDIATEK && REGULATOR ) without really giving a free configuration
choice because, once the DVFS mechanism will be fully working, using one
of the listed MediaTek SoCs *without* this coupling mechanism *will* lead
to unstabilities and system crashes.
For COMPILE_TEST, choice is given for obvious reasons.

 drivers/soc/mediatek/Kconfig                 |   5 +
 drivers/soc/mediatek/Makefile                |   1 +
 drivers/soc/mediatek/mtk-regulator-coupler.c | 159 +++++++++++++++++++
 3 files changed, 165 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-regulator-coupler.c

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 40d0cc600cae..30b5afc0e51d 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -44,6 +44,11 @@ config MTK_PMIC_WRAP
 	  on different MediaTek SoCs. The PMIC wrapper is a proprietary
 	  hardware to connect the PMIC.
 
+config MTK_REGULATOR_COUPLER
+	bool "MediaTek SoC Regulator Coupler" if COMPILE_TEST
+	default ARCH_MEDIATEK
+	depends on REGULATOR
+
 config MTK_SCPSYS
 	bool "MediaTek SCPSYS Support"
 	default ARCH_MEDIATEK
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 0e9e703c931a..8c0ddacbcde8 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
 obj-$(CONFIG_MTK_DEVAPC) += mtk-devapc.o
 obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
 obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
+obj-$(CONFIG_MTK_REGULATOR_COUPLER) += mtk-regulator-coupler.o
 obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
 obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
diff --git a/drivers/soc/mediatek/mtk-regulator-coupler.c b/drivers/soc/mediatek/mtk-regulator-coupler.c
new file mode 100644
index 000000000000..ad2ed42aa697
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-regulator-coupler.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Voltage regulators coupler for MediaTek SoCs
+ *
+ * Copyright (C) 2022 Collabora, Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/regulator/coupler.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/suspend.h>
+
+#define to_mediatek_coupler(x)	container_of(x, struct mediatek_regulator_coupler, coupler)
+
+struct mediatek_regulator_coupler {
+	struct regulator_coupler coupler;
+	struct regulator_dev *vsram_rdev;
+};
+
+/*
+ * We currently support only couples of not more than two vregs and
+ * modify the vsram voltage only when changing voltage of vgpu.
+ *
+ * This function is limited to the GPU<->SRAM voltages relationships.
+ */
+static int mediatek_regulator_balance_voltage(struct regulator_coupler *coupler,
+					      struct regulator_dev *rdev,
+					      suspend_state_t state)
+{
+	struct mediatek_regulator_coupler *mrc = to_mediatek_coupler(coupler);
+	int max_spread = rdev->constraints->max_spread[0];
+	int vsram_min_uV = mrc->vsram_rdev->constraints->min_uV;
+	int vsram_max_uV = mrc->vsram_rdev->constraints->max_uV;
+	int vsram_target_min_uV, vsram_target_max_uV;
+	int min_uV = 0;
+	int max_uV = INT_MAX;
+	int ret;
+
+	/*
+	 * If the target device is on, setting the SRAM voltage directly
+	 * is not supported as it scales through its coupled supply voltage.
+	 *
+	 * An exception is made in case the use_count is zero: this means
+	 * that this is the first time we power up the SRAM regulator, which
+	 * implies that the target device has yet to perform initialization
+	 * and setting a voltage at that time is harmless.
+	 */
+	if (rdev == mrc->vsram_rdev) {
+		if (rdev->use_count == 0)
+			return regulator_do_balance_voltage(rdev, state, true);
+
+		return -EPERM;
+	}
+
+	ret = regulator_check_consumers(rdev, &min_uV, &max_uV, state);
+	if (ret < 0)
+		return ret;
+
+	if (min_uV == 0) {
+		ret = regulator_get_voltage_rdev(rdev);
+		if (ret < 0)
+			return ret;
+		min_uV = ret;
+	}
+
+	ret = regulator_check_voltage(rdev, &min_uV, &max_uV);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * If we're asked to set a voltage less than VSRAM min_uV, set
+	 * the minimum allowed voltage on VSRAM, as in this case it is
+	 * safe to ignore the max_spread parameter.
+	 */
+	vsram_target_min_uV = max(vsram_min_uV, min_uV + max_spread);
+	vsram_target_max_uV = min(vsram_max_uV, vsram_target_min_uV + max_spread);
+
+	/* Make sure we're not out of range */
+	vsram_target_min_uV = min(vsram_target_min_uV, vsram_max_uV);
+
+	pr_debug("Setting voltage %d-%duV on %s (minuV %d)\n",
+		 vsram_target_min_uV, vsram_target_max_uV,
+		 rdev_get_name(mrc->vsram_rdev), min_uV);
+
+	ret = regulator_set_voltage_rdev(mrc->vsram_rdev, vsram_target_min_uV,
+					 vsram_target_max_uV, state);
+	if (ret)
+		return ret;
+
+	/* The sram voltage is now balanced: update the target vreg voltage */
+	return regulator_do_balance_voltage(rdev, state, true);
+}
+
+static int mediatek_regulator_attach(struct regulator_coupler *coupler,
+				     struct regulator_dev *rdev)
+{
+	struct mediatek_regulator_coupler *mrc = to_mediatek_coupler(coupler);
+	const char *rdev_name = rdev_get_name(rdev);
+
+	/*
+	 * If we're getting a coupling of more than two regulators here and
+	 * this means that this is surely not a GPU<->SRAM couple: in that
+	 * case, we may want to use another coupler implementation, if any,
+	 * or the generic one: the regulator core will keep walking through
+	 * the list of couplers when any .attach_regulator() cb returns 1.
+	 */
+	if (rdev->coupling_desc.n_coupled > 2)
+		return 1;
+
+	if (strstr(rdev_name, "sram")) {
+		if (mrc->vsram_rdev)
+			return -EINVAL;
+		mrc->vsram_rdev = rdev;
+	} else if (!strstr(rdev_name, "vgpu") && !strstr(rdev_name, "Vgpu")) {
+		return 1;
+	}
+
+	return 0;
+}
+
+static int mediatek_regulator_detach(struct regulator_coupler *coupler,
+				     struct regulator_dev *rdev)
+{
+	struct mediatek_regulator_coupler *mrc = to_mediatek_coupler(coupler);
+
+	if (rdev == mrc->vsram_rdev)
+		mrc->vsram_rdev = NULL;
+
+	return 0;
+}
+
+static struct mediatek_regulator_coupler mediatek_coupler = {
+	.coupler = {
+		.attach_regulator = mediatek_regulator_attach,
+		.detach_regulator = mediatek_regulator_detach,
+		.balance_voltage = mediatek_regulator_balance_voltage,
+	},
+};
+
+static int mediatek_regulator_coupler_init(void)
+{
+	if (!of_machine_is_compatible("mediatek,mt8183") &&
+	    !of_machine_is_compatible("mediatek,mt8186") &&
+	    !of_machine_is_compatible("mediatek,mt8192"))
+		return 0;
+
+	return regulator_coupler_register(&mediatek_coupler.coupler);
+}
+arch_initcall(mediatek_regulator_coupler_init);
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_DESCRIPTION("MediaTek Regulator Coupler driver");
+MODULE_LICENSE("GPL");
-- 
2.37.2

