Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309B25B4A9A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIJWa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiIJW3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:29:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C61145F6B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:28:19 -0700 (PDT)
Message-ID: <20220910222302.052398226@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=PfOqpESp8tLtZDC+o8o6mnQEU5nU5UN8jXbbOmj7yS4=;
        b=m6Abpy6h1kF4rVeB+tpgtOq5St2HvOoeyZmg3+oUoEtc765WcnPNdjjdDskblrqvvh5HNk
        KiRC42PRB7VaAGyui0U3PPmaJ2HA4GU41PDgVaIDtcov1VV3AfkKdlLog5LOMIinhHX0jQ
        QzXs+yLhpaAHDcVD7saCgOBVUKYcjwAgW9Jt3p/yX2MuRk2oM7hRX4+sDJsxzVP1Og4wFG
        LGm+QnND9C0++XeX14/sd8bJqLKt1FbOmKPMGoqBXo3ZpqRWoPrRf/FTmo4N1so5lSKl8E
        yvQQq1ppEUsHjPnfshWShiM/PP40N03NHcxpGJW/C3jDOtofdbkHIzVEvj+CfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=PfOqpESp8tLtZDC+o8o6mnQEU5nU5UN8jXbbOmj7yS4=;
        b=XSgI0HWlYJEj+zBs/+PztE9DWGK8iwwPJ6EA+zl/UFDLvCDcC9P9LSHOe29UE+vTNZxvAz
        2L3mmKMAyxEIB+CA==
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
        Daniel Thompson <daniel.thompson@linaro.org>,
        John Ogness <jogness@linutronix.de>
Subject: [patch RFC 29/29] printk: Add atomic write enforcement to warn/panic...
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:28:17 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: John Ogness <jogness@linutronix.de>

Invoke the atomic write enforcement functions for warn/panic to ensure that
the information gets out to the consoles.

This is not yet a final solution as this still unlocks consoles and depends
on the "reliablity" of legacy consoles which are invoked during printk().

Once the legacy is converted over this can be changed to lock consoles on
entry, print undisturbed and release them on exit.

Signed-off-by: John Ogness <jogness@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/panic.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -256,6 +256,12 @@ void panic(const char *fmt, ...)
 	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
 		panic_smp_self_stop();
 
+	/*
+	 * No point in saving the previous printk severity level
+	 * here. Panic won't come back
+	 */
+	cons_atomic_enter(CONS_PRIO_PANIC);
+
 	console_verbose();
 	bust_spinlocks(1);
 	va_start(args, fmt);
@@ -602,6 +608,10 @@ struct warn_args {
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
+	enum cons_prio prev_prio;
+
+	prev_prio = cons_atomic_enter(CONS_PRIO_EMERGENCY);
+
 	disable_trace_on_warning();
 
 	if (file)
@@ -633,6 +643,8 @@ void __warn(const char *file, int line,
 
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
+
+	cons_atomic_exit(CONS_PRIO_EMERGENCY, prev_prio);
 }
 
 #ifndef __WARN_FLAGS

