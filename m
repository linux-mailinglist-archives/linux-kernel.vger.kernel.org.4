Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1AA71917C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjFADuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFADtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:49:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C642B2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 20:49:49 -0700 (PDT)
X-UUID: 573a886c002f11ee9cb5633481061a41-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=AZL/4U3dA33LvS8NGPtfm3QUWpx91cAARIW+EUNlpMc=;
        b=eqM0clQLpLZYDXLrZ/zaSBrKBlfymeufKJIlRwkQZq7jL8igxqH6tjKbE59xPo58hG+NFuOJ8JbSTEVAwziOzeVPBToBDSO722qq4Uk4/MNrabNYRx8D1hzQZ2IwRuHF8mx57MiWbDrvkRu7r2+Fx+1SeVT0CKpu4lvGlxBg7PM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:491095e7-a6a6-41d0-b7eb-ca3d30baaf35,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:884aa96d-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 573a886c002f11ee9cb5633481061a41-20230601
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1764586940; Thu, 01 Jun 2023 11:49:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 11:49:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 11:49:40 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <pierre-louis.bossart@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <daniel.baluta@nxp.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <yc.hung@mediatek.com>,
        <tinghan.shen@mediatek.com>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/1] ASoC: SOF: add mt8188 audio support
Date:   Thu, 1 Jun 2023 11:49:38 +0800
Message-ID: <20230601034939.15802-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds mt8188 audio support and dbg_dump callback for
mt8186 and mt8188.

Changes since v2:
  - resend the correct patch for adsp debug dump

Changes since v1:
  - fix typo
  - adopt reviewer's suggestion

Trevor Wu (1):
  ASoC: SOF: mediatek: add adsp debug dump

 sound/soc/sof/mediatek/mt8186/mt8186.c | 22 ++++++++++++++++++++++
 sound/soc/sof/mediatek/mt8186/mt8186.h |  5 +++++
 2 files changed, 27 insertions(+)

-- 
2.18.0

