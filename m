Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7DF5B4A95
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiIJWaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiIJW2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:28:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4FB45060
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:28:09 -0700 (PDT)
Message-ID: <20220910222301.654817026@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=V3nslHeiY7vWR7aBqi9IfKVmvqX1b3nre7PznFTjP54=;
        b=zqvAM8a9TzTOkfp4BhhnkkB0U0BnK8o+ThtyYJXwrCKV4bF963O+463y9zW4X1kDD8piWo
        kzjEznuNrUsehJ7+RWMMir6ne7agCdu9FNFPcceIR8QdgYn11KbRY0gcjmwXePDZ2YXGTS
        W/dkY3OAk0R9eeYVbF2bhoc47dPm57m/R7o1fcb3XgUrSVX4xx55KBjoK1NsLlx33WX8l5
        wibpW4M4JeX9QKyfemK486O5y3PUV8NEODDLS9V7InTrzrwOW8U2fqqx7kT3SDpoRyfkCJ
        Kq4xvOArAUEJrZ7mfBp0GOO7BE/af+y9Pm40WrV0fhDXGLxyGCVMSLmjcIXzyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=V3nslHeiY7vWR7aBqi9IfKVmvqX1b3nre7PznFTjP54=;
        b=B4+MUerbxLxDsVOn+jgpVITvcY8hQaT4GUc+ZkKfcqUCj9ZvmuV6tZbevKaQFjIo6U4vm4
        uKQkM+qIxZTOqJCQ==
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
Subject: [patch RFC 22/29] printk: Add sequence handling for non-BKL consoles
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:28:06 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 64bit systems the sequence tracking is embedded into the atomic console
state, on 32bit it has to be stored in a seperate atomic member. The latter
needs to handle the non-atomicity in hostile takeover cases, while 64bit can
completely rely on the state atomicity.

The ringbuffer sequence number is 64bit, but having a 32bit representation
in the console is sufficient. If a console ever gets more than 2^31 records
behind the ringbuffer then this is the least of the problems.

On acquire() the stomic 32bit sequence number is expanded to 64 bit by
folding the ringbuffers sequence into it carefully.

Co-Developed-by: John Ogness <jogness@linutronix.de>
Signed-off-by: John Ogness <jogness@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h      |   11 +-
 kernel/printk/printk_nobkl.c |  204 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 212 insertions(+), 3 deletions(-)

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -275,6 +275,8 @@ struct console;
  * @hov_state:		The handover state for spin and cleanup
  * @req_state:		The request state for spin and cleanup
  * @spinwait_max_us:	Limit for spinwait acquire
+ * @oldseq:		The sequence number at acquire()
+ * @newseq:		The sequence number for progress
  * @prio:		Priority of the context
  * @txtbuf:		Pointer to the text buffer for this context
  * @thread:		The acquire is printk thread context
