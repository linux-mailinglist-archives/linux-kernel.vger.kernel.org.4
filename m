Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2F85EE106
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiI1P4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiI1P4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:56:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5F8DCEA6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 18713CE1EE2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68E0C433C1;
        Wed, 28 Sep 2022 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380540;
        bh=+tGfcIhP3nFE6FsLjBv5CQN00EhkZzX5QDJfLFGFy3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jo2EwnHaeT8lqeU1zq5OU91LEpqZDgyIPL5j+587h7pVWHMer/apX8mRkMqgqDo/9
         7uFetMFR02fgLaSN5X3JRP3Ms9SO95WRJWO+WNCw4LagbHqfqXKdz/8MBYNuYPLz8y
         iuoWRsH0kx6ugUgvveqUzPbYQVtmIhC7DW/pmUKAY9JawQ+fU6udfy64UMVX8LJ3g9
         XLNnY5DyS0nZQfLznvf+GGgOGSzc7Yw+kL3yptE00JyTUrr+5z5PPpil8nQouOo6s2
         Kz9sPdYczbOGAErXY0VqkNZMnYvC58gRv0ILDIVuU53BWVZeXpHDWw5ie6ZuqUgtaK
         A8Nnm43dprwCw==
From:   matthias.bgg@kernel.org
To:     roger.lu@mediatek.com, jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 5/8] soc: mediatek: mtk-svs: Move SoC specific functions to new files
Date:   Wed, 28 Sep 2022 17:55:16 +0200
Message-Id: <20220928155519.31977-6-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220928155519.31977-1-matthias.bgg@kernel.org>
References: <20220928155519.31977-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

With every SoC added to the driver, it grows. Move SoC specific
callbacks to a new source files.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 drivers/soc/mediatek/Makefile         |   3 +-
 drivers/soc/mediatek/mt8183-svs.h     | 113 ++++
 drivers/soc/mediatek/mt8192-svs.h     |  64 ++
 drivers/soc/mediatek/mtk-svs-mt8183.c | 234 ++++++++
 drivers/soc/mediatek/mtk-svs-mt8192.c | 100 ++++
 drivers/soc/mediatek/mtk-svs.c        | 831 ++------------------------
 drivers/soc/mediatek/mtk-svs.h        | 279 +++++++++
 7 files changed, 837 insertions(+), 787 deletions(-)
 create mode 100644 drivers/soc/mediatek/mt8183-svs.h
 create mode 100644 drivers/soc/mediatek/mt8192-svs.h
 create mode 100644 drivers/soc/mediatek/mtk-svs-mt8183.c
 create mode 100644 drivers/soc/mediatek/mtk-svs-mt8192.c
 create mode 100644 drivers/soc/mediatek/mtk-svs.h

diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 0e9e703c931a..851131638644 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -7,4 +7,5 @@ obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
 obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
