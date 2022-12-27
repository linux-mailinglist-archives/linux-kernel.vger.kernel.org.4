Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54043656A98
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiL0MJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiL0MJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:09:30 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E52C2D7;
        Tue, 27 Dec 2022 04:09:25 -0800 (PST)
X-UUID: aee440c3112d4fd3890a3a25bfbc1400-20221227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=m8+6n1e6RQmmFLnT3yJSrxkphZnpo8Y8/MUK4VmiN4E=;
        b=s+pAjSW3N4cgqEx+6c7udRkOaNgOfY9bVuzG6oFLUzf45WV61ZcXaNVwlBp4hfnVmv36rLN/p2M8jeaWVU4U//Ck9s/S/36ZlrA7mTvhDhqajLqoR8ETJ8lYxw/OwdIIQl7BXJiEALDmBBO+WVpKNoD7NfHeK8FUbU1c2ZkuCto=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:848857ac-7e35-4a31-8b72-de367fdba419,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:e59bee52-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: aee440c3112d4fd3890a3a25bfbc1400-20221227
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 696239125; Tue, 27 Dec 2022 20:09:18 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 27 Dec 2022 20:09:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 27 Dec 2022 20:09:17 +0800
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
Subject: [PATCH v2 0/13] Enhance SVS's robustness
Date:   Tue, 27 Dec 2022 20:09:01 +0800
Message-ID: <20221227120914.11346-1-roger.lu@mediatek.com>
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

SVS driver got accepted upstream but still has room to be improved.
Therefore, we add these patches to fix issues and coding style.

Change since v1:
- Reorder patch for helping readness
- Re-write patch [9/13] to fix the corner case issue
- Remove redundant codes in patch [13/13]

Matthias Brugger (4):
  soc: mediatek: mtk-svs: clean up platform probing
  soc: mediatek: mtk-svs: improve readability of platform_probe
  soc: mediatek: mtk-svs: move svs_platform_probe into probe
  soc: mediatek: mtk-svs: delete superfluous platform data entries

Ricardo Ribalda (1):
  soc: mediatek: mtk-svs: enable the IRQ later

Roger Lu (7):
  soc: mtk-svs: mt8183: refactor o_slope calculation
  soc: mediatek: mtk-svs: use svs get efuse common function
  soc: mediatek: mtk-svs: use svs clk control APIs
  soc: mediatek: mtk-svs: use common function to disable restore
    voltages
  soc: mediatek: mtk-svs: restore default voltages when svs_init02()
    fail
  soc: mediatek: mtk-svs: add thermal voltage compensation if needed
  soc: mediatek: mtk-svs: keep svs alive even though debug cmd create
    fail

Shang XiaoJing (1):
  soc: mediatek: mtk-svs: Use pm_runtime_resume_and_get() in
    svs_init01()

 drivers/soc/mediatek/mtk-svs.c | 341 ++++++++++++++++-----------------
 1 file changed, 167 insertions(+), 174 deletions(-)


