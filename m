Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC61689971
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjBCNG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjBCNGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:06:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B7C3B640
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 05:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675429575; x=1706965575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z5KTL4EaTIbo9QWWW/1WpQc0bvQTdKHy2Kuwm2BBH5Q=;
  b=jKAblgYA56AuhDWgVTK2x/PseB6pxHNn2nxYw6VFdCeQigui6pX2msxl
   RHNycYL1qupFMI1gUXIUb6Y2T1bxUCZY+HoXZBV0UfRpa5BD1ort8oUuY
   znvb4cJrICPY5lZK6TEw4/reXzWlPVY5FAeZMeY/Y2QgInXXPMyoEJx9U
   O+QM87OOcf5D1m+AJX8Lklg07IEaP4DefU5InASiH2GT46IwyihtQcdXQ
   EiOvOSF3lp6eg1W8p7UP85PbjSly5Q3cjuBFfB0h5L80Rkd5k8OJwmURM
   kL5nIkfmOfp8sWk4sw3FkTUE/q/mHEc4Cz/xljIE1OXDmHSZrGwVImDlg
   g==;
X-IronPort-AV: E=Sophos;i="5.97,270,1669100400"; 
   d="scan'208";a="210478770"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Feb 2023 06:06:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 06:06:16 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 06:06:14 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/2] clocksource/drivers/timer-microchip-pit64b: add delay timer
Date:   Fri, 3 Feb 2023 15:05:37 +0200
Message-ID: <20230203130537.1921608-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203130537.1921608-1-claudiu.beznea@microchip.com>
References: <20230203130537.1921608-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add delay timer.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/timer-microchip-pit64b.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index d5f1436f33d9..57209bb38c70 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk.h>
 #include <linux/clockchips.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -92,6 +93,8 @@ struct mchp_pit64b_clksrc {
 static void __iomem *mchp_pit64b_cs_base;
 /* Default cycles for clockevent timer. */
 static u64 mchp_pit64b_ce_cycles;
+/* Delay timer. */
+static struct delay_timer mchp_pit64b_dt;
 
 static inline u64 mchp_pit64b_cnt_read(void __iomem *base)
 {
@@ -169,6 +172,11 @@ static u64 notrace mchp_pit64b_sched_read_clk(void)
 	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
 }
 
+static unsigned long notrace mchp_pit64b_dt_read(void)
+{
+	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
+}
+
 static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
@@ -376,6 +384,10 @@ static int __init mchp_pit64b_init_clksrc(struct mchp_pit64b_timer *timer,
 
 	sched_clock_register(mchp_pit64b_sched_read_clk, 64, clk_rate);
 
+	mchp_pit64b_dt.read_current_timer = mchp_pit64b_dt_read;
+	mchp_pit64b_dt.freq = clk_rate;
+	register_current_timer_delay(&mchp_pit64b_dt);
+
 	return 0;
 }
 
-- 
2.34.1

