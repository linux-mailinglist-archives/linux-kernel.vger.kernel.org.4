Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7F65952B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 06:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiL3Fzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 00:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbiL3FzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 00:55:03 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318EF164AE;
        Thu, 29 Dec 2022 21:54:59 -0800 (PST)
X-UUID: aa84904ec2c54aa38a011024dd26fbf6-20221230
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hZ47V1Nxsm5xIBY7uDVQ+veI3ngl2d6KM73Bju0xkiQ=;
        b=PjuIxCe9ICL51DRZRCP+k35P85I282h0WsitVYeIeCtrwuhMup919yiCR9n8EGTYUpWa7iUwn21HZqaV8UesViN43yzuKjt7Y8+2KjBK+VsLmkAb7MwX1rLmoNZHkYLnph/9f0Cj3zvP/y0FOXecfky0qS5Lum3ZLVB/QK67dzQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:99e691f0-9b3e-4aa9-968b-7e089e526fdc,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.16,REQID:99e691f0-9b3e-4aa9-968b-7e089e526fdc,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:09771b1,CLOUDID:24f45ff4-ff42-4fb0-b929-626456a83c14,B
        ulkID:221230135451KL19NN18,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0
X-UUID: aa84904ec2c54aa38a011024dd26fbf6-20221230
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 59465427; Fri, 30 Dec 2022 13:54:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 30 Dec 2022 13:54:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Dec 2022 13:54:49 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <p.zabel@pengutronix.de>
CC:     <trevor.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 03/13] ASoC: mediatek: mt8188: support audsys clock
Date:   Fri, 30 Dec 2022 13:54:33 +0800
Message-ID: <20221230055443.16024-4-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221230055443.16024-1-trevor.wu@mediatek.com>
References: <20221230055443.16024-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
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

Add mt8188 audio cg clock control. Audio clock gates are registered to CCF
for reference count and clock parent management.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c | 205 ++++++++++++++++++
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.h |  15 ++
 .../soc/mediatek/mt8188/mt8188-audsys-clkid.h |  83 +++++++
 3 files changed, 303 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-audsys-clk.h
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h

