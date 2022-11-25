Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637CA638675
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKYJog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiKYJo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:44:28 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB2263D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:44:26 -0800 (PST)
X-UUID: bacdaa27b4764b6eab6e6b8029f02a0b-20221125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ViGNiKiDlpdTwQms22X0e/YbhcaMRLoQ4ODpbxaV73U=;
        b=Nk1868Hcgm4Sga+1ga5TWD8mgqbGNFuaB+9VgtOxMoS0flBMK/6EB8jURuDUtVvhSRdk0q2GlCYbDjtFIliWz6hnAuN22WNVa4szQfY54yRoUkua9P9/OpujD28QjSWG6bgkmmFj0W4KFeYT6R1ztPGax6tacy/kznQsVfjwong=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.14,REQID:c6786ccd-b2fa-4eea-af45-1140bcce76df,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:28,RULE:Spam_GS6885AD,AC
        TION:quarantine,TS:118
X-CID-INFO: VERSION:1.1.14,REQID:c6786ccd-b2fa-4eea-af45-1140bcce76df,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:118
X-CID-META: VersionHash:dcaaed0,CLOUDID:b9843ddc-6ad4-42ff-91f3-18e0272db660,B
        ulkID:221124165445AUVM93DU,BulkQuantity:8,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:41|20,QS:nil,BEC:nil,COL:0
X-UUID: bacdaa27b4764b6eab6e6b8029f02a0b-20221125
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 631387422; Fri, 25 Nov 2022 17:44:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 25 Nov 2022 17:44:17 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 25 Nov 2022 17:44:16 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <robert.foss@linaro.org>,
        <Laurent.pinchart@ideasonboard.com>,
        <kuninori.morimoto.gx@renesas.com>,
        <angelogioacchino.delregno@collabora.com>,
        <nfraprado@collabora.com>
CC:     <chunxu.li@mediatek.com>,
        <ajye_huang@compal.corp-partner.google.com>,
        <allen-kh.cheng@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH v2 2/3] ASoC: mediatek: mt8186: correct the HDMI widgets
Date:   Fri, 25 Nov 2022 17:44:12 +0800
Message-ID: <20221125094413.4940-3-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125094413.4940-1-jiaxin.yu@mediatek.com>
References: <20221125094413.4940-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SND_SOC_DAPM_LINE instead of SND_SOC_DAPM_OUTPUT to trigger
DAPM events to hdmi-codec when userspace control the DPAM pin.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c | 2 +-
 sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
index d8c93d66b4e6..f4960b0c8298 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
@@ -965,7 +965,7 @@ mt8186_mt6366_da7219_max98357_widgets[] = {
 	SND_SOC_DAPM_SPK("Speakers", NULL),
 	SND_SOC_DAPM_HP("Headphones", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_OUTPUT("HDMI1"),
+	SND_SOC_DAPM_LINE("HDMI1", NULL),
 	SND_SOC_DAPM_MIXER(SOF_DMA_DL1, SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER(SOF_DMA_DL2, SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER(SOF_DMA_UL1, SND_SOC_NOPM, 0, 0, NULL, 0),
diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
index e59d92e2afa3..c61e9bb419d4 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
@@ -1033,7 +1033,7 @@ mt8186_mt6366_rt1019_rt5682s_widgets[] = {
 	SND_SOC_DAPM_SPK("Speakers", NULL),
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_OUTPUT("HDMI1"),
+	SND_SOC_DAPM_LINE("HDMI1", NULL),
 	SND_SOC_DAPM_MIXER(SOF_DMA_DL1, SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER(SOF_DMA_DL2, SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER(SOF_DMA_UL1, SND_SOC_NOPM, 0, 0, NULL, 0),
-- 
2.18.0

