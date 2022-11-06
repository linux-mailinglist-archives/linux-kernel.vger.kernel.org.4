Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AAB61E79B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 00:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiKFXeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 18:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiKFXeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 18:34:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A88D117
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 15:34:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A26360DFB
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 23:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9658BC43470;
        Sun,  6 Nov 2022 23:34:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1orp9u-008UPY-0i;
        Sun, 06 Nov 2022 18:34:34 -0500
Message-ID: <20221106233434.059512224@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 06 Nov 2022 18:30:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>
Subject: [for-linus][PATCH 2/5] clocksource/drivers/arm_arch_timer: Do not use timer namespace for
 timer_shutdown() function
References: <20221106233037.815236769@goodmis.org>
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

Rename timer_shutdown() to arch_timer_shutdown() to avoid this conflict.

Link: https://lkml.kernel.org/r/20221106212702.002251651@goodmis.org
Link: https://lore.kernel.org/all/20221105060155.409832154@goodmis.org/

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/clocksource/arm_arch_timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index a7ff77550e17..9c3420a0d19d 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -687,8 +687,8 @@ static irqreturn_t arch_timer_handler_virt_mem(int irq, void *dev_id)
 	return timer_handler(ARCH_TIMER_MEM_VIRT_ACCESS, evt);
 }
 
-static __always_inline int timer_shutdown(const int access,
-					  struct clock_event_device *clk)
+static __always_inline int arch_timer_shutdown(const int access,
+					       struct clock_event_device *clk)
 {
 	unsigned long ctrl;
 
@@ -701,22 +701,22 @@ static __always_inline int timer_shutdown(const int access,
 
 static int arch_timer_shutdown_virt(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_phys(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_virt_mem(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_phys_mem(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
 }
 
 static __always_inline void set_next_event(const int access, unsigned long evt,
-- 
2.35.1