diff --git a/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c b/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
new file mode 100644
index 000000000000..be1c53bf4729
--- /dev/null
+++ b/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mt8188-audsys-clk.c  --  MediaTek 8188 audsys clock control
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Chun-Chia Chiu <chun-chia.chiu@mediatek.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include "mt8188-afe-common.h"
+#include "mt8188-audsys-clk.h"
+#include "mt8188-audsys-clkid.h"
+#include "mt8188-reg.h"
+
+struct afe_gate {
+	int id;
+	const char *name;
+	const char *parent_name;
+	int reg;
+	u8 bit;
+	const struct clk_ops *ops;
+	unsigned long flags;
+	u8 cg_flags;
+};
+
+#define GATE_AFE_FLAGS(_id, _name, _parent, _reg, _bit, _flags, _cgflags) {\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.reg = _reg,					\
+		.bit = _bit,					\
+		.flags = _flags,				\
+		.cg_flags = _cgflags,				\
+	}
+
+#define GATE_AFE(_id, _name, _parent, _reg, _bit)		\
+	GATE_AFE_FLAGS(_id, _name, _parent, _reg, _bit,		\
+		       CLK_SET_RATE_PARENT, CLK_GATE_SET_TO_DISABLE)
+
+#define GATE_AUD0(_id, _name, _parent, _bit)			\
+	GATE_AFE(_id, _name, _parent, AUDIO_TOP_CON0, _bit)
+
+#define GATE_AUD1(_id, _name, _parent, _bit)			\
+	GATE_AFE(_id, _name, _parent, AUDIO_TOP_CON1, _bit)
+
+#define GATE_AUD3(_id, _name, _parent, _bit)			\
+	GATE_AFE(_id, _name, _parent, AUDIO_TOP_CON3, _bit)
+
+#define GATE_AUD4(_id, _name, _parent, _bit)			\
+	GATE_AFE(_id, _name, _parent, AUDIO_TOP_CON4, _bit)
+
+#define GATE_AUD5(_id, _name, _parent, _bit)			\
+	GATE_AFE(_id, _name, _parent, AUDIO_TOP_CON5, _bit)
+
+#define GATE_AUD6(_id, _name, _parent, _bit)			\
+	GATE_AFE(_id, _name, _parent, AUDIO_TOP_CON6, _bit)
+
+static const struct afe_gate aud_clks[CLK_AUD_NR_CLK] = {
+	/* AUD0 */
+	GATE_AUD0(CLK_AUD_AFE, "aud_afe", "top_a1sys_hp", 2),
+	GATE_AUD0(CLK_AUD_LRCK_CNT, "aud_lrck_cnt", "top_a1sys_hp", 4),
+	GATE_AUD0(CLK_AUD_SPDIFIN_TUNER_APLL, "aud_spdifin_tuner_apll", "top_apll4", 10),
+	GATE_AUD0(CLK_AUD_SPDIFIN_TUNER_DBG, "aud_spdifin_tuner_dbg", "top_apll4", 11),
+	GATE_AUD0(CLK_AUD_UL_TML, "aud_ul_tml", "top_a1sys_hp", 18),
+	GATE_AUD0(CLK_AUD_APLL1_TUNER, "aud_apll1_tuner", "top_apll1", 19),
+	GATE_AUD0(CLK_AUD_APLL2_TUNER, "aud_apll2_tuner", "top_apll2", 20),
+	GATE_AUD0(CLK_AUD_TOP0_SPDF, "aud_top0_spdf", "top_aud_iec_clk", 21),
+	GATE_AUD0(CLK_AUD_APLL, "aud_apll", "top_apll1", 23),
+	GATE_AUD0(CLK_AUD_APLL2, "aud_apll2", "top_apll2", 24),
+	GATE_AUD0(CLK_AUD_DAC, "aud_dac", "top_a1sys_hp", 25),
+	GATE_AUD0(CLK_AUD_DAC_PREDIS, "aud_dac_predis", "top_a1sys_hp", 26),
+	GATE_AUD0(CLK_AUD_TML, "aud_tml", "top_a1sys_hp", 27),
+	GATE_AUD0(CLK_AUD_ADC, "aud_adc", "top_a1sys_hp", 28),
+	GATE_AUD0(CLK_AUD_DAC_HIRES, "aud_dac_hires", "top_audio_h", 31),
+
+	/* AUD1 */
+	GATE_AUD1(CLK_AUD_A1SYS_HP, "aud_a1sys_hp", "top_a1sys_hp", 2),
+	GATE_AUD1(CLK_AUD_AFE_DMIC1, "aud_afe_dmic1", "top_a1sys_hp", 10),
+	GATE_AUD1(CLK_AUD_AFE_DMIC2, "aud_afe_dmic2", "top_a1sys_hp", 11),
+	GATE_AUD1(CLK_AUD_AFE_DMIC3, "aud_afe_dmic3", "top_a1sys_hp", 12),
+	GATE_AUD1(CLK_AUD_AFE_DMIC4, "aud_afe_dmic4", "top_a1sys_hp", 13),
+	GATE_AUD1(CLK_AUD_AFE_26M_DMIC_TM, "aud_afe_26m_dmic_tm", "top_a1sys_hp", 14),
+	GATE_AUD1(CLK_AUD_UL_TML_HIRES, "aud_ul_tml_hires", "top_audio_h", 16),
+	GATE_AUD1(CLK_AUD_ADC_HIRES, "aud_adc_hires", "top_audio_h", 17),
+
+	/* AUD3 */
+	GATE_AUD3(CLK_AUD_LINEIN_TUNER, "aud_linein_tuner", "top_apll5", 5),
+	GATE_AUD3(CLK_AUD_EARC_TUNER, "aud_earc_tuner", "top_apll3", 7),
+
+	/* AUD4 */
+	GATE_AUD4(CLK_AUD_I2SIN, "aud_i2sin", "top_a1sys_hp", 0),
+	GATE_AUD4(CLK_AUD_TDM_IN, "aud_tdm_in", "top_a1sys_hp", 1),
+	GATE_AUD4(CLK_AUD_I2S_OUT, "aud_i2s_out", "top_a1sys_hp", 6),
+	GATE_AUD4(CLK_AUD_TDM_OUT, "aud_tdm_out", "top_a1sys_hp", 7),
+	GATE_AUD4(CLK_AUD_HDMI_OUT, "aud_hdmi_out", "top_a1sys_hp", 8),
+	GATE_AUD4(CLK_AUD_ASRC11, "aud_asrc11", "top_a1sys_hp", 16),
+	GATE_AUD4(CLK_AUD_ASRC12, "aud_asrc12", "top_a1sys_hp", 17),
+	GATE_AUD4(CLK_AUD_MULTI_IN, "aud_multi_in", "mphone_slave_b", 19),
+	GATE_AUD4(CLK_AUD_INTDIR, "aud_intdir", "top_intdir", 20),
+	GATE_AUD4(CLK_AUD_A1SYS, "aud_a1sys", "top_a1sys_hp", 21),
+	GATE_AUD4(CLK_AUD_A2SYS, "aud_a2sys", "top_a2sys", 22),
+	GATE_AUD4(CLK_AUD_PCMIF, "aud_pcmif", "top_a1sys_hp", 24),
+	GATE_AUD4(CLK_AUD_A3SYS, "aud_a3sys", "top_a3sys", 30),
+	GATE_AUD4(CLK_AUD_A4SYS, "aud_a4sys", "top_a4sys", 31),
+
+	/* AUD5 */
+	GATE_AUD5(CLK_AUD_MEMIF_UL1, "aud_memif_ul1", "top_a1sys_hp", 0),
+	GATE_AUD5(CLK_AUD_MEMIF_UL2, "aud_memif_ul2", "top_a1sys_hp", 1),
+	GATE_AUD5(CLK_AUD_MEMIF_UL3, "aud_memif_ul3", "top_a1sys_hp", 2),
+	GATE_AUD5(CLK_AUD_MEMIF_UL4, "aud_memif_ul4", "top_a1sys_hp", 3),
+	GATE_AUD5(CLK_AUD_MEMIF_UL5, "aud_memif_ul5", "top_a1sys_hp", 4),
+	GATE_AUD5(CLK_AUD_MEMIF_UL6, "aud_memif_ul6", "top_a1sys_hp", 5),
+	GATE_AUD5(CLK_AUD_MEMIF_UL8, "aud_memif_ul8", "top_a1sys_hp", 7),
+	GATE_AUD5(CLK_AUD_MEMIF_UL9, "aud_memif_ul9", "top_a1sys_hp", 8),
+	GATE_AUD5(CLK_AUD_MEMIF_UL10, "aud_memif_ul10", "top_a1sys_hp", 9),
+	GATE_AUD5(CLK_AUD_MEMIF_DL2, "aud_memif_dl2", "top_a1sys_hp", 18),
+	GATE_AUD5(CLK_AUD_MEMIF_DL3, "aud_memif_dl3", "top_a1sys_hp", 19),
+	GATE_AUD5(CLK_AUD_MEMIF_DL6, "aud_memif_dl6", "top_a1sys_hp", 22),
+	GATE_AUD5(CLK_AUD_MEMIF_DL7, "aud_memif_dl7", "top_a1sys_hp", 23),
+	GATE_AUD5(CLK_AUD_MEMIF_DL8, "aud_memif_dl8", "top_a1sys_hp", 24),
+	GATE_AUD5(CLK_AUD_MEMIF_DL10, "aud_memif_dl10", "top_a1sys_hp", 26),
+	GATE_AUD5(CLK_AUD_MEMIF_DL11, "aud_memif_dl11", "top_a1sys_hp", 27),
+
+	/* AUD6 */
+	GATE_AUD6(CLK_AUD_GASRC0, "aud_gasrc0", "top_asm_h", 0),
+	GATE_AUD6(CLK_AUD_GASRC1, "aud_gasrc1", "top_asm_h", 1),
+	GATE_AUD6(CLK_AUD_GASRC2, "aud_gasrc2", "top_asm_h", 2),
+	GATE_AUD6(CLK_AUD_GASRC3, "aud_gasrc3", "top_asm_h", 3),
+	GATE_AUD6(CLK_AUD_GASRC4, "aud_gasrc4", "top_asm_h", 4),
+	GATE_AUD6(CLK_AUD_GASRC5, "aud_gasrc5", "top_asm_h", 5),
+	GATE_AUD6(CLK_AUD_GASRC6, "aud_gasrc6", "top_asm_h", 6),
+	GATE_AUD6(CLK_AUD_GASRC7, "aud_gasrc7", "top_asm_h", 7),
+	GATE_AUD6(CLK_AUD_GASRC8, "aud_gasrc8", "top_asm_h", 8),
+	GATE_AUD6(CLK_AUD_GASRC9, "aud_gasrc9", "top_asm_h", 9),
+	GATE_AUD6(CLK_AUD_GASRC10, "aud_gasrc10", "top_asm_h", 10),
+	GATE_AUD6(CLK_AUD_GASRC11, "aud_gasrc11", "top_asm_h", 11),
+};
+
+int mt8188_audsys_clk_register(struct mtk_base_afe *afe)
+{
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct clk *clk;
+	struct clk_lookup *cl;
+	int i;
+
+	afe_priv->lookup = devm_kcalloc(afe->dev, CLK_AUD_NR_CLK,
+					sizeof(*afe_priv->lookup),
+					GFP_KERNEL);
+
+	if (!afe_priv->lookup)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(aud_clks); i++) {
+		const struct afe_gate *gate = &aud_clks[i];
+
+		clk = clk_register_gate(afe->dev, gate->name, gate->parent_name,
+					gate->flags, afe->base_addr + gate->reg,
+					gate->bit, gate->cg_flags, NULL);
+
+		if (IS_ERR(clk)) {
+			dev_err(afe->dev, "Failed to register clk %s: %ld\n",
+				gate->name, PTR_ERR(clk));
+			continue;
+		}
+
+		/* add clk_lookup for devm_clk_get(SND_SOC_DAPM_CLOCK_SUPPLY) */
+		cl = kzalloc(sizeof(*cl), GFP_KERNEL);
+		if (!cl)
+			return -ENOMEM;
+
+		cl->clk = clk;
+		cl->con_id = gate->name;
+		cl->dev_id = dev_name(afe->dev);
+		cl->clk_hw = NULL;
+		clkdev_add(cl);
+
+		afe_priv->lookup[i] = cl;
+	}
+
+	return 0;
+}
+
+void mt8188_audsys_clk_unregister(struct mtk_base_afe *afe)
+{
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct clk *clk;
+	struct clk_lookup *cl;
+	int i;
+
+	if (!afe_priv)
+		return;
+
+	for (i = 0; i < CLK_AUD_NR_CLK; i++) {
+		cl = afe_priv->lookup[i];
+		if (!cl)
+			continue;
+
+		clk = cl->clk;
+		clk_unregister_gate(clk);
+
+		clkdev_drop(cl);
+	}
+}
diff --git a/sound/soc/mediatek/mt8188/mt8188-audsys-clk.h b/sound/soc/mediatek/mt8188/mt8188-audsys-clk.h
new file mode 100644
index 000000000000..6c5f463ad7e4
--- /dev/null
+++ b/sound/soc/mediatek/mt8188/mt8188-audsys-clk.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mt8188-audsys-clk.h  --  MediaTek 8188 audsys clock definition
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Chun-Chia Chiu <chun-chia.chiu@mediatek.com>
+ */
+
+#ifndef _MT8188_AUDSYS_CLK_H_
+#define _MT8188_AUDSYS_CLK_H_
+
+int mt8188_audsys_clk_register(struct mtk_base_afe *afe);
+void mt8188_audsys_clk_unregister(struct mtk_base_afe *afe);
+
+#endif
diff --git a/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h b/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
new file mode 100644
index 000000000000..6f34ffc760e0
--- /dev/null
+++ b/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mt8188-audsys-clkid.h  --  MediaTek 8188 audsys clock id definition
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Chun-Chia Chiu <chun-chia.chiu@mediatek.com>
+ */
+
+#ifndef _MT8188_AUDSYS_CLKID_H_
+#define _MT8188_AUDSYS_CLKID_H_
+
+enum{
+	CLK_AUD_AFE,
+	CLK_AUD_LRCK_CNT,
+	CLK_AUD_SPDIFIN_TUNER_APLL,
+	CLK_AUD_SPDIFIN_TUNER_DBG,
+	CLK_AUD_UL_TML,
+	CLK_AUD_APLL1_TUNER,
+	CLK_AUD_APLL2_TUNER,
+	CLK_AUD_TOP0_SPDF,
+	CLK_AUD_APLL,
+	CLK_AUD_APLL2,
+	CLK_AUD_DAC,
+	CLK_AUD_DAC_PREDIS,
+	CLK_AUD_TML,
+	CLK_AUD_ADC,
+	CLK_AUD_DAC_HIRES,
+	CLK_AUD_A1SYS_HP,
+	CLK_AUD_AFE_DMIC1,
+	CLK_AUD_AFE_DMIC2,
+	CLK_AUD_AFE_DMIC3,
+	CLK_AUD_AFE_DMIC4,
+	CLK_AUD_AFE_26M_DMIC_TM,
+	CLK_AUD_UL_TML_HIRES,
+	CLK_AUD_ADC_HIRES,
+	CLK_AUD_LINEIN_TUNER,
+	CLK_AUD_EARC_TUNER,
+	CLK_AUD_I2SIN,
+	CLK_AUD_TDM_IN,
+	CLK_AUD_I2S_OUT,
+	CLK_AUD_TDM_OUT,
+	CLK_AUD_HDMI_OUT,
+	CLK_AUD_ASRC11,
+	CLK_AUD_ASRC12,
+	CLK_AUD_MULTI_IN,
+	CLK_AUD_INTDIR,
+	CLK_AUD_A1SYS,
+	CLK_AUD_A2SYS,
+	CLK_AUD_PCMIF,
+	CLK_AUD_A3SYS,
+	CLK_AUD_A4SYS,
+	CLK_AUD_MEMIF_UL1,
+	CLK_AUD_MEMIF_UL2,
+	CLK_AUD_MEMIF_UL3,
+	CLK_AUD_MEMIF_UL4,
+	CLK_AUD_MEMIF_UL5,
+	CLK_AUD_MEMIF_UL6,
+	CLK_AUD_MEMIF_UL8,
+	CLK_AUD_MEMIF_UL9,
+	CLK_AUD_MEMIF_UL10,
+	CLK_AUD_MEMIF_DL2,
+	CLK_AUD_MEMIF_DL3,
+	CLK_AUD_MEMIF_DL6,
+	CLK_AUD_MEMIF_DL7,
+	CLK_AUD_MEMIF_DL8,
+	CLK_AUD_MEMIF_DL10,
+	CLK_AUD_MEMIF_DL11,
+	CLK_AUD_GASRC0,
+	CLK_AUD_GASRC1,
+	CLK_AUD_GASRC2,
+	CLK_AUD_GASRC3,
+	CLK_AUD_GASRC4,
+	CLK_AUD_GASRC5,
+	CLK_AUD_GASRC6,
+	CLK_AUD_GASRC7,
+	CLK_AUD_GASRC8,
+	CLK_AUD_GASRC9,
+	CLK_AUD_GASRC10,
+	CLK_AUD_GASRC11,
+	CLK_AUD_NR_CLK,
+};
+
+#endif
-- 
2.18.0

