Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD59696188
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjBNKzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjBNKzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:55:40 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7F08A7E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:55:36 -0800 (PST)
X-UUID: 17ab8fc0ac5611ed945fc101203acc17-20230214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=c5SA0sygA99LkVl15NgxUnE+nHkoRfXhfOKbmDW6wQY=;
        b=oSXmPlPxJRpbhwEhpFizrzMlOKEN/4CqIv9rMJR/xsV9IObkMnA33QJv/0xPiqBkCAZJ5NTNMPgDtLOqoqQ4hCjdCYAV2Y+/H2rb8ydWfJgvOs19FV0tb/WUynFuU7Sy+AQGaD4/mYElqP1iEwIkq0OBdY4VxK8oRiLcuiQQg3U=;
X-CID-CACHE: Type:Local,Time:202302141855+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:88ba1e65-4c7d-4acf-99af-baa6c557dbad,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:481cf7f2-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 17ab8fc0ac5611ed945fc101203acc17-20230214
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 262891074; Tue, 14 Feb 2023 18:55:28 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 14 Feb 2023 18:55:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 14 Feb 2023 18:55:25 +0800
From:   <walter.chang@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        John Stultz <jstultz@google.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
CC:     <wsd_upstream@mediatek.com>, <stanley.chu@mediatek.com>,
        <Chun-hung.Wu@mediatek.com>, <Freddy.Hsin@mediatek.com>,
        Walter Chang <walter.chang@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 0/4] Support timer drivers as loadable modules
Date:   Tue, 14 Feb 2023 18:53:10 +0800
Message-ID: <20230214105412.5856-1-walter.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
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
system will also boot normally by using built-in architecture timer 
(in this case is Arm Generic Timer) instead.

The first three patches export functions and remove __init markings to 
support loadable timer modules.

The fourth patch makes timer-mediatek.c become loadable module for GKI.

[v2]
- Convert timer-mediatek.c driver to loadable module

Chun-Hung Wu (4):
  time/sched_clock: Export sched_clock_register()
  clocksource/drivers/mmio: Export clocksource_mmio_init()
  clocksource/drivers/timer-of: Remove __init markings
  clocksource/drivers/timer-mediatek: Make timer-mediatek become
    loadable module

 drivers/clocksource/Kconfig          |  2 +-
 drivers/clocksource/mmio.c           |  8 ++++--
 drivers/clocksource/timer-mediatek.c | 43 ++++++++++++++++++++++++++++
 drivers/clocksource/timer-of.c       | 23 ++++++++-------
 drivers/clocksource/timer-of.h       |  6 ++--
 kernel/time/sched_clock.c            |  4 +--
 6 files changed, 66 insertions(+), 20 deletions(-)

-- 
2.18.0