-obj-$(CONFIG_MTK_SVS) += mtk-svs.o
+mtk_svs-objs := mtk-svs.o mtk-svs-mt8183.o mtk-svs-mt8192.o
+obj-$(CONFIG_MTK_SVS) += mtk_svs.o
diff --git a/drivers/soc/mediatek/mt8183-svs.h b/drivers/soc/mediatek/mt8183-svs.h
new file mode 100644
index 000000000000..89c0deb9fb11
--- /dev/null
+++ b/drivers/soc/mediatek/mt8183-svs.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __DRV_SVS_MT8183_H
+#define __DRV_SVS_MT8183_H
+
+static struct svs_bank svs_mt8183_banks[] = {
+	{
+		.sw_id			= SVSB_CPU_LITTLE,
+		.set_freq_pct		= svs_set_bank_freq_pct_v2,
+		.get_volts		= svs_get_bank_volts_v2,
+		.cpu_id			= 0,
+		.buck_name		= "proc",
+		.volt_flags		= SVSB_INIT01_VOLT_INC_ONLY,
+		.mode_support		= SVSB_MODE_INIT01 | SVSB_MODE_INIT02,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 1989000000,
+		.vboot			= 0x30,
+		.volt_step		= 6250,
+		.volt_base		= 500000,
+		.vmax			= 0x64,
+		.vmin			= 0x18,
+		.age_config		= 0x555555,
+		.dc_config		= 0x555555,
+		.dvt_fixed		= 0x7,
+		.vco			= 0x10,
+		.chk_shift		= 0x77,
+		.core_sel		= 0x8fff0000,
+		.int_st			= BIT(0),
+		.ctl0			= 0x00010001,
+	},
+	{
+		.sw_id			= SVSB_CPU_BIG,
+		.set_freq_pct		= svs_set_bank_freq_pct_v2,
+		.get_volts		= svs_get_bank_volts_v2,
+		.cpu_id			= 4,
+		.buck_name		= "proc",
+		.volt_flags		= SVSB_INIT01_VOLT_INC_ONLY,
+		.mode_support		= SVSB_MODE_INIT01 | SVSB_MODE_INIT02,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 1989000000,
+		.vboot			= 0x30,
+		.volt_step		= 6250,
+		.volt_base		= 500000,
+		.vmax			= 0x58,
+		.vmin			= 0x10,
+		.age_config		= 0x555555,
+		.dc_config		= 0x555555,
+		.dvt_fixed		= 0x7,
+		.vco			= 0x10,
+		.chk_shift		= 0x77,
+		.core_sel		= 0x8fff0001,
+		.int_st			= BIT(1),
+		.ctl0			= 0x00000001,
+	},
+	{
+		.sw_id			= SVSB_CCI,
+		.set_freq_pct		= svs_set_bank_freq_pct_v2,
+		.get_volts		= svs_get_bank_volts_v2,
+		.buck_name		= "proc",
+		.volt_flags		= SVSB_INIT01_VOLT_INC_ONLY,
+		.mode_support		= SVSB_MODE_INIT01 | SVSB_MODE_INIT02,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 1196000000,
+		.vboot			= 0x30,
+		.volt_step		= 6250,
+		.volt_base		= 500000,
+		.vmax			= 0x64,
+		.vmin			= 0x18,
+		.age_config		= 0x555555,
+		.dc_config		= 0x555555,
+		.dvt_fixed		= 0x7,
+		.vco			= 0x10,
+		.chk_shift		= 0x77,
+		.core_sel		= 0x8fff0002,
+		.int_st			= BIT(2),
+		.ctl0			= 0x00100003,
+	},
+	{
+		.sw_id			= SVSB_GPU,
+		.set_freq_pct		= svs_set_bank_freq_pct_v2,
+		.get_volts		= svs_get_bank_volts_v2,
+		.buck_name		= "mali",
+		.tzone_name		= "tzts2",
+		.volt_flags		= SVSB_INIT01_PD_REQ |
+					  SVSB_INIT01_VOLT_INC_ONLY,
+		.mode_support		= SVSB_MODE_INIT01 | SVSB_MODE_INIT02 |
+					  SVSB_MODE_MON,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 900000000,
+		.vboot			= 0x30,
+		.volt_step		= 6250,
+		.volt_base		= 500000,
+		.vmax			= 0x40,
+		.vmin			= 0x14,
+		.age_config		= 0x555555,
+		.dc_config		= 0x555555,
+		.dvt_fixed		= 0x3,
+		.vco			= 0x10,
+		.chk_shift		= 0x77,
+		.core_sel		= 0x8fff0003,
+		.int_st			= BIT(3),
+		.ctl0			= 0x00050001,
+		.tzone_htemp		= 85000,
+		.tzone_htemp_voffset	= 0,
+		.tzone_ltemp		= 25000,
+		.tzone_ltemp_voffset	= 3,
+	},
+};
+
+bool svs_mt8183_efuse_parsing(struct svs_platform *svsp);
+int svs_mt8183_platform_probe(struct svs_platform *svsp);
+
+#endif
diff --git a/drivers/soc/mediatek/mt8192-svs.h b/drivers/soc/mediatek/mt8192-svs.h
new file mode 100644
index 000000000000..6571ebcb2c0f
--- /dev/null
+++ b/drivers/soc/mediatek/mt8192-svs.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __DRV_SVS_MT8192_H
+#define __DRV_SVS_MT8192_H
+
+static struct svs_bank svs_mt8192_banks[] = {
+	{
+		.sw_id			= SVSB_GPU,
+		.type			= SVSB_LOW,
+		.set_freq_pct		= svs_set_bank_freq_pct_v3,
+		.get_volts		= svs_get_bank_volts_v3,
+		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT,
+		.mode_support		= SVSB_MODE_INIT02,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 688000000,
+		.turn_freq_base		= 688000000,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.vmax			= 0x60,
+		.vmin			= 0x1a,
+		.age_config		= 0x555555,
+		.dc_config		= 0x1,
+		.dvt_fixed		= 0x1,
+		.vco			= 0x18,
+		.chk_shift		= 0x87,
+		.core_sel		= 0x0fff0100,
+		.int_st			= BIT(0),
+		.ctl0			= 0x00540003,
+	},
+	{
+		.sw_id			= SVSB_GPU,
+		.type			= SVSB_HIGH,
+		.set_freq_pct		= svs_set_bank_freq_pct_v3,
+		.get_volts		= svs_get_bank_volts_v3,
+		.tzone_name		= "gpu1",
+		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT |
+					  SVSB_MON_VOLT_IGNORE,
+		.mode_support		= SVSB_MODE_INIT02 | SVSB_MODE_MON,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 902000000,
+		.turn_freq_base		= 688000000,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.vmax			= 0x60,
+		.vmin			= 0x1a,
+		.age_config		= 0x555555,
+		.dc_config		= 0x1,
+		.dvt_fixed		= 0x6,
+		.vco			= 0x18,
+		.chk_shift		= 0x87,
+		.core_sel		= 0x0fff0101,
+		.int_st			= BIT(1),
+		.ctl0			= 0x00540003,
+		.tzone_htemp		= 85000,
+		.tzone_htemp_voffset	= 0,
+		.tzone_ltemp		= 25000,
+		.tzone_ltemp_voffset	= 7,
+	},
+};
+
+bool svs_mt8192_efuse_parsing(struct svs_platform *svsp);
+int svs_mt8192_platform_probe(struct svs_platform *svsp);
+
+#endif
diff --git a/drivers/soc/mediatek/mtk-svs-mt8183.c b/drivers/soc/mediatek/mtk-svs-mt8183.c
new file mode 100644
index 000000000000..a97fcae59dd7
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-svs-mt8183.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "mtk-svs.h"
+
+bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb;
+	int format[6], x_roomt[6], o_vtsmcu[5], o_vtsabb, tb_roomt = 0;
+	int adc_ge_t, adc_oe_t, ge, oe, gain, degc_cali, adc_cali_en_t;
+	int o_slope, o_slope_sign, ts_id;
+	u32 idx, i, ft_pgm, mts, temp0, temp1, temp2;
+	int ret;
+
+	for (i = 0; i < svsp->efuse_max; i++)
+		if (svsp->efuse[i])
+			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
+				 i, svsp->efuse[i]);
+
+	if (!svsp->efuse[2]) {
+		dev_notice(svsp->dev, "svs_efuse[2] = 0x0?\n");
+		return false;
+	}
+
+	/* Svs efuse parsing */
+	ft_pgm = (svsp->efuse[0] >> 4) & GENMASK(3, 0);
+
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (ft_pgm <= 1)
+			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
+
+		switch (svsb->sw_id) {
+		case SVSB_CPU_LITTLE:
+			svsb->bdes = svsp->efuse[16] & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[16] >> 8) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[16] >> 16) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[16] >> 24) & GENMASK(7, 0);
+			svsb->mtdes  = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
+
+			if (ft_pgm <= 3)
+				svsb->volt_od += 10;
+			else
+				svsb->volt_od += 2;
+			break;
+		case SVSB_CPU_BIG:
+			svsb->bdes = svsp->efuse[18] & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[18] >> 8) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[18] >> 16) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[18] >> 24) & GENMASK(7, 0);
+			svsb->mtdes  = svsp->efuse[17] & GENMASK(7, 0);
+
+			if (ft_pgm <= 3)
+				svsb->volt_od += 15;
+			else
+				svsb->volt_od += 12;
+			break;
+		case SVSB_CCI:
+			svsb->bdes = svsp->efuse[4] & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[4] >> 8) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
+			svsb->mtdes  = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
+
+			if (ft_pgm <= 3)
+				svsb->volt_od += 10;
+			else
+				svsb->volt_od += 2;
+			break;
+		case SVSB_GPU:
+			svsb->bdes = svsp->efuse[6] & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[6] >> 8) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[6] >> 16) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[6] >> 24) & GENMASK(7, 0);
+			svsb->mtdes  = svsp->efuse[5] & GENMASK(7, 0);
+
+			if (ft_pgm >= 2) {
+				svsb->freq_base = 800000000; /* 800MHz */
+				svsb->dvt_fixed = 2;
+			}
+			break;
+		default:
+			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
+			return false;
+		}
+	}
+
+	ret = svs_thermal_efuse_get_data(svsp);
+	if (ret)
+		return false;
+
+	/* Thermal efuse parsing */
+	adc_ge_t = (svsp->tefuse[1] >> 22) & GENMASK(9, 0);
+	adc_oe_t = (svsp->tefuse[1] >> 12) & GENMASK(9, 0);
+
+	o_vtsmcu[0] = (svsp->tefuse[0] >> 17) & GENMASK(8, 0);
+	o_vtsmcu[1] = (svsp->tefuse[0] >> 8) & GENMASK(8, 0);
+	o_vtsmcu[2] = svsp->tefuse[1] & GENMASK(8, 0);
+	o_vtsmcu[3] = (svsp->tefuse[2] >> 23) & GENMASK(8, 0);
+	o_vtsmcu[4] = (svsp->tefuse[2] >> 5) & GENMASK(8, 0);
+	o_vtsabb = (svsp->tefuse[2] >> 14) & GENMASK(8, 0);
+
+	degc_cali = (svsp->tefuse[0] >> 1) & GENMASK(5, 0);
+	adc_cali_en_t = svsp->tefuse[0] & BIT(0);
+	o_slope_sign = (svsp->tefuse[0] >> 7) & BIT(0);
+
+	ts_id = (svsp->tefuse[1] >> 9) & BIT(0);
+	o_slope = (svsp->tefuse[0] >> 26) & GENMASK(5, 0);
+
+	if (adc_cali_en_t == 1) {
+		if (!ts_id)
+			o_slope = 0;
+
+		if (adc_ge_t < 265 || adc_ge_t > 758 ||
+		    adc_oe_t < 265 || adc_oe_t > 758 ||
+		    o_vtsmcu[0] < -8 || o_vtsmcu[0] > 484 ||
+		    o_vtsmcu[1] < -8 || o_vtsmcu[1] > 484 ||
+		    o_vtsmcu[2] < -8 || o_vtsmcu[2] > 484 ||
+		    o_vtsmcu[3] < -8 || o_vtsmcu[3] > 484 ||
+		    o_vtsmcu[4] < -8 || o_vtsmcu[4] > 484 ||
+		    o_vtsabb < -8 || o_vtsabb > 484 ||
+		    degc_cali < 1 || degc_cali > 63) {
+			dev_err(svsp->dev, "bad thermal efuse, no mon mode\n");
+			goto remove_mt8183_svsb_mon_mode;
+		}
+	} else {
+		dev_err(svsp->dev, "no thermal efuse, no mon mode\n");
+		goto remove_mt8183_svsb_mon_mode;
+	}
+
+	ge = ((adc_ge_t - 512) * 10000) / 4096;
+	oe = (adc_oe_t - 512);
+	gain = (10000 + ge);
+
+	format[0] = (o_vtsmcu[0] + 3350 - oe);
+	format[1] = (o_vtsmcu[1] + 3350 - oe);
+	format[2] = (o_vtsmcu[2] + 3350 - oe);
+	format[3] = (o_vtsmcu[3] + 3350 - oe);
+	format[4] = (o_vtsmcu[4] + 3350 - oe);
+	format[5] = (o_vtsabb + 3350 - oe);
+
+	for (i = 0; i < 6; i++)
+		x_roomt[i] = (((format[i] * 10000) / 4096) * 10000) / gain;
+
+	temp0 = (10000 * 100000 / gain) * 15 / 18;
+
+	if (!o_slope_sign)
+		mts = (temp0 * 10) / (1534 + o_slope * 10);
+	else
+		mts = (temp0 * 10) / (1534 - o_slope * 10);
+
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+		svsb->mts = mts;
+
+		switch (svsb->sw_id) {
+		case SVSB_CPU_LITTLE:
+			tb_roomt = x_roomt[3];
+			break;
+		case SVSB_CPU_BIG:
+			tb_roomt = x_roomt[4];
+			break;
+		case SVSB_CCI:
+			tb_roomt = x_roomt[3];
+			break;
+		case SVSB_GPU:
+			tb_roomt = x_roomt[1];
+			break;
+		default:
+			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
+			goto remove_mt8183_svsb_mon_mode;
+		}
+
+		temp0 = (degc_cali * 10 / 2);
+		temp1 = ((10000 * 100000 / 4096 / gain) *
+			 oe + tb_roomt * 10) * 15 / 18;
+
+		if (!o_slope_sign)
+			temp2 = temp1 * 100 / (1534 + o_slope * 10);
+		else
+			temp2 = temp1 * 100 / (1534 - o_slope * 10);
+
+		svsb->bts = (temp0 + temp2 - 250) * 4 / 10;
+	}
+
+	return true;
+
+remove_mt8183_svsb_mon_mode:
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+		svsb->mode_support &= ~SVSB_MODE_MON;
+	}
+
+	return true;
+}
+
+int svs_mt8183_platform_probe(struct svs_platform *svsp)
+{
+	struct device *dev;
+	struct svs_bank *svsb;
+	u32 idx;
+
+	dev = svs_add_device_link(svsp, "thermal");
+	if (IS_ERR(dev))
+		return dev_err_probe(svsp->dev, PTR_ERR(dev),
+				     "failed to get thermal device\n");
+
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+
+		switch (svsb->sw_id) {
+		case SVSB_CPU_LITTLE:
+		case SVSB_CPU_BIG:
+			svsb->opp_dev = get_cpu_device(svsb->cpu_id);
+			break;
+		case SVSB_CCI:
+			svsb->opp_dev = svs_add_device_link(svsp, "cci");
+			break;
+		case SVSB_GPU:
+			svsb->opp_dev = svs_add_device_link(svsp, "gpu");
+			break;
+		default:
+			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
+			return -EINVAL;
+		}
+
+		if (IS_ERR(svsb->opp_dev))
+			return dev_err_probe(svsp->dev, PTR_ERR(svsb->opp_dev),
+					     "failed to get OPP device for bank %d\n",
+					     idx);
+	}
+
+	return 0;
+}
diff --git a/drivers/soc/mediatek/mtk-svs-mt8192.c b/drivers/soc/mediatek/mtk-svs-mt8192.c
new file mode 100644
index 000000000000..838a94834741
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-svs-mt8192.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "mtk-svs.h"
+
+bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb;
+	u32 idx, i, vmin, golden_temp;
+	int ret;
+
+	for (i = 0; i < svsp->efuse_max; i++)
+		if (svsp->efuse[i])
+			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
+				 i, svsp->efuse[i]);
+
+	if (!svsp->efuse[9]) {
+		dev_notice(svsp->dev, "svs_efuse[9] = 0x0?\n");
+		return false;
+	}
+
+	/* Svs efuse parsing */
+	vmin = (svsp->efuse[19] >> 4) & GENMASK(1, 0);
+
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (vmin == 0x1)
+			svsb->vmin = 0x1e;
+
+		if (svsb->type == SVSB_LOW) {
+			svsb->mtdes = svsp->efuse[10] & GENMASK(7, 0);
+			svsb->bdes = (svsp->efuse[10] >> 16) & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[10] >> 24) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[17]) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[17] >> 8) & GENMASK(7, 0);
+		} else if (svsb->type == SVSB_HIGH) {
+			svsb->mtdes = svsp->efuse[9] & GENMASK(7, 0);
+			svsb->bdes = (svsp->efuse[9] >> 16) & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[9] >> 24) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[17] >> 24) & GENMASK(7, 0);
+		}
+
+		svsb->vmax += svsb->dvt_fixed;
+	}
+
+	ret = svs_thermal_efuse_get_data(svsp);
+	if (ret)
+		return false;
+
+	for (i = 0; i < svsp->tefuse_max; i++)
+		if (svsp->tefuse[i] != 0)
+			break;
+
+	if (i == svsp->tefuse_max)
+		golden_temp = 50; /* All thermal efuse data are 0 */
+	else
+		golden_temp = (svsp->tefuse[0] >> 24) & GENMASK(7, 0);
+
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+		svsb->mts = 500;
+		svsb->bts = (((500 * golden_temp + 250460) / 1000) - 25) * 4;
+	}
+
+	return true;
+}
+
+int svs_mt8192_platform_probe(struct svs_platform *svsp)
+{
+	struct device *dev;
+	struct svs_bank *svsb;
+	u32 idx;
+
+	svsp->rst = devm_reset_control_get_optional(svsp->dev, "svs_rst");
+	if (IS_ERR(svsp->rst))
+		return dev_err_probe(svsp->dev, PTR_ERR(svsp->rst),
+				     "cannot get svs reset control\n");
+
+	dev = svs_add_device_link(svsp, "lvts");
+	if (IS_ERR(dev))
+		return dev_err_probe(svsp->dev, PTR_ERR(dev),
+				     "failed to get lvts device\n");
+
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (svsb->type == SVSB_HIGH)
+			svsb->opp_dev = svs_add_device_link(svsp, "mali");
+		else if (svsb->type == SVSB_LOW)
+			svsb->opp_dev = svs_get_subsys_device(svsp, "mali");
+
+		if (IS_ERR(svsb->opp_dev))
+			return dev_err_probe(svsp->dev, PTR_ERR(svsb->opp_dev),
+					     "failed to get OPP device for bank %d\n",
+					     idx);
+	}
+
+	return 0;
+}
diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 482cc8d7e7cf..714eb93160f5 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -9,7 +9,6 @@
 #include <linux/completion.h>
 #include <linux/cpuidle.h>
 #include <linux/debugfs.h>
