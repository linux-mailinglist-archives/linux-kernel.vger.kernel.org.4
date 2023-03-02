Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1176A89F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjCBT62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCBT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ED9474DE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=edvO9X8XZ958RaRcZGgZGLMOgts69wn+b0VXMGnOne8=;
        b=Z8SkxmFxnzZ9XMdnLPhidK001rury81RhEEZivwkSCKoRgFr0dCOxmR0h/z3+80UgOT7oA
        EOVaC11S5kOUGrxy8X9MnPuIz6Hmu4GsiYouT3WUQT2CVDP1+ZkK9h6VGa4dUvp/BxQLSK
        Z9WaNfDWMq0K/DVxOjis1rjgxNZvtAQ7v1ZCGrsdrlsKiS0JZydo7b08K96BndmdrhFexz
        /Oo8fWN+Xc/FyUg1cZcUNtL9lKwOu/sMzwATep0VZb3yOLBr5vElr15PNjG2CxR/+oa5Ck
        CFKV65Adgz3BL1yo4eFgz+293xDv0tQ/EK4w1HGMasvmr23wylz+WzEJZ0aHRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=edvO9X8XZ958RaRcZGgZGLMOgts69wn+b0VXMGnOne8=;
        b=cRT531wHVlDzGkhhheBxiGJJeNEiGr0t/Op9b5IcxUx7F/gGoR9k3VKK7eNm3PxPTSl33w
        6No9KuH5jwPHD/BQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v1 08/18] printk: nobkl: Add sequence handling
Date:   Thu,  2 Mar 2023 21:02:08 +0106
Message-Id: <20230302195618.156940-9-john.ogness@linutronix.de>
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

On 64bit systems the sequence tracking is embedded into the atomic
console state, on 32bit it has to be stored in a separate atomic
member. The latter needs to handle the non-atomicity in hostile
takeover cases, while 64bit can completely rely on the state
atomicity.

The ringbuffer sequence number is 64bit, but having a 32bit
representation in the console is sufficient. If a console ever gets
more than 2^31 records behind the ringbuffer then this is the least
of the problems.

On acquire() the atomic 32bit sequence number is expanded to 64 bit
by folding the ringbuffer's sequence into it carefully.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h      |   8 ++
 kernel/printk/internal.h     |   4 +
 kernel/printk/printk.c       |  61 +++++++---
 kernel/printk/printk_nobkl.c | 224 +++++++++++++++++++++++++++++++++++
 4 files changed, 280 insertions(+), 17 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 3d989104240f..942cc7f57798 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -246,6 +246,8 @@ struct printk_buffers;
  * @hov_state:		The handover state for spin and cleanup
  * @req_state:		The request state for spin and cleanup
  * @spinwait_max_us:	Limit for spinwait acquire
+ * @oldseq:		The sequence number at acquire()
+ * @newseq:		The sequence number for progress
  * @prio:		Priority of the context
  * @pbufs:		Pointer to the text buffer for this context
  * @thread:		The acquire is printk thread context
