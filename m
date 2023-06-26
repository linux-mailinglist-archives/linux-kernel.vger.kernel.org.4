Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F3073D5E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjFZCgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjFZCgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:36:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6695F10C6;
        Sun, 25 Jun 2023 19:35:36 -0700 (PDT)
X-UUID: 1e0f399e13ca11eeb20a276fd37b9834-20230626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wnjl5yaKC0oV4FudiXEwd8pFPQGS9Pkhlv469Vk/tDE=;
        b=IArIkbT54+OA95p/FxkDQG6Hul7c3FU6wv69iz3a7L9HHFCxoIb8t3kUMmoYbsHC0RI29ZGNTQcijnWBqNoGguOkVF4MwQDHJFddBdKlc0C36lLcSDbAfMT24p5b1YBLpe4pAqJT1pX8OYSZ1xJ8CMo+g8eZ+ExxIA1GKsI52Zs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:11f4377d-ac4c-4bff-816a-43e3b24119cf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.27,REQID:11f4377d-ac4c-4bff-816a-43e3b24119cf,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:01c9525,CLOUDID:e2761470-2f20-4998-991c-3b78627e4938,B
        ulkID:230626103531PV9Z8MKQ,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_SNR
X-UUID: 1e0f399e13ca11eeb20a276fd37b9834-20230626
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 381454555; Mon, 26 Jun 2023 10:35:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 10:35:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 26 Jun 2023 10:35:29 +0800
From:   Maso Huang <maso.huang@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Maso Huang <maso.huang@mediatek.com>
Subject: [PATCH v2 2/7] ASoC: mediatek: mt7986: support audio clock control
Date:   Mon, 26 Jun 2023 10:34:56 +0800
Message-ID: <20230626023501.11120-3-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230626023501.11120-1-maso.huang@mediatek.com>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio clock wrapper and audio tuner control.

Signed-off-by: Maso Huang <maso.huang@mediatek.com>
---
 sound/soc/mediatek/mt7986/mt7986-afe-clk.c | 75 ++++++++++++++++++++++
 sound/soc/mediatek/mt7986/mt7986-afe-clk.h | 18 ++++++
 2 files changed, 93 insertions(+)
 create mode 100644 sound/soc/mediatek/mt7986/mt7986-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt7986/mt7986-afe-clk.h

diff --git a/sound/soc/mediatek/mt7986/mt7986-afe-clk.c b/sound/soc/mediatek/mt7986/mt7986-afe-clk.c
new file mode 100644
index 000000000000..a8b5fae05673
--- /dev/null
+++ b/sound/soc/mediatek/mt7986/mt7986-afe-clk.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mt7986-afe-clk.c  --  MediaTek 7986 afe clock ctrl
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Vic Wu <vic.wu@mediatek.com>
+ *         Maso Huang <maso.huang@mediatek.com>
+ */
+
+#include <linux/clk.h>
+
+#include "mt7986-afe-common.h"
+#include "mt7986-afe-clk.h"
+#include "mt7986-reg.h"
+
+enum {
+	CK_INFRA_AUD_BUS_CK = 0,
+	CK_INFRA_AUD_26M_CK,
+	CK_INFRA_AUD_L_CK,
+	CK_INFRA_AUD_AUD_CK,
+	CK_INFRA_AUD_EG2_CK,
+	CLK_NUM
+};
+
+static const char *aud_clks[CLK_NUM] = {
+	[CK_INFRA_AUD_BUS_CK] = "aud_bus_ck",
+	[CK_INFRA_AUD_26M_CK] = "aud_26m_ck",
+	[CK_INFRA_AUD_L_CK] = "aud_l_ck",
+	[CK_INFRA_AUD_AUD_CK] = "aud_aud_ck",
+	[CK_INFRA_AUD_EG2_CK] = "aud_eg2_ck",
+};
+
+int mt7986_init_clock(struct mtk_base_afe *afe)
+{
+	struct mt7986_afe_private *afe_priv = afe->platform_priv;
+	int ret, i;
+
+	afe_priv->clks = devm_kcalloc(afe->dev, CLK_NUM,
+				sizeof(*afe_priv->clks), GFP_KERNEL);
+	if (!afe_priv->clks)
+		return -ENOMEM;
+	afe_priv->num_clks = CLK_NUM;
+
+	for (i = 0; i < afe_priv->num_clks; i++)
+		afe_priv->clks[i].id = aud_clks[i];
+
+	ret = devm_clk_bulk_get(afe->dev, afe_priv->num_clks, afe_priv->clks);
+	if (ret)
+		return dev_err_probe(afe->dev, ret, "Failed to get clocks\n");
+
+	return 0;
+}
+
+int mt7986_afe_enable_clock(struct mtk_base_afe *afe)
+{
+	struct mt7986_afe_private *afe_priv = afe->platform_priv;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(afe_priv->num_clks, afe_priv->clks);
+	if (ret)
+		return dev_err_probe(afe->dev, ret, "Failed to enable clocks\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7986_afe_enable_clock);
+
+int mt7986_afe_disable_clock(struct mtk_base_afe *afe)
+{
+	struct mt7986_afe_private *afe_priv = afe->platform_priv;
+
+	clk_bulk_disable_unprepare(afe_priv->num_clks, afe_priv->clks);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7986_afe_disable_clock);
diff --git a/sound/soc/mediatek/mt7986/mt7986-afe-clk.h b/sound/soc/mediatek/mt7986/mt7986-afe-clk.h
new file mode 100644
index 000000000000..2f15b7a54bdc
--- /dev/null
+++ b/sound/soc/mediatek/mt7986/mt7986-afe-clk.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mt7986-afe-clk.h  --  MediaTek 7986 afe clock ctrl definition
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Vic Wu <vic.wu@mediatek.com>
+ *         Maso Huang <maso.huang@mediatek.com>
+ */
+
+#ifndef _MT7986_AFE_CLK_H_
+#define _MT7986_AFE_CLK_H_
+
+struct mtk_base_afe;
+
+int mt7986_init_clock(struct mtk_base_afe *afe);
+int mt7986_afe_enable_clock(struct mtk_base_afe *afe);
+int mt7986_afe_disable_clock(struct mtk_base_afe *afe);
+#endif
-- 
2.18.0

