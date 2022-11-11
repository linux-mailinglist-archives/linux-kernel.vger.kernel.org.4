Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EE1625709
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiKKJlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiKKJlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:41:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496D7654E3;
        Fri, 11 Nov 2022 01:41:14 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 29C7B660035A;
        Fri, 11 Nov 2022 09:41:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668159672;
        bh=/QAbwy39z5wB7wwJDYJB20RcokLJXsTqKYcafNeAgBc=;
        h=From:To:Cc:Subject:Date:From;
        b=f7eLY5VFMz5KIPdqNWG+Z0GZRRIXfYo7L/QNDxqXbAPduxqg3Y2mOpEpStioieRoy
         EGS2tx19LAtuDljepAHrBox9Gb4swrvCU8X1cf9NmQEtFW6mgJrTVsGNB4a+bp20u2
         2hGKf2OEt2taKqVyaVt7IWumevoN6/JsXxuAHHHoE0fQciRQBfX4B8+FqQ1s0zdQMN
         sdcBlI2WYO2zLQuFAg0OTtfwDg3rwKha23xhjCT5gCVEEbn+GdubnaeVouWT1kL1Lm
         y8fhoobdeVAFmT3XXCIP7nnBiCIomUak1l7A1Kr40xYRY16kYFTgWlhOku8iTtNb8s
         6iawiHr/NpYnA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@kernel.org
Cc:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        nfraprado@collabora.com, marijn.suijten@somainline.org,
        jami.kettunen@somainline.org, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] pinctrl: mediatek: Fix EINT pins input debounce time configuration
Date:   Fri, 11 Nov 2022 10:41:06 +0100
Message-Id: <20221111094106.18486-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
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

The External Interrupt Controller (EINTC) on all of the supported
MediaTek SoCs does support input debouncing, but not all of them
index the debounce time values (DBNC_SETTING registers) the same way.

Before this change, in some cases, as an example, requesting a debounce
time of 16 milliseconds would mistakenly set the relative DBNC_SETTING
register to 0x2, resulting in a way shorter debounce time of 500uS.

To fix the aforementioned issue, define three different debounce_time
arrays, reflecting the correct register index for each value and for
each register index variant, and make sure that each SoC pinctrl
driver uses the right one.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

I know, this commit is a good candidate to get a Fixes tag, but I
couldn't find a way to actually do that cleanly...

The only way would be to split this in one commit for each pinctrl
driver, but that would result in a series containing 21 commits, of
which 20 are one-liners... and that didn't look right.

 drivers/pinctrl/mediatek/mtk-eint.c       | 31 +++++++++++++++++++----
 drivers/pinctrl/mediatek/mtk-eint.h       |  6 +++++
 drivers/pinctrl/mediatek/pinctrl-mt2701.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt2712.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt6765.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt6779.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt6795.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt7622.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt7623.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt7629.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt7986.c |  2 ++
 drivers/pinctrl/mediatek/pinctrl-mt8127.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8135.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8167.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8173.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8183.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8186.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8188.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8192.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8195.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8365.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8516.c |  1 +
 22 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
index fff0c05a1425..3e205318b54e 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.c
+++ b/drivers/pinctrl/mediatek/mtk-eint.c
@@ -24,6 +24,7 @@
 #define MTK_EINT_EDGE_SENSITIVE           0
 #define MTK_EINT_LEVEL_SENSITIVE          1
 #define MTK_EINT_DBNC_SET_DBNC_BITS	  4
+#define MTK_EINT_DBNC_MAX		  16
 #define MTK_EINT_DBNC_RST_BIT		  (0x1 << 1)
 #define MTK_EINT_DBNC_SET_EN		  (0x1 << 0)
 
@@ -48,6 +49,18 @@ static const struct mtk_eint_regs mtk_generic_eint_regs = {
 	.dbnc_clr  = 0x700,
 };
 
