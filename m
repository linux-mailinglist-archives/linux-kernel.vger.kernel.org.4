Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7D66E744F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjDSHtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjDSHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:49:48 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFAC10E0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:49:45 -0700 (PDT)
X-UUID: bcc03b52de8611eda9a90f0bb45854f4-20230419
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kV0J1/FM+1iF9G81TOXk0JsrKpONZFmg5K8V55ImZCc=;
        b=QQSw9JL9NdPf0Y9tBuMgpDH3KDXX1M/N/0PqGsr9KXEEx1oAzUzfyau+zHDnGdQhJtIIRWIEIZFa3HsOorfl1ZYxNhiU8waXPyS89d/pTM2sVbpY1PW9dAk5gfEmUmexNjYvWQpgXARTxqmbtF42nKMHV4/V8NbD42uwgyNXdHg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:0ac8bd2d-b731-4886-b550-720e4261af16,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:a3419084-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: bcc03b52de8611eda9a90f0bb45854f4-20230419
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1288790781; Wed, 19 Apr 2023 15:49:39 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 19 Apr 2023 15:49:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 19 Apr 2023 15:49:37 +0800
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
        <walter.chang@mediatek.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH linux-next v3 1/4] time/sched_clock: Export sched_clock_register()
Date:   Wed, 19 Apr 2023 15:49:05 +0800
Message-ID: <20230419074910.10809-2-walter.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230419074910.10809-1-walter.chang@mediatek.com>
References: <20230419074910.10809-1-walter.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chun-Hung Wu <chun-hung.wu@mediatek.com>

clocksource driver may use sched_clock_register()
to resigter itself as a sched_clock source.
Export it to support building such driver
as module, like timer-mediatek.c

Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
---
 kernel/time/sched_clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 8464c5acc913..8e49e87d1221 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -150,8 +150,7 @@ static enum hrtimer_restart sched_clock_poll(struct hrtimer *hrt)
 	return HRTIMER_RESTART;
 }
 
-void __init
-sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
+void sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 {
 	u64 res, wrap, new_mask, new_epoch, cyc, ns;
 	u32 new_mult, new_shift;
@@ -223,6 +222,7 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 
 	pr_debug("Registered %pS as sched_clock source\n", read);
 }
+EXPORT_SYMBOL_GPL(sched_clock_register);
 
 void __init generic_sched_clock_init(void)
 {
-- 
2.18.0

