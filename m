Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9425B4A80
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiIJW22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiIJW1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:27:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52DC42AEA
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:46 -0700 (PDT)
Message-ID: <20220910222300.846719466@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=X8SnKPqrkzZxerHYD/XgQWDb+uIPlnpUZ5U4JX+DX7g=;
        b=LZ5nkwCtJWjVflIeFYrTasSpWud/BpdHRAi72VFZ1drIKC33ebH3yUYvADtdnsxyeIStvr
        X6l0Lvis9vT27ffdzjHJp8i4B4H1wYpvmyluQi7QrjWts4WS1E6Mst2WfJQaFKoBAVqocG
        yzkEODXKhiKrTGohXl4gqAuigLy7tl69FWfpcb1mcSo991AouxLIz5CNTtK95HgA9sQx+z
        guv3nIpejRXIDqXlau8ZDxdpa5w7O5TVs7UU/2BK4fFE3lkvK3fVYaYy6nAgpConyQIEga
        geL1fVn8+XRDYVI411rcZWhS+B6P3cTyUbxskWfSXOa3wIo8d0vWvEaFvmxNOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=X8SnKPqrkzZxerHYD/XgQWDb+uIPlnpUZ5U4JX+DX7g=;
        b=AD02eYayJvVJbovZD8OsuYXTQ5VxXSx1+bVaG8pzVH0y7R5UKcmm//5xwaS1etOSwjfJnu
        a4up3EGjggGV/hCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [patch RFC 08/29] parisc: Put console abuse into one place
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:44 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PARISC has a hope based mechanism to restore consoles in case of a HPMC
(machine check exception) which is scattered over several places.

Move it into one place to make further changes simpler and add comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/parisc/include/asm/pdc.h |    2 +-
 arch/parisc/kernel/pdc_cons.c |   38 +++++++++++++++++++++++++++++++-------
 arch/parisc/kernel/traps.c    |   17 +++++------------
 3 files changed, 37 insertions(+), 20 deletions(-)

--- a/arch/parisc/include/asm/pdc.h
+++ b/arch/parisc/include/asm/pdc.h
@@ -20,7 +20,7 @@ extern unsigned long parisc_pat_pdc_cap;
 #define PDC_TYPE_SNAKE		 2 /* Doesn't support SYSTEM_MAP */
 
 void pdc_console_init(void);	/* in pdc_console.c */
-void pdc_console_restart(void);
+void pdc_console_restart(bool hpmc);
 
 void setup_pdc(void);		/* in inventory.c */
 
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
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -235,17 +235,12 @@ void die_if_kernel(char *str, struct pt_
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
@@ -429,9 +424,7 @@ void parisc_terminate(char *msg, struct
 	/* unlock the pdc lock if necessary */
 	pdc_emergency_unlock();
 
-	/* restart pdc console if necessary */
-	if (!console_drivers)
-		pdc_console_restart();
+	pdc_console_restart(false);
 
 	/* Not all paths will gutter the processor... */
 	switch(code){
@@ -483,7 +476,7 @@ void notrace handle_interruption(int cod
 	int si_code;
 
 	if (code == 1)
-	    pdc_console_restart();  /* switch back to pdc if HPMC */
+	    pdc_console_restart(true);  /* switch back to pdc if HPMC */
 	else if (!irqs_disabled_flags(regs->gr[0]))
 	    local_irq_enable();
 

