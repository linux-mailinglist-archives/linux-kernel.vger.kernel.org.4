Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7EA72C269
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbjFLLFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238895AbjFLLF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:05:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF18A268;
        Mon, 12 Jun 2023 03:53:38 -0700 (PDT)
X-UUID: 5f9d85d4090f11ee9cb5633481061a41-20230612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=aZY/OvmVIfR/+U1CwVj1hHp8VX+qCtSh3oDVJZZeK0E=;
        b=QcgmvK/1G5I/CvY6FL16EkbRkMlz9XwiAjjsKcxhpk8IWofoq2xYvFMxTSofz0nL5ToxXzmKuDdQEAfYFSBk0LGO6f2jhc6k1WCX8BDdibBfxlW3NHngutmBdipLN6fz57LuVQeDkdAYMiJn4NZqfb38SIX2k1z9whx+90jFisQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:4d8b9c73-4ef7-4fd5-a9e8-16fd97839352,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.26,REQID:4d8b9c73-4ef7-4fd5-a9e8-16fd97839352,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:cb9a4e1,CLOUDID:126ace6e-2f20-4998-991c-3b78627e4938,B
        ulkID:2306121853338KRXL2OK,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 5f9d85d4090f11ee9cb5633481061a41-20230612
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1520647404; Mon, 12 Jun 2023 18:53:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Jun 2023 18:53:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 12 Jun 2023 18:53:32 +0800
From:   Maso Hunag <maso.huang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Maso Huang <maso.huang@mediatek.com>
Subject: [PATCH 2/7] ASoC: mediatek: mt79xx: support audio clock control
Date:   Mon, 12 Jun 2023 18:52:45 +0800
Message-ID: <20230612105250.15441-3-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230612105250.15441-1-maso.huang@mediatek.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maso Huang <maso.huang@mediatek.com>

Add audio clock wrapper and audio tuner control.

Signed-off-by: Maso Huang <maso.huang@mediatek.com>
---
 sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c | 123 +++++++++++++++++++++
 sound/soc/mediatek/mt79xx/mt79xx-afe-clk.h |  18 +++
 2 files changed, 141 insertions(+)
 create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-afe-clk.h

