Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C334637E86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKXRrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXRrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:47:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EA413BB61
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:47:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA098620DD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 17:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE72C433D6;
        Thu, 24 Nov 2022 17:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669312031;
        bh=hKX9sfDB3C5uLmIf2/nm7Bw9f/byHa3RFSNq0s4zC0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHfaFgH/wBSJIZoqNGOluyFh2FeTNJNQhdTZguMYjoltM0PK0VKjQxhiFecgQvSFM
         k+5zWvVQ/AD5cZTD79NCP3de5iLp4hjaPDEdt1KE6evdWXhYsqY3SigSLJbW2fJtAm
         jHyjLyT33GEu/X8j8+p2dzu0dbguFj7YFrBz9ZlIgLEUMcOqCxPY8EKJM+CQQIL+fr
         BC6x901Wu5PkwlCbOtJ01XorSlXi/0wln2KYrEyPpQzoL/zeAF1Uk6VLp11MfMdfSp
         /dYqbZ+hNO+TNuZoOyTI7q80biJ9AdHzKb3i0WgNtCnSTR8jF+uczs7cwCo3niKMxn
         IiCixI6xoJ2mg==
Date:   Thu, 24 Nov 2022 23:17:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: Re: [PATCH v4 3/3] phy: mediatek: tphy: add debugfs files
Message-ID: <Y3+uGjpMQcEWQrew@matsya>
References: <20221110132716.12294-1-chunfeng.yun@mediatek.com>
 <20221110132716.12294-3-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110132716.12294-3-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-11-22, 21:27, Chunfeng Yun wrote:
> These debugfs files are mainly used to make eye diagram test easier,
> especially helpful to do HQA test for a new IC without efuse enabled.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v4: fix build warning of sometimes uninitialized variable
> 
> v3: fix typo of "debugfs" suggested by AngeloGioacchino
> 
> v2: add CONFIG_PHY_MTK_TPHY_DEBUGFS suggested by AngeloGioacchino
> ---
>  drivers/phy/mediatek/Kconfig        |   5 +
>  drivers/phy/mediatek/phy-mtk-tphy.c | 405 +++++++++++++++++++++++++++-
>  2 files changed, 409 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
> index 3125ecb5d119..e9fdfe9f519f 100644
> --- a/drivers/phy/mediatek/Kconfig
> +++ b/drivers/phy/mediatek/Kconfig
> @@ -27,6 +27,11 @@ config PHY_MTK_TPHY
>  	  multi-ports is first version, otherwise is second version,
>  	  so you can easily distinguish them by banks layout.
>  
> +config PHY_MTK_TPHY_DEBUGFS
> +	bool "Add T-PHY Debugfs Files"
> +	help
> +	  Say Y here to add debugfs files mainly for T-PHY HQA test.

Why do we need a config option for this, is debugfs config option not
sufficient?

