Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8993D60722B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJUI1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJUI1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:27:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F5B23641B;
        Fri, 21 Oct 2022 01:27:29 -0700 (PDT)
X-UUID: 46fea039c8eb4d4f8dd275eec3c8b095-20221021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mYPcs1IOe6NtCzuGcnog0KWdUa2jDExn9rUhH4BHCfo=;
        b=hXQFzaQArQdGNA0RRbR+werKr8Nb+3qnLa9HIz0ZxhYo1KDzyseQ45FXJM3H12BTuSg1/PRYqGZcmSVPJsMvStOAijAx//O2w+Bo+uJUTz+Jg7VKbmei/yL5/rpKhrJ2qQ/G9Z3Nr2FD4NBm8CMhhZZJQelawGRVeDEpu5rFf0U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:c574385b-98ff-4b77-b412-cfb1cfca9749,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:65f642c8-03ab-4171-989e-341ab5339257,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 46fea039c8eb4d4f8dd275eec3c8b095-20221021
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1690676347; Fri, 21 Oct 2022 16:27:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 21 Oct 2022 16:27:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 21 Oct 2022 16:27:24 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>
CC:     <trevor.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 01/12] ASoC: mediatek: common: add SMC ops and SMC CMD
Date:   Fri, 21 Oct 2022 16:27:08 +0800
Message-ID: <20221021082719.18325-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221021082719.18325-1-trevor.wu@mediatek.com>
References: <20221021082719.18325-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMC call is required to communicate with ATF for some secure operations,
so we add SMC ops IDs and SMC CMD ID to common header.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/common/mtk-base-afe.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/mediatek/common/mtk-base-afe.h b/sound/soc/mediatek/common/mtk-base-afe.h
index ef83e78c22a8..f51578b6c50a 100644
--- a/sound/soc/mediatek/common/mtk-base-afe.h
+++ b/sound/soc/mediatek/common/mtk-base-afe.h
@@ -9,7 +9,26 @@
 #ifndef _MTK_BASE_AFE_H_
 #define _MTK_BASE_AFE_H_
 
+#include <linux/soc/mediatek/mtk_sip_svc.h>
+
 #define MTK_STREAM_NUM (SNDRV_PCM_STREAM_LAST + 1)
+#define MTK_SIP_AUDIO_CONTROL MTK_SIP_SMC_CMD(0x517)
+
+/* SMC CALL Operations */
+enum mtk_audio_smc_call_op {
+	MTK_AUDIO_SMC_OP_INIT = 0,
+	MTK_AUDIO_SMC_OP_DRAM_REQUEST,
+	MTK_AUDIO_SMC_OP_DRAM_RELEASE,
+	MTK_AUDIO_SMC_OP_SRAM_REQUEST,
+	MTK_AUDIO_SMC_OP_SRAM_RELEASE,
+	MTK_AUDIO_SMC_OP_ADSP_REQUEST,
+	MTK_AUDIO_SMC_OP_ADSP_RELEASE,
+	MTK_AUDIO_SMC_OP_DOMAIN_SIDEBANDS,
+	MTK_AUDIO_SMC_OP_BTCVSD_WRITE,
+	MTK_AUDIO_SMC_OP_BTCVSD_UPDATE_CTRL_CLEAR,
+	MTK_AUDIO_SMC_OP_BTCVSD_UPDATE_CTRL_UNDERFLOW,
+	MTK_AUDIO_SMC_OP_NUM
+};
 
 struct mtk_base_memif_data {
 	int id;
-- 
2.18.0

