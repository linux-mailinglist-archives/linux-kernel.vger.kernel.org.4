Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9726D5B4A8A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiIJW2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiIJW2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:28:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D911D42AEA
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:53 -0700 (PDT)
Message-ID: <20220910222301.084428332@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fGXSmzhEoK8b0GTobsLbcAxSd+NNxBh/Huh2f6MgBe8=;
        b=oEoG4XV/p63GR35K1PB67q56l0RUQRKw6YTPQ6y3RalqcnfpaMMmKI3NSxD0i0qIm2CMRm
        +ULaMQMVKoCodg2N6gDErwVLpyx9bw4pRcNB6PmFCxWzDxtTQUSGrgzbIBr0mtuvP0/Ozq
        3BWp1QpP5x8fRcNkxC0H1XUrUCXlyVb2JsrxYUj/kYtZv7veSbGvCPE5c7mcylreff3Fjc
        g4Dh96r9+i819DPBNfIysF9G2EPbI3/QhaRs4pq0fn2o8ovOwH8uWFrIhFAAgj2KgsTpJE
        ZdCK1ora8+Iusf+S/+3rMd3ABaPewKlCSxtpsaLso2HxBxc2x8anqqDhSphYew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fGXSmzhEoK8b0GTobsLbcAxSd+NNxBh/Huh2f6MgBe8=;
        b=XNjATjL37sd9bZqMc50Uk1ZjkOB2XZLy9+WnHzUcStr8G587JSVK2QVuK/z+MfYlvEN3ta
        zTxv+K0dAQU52NAQ==
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
Subject: [patch RFC 12/29] printk: Prepare for SCRU console list protection
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:50 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a SRCU protected variant to walk the console list.

Preperatory change for a new console infrastructure which operates
independent of console BKL.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h |   14 +++++++++++++-
 kernel/printk/printk.c  |   16 +++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -15,7 +15,7 @@
 #define _LINUX_CONSOLE_H_ 1
 
 #include <linux/atomic.h>
-#include <linux/list.h>
+#include <linux/rculist.h>
 #include <linux/types.h>
 
 struct vc_data;
@@ -161,6 +161,7 @@ struct console {
 #ifdef CONFIG_LOCKDEP
 extern void lockdep_assert_console_lock_held(void);
 extern void lockdep_assert_console_list_lock_held(void);
+extern bool console_srcu_read_lock_is_held(void);
 #else
 static inline void lockdep_assert_console_lock_held(void) { }
 static inline void lockdep_assert_console_list_lock_held(void) { }
@@ -172,6 +173,17 @@ extern void console_list_lock(void) __ac
 extern void console_list_unlock(void) __releases(console_mutex);
 
 /**
+ * for_each_console_srcu() - Iterator over registered consoles
+ * @con:	struct console pointer used as loop cursor
+ *
+ * Requires console_srcu_read_lock to be held. Can be invoked from
+ * any context.
+ */
+#define for_each_console_srcu(con)					\
+	hlist_for_each_entry_srcu(con, &console_list, node,		\
+				  console_srcu_read_lock_is_held())
+
+/**
  * for_each_registered_console() - Iterator over registered consoles
  * @con:	struct console pointer used as loop cursor
  *
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -90,6 +90,7 @@ static DEFINE_MUTEX(console_mutex);
 static DEFINE_SEMAPHORE(console_sem);
 HLIST_HEAD(console_list);
 EXPORT_SYMBOL_GPL(console_list);
+DEFINE_STATIC_SRCU(console_srcu);
 
 /*
  * System may need to suppress printk message under certain
@@ -118,6 +119,10 @@ void lockdep_assert_console_list_lock_he
 	lockdep_assert_held(&console_mutex);
 }
 
+bool console_srcu_read_lock_is_held(void)
+{
+	return srcu_read_lock_held(&console_srcu);
+}
 #endif
 
 enum devkmsg_log_bits {
@@ -3227,9 +3232,9 @@ void register_console(struct console *ne
 	 */
 	console_lock();
 	if (newcon->flags & CON_CONSDEV || hlist_empty(&console_list))
-		hlist_add_head(&newcon->node, &console_list);
+		hlist_add_head_rcu(&newcon->node, &console_list);
 	else
-		hlist_add_behind(&newcon->node, console_list.first);
+		hlist_add_behind_rcu(&newcon->node, console_list.first);
 
 	/* Ensure this flag is always set for the head of the list */
 	cons_first()->flags |= CON_CONSDEV;
@@ -3245,6 +3250,7 @@ void register_console(struct console *ne
 		newcon->seq = prb_next_seq(prb);
 	}
 	console_unlock();
+	/* No need to synchronize SRCU here! */
 	console_sysfs_notify();
 
 	/*
@@ -3290,7 +3296,7 @@ static int console_unregister_locked(str
 	if (hlist_unhashed(&console->node))
 		goto out_unlock;
 
-	hlist_del_init(&console->node);
+	hlist_del_init_rcu(&console->node);
 
 	/*
 	 * <HISTORICAL>
@@ -3305,6 +3311,10 @@ static int console_unregister_locked(str
 		cons_first()->flags |= CON_CONSDEV;
 
 	console_unlock();
+
+	/* Ensure that all SRCU list walks have completed */
+	synchronize_srcu(&console_srcu);
+
 	console_sysfs_notify();
 
 	if (console->exit)