> +
>  config PHY_MTK_UFS
>  	tristate "MediaTek UFS M-PHY driver"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
> index e906a82791bd..f220a9a409bf 100644
> --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> @@ -7,6 +7,7 @@
>  
>  #include <dt-bindings/phy/phy.h>
>  #include <linux/clk.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/iopoll.h>
>  #include <linux/mfd/syscon.h>
> @@ -264,6 +265,8 @@
>  
>  #define TPHY_CLKS_CNT	2
>  
> +#define USER_BUF_LEN(count) min_t(size_t, 8, (count))
> +
>  enum mtk_phy_version {
>  	MTK_PHY_V1 = 1,
>  	MTK_PHY_V2,
> @@ -310,6 +313,7 @@ struct mtk_phy_instance {
>  	struct clk_bulk_data clks[TPHY_CLKS_CNT];
>  	u32 index;
>  	u32 type;
> +	struct dentry *dbgfs;
>  	struct regmap *type_sw;
>  	u32 type_sw_reg;
>  	u32 type_sw_index;
> @@ -332,10 +336,391 @@ struct mtk_tphy {
>  	const struct mtk_phy_pdata *pdata;
>  	struct mtk_phy_instance **phys;
>  	int nphys;
> +	struct dentry *dbgfs_root;
>  	int src_ref_clk; /* MHZ, reference clock for slew rate calibrate */
>  	int src_coef; /* coefficient for slew rate calibrate */
>  };
>  
> +#if IS_ENABLED(CONFIG_PHY_MTK_TPHY_DEBUGFS)
> +
> +enum u2_phy_params {
> +	U2P_EYE_VRT = 0,
> +	U2P_EYE_TERM,
> +	U2P_EFUSE_EN,
> +	U2P_EFUSE_INTR,
> +	U2P_DISCTH,
> +	U2P_PRE_EMPHASIS,
> +};
> +
> +enum u3_phy_params {
> +	U3P_EFUSE_EN = 0,
> +	U3P_EFUSE_INTR,
> +	U3P_EFUSE_TX_IMP,
> +	U3P_EFUSE_RX_IMP,
> +};
> +
> +static const char *const u2_phy_files[] = {
> +	[U2P_EYE_VRT] = "vrt",
> +	[U2P_EYE_TERM] = "term",
> +	[U2P_EFUSE_EN] = "efuse",
> +	[U2P_EFUSE_INTR] = "intr",
> +	[U2P_DISCTH] = "discth",
> +	[U2P_PRE_EMPHASIS] = "preemph",
> +};
> +
> +static const char *const u3_phy_files[] = {
> +	[U3P_EFUSE_EN] = "efuse",
> +	[U3P_EFUSE_INTR] = "intr",
> +	[U3P_EFUSE_TX_IMP] = "tx-imp",
> +	[U3P_EFUSE_RX_IMP] = "rx-imp",
> +};
> +
> +static int u2_phy_params_show(struct seq_file *sf, void *unused)
> +{
> +	struct mtk_phy_instance *inst = sf->private;
> +	const char *fname = file_dentry(sf->file)->d_iname;
> +	struct u2phy_banks *u2_banks = &inst->u2_banks;
> +	void __iomem *com = u2_banks->com;
> +	u32 max = 0;
> +	u32 tmp = 0;
> +	u32 val = 0;
> +	int ret;
> +
> +	ret = match_string(u2_phy_files, ARRAY_SIZE(u2_phy_files), fname);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (ret) {
> +	case U2P_EYE_VRT:
> +		tmp = readl(com + U3P_USBPHYACR1);
> +		val = FIELD_GET(PA1_RG_VRT_SEL, tmp);
> +		max = FIELD_MAX(PA1_RG_VRT_SEL);
> +		break;
> +
> +	case U2P_EYE_TERM:
> +		tmp = readl(com + U3P_USBPHYACR1);
> +		val = FIELD_GET(PA1_RG_TERM_SEL, tmp);
> +		max = FIELD_MAX(PA1_RG_TERM_SEL);
> +		break;
> +
> +	case U2P_EFUSE_EN:
> +		if (u2_banks->misc) {
> +			tmp = readl(u2_banks->misc + U3P_MISC_REG1);
> +			max = 1;
> +		}
> +
> +		val = !!(tmp & MR1_EFUSE_AUTO_LOAD_DIS);
> +		break;
> +
> +	case U2P_EFUSE_INTR:
> +		tmp = readl(com + U3P_USBPHYACR1);
> +		val = FIELD_GET(PA1_RG_INTR_CAL, tmp);
> +		max = FIELD_MAX(PA1_RG_INTR_CAL);
> +		break;
> +
> +	case U2P_DISCTH:
> +		tmp = readl(com + U3P_USBPHYACR6);
> +		val = FIELD_GET(PA6_RG_U2_DISCTH, tmp);
> +		max = FIELD_MAX(PA6_RG_U2_DISCTH);
> +		break;
> +
> +	case U2P_PRE_EMPHASIS:
> +		tmp = readl(com + U3P_USBPHYACR6);
> +		val = FIELD_GET(PA6_RG_U2_PRE_EMP, tmp);
> +		max = FIELD_MAX(PA6_RG_U2_PRE_EMP);
> +		break;
> +
> +	default:
> +		seq_printf(sf, "invalid, %d\n", ret);
> +		break;
> +	}
> +
> +	seq_printf(sf, "%s : %d [0, %d]\n", fname, val, max);
> +
> +	return 0;
> +}
> +
> +static int u2_phy_params_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, u2_phy_params_show, inode->i_private);
> +}
> +
> +static ssize_t u2_phy_params_write(struct file *file, const char __user *ubuf,
> +				   size_t count, loff_t *ppos)

