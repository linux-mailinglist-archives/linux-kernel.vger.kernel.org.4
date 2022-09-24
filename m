Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41D55E87FE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 05:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiIXDge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 23:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiIXDgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 23:36:19 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C2D137911
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 20:36:12 -0700 (PDT)
X-UUID: c90b1d76824e4bdaa769bae01677227b-20220924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hIQ4mUx+Rp+E2H2Xc+2URnzvQPQLSU49LU5vAQg5gU4=;
        b=IyMe534NRYAo7OtW6kKXXYR6pe5h9g11Pg/frj2KJ0b3ho33YSjTFrxJMhJC31QSTKZNjMFMNn2fYqdIXJncLL7HSaW86aT2InUDQwbaBT97qZtWLYKgvpm67FxMgn3fZI0OAhzJiknVWvNf23Rj4yQRoEictdKglbw8sd6m6aA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:8e917797-9935-40d1-8e0d-59d06e258870,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.11,REQID:8e917797-9935-40d1-8e0d-59d06e258870,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:39a5ff1,CLOUDID:dfd4d906-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:2209241136087SI94QT7,BulkQuantity:2,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:43,QS:nil,BEC:ni
        l,COL:0
X-UUID: c90b1d76824e4bdaa769bae01677227b-20220924
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunxu.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 13614035; Sat, 24 Sep 2022 11:36:06 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 24 Sep 2022 11:36:05 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 24 Sep 2022 11:36:04 +0800
From:   Chunxu Li <chunxu.li@mediatek.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>, <lgirdwood@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <daniel.baluta@nxp.com>
CC:     <matthias.bgg@gmail.com>, <yc.hung@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <sound-open-firmware@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <project_global_chrome_upstream_group@mediatek.com>,
        Chunxu Li <chunxu.li@mediatek.com>
Subject: [PATCH 1/2] ASoC: SOF: mediatek: mt8195: Add pcm_hw_params callback
Date:   Sat, 24 Sep 2022 11:35:58 +0800
Message-ID: <20220924033559.26599-2-chunxu.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220924033559.26599-1-chunxu.li@mediatek.com>
References: <20220924033559.26599-1-chunxu.li@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pcm_hw_params callback for mt8195 to support continue
update dma host position

Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index c12192c8a6f8..882fde741cf5 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -496,6 +496,16 @@ static int mt8195_get_bar_index(struct snd_sof_dev *sdev, u32 type)
 	return type;
 }
 
+static int mt8195_pcm_hw_params(struct snd_sof_dev *sdev,
+				struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_sof_platform_stream_params *platform_params)
+{
+	platform_params->cont_update_posn = 1;
+
+	return 0;
+}
+
 static void mt8195_adsp_dump(struct snd_sof_dev *sdev, u32 flags)
 {
 	u32 dbg_pc, dbg_data, dbg_bus0, dbg_bus1, dbg_inst;
@@ -588,6 +598,7 @@ static struct snd_sof_dsp_ops sof_mt8195_ops = {
 
 	/* stream callbacks */
 	.pcm_open	= sof_stream_pcm_open,
+	.pcm_hw_params	= mt8195_pcm_hw_params,
 	.pcm_close	= sof_stream_pcm_close,
 
 	/* firmware loading */
-- 
2.25.1

