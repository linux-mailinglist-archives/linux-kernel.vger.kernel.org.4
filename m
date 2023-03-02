Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5773A6A89EB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCBT60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjCBT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA17474F3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:48 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J+6Uo9a3gUV/uuNaER8XdIymGyF2GY1924++ShHc6Ps=;
        b=RSRBYZTTYaC3LqqH5o7zHh4Atx/RzX5EKyzZAAfcuCZznQPTbYdupyci1tRR188esFhNwD
        BiL2RbhsOBPoHfD/GS0+WegM8gE0/7NTbY/efehrYwfkTD2GOBbVTHo31uhXag4sBlR+jJ
        +cEssFYpPDyaX2tavQb75eaiMwincI2pu8SmhmMV9z4iEftYIaQtCC3jJBat5IgIdpEBFH
        5j5auv4w92gmaUpq/LltX0tRRc4qPbx9aTkuZlDdttl+zmYIxydm8NZh0CEvxrRWxlWm3K
        YcIF9bTFXTRWNKlU4zz9p+HE3bhC9j/9zizAskHjQqpHsH8eDME+ogDU2GcgHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J+6Uo9a3gUV/uuNaER8XdIymGyF2GY1924++ShHc6Ps=;
        b=Nr5ZVS+lu4p8NFKGgEoRNUu8vjta4e+sJ0nnmeiaNvlChK2fxp5g9GfUx7JbDAntyHWLZq
        rWH7UBL1slMBzQDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v1 12/18] printk: nobkl: Add printer thread wakeups
Date:   Thu,  2 Mar 2023 21:02:12 +0106
Message-Id: <20230302195618.156940-13-john.ogness@linutronix.de>
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

Add a function to wakeup the printer threads. Use the new function
when:

  - records are added to the printk ringbuffer
  - consoles are started
  - consoles are resumed

The actual waking is performed via irq_work so that the wakeup can
be triggered from any context.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h      |  3 +++
 kernel/printk/internal.h     |  1 +
 kernel/printk/printk.c       | 26 ++++++++++++++++++++++++++
 kernel/printk/printk_nobkl.c | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 2c120c3f3c6e..710f1e72cd0f 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -16,6 +16,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bits.h>
+#include <linux/irq_work.h>
 #include <linux/rculist.h>
 #include <linux/rcuwait.h>
 #include <linux/types.h>
@@ -317,6 +318,7 @@ struct cons_context_data;
  * @thread_pbufs:	Pointer to thread private buffer
  * @kthread:		Pointer to kernel thread
  * @rcuwait:		RCU wait for the kernel thread
+ * @irq_work:		IRQ work for thread wakeup
  * @kthread_waiting:	Indicator whether the kthread is waiting to be woken
  * @write_atomic:	Write callback for atomic context
  * @write_thread:	Write callback for printk threaded printing
@@ -350,6 +352,7 @@ struct console {
 	struct printk_buffers	*thread_pbufs;
 	struct task_struct	*kthread;
 	struct rcuwait		rcuwait;
+	struct irq_work		irq_work;
 	atomic_t		kthread_waiting;
 
 	bool (*write_atomic)(struct console *con, struct cons_write_context *wctxt);
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 8856beed65da..a72402c1ac93 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -78,6 +78,7 @@ void cons_nobkl_cleanup(struct console *con);
 bool cons_nobkl_init(struct console *con);
 bool cons_alloc_percpu_data(struct console *con);
 void cons_kthread_create(struct console *con);
+void cons_wake_threads(void);
 
 /*
  * Check if the given console is currently capable and allowed to print
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4c6abb033ec1..19f682fcae10 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2345,6 +2345,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
+	cons_wake_threads();
 	if (in_sched)
 		defer_console_output();
 	else
@@ -2615,6 +2616,8 @@ void suspend_console(void)
 void resume_console(void)
 {
 	struct console *con;
+	short flags;
+	int cookie;
 
 	if (!console_suspend_enabled)
 		return;
@@ -2634,6 +2637,14 @@ void resume_console(void)
 	 */
 	synchronize_srcu(&console_srcu);
 
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		flags = console_srcu_read_flags(con);
+		if (flags & CON_NO_BKL)
+			cons_kthread_wake(con);
+	}
+	console_srcu_read_unlock(cookie);
+
 	pr_flush(1000, true);
 }
 
@@ -3226,9 +3237,23 @@ EXPORT_SYMBOL(console_stop);
 
 void console_start(struct console *console)
 {
+	short flags;
+
 	console_list_lock();
 	console_srcu_write_flags(console, console->flags | CON_ENABLED);
+	flags = console->flags;
 	console_list_unlock();
+
+	/*
+	 * Ensure that all SRCU list walks have completed. The related
+	 * printing context must be able to see it is enabled so that
+	 * it is guaranteed to wake up and resume printing.
+	 */
+	synchronize_srcu(&console_srcu);
+
+	if (flags & CON_NO_BKL)
+		cons_kthread_wake(console);
+
 	__pr_flush(console, 1000, true);
 }
 EXPORT_SYMBOL(console_start);
@@ -3918,6 +3943,7 @@ void defer_console_output(void)
 
 void printk_trigger_flush(void)
 {
+	cons_wake_threads();
 	defer_console_output();
 }
 
diff --git a/kernel/printk/printk_nobkl.c b/kernel/printk/printk_nobkl.c
index bc3b69223897..890fc8d44f1d 100644
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -1368,6 +1368,37 @@ static int cons_kthread_func(void *__console)
 	return 0;
 }
 
+/**
+ * cons_irq_work - irq work to wake printk thread
+ * @irq_work:	The irq work to operate on
+ */
+static void cons_irq_work(struct irq_work *irq_work)
+{
+	struct console *con = container_of(irq_work, struct console, irq_work);
+
+	cons_kthread_wake(con);
+}
+
+/**
+ * cons_wake_threads - Wake up printing threads
+ *
+ * A printing thread is only woken if it is within the @kthread_waiting
+ * block. If it is not within the block (or enters the block later), it
+ * will see any new records and continue printing on its own.
+ */
+void cons_wake_threads(void)
+{
+	struct console *con;
+	int cookie;
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		if (con->kthread && atomic_read(&con->kthread_waiting))
+			irq_work_queue(&con->irq_work);
+	}
+	console_srcu_read_unlock(cookie);
+}
+
 /**
  * cons_kthread_stop - Stop a printk thread
  * @con:	Console to operate on
@@ -1471,6 +1502,7 @@ bool cons_nobkl_init(struct console *con)
 
 	rcuwait_init(&con->rcuwait);
 	atomic_set(&con->kthread_waiting, 0);
+	init_irq_work(&con->irq_work, cons_irq_work);
 	cons_state_set(con, CON_STATE_CUR, &state);
 	cons_state_set(con, CON_STATE_REQ, &state);
 	cons_seq_init(con);
-- 
2.30.2