-#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -19,40 +18,19 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
-#include <linux/reset.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/thermal.h>
 
-/* svs bank 1-line software id */
-#define SVSB_CPU_LITTLE			BIT(0)
-#define SVSB_CPU_BIG			BIT(1)
-#define SVSB_CCI			BIT(2)
-#define SVSB_GPU			BIT(3)
-
-/* svs bank 2-line type */
-#define SVSB_LOW			BIT(8)
-#define SVSB_HIGH			BIT(9)
-
-/* svs bank mode support */
-#define SVSB_MODE_ALL_DISABLE		0
-#define SVSB_MODE_INIT01		BIT(1)
-#define SVSB_MODE_INIT02		BIT(2)
-#define SVSB_MODE_MON			BIT(3)
-
-/* svs bank volt flags */
-#define SVSB_INIT01_PD_REQ		BIT(0)
-#define SVSB_INIT01_VOLT_IGNORE		BIT(1)
-#define SVSB_INIT01_VOLT_INC_ONLY	BIT(2)
-#define SVSB_MON_VOLT_IGNORE		BIT(16)
-#define SVSB_REMOVE_DVTFIXED_VOLT	BIT(24)
+#include "mtk-svs.h"
+#include "mt8183-svs.h"
+#include "mt8192-svs.h"
 
 /* svs bank register fields and common configuration */
 #define SVSB_PTPCONFIG_DETMAX		GENMASK(15, 0)
@@ -129,129 +107,12 @@
 
 /* svs bank related setting */
 #define BITS8				8
-#define MAX_OPP_ENTRIES			16
 #define REG_BYTES			4
 #define SVSB_DC_SIGNED_BIT		BIT(15)
 #define SVSB_DET_CLK_EN			BIT(31)
 #define SVSB_TEMP_LOWER_BOUND		0xb2
 #define SVSB_TEMP_UPPER_BOUND		0x64
 
