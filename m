Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5805870F101
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbjEXId2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbjEXIcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:32:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124B7195
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:32:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1q1juc-0002su-6B; Wed, 24 May 2023 10:32:02 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1q1jub-002Ram-4N; Wed, 24 May 2023 10:32:01 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1q1juX-009jEs-13; Wed, 24 May 2023 10:31:57 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v5 15/25] PM / devfreq: rockchip-dfi: give variable a better name
Date:   Wed, 24 May 2023 10:31:43 +0200
Message-Id: <20230524083153.2046084-16-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524083153.2046084-1-s.hauer@pengutronix.de>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct dmc_count_channel::total counts the clock cycles of the DDR
controller. Rename it accordingly to give the reader a better idea
what this is about. While at it, at some documentation to struct
dmc_count_channel.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/devfreq/event/rockchip-dfi.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 8a7af7c32ae0d..50e497455dc69 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -46,9 +46,14 @@
 #define DDRMON_CH1_COUNT_NUM		0x3c
 #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
 
+/**
+ * struct dmc_count_channel - structure to hold counter values from the DDR controller
+ * @access:       Number of read and write accesses
+ * @clock_cycles: DDR clock cycles
+ */
 struct dmc_count_channel {
 	u32 access;
-	u32 total;
+	u32 clock_cycles;
 };
 
 struct dmc_count {
@@ -150,7 +155,7 @@ static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_coun
 			continue;
 		count->c[i].access = readl_relaxed(dfi_regs +
 				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
-		count->c[i].total = readl_relaxed(dfi_regs +
+		count->c[i].clock_cycles = readl_relaxed(dfi_regs +
 				DDRMON_CH0_COUNT_NUM + i * 20);
 	}
 }
@@ -182,29 +187,29 @@ static int rockchip_dfi_get_event(struct devfreq_event_dev *edev,
 	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
 	struct dmc_count count;
 	struct dmc_count *last = &dfi->last_event_count;
-	u32 access = 0, total = 0;
+	u32 access = 0, clock_cycles = 0;
 	int i;
 
 	rockchip_dfi_read_counters(dfi, &count);
 
 	/* We can only report one channel, so find the busiest one */
 	for (i = 0; i < DMC_MAX_CHANNELS; i++) {
-		u32 a, t;
+		u32 a, c;
 
 		if (!(dfi->channel_mask & BIT(i)))
 			continue;
 
 		a = count.c[i].access - last->c[i].access;
-		t = count.c[i].total - last->c[i].total;
+		c = count.c[i].clock_cycles - last->c[i].clock_cycles;
 
 		if (a > access) {
 			access = a;
-			total = t;
+			clock_cycles = c;
 		}
 	}
 
 	edata->load_count = access * 4;
-	edata->total_count = total;
+	edata->total_count = clock_cycles;
 
 	dfi->last_event_count = count;
 
-- 
2.39.2

