Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0015EF00A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiI2IJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbiI2IJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:09:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE0B12AC8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:09:41 -0700 (PDT)
X-UUID: 98dd3cf936704ece9d71273c61474bb1-20220929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=u9zXCCknJ55Nl09sBGfff6V+56egCIYmjm8dO/R8tKM=;
        b=hbw77DEwf/YAE3MGxC3OSxK3uR5odwfhCmVkKUuAcjoqANtTkFzL0xnunUYw+/VOEbGvZX4zZ9fuq9rCuwHZB9eXpbWvf/2/WmOJEmCbD3q4zkQlWMGAjkacONaYX3Ioj//M7Xszv0xEqX5D4m/j9TKN857qk6VgA2HM6nrks+Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:45eb0d14-fead-4665-843a-efc4f4a59846,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.11,REQID:45eb0d14-fead-4665-843a-efc4f4a59846,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:39a5ff1,CLOUDID:2115a1e4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:220929160936PF0PL2LH,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: 98dd3cf936704ece9d71273c61474bb1-20220929
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 87333006; Thu, 29 Sep 2022 16:09:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 29 Sep 2022 16:09:35 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 29 Sep 2022 16:09:34 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/2] phy: mediatek: tphy: add debugfs files
Date:   Thu, 29 Sep 2022 16:09:26 +0800
Message-ID: <20220929080926.1272-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929080926.1272-1-chunfeng.yun@mediatek.com>
References: <20220929080926.1272-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These debugfs files are mainly used to make eye diagram test easier,
especially helpful to do HQA test for a new IC without efuse enabled.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: add CONFIG_PHY_MTK_TPHY_DEBUGFS suggested by AngeloGioacchino
---
 drivers/phy/mediatek/Kconfig        |   5 +
 drivers/phy/mediatek/phy-mtk-tphy.c | 403 +++++++++++++++++++++++++++-
 2 files changed, 407 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 3125ecb5d119..e9fdfe9f519f 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -27,6 +27,11 @@ config PHY_MTK_TPHY
 	  multi-ports is first version, otherwise is second version,
 	  so you can easily distinguish them by banks layout.
 
+config PHY_MTK_TPHY_DEBUGFS
+	bool "Add T-PHY Debugfs Files"
+	help
+	  Say Y here to add debugfs files mainly for T-PHY HQA test.
+
 config PHY_MTK_UFS
 	tristate "MediaTek UFS M-PHY driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index e906a82791bd..d9509e1314a4 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/phy/phy.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/mfd/syscon.h>
@@ -264,6 +265,8 @@
 
 #define TPHY_CLKS_CNT	2
 
