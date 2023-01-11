Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60024665550
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAKHps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjAKHpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:45:43 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E19B7F3;
        Tue, 10 Jan 2023 23:45:37 -0800 (PST)
X-UUID: ec69c5da918311ed945fc101203acc17-20230111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1IcXxUlcMjL6OjiByHs+3U0DRKLrz/x/GXv70XJcADo=;
        b=q+KxuErKEDdXT0h122zyBa873ChK/ioOiaJy68Pm8xlAecLa/5zBZxQcIdXhz9+UeVHZhZfgu66t3BUYfmO8L8yiX/ftebFNKjn71FtXb1ZeTkSypbovCLXgErMAkA+GUwThdOXlZc9quVDJh4EQnU6u4tRVEOPVgBftmaBmAck=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:93a2a6e6-025c-4af0-81a6-d80df9c31ce7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:7e99ee8b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: ec69c5da918311ed945fc101203acc17-20230111
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2024602603; Wed, 11 Jan 2023 15:45:31 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 11 Jan 2023 15:45:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 11 Jan 2023 15:45:29 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
CC:     Fan Chen <fan.chen@mediatek.com>, Roger Lu <roger.lu@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 0/14] Enahance SVS's robustness
Date:   Wed, 11 Jan 2023 15:45:14 +0800
Message-ID: <20230111074528.29354-1-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SVS driver got accepted upstream but still has room to be improved.
Therefore, we add these patches to fix issues and coding style.

Change since v3:
- Remove cleanup codes in patch [01/14] for letting it backport easily
- Enclose svs debug cmd codes with "CONFIG_DEBUG_FS" where needed
- Reorder patch sequenece to put fix up patch first

Tested on:
MT8183 Platform (kernel v5.10)
MT8192 Platform (kernel v5.4)

Matthias Brugger (4):
  soc: mediatek: mtk-svs: clean up platform probing
  soc: mediatek: mtk-svs: improve readability of platform_probe
  soc: mediatek: mtk-svs: move svs_platform_probe into probe
  soc: mediatek: mtk-svs: delete superfluous platform data entries

Ricardo Ribalda (1):
  soc: mediatek: mtk-svs: enable the IRQ later

Roger Lu (8):
  soc: mediatek: mtk-svs: restore default voltages when svs_init02()
    fail
  soc: mediatek: mtk-svs: reset svs when svs_resume() fail
  soc: mediatek: mtk-svs: use svs clk control APIs
  soc: mediatek: mtk-svs: add thermal voltage compensation if needed
  soc: mediatek: mtk-svs: keep svs alive if CONFIG_DEBUG_FS not
    supported
  soc: mediatek: mtk-svs: use svs get efuse common function
  soc: mediatek: mtk-svs: use common function to disable restore
    voltages
  soc: mtk-svs: mt8183: refactor o_slope calculation

Shang XiaoJing (1):
  soc: mediatek: mtk-svs: Use pm_runtime_resume_and_get() in
    svs_init01()

 drivers/soc/mediatek/mtk-svs.c | 339 +++++++++++++++++----------------
 1 file changed, 173 insertions(+), 166 deletions(-)


