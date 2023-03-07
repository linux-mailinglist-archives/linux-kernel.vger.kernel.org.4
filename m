Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A905D6AD5F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCGEJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCGEJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:09:48 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D014034F54
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 20:09:45 -0800 (PST)
X-UUID: e2a71576bc9d11ed945fc101203acc17-20230307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DB2Uxt1RaCktv7zz4ekz5QzDi7zff0EFv7ICF/t918I=;
        b=giTpxcRhqeUDEp33iyl/SXAv0sT2tktJgpsi+2gn77uaNm7prHs35gwfC/y6QC27EbjgABCcQo2apOKL0gHIYIQQs9LbUKHQQAubxyT3fR8LtLg0yJAgzaPsW9Jwo2DDyKr3EMt2BBHgOq8Mi1XYTkL+1lveq7TvyeEZgAGH7js=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:eb08bc62-7fb9-41c7-860a-5466cb361409,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:edc46cb2-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: e2a71576bc9d11ed945fc101203acc17-20230307
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1508969569; Tue, 07 Mar 2023 12:09:41 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 7 Mar 2023 12:09:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 7 Mar 2023 12:09:40 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] ASoC: mediatek: fix coverity problems
Date:   Tue, 7 Mar 2023 12:09:34 +0800
Message-ID: <20230307040938.7484-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity reports some UNINIT and CERT STR31-C problems, so we add 
initialization and dai id check to resolve problems.

Trevor Wu (4):
  ASoC: mediatek: mt8195: add dai id check before accessing array
  ASoC: mediatek: mt9195-mt6359: fix UNINIT problem
  ASoC: mediatek: mt6358: fix UNINIT problem
  ASoC: mediatek: mt6359: fix UNINIT problem

 sound/soc/codecs/mt6358.c                   |   2 +-
 sound/soc/codecs/mt6359.c                   |   2 +-
 sound/soc/mediatek/mt8195/mt8195-dai-adda.c |  17 +-
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c | 177 +++++++++++++++++---
 sound/soc/mediatek/mt8195/mt8195-dai-pcm.c  |  26 ++-
 sound/soc/mediatek/mt8195/mt8195-mt6359.c   |   2 +-
 6 files changed, 188 insertions(+), 38 deletions(-)

-- 
2.18.0