diff --git a/sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c b/sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c
new file mode 100644
index 000000000000..f00f0d7de861
--- /dev/null
+++ b/sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mt79xx-afe-clk.c  --  MediaTek 79xx afe clock ctrl
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Vic Wu <vic.wu@mediatek.com>
+ *         Maso Huang <maso.huang@mediatek.com>
+ */
+
+#include <linux/clk.h>
+
+#include "mt79xx-afe-common.h"
+#include "mt79xx-afe-clk.h"
+#include "mt79xx-reg.h"
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
+int mt79xx_init_clock(struct mtk_base_afe *afe)
+{
+	struct mt79xx_afe_private *afe_priv = afe->platform_priv;
+	int i;
+
+	afe_priv->clk = devm_kcalloc(afe->dev, CLK_NUM, sizeof(*afe_priv->clk),
+				     GFP_KERNEL);
+	if (!afe_priv->clk)
+		return -ENOMEM;
+
+	for (i = 0; i < CLK_NUM; i++) {
+		afe_priv->clk[i] = devm_clk_get(afe->dev, aud_clks[i]);
+		if (IS_ERR(afe_priv->clk[i])) {
+			dev_err(afe->dev, "%s(), devm_clk_get %s fail,
+				ret %ld\n", __func__, aud_clks[i],
+				PTR_ERR(afe_priv->clk[i]));
+			return PTR_ERR(afe_priv->clk[i]);
+		}
+	}
+
+	return 0;
+}
+
+int mt79xx_afe_enable_clock(struct mtk_base_afe *afe)
+{
+	struct mt79xx_afe_private *afe_priv = afe->platform_priv;
+	int ret;
+
+	ret = clk_prepare_enable(afe_priv->clk[CK_INFRA_AUD_BUS_CK]);
+	if (ret) {
+		dev_err(afe->dev, "%s(), clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CK_INFRA_AUD_BUS_CK], ret);
+		goto CK_INFRA_AUD_BUS_CK_ERR;
+	}
+
+	ret = clk_prepare_enable(afe_priv->clk[CK_INFRA_AUD_26M_CK]);
+	if (ret) {
+		dev_err(afe->dev, "%s(), clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CK_INFRA_AUD_26M_CK], ret);
+		goto CK_INFRA_AUD_26M_ERR;
+	}
+
+	ret = clk_prepare_enable(afe_priv->clk[CK_INFRA_AUD_L_CK]);
+	if (ret) {
+		dev_err(afe->dev, "%s(), clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CK_INFRA_AUD_L_CK], ret);
+		goto CK_INFRA_AUD_L_CK_ERR;
+	}
+
+	ret = clk_prepare_enable(afe_priv->clk[CK_INFRA_AUD_AUD_CK]);
+	if (ret) {
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CK_INFRA_AUD_AUD_CK], ret);
+		goto CK_INFRA_AUD_AUD_CK_ERR;
+	}
+
+	ret = clk_prepare_enable(afe_priv->clk[CK_INFRA_AUD_EG2_CK]);
+	if (ret) {
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CK_INFRA_AUD_EG2_CK], ret);
+		goto CK_INFRA_AUD_EG2_CK_ERR;
+	}
+
+	return 0;
+
+CK_INFRA_AUD_EG2_CK_ERR:
+	clk_disable_unprepare(afe_priv->clk[CK_INFRA_AUD_AUD_CK]);
+CK_INFRA_AUD_AUD_CK_ERR:
+	clk_disable_unprepare(afe_priv->clk[CK_INFRA_AUD_L_CK]);
+CK_INFRA_AUD_L_CK_ERR:
+	clk_disable_unprepare(afe_priv->clk[CK_INFRA_AUD_26M_CK]);
+CK_INFRA_AUD_26M_ERR:
+	clk_disable_unprepare(afe_priv->clk[CK_INFRA_AUD_BUS_CK]);
+CK_INFRA_AUD_BUS_CK_ERR:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt79xx_afe_enable_clock);
+
+int mt79xx_afe_disable_clock(struct mtk_base_afe *afe)
+{
+	struct mt79xx_afe_private *afe_priv = afe->platform_priv;
+
+	clk_disable_unprepare(afe_priv->clk[CK_INFRA_AUD_EG2_CK]);
+	clk_disable_unprepare(afe_priv->clk[CK_INFRA_AUD_AUD_CK]);
+	clk_disable_unprepare(afe_priv->clk[CK_INFRA_AUD_L_CK]);
+	clk_disable_unprepare(afe_priv->clk[CK_INFRA_AUD_26M_CK]);
+	clk_disable_unprepare(afe_priv->clk[CK_INFRA_AUD_BUS_CK]);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt79xx_afe_disable_clock);
diff --git a/sound/soc/mediatek/mt79xx/mt79xx-afe-clk.h b/sound/soc/mediatek/mt79xx/mt79xx-afe-clk.h
new file mode 100644
index 000000000000..bf9c3edb6922
--- /dev/null
+++ b/sound/soc/mediatek/mt79xx/mt79xx-afe-clk.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mt79xx-afe-clk.h  --  MediaTek 79xx afe clock ctrl definition
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Vic Wu <vic.wu@mediatek.com>
+ *         Maso Huang <maso.huang@mediatek.com>
+ */
+
+#ifndef _MT79XX_AFE_CLK_H_
+#define _MT79XX_AFE_CLK_H_
+
+struct mtk_base_afe;
+
+int mt79xx_init_clock(struct mtk_base_afe *afe);
+int mt79xx_afe_enable_clock(struct mtk_base_afe *afe);
+int mt79xx_afe_disable_clock(struct mtk_base_afe *afe);
+#endif
-- 
2.18.0

