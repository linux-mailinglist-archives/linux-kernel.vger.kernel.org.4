Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1321761E06A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 06:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiKFFqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 01:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiKFFqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 01:46:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61337A18C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 22:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D072EB80989
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 05:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C939C43145;
        Sun,  6 Nov 2022 05:46:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1orYUa-007nCA-2t;
        Sun, 06 Nov 2022 01:46:48 -0400
Message-ID: <20221106054648.735411273@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 06 Nov 2022 01:45:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v5a 3/5] clocksource/drivers/sp804: Do not use timer namespace for
 timer_shutdown() function
References: <20221106054535.709068702@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

A new "shutdown" timer state is being added to the generic timer code. One
of the functions to change the timer into the state is called
"timer_shutdown()". This means that there can not be other functions
called "timer_shutdown()" as the timer code owns the "timer_*" name space.

Rename timer_shutdown() to evt_timer_shutdown() to avoid this conflict.

Link: https://lore.kernel.org/all/20221105060155.592778858@goodmis.org/

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/clocksource/timer-sp804.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index e6a87f4af2b5..cd1916c05325 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -155,14 +155,14 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static inline void timer_shutdown(struct clock_event_device *evt)
+static inline void evt_timer_shutdown(struct clock_event_device *evt)
 {
 	writel(0, common_clkevt->ctrl);
 }
 
 static int sp804_shutdown(struct clock_event_device *evt)
 {
-	timer_shutdown(evt);
+	evt_timer_shutdown(evt);
 	return 0;
 }
 
@@ -171,7 +171,7 @@ static int sp804_set_periodic(struct clock_event_device *evt)
 	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
 			     TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
 
-	timer_shutdown(evt);
+	evt_timer_shutdown(evt);
 	writel(common_clkevt->reload, common_clkevt->load);
 	writel(ctrl, common_clkevt->ctrl);
 	return 0;
-- 
2.35.1