-static DEFINE_SPINLOCK(svs_lock);
-
-#define debug_fops_ro(name)						\
-	static int svs_##name##_debug_open(struct inode *inode,		\
-					   struct file *filp)		\
-	{								\
-		return single_open(filp, svs_##name##_debug_show,	\
-				   inode->i_private);			\
-	}								\
-	static const struct file_operations svs_##name##_debug_fops = {	\
-		.owner = THIS_MODULE,					\
-		.open = svs_##name##_debug_open,			\
-		.read = seq_read,					\
-		.llseek = seq_lseek,					\
-		.release = single_release,				\
-	}
-
-#define debug_fops_rw(name)						\
-	static int svs_##name##_debug_open(struct inode *inode,		\
-					   struct file *filp)		\
-	{								\
-		return single_open(filp, svs_##name##_debug_show,	\
-				   inode->i_private);			\
-	}								\
-	static const struct file_operations svs_##name##_debug_fops = {	\
-		.owner = THIS_MODULE,					\
-		.open = svs_##name##_debug_open,			\
-		.read = seq_read,					\
-		.write = svs_##name##_debug_write,			\
-		.llseek = seq_lseek,					\
-		.release = single_release,				\
-	}
-
-#define svs_dentry_data(name)	{__stringify(name), &svs_##name##_debug_fops}
-
-/**
- * enum svsb_phase - svs bank phase enumeration
- * @SVSB_PHASE_ERROR: svs bank encounters unexpected condition
- * @SVSB_PHASE_INIT01: svs bank basic init for data calibration
- * @SVSB_PHASE_INIT02: svs bank can provide voltages to opp table
- * @SVSB_PHASE_MON: svs bank can provide voltages with thermal effect
- * @SVSB_PHASE_MAX: total number of svs bank phase (debug purpose)
- *
- * Each svs bank has its own independent phase and we enable each svs bank by
- * running their phase orderly. However, when svs bank encounters unexpected
- * condition, it will fire an irq (PHASE_ERROR) to inform svs software.
- *
- * svs bank general phase-enabled order:
- * SVSB_PHASE_INIT01 -> SVSB_PHASE_INIT02 -> SVSB_PHASE_MON
- */
-enum svsb_phase {
-	SVSB_PHASE_ERROR = 0,
-	SVSB_PHASE_INIT01,
-	SVSB_PHASE_INIT02,
-	SVSB_PHASE_MON,
-	SVSB_PHASE_MAX,
-};
-
-enum svs_reg_index {
-	DESCHAR = 0,
-	TEMPCHAR,
-	DETCHAR,
-	AGECHAR,
-	DCCONFIG,
-	AGECONFIG,
-	FREQPCT30,
-	FREQPCT74,
-	LIMITVALS,
-	VBOOT,
-	DETWINDOW,
-	CONFIG,
-	TSCALCS,
-	RUNCONFIG,
-	SVSEN,
-	INIT2VALS,
-	DCVALUES,
-	AGEVALUES,
-	VOP30,
-	VOP74,
-	TEMP,
-	INTSTS,
-	INTSTSRAW,
-	INTEN,
-	CHKINT,
-	CHKSHIFT,
-	STATUS,
-	VDESIGN30,
-	VDESIGN74,
-	DVT30,
-	DVT74,
-	AGECOUNT,
-	SMSTATE0,
-	SMSTATE1,
-	CTL0,
-	DESDETSEC,
-	TEMPAGESEC,
-	CTRLSPARE0,
-	CTRLSPARE1,
-	CTRLSPARE2,
-	CTRLSPARE3,
-	CORESEL,
-	THERMINTST,
-	INTST,
-	THSTAGE0ST,
-	THSTAGE1ST,
-	THSTAGE2ST,
-	THAHBST0,
-	THAHBST1,
-	SPARE0,
-	SPARE1,
-	SPARE2,
-	SPARE3,
-	THSLPEVEB,
-	SVS_REG_MAX,
-};
-
 static const u32 svs_regs_v2[] = {
 	[DESCHAR]		= 0xc00,
 	[TEMPCHAR]		= 0xc04,
@@ -309,35 +170,41 @@ static const u32 svs_regs_v2[] = {
 	[THSLPEVEB]		= 0xf30,
 };
 
-/**
- * struct svs_platform - svs platform control
- * @base: svs platform register base
- * @dev: svs platform device
- * @main_clk: main clock for svs bank
- * @pbank: svs bank pointer needing to be protected by spin_lock section
- * @banks: svs banks that svs platform supports
- * @rst: svs platform reset control
- * @efuse_max: total number of svs efuse
- * @tefuse_max: total number of thermal efuse
- * @regs: svs platform registers map
- * @bank_max: total number of svs banks
- * @efuse: svs efuse data received from NVMEM framework
- * @tefuse: thermal efuse data received from NVMEM framework
- */
-struct svs_platform {
-	void __iomem *base;
-	struct device *dev;
-	struct clk *main_clk;
-	struct svs_bank *pbank;
-	struct svs_bank *banks;
-	struct reset_control *rst;
-	size_t efuse_max;
-	size_t tefuse_max;
-	const u32 *regs;
-	u32 bank_max;
-	u32 *efuse;
-	u32 *tefuse;
-};
+static DEFINE_SPINLOCK(svs_lock);
+
+#define debug_fops_ro(name)						\
+	static int svs_##name##_debug_open(struct inode *inode,		\
+					   struct file *filp)		\
+	{								\
+		return single_open(filp, svs_##name##_debug_show,	\
+				   inode->i_private);			\
+	}								\
+	static const struct file_operations svs_##name##_debug_fops = {	\
+		.owner = THIS_MODULE,					\
+		.open = svs_##name##_debug_open,			\
+		.read = seq_read,					\
+		.llseek = seq_lseek,					\
+		.release = single_release,				\
+	}
+
+#define debug_fops_rw(name)						\
+	static int svs_##name##_debug_open(struct inode *inode,		\
+					   struct file *filp)		\
+	{								\
+		return single_open(filp, svs_##name##_debug_show,	\
+				   inode->i_private);			\
+	}								\
+	static const struct file_operations svs_##name##_debug_fops = {	\
+		.owner = THIS_MODULE,					\
+		.open = svs_##name##_debug_open,			\
+		.read = seq_read,					\
+		.write = svs_##name##_debug_write,			\
+		.llseek = seq_lseek,					\
+		.release = single_release,				\
+	}
+
+#define svs_dentry_data(name)	{__stringify(name), &svs_##name##_debug_fops}
+
 
 struct svs_platform_data {
 	char *name;
@@ -348,127 +215,6 @@ struct svs_platform_data {
 	u32 bank_max;
 };
 
-/**
- * struct svs_bank - svs bank representation
- * @dev: bank device
- * @opp_dev: device for opp table/buck control
- * @init_completion: the timeout completion for bank init
- * @buck: regulator used by opp_dev
- * @tzd: thermal zone device for getting temperature
- * @lock: mutex lock to protect voltage update process
- * @set_freq_pct: function pointer to set bank frequency percent table
- * @get_volts: function pointer to get bank voltages
- * @name: bank name
- * @buck_name: regulator name
- * @tzone_name: thermal zone name
- * @phase: bank current phase
- * @volt_od: bank voltage overdrive
- * @reg_data: bank register data in different phase for debug purpose
- * @pm_runtime_enabled_count: bank pm runtime enabled count
- * @mode_support: bank mode support.
- * @freq_base: reference frequency for bank init
- * @turn_freq_base: refenrece frequency for 2-line turn point
- * @vboot: voltage request for bank init01 only
- * @opp_dfreq: default opp frequency table
- * @opp_dvolt: default opp voltage table
- * @freq_pct: frequency percent table for bank init
- * @volt: bank voltage table
- * @volt_step: bank voltage step
- * @volt_base: bank voltage base
- * @volt_flags: bank voltage flags
- * @vmax: bank voltage maximum
- * @vmin: bank voltage minimum
- * @age_config: bank age configuration
- * @age_voffset_in: bank age voltage offset
- * @dc_config: bank dc configuration
- * @dc_voffset_in: bank dc voltage offset
- * @dvt_fixed: bank dvt fixed value
- * @vco: bank VCO value
- * @chk_shift: bank chicken shift
- * @core_sel: bank selection
- * @opp_count: bank opp count
- * @int_st: bank interrupt identification
- * @sw_id: bank software identification
- * @cpu_id: cpu core id for SVS CPU bank use only
- * @ctl0: TS-x selection
- * @temp: bank temperature
- * @tzone_htemp: thermal zone high temperature threshold
- * @tzone_htemp_voffset: thermal zone high temperature voltage offset
- * @tzone_ltemp: thermal zone low temperature threshold
- * @tzone_ltemp_voffset: thermal zone low temperature voltage offset
- * @bts: svs efuse data
- * @mts: svs efuse data
- * @bdes: svs efuse data
- * @mdes: svs efuse data
- * @mtdes: svs efuse data
- * @dcbdet: svs efuse data
- * @dcmdet: svs efuse data
- * @turn_pt: 2-line turn point tells which opp_volt calculated by high/low bank
- * @type: bank type to represent it is 2-line (high/low) bank or 1-line bank
- *
- * Svs bank will generate suitalbe voltages by below general math equation
- * and provide these voltages to opp voltage table.
- *
- * opp_volt[i] = (volt[i] * volt_step) + volt_base;
- */
-struct svs_bank {
-	struct device *dev;
-	struct device *opp_dev;
-	struct completion init_completion;
-	struct regulator *buck;
-	struct thermal_zone_device *tzd;
-	struct mutex lock;	/* lock to protect voltage update process */
-	void (*set_freq_pct)(struct svs_platform *svsp);
-	void (*get_volts)(struct svs_platform *svsp);
-	char *name;
-	char *buck_name;
-	char *tzone_name;
-	enum svsb_phase phase;
-	s32 volt_od;
-	u32 reg_data[SVSB_PHASE_MAX][SVS_REG_MAX];
-	u32 pm_runtime_enabled_count;
-	u32 mode_support;
-	u32 freq_base;
-	u32 turn_freq_base;
-	u32 vboot;
-	u32 opp_dfreq[MAX_OPP_ENTRIES];
-	u32 opp_dvolt[MAX_OPP_ENTRIES];
-	u32 freq_pct[MAX_OPP_ENTRIES];
-	u32 volt[MAX_OPP_ENTRIES];
-	u32 volt_step;
-	u32 volt_base;
-	u32 volt_flags;
-	u32 vmax;
-	u32 vmin;
-	u32 age_config;
-	u32 age_voffset_in;
-	u32 dc_config;
-	u32 dc_voffset_in;
-	u32 dvt_fixed;
-	u32 vco;
-	u32 chk_shift;
-	u32 core_sel;
-	u32 opp_count;
-	u32 int_st;
-	u32 sw_id;
-	u32 cpu_id;
-	u32 ctl0;
-	u32 temp;
-	u32 tzone_htemp;
-	u32 tzone_htemp_voffset;
-	u32 tzone_ltemp;
-	u32 tzone_ltemp_voffset;
-	u32 bts;
-	u32 mts;
-	u32 bdes;
-	u32 mdes;
-	u32 mtdes;
-	u32 dcbdet;
-	u32 dcmdet;
-	u32 turn_pt;
-	u32 type;
-};
-
 static u32 percent(u32 numerator, u32 denominator)
 {
 	/* If not divide 1000, "numerator * 100" will have data overflow. */
@@ -851,7 +597,7 @@ static u32 interpolate(u32 f0, u32 f1, u32 v0, u32 v1, u32 fx)
 	return DIV_ROUND_UP(vx, 100);
 }
 
-static void svs_get_bank_volts_v3(struct svs_platform *svsp)
+void svs_get_bank_volts_v3(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb = svsp->pbank;
 	u32 i, j, *vop, vop74, vop30, turn_pt = svsb->turn_pt;
@@ -943,7 +689,7 @@ static void svs_get_bank_volts_v3(struct svs_platform *svsp)
 			svsb->volt[i] -= svsb->dvt_fixed;
 }
 
-static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
+void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb = svsp->pbank;
 	u32 i, j, *freq_pct, freq_pct74 = 0, freq_pct30 = 0;
@@ -1026,7 +772,7 @@ static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
 	svs_writel_relaxed(svsp, freq_pct30, FREQPCT30);
 }
 