@@ -259,6 +261,8 @@ struct cons_context {
 	struct cons_state	old_state;
 	struct cons_state	hov_state;
 	struct cons_state	req_state;
+	u64			oldseq;
+	u64			newseq;
 	unsigned int		spinwait_max_us;
 	enum cons_prio		prio;
 	struct printk_buffers	*pbufs;
@@ -304,6 +308,7 @@ struct cons_context_data;
  * @node:		hlist node for the console list
  *
  * @atomic_state:	State array for NOBKL consoles; real and handover
+ * @atomic_seq:		Sequence for record tracking (32bit only)
  * @thread_pbufs:	Pointer to thread private buffer
  * @pcpu_data:		Pointer to percpu context data
  */
@@ -328,6 +333,9 @@ struct console {
 
 	/* NOBKL console specific members */
 	atomic_long_t		__private atomic_state[2];
+#ifndef CONFIG_64BIT
+	atomic_t		__private atomic_seq;
+#endif
 	struct printk_buffers	*thread_pbufs;
 	struct cons_context_data	__percpu *pcpu_data;
 };
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 61ecdde5c872..15a412065327 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -4,6 +4,7 @@
  */
 #include <linux/percpu.h>
 #include <linux/console.h>
+#include "printk_ringbuffer.h"
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
 void __init printk_sysctl_init(void);
@@ -41,6 +42,8 @@ enum printk_info_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
+extern struct printk_ringbuffer *prb;
+
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
@@ -68,6 +71,7 @@ void defer_console_output(void);
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
 
+u64 cons_read_seq(struct console *con);
 void cons_nobkl_cleanup(struct console *con);
 bool cons_nobkl_init(struct console *con);
 bool cons_alloc_percpu_data(struct console *con);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3abefdead7ae..21b31183ff2b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -511,7 +511,7 @@ _DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
 
 static struct printk_ringbuffer printk_rb_dynamic;
 
-static struct printk_ringbuffer *prb = &printk_rb_static;
+struct printk_ringbuffer *prb = &printk_rb_static;
 
 /*
  * We cannot access per-CPU data (e.g. per-CPU flush irq_work) before
@@ -2728,30 +2728,39 @@ static bool abandon_console_lock_in_panic(void)
 
 /*
  * Check if the given console is currently capable and allowed to print
- * records.
- *
- * Requires the console_srcu_read_lock.
+ * records. If the caller only works with certain types of consoles, the
+ * caller is responsible for checking the console type before calling
+ * this function.
  */
-static inline bool console_is_usable(struct console *con)
+static inline bool console_is_usable(struct console *con, short flags)
 {
-	short flags = console_srcu_read_flags(con);
-
 	if (!(flags & CON_ENABLED))
 		return false;
 
 	if ((flags & CON_SUSPENDED))
 		return false;
 
-	if (!con->write)
-		return false;
-
 	/*
-	 * Console drivers may assume that per-cpu resources have been
-	 * allocated. So unless they're explicitly marked as being able to
-	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
+	 * The usability of a console varies depending on whether
+	 * it is a NOBKL console or not.
 	 */
-	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
-		return false;
+
+	if (flags & CON_NO_BKL) {
+		if (have_boot_console)
+			return false;
+
+	} else {
+		if (!con->write)
+			return false;
+		/*
+		 * Console drivers may assume that per-cpu resources have
+		 * been allocated. So unless they're explicitly marked as
+		 * being able to cope (CON_ANYTIME) don't call them until
+		 * this CPU is officially up.
+		 */
+		if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
+			return false;
+	}
 
 	return true;
 }
@@ -3001,9 +3010,14 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
+			short flags = console_srcu_read_flags(con);
 			bool progress;
 
-			if (!console_is_usable(con))
+			/* console_flush_all() is only for legacy consoles. */
+			if (flags & CON_NO_BKL)
+				continue;
+
+			if (!console_is_usable(con, flags))
 				continue;
 			any_usable = true;
 
@@ -3775,10 +3789,23 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
+			short flags;
+
 			if (con && con != c)
 				continue;
-			if (!console_is_usable(c))
+
+			flags = console_srcu_read_flags(c);
+
+			if (!console_is_usable(c, flags))
 				continue;
+
+			/*
+			 * Since the console is locked, use this opportunity
+			 * to update console->seq for NOBKL consoles.
+			 */
+			if (flags & CON_NO_BKL)
+				c->seq = cons_read_seq(c);
+
 			printk_seq = c->seq;
 			if (printk_seq < seq)
 				diff += seq - printk_seq;
diff --git a/kernel/printk/printk_nobkl.c b/kernel/printk/printk_nobkl.c
index 7db56ffd263a..7184a93a5b0d 100644
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include "printk_ringbuffer.h"
 #include "internal.h"
 /*
  * Printk implementation for consoles that do not depend on the BKL style
@@ -207,6 +208,227 @@ static __ref void cons_context_set_pbufs(struct cons_context *ctxt)
 		ctxt->pbufs = &(this_cpu_ptr(con->pcpu_data)->pbufs);
 }
 
+/**
+ * cons_seq_init - Helper function to initialize the console sequence
+ * @con:	Console to work on
+ *
+ * Set @con->atomic_seq to the starting record, or if that record no
+ * longer exists, the oldest available record. For init only. Do not
+ * use for runtime updates.
+ */
+static void cons_seq_init(struct console *con)
+{
+	u32 seq = (u32)max_t(u64, con->seq, prb_first_valid_seq(prb));
+#ifdef CONFIG_64BIT
+	struct cons_state state;
+
+	cons_state_read(con, CON_STATE_CUR, &state);
+	state.seq = seq;
+	cons_state_set(con, CON_STATE_CUR, &state);
+#else
+	atomic_set(&ACCESS_PRIVATE(con, atomic_seq), seq);
+#endif
+}
+
+static inline u64 cons_expand_seq(u64 seq)
+{
+	u64 rbseq;
+
+	/*
+	 * The provided sequence is only the lower 32bits of the ringbuffer
+	 * sequence. It needs to be expanded to 64bit. Get the next sequence
+	 * number from the ringbuffer and fold it.
+	 */
+	rbseq = prb_next_seq(prb);
+	seq = rbseq - ((u32)rbseq - (u32)seq);
+
+	return seq;
+}
+
+/**
+ * cons_read_seq - Read the current console sequence
+ * @con:	Console to read the sequence of
+ *
+ * Returns:	Sequence number of the next record to print on @con.
+ */
+u64 cons_read_seq(struct console *con)
+{
+	u64 seq;
+#ifdef CONFIG_64BIT
+	struct cons_state state;
+
+	cons_state_read(con, CON_STATE_CUR, &state);
+	seq = state.seq;
+#else
+	seq = atomic_read(&ACCESS_PRIVATE(con, atomic_seq));
+#endif
+	return cons_expand_seq(seq);
+}
+
+/**
+ * cons_context_set_seq - Setup the context with the next sequence to print
+ * @ctxt:	Pointer to an acquire context that contains
+ *		all information about the acquire mode
+ *
+ * On return the retrieved sequence number is stored in ctxt->oldseq.
+ *
+ * The sequence number is safe in forceful takeover situations.
+ *
+ * Either the writer succeeded to update before it got interrupted
+ * or it failed. In the latter case the takeover will print the
+ * same line again.
+ *
+ * The sequence is only the lower 32bits of the ringbuffer sequence. The
+ * ringbuffer must be 2^31 records ahead to get out of sync. This needs
+ * some care when starting a console, i.e setting the sequence to 0 is
+ * wrong. It has to be set to the oldest valid sequence in the ringbuffer
+ * as that cannot be more than 2^31 records away
+ *
+ * On 64bit the 32bit sequence is part of console::state, which is saved
+ * in @ctxt->state. This prevents the 32bit update race.
+ */
+static void cons_context_set_seq(struct cons_context *ctxt)
+{
+#ifdef CONFIG_64BIT
+	ctxt->oldseq = ctxt->state.seq;
+#else
+	ctxt->oldseq = atomic_read(&ACCESS_PRIVATE(ctxt->console, atomic_seq));
+#endif
+	ctxt->oldseq = cons_expand_seq(ctxt->oldseq);
+	ctxt->newseq = ctxt->oldseq;
+}
+
+/**
+ * cons_seq_try_update - Try to update the console sequence number
+ * @ctxt:	Pointer to an acquire context that contains
+ *		all information about the acquire mode
+ *
+ * Returns:	True if the console sequence was updated, false otherwise.
+ *
+ * Internal helper as the logic is different on 32bit and 64bit.
+ *
+ * On 32 bit the sequence is separate from state and therefore
+ * subject to a subtle race in the case of hostile takeovers.
+ *
+ * On 64 bit the sequence is part of the state and therefore safe
+ * vs. hostile takeovers.
+ *
+ * In case of fail the console has been taken over and @ctxt is
+ * invalid. Caller has to reacquire the console.
+ */
+#ifdef CONFIG_64BIT
+static bool __maybe_unused cons_seq_try_update(struct cons_context *ctxt)
+{
+	struct console *con = ctxt->console;
+	struct cons_state old;
+	struct cons_state new;
+
+	cons_state_read(con, CON_STATE_CUR, &old);
+	do {
+		/* Make sure this context is still the owner. */
+		if (!cons_state_bits_match(old, ctxt->state))
+			return false;
+
+		/* Preserve bit state */
+		copy_bit_state(new, old);
+		new.seq = ctxt->newseq;
+
+		/*
+		 * Can race with hostile takeover or with a handover
+		 * request.
+		 */
+	} while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &old, &new));
+
+	copy_full_state(ctxt->state, new);
+	ctxt->oldseq = ctxt->newseq;
+
+	return true;
+}
+#else
+static bool cons_release(struct cons_context *ctxt);
+static bool __maybe_unused cons_seq_try_update(struct cons_context *ctxt)
+{
+	struct console *con = ctxt->console;
+	struct cons_state state;
+	int pcpu;
+	u32 old;
+	u32 new;
+
+	/*
+	 * There is a corner case that needs to be considered here:
+	 *
+	 * CPU0			CPU1
+	 * printk()
+	 *  acquire()		-> emergency
+	 *  write()		   acquire()
+	 *  update_seq()
+	 *    state == OK
+	 * --> NMI
+	 *			   takeover()
+	 * <---			     write()
+	 *  cmpxchg() succeeds	     update_seq()
+	 *			     cmpxchg() fails
+	 *
+	 * There is nothing that can be done about this other than having
+	 * yet another state bit that needs to be tracked and analyzed,
+	 * but fails to cover the problem completely.
+	 *
+	 * No other scenarios expose such a problem. On same CPU takeovers
+	 * the cmpxchg() always fails on the interrupted context after the
+	 * interrupting context finished printing, but that's fine as it
+	 * does not own the console anymore. The state check after the
+	 * failed cmpxchg prevents that.
+	 */
+	cons_state_read(con, CON_STATE_CUR, &state);
+	/* Make sure this context is still the owner. */
+	if (!cons_state_bits_match(state, ctxt->state))
+		return false;
+
+	/*
+	 * Get the original sequence number that was retrieved
+	 * from @con->atomic_seq. @con->atomic_seq should be still
+	 * the same. 32bit truncates. See cons_context_set_seq().
+	 */
+	old = (u32)ctxt->oldseq;
+	new = (u32)ctxt->newseq;
+	if (atomic_try_cmpxchg(&ACCESS_PRIVATE(con, atomic_seq), &old, new)) {
+		ctxt->oldseq = ctxt->newseq;
+		return true;
+	}
+
+	/*
+	 * Reread the state. If this context does not own the console anymore
+	 * then it cannot touch the sequence again.
+	 */
+	cons_state_read(con, CON_STATE_CUR, &state);
+	if (!cons_state_bits_match(state, ctxt->state))
+		return false;
+
+	pcpu = atomic_read(&panic_cpu);
+	if (pcpu == smp_processor_id()) {
+		/*
+		 * This is the panic CPU. Emitting a warning here does not
+		 * help at all. The callchain is clear and the priority is
+		 * to get the messages out. In the worst case duplicated
+		 * ones. That's a job for postprocessing.
+		 */
+		atomic_set(&ACCESS_PRIVATE(con, atomic_seq), new);
+		ctxt->oldseq = ctxt->newseq;
+		return true;
+	}
+
+	/*
+	 * Only emit a warning when this happens outside of a panic
+	 * situation as on panic it's neither useful nor helping to let the
+	 * panic CPU get the important stuff out.
+	 */
+	WARN_ON_ONCE(pcpu == PANIC_CPU_INVALID);
+
+	cons_release(ctxt);
+	return false;
+}
+#endif
+
 /**
  * cons_cleanup_handover - Cleanup a handover request
  * @ctxt:	Pointer to acquire context
@@ -542,6 +764,7 @@ static bool __cons_try_acquire(struct cons_context *ctxt)
 	}
 success:
 	/* Common updates on success */
+	cons_context_set_seq(ctxt);
 	cons_context_set_pbufs(ctxt);
 	return true;
 
@@ -739,6 +962,7 @@ bool cons_nobkl_init(struct console *con)
 
 	cons_state_set(con, CON_STATE_CUR, &state);
 	cons_state_set(con, CON_STATE_REQ, &state);
+	cons_seq_init(con);
 	return true;
 }
 
-- 
2.30.2