+const unsigned int debounce_time_mt2701[] = {
+	500, 1000, 16000, 32000, 64000, 128000, 256000, 0
+};
+
+const unsigned int debounce_time_mt6765[] = {
+	125, 250, 500, 1000, 16000, 32000, 64000, 128000, 256000, 512000, 0
+};
+
+const unsigned int debounce_time_mt6795[] = {
+	500, 1000, 16000, 32000, 64000, 128000, 256000, 512000, 0
+};
+
 static void __iomem *mtk_eint_get_offset(struct mtk_eint *eint,
 					 unsigned int eint_num,
 					 unsigned int offset)
@@ -402,10 +415,11 @@ int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_num,
 	int virq, eint_offset;
 	unsigned int set_offset, bit, clr_bit, clr_offset, rst, i, unmask,
 		     dbnc;
-	static const unsigned int debounce_time[] = {500, 1000, 16000, 32000,
-						     64000, 128000, 256000};
 	struct irq_data *d;
 
+	if (!eint->hw->db_time)
+		return -EOPNOTSUPP;
+
 	virq = irq_find_mapping(eint->domain, eint_num);
 	eint_offset = (eint_num % 4) * 8;
 	d = irq_get_irq_data(virq);
@@ -416,9 +430,9 @@ int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_num,
 	if (!mtk_eint_can_en_debounce(eint, eint_num))
 		return -EINVAL;
 
