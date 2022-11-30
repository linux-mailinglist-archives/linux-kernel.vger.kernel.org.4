Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617F863E278
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiK3VGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiK3VGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:06:17 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5917E8567C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=fGeB69K7vNARYHE0In4LF63NiK5
        kwstZrsX34GY+rdk=; b=kAdoHXP80t5vkovt2TGBxsygkqzEDU1YkLJaaum+lJc
        oh99WCCdtWLlr8kWyNrFy8lMIKe0+tMKDI/xnmY+uYb1YdMygwdrYBFR0cCPwmwM
        eaK+RlPgO7k6iXawtGHJ3ZVVJlTaA7d1yeNlplrpz9RkZoQUN9lLOdHsQ2PYsVXQ
        =
Received: (qmail 200442 invoked from network); 30 Nov 2022 22:06:11 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Nov 2022 22:06:11 +0100
X-UD-Smtp-Session: l3s3148p1@Ejdlebbu/OYgAQnoAHGJAMsVZOhAgWYe
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers/sh_cmt: access registers according to spec
Date:   Wed, 30 Nov 2022 22:06:09 +0100
Message-Id: <20221130210609.7718-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for most CMTs say that we need to wait two input clocks
before changes propagate to the timer. This is especially relevant when
we stop the timer to change further settings. Implement the delays
according to the spec. To avoid unnecessary delays in atomic mode, we
also check if the to-be-written value actually differs. CMCNT is a bit
special because testing showed that we need to wait 3 cycles instead.
AFAIU, this is also true for all CMTs. Also, the WRFLAG needs to be
checked before writing. This fixes "cannot clear CMCNT" messages which
occur often on R-Car Gen4 SoCs, but only very rarely on older SoCs for
some reason.

Fixes: 81b3b2711072 ("clocksource: sh_cmt: Add support for multiple channels per device")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since RFC v2:
* use DIV_ROUND_UP also for caluclating cmcnt_delay
* remove a FIXME comment

There were no further comments, so I dropped the RFC status and send
this as a regular patch. Here again the introduction from RFC v1:

With this patch, I can run the 'clocksource-switch' test (from the Linux
selftests) without any warnings printed on the Spider S4 and the Ebisu
E3 board. Both printed the warnings before, the Spider immediately, the
Ebisu rarely but still. The price for this correctness is that the tests
run much longer due to the udelays in atomic mode. However, I consider
the massive switching a corner case. Usually, one switches rarely so the
extra delay is worth the correctness IMHO.

Happy hacking,

   Wolfram


 drivers/clocksource/sh_cmt.c | 88 ++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 33 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 64dcb082d4cf..7b952aa52c0b 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -116,6 +117,7 @@ struct sh_cmt_device {
 	void __iomem *mapbase;
 	struct clk *clk;
 	unsigned long rate;
+	unsigned int reg_delay;
 
 	raw_spinlock_t lock; /* Protect the shared start/stop register */
 
@@ -247,10 +249,17 @@ static inline u32 sh_cmt_read_cmstr(struct sh_cmt_channel *ch)
 
 static inline void sh_cmt_write_cmstr(struct sh_cmt_channel *ch, u32 value)
 {
-	if (ch->iostart)
-		ch->cmt->info->write_control(ch->iostart, 0, value);
-	else
-		ch->cmt->info->write_control(ch->cmt->mapbase, 0, value);
+	u32 old_value = sh_cmt_read_cmstr(ch);
+
+	if (value != old_value) {
+		if (ch->iostart) {
+			ch->cmt->info->write_control(ch->iostart, 0, value);
+			udelay(ch->cmt->reg_delay);
+		} else {
+			ch->cmt->info->write_control(ch->cmt->mapbase, 0, value);
+			udelay(ch->cmt->reg_delay);
+		}
+	}
 }
 
 static inline u32 sh_cmt_read_cmcsr(struct sh_cmt_channel *ch)
@@ -260,7 +269,12 @@ static inline u32 sh_cmt_read_cmcsr(struct sh_cmt_channel *ch)
 
 static inline void sh_cmt_write_cmcsr(struct sh_cmt_channel *ch, u32 value)
 {
-	ch->cmt->info->write_control(ch->ioctrl, CMCSR, value);
+	u32 old_value = sh_cmt_read_cmcsr(ch);
+
+	if (value != old_value) {
+		ch->cmt->info->write_control(ch->ioctrl, CMCSR, value);
+		udelay(ch->cmt->reg_delay);
+	}
 }
 
 static inline u32 sh_cmt_read_cmcnt(struct sh_cmt_channel *ch)
@@ -268,14 +282,33 @@ static inline u32 sh_cmt_read_cmcnt(struct sh_cmt_channel *ch)
 	return ch->cmt->info->read_count(ch->ioctrl, CMCNT);
 }
 
