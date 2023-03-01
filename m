Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7692B6A6B49
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCALCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCALCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:02:17 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F693B3E7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:02:10 -0800 (PST)
X-UUID: 7f5ade8eb82011eda06fc9ecc4dadd91-20230301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hEfAOvZJXLtdoX37aHyT09q7nlqO9HPu0KdVdJ5LDDc=;
        b=Zm+OPMeLf5MzQ5BuPcFdPCddPFkY1CYUugR67Rj5OyMJhkEdlx0kRa9rgot4uJ7dnbqbHD79dNO3kmyrcMGJc68o+7a0EVAO34UrDRZP5ECQLEwHtu4TPcxsR2vAwxJ7t4UwYcFhgE6rdpeqki20M6T2yF5gMNSQ4Wq65gwu1qY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:49b1b3a6-f03a-416f-9541-c0e64fc07ed3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.20,REQID:49b1b3a6-f03a-416f-9541-c0e64fc07ed3,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:25b5999,CLOUDID:8009deb1-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:2303011902059S38TP4B,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 7f5ade8eb82011eda06fc9ecc4dadd91-20230301
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1883867757; Wed, 01 Mar 2023 19:02:03 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 1 Mar 2023 19:02:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 1 Mar 2023 19:02:02 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] ASoC: mediatek: add missing initialization
Date:   Wed, 1 Mar 2023 19:01:58 +0800
Message-ID: <20230301110200.26177-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Fix dts parsing problem in mt8188 and mt8195 etdm dai drivers.

Changes since v1:
  - split the patch into two commits and add Fixes tag.

Trevor Wu (2):
  ASoC: mediatek: mt8188: add missing initialization
  ASoC: mediatek: mt8195: add missing initialization

 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c | 3 +++
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.18.0