-	dbnc = ARRAY_SIZE(debounce_time);
-	for (i = 0; i < ARRAY_SIZE(debounce_time); i++) {
-		if (debounce <= debounce_time[i]) {
+	dbnc = eint->num_db_time;
+	for (i = 0; i < eint->num_db_time; i++) {
+		if (debounce <= eint->hw->db_time[i]) {
 			dbnc = i;
 			break;
 		}
@@ -492,6 +506,13 @@ int mtk_eint_do_init(struct mtk_eint *eint)
 	if (!eint->domain)
 		return -ENOMEM;
 
+	if (eint->hw->db_time) {
+		for (i = 0; i < MTK_EINT_DBNC_MAX; i++)
+			if (eint->hw->db_time[i] == 0)
+				break;
+		eint->num_db_time = i;
+	}
+
 	mtk_eint_hw_init(eint);
 	for (i = 0; i < eint->hw->ap_num; i++) {
 		int virq = irq_create_mapping(eint->domain, i);
diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
index 48468d0fae68..6139b16cd225 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.h
+++ b/drivers/pinctrl/mediatek/mtk-eint.h
@@ -37,8 +37,13 @@ struct mtk_eint_hw {
 	u8		ports;
 	unsigned int	ap_num;
 	unsigned int	db_cnt;
+	const unsigned int *db_time;
 };
 
+extern const unsigned int debounce_time_mt2701[];
+extern const unsigned int debounce_time_mt6765[];
+extern const unsigned int debounce_time_mt6795[];
+
 struct mtk_eint;
 
 struct mtk_eint_xt {
@@ -62,6 +67,7 @@ struct mtk_eint {
 	/* Used to fit into various EINT device */
 	const struct mtk_eint_hw *hw;
 	const struct mtk_eint_regs *regs;
+	u16 num_db_time;
 
 	/* Used to fit into various pinctrl device */
 	void *pctl;
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2701.c b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
index d1583b4fdd9d..b185538452a0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2701.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
@@ -518,6 +518,7 @@ static const struct mtk_pinctrl_devdata mt2701_pinctrl_data = {
 		.ports     = 6,
 		.ap_num    = 169,
 		.db_cnt    = 16,
+		.db_time   = debounce_time_mt2701,
 	},
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2712.c b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
index b921068f9e69..730a496848dc 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2712.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
@@ -567,6 +567,7 @@ static const struct mtk_pinctrl_devdata mt2712_pinctrl_data = {
 		.ports     = 8,
 		.ap_num    = 229,
 		.db_cnt    = 40,
+		.db_time   = debounce_time_mt2701,
 	},
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6765.c b/drivers/pinctrl/mediatek/pinctrl-mt6765.c
index c57b19fcda03..f6ec41eb6e0c 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6765.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6765.c
@@ -1062,6 +1062,7 @@ static const struct mtk_eint_hw mt6765_eint_hw = {
 	.ports     = 6,
 	.ap_num    = 160,
 	.db_cnt    = 13,
+	.db_time   = debounce_time_mt6765,
 };
 
 static const struct mtk_pin_soc mt6765_data = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6779.c b/drivers/pinctrl/mediatek/pinctrl-mt6779.c
index 4ddf8bda6827..62d4f5ad6737 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6779.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6779.c
@@ -737,6 +737,7 @@ static const struct mtk_eint_hw mt6779_eint_hw = {
 	.ports     = 6,
 	.ap_num    = 195,
 	.db_cnt    = 13,
+	.db_time   = debounce_time_mt2701,
 };
 
 static const struct mtk_pin_soc mt6779_data = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6795.c b/drivers/pinctrl/mediatek/pinctrl-mt6795.c
index f90152261a0f..01e855ccd4dd 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6795.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6795.c
@@ -475,6 +475,7 @@ static const struct mtk_eint_hw mt6795_eint_hw = {
 	.ports     = 7,
 	.ap_num    = 224,
 	.db_cnt    = 32,
+	.db_time   = debounce_time_mt6795,
 };
 
 static const unsigned int mt6795_pull_type[] = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 68eee881ee3d..3c1148d59eff 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -846,6 +846,7 @@ static const struct mtk_eint_hw mt7622_eint_hw = {
 	.ports     = 7,
 	.ap_num    = ARRAY_SIZE(mt7622_pins),
 	.db_cnt    = 20,
+	.db_time   = debounce_time_mt6765,
 };
 
 static const struct mtk_pin_soc mt7622_data = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7623.c b/drivers/pinctrl/mediatek/pinctrl-mt7623.c
index b8d9d31db74f..699977074697 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7623.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7623.c
@@ -1369,6 +1369,7 @@ static const struct mtk_eint_hw mt7623_eint_hw = {
 	.ports     = 6,
 	.ap_num    = 169,
 	.db_cnt    = 20,
+	.db_time   = debounce_time_mt2701,
 };
 
 static struct mtk_pin_soc mt7623_data = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7629.c b/drivers/pinctrl/mediatek/pinctrl-mt7629.c
index b5f0fa43245f..2ce411cb9c6e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7629.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7629.c
@@ -402,6 +402,7 @@ static const struct mtk_eint_hw mt7629_eint_hw = {
 	.ports     = 7,
 	.ap_num    = ARRAY_SIZE(mt7629_pins),
 	.db_cnt    = 16,
+	.db_time   = debounce_time_mt2701,
 };
 
 static struct mtk_pin_soc mt7629_data = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7986.c b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
index 95f32e62e02f..8e2da08e88fd 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7986.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
@@ -844,6 +844,7 @@ static const struct mtk_eint_hw mt7986a_eint_hw = {
 	.ports = 7,
 	.ap_num = ARRAY_SIZE(mt7986a_pins),
 	.db_cnt = 16,
+	.db_time = debounce_time_mt6765,
 };
 
 static const struct mtk_eint_hw mt7986b_eint_hw = {
@@ -851,6 +852,7 @@ static const struct mtk_eint_hw mt7986b_eint_hw = {
 	.ports = 7,
 	.ap_num = ARRAY_SIZE(mt7986b_pins),
 	.db_cnt = 16,
+	.db_time = debounce_time_mt6765,
 };
 
 static struct mtk_pin_soc mt7986a_data = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8127.c b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
index 91c530e7b00e..e8772dcfe69e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8127.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
@@ -286,6 +286,7 @@ static const struct mtk_pinctrl_devdata mt8127_pinctrl_data = {
 		.ports     = 6,
 		.ap_num    = 143,
 		.db_cnt    = 16,
+		.db_time = debounce_time_mt2701,
 	},
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
index 562846756517..cdb0252071fb 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8135.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
@@ -315,6 +315,7 @@ static const struct mtk_pinctrl_devdata mt8135_pinctrl_data = {
 		.ports     = 6,
 		.ap_num    = 192,
 		.db_cnt    = 16,
+		.db_time = debounce_time_mt2701,
 	},
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8167.c b/drivers/pinctrl/mediatek/pinctrl-mt8167.c
index 825167f5d020..866da2c4a890 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8167.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8167.c
@@ -319,6 +319,7 @@ static const struct mtk_pinctrl_devdata mt8167_pinctrl_data = {
 		.ports     = 6,
 		.ap_num    = 169,
 		.db_cnt    = 64,
+		.db_time = debounce_time_mt6795,
 	},
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
index 1d7d11a32e7d..37d8cec1c3ce 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
@@ -327,6 +327,7 @@ static const struct mtk_pinctrl_devdata mt8173_pinctrl_data = {
 		.ports     = 6,
 		.ap_num    = 224,
 		.db_cnt    = 16,
+		.db_time   = debounce_time_mt2701,
 	},
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
index fecb1e64fff4..ddc48b725c22 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
@@ -545,6 +545,7 @@ static const struct mtk_eint_hw mt8183_eint_hw = {
 	.ports     = 6,
 	.ap_num    = 212,
 	.db_cnt    = 13,
+	.db_time   = debounce_time_mt6765,
 };
 
 static const struct mtk_pin_soc mt8183_data = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8186.c b/drivers/pinctrl/mediatek/pinctrl-mt8186.c
index a4dd5197abc1..a02f7c326970 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8186.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8186.c
@@ -1222,6 +1222,7 @@ static const struct mtk_eint_hw mt8186_eint_hw = {
 	.ports     = 7,
 	.ap_num    = 217,
 	.db_cnt    = 32,
+	.db_time   = debounce_time_mt6765,
 };
 
 static const struct mtk_pin_soc mt8186_data = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8188.c b/drivers/pinctrl/mediatek/pinctrl-mt8188.c
index d0e75c1b4417..6a3d0126288e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8188.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8188.c
@@ -1625,6 +1625,7 @@ static const struct mtk_eint_hw mt8188_eint_hw = {
 	.ports     = 7,
 	.ap_num    = 225,
 	.db_cnt    = 32,
+	.db_time   = debounce_time_mt6765,
 };
 
 static const struct mtk_pin_soc mt8188_data = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
index 78c02b7c81f0..9695f4ec6aba 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
@@ -1371,6 +1371,7 @@ static const struct mtk_eint_hw mt8192_eint_hw = {
 	.ports     = 7,
 	.ap_num    = 224,
 	.db_cnt    = 32,
+	.db_time   = debounce_time_mt6765,
 };
 
 static const struct mtk_pin_reg_calc mt8192_reg_cals[PINCTRL_PIN_REG_MAX] = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8195.c b/drivers/pinctrl/mediatek/pinctrl-mt8195.c
index 563693d3d4c2..89557c7ed2ab 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8195.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8195.c
@@ -935,6 +935,7 @@ static const struct mtk_eint_hw mt8195_eint_hw = {
 	.ports     = 7,
 	.ap_num    = 225,
 	.db_cnt    = 32,
+	.db_time   = debounce_time_mt6765,
 };
 
 static const struct mtk_pin_soc mt8195_data = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8365.c b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
index 57f37a294063..e31b89b226b7 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8365.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
@@ -453,6 +453,7 @@ static const struct mtk_pinctrl_devdata mt8365_pinctrl_data = {
 		.ports     = 5,
 		.ap_num = 160,
 		.db_cnt = 160,
+		.db_time   = debounce_time_mt6765,
 	},
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8516.c b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
index 939a1932b8dc..e929339dd2cb 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8516.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
@@ -319,6 +319,7 @@ static const struct mtk_pinctrl_devdata mt8516_pinctrl_data = {
 		.ports     = 6,
 		.ap_num    = 169,
 		.db_cnt    = 64,
+		.db_time   = debounce_time_mt6795,
 	},
 };
 
-- 
2.38.1

