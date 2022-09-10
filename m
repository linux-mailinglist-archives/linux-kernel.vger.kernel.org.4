Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8565B4A8B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIJW30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiIJW2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:28:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA3C43327
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:28:04 -0700 (PDT)
Message-ID: <20220910222301.479172669@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=eW1Uv7VcznaWz1WCA/sCs2A1xXkZMV/Q/SbEfreVnsg=;
        b=nLhzR3/u5SeUMOBnmpTsUUhNpI+Wypi0sJNm5i86qygBtQAKb9ssAryYUyTMEgUvyN2sm+
        T3g0QiyYz9+Ea7hVrcv6Pkxyqa3+HL/QGNaJSDpz3XGqayGF34dmoyquEHn+L9T+6grkJt
        F2slE8RdopxrJEPgYHt3m0lg9H1FYcYlPleVrpy9L6UoxddnhfrBaZtDEhoFssa+6rM5Lh
        8jvEkY9UWfBA5ozQy0/kLfEmw9Ji+ahwC/GrKyy9D2geGcVIrvp6uu7ID/24/9XStw2ZBM
        63Cao8aZjbAWdpKX4EYHyR1Ti3lj9N2ZfapqIb/6ZuEVrx+WLCEsEXBSg4F+UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=eW1Uv7VcznaWz1WCA/sCs2A1xXkZMV/Q/SbEfreVnsg=;
        b=5OF6Nei9RtmlJEXDfoL0aeOUY4u9J9+nvcw0wzr7WTHIOvLIb2o7+CQuymymjOM0H3zvVD
        GWCFFecB8fyPk4Bw==
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
Subject: [patch RFC 19/29] printk: Add basic infrastructure for non-BKL consoles
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:28:01 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current console/printk subsystem is protected by a Big Kernel Lock,
aka. console_lock which has has ill defined semantics and is more or less
stateless. This puts severe limitations on the console subsystem and makes
forced takeover and output in emergency and panic situations a fragile
endavour which is based on try and pray.

The goal of non-BKL consoles is to break out of the console lock jail and
to provide a new infrastructure which avoids the pitfalls and allows
console drivers to be gradually converted over.

The proposed infrastructure aims for the following properties:

  - Lockless (SCRU protected) console list walk
  - Per console locking instead of global locking
  - Per console state which allows to make informed decisions
  - Stateful handover and takeover

As a first step this adds state to struct console. The per console state is
a atomic_long_t with a 32bit bit field and on 64bit a 32bit sequence for
tracking the last printed ringbuffer sequence number. On 32bit the sequence
is seperate from state for obvious reasons which requires to handle a few
extra race conditions.

Add the initial state with the most basic 'alive' and 'enabled' bits and
wire it up into the console register/unregister functionality and exclude
such consoles from being handled in the console BKL mechanisms.

The decision to use a bitfield was made as using a plain u32 and mask/shift
operations turned out to result in uncomprehensible code.

Co-Developed-by: John Ogness <jogness@linutronix.de>
Signed-off-by: John Ogness <jogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 fs/proc/consoles.c           |    1 
 include/linux/console.h      |   38 +++++++++
 kernel/printk/printk.c       |   21 ++++-
 kernel/printk/printk_nobkl.c |  176 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 235 insertions(+), 1 deletion(-)