+#define USER_BUF_LEN(count) min_t(size_t, 8, (count))
+
 enum mtk_phy_version {
 	MTK_PHY_V1 = 1,
 	MTK_PHY_V2,
@@ -310,6 +313,7 @@ struct mtk_phy_instance {
 	struct clk_bulk_data clks[TPHY_CLKS_CNT];
 	u32 index;
 	u32 type;
+	struct dentry *dbgfs;
 	struct regmap *type_sw;
 	u32 type_sw_reg;
 	u32 type_sw_index;
@@ -332,10 +336,389 @@ struct mtk_tphy {
 	const struct mtk_phy_pdata *pdata;
 	struct mtk_phy_instance **phys;
 	int nphys;
+	struct dentry *dbgfs_root;
 	int src_ref_clk; /* MHZ, reference clock for slew rate calibrate */
 	int src_coef; /* coefficient for slew rate calibrate */
 };
 
+#if IS_ENABLED(CONFIG_PHY_MTK_TPHY_DEBUGFS)
+
+enum u2_phy_params {
+	U2P_EYE_VRT = 0,
+	U2P_EYE_TERM,
+	U2P_EFUSE_EN,
+	U2P_EFUSE_INTR,
+	U2P_DISCTH,
+	U2P_PRE_EMPHASIS,
+};
+
+enum u3_phy_params {
+	U3P_EFUSE_EN = 0,
+	U3P_EFUSE_INTR,
+	U3P_EFUSE_TX_IMP,
+	U3P_EFUSE_RX_IMP,
+};
+
+static const char *const u2_phy_files[] = {
+	[U2P_EYE_VRT] = "vrt",
+	[U2P_EYE_TERM] = "term",
+	[U2P_EFUSE_EN] = "efuse",
+	[U2P_EFUSE_INTR] = "intr",
+	[U2P_DISCTH] = "discth",
+	[U2P_PRE_EMPHASIS] = "preemph",
+};
+
+static const char *const u3_phy_files[] = {
+	[U3P_EFUSE_EN] = "efuse",
+	[U3P_EFUSE_INTR] = "intr",
+	[U3P_EFUSE_TX_IMP] = "tx-imp",
+	[U3P_EFUSE_RX_IMP] = "rx-imp",
+};
+
+static int u2_phy_params_show(struct seq_file *sf, void *unused)
+{
+	struct mtk_phy_instance *inst = sf->private;
+	const char *fname = file_dentry(sf->file)->d_iname;
+	struct u2phy_banks *u2_banks = &inst->u2_banks;
+	void __iomem *com = u2_banks->com;
+	u32 max = 0;
+	u32 tmp = 0;
+	u32 val = 0;
+	int ret;
+
+	ret = match_string(u2_phy_files, ARRAY_SIZE(u2_phy_files), fname);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case U2P_EYE_VRT:
+		tmp = readl(com + U3P_USBPHYACR1);
+		val = FIELD_GET(PA1_RG_VRT_SEL, tmp);
+		max = FIELD_MAX(PA1_RG_VRT_SEL);
+		break;
+
+	case U2P_EYE_TERM:
+		tmp = readl(com + U3P_USBPHYACR1);
+		val = FIELD_GET(PA1_RG_TERM_SEL, tmp);
+		max = FIELD_MAX(PA1_RG_TERM_SEL);
+		break;
+
+	case U2P_EFUSE_EN:
+		if (u2_banks->misc) {
+			tmp = readl(u2_banks->misc + U3P_MISC_REG1);
+			max = 1;
+		}
+
+		val = !!(tmp & MR1_EFUSE_AUTO_LOAD_DIS);
+		break;
+
+	case U2P_EFUSE_INTR:
+		tmp = readl(com + U3P_USBPHYACR1);
+		val = FIELD_GET(PA1_RG_INTR_CAL, tmp);
+		max = FIELD_MAX(PA1_RG_INTR_CAL);
+		break;
+
+	case U2P_DISCTH:
+		tmp = readl(com + U3P_USBPHYACR6);
+		val = FIELD_GET(PA6_RG_U2_DISCTH, tmp);
+		max = FIELD_MAX(PA6_RG_U2_DISCTH);
+		break;
+
+	case U2P_PRE_EMPHASIS:
+		tmp = readl(com + U3P_USBPHYACR6);
+		val = FIELD_GET(PA6_RG_U2_PRE_EMP, tmp);
+		max = FIELD_MAX(PA6_RG_U2_PRE_EMP);
+		break;
+
+	default:
+		seq_printf(sf, "invalid, %d\n", ret);
+		break;
+	}
+
+	seq_printf(sf, "%s : %d [0, %d]\n", fname, val, max);
+
+	return 0;
+}
+
+static int u2_phy_params_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, u2_phy_params_show, inode->i_private);
+}
+
+static ssize_t u2_phy_params_write(struct file *file, const char __user *ubuf,
+				   size_t count, loff_t *ppos)
+{
+	const char *fname = file_dentry(file)->d_iname;
+	struct seq_file *sf = file->private_data;
+	struct mtk_phy_instance *inst = sf->private;
+	struct u2phy_banks *u2_banks = &inst->u2_banks;
+	void __iomem *com = u2_banks->com;
+	ssize_t rc;
+	u32 val;
+	int ret;
+
+	rc = kstrtouint_from_user(ubuf, USER_BUF_LEN(count), 0, &val);
+	if (rc)
+		return rc;
+
+	ret = match_string(u2_phy_files, ARRAY_SIZE(u2_phy_files), fname);
+	if (ret < 0)
+		return (ssize_t)ret;
+
+	switch (ret) {
+	case U2P_EYE_VRT:
+		mtk_phy_update_field(com + U3P_USBPHYACR1, PA1_RG_VRT_SEL, val);
+		break;
+
+	case U2P_EYE_TERM:
+		mtk_phy_update_field(com + U3P_USBPHYACR1, PA1_RG_TERM_SEL, val);
+		break;
+
+	case U2P_EFUSE_EN:
+		if (u2_banks->misc)
+			mtk_phy_update_field(u2_banks->misc + U3P_MISC_REG1,
+					     MR1_EFUSE_AUTO_LOAD_DIS, !!val);
+		break;
+
+	case U2P_EFUSE_INTR:
+		mtk_phy_update_field(com + U3P_USBPHYACR1, PA1_RG_INTR_CAL, val);
+		break;
+
+	case U2P_DISCTH:
+		mtk_phy_update_field(com + U3P_USBPHYACR6, PA6_RG_U2_DISCTH, val);
+		break;
+
+	case U2P_PRE_EMPHASIS:
+		mtk_phy_update_field(com + U3P_USBPHYACR6, PA6_RG_U2_PRE_EMP, val);
+		break;
+
+	default:
+		break;
+	}
+
+	return count;
+}
+
+static const struct file_operations u2_phy_fops = {
+	.open = u2_phy_params_open,
+	.write = u2_phy_params_write,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static void u2_phy_files_create(struct mtk_phy_instance *inst)
+{
+	u32 count = ARRAY_SIZE(u2_phy_files);
+	int i;
+
+	for (i = 0; i < count; i++)
+		debugfs_create_file(u2_phy_files[i], 0644, inst->dbgfs, inst, &u2_phy_fops);
+}
+
+static int u3_phy_params_show(struct seq_file *sf, void *unused)
+{
+	struct mtk_phy_instance *inst = sf->private;
+	const char *fname = file_dentry(sf->file)->d_iname;
+	struct u3phy_banks *u3_banks = &inst->u3_banks;
+	u32 val, tmp, max;
+	int ret;
+
+	ret = match_string(u3_phy_files, ARRAY_SIZE(u3_phy_files), fname);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case U3P_EFUSE_EN:
+		tmp = readl(u3_banks->phyd + U3P_U3_PHYD_RSV);
+		val = !!(tmp & P3D_RG_EFUSE_AUTO_LOAD_DIS);
+		max = 1;
+		break;
+
+	case U3P_EFUSE_INTR:
+		tmp = readl(u3_banks->phya + U3P_U3_PHYA_REG0);
+		val = FIELD_GET(P3A_RG_IEXT_INTR, tmp);
+		max = FIELD_MAX(P3A_RG_IEXT_INTR);
+		break;
+
+	case U3P_EFUSE_TX_IMP:
+		tmp = readl(u3_banks->phyd + U3P_U3_PHYD_IMPCAL0);
+		val = FIELD_GET(P3D_RG_TX_IMPEL, tmp);
+		max = FIELD_MAX(P3D_RG_TX_IMPEL);
+		break;
+
+	case U3P_EFUSE_RX_IMP:
+		tmp = readl(u3_banks->phyd + U3P_U3_PHYD_IMPCAL1);
+		val = FIELD_GET(P3D_RG_RX_IMPEL, tmp);
+		max = FIELD_MAX(P3D_RG_RX_IMPEL);
+		break;
+
+	default:
+		seq_printf(sf, "invalid, %d\n", ret);
+		break;
+	}
+
+	seq_printf(sf, "%s : %d [0, %d]\n", fname, val, max);
+
+	return 0;
+}
+
+static int u3_phy_params_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, u3_phy_params_show, inode->i_private);
+}
+
+static ssize_t u3_phy_params_write(struct file *file, const char __user *ubuf,
+				   size_t count, loff_t *ppos)
+{
+	const char *fname = file_dentry(file)->d_iname;
+	struct seq_file *sf = file->private_data;
+	struct mtk_phy_instance *inst = sf->private;
+	struct u3phy_banks *u3_banks = &inst->u3_banks;
+	void __iomem *phyd = u3_banks->phyd;
+	ssize_t rc;
+	u32 val;
+	int ret;
+
+	rc = kstrtouint_from_user(ubuf, USER_BUF_LEN(count), 0, &val);
+	if (rc)
+		return rc;
+
+	ret = match_string(u3_phy_files, ARRAY_SIZE(u3_phy_files), fname);
+	if (ret < 0)
+		return (ssize_t)ret;
+
+	switch (ret) {
+	case U3P_EFUSE_EN:
+		mtk_phy_update_field(phyd + U3P_U3_PHYD_RSV,
+				     P3D_RG_EFUSE_AUTO_LOAD_DIS, !!val);
+		break;
+
+	case U3P_EFUSE_INTR:
+		mtk_phy_update_field(u3_banks->phya + U3P_U3_PHYA_REG0, P3A_RG_IEXT_INTR, val);
+		break;
+
+	case U3P_EFUSE_TX_IMP:
+		mtk_phy_update_field(phyd + U3P_U3_PHYD_IMPCAL0, P3D_RG_TX_IMPEL, val);
+		mtk_phy_set_bits(phyd + U3P_U3_PHYD_IMPCAL0, P3D_RG_FORCE_TX_IMPEL);
+		break;
+
+	case U3P_EFUSE_RX_IMP:
+		mtk_phy_update_field(phyd + U3P_U3_PHYD_IMPCAL1, P3D_RG_RX_IMPEL, val);
+		mtk_phy_set_bits(phyd + U3P_U3_PHYD_IMPCAL1, P3D_RG_FORCE_RX_IMPEL);
+		break;
+
+	default:
+		break;
+	}
+
+	return count;
+}
+
+static const struct file_operations u3_phy_fops = {
+	.open = u3_phy_params_open,
+	.write = u3_phy_params_write,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static void u3_phy_files_create(struct mtk_phy_instance *inst)
+{
+	u32 count = ARRAY_SIZE(u3_phy_files);
+	int i;
+
+	for (i = 0; i < count; i++)
+		debugfs_create_file(u3_phy_files[i], 0644, inst->dbgfs, inst, &u3_phy_fops);
+}
+
+static int tphy_type_show(struct seq_file *sf, void *unused)
+{
+	struct mtk_phy_instance *inst = sf->private;
+	const char *type;
+
+	switch (inst->type) {
+	case PHY_TYPE_USB2:
+		type = "USB2";
+		break;
+	case PHY_TYPE_USB3:
+		type = "USB3";
+		break;
+	case PHY_TYPE_PCIE:
+		type = "PCIe";
+		break;
+	case PHY_TYPE_SGMII:
+		type = "SGMII";
+		break;
+	case PHY_TYPE_SATA:
+		type = "SATA";
+		break;
+	default:
+		type = "";
+	}
+
+	seq_printf(sf, "%s\n", type);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(tphy_type);
+
+static void tphy_debufs_init(struct mtk_tphy *tphy, struct mtk_phy_instance *inst)
+{
+	char name[16];
+
+	snprintf(name, sizeof(name) - 1, "phy.%d", inst->index);
+	inst->dbgfs = debugfs_create_dir(name, tphy->dbgfs_root);
+
+	debugfs_create_file("type", 0444, inst->dbgfs, inst, &tphy_type_fops);
+
+	switch (inst->type) {
+	case PHY_TYPE_USB2:
+		u2_phy_files_create(inst);
+		break;
+	case PHY_TYPE_USB3:
+	case PHY_TYPE_PCIE:
+		u3_phy_files_create(inst);
+		break;
+	default:
+		break;
+	}
+}
+
+static void tphy_debufs_exit(struct mtk_phy_instance *inst)
+{
+	debugfs_remove_recursive(inst->dbgfs);
+	inst->dbgfs = NULL;
+}
+
+static void tphy_debufs_root_create(struct mtk_tphy *tphy)
+{
+	tphy->dbgfs_root = debugfs_create_dir(dev_name(tphy->dev), phy_debug_root);
+}
+
+static void tphy_debufs_root_remove(struct mtk_tphy *tphy)
+{
+	debugfs_remove_recursive(tphy->dbgfs_root);
+	tphy->dbgfs_root = NULL;
+}
+
+#else
+
+static void tphy_debufs_init(struct mtk_tphy *tphy, struct mtk_phy_instance *inst)
+{}
+
+static void tphy_debufs_exit(struct mtk_phy_instance *inst)
+{}
+
+static void tphy_debufs_root_create(struct mtk_tphy *tphy)
+{}
+
+static void tphy_debufs_root_remove(struct mtk_tphy *tphy)
+{}
+
+#endif
+
 static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
 	struct mtk_phy_instance *instance)
 {
@@ -1032,6 +1415,8 @@ static int mtk_phy_init(struct phy *phy)
 		return -EINVAL;
 	}
 
+	tphy_debufs_init(tphy, instance);
+
 	return 0;
 }
 
