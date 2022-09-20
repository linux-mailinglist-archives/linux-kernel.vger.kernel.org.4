Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1753E5BE3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiITK4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiITK4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:56:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF186AA3F;
        Tue, 20 Sep 2022 03:56:28 -0700 (PDT)
X-UUID: a33a205bfce642fd864d6ff02e468282-20220920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=KiwPmbDD1MhVA6n6KkWt9LbHMoM8EQb6aIvzu6stn04=;
        b=PbVWBAikhUyI6gCikolaSz4t5fipeHG0hodD3wtHms18riQXGwvfjFbnUew1uy2VOB//f5t/vEdX6yazJrFRVDUt0cU09YvX15FQ+FLMwMCRxHGXaM1Q9hnd2eA0TootKoCO8Ev5XSl+Zpn1fQqTIqydDO7+5j+U8Rtgfaj0CrE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:fb96a03c-a984-4173-83d4-cc0f9515745b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.11,REQID:fb96a03c-a984-4173-83d4-cc0f9515745b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:39a5ff1,CLOUDID:534c08f7-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:220920185626JNN68HXU,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0
X-UUID: a33a205bfce642fd864d6ff02e468282-20220920
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <runyang.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 412915204; Tue, 20 Sep 2022 18:56:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 20 Sep 2022 18:56:25 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 20 Sep 2022 18:56:24 +0800
From:   Runyang Chen <Runyang.Chen@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <nfraprado@collabora.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Runyang Chen <runyang.chen@mediatek.com>
Subject: [PATCH v3 0/3] Add watchdog support for MT8188 Soc
Date:   Tue, 20 Sep 2022 18:56:19 +0800
Message-ID: <20220920105622.25666-1-Runyang.Chen@mediatek.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Runyang Chen <runyang.chen@mediatek.com>

Based on tag: next-20220919, linux-next/master

Refer to the discussion in the link:
https://patchwork.kernel.org/project/linux-mediatek/patch/20220721014845.19044-2-allen-kh.cheng@mediatek.com/
The other wdt compatible strings are unchanged.So, won't apply the
series above

v3:
Rebase on 6.0-rc5 and add reviewed-by and acked-by tag.

v2:
Revert wdt compatible for MT8188.

v1:
1. Add mt8188-resets.h to define definition of reset bits.
2. Add wdt compatible for MT8188.*

Runyang Chen (3):
  dt-bindings: watchdog: Add compatible for MediaTek MT8188
  dt-bindings: reset: mt8188: add toprgu reset-controller header file
  watchdog: mediatek: mt8188: add wdt support

 .../devicetree/bindings/watchdog/mtk-wdt.txt  |  1 +
 drivers/watchdog/mtk_wdt.c                    |  6 ++++
 include/dt-bindings/reset/mt8188-resets.h     | 36 +++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 include/dt-bindings/reset/mt8188-resets.h


base-commit: 4c9ca5b1597e3222177ba2a94658f78fa5ef4f58
-- 
2.18.0

