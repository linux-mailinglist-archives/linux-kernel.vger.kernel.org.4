Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632896EA271
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 05:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjDUDrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 23:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDUDrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 23:47:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB951FC0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 20:47:36 -0700 (PDT)
X-UUID: 3da494fedff711edb6b9f13eb10bd0fe-20230421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9fA4Q8Eu/7r79+HGr+WgcfxZUyDhzDjsfyrl60cGNPw=;
        b=Kn+c0UUocb5x4sQmKbZafj4CMN/YtG+1dGJO1uomfLVho/KPIgdMcWn6P+a7m2ptvA+m+KNymg5pVikkP4Lj6m3EYRVGkJPW8nP25wSeQoO8foqu9ZH26pVa0+GHdKcbf5ePd0v/l5GeDJZLnLItcZ7h8AuXknmaRfRXKp01P8w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:2f1a9738-c871-4ba4-a4f8-949559ec3d4e,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:2f1a9738-c871-4ba4-a4f8-949559ec3d4e,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:d8680ba2-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:230421114731BRI4OOTO,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 3da494fedff711edb6b9f13eb10bd0fe-20230421
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1517359952; Fri, 21 Apr 2023 11:47:30 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 21 Apr 2023 11:47:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 21 Apr 2023 11:47:28 +0800
From:   <walter.chang@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        John Stultz <jstultz@google.com>
CC:     <wsd_upstream@mediatek.com>, <stanley.chu@mediatek.com>,
        <Chun-hung.Wu@mediatek.com>, <Freddy.Hsin@mediatek.com>,
        <walter.chang@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH linux-next v4 0/4] Support timer drivers as loadable modules
Date:   Fri, 21 Apr 2023 11:46:45 +0800
Message-ID: <20230421034649.15247-1-walter.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Walter Chang <walter.chang@mediatek.com>

This set of patches aims to make SoC related timer drivers, such as 
timer-mediatek.c become loadable modules for the Generic Kernel Image
(GKI).

This driver registers an always-on timer as tick_broadcast_device on 
MediaTek SoCs. If the system does not load this module at startup, 
system will also boot normally by using built-in `bc_hrtimer` instead.
Besides, the previous experiment [1] indicates that the SYST/GPT, in 
combination with a loadable module, is fully operational.

The first three patches export functions and remove __init markings to 
support loadable timer modules.

The fourth patch makes timer-mediatek.c become loadable module for GKI.

[1]
https://lore.kernel.org/all/32777456f8e0f98e4cd5b950f421d21f71b149cf.camel@mediatek.com/#t

[v4]
- Fix review comments pointed by Angelo

[v3]
- Rebase on linux-next

[v2]
- Convert timer-mediatek.c driver to loadable module

Chun-Hung Wu (4):
  time/sched_clock: Export sched_clock_register()
  clocksource/drivers/mmio: Export clocksource_mmio_init()
  clocksource/drivers/timer-of: Remove __init markings
  clocksource/drivers/timer-mediatek: Make timer-mediatek become
    loadable module

 drivers/clocksource/Kconfig          |  2 +-
 drivers/clocksource/mmio.c           |  8 ++++---
 drivers/clocksource/timer-mediatek.c | 33 ++++++++++++++++++++++++++++
 drivers/clocksource/timer-of.c       | 23 +++++++++----------
 drivers/clocksource/timer-of.h       |  6 ++---
 kernel/time/sched_clock.c            |  4 ++--
 6 files changed, 56 insertions(+), 20 deletions(-)

-- 
2.18.0

