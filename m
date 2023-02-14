Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B216069618C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjBNK5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBNK5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:57:32 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828A359F6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:57:30 -0800 (PST)
X-UUID: 571bafbeac5611ed945fc101203acc17-20230214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=53j2Zr5g1CHI4OUeg0l8fF8afX2h7OOtLqGtKgBQpXk=;
        b=W62tWo/yU8G/rN4xWB1VWl5tJniJ0Y8IW562Q04flL1IHk+H0VnbkamOnjSyHKiajmBdRAdYbRLGVEnFC7n5EM2yz5Ev0IxuGZIWwoPWzhxbp/ltJQPTulFLNVC5r5HDTjj7z8RXjjREBTULy0KEJg2YiOm02NCl1oggUhdtItE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:f85f9659-e8b3-42f0-b9ba-497bc4a5b9c6,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:e01d8925-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 571bafbeac5611ed945fc101203acc17-20230214
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 337619719; Tue, 14 Feb 2023 18:57:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 14 Feb 2023 18:57:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 14 Feb 2023 18:57:13 +0800
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
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 2/4] clocksource/drivers/mmio: Export clocksource_mmio_init()
Date:   Tue, 14 Feb 2023 18:53:12 +0800
Message-ID: <20230214105412.5856-3-walter.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230214105412.5856-1-walter.chang@mediatek.com>
References: <20230214105412.5856-1-walter.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chun-Hung Wu <chun-hung.wu@mediatek.com>

Export clocksource_mmio_init() and clocksource_mmio_readl_up()
to support building clocksource driver as module,
such as timer-mediatek.c.

Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
---
 drivers/clocksource/mmio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/mmio.c b/drivers/clocksource/mmio.c
index 9de751531831..b08b2f9d7a8b 100644
--- a/drivers/clocksource/mmio.c
+++ b/drivers/clocksource/mmio.c
@@ -21,6 +21,7 @@ u64 clocksource_mmio_readl_up(struct clocksource *c)
 {
 	return (u64)readl_relaxed(to_mmio_clksrc(c)->reg);
 }
+EXPORT_SYMBOL_GPL(clocksource_mmio_readl_up);
 
 u64 clocksource_mmio_readl_down(struct clocksource *c)
 {
@@ -46,9 +47,9 @@ u64 clocksource_mmio_readw_down(struct clocksource *c)
  * @bits:	Number of valid bits
  * @read:	One of clocksource_mmio_read*() above
  */
-int __init clocksource_mmio_init(void __iomem *base, const char *name,
-	unsigned long hz, int rating, unsigned bits,
-	u64 (*read)(struct clocksource *))
+int clocksource_mmio_init(void __iomem *base, const char *name,
+			  unsigned long hz, int rating, unsigned bits,
+			  u64 (*read)(struct clocksource *))
 {
 	struct clocksource_mmio *cs;
 
@@ -68,3 +69,4 @@ int __init clocksource_mmio_init(void __iomem *base, const char *name,
 
 	return clocksource_register_hz(&cs->clksrc, hz);
 }
+EXPORT_SYMBOL_GPL(clocksource_mmio_init);
-- 
2.18.0

