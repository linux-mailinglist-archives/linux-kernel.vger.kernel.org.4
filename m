Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D4E5BAE57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiIPNiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiIPNii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:38:38 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D655AD993
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:38:31 -0700 (PDT)
X-UUID: 3c5e513d455341108e71528621dc34f0-20220916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=//32S1i46vXVRy+d0zvrACix42xN5G/83NKutSBPkE8=;
        b=WF+qMb9NQ3nk/GfQ4gLnS9j1JpfdqEnVY+EaPLrn86JZRkrMzM/N89txDMcEyUmX6YoAcUvfg8eoZHehDeTi5dvTh8ZpdSUo3SZH1OmxMTzWyxmAoyzdHitgafIpP4fxfbmTI4xaDhzJP6BaSY3mBIpDMIQQ4AwaK8Mt/Z2YPa0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:aba5fa93-a516-4317-9101-b7e19cb507b1,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.11,REQID:aba5fa93-a516-4317-9101-b7e19cb507b1,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:39a5ff1,CLOUDID:2996aaf6-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:2209162138263WOOHPZ9,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: 3c5e513d455341108e71528621dc34f0-20220916
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1849799012; Fri, 16 Sep 2022 21:38:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 16 Sep 2022 21:38:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 16 Sep 2022 21:38:23 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>
CC:     <matthias.bgg@gmail.com>, <granquet@baylibre.com>,
        <daniel@ffwll.ch>, <jitao.shi@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>, <ck.hu@mediatek.com>,
        <liangxu.xu@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v2 3/3] drm/mediatek: dp: Fix warning in mtk_dp_video_mute()
Date:   Fri, 16 Sep 2022 21:38:21 +0800
Message-ID: <20220916133821.27980-4-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220916133821.27980-1-rex-bc.chen@mediatek.com>
References: <20220916133821.27980-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Warning:
../drivers/gpu/drm/mediatek/mtk_dp.c: In function ‘mtk_dp_video_mute’:
../drivers/gpu/drm/mediatek/mtk_dp.c:947:23: warning: format ‘%x’
expects argument of type ‘unsigned int’, but argument 4 has type ‘long
unsigned int’ [-Wformat=]
  947 |  dev_dbg(mtk_dp->dev, "smc cmd: 0x%x, p1: 0x%x, ret: 0x%lx-0x%lx\n",
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../include/linux/dev_printk.h:129:27: note: in definition of macro ‘dev_printk’
  129 |   _dev_printk(level, dev, fmt, ##__VA_ARGS__);  \
      |                           ^~~
../include/linux/dev_printk.h:163:31: note: in expansion of macro ‘dev_fmt’
  163 |   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
      |                               ^~~~~~~
../drivers/gpu/drm/mediatek/mtk_dp.c:947:2: note: in expansion of
macro ‘dev_dbg’
  947 |  dev_dbg(mtk_dp->dev, "smc cmd: 0x%x, p1: 0x%x, ret: 0x%lx-0x%lx\n",
      |  ^~~~~~~
../drivers/gpu/drm/mediatek/mtk_dp.c:947:36: note: format string is defined here
  947 |  dev_dbg(mtk_dp->dev, "smc cmd: 0x%x, p1: 0x%x, ret: 0x%lx-0x%lx\n",
      |                                   ~^
      |                                    |
      |                                    unsigned int
      |                                   %lx

To fix this issue, we use %s to replace 0x%x.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Reported-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index c72c646e25e9..d58e98b2f83a 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1222,8 +1222,8 @@ static void mtk_dp_video_mute(struct mtk_dp *mtk_dp, bool enable)
 		      mtk_dp->data->smc_cmd, enable,
 		      0, 0, 0, 0, 0, &res);
 
-	dev_dbg(mtk_dp->dev, "smc cmd: 0x%x, p1: 0x%x, ret: 0x%lx-0x%lx\n",
-		mtk_dp->data->smc_cmd, enable, res.a0, res.a1);
+	dev_dbg(mtk_dp->dev, "smc cmd: 0x%x, p1: %s, ret: 0x%lx-0x%lx\n",
+		mtk_dp->data->smc_cmd, enable ? "enable" : "disable", res.a0, res.a1);
 }
 
 static void mtk_dp_audio_mute(struct mtk_dp *mtk_dp, bool mute)
-- 
2.18.0

