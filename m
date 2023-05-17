Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4CB706725
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjEQLwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjEQLwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:52:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13931421A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:52:29 -0700 (PDT)
X-UUID: 48604eeef4a911edb20a276fd37b9834-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EUCXX3qywTmH1/iTn+Vhans2ufli5Vw7rjPGGMD4pM0=;
        b=iiIwG5y1fQM/wo/UR4SD81cMILUd+ZDD6rhc9+pA52HrPUXIErd6zhrs7+mJTRqA1FcRMeQnTMwy8GIZJtK3AFsDdH2PC4eOsgSnT7YCz+zgqm1zlGotjuYV0443fyAaoHC9pQRwaxmZ/l4H2abj5lHf4u1JQEo3zDmMF5cvkAo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:341178e7-a829-4762-9531-ce3da29a6fd5,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.25,REQID:341178e7-a829-4762-9531-ce3da29a6fd5,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:d5b0ae3,CLOUDID:e4ca1e6c-2f20-4998-991c-3b78627e4938,B
        ulkID:230517195224OD070BA2,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 48604eeef4a911edb20a276fd37b9834-20230517
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1759731671; Wed, 17 May 2023 19:52:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 19:52:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 19:52:20 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <bicycle.tsai@mediatek.com>,
        <ting-fang.hou@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RESEND 3/4] ASoC: mediatek: mt6359: add mtkaif gpio setting
Date:   Wed, 17 May 2023 19:52:18 +0800
Message-ID: <20230517115219.532-4-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230517115219.532-1-trevor.wu@mediatek.com>
References: <20230517115219.532-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mtkaif gpio driving to increase signal strength and smt setting to
prevent from overshooting.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/codecs/mt6359.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index 65e6d4d08b6a..a37ad61a8253 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -18,6 +18,20 @@
 
 #include "mt6359.h"
 
+static void mt6359_set_gpio_smt(struct mt6359_priv *priv)
+{
+	/* set gpio SMT mode */
+	regmap_update_bits(priv->regmap, MT6359_SMT_CON1, 0x3ff0, 0x3ff0);
+}
+
+static void mt6359_set_gpio_driving(struct mt6359_priv *priv)
+{
+	/* 8:4mA(default), a:8mA, c:12mA, e:16mA */
+	regmap_update_bits(priv->regmap, MT6359_DRV_CON2, 0xffff, 0x8888);
+	regmap_update_bits(priv->regmap, MT6359_DRV_CON3, 0xffff, 0x8888);
+	regmap_update_bits(priv->regmap, MT6359_DRV_CON4, 0x00ff, 0x88);
+}
+
 static void mt6359_set_playback_gpio(struct mt6359_priv *priv)
 {
 	/* set gpio mosi mode, clk / data mosi */
@@ -2745,6 +2759,8 @@ static int mt6359_codec_init_reg(struct snd_soc_component *cmpnt)
 			   0x1 << RG_AUDLOLSCDISABLE_VAUDP32_SFT);
 
 	/* set gpio */
+	mt6359_set_gpio_smt(priv);
+	mt6359_set_gpio_driving(priv);
 	mt6359_reset_playback_gpio(priv);
 	mt6359_reset_capture_gpio(priv);
 
-- 
2.18.0