@@ -288,6 +290,8 @@ struct cons_context {
 	struct cons_state	old_state;
 	struct cons_state	hov_state;
 	struct cons_state	req_state;
+	u64			oldseq;
+	u64			newseq;
 	unsigned int		spinwait_max_us;
 	enum cons_prio		prio;
 	struct cons_text_buf	*txtbuf;
@@ -330,6 +334,7 @@ struct cons_context_data {
  * @node:		hlist node for the console list
  *
  * @atomic_state:	State array for non-BKL consoles. Real and handover
+ * @atomic_seq:		Sequence for record tracking (32bit only)
  * @pcpu_data:		Pointer to percpu context data
  * @ctxt_data:		Builtin context data for early boot and threaded printing
  */
@@ -353,8 +358,10 @@ struct console {
 	struct hlist_node	node;
 
 	/* NOBKL console specific members */
-	atomic_long_t __private		atomic_state[2];
-
+	atomic_long_t __private	atomic_state[2];
+#ifndef CONFIG_64BIT
+	atomic_t __private	atomic_seq;
+#endif
 	struct cons_context_data __percpu	*pcpu_data;
 	struct cons_context_data		ctxt_data;
 };
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -51,6 +51,8 @@
 
 #ifdef CONFIG_PRINTK
 
+static bool cons_release(struct cons_context *ctxt);
+
 #define copy_full_state(_dst, _src)	do { _dst = _src; } while(0)
 #define copy_bit_state(_dst, _src)	do { _dst.bits = _src.bits; } while(0)
 
@@ -244,6 +246,205 @@ static void cons_context_set_text_buf(st
 }
 
 /**
+ * cons_forward_sequence - Helper function forward the sequence
+ * @con:	Console to work on
+ *
+ * Forward @con->atomic_seq to the oldest available record. For init
+ * only. Do not use for runtime updates.
+ */
+static void cons_forward_sequence(struct console *con)
+{
+	u32 seq = (u32)prb_first_valid_seq(prb);
+#ifdef CONFIG_64BIT
+	struct cons_state state;
+
+	cons_state_read(con, STATE_REAL, &state);
+	state.seq = seq;
+	cons_state_set(con, STATE_REAL, &state);
+#else
+	atomic_set(&ACCESS_PRIVATE(con, atomic_seq), seq);
+#endif
+}
+
+/**
+ * cons_context_sequence_init - Retrieve the last printed sequence number
+ * @ctxt:	Pointer to an aquire context which contains
+ *		all information about the acquire mode
+ *
+ * On return the retrieved sequence number is stored in ctxt->oldseq.
+ *
+ * The sequence number is safe in forceful takeover situations.
+ *
+ * Either the writer succeded to update before it got interrupted
+ * or it failed. In the latter case the takeover will print the
+ * same line again.
+ *
+ * The sequence is only the lower 32bits of the ringbuffer sequence. The
+ * ringbuffer must be 2^31 records ahead to get out of sync. This needs
+ * some care when starting a console, i.e setting the sequence to 0 is
+ * wrong. It has to be set to the oldest valid sequence in the ringbuffer
+ * as that cannot be more than 2^31 records away
+ *
+ * On 64bit the 32bit sequence is part of console::state which is saved
+ * in @ctxt->state. This prevents the 32bit update race.
+ */
+static void cons_context_sequence_init(struct cons_context *ctxt)
+{
+	u64 rbseq;
+
+#ifdef CONFIG_64BIT
+	ctxt->oldseq = ctxt->state.seq;
+#else
+	ctxt->oldseq = atomic_read(&ACCESS_PRIVATE(ctxt->console, atomic_seq));
+#endif
+
+	/*
+	 * The sequence is only the lower 32bits of the ringbuffer
+	 * sequence. So it needs to be expanded to 64bit. Get the next
+	 * sequence number from the ringbuffer and fold it.
+	 */
+	rbseq = prb_next_seq(prb);
+	ctxt->oldseq = rbseq - ((u32)rbseq - (u32)ctxt->oldseq);
+	ctxt->newseq = ctxt->oldseq;
+}
+
+/**
+ * cons_sequence_try_update - Try to update the sequence number
+ * @ctxt:	Pointer to an aquire context which contains
+ *		all information about the acquire mode
+ *
+ * Returns:	True on success
+ *		False on fail.
+ *
+ * Internal helper as the logic is different on 32bit and 64bit.
+ *
+ * On 32 bit the sequence is seperate from state and therefore
+ * subject to a subtle race in the case of hostile takeovers.
+ *
+ * On 64 bit the sequence is part of the state and therefore safe
+ * vs. hostile takeovers.
+ *
+ * In case of fail the console has been taken over and @ctxt is
+ * invalid. Caller has to reacquire the console.
+ */
+#ifdef CONFIG_64BIT
+static bool __maybe_unused cons_sequence_try_update(struct cons_context *ctxt)
+{
+	struct console *con = ctxt->console;
+	struct cons_state old, new;
+
+	cons_state_read(con, STATE_REAL, &old);
+	do {
+		/* Full state compare including sequence */
+		if (!cons_state_full_match(old, ctxt->state))
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
+	} while (!cons_state_try_cmpxchg(con, STATE_REAL, &old, &new));
+
+	copy_full_state(ctxt->state, new);
+	ctxt->oldseq = ctxt->newseq;
+
+	return true;
+}
+#else
+static bool __maybe_unused cons_sequence_try_update(struct cons_context *ctxt)
+{
+	struct console *con = ctxt->console;
+	unsigned long old, new, cur;
+	struct cons_state state;
+	int pcpu;
+
+	/*
+	 * There is a corner case which needs to be considered here:
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
+	 * There is nothing which can be done about this other than having
+	 * yet another state bit which needs to be tracked and analyzed,
+	 * but fails to cover the problem completely.
+	 *
+	 * No other scenarios expose such a problem. On same CPU takeovers
+	 * the cmpxchg() always fails on the interrupted context after the
+	 * interrupting context finished printing, but that's fine as it
+	 * does not own the console anymore. The state check after the
+	 * failed cmpxchg prevents that.
+	 */
+	cons_state_read(con, STATE_REAL, &state);
+	/* Sequence is not part of cons_state on 32bit */
+	if (!cons_state_bits_match(state, ctxt->state))
+		return false;
+
+	/*
+	 * Get the original sequence number which was retrieved
+	 * from @con->atomic_seq. @con->atomic_seq should be still
+	 * the same. 32bit truncates. See cons_context_set_sequence().
+	 */
+	old = (unsigned long)ctxt->oldseq;
+	new = (unsigned long)ctxt->newseq;
+	cur = atomic_cmpxchg(&ACCESS_PRIVATE(con, atomic_seq), old, new);
+	if (cur == old) {
+		ctxt->oldseq = ctxt->newseq;
+		return true;
+	}
+
+	/*
+	 * Reread the state. If the state does not own the console anymore
+	 * then it cannot touch the sequence again.
+	 */
+	cons_state_read(con, STATE_REAL, &state);
+	/* Sequence is not part of cons_state on 32bit */
+	if (!cons_state_bits_match(state, ctxt->state))
+		return false;
+
+	/* If panic and not on the panic CPU, drop the lock */
+	pcpu = atomic_read(&panic_cpu);
+	if (pcpu != PANIC_CPU_INVALID && pcpu != smp_processor_id())
+		goto unlock;
+
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
+unlock:
+	cons_release(ctxt);
+	return false;
+}
+#endif
+
+/**
  * cons_cleanup_handover - Cleanup a handover request
  * @ctxt:	Pointer to acquire context
  *
@@ -519,6 +720,7 @@ static bool __cons_try_acquire(struct co
 		return false;
 success:
 	/* Common updates on success */
+	cons_context_sequence_init(ctxt);
 	cons_context_set_text_buf(ctxt);
 	return true;
 
@@ -529,7 +731,6 @@ static bool __cons_try_acquire(struct co
 	if (!cons_state_try_cmpxchg(con, STATE_REAL, &old, &new))
 		goto again;
 
-	ctxt->hostile = true;
 	copy_full_state(ctxt->state, new);
 	goto success;
 }
@@ -688,6 +889,7 @@ static void cons_nobkl_init(struct conso
 	};
 
 	cons_alloc_percpu_data(con);
+	cons_forward_sequence(con);
 	cons_state_set(con, STATE_REAL, &state);
 }
 