-static void svs_get_bank_volts_v2(struct svs_platform *svsp)
+void svs_get_bank_volts_v2(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb = svsp->pbank;
 	u32 temp, i;
@@ -1060,7 +806,7 @@ static void svs_get_bank_volts_v2(struct svs_platform *svsp)
 		svsb->volt[i] += svsb->volt_od;
 }
 
-static void svs_set_bank_freq_pct_v2(struct svs_platform *svsp)
+void svs_set_bank_freq_pct_v2(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb = svsp->pbank;
 	u32 freqpct74_val, freqpct30_val;
@@ -1701,7 +1447,7 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
 	return 0;
 }
 
-static int svs_thermal_efuse_get_data(struct svs_platform *svsp)
+int svs_thermal_efuse_get_data(struct svs_platform *svsp)
 {
 	struct nvmem_cell *cell;
 
@@ -1726,262 +1472,6 @@ static int svs_thermal_efuse_get_data(struct svs_platform *svsp)
 	return 0;
 }
 
-static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
-{
-	struct svs_bank *svsb;
-	u32 idx, i, vmin, golden_temp;
-	int ret;
-
-	for (i = 0; i < svsp->efuse_max; i++)
-		if (svsp->efuse[i])
-			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
-				 i, svsp->efuse[i]);
-
-	if (!svsp->efuse[9]) {
-		dev_notice(svsp->dev, "svs_efuse[9] = 0x0?\n");
-		return false;
-	}
-
-	/* Svs efuse parsing */
-	vmin = (svsp->efuse[19] >> 4) & GENMASK(1, 0);
-
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-
-		if (vmin == 0x1)
-			svsb->vmin = 0x1e;
-
-		if (svsb->type == SVSB_LOW) {
-			svsb->mtdes = svsp->efuse[10] & GENMASK(7, 0);
-			svsb->bdes = (svsp->efuse[10] >> 16) & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[10] >> 24) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[17]) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[17] >> 8) & GENMASK(7, 0);
-		} else if (svsb->type == SVSB_HIGH) {
-			svsb->mtdes = svsp->efuse[9] & GENMASK(7, 0);
-			svsb->bdes = (svsp->efuse[9] >> 16) & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[9] >> 24) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[17] >> 24) & GENMASK(7, 0);
-		}
-
-		svsb->vmax += svsb->dvt_fixed;
-	}
-
-	ret = svs_thermal_efuse_get_data(svsp);
-	if (ret)
-		return false;
-
-	for (i = 0; i < svsp->tefuse_max; i++)
-		if (svsp->tefuse[i] != 0)
-			break;
-
-	if (i == svsp->tefuse_max)
-		golden_temp = 50; /* All thermal efuse data are 0 */
-	else
-		golden_temp = (svsp->tefuse[0] >> 24) & GENMASK(7, 0);
-
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-		svsb->mts = 500;
-		svsb->bts = (((500 * golden_temp + 250460) / 1000) - 25) * 4;
-	}
-
-	return true;
-}
-
-static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
-{
-	struct svs_bank *svsb;
-	int format[6], x_roomt[6], o_vtsmcu[5], o_vtsabb, tb_roomt = 0;
-	int adc_ge_t, adc_oe_t, ge, oe, gain, degc_cali, adc_cali_en_t;
-	int o_slope, o_slope_sign, ts_id;
-	u32 idx, i, ft_pgm, mts, temp0, temp1, temp2;
-	int ret;
-
-	for (i = 0; i < svsp->efuse_max; i++)
-		if (svsp->efuse[i])
-			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
-				 i, svsp->efuse[i]);
-
-	if (!svsp->efuse[2]) {
-		dev_notice(svsp->dev, "svs_efuse[2] = 0x0?\n");
-		return false;
-	}
-
-	/* Svs efuse parsing */
-	ft_pgm = (svsp->efuse[0] >> 4) & GENMASK(3, 0);
-
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-
-		if (ft_pgm <= 1)
-			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
-
-		switch (svsb->sw_id) {
-		case SVSB_CPU_LITTLE:
-			svsb->bdes = svsp->efuse[16] & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[16] >> 8) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[16] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[16] >> 24) & GENMASK(7, 0);
-			svsb->mtdes  = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
-
-			if (ft_pgm <= 3)
-				svsb->volt_od += 10;
-			else
-				svsb->volt_od += 2;
-			break;
-		case SVSB_CPU_BIG:
-			svsb->bdes = svsp->efuse[18] & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[18] >> 8) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[18] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[18] >> 24) & GENMASK(7, 0);
-			svsb->mtdes  = svsp->efuse[17] & GENMASK(7, 0);
-
-			if (ft_pgm <= 3)
-				svsb->volt_od += 15;
-			else
-				svsb->volt_od += 12;
-			break;
-		case SVSB_CCI:
-			svsb->bdes = svsp->efuse[4] & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[4] >> 8) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
-			svsb->mtdes  = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
-
-			if (ft_pgm <= 3)
-				svsb->volt_od += 10;
-			else
-				svsb->volt_od += 2;
-			break;
-		case SVSB_GPU:
-			svsb->bdes = svsp->efuse[6] & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[6] >> 8) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[6] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[6] >> 24) & GENMASK(7, 0);
-			svsb->mtdes  = svsp->efuse[5] & GENMASK(7, 0);
-
-			if (ft_pgm >= 2) {
-				svsb->freq_base = 800000000; /* 800MHz */
-				svsb->dvt_fixed = 2;
-			}
-			break;
-		default:
-			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
-			return false;
-		}
-	}
-
-	ret = svs_thermal_efuse_get_data(svsp);
-	if (ret)
-		return false;
-
-	/* Thermal efuse parsing */
-	adc_ge_t = (svsp->tefuse[1] >> 22) & GENMASK(9, 0);
-	adc_oe_t = (svsp->tefuse[1] >> 12) & GENMASK(9, 0);
-
-	o_vtsmcu[0] = (svsp->tefuse[0] >> 17) & GENMASK(8, 0);
-	o_vtsmcu[1] = (svsp->tefuse[0] >> 8) & GENMASK(8, 0);
-	o_vtsmcu[2] = svsp->tefuse[1] & GENMASK(8, 0);
-	o_vtsmcu[3] = (svsp->tefuse[2] >> 23) & GENMASK(8, 0);
-	o_vtsmcu[4] = (svsp->tefuse[2] >> 5) & GENMASK(8, 0);
-	o_vtsabb = (svsp->tefuse[2] >> 14) & GENMASK(8, 0);
-
-	degc_cali = (svsp->tefuse[0] >> 1) & GENMASK(5, 0);
-	adc_cali_en_t = svsp->tefuse[0] & BIT(0);
-	o_slope_sign = (svsp->tefuse[0] >> 7) & BIT(0);
-
-	ts_id = (svsp->tefuse[1] >> 9) & BIT(0);
-	o_slope = (svsp->tefuse[0] >> 26) & GENMASK(5, 0);
-
-	if (adc_cali_en_t == 1) {
-		if (!ts_id)
-			o_slope = 0;
-
-		if (adc_ge_t < 265 || adc_ge_t > 758 ||
-		    adc_oe_t < 265 || adc_oe_t > 758 ||
-		    o_vtsmcu[0] < -8 || o_vtsmcu[0] > 484 ||
-		    o_vtsmcu[1] < -8 || o_vtsmcu[1] > 484 ||
-		    o_vtsmcu[2] < -8 || o_vtsmcu[2] > 484 ||
-		    o_vtsmcu[3] < -8 || o_vtsmcu[3] > 484 ||
-		    o_vtsmcu[4] < -8 || o_vtsmcu[4] > 484 ||
-		    o_vtsabb < -8 || o_vtsabb > 484 ||
-		    degc_cali < 1 || degc_cali > 63) {
-			dev_err(svsp->dev, "bad thermal efuse, no mon mode\n");
-			goto remove_mt8183_svsb_mon_mode;
-		}
-	} else {
-		dev_err(svsp->dev, "no thermal efuse, no mon mode\n");
-		goto remove_mt8183_svsb_mon_mode;
-	}
-
-	ge = ((adc_ge_t - 512) * 10000) / 4096;
-	oe = (adc_oe_t - 512);
-	gain = (10000 + ge);
-
-	format[0] = (o_vtsmcu[0] + 3350 - oe);
-	format[1] = (o_vtsmcu[1] + 3350 - oe);
-	format[2] = (o_vtsmcu[2] + 3350 - oe);
-	format[3] = (o_vtsmcu[3] + 3350 - oe);
-	format[4] = (o_vtsmcu[4] + 3350 - oe);
-	format[5] = (o_vtsabb + 3350 - oe);
-
-	for (i = 0; i < 6; i++)
-		x_roomt[i] = (((format[i] * 10000) / 4096) * 10000) / gain;
-
-	temp0 = (10000 * 100000 / gain) * 15 / 18;
-
-	if (!o_slope_sign)
-		mts = (temp0 * 10) / (1534 + o_slope * 10);
-	else
-		mts = (temp0 * 10) / (1534 - o_slope * 10);
-
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-		svsb->mts = mts;
-
-		switch (svsb->sw_id) {
-		case SVSB_CPU_LITTLE:
-			tb_roomt = x_roomt[3];
-			break;
-		case SVSB_CPU_BIG:
-			tb_roomt = x_roomt[4];
-			break;
-		case SVSB_CCI:
-			tb_roomt = x_roomt[3];
-			break;
-		case SVSB_GPU:
-			tb_roomt = x_roomt[1];
-			break;
-		default:
-			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
-			goto remove_mt8183_svsb_mon_mode;
-		}
-
-		temp0 = (degc_cali * 10 / 2);
-		temp1 = ((10000 * 100000 / 4096 / gain) *
-			 oe + tb_roomt * 10) * 15 / 18;
-
-		if (!o_slope_sign)
-			temp2 = temp1 * 100 / (1534 + o_slope * 10);
-		else
-			temp2 = temp1 * 100 / (1534 - o_slope * 10);
-
-		svsb->bts = (temp0 + temp2 - 250) * 4 / 10;
-	}
-
-	return true;
-
-remove_mt8183_svsb_mon_mode:
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-		svsb->mode_support &= ~SVSB_MODE_MON;
-	}
-
-	return true;
-}
-
 static bool svs_is_efuse_data_correct(struct svs_platform *svsp)
 {
 	struct nvmem_cell *cell;
@@ -2008,7 +1498,7 @@ static bool svs_is_efuse_data_correct(struct svs_platform *svsp)
 	return true;
 }
 
