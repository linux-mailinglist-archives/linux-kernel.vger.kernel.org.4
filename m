Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A983637B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiKXORJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiKXOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:16:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5336EFAE95;
        Thu, 24 Nov 2022 06:16:20 -0800 (PST)
Date:   Thu, 24 Nov 2022 14:16:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669299378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p9nhhOC0dmoguyhyQWVzllAlYJbOLqoahHX54fy0N1U=;
        b=sKwSzXc4wVjHB6HsXJtnmOVZzBz1HMrcMneALJw/J3W94LyENbe/NotcKSMt1Gs7K/lrhS
        4sSs0h2kBWB6BZPQ6DEL+4IyCbG4zFJpHcM5+PF1x/uH02/+KX4yYa2/Fs//W3l/e44KJe
        8KSb641i1aIIUMaG9fJMKteqdWnIBcd+0lixlbLcXeMVNpoR8jENXq0QTTzKnG5oaj3WfX
        uVdcJg8BOvC3QJgJxvHpQgf1WI+hWp5UFkarWARjuRksEr9O8qQ5Jd3JsAOtXYj9gpYTYA
        uI4x9tA/rkP39nZ1G7P/OwjboZz6kXKetEzP0J4BxNoWUUVR0i1zVv2KMSXZXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669299378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p9nhhOC0dmoguyhyQWVzllAlYJbOLqoahHX54fy0N1U=;
        b=M1E7mvJBTCVp2MhQv+qcy1B8J5oVCgWSPTgIR6H2kdJzxN3Y27qkAodaBIthhG9NRDMSjj
        5YwMkB7KOBjVN8Dg==
From:   "tip-bot2 for Steven Rostedt (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ARM: spear: Do not use timer namespace for
 timer_shutdown() function
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221106212701.822440504@goodmis.org>
References: <20221106212701.822440504@goodmis.org>
MIME-Version: 1.0
Message-ID: <166929937763.4906.10502292339325011964.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     80b55772d41d8afec68dbc4ff0368a9fe5d1f390
Gitweb:        https://git.kernel.org/tip/80b55772d41d8afec68dbc4ff0368a9fe5d1f390
Author:        Steven Rostedt (Google) <rostedt@goodmis.org>
AuthorDate:    Wed, 23 Nov 2022 21:18:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Nov 2022 15:09:10 +01:00

ARM: spear: Do not use timer namespace for timer_shutdown() function

A new "shutdown" timer state is being added to the generic timer code. One
of the functions to change the timer into the state is called
"timer_shutdown()". This means that there can not be other functions called
"timer_shutdown()" as the timer code owns the "timer_*" name space.

Rename timer_shutdown() to spear_timer_shutdown() to avoid this conflict.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lkml.kernel.org/r/20221106212701.822440504@goodmis.org
Link: https://lore.kernel.org/all/20221105060155.228348078@goodmis.org/
Link: https://lore.kernel.org/r/20221110064146.810953418@goodmis.org
Link: https://lore.kernel.org/r/20221123201624.513863211@linutronix.de

---
 arch/arm/mach-spear/time.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index e979e21..5371c82 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -90,7 +90,7 @@ static void __init spear_clocksource_init(void)
 		200, 16, clocksource_mmio_readw_up);
 }
 
-static inline void timer_shutdown(struct clock_event_device *evt)
+static inline void spear_timer_shutdown(struct clock_event_device *evt)
 {
 	u16 val = readw(gpt_base + CR(CLKEVT));
 
@@ -101,7 +101,7 @@ static inline void timer_shutdown(struct clock_event_device *evt)
 
 static int spear_shutdown(struct clock_event_device *evt)
 {
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	return 0;
 }
@@ -111,7 +111,7 @@ static int spear_set_oneshot(struct clock_event_device *evt)
 	u16 val;
 
 	/* stop the timer */
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	val = readw(gpt_base + CR(CLKEVT));
 	val |= CTRL_ONE_SHOT;
@@ -126,7 +126,7 @@ static int spear_set_periodic(struct clock_event_device *evt)
 	u16 val;
 
 	/* stop the timer */
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	period = clk_get_rate(gpt_clk) / HZ;
 	period >>= CTRL_PRESCALER16;