@@ -1068,6 +1453,8 @@ static int mtk_phy_exit(struct phy *phy)
 	struct mtk_phy_instance *instance = phy_get_drvdata(phy);
 	struct mtk_tphy *tphy = dev_get_drvdata(phy->dev.parent);
 
+	tphy_debufs_exit(instance);
+
 	if (instance->type == PHY_TYPE_USB2)
 		u2_phy_instance_exit(tphy, instance);
 
@@ -1295,15 +1682,29 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 	}
 
 	provider = devm_of_phy_provider_register(dev, mtk_phy_xlate);
+	if (IS_ERR(provider))
+		return dev_err_probe(dev, PTR_ERR(provider), "probe failed\n");
+
+	tphy_debufs_root_create(tphy);
+	return 0;
 
-	return PTR_ERR_OR_ZERO(provider);
 put_child:
 	of_node_put(child_np);
 	return retval;
 }
 
+static int mtk_tphy_remove(struct platform_device *pdev)
+{
+	struct mtk_tphy *tphy;
+
+	tphy = platform_get_drvdata(pdev);
+	tphy_debufs_root_remove(tphy);
+	return 0;
+}
+
 static struct platform_driver mtk_tphy_driver = {
 	.probe		= mtk_tphy_probe,
+	.remove		= mtk_tphy_remove,
 	.driver		= {
 		.name	= "mtk-tphy",
 		.of_match_table = mtk_tphy_id_table,
-- 
2.18.0