-static struct device *svs_get_subsys_device(struct svs_platform *svsp,
+struct device *svs_get_subsys_device(struct svs_platform *svsp,
 					    const char *node_name)
 {
 	struct platform_device *pdev;
@@ -2032,7 +1522,7 @@ static struct device *svs_get_subsys_device(struct svs_platform *svsp,
 	return &pdev->dev;
 }
 
-static struct device *svs_add_device_link(struct svs_platform *svsp,
+struct device *svs_add_device_link(struct svs_platform *svsp,
 					  const char *node_name)
 {
 	struct device *dev;
@@ -2060,237 +1550,6 @@ static struct device *svs_add_device_link(struct svs_platform *svsp,
 	return dev;
 }
 
-static int svs_mt8192_platform_probe(struct svs_platform *svsp)
-{
-	struct device *dev;
-	struct svs_bank *svsb;
-	u32 idx;
-
-	svsp->rst = devm_reset_control_get_optional(svsp->dev, "svs_rst");
-	if (IS_ERR(svsp->rst))
-		return dev_err_probe(svsp->dev, PTR_ERR(svsp->rst),
-				     "cannot get svs reset control\n");
-
-	dev = svs_add_device_link(svsp, "lvts");
-	if (IS_ERR(dev))
-		return dev_err_probe(svsp->dev, PTR_ERR(dev),
-				     "failed to get lvts device\n");
-
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-
-		if (svsb->type == SVSB_HIGH)
-			svsb->opp_dev = svs_add_device_link(svsp, "mali");
-		else if (svsb->type == SVSB_LOW)
-			svsb->opp_dev = svs_get_subsys_device(svsp, "mali");
-
-		if (IS_ERR(svsb->opp_dev))
-			return dev_err_probe(svsp->dev, PTR_ERR(svsb->opp_dev),
-					     "failed to get OPP device for bank %d\n",
-					     idx);
-	}
-
-	return 0;
-}
-
-static int svs_mt8183_platform_probe(struct svs_platform *svsp)
-{
-	struct device *dev;
-	struct svs_bank *svsb;
-	u32 idx;
-
-	dev = svs_add_device_link(svsp, "thermal");
-	if (IS_ERR(dev))
-		return dev_err_probe(svsp->dev, PTR_ERR(dev),
-				     "failed to get thermal device\n");
-
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-
-		switch (svsb->sw_id) {
-		case SVSB_CPU_LITTLE:
-		case SVSB_CPU_BIG:
-			svsb->opp_dev = get_cpu_device(svsb->cpu_id);
-			break;
-		case SVSB_CCI:
-			svsb->opp_dev = svs_add_device_link(svsp, "cci");
-			break;
-		case SVSB_GPU:
-			svsb->opp_dev = svs_add_device_link(svsp, "gpu");
-			break;
-		default:
-			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
-			return -EINVAL;
-		}
-
-		if (IS_ERR(svsb->opp_dev))
-			return dev_err_probe(svsp->dev, PTR_ERR(svsb->opp_dev),
-					     "failed to get OPP device for bank %d\n",
-					     idx);
-	}
-
-	return 0;
-}
-
-static struct svs_bank svs_mt8192_banks[] = {
-	{
-		.sw_id			= SVSB_GPU,
-		.type			= SVSB_LOW,
-		.set_freq_pct		= svs_set_bank_freq_pct_v3,
-		.get_volts		= svs_get_bank_volts_v3,
-		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT,
-		.mode_support		= SVSB_MODE_INIT02,
-		.opp_count		= MAX_OPP_ENTRIES,
-		.freq_base		= 688000000,
-		.turn_freq_base		= 688000000,
-		.volt_step		= 6250,
-		.volt_base		= 400000,
-		.vmax			= 0x60,
-		.vmin			= 0x1a,
-		.age_config		= 0x555555,
-		.dc_config		= 0x1,
-		.dvt_fixed		= 0x1,
-		.vco			= 0x18,
-		.chk_shift		= 0x87,
-		.core_sel		= 0x0fff0100,
-		.int_st			= BIT(0),
-		.ctl0			= 0x00540003,
-	},
-	{
-		.sw_id			= SVSB_GPU,
-		.type			= SVSB_HIGH,
-		.set_freq_pct		= svs_set_bank_freq_pct_v3,
-		.get_volts		= svs_get_bank_volts_v3,
-		.tzone_name		= "gpu1",
-		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT |
-					  SVSB_MON_VOLT_IGNORE,
-		.mode_support		= SVSB_MODE_INIT02 | SVSB_MODE_MON,
-		.opp_count		= MAX_OPP_ENTRIES,
-		.freq_base		= 902000000,
-		.turn_freq_base		= 688000000,
-		.volt_step		= 6250,
-		.volt_base		= 400000,
-		.vmax			= 0x60,
-		.vmin			= 0x1a,
-		.age_config		= 0x555555,
-		.dc_config		= 0x1,
-		.dvt_fixed		= 0x6,
-		.vco			= 0x18,
-		.chk_shift		= 0x87,
-		.core_sel		= 0x0fff0101,
-		.int_st			= BIT(1),
-		.ctl0			= 0x00540003,
-		.tzone_htemp		= 85000,
-		.tzone_htemp_voffset	= 0,
-		.tzone_ltemp		= 25000,
-		.tzone_ltemp_voffset	= 7,
-	},
-};
-
-static struct svs_bank svs_mt8183_banks[] = {
-	{
-		.sw_id			= SVSB_CPU_LITTLE,
-		.set_freq_pct		= svs_set_bank_freq_pct_v2,
-		.get_volts		= svs_get_bank_volts_v2,
-		.cpu_id			= 0,
-		.buck_name		= "proc",
-		.volt_flags		= SVSB_INIT01_VOLT_INC_ONLY,
-		.mode_support		= SVSB_MODE_INIT01 | SVSB_MODE_INIT02,
-		.opp_count		= MAX_OPP_ENTRIES,
-		.freq_base		= 1989000000,
-		.vboot			= 0x30,
-		.volt_step		= 6250,
-		.volt_base		= 500000,
-		.vmax			= 0x64,
-		.vmin			= 0x18,
-		.age_config		= 0x555555,
-		.dc_config		= 0x555555,
-		.dvt_fixed		= 0x7,
-		.vco			= 0x10,
-		.chk_shift		= 0x77,
-		.core_sel		= 0x8fff0000,
-		.int_st			= BIT(0),
-		.ctl0			= 0x00010001,
-	},
-	{
-		.sw_id			= SVSB_CPU_BIG,
-		.set_freq_pct		= svs_set_bank_freq_pct_v2,
-		.get_volts		= svs_get_bank_volts_v2,
-		.cpu_id			= 4,
-		.buck_name		= "proc",
-		.volt_flags		= SVSB_INIT01_VOLT_INC_ONLY,
-		.mode_support		= SVSB_MODE_INIT01 | SVSB_MODE_INIT02,
-		.opp_count		= MAX_OPP_ENTRIES,
-		.freq_base		= 1989000000,
-		.vboot			= 0x30,
-		.volt_step		= 6250,
-		.volt_base		= 500000,
-		.vmax			= 0x58,
-		.vmin			= 0x10,
-		.age_config		= 0x555555,
-		.dc_config		= 0x555555,
-		.dvt_fixed		= 0x7,
-		.vco			= 0x10,
-		.chk_shift		= 0x77,
-		.core_sel		= 0x8fff0001,
-		.int_st			= BIT(1),
-		.ctl0			= 0x00000001,
-	},
-	{
-		.sw_id			= SVSB_CCI,
-		.set_freq_pct		= svs_set_bank_freq_pct_v2,
-		.get_volts		= svs_get_bank_volts_v2,
-		.buck_name		= "proc",
-		.volt_flags		= SVSB_INIT01_VOLT_INC_ONLY,
-		.mode_support		= SVSB_MODE_INIT01 | SVSB_MODE_INIT02,
-		.opp_count		= MAX_OPP_ENTRIES,
-		.freq_base		= 1196000000,
-		.vboot			= 0x30,
-		.volt_step		= 6250,
-		.volt_base		= 500000,
-		.vmax			= 0x64,
-		.vmin			= 0x18,
-		.age_config		= 0x555555,
-		.dc_config		= 0x555555,
-		.dvt_fixed		= 0x7,
-		.vco			= 0x10,
-		.chk_shift		= 0x77,
-		.core_sel		= 0x8fff0002,
-		.int_st			= BIT(2),
-		.ctl0			= 0x00100003,
-	},
-	{
-		.sw_id			= SVSB_GPU,
-		.set_freq_pct		= svs_set_bank_freq_pct_v2,
-		.get_volts		= svs_get_bank_volts_v2,
-		.buck_name		= "mali",
-		.tzone_name		= "tzts2",
-		.volt_flags		= SVSB_INIT01_PD_REQ |
-					  SVSB_INIT01_VOLT_INC_ONLY,
-		.mode_support		= SVSB_MODE_INIT01 | SVSB_MODE_INIT02 |
-					  SVSB_MODE_MON,
-		.opp_count		= MAX_OPP_ENTRIES,
-		.freq_base		= 900000000,
-		.vboot			= 0x30,
-		.volt_step		= 6250,
-		.volt_base		= 500000,
-		.vmax			= 0x40,
-		.vmin			= 0x14,
-		.age_config		= 0x555555,
-		.dc_config		= 0x555555,
-		.dvt_fixed		= 0x3,
-		.vco			= 0x10,
-		.chk_shift		= 0x77,
-		.core_sel		= 0x8fff0003,
-		.int_st			= BIT(3),
-		.ctl0			= 0x00050001,
-		.tzone_htemp		= 85000,
-		.tzone_htemp_voffset	= 0,
-		.tzone_ltemp		= 25000,
-		.tzone_ltemp_voffset	= 3,
-	},
-};
-
 static const struct svs_platform_data svs_mt8192_platform_data = {
 	.name = "mt8192-svs",
 	.banks = svs_mt8192_banks,
diff --git a/drivers/soc/mediatek/mtk-svs.h b/drivers/soc/mediatek/mtk-svs.h
new file mode 100644
index 000000000000..dca414181066
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-svs.h
@@ -0,0 +1,279 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __DRV_SVS_MTK_H
+#define __DRV_SVS_MTK_H
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/reset.h>
+
+/* svs bank 1-line software id */
+#define SVSB_CPU_LITTLE			BIT(0)
+#define SVSB_CPU_BIG			BIT(1)
+#define SVSB_CCI			BIT(2)
+#define SVSB_GPU			BIT(3)
+
+/* svs bank 2-line type */
+#define SVSB_LOW			BIT(8)
+#define SVSB_HIGH			BIT(9)
+
+/* svs bank mode support */
+#define SVSB_MODE_ALL_DISABLE		0
+#define SVSB_MODE_INIT01		BIT(1)
+#define SVSB_MODE_INIT02		BIT(2)
+#define SVSB_MODE_MON			BIT(3)
+
+/* svs bank volt flags */
+#define SVSB_INIT01_PD_REQ		BIT(0)
+#define SVSB_INIT01_VOLT_IGNORE		BIT(1)
+#define SVSB_INIT01_VOLT_INC_ONLY	BIT(2)
+#define SVSB_MON_VOLT_IGNORE		BIT(16)
+#define SVSB_REMOVE_DVTFIXED_VOLT	BIT(24)
+
+/**
+ * enum svsb_phase - svs bank phase enumeration
+ * @SVSB_PHASE_ERROR: svs bank encounters unexpected condition
+ * @SVSB_PHASE_INIT01: svs bank basic init for data calibration
+ * @SVSB_PHASE_INIT02: svs bank can provide voltages to opp table
+ * @SVSB_PHASE_MON: svs bank can provide voltages with thermal effect
+ * @SVSB_PHASE_MAX: total number of svs bank phase (debug purpose)
+ *
+ * Each svs bank has its own independent phase and we enable each svs bank by
+ * running their phase orderly. However, when svs bank encounters unexpected
+ * condition, it will fire an irq (PHASE_ERROR) to inform svs software.
+ *
+ * svs bank general phase-enabled order:
+ * SVSB_PHASE_INIT01 -> SVSB_PHASE_INIT02 -> SVSB_PHASE_MON
+ */
+enum svsb_phase {
+	SVSB_PHASE_ERROR = 0,
+	SVSB_PHASE_INIT01,
+	SVSB_PHASE_INIT02,
+	SVSB_PHASE_MON,
+	SVSB_PHASE_MAX,
+};
+
+enum svs_reg_index {
+	DESCHAR = 0,
+	TEMPCHAR,
+	DETCHAR,
+	AGECHAR,
+	DCCONFIG,
+	AGECONFIG,
+	FREQPCT30,
+	FREQPCT74,
+	LIMITVALS,
+	VBOOT,
+	DETWINDOW,
+	CONFIG,
+	TSCALCS,
+	RUNCONFIG,
+	SVSEN,
+	INIT2VALS,
+	DCVALUES,
+	AGEVALUES,
+	VOP30,
+	VOP74,
+	TEMP,
+	INTSTS,
+	INTSTSRAW,
+	INTEN,
+	CHKINT,
+	CHKSHIFT,
+	STATUS,
+	VDESIGN30,
+	VDESIGN74,
+	DVT30,
+	DVT74,
+	AGECOUNT,
+	SMSTATE0,
+	SMSTATE1,
+	CTL0,
+	DESDETSEC,
+	TEMPAGESEC,
+	CTRLSPARE0,
+	CTRLSPARE1,
+	CTRLSPARE2,
+	CTRLSPARE3,
+	CORESEL,
+	THERMINTST,
+	INTST,
+	THSTAGE0ST,
+	THSTAGE1ST,
+	THSTAGE2ST,
+	THAHBST0,
+	THAHBST1,
+	SPARE0,
+	SPARE1,
+	SPARE2,
+	SPARE3,
+	THSLPEVEB,
+	SVS_REG_MAX,
+};
+
+/**
+ * struct svs_platform - svs platform control
+ * @base: svs platform register base
+ * @dev: svs platform device
+ * @main_clk: main clock for svs bank
+ * @pbank: svs bank pointer needing to be protected by spin_lock section
+ * @banks: svs banks that svs platform supports
+ * @rst: svs platform reset control
+ * @efuse_max: total number of svs efuse
+ * @tefuse_max: total number of thermal efuse
+ * @regs: svs platform registers map
+ * @bank_max: total number of svs banks
+ * @efuse: svs efuse data received from NVMEM framework
+ * @tefuse: thermal efuse data received from NVMEM framework
+ */
+struct svs_platform {
+	void __iomem *base;
+	struct device *dev;
+	struct clk *main_clk;
+	struct svs_bank *pbank;
+	struct svs_bank *banks;
+	struct reset_control *rst;
+	size_t efuse_max;
+	size_t tefuse_max;
+	const u32 *regs;
+	u32 bank_max;
+	u32 *efuse;
+	u32 *tefuse;
+};
+
+#define MAX_OPP_ENTRIES			16
+
+/**
+ * struct svs_bank - svs bank representation
+ * @dev: bank device
+ * @opp_dev: device for opp table/buck control
+ * @init_completion: the timeout completion for bank init
+ * @buck: regulator used by opp_dev
+ * @tzd: thermal zone device for getting temperature
+ * @lock: mutex lock to protect voltage update process
+ * @set_freq_pct: function pointer to set bank frequency percent table
+ * @get_volts: function pointer to get bank voltages
+ * @name: bank name
+ * @buck_name: regulator name
+ * @tzone_name: thermal zone name
+ * @phase: bank current phase
+ * @volt_od: bank voltage overdrive
+ * @reg_data: bank register data in different phase for debug purpose
+ * @pm_runtime_enabled_count: bank pm runtime enabled count
+ * @mode_support: bank mode support.
+ * @freq_base: reference frequency for bank init
+ * @turn_freq_base: refenrece frequency for 2-line turn point
+ * @vboot: voltage request for bank init01 only
+ * @opp_dfreq: default opp frequency table
+ * @opp_dvolt: default opp voltage table
+ * @freq_pct: frequency percent table for bank init
+ * @volt: bank voltage table
+ * @volt_step: bank voltage step
+ * @volt_base: bank voltage base
+ * @volt_flags: bank voltage flags
+ * @vmax: bank voltage maximum
+ * @vmin: bank voltage minimum
+ * @age_config: bank age configuration
+ * @age_voffset_in: bank age voltage offset
+ * @dc_config: bank dc configuration
+ * @dc_voffset_in: bank dc voltage offset
+ * @dvt_fixed: bank dvt fixed value
+ * @vco: bank VCO value
+ * @chk_shift: bank chicken shift
+ * @core_sel: bank selection
+ * @opp_count: bank opp count
+ * @int_st: bank interrupt identification
+ * @sw_id: bank software identification
+ * @cpu_id: cpu core id for SVS CPU bank use only
+ * @ctl0: TS-x selection
+ * @temp: bank temperature
+ * @tzone_htemp: thermal zone high temperature threshold
+ * @tzone_htemp_voffset: thermal zone high temperature voltage offset
+ * @tzone_ltemp: thermal zone low temperature threshold
+ * @tzone_ltemp_voffset: thermal zone low temperature voltage offset
+ * @bts: svs efuse data
+ * @mts: svs efuse data
+ * @bdes: svs efuse data
+ * @mdes: svs efuse data
+ * @mtdes: svs efuse data
+ * @dcbdet: svs efuse data
+ * @dcmdet: svs efuse data
+ * @turn_pt: 2-line turn point tells which opp_volt calculated by high/low bank
+ * @type: bank type to represent it is 2-line (high/low) bank or 1-line bank
+ *
+ * Svs bank will generate suitalbe voltages by below general math equation
+ * and provide these voltages to opp voltage table.
+ *
+ * opp_volt[i] = (volt[i] * volt_step) + volt_base;
+ */
+struct svs_bank {
+	struct device *dev;
+	struct device *opp_dev;
+	struct completion init_completion;
+	struct regulator *buck;
+	struct thermal_zone_device *tzd;
+	struct mutex lock;	/* lock to protect voltage update process */
+	void (*set_freq_pct)(struct svs_platform *svsp);
+	void (*get_volts)(struct svs_platform *svsp);
+	char *name;
+	char *buck_name;
+	char *tzone_name;
+	enum svsb_phase phase;
+	s32 volt_od;
+	u32 reg_data[SVSB_PHASE_MAX][SVS_REG_MAX];
+	u32 pm_runtime_enabled_count;
+	u32 mode_support;
+	u32 freq_base;
+	u32 turn_freq_base;
+	u32 vboot;
+	u32 opp_dfreq[MAX_OPP_ENTRIES];
+	u32 opp_dvolt[MAX_OPP_ENTRIES];
+	u32 freq_pct[MAX_OPP_ENTRIES];
+	u32 volt[MAX_OPP_ENTRIES];
+	u32 volt_step;
+	u32 volt_base;
+	u32 volt_flags;
+	u32 vmax;
+	u32 vmin;
+	u32 age_config;
+	u32 age_voffset_in;
+	u32 dc_config;
+	u32 dc_voffset_in;
+	u32 dvt_fixed;
+	u32 vco;
+	u32 chk_shift;
+	u32 core_sel;
+	u32 opp_count;
+	u32 int_st;
+	u32 sw_id;
+	u32 cpu_id;
+	u32 ctl0;
+	u32 temp;
+	u32 tzone_htemp;
+	u32 tzone_htemp_voffset;
+	u32 tzone_ltemp;
+	u32 tzone_ltemp_voffset;
+	u32 bts;
+	u32 mts;
+	u32 bdes;
+	u32 mdes;
+	u32 mtdes;
+	u32 dcbdet;
+	u32 dcmdet;
+	u32 turn_pt;
+	u32 type;
+};
+
+struct device *svs_add_device_link(struct svs_platform *svsp,
+					  const char *node_name);
+struct device *svs_get_subsys_device(struct svs_platform *svsp,
+					    const char *node_name);
+int svs_thermal_efuse_get_data(struct svs_platform *svsp);
+
+void svs_get_bank_volts_v2(struct svs_platform *svsp);
+void svs_set_bank_freq_pct_v2(struct svs_platform *svsp);
+
+void svs_get_bank_volts_v3(struct svs_platform *svsp);
+void svs_set_bank_freq_pct_v3(struct svs_platform *svsp);
+#endif
-- 
2.37.3

