Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2742F637B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKXORG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiKXOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:16:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83720FFAA4;
        Thu, 24 Nov 2022 06:16:19 -0800 (PST)
Date:   Thu, 24 Nov 2022 14:16:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669299377;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPM4GtgkPikyO8undmf32MjZA2sKaffe2O+gLIOF3sc=;
        b=SjjEg0E7f4JsemG0UMkRweLi+fsg+AMox6nVTViSGJEdZgxTXHbD5sBpOy66N2KpEn4PzB
        BtTfrfhCWFgan4P8J0iqMpXXZx2gZ7sOzslbw+bOQlsCX4vXydJrw/0PPfZ23nj1mDPHbN
        UjZdcXRRR7cwoxEPErfPmRKTXzVTydMk9rKMx4ZvxelCK5dKkcZFZWUNXPzuNSItAP1UhF
        fSO+E1eRt373Ogl0OgAuMo3r2Tp9ruKGVkUgIXMmwhpxErxScqaQbcRv6Zocts/Qvl4Pcp
        hyliQuVvNfr2S3mux0QcJ3cDB6al+LzkQZg81gaigBm5dJEdiOUaV96tIQJh9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669299377;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPM4GtgkPikyO8undmf32MjZA2sKaffe2O+gLIOF3sc=;
        b=3aaEAoecxa/t4n0BQgq/QvWvowA3PQZDSM7fNL947qYo+XMqodb7yr02s6lrZX8GN+Y7jX
        S7ux1EjQ9ffBpACw==
From:   "tip-bot2 for Steven Rostedt (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Do not use
 timer namespace for timer_shutdown() function
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221106212702.002251651@goodmis.org>
References: <20221106212702.002251651@goodmis.org>
MIME-Version: 1.0
Message-ID: <166929937647.4906.15326210430381406447.tip-bot2@tip-bot2>
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

Commit-ID:     73737a5833ace25a8408b0d3b783637cb6bf29d1
Gitweb:        https://git.kernel.org/tip/73737a5833ace25a8408b0d3b783637cb6bf29d1
Author:        Steven Rostedt (Google) <rostedt@goodmis.org>
AuthorDate:    Wed, 23 Nov 2022 21:18:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Nov 2022 15:09:10 +01:00

clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function

A new "shutdown" timer state is being added to the generic timer code. One
of the functions to change the timer into the state is called
"timer_shutdown()". This means that there can not be other functions
called "timer_shutdown()" as the timer code owns the "timer_*" name space.

Rename timer_shutdown() to arch_timer_shutdown() to avoid this conflict.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lkml.kernel.org/r/20221106212702.002251651@goodmis.org
Link: https://lore.kernel.org/all/20221105060155.409832154@goodmis.org/
Link: https://lore.kernel.org/r/20221110064146.981725531@goodmis.org
Link: https://lore.kernel.org/r/20221123201624.574672568@linutronix.de



---
 drivers/clocksource/arm_arch_timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index a7ff775..9c3420a 100644
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
