Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5556A89E8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjCBT6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCBT5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6AA4743A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:50 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ukjcgr8xBhy+g3OZs13uetHsjpUVZC4eHKa1M+r91I=;
        b=HRhjUOhkaz87s/S228utMAWOjOX7FX/XBqnyxw9Bux9d/cig1aDf5yJMr0p+mk1ysQcQgt
        kMkxq30KNB2XnDG8LUhTyGDmMi57b1J7H6XDH+n1yRivsxyfO0CK7dLFLuaj+3jHSfGPSF
        5vxtaoPWz6YIUF+LBhCSe7q4DBqUoNr5UlnfeJg2iLMf4Q9/iRRROb7dlDOmKuYw7Zdty/
        fSrcUARLWJ26OulLCfpUIxkxoR9xaeglM0N/Ap1d3KCD5UUVUWOP79m1/mqGCKoEpAM4EB
        D/vQwxci3QQT5XlVS7j7OnE1VHpyhlzMpiJ7y+qA1oon2q/ZAwEb/6sYyL8haQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ukjcgr8xBhy+g3OZs13uetHsjpUVZC4eHKa1M+r91I=;
        b=1bCHwZvCMxdX8QJcoPVDUANjvlSfXk6CGVNBnj/3eTMfWMiBWX2aIEYW056QPWZNJ1jXzM
        SjDkNN5cm/XiV2DA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Gow <davidgow@google.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH printk v1 16/18] kernel/panic: Add atomic write enforcement to warn/panic
Date:   Thu,  2 Mar 2023 21:02:16 +0106
Message-Id: <20230302195618.156940-17-john.ogness@linutronix.de>
In-Reply-To: <20230302195618.156940-1-john.ogness@linutronix.de>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Invoke the atomic write enforcement functions for warn/panic to
ensure that the information gets out to the consoles.

For the panic case, add explicit intermediate atomic flush calls to
ensure immediate flushing at important points. Otherwise the atomic
flushing only occurs when dropping out of the elevated priority,
which for panic may never happen.

It is important to note that if there are any legacy consoles
registered, they will be attempting to directly print from the
printk-caller context, which may jeopardize the reliability of the
atomic consoles. Optimally there should be no legacy consoles
registered.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 kernel/panic.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index da323209f583..db9834fbdf26 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -209,6 +209,7 @@ static void panic_print_sys_info(bool console_flush)
  */
 void panic(const char *fmt, ...)
 {
+	enum cons_prio prev_prio;
 	static char buf[1024];
 	va_list args;
 	long i, i_next = 0, len;
@@ -256,6 +257,8 @@ void panic(const char *fmt, ...)
 	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
 		panic_smp_self_stop();
 
+	prev_prio = cons_atomic_enter(CONS_PRIO_PANIC);
+
 	console_verbose();
 	bust_spinlocks(1);
 	va_start(args, fmt);
@@ -329,6 +332,8 @@ void panic(const char *fmt, ...)
 	if (_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
+	cons_atomic_flush(NULL, true);
+
 	console_unblank();
 
 	/*
@@ -353,6 +358,7 @@ void panic(const char *fmt, ...)
 		 * We can't use the "normal" timers since we just panicked.
 		 */
 		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
+		cons_atomic_flush(NULL, true);
 
 		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
 			touch_nmi_watchdog();
@@ -371,6 +377,7 @@ void panic(const char *fmt, ...)
 		 */
 		if (panic_reboot_mode != REBOOT_UNDEFINED)
 			reboot_mode = panic_reboot_mode;
+		cons_atomic_flush(NULL, true);
 		emergency_restart();
 	}
 #ifdef __sparc__
@@ -383,12 +390,16 @@ void panic(const char *fmt, ...)
 	}
 #endif
 #if defined(CONFIG_S390)
+	cons_atomic_flush(NULL, true);
 	disabled_wait();
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
+
+	cons_atomic_exit(CONS_PRIO_PANIC, prev_prio);
+
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();
@@ -599,6 +610,10 @@ struct warn_args {
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
+	enum cons_prio prev_prio;
+
+	prev_prio = cons_atomic_enter(CONS_PRIO_EMERGENCY);
+
 	disable_trace_on_warning();
 
 	if (file)
@@ -630,6 +645,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
+
+	cons_atomic_exit(CONS_PRIO_EMERGENCY, prev_prio);
 }
 
 #ifndef __WARN_FLAGS
-- 
2.30.2

