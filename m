Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D374665E6B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjAEIS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjAEIRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:17:32 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B255A8B4;
        Thu,  5 Jan 2023 00:16:44 -0800 (PST)
X-UUID: f84a76709cac4fe58ce5d09bd5ca5e2a-20230105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QsXVaBlLyZgLe3Omky45vD7Ia8dAb9dNk+EXoNiFXQE=;
        b=EzSv6VLTq38BlG6Xa9zJvnGg+osImP5MgLFGWw4gxN0Vf1nE715mHLmxjVzh5fk9sBgAQaGuqwRY2C+/aQxCATvH8giZLA/Q0vI8ke4au1NpZFiLOJWze5A2vhOIO+3j0rZO0ep8uUIMKYTNlG2KHwoMzXflAgqhXCHXTD58EL8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:325c84ec-9f07-48b1-b61e-6d138f47913f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.17,REQID:325c84ec-9f07-48b1-b61e-6d138f47913f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:543e81c,CLOUDID:fd2eb953-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230105161620SEYMO38N,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: f84a76709cac4fe58ce5d09bd5ca5e2a-20230105
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1343025869; Thu, 05 Jan 2023 16:16:18 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 5 Jan 2023 16:16:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 5 Jan 2023 16:16:16 +0800
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
Subject: [PATCH v5 11/13] ASoC: mediatek: common: add soundcard driver common code
Date:   Thu, 5 Jan 2023 16:16:04 +0800
Message-ID: <20230105081606.6582-12-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230105081606.6582-1-trevor.wu@mediatek.com>
References: <20230105081606.6582-1-trevor.wu@mediatek.com>
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

Add common code to support of_node of codec parsing, so codec phandle
can be assigned by sound-dai in dts.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/common/Makefile            |  2 +-
 .../mediatek/common/mtk-soundcard-driver.c    | 79 +++++++++++++++++++
 .../mediatek/common/mtk-soundcard-driver.h    | 14 ++++
 3 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/mediatek/common/mtk-soundcard-driver.c
 create mode 100644 sound/soc/mediatek/common/mtk-soundcard-driver.h

diff --git a/sound/soc/mediatek/common/Makefile b/sound/soc/mediatek/common/Makefile
index 576deb7f8cce..42e636c10c1e 100644
--- a/sound/soc/mediatek/common/Makefile
+++ b/sound/soc/mediatek/common/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # platform driver
-snd-soc-mtk-common-objs := mtk-afe-platform-driver.o mtk-afe-fe-dai.o mtk-dsp-sof-common.o
+snd-soc-mtk-common-objs := mtk-afe-platform-driver.o mtk-afe-fe-dai.o mtk-dsp-sof-common.o mtk-soundcard-driver.o
 obj-$(CONFIG_SND_SOC_MEDIATEK) += snd-soc-mtk-common.o
 
 obj-$(CONFIG_SND_SOC_MTK_BTCVSD) += mtk-btcvsd.o
diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.c b/sound/soc/mediatek/common/mtk-soundcard-driver.c
new file mode 100644
index 000000000000..7c55c2cb1f21
--- /dev/null
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mtk-soundcard-driver.c  --  MediaTek soundcard driver common
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Trevor Wu <trevor.wu@mediatek.com>
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <sound/soc.h>
+
+#include "mtk-soundcard-driver.h"
+
+static int set_card_codec_info(struct snd_soc_card *card,
+			       struct device_node *sub_node,
+			       struct snd_soc_dai_link *dai_link)
+{
+	struct device *dev = card->dev;
+	struct device_node *codec_node;
+	int ret;
+
+	codec_node = of_get_child_by_name(sub_node, "codec");
+	if (!codec_node)
+		return -EINVAL;
+
+	/* set card codec info */
+	ret = snd_soc_of_get_dai_link_codecs(dev, codec_node, dai_link);
+
+	of_node_put(codec_node);
+
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "%s: codec dai not found\n",
+				     dai_link->name);
+
+	return 0;
+}
+
+int parse_dai_link_info(struct snd_soc_card *card)
+{
+	struct device *dev = card->dev;
+	struct device_node *sub_node;
+	struct snd_soc_dai_link *dai_link;
+	const char *dai_link_name;
+	int ret, i;
+
+	/* Loop over all the dai link sub nodes */
+	for_each_available_child_of_node(dev->of_node, sub_node) {
+		if (of_property_read_string(sub_node, "link-name",
+					    &dai_link_name))
+			return -EINVAL;
+
+		for_each_card_prelinks(card, i, dai_link) {
+			if (!strcmp(dai_link_name, dai_link->name))
+				break;
+		}
+
+		if (i >= card->num_links)
+			return -EINVAL;
+
+		ret = set_card_codec_info(card, sub_node, dai_link);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(parse_dai_link_info);
+
+void clean_card_reference(struct snd_soc_card *card)
+{
+	struct snd_soc_dai_link *dai_link;
+	int i;
+
+	/* release codec reference gotten by set_card_codec_info */
+	for_each_card_prelinks(card, i, dai_link)
+		snd_soc_of_put_dai_link_codecs(dai_link);
+}
+EXPORT_SYMBOL_GPL(clean_card_reference);
diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.h b/sound/soc/mediatek/common/mtk-soundcard-driver.h
new file mode 100644
index 000000000000..d92cac1d7b72
--- /dev/null
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mtk-soundcard-driver.h  --  MediaTek soundcard driver common definition
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Trevor Wu <trevor.wu@mediatek.com>
+ */
+
+#ifndef _MTK_SOUNDCARD_DRIVER_H_
+#define _MTK_SOUNDCARD_DRIVER_H_
+
+int parse_dai_link_info(struct snd_soc_card *card);
+void clean_card_reference(struct snd_soc_card *card);
+#endif
-- 
2.18.0