--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -21,6 +21,7 @@ static int show_console_dev(struct seq_f
 		{ CON_ENABLED,		'E' },
 		{ CON_CONSDEV,		'C' },
 		{ CON_BOOT,		'B' },
+		{ CON_NO_BKL,		'N' },
 		{ CON_PRINTBUFFER,	'p' },
 		{ CON_BRL,		'b' },
 		{ CON_ANYTIME,		'a' },
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -161,6 +161,8 @@ static inline int con_debug_leave(void)
  *			printk spam for obvious reasons
  * @CON_EXTENDED:	The console supports the extended output format of /dev/kmesg
  *			which requires a larger output record buffer
+ * @CON_NO_BKL:		Console can operate outside of the BKL style console_lock
+ *			constraints.
  */
 enum cons_flags {
 	CON_PRINTBUFFER		= BIT(0),
@@ -170,6 +172,37 @@ enum cons_flags {
 	CON_ANYTIME		= BIT(4),
 	CON_BRL			= BIT(5),
 	CON_EXTENDED		= BIT(6),
+	CON_NO_BKL		= BIT(7),
+};
+
+/**
+ * struct cons_state - console state for NOBKL consoles
+ * @atom:	Compound of the state fields for atomic operations
+ * @seq:	Sequence for record tracking (64bit only)
+ * @bits:	Compound of the state bits below
+ *
+ * @alive:	Console is alive. Required for teardown
+ * @enabled:	Console is enabled. If 0, do not use
+ *
+ * To be used for state read and preparation of atomic_long_cmpxchg()
+ * operations.
+ */
+struct cons_state {
+	union {
+		unsigned long	atom;
+		struct {
+#ifdef CONFIG_64BIT
+			u32	seq;
+#endif
+			union {
+				u32	bits;
+				struct {
+					u32 alive	:  1;
+					u32 enabled	:  1;
+				};
+			};
+		};
+	};
 };
 
 /**
@@ -218,6 +251,8 @@ struct cons_outbuf_desc {
  * @dropped:		Number of dropped ringbuffer records
  * @data:		Driver private data
  * @node:		hlist node for the console list
+ *
+ * @atomic_state:	State array for non-BKL consoles. Real and handover
  */
 struct console {
 	char			name[16];
@@ -237,6 +272,9 @@ struct console {
 	unsigned long		dropped;
 	void			*data;
 	struct hlist_node	node;
+
+	/* NOBKL console specific members */
+	atomic_long_t __private	atomic_state[2];
 };
 
 #ifdef CONFIG_LOCKDEP
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2339,7 +2339,9 @@ static bool suppress_message_printing(in
 static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
-#endif /* CONFIG_PRINTK */
+#endif /* !CONFIG_PRINTK */
+
+#include "printk_nobkl.c"
 
 #ifdef CONFIG_EARLY_PRINTK
 struct console *early_console;
@@ -2635,6 +2637,13 @@ static bool abandon_console_lock_in_pani
  */
 static inline bool console_is_usable(struct console *con)
 {
+	/*
+	 * Exclude the NOBKL consoles. They are handled seperately
+	 * as they do not require the console BKL
+	 */
+	if ((con->flags & CON_NO_BKL))
+		return false;
+
 	if (!(con->flags & CON_ENABLED))
 		return false;
 
@@ -3079,7 +3088,10 @@ void console_stop(struct console *consol
 	console_list_lock();
 	console_lock();
 	console->flags &= ~CON_ENABLED;
+	cons_state_disable(console);
 	console_unlock();
+	/* Ensure that all SRCU list walks have completed */
+	synchronize_srcu(&console_srcu);
 	console_list_unlock();
 }
 EXPORT_SYMBOL(console_stop);
@@ -3089,6 +3101,7 @@ void console_start(struct console *conso
 	console_list_lock();
 	console_lock();
 	console->flags |= CON_ENABLED;
+	cons_state_enable(console);
 	console_unlock();
 	console_list_unlock();
 	__pr_flush(console, 1000, true);
@@ -3276,6 +3289,9 @@ void register_console(struct console *ne
 		newcon->flags &= ~CON_PRINTBUFFER;
 	}
 
+	/* Initialize the nobkl data in @newcon */
+	cons_nobkl_init(newcon);
+
 	/*
 	 * Put this console in the list and keep the referred driver at the
 	 * head of the list.
@@ -3342,6 +3358,7 @@ static int console_unregister_locked(str
 
 	/* Disable it unconditionally */
 	console->flags &= ~CON_ENABLED;
+	cons_state_disable(console);
 
 	if (hlist_unhashed(&console->node))
 		goto out_unlock;
@@ -3365,6 +3382,8 @@ static int console_unregister_locked(str
 	/* Ensure that all SRCU list walks have completed */
 	synchronize_srcu(&console_srcu);
 
+	cons_nobkl_cleanup(console);
+
 	console_sysfs_notify();
 
 	if (console->exit)
--- /dev/null
+++ b/kernel/printk/printk_nobkl.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH, John Ogness
+// Copyright (C) 2022 Intel, Thomas Gleixner
+
+/*
+ * Printk implementation for consoles which do not depend on the BKL style
+ * console_lock() mechanism.
+ *
+ * Console is locked on a CPU when state::locked is set and state:cpu ==
+ * current CPU. This is valid for the current execution context.
+ *
+ * Nesting execution contexts on the same CPU can carefully take over
+ * if the driver allows reentrancy via state::unsafe = false. When the
+ * interrupted context resumes it checks the state before entering
+ * a unsafe region and aborts the operation it it detects the takeover.
+ *
+ * In case of panic or emergency the nesting context can take over the
+ * console forcefully. The write callback is then invoked with the unsafe
+ * flag set in the write context data which allows the driver side to avoid
+ * locks and to evaluate the driver state so it can use an emergency path or
+ * repair the state instead of blindly assuming that it works.
+ *
+ * If the interrupted context touches the assigned record buffer after
+ * takeover that does not cause harm because at the same execution level
+ * there is no concurrency on the same CPU. A threaded printer has always
+ * its own record buffer so it can never interfere with any of the per CPU
+ * record buffers.
+ *
+ * A concurrent writer on a different CPU can request to take over the
+ * console by:
+ *
+ *	1) Carefully writing the desired state into state[HANDOVER]
+ *	   if there is no same or higher priority request pending
+ *	   This locks state[HANDOVER] except for higher priority
+ *	   waiters.
+ *
+ *	2) Setting state[REAL].req_prio unless a higher priority
+ *	   waiter won the race.
+ *
+ *	3) Carefully spin on state[REAL] until that is locked with the
+ *	   expected state. When the state is not the expected one then it
+ *	   has to verify that state[HANDOVER] is still the same and that
+ *	   state[REAL] has not been taken over or marked dead.
+ *
+ *      The unlocker hands over to state[HANDOVER], but only if state[REAL]
+ *	matches.
+ *
+ * In case that the owner does not react on the request and does not make
+ * observable progress, the caller can decide to do a hostile take over.
+ */
+
+#ifdef CONFIG_PRINTK
+
+#define copy_full_state(_dst, _src)	do { _dst = _src; } while(0)
+#define copy_bit_state(_dst, _src)	do { _dst.bits = _src.bits; } while(0)
+
+#ifdef CONFIG_64BIT
+#define copy_seq_state64(_dst, _src)	do { _dst.seq = _src.seq; } while(0)
+#else
+#define copy_seq_state64(_dst, _src)	do { } while(0)
+#endif
+
+enum state_selector {
+	STATE_REAL,
+	STATE_HANDOVER,
+};
+
+/**
+ * cons_state_set - Helper function to set the console state
+ * @con:	Console to update
+ * @which:	Selects real state or handover state
+ * @new:	The new state to write
+ *
+ * Only to be used when the console is not yet or not longer visible in the
+ * system.
+ */
+static inline void cons_state_set(struct console *con, enum state_selector which,
+				  struct cons_state *new)
+{
+	atomic_long_set(&ACCESS_PRIVATE(con, atomic_state[which]), new->atom);
+}
+
+/**
+ * cons_state_read - Helper function to read the console state
+ * @con:	Console to update
+ * @which:	Selects real state or handover state
+ * @state:	The state to store the result
+ */
+static inline void cons_state_read(struct console *con, enum state_selector which,
+				   struct cons_state *state)
+{
+	state->atom = atomic_long_read(&ACCESS_PRIVATE(con, atomic_state[which]));
+}
+
+/**
+ * cons_state_try_cmpxchg() - Helper function for atomic_long_try_cmpxchg() on console state
+ * @con:	Console to update
+ * @which:	Selects real state or handover state
+ * @old:	Old state
+ * @new:	New state
+ *
+ * Returns: True on success, false on fail
+ */
+static inline bool cons_state_try_cmpxchg(struct console *con,
+					  enum state_selector which,
+					  struct cons_state *old,
+					  struct cons_state *new)
+{
+	return atomic_long_try_cmpxchg(&ACCESS_PRIVATE(con, atomic_state[which]),
+				       &old->atom, new->atom);
+}
+
+/**
+ * cons_state_mod_enabled - Helper function to en/disable a console
+ * @con:	Console to modify
+ */
+static void cons_state_mod_enabled(struct console *con, bool enable)
+{
+	struct cons_state old, new;
+
+	cons_state_read(con, STATE_REAL, &old);
+	do {
+		copy_full_state(new, old);
+		new.enabled = enable;
+	} while (!cons_state_try_cmpxchg(con, STATE_REAL, &old, &new));
+}
+
+/**
+ * cons_state_disable - Helper function to disable a console
+ * @con:	Console to disable
+ */
+static void cons_state_disable(struct console *con)
+{
+	cons_state_mod_enabled(con, false);
+}
+
+/**
+ * cons_state_enable - Helper function to enable a console
+ * @con:	Console to enable
+ */
+static void cons_state_enable(struct console *con)
+{
+	cons_state_mod_enabled(con, true);
+}
+
+/**
+ * cons_nobkl_init - Initialize the NOBKL console state
+ * @con:	Console to initialize
+ */
+static void cons_nobkl_init(struct console *con)
+{
+	struct cons_state state = {
+		.alive = 1,
+		.enabled = !!(con->flags & CON_ENABLED),
+	};
+
+	cons_state_set(con, STATE_REAL, &state);
+}
+
+/**
+ * cons_nobkl_cleanup - Cleanup the NOBKL console state
+ * @con:	Console to cleanup
+ */
+static void cons_nobkl_cleanup(struct console *con)
+{
+	struct cons_state state = { };
+
+	cons_state_set(con, STATE_REAL, &state);
+}
+
+#else /* CONFIG_PRINTK */
+static inline void cons_nobkl_init(struct console *con) { }
+static inline void cons_nobkl_cleanup(struct console *con) { }
+static inline void cons_state_disable(struct console *con) { }
+static inline void cons_state_enable(struct console *con) { }
+#endif /* !CONFIG_PRINTK */

