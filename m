Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75EB6E7450
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjDSHtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjDSHtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:49:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6814597
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:49:39 -0700 (PDT)
X-UUID: b98f450ede8611eda9a90f0bb45854f4-20230419
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+O0WO7yYI7mQhiZ8rqGJznJVC6zAde9t8Thengpd4qE=;
        b=Mlbbi9Vitq1m2gEqVaFuLVaY8GRnimASFRUUm3TbOfdebT4nTa5fkNgNw/MQV+HXT35GV666TBOEQzAm+J/zAe3IAm5I/baasxRUW0wyIMSJUFR+ukexmEa243lfHVtjZINqWaTbwwKlWTjPSaGOm4HFsW2wBOHbHcjv1SZALcY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:b89faa77-7d2c-4854-925d-f6c6b286bf1d,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:f7409084-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b98f450ede8611eda9a90f0bb45854f4-20230419
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1809981656; Wed, 19 Apr 2023 15:49:33 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 19 Apr 2023 15:49:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 19 Apr 2023 15:49:32 +0800
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
Subject: [PATCH linux-next v3 0/4] Support timer drivers as loadable modules
Date:   Wed, 19 Apr 2023 15:49:04 +0800
Message-ID: <20230419074910.10809-1-walter.chang@mediatek.com>
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

[1] https://lore.kernel.org/all/32777456f8e0f98e4cd5b950f421d21f71b149cf.camel@mediatek.com/#t

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
 drivers/clocksource/mmio.c           |  8 +++---
 drivers/clocksource/timer-mediatek.c | 39 ++++++++++++++++++++++++++++
 drivers/clocksource/timer-of.c       | 23 ++++++++--------
 drivers/clocksource/timer-of.h       |  6 ++---
 kernel/time/sched_clock.c            |  4 +--
 6 files changed, 62 insertions(+), 20 deletions(-)

-- 
2.18.0