so are we writing to phy registers from userspace, why?

> +{
> +	const char *fname = file_dentry(file)->d_iname;
> +	struct seq_file *sf = file->private_data;
> +	struct mtk_phy_instance *inst = sf->private;
> +	struct u2phy_banks *u2_banks = &inst->u2_banks;
> +	void __iomem *com = u2_banks->com;
> +	ssize_t rc;
> +	u32 val;
> +	int ret;
> +
> +	rc = kstrtouint_from_user(ubuf, USER_BUF_LEN(count), 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	ret = match_string(u2_phy_files, ARRAY_SIZE(u2_phy_files), fname);
> +	if (ret < 0)
> +		return (ssize_t)ret;
> +
> +	switch (ret) {
> +	case U2P_EYE_VRT:
> +		mtk_phy_update_field(com + U3P_USBPHYACR1, PA1_RG_VRT_SEL, val);
> +		break;
> +
> +	case U2P_EYE_TERM:
> +		mtk_phy_update_field(com + U3P_USBPHYACR1, PA1_RG_TERM_SEL, val);
> +		break;
> +
> +	case U2P_EFUSE_EN:
> +		if (u2_banks->misc)
> +			mtk_phy_update_field(u2_banks->misc + U3P_MISC_REG1,
> +					     MR1_EFUSE_AUTO_LOAD_DIS, !!val);
> +		break;
> +
> +	case U2P_EFUSE_INTR:
> +		mtk_phy_update_field(com + U3P_USBPHYACR1, PA1_RG_INTR_CAL, val);
> +		break;
> +
> +	case U2P_DISCTH:
> +		mtk_phy_update_field(com + U3P_USBPHYACR6, PA6_RG_U2_DISCTH, val);
> +		break;
> +
> +	case U2P_PRE_EMPHASIS:
> +		mtk_phy_update_field(com + U3P_USBPHYACR6, PA6_RG_U2_PRE_EMP, val);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations u2_phy_fops = {
> +	.open = u2_phy_params_open,
> +	.write = u2_phy_params_write,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static void u2_phy_dbgfs_files_create(struct mtk_phy_instance *inst)
> +{
> +	u32 count = ARRAY_SIZE(u2_phy_files);
> +	int i;
> +
> +	for (i = 0; i < count; i++)
> +		debugfs_create_file(u2_phy_files[i], 0644, inst->dbgfs, inst, &u2_phy_fops);

pls use 
> +}
> +
> +static int u3_phy_params_show(struct seq_file *sf, void *unused)
> +{
> +	struct mtk_phy_instance *inst = sf->private;
> +	const char *fname = file_dentry(sf->file)->d_iname;
> +	struct u3phy_banks *u3_banks = &inst->u3_banks;
> +	u32 val = 0;
> +	u32 max = 0;
> +	u32 tmp;
> +	int ret;
> +
> +	ret = match_string(u3_phy_files, ARRAY_SIZE(u3_phy_files), fname);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (ret) {
> +	case U3P_EFUSE_EN:
> +		tmp = readl(u3_banks->phyd + U3P_U3_PHYD_RSV);
> +		val = !!(tmp & P3D_RG_EFUSE_AUTO_LOAD_DIS);
> +		max = 1;
> +		break;
> +
> +	case U3P_EFUSE_INTR:
> +		tmp = readl(u3_banks->phya + U3P_U3_PHYA_REG0);
> +		val = FIELD_GET(P3A_RG_IEXT_INTR, tmp);
> +		max = FIELD_MAX(P3A_RG_IEXT_INTR);
> +		break;
> +
> +	case U3P_EFUSE_TX_IMP:
> +		tmp = readl(u3_banks->phyd + U3P_U3_PHYD_IMPCAL0);
> +		val = FIELD_GET(P3D_RG_TX_IMPEL, tmp);
> +		max = FIELD_MAX(P3D_RG_TX_IMPEL);
> +		break;
> +
> +	case U3P_EFUSE_RX_IMP:
> +		tmp = readl(u3_banks->phyd + U3P_U3_PHYD_IMPCAL1);
> +		val = FIELD_GET(P3D_RG_RX_IMPEL, tmp);
> +		max = FIELD_MAX(P3D_RG_RX_IMPEL);
> +		break;
> +
> +	default:
> +		seq_printf(sf, "invalid, %d\n", ret);
> +		break;
> +	}
> +
> +	seq_printf(sf, "%s : %d [0, %d]\n", fname, val, max);
> +
> +	return 0;
> +}
> +
> +static int u3_phy_params_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, u3_phy_params_show, inode->i_private);
> +}
> +
> +static ssize_t u3_phy_params_write(struct file *file, const char __user *ubuf,
> +				   size_t count, loff_t *ppos)
> +{
> +	const char *fname = file_dentry(file)->d_iname;
> +	struct seq_file *sf = file->private_data;
> +	struct mtk_phy_instance *inst = sf->private;
> +	struct u3phy_banks *u3_banks = &inst->u3_banks;
> +	void __iomem *phyd = u3_banks->phyd;
> +	ssize_t rc;
> +	u32 val;
> +	int ret;
> +
> +	rc = kstrtouint_from_user(ubuf, USER_BUF_LEN(count), 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	ret = match_string(u3_phy_files, ARRAY_SIZE(u3_phy_files), fname);
> +	if (ret < 0)
> +		return (ssize_t)ret;
> +
> +	switch (ret) {
> +	case U3P_EFUSE_EN:
> +		mtk_phy_update_field(phyd + U3P_U3_PHYD_RSV,
> +				     P3D_RG_EFUSE_AUTO_LOAD_DIS, !!val);
> +		break;
> +
> +	case U3P_EFUSE_INTR:
> +		mtk_phy_update_field(u3_banks->phya + U3P_U3_PHYA_REG0, P3A_RG_IEXT_INTR, val);
> +		break;
> +
> +	case U3P_EFUSE_TX_IMP:
> +		mtk_phy_update_field(phyd + U3P_U3_PHYD_IMPCAL0, P3D_RG_TX_IMPEL, val);
> +		mtk_phy_set_bits(phyd + U3P_U3_PHYD_IMPCAL0, P3D_RG_FORCE_TX_IMPEL);
> +		break;
> +
> +	case U3P_EFUSE_RX_IMP:
> +		mtk_phy_update_field(phyd + U3P_U3_PHYD_IMPCAL1, P3D_RG_RX_IMPEL, val);
> +		mtk_phy_set_bits(phyd + U3P_U3_PHYD_IMPCAL1, P3D_RG_FORCE_RX_IMPEL);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations u3_phy_fops = {
> +	.open = u3_phy_params_open,
> +	.write = u3_phy_params_write,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static void u3_phy_dbgfs_files_create(struct mtk_phy_instance *inst)
> +{
> +	u32 count = ARRAY_SIZE(u3_phy_files);
> +	int i;
> +
> +	for (i = 0; i < count; i++)
> +		debugfs_create_file(u3_phy_files[i], 0644, inst->dbgfs, inst, &u3_phy_fops);
> +}
> +
> +static int tphy_type_show(struct seq_file *sf, void *unused)
> +{
> +	struct mtk_phy_instance *inst = sf->private;
> +	const char *type;
> +
> +	switch (inst->type) {
> +	case PHY_TYPE_USB2:
> +		type = "USB2";
> +		break;
> +	case PHY_TYPE_USB3:
> +		type = "USB3";
> +		break;
> +	case PHY_TYPE_PCIE:
> +		type = "PCIe";
> +		break;
> +	case PHY_TYPE_SGMII:
> +		type = "SGMII";
> +		break;
> +	case PHY_TYPE_SATA:
> +		type = "SATA";
> +		break;
> +	default:
> +		type = "";
> +	}
> +
> +	seq_printf(sf, "%s\n", type);
> +
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(tphy_type);
> +
> +static void tphy_debugfs_init(struct mtk_tphy *tphy, struct mtk_phy_instance *inst)
> +{
> +	char name[16];
> +
> +	snprintf(name, sizeof(name) - 1, "phy.%d", inst->index);
> +	inst->dbgfs = debugfs_create_dir(name, tphy->dbgfs_root);
> +
> +	debugfs_create_file("type", 0444, inst->dbgfs, inst, &tphy_type_fops);
> +
> +	switch (inst->type) {
> +	case PHY_TYPE_USB2:
> +		u2_phy_dbgfs_files_create(inst);
> +		break;
> +	case PHY_TYPE_USB3:
> +	case PHY_TYPE_PCIE:
> +		u3_phy_dbgfs_files_create(inst);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static void tphy_debugfs_exit(struct mtk_phy_instance *inst)
> +{
> +	debugfs_remove_recursive(inst->dbgfs);
> +	inst->dbgfs = NULL;
> +}
> +
> +static void tphy_debugfs_root_create(struct mtk_tphy *tphy)
> +{
> +	tphy->dbgfs_root = debugfs_create_dir(dev_name(tphy->dev), phy_debug_root);
> +}
> +
> +static void tphy_debugfs_root_remove(struct mtk_tphy *tphy)
> +{
> +	debugfs_remove_recursive(tphy->dbgfs_root);
> +	tphy->dbgfs_root = NULL;
> +}
> +
> +#else
> +
> +static void tphy_debugfs_init(struct mtk_tphy *tphy, struct mtk_phy_instance *inst)
> +{}
> +
> +static void tphy_debugfs_exit(struct mtk_phy_instance *inst)
> +{}
> +
> +static void tphy_debugfs_root_create(struct mtk_tphy *tphy)
> +{}
> +
> +static void tphy_debugfs_root_remove(struct mtk_tphy *tphy)
> +{}
> +
> +#endif
> +
>  static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
>  	struct mtk_phy_instance *instance)
>  {
> @@ -1032,6 +1417,8 @@ static int mtk_phy_init(struct phy *phy)
>  		return -EINVAL;
>  	}
>  
> +	tphy_debugfs_init(tphy, instance);
> +
>  	return 0;
>  }
>  
> @@ -1068,6 +1455,8 @@ static int mtk_phy_exit(struct phy *phy)
>  	struct mtk_phy_instance *instance = phy_get_drvdata(phy);
>  	struct mtk_tphy *tphy = dev_get_drvdata(phy->dev.parent);
>  
> +	tphy_debugfs_exit(instance);
> +
>  	if (instance->type == PHY_TYPE_USB2)
>  		u2_phy_instance_exit(tphy, instance);
>  
> @@ -1295,15 +1684,29 @@ static int mtk_tphy_probe(struct platform_device *pdev)
>  	}
>  
>  	provider = devm_of_phy_provider_register(dev, mtk_phy_xlate);
> +	if (IS_ERR(provider))
> +		return dev_err_probe(dev, PTR_ERR(provider), "probe failed\n");
> +
> +	tphy_debugfs_root_create(tphy);
> +	return 0;
>  
> -	return PTR_ERR_OR_ZERO(provider);
>  put_child:
>  	of_node_put(child_np);
>  	return retval;
>  }
>  
> +static int mtk_tphy_remove(struct platform_device *pdev)
> +{
> +	struct mtk_tphy *tphy;
> +
> +	tphy = platform_get_drvdata(pdev);
> +	tphy_debugfs_root_remove(tphy);
> +	return 0;
> +}
> +
>  static struct platform_driver mtk_tphy_driver = {
>  	.probe		= mtk_tphy_probe,
> +	.remove		= mtk_tphy_remove,
>  	.driver		= {
>  		.name	= "mtk-tphy",
>  		.of_match_table = mtk_tphy_id_table,
> -- 
> 2.18.0

-- 
~Vinod
