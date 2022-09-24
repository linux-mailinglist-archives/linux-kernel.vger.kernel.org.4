Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98255E8681
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiIXAFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiIXAFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA8A9AFA8;
        Fri, 23 Sep 2022 17:05:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WB3BybeSJAXwy9sZVb/waLS+Dyffg8F8NybWwGa1X/A=;
        b=xcriPjgLQzRYZ4xUbtrjHhhbSY6X8gfZJ30zvTyo5dN8Exk7uj2MmjaWOSJlNRl7Kx7QgB
        9zQMGBTGy3Igy87KJJoiQBMEBq1ZfUyJ3+ONwK3Q2gWgYzXNwtard3Pe2VWpuYp1AjVYud
        g4vXL5kWEDF7Xo1JpP+wPHuBA6Biyoynv4rES/A0LDxmt5x3U6Khr0Gb1dCj357zAK5TrC
        1x5uAsDfEZkZMo21gLUlF5sJX5MVPGjKTRNRPvpHjKdH4vn54Jxdxv93lMZv4COb/J/lqF
        2N+8ZBtK8RV+utbDmp1JekmGb65ZIrgEh4rTStW8s+HKiMPBgXfBMmkIZL6g/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WB3BybeSJAXwy9sZVb/waLS+Dyffg8F8NybWwGa1X/A=;
        b=zrUfFUWtkjjZ3Z3lX1frvgxG5HxmxzTiAMVgTfy0X477YaoYnRe+pIKC81HrwV1A1YFwfh
        Q9yqPZQbhwkJzJCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Sven Schnelle <svens@stackframe.org>,
        John David Anglin <dave.anglin@bell.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        linux-parisc@vger.kernel.org
Subject: [PATCH printk 08/18] parisc: Put console abuse into one place
Date:   Sat, 24 Sep 2022 02:10:44 +0206
Message-Id: <20220924000454.3319186-9-john.ogness@linutronix.de>
In-Reply-To: <20220924000454.3319186-1-john.ogness@linutronix.de>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
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

PARISC has a hope based mechanism to restore consoles in case of a HPMC
(machine check exception) which is scattered over several places.

Move it into one place to make further changes simpler and add comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 arch/parisc/include/asm/pdc.h |  2 +-
 arch/parisc/kernel/pdc_cons.c | 38 ++++++++++++++++++++++++++++-------
 arch/parisc/kernel/traps.c    | 17 +++++-----------
 3 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/arch/parisc/include/asm/pdc.h b/arch/parisc/include/asm/pdc.h
index b643092d4b98..12bffd8a5d05 100644
--- a/arch/parisc/include/asm/pdc.h
+++ b/arch/parisc/include/asm/pdc.h
@@ -20,7 +20,7 @@ extern unsigned long parisc_pat_pdc_cap; /* PDC capabilities (PAT) */
 #define PDC_TYPE_SNAKE		 2 /* Doesn't support SYSTEM_MAP */
 
 void pdc_console_init(void);	/* in pdc_console.c */
-void pdc_console_restart(void);
+void pdc_console_restart(bool hpmc);
 
 void setup_pdc(void);		/* in inventory.c */
 
diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons.c
index 2661cdd256ae..9a0c0932d2f9 100644
--- a/arch/parisc/kernel/pdc_cons.c
+++ b/arch/parisc/kernel/pdc_cons.c
@@ -237,20 +237,44 @@ void __init pdc_console_init(void)
 
 
 /*
- * Used for emergencies. Currently only used if an HPMC occurs. If an
- * HPMC occurs, it is possible that the current console may not be
- * properly initialised after the PDC IO reset. This routine unregisters
- * all of the current consoles, reinitializes the pdc console and
- * registers it.
+ * <Historical comments>
+ *
+ * Used for emergencies.
+ *
+ *  - If an HPMC occurs, it is possible that the current console may not be
+ *    properly initialised after the PDC IO reset. This routine unregisters
+ *    all of the current consoles, reinitializes the pdc console and registers
+ *    it.
+ *
+ *  - Maybe the kernel hasn't booted very far yet and hasn't been able
+ *    to initialize the serial or STI console. In that case we should
+ *    re-enable the pdc console, so that the user will be able to
+ *    identify the problem.
+ *
+ * </Historical comments>
+ *
+ * The above is all wishful thinking:
+ *
+ *  - Invoking [un]register_console() from exception contexts is obviously
+ *    unsafe.
+ *
+ *  - If the HPMC left the machine in unpleasant state and the pdc console
+ *    was already initialized, but later removed due to CON_BOOT then this
+ *    will do nothing.
+ *
+ * Pretend that any of the below works in the same way as we pretend that
+ * any of PARISC works.
  */
-
-void pdc_console_restart(void)
+void pdc_console_restart(bool hpmc)
 {
 	struct console *console;
 
 	if (pdc_console_initialized)
 		return;
 
+	if (!hpmc && console_drivers)
+		return;
+
 	/* If we've already seen the output, don't bother to print it again */
 	if (console_drivers != NULL)
 		pdc_cons.flags &= ~CON_PRINTBUFFER;
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index b78f1b9d45c1..81e23f589d3d 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -235,17 +235,12 @@ void die_if_kernel(char *str, struct pt_regs *regs, long err)
 			"                 (__)\\       )\\/\\\n"
 			"                  U  ||----w |\n"
 			"                     ||     ||\n");
-	
+
 	/* unlock the pdc lock if necessary */
 	pdc_emergency_unlock();
 
-	/* maybe the kernel hasn't booted very far yet and hasn't been able 
-	 * to initialize the serial or STI console. In that case we should 
-	 * re-enable the pdc console, so that the user will be able to 
-	 * identify the problem. */
-	if (!console_drivers)
-		pdc_console_restart();
-	
+	pdc_console_restart(false);
+
 	if (err)
 		printk(KERN_CRIT "%s (pid %d): %s (code %ld)\n",
 			current->comm, task_pid_nr(current), str, err);
@@ -429,9 +424,7 @@ void parisc_terminate(char *msg, struct pt_regs *regs, int code, unsigned long o
 	/* unlock the pdc lock if necessary */
 	pdc_emergency_unlock();
 
-	/* restart pdc console if necessary */
-	if (!console_drivers)
-		pdc_console_restart();
+	pdc_console_restart(false);
 
 	/* Not all paths will gutter the processor... */
 	switch(code){
@@ -483,7 +476,7 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 	int si_code;
 
 	if (code == 1)
-	    pdc_console_restart();  /* switch back to pdc if HPMC */
+	    pdc_console_restart(true);  /* switch back to pdc if HPMC */
 	else if (!irqs_disabled_flags(regs->gr[0]))
 	    local_irq_enable();
 
-- 
2.30.2