-static inline void sh_cmt_write_cmcnt(struct sh_cmt_channel *ch, u32 value)
+static inline int sh_cmt_write_cmcnt(struct sh_cmt_channel *ch, u32 value)
 {
+	/* Tests showed that we need to wait 3 clocks here */
+	unsigned int cmcnt_delay = DIV_ROUND_UP(3 * ch->cmt->reg_delay, 2);
+	u32 reg;
+
+	if (ch->cmt->info->model > SH_CMT_16BIT) {
+		int ret = read_poll_timeout_atomic(sh_cmt_read_cmcsr, reg,
+						   !(reg & SH_CMT32_CMCSR_WRFLG),
+						   1, cmcnt_delay, false, ch);
+		if (ret < 0)
+			return ret;
+	}
+
 	ch->cmt->info->write_count(ch->ioctrl, CMCNT, value);
+	udelay(cmcnt_delay);
+	return 0;
 }
 
 static inline void sh_cmt_write_cmcor(struct sh_cmt_channel *ch, u32 value)
 {
-	ch->cmt->info->write_count(ch->ioctrl, CMCOR, value);
+	u32 old_value = ch->cmt->info->read_count(ch->ioctrl, CMCOR);
+
+	if (value != old_value) {
+		ch->cmt->info->write_count(ch->ioctrl, CMCOR, value);
+		udelay(ch->cmt->reg_delay);
+	}
 }
 
 static u32 sh_cmt_get_counter(struct sh_cmt_channel *ch, u32 *has_wrapped)
@@ -319,7 +352,7 @@ static void sh_cmt_start_stop_ch(struct sh_cmt_channel *ch, int start)
 
 static int sh_cmt_enable(struct sh_cmt_channel *ch)
 {
-	int k, ret;
+	int ret;
 
 	dev_pm_syscore_device(&ch->cmt->pdev->dev, true);
 
@@ -347,26 +380,9 @@ static int sh_cmt_enable(struct sh_cmt_channel *ch)
 	}
 
 	sh_cmt_write_cmcor(ch, 0xffffffff);
-	sh_cmt_write_cmcnt(ch, 0);
-
-	/*
-	 * According to the sh73a0 user's manual, as CMCNT can be operated
-	 * only by the RCLK (Pseudo 32 kHz), there's one restriction on
-	 * modifying CMCNT register; two RCLK cycles are necessary before
-	 * this register is either read or any modification of the value
-	 * it holds is reflected in the LSI's actual operation.
-	 *
-	 * While at it, we're supposed to clear out the CMCNT as of this
-	 * moment, so make sure it's processed properly here.  This will
-	 * take RCLKx2 at maximum.
-	 */
-	for (k = 0; k < 100; k++) {
-		if (!sh_cmt_read_cmcnt(ch))
-			break;
-		udelay(1);
-	}
+	ret = sh_cmt_write_cmcnt(ch, 0);
 
-	if (sh_cmt_read_cmcnt(ch)) {
+	if (ret || sh_cmt_read_cmcnt(ch)) {
 		dev_err(&ch->cmt->pdev->dev, "ch%u: cannot clear CMCNT\n",
 			ch->index);
 		ret = -ETIMEDOUT;
@@ -995,8 +1011,8 @@ MODULE_DEVICE_TABLE(of, sh_cmt_of_table);
 
 static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
 {
-	unsigned int mask;
-	unsigned int i;
+	unsigned int mask, i;
+	unsigned long rate;
 	int ret;
 
 	cmt->pdev = pdev;
@@ -1032,10 +1048,16 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
 	if (ret < 0)
 		goto err_clk_unprepare;
 
-	if (cmt->info->width == 16)
-		cmt->rate = clk_get_rate(cmt->clk) / 512;
-	else
-		cmt->rate = clk_get_rate(cmt->clk) / 8;
+	rate = clk_get_rate(cmt->clk);
+	if (!rate) {
+		ret = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	/* We shall wait 2 input clks after register writes */
+	if (cmt->info->model >= SH_CMT_48BIT)
+		cmt->reg_delay = DIV_ROUND_UP(2UL * USEC_PER_SEC, rate);
+	cmt->rate = rate / (cmt->info->width == 16 ? 512 : 8);
 
 	/* Map the memory resource(s). */
 	ret = sh_cmt_map_memory(cmt);
-- 
2.35.1

