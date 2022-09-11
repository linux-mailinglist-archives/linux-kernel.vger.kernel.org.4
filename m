Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FCD5B4A8E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiIJW3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiIJW2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:28:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1772243606
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:28:05 -0700 (PDT)
Message-ID: <20220910222301.539158418@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+saMLYDsS/m2enf6TfMEaB5aiB2N6jXCMDiRdRXMaJ0=;
        b=YiwMm7paqOmXf2P471+wibGaaUi7aDiCXQW7wzvpdOsuKaeYPuESnTMrngiRXaSwjQpQHi
        WylGAfHPApkK9UbhOlixf/PoNnUqD8LSN7ZjVmju1tMwoS8Xk45QgskWz5PNlD64gBE2zE
        Ni5aX1hPTVcrvRylir67jf77v3pB5j3UwXHUBw3wimm0haE27z/aRryJYzlItH2vg0JIj7
        klP11t+KG/ArL5Ws2Hn5qrw6OdbbFdpso2YNMXIaoAs+he1jszEBCmiRkNio8cIcyTTFcm
        skxgdO49YrGCy0RAhOXyFNDspPnO7xBizh7oiFryjUUnVHpPEWZNdYKaOY/SQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+saMLYDsS/m2enf6TfMEaB5aiB2N6jXCMDiRdRXMaJ0=;
        b=FJvMaosjU7/7c8GrFhD/LHeklWdNpKdGzZK1VtNt7TtwUEGgJxmYcGLqiWjzI5v6ouF8Et
        Oy88M1S89YDkRLDw==
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
Subject: [patch RFC 20/29] printk: Add non-BKL console acquire/release logic
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:28:02 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add per console acquire/release functionality. The console 'locked' state
is a combination of several state fields:

  - The 'locked' bit

  - The 'cpu' field which denotes on which CPU the console is locked
  
  - The 'cur_prio' field which contains the severity of the printk context
    which owns the console. This field is used for decisions whether to
    attempt friendly handovers and also prevents takeovers from a less
    severe context, e.g. to protect the panic CPU.

The acquire mechanism comes with several flavours:

  - Straight forward acquire when the console is not contended

  - Friendly handover mechanism based on a request/grant handshake

    The requesting context:

      1) puts the desired handover state (CPU nr, prio) into a seperate
         handover state

      2) sets the 'req_prio' field in the real console state

      3) Waits for the owning context to handover with a timeout

    The owning context:

      1) Observes the 'req_prio' field set

      2) Hands the console over to the requesting context by switching
      	 the console state to the handover state which the requester
	 provided
    
  - Hostile takeover

      The new owner takes the console over without handshake

      This is required when friendly handovers are not possible, i.e. the
      higher priority context interrupted the owning context on the same
      CPU or the owning context is not able to make progress on a remote
      CPU.

The release is the counterpart which either releases the console directly
or hands it gracefully over to a requester.

All operations on console::atomic_state[REAL|HANDOVER} are atomic cmpxchg
based to handle concurrency.

The acquire/release functions implement only minimal policies:

  - Preference for higher priority contexts
  - Protection of the panic CPU

All other policy decisions have to be made at the call sites.

The design allows to implement the well known:

    acquire()
    output_one_line()
    release()

algorithm, but also allows to avoid the per line acquire/release for
e.g. panic situations by doing the acquire once and then relying on
the panic CPU protection for the rest.

Co-Developed-by: John Ogness <jogness@linutronix.de>
Signed-off-by: John Ogness <jogness@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h      |   63 +++++
 kernel/printk/printk_nobkl.c |  466 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 529 insertions(+)

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -183,6 +183,12 @@ enum cons_flags {
  *
  * @alive:	Console is alive. Required for teardown
  * @enabled:	Console is enabled. If 0, do not use
+ * @locked:	Console is locked by a writer
+ * @unsafe:	Console is busy in a non takeover region
+ * @thread:	Current owner is the printk thread
+ * @cur_prio:	The priority of the current output
+ * @req_prio:	The priority of a handover request
+ * @cpu:	The CPU on which the writer runs
  *
  * To be used for state read and preparation of atomic_long_cmpxchg()
  * operations.
@@ -199,6 +205,12 @@ struct cons_state {
 				struct {
 					u32 alive	:  1;
 					u32 enabled	:  1;
+					u32 locked	:  1;
+					u32 unsafe	:  1;
+					u32 thread	:  1;
+					u32 cur_prio	:  2;
+					u32 req_prio	:  2;
+					u32 cpu		: 18;
 				};
 			};
 		};
@@ -233,6 +245,56 @@ struct cons_outbuf_desc {
 };
 
 /**
+ * cons_prio - console writer priority for NOBKL consoles
+ * @CONS_PRIO_NONE:		Unused
+ * @CONS_PRIO_NORMAL:		Regular printk
+ * @CONS_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
+ * @CONS_PRIO_PANIC:		Panic output
+ *
+ * Emergency output can carefully takeover the console even without consent
+ * of the owner, ideally only when @cons_state::unsafe is not set. Panic
+ * output can ignore the unsafe flag as a last resort. If panic output is
+ * active no takeover is possible until the panic output releases the
+ * console.
+ */
+enum cons_prio {
+	CONS_PRIO_NONE = 0,
+	CONS_PRIO_NORMAL,
+	CONS_PRIO_EMERGENCY,
+	CONS_PRIO_PANIC,
+};
+
+struct console;
+
+/**
+ * struct cons_context - Context for console acquire/release
+ * @console:		The associated console
+ * @state:		The state at acquire time
+ * @old_state:		The old state when try_acquire() failed for analyis
+ *			by the caller
+ * @hov_state:		The handover state for spin and cleanup
+ * @req_state:		The request state for spin and cleanup
+ * @spinwait_max_us:	Limit for spinwait acquire
+ * @prio:		Priority of the context
+ * @thread:		The acquire is printk thread context
+ * @hostile:		Hostile takeover requested. Cleared on normal
+ *			acquire or friendly handover
+ * @spinwait:		Spinwait on acquire if possible
+ */
+struct cons_context {
+	struct console		*console;
+	struct cons_state	state;
+	struct cons_state	old_state;
+	struct cons_state	hov_state;
+	struct cons_state	req_state;
+	unsigned int		spinwait_max_us;
+	enum cons_prio		prio;
+	unsigned int		thread		: 1;
+	unsigned int		hostile		: 1;
+	unsigned int		spinwait	: 1;
+};
+
+/**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
  * @write:		Write callback to output messages (Optional)
@@ -275,6 +337,7 @@ struct console {
 
 	/* NOBKL console specific members */
 	atomic_long_t __private	atomic_state[2];
+
 };
 
 #ifdef CONFIG_LOCKDEP
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -144,6 +144,472 @@ static void cons_state_enable(struct con
 }
 
 /**
+ * cons_state_ok - Check whether state is ok for usage
+ * @state:	The state to check
+ *
+ * Returns: True if usable, false otherwise.
+ */
+static inline bool cons_state_ok(struct cons_state state)
+{
+	return state.alive && state.enabled;
+}
+
+/**
+ * cons_state_full_match - Check whether the full state matches
+ * @cur:	The state to check
+ * @prev:	The previous state
+ *
+ * Returns: True if matching, false otherwise.
+ *
+ * Check the full state including state::seq on 64bit. For take over
+ * detection.
+ */
+static inline bool cons_state_full_match(struct cons_state cur,
+					 struct cons_state prev)
+{
+	/*
+	 * req_prio can be set by a concurrent writer for friendly
+	 * handover. Ignore it in the comparison.
+	 */
+	cur.req_prio = prev.req_prio;
+	return cur.atom == prev.atom;
+}
+
+/**
+ * cons_state_bits_match - Check for matching state bits
+ * @cur:	The state to check
+ * @prev:	The previous state
+ *
+ * Returns: True if state matches, false otherwise.
+ *
+ * Contrary to cons_state_full_match this checks only the bits and ignores
+ * a sequence change on 64bits. On 32bit the two functions are identical.
+ */
+static inline bool cons_state_bits_match(struct cons_state cur,
+					  struct cons_state prev)
+{
+	/*
+	 * req_prio can be set by a concurrent writer for friendly
+	 * handover. Ignore it in the comparison.
+	 */
+	cur.req_prio = prev.req_prio;
+	return cur.bits == prev.bits;
+}
+
+/**
+ * cons_check_panic - Check whether a remote CPU paniced
+ */
+static inline bool cons_check_panic(void)
+{
+	unsigned int pcpu = atomic_read(&panic_cpu);
+
+	return pcpu != PANIC_CPU_INVALID && pcpu != smp_processor_id();
+}
+
+/**
+ * cons_cleanup_handover - Cleanup a handover request
+ * @ctxt:	Pointer to acquire context
+ *
+ * @ctxt->hov_state contains the state to clean up
+ */
+static void cons_cleanup_handover(struct cons_context *ctxt)
+{
+	struct console *con = ctxt->console;
+	struct cons_state new;
+
+	/*
+	 * No loop required. Either hov_state is still the same or
+	 * not.
+	 */
+	new.atom = 0;
+	cons_state_try_cmpxchg(con, STATE_HANDOVER, &ctxt->hov_state, &new);
+}
+
+/**
+ * cons_setup_handover - Setup a handover request
+ * @ctxt:	Pointer to acquire context
+ *
+ * On success @ctxt->hov_state contains the requested handover state
+ */
+static bool cons_setup_handover(struct cons_context *ctxt)
+{
+	unsigned int cpu = smp_processor_id();
+	struct console *con = ctxt->console;
+	struct cons_state old;
+	struct cons_state hstate = {
+		.alive		= 1,
+		.enabled	= 1,
+		.locked		= 1,
+		.cur_prio	= ctxt->prio,
+		.cpu		= cpu,
+	};
+
+	/*
+	 * Try to store hstate in @con->atomic_state[HANDOVER]. This might
+	 * race with a higher priority waiter.
+	 */
+	cons_state_read(con, STATE_HANDOVER, &old);
+	do {
+		if (cons_check_panic())
+			return false;
+
+		/* Same or higher priority waiter exists? */
+		if (old.cur_prio >= ctxt->prio)
+			return false;
+
+	} while (!cons_state_try_cmpxchg(con, STATE_HANDOVER, &old, &hstate));
+
+	copy_full_state(ctxt->hov_state, hstate);
+	return true;
+}
+
+/**
+ * cons_setup_request - Setup a handover request in state[REAL]
+ * @ctxt:	Pointer to acquire context
+ * @old:	The state which was used to make the decision to spin wait
+ *
+ * @ctxt->hov_state contains the handover state which was set in
+ * state[HANDOVER]
+ */
+static bool cons_setup_request(struct cons_context *ctxt, struct cons_state old)
+{
+	struct console *con = ctxt->console;
+	struct cons_state cur, new;
+
+	/* Now set the request in state[REAL] */
+	cons_state_read(con, STATE_REAL, &cur);
+	do {
+		if (cons_check_panic())
+			goto cleanup;
+
+		/* Bit state changed vs. the decision to spinwait? */
+		if (!cons_state_bits_match(cur, old))
+			goto cleanup;
+
+		/* Setup a request for handover. */
+		copy_full_state(new, cur);
+		new.req_prio = ctxt->prio;
+	} while (!cons_state_try_cmpxchg(con, STATE_REAL, &cur, &new));
+
+	/* Safe that state for comparision in spinwait */
+	copy_bit_state(ctxt->req_state, new);
+	return true;
+
+cleanup:
+	cons_cleanup_handover(ctxt);
+	return false;
+}
+
+/**
+ * cons_try_acquire_spin - Complete the spinwait attempt
+ * @ctxt:	Pointer to an aquire context which contains
+ *		all information about the acquire mode
+ *
+ * @ctxt->hov_state contains the handover state which was set in
+ * state[HANDOVER]
+ * @ctxt->req_state contains the request state which was set in
+ * state[REAL]
+ *
+ * Returns: True if locked. False otherwise
+ */
+static bool cons_try_acquire_spin(struct cons_context *ctxt)
+{
+	struct console *con = ctxt->console;
+	struct cons_state cur, new;
+	bool ret = false;
+	int timeout;
+
+	/* Now wait for the other side to hand over */
+	for (timeout = ctxt->spinwait_max_us; timeout >= 0; timeout--) {
+		if (cons_check_panic())
+			goto cleanup;
+
+		cons_state_read(con, STATE_REAL, &cur);
+		/*
+		 * This might have raced with a new requester coming in
+		 * after the lock was handed over. So the request pends now
+		 * for the current context with higher priority.
+		 */
+		if (cons_state_bits_match(cur, ctxt->hov_state))
+			goto success;
+
+		/*
+		 * When state changed since the request was made give up as
+		 * it is not longer consistent. This must include
+		 * state::req_prio.
+		 */
+		if (cur.bits != ctxt->req_state.bits)
+			goto cleanup;
+
+		/*
+		 * Finally check whether the handover state is still
+		 * the same.
+		 */
+		cons_state_read(con, STATE_HANDOVER, &cur);
+		if (cur.atom != ctxt->hov_state.atom)
+			goto cleanup;
+
+		/* Account time */
+		udelay(1);
+	}
+
+	/*
+	 * Timeout. Cleanup the handover state and carefully try to undo
+	 * req_prio in real state.
+	 */
+	cons_cleanup_handover(ctxt);
+
+	cons_state_read(con, STATE_REAL, &cur);
+	do {
+		/*
+		 * The timeout might have raced with the owner coming late
+		 * and handing it over gracefully.
+		 */
+		if (cur.bits == ctxt->hov_state.bits)
+			goto success;
+		/*
+		 * Validate that the state matches with the state at
+		 * request time.
+		 */
+		if (cur.bits != ctxt->req_state.bits)
+			return false;
+
+		copy_full_state(new, cur);
+		new.req_prio = 0;
+	} while (!cons_state_try_cmpxchg(con, STATE_REAL, &cur, &new));
+	/* Reset worked */
+	return false;
+
+success:
+	/* Store the real state */
+	copy_full_state(ctxt->state, cur);
+	ctxt->hostile = false;
+	ret = true;
+
+cleanup:
+	cons_cleanup_handover(ctxt);
+	return ret;
+}
+
+/**
+ * __cons_try_acquire - Try to acquire the console for printk output
+ * @ctxt:	Pointer to an aquire context which contains
+ *		all information about the acquire mode
+ *
+ * Returns: True if the acquire was successful. False on fail.
+ *
+ * In case of success @ctxt->state contains the acquisition
+ * state.
+ *
+ * In case of fail @ctxt->old_state contains the state
+ * which was read from @con->state for analysis by the caller.
+ */
+static bool __cons_try_acquire(struct cons_context *ctxt)
+{
+	struct console *con = ctxt->console;
+	unsigned int cpu = smp_processor_id();
+	struct cons_state old, new;
+
+	if (WARN_ON_ONCE(!(con->flags & CON_NO_BKL)))
+		return false;
+
+	cons_state_read(con, STATE_REAL, &old);
+
+again:
+	if (cons_check_panic())
+		return false;
+
+	/* Preserve it for the caller and for spinwait */
+	copy_full_state(ctxt->old_state, old);
+
+	if (!cons_state_ok(old))
+		return false;
+
+	/* Set up the new state for takeover */
+	copy_full_state(new, old);
+	new.locked = 1;
+	new.thread = ctxt->thread;
+	new.cur_prio = ctxt->prio;
+	new.req_prio = CONS_PRIO_NONE;
+	new.cpu = cpu;
+
+	/* Attempt to acquire it directly if unlocked */
+	if (!old.locked) {
+		if (!cons_state_try_cmpxchg(con, STATE_REAL, &old, &new))
+			goto again;
+
+		ctxt->hostile = false;
+		copy_full_state(ctxt->state, new);
+		goto success;
+	}
+
+	/*
+	 * Give up if the calling context is the printk thread. The
+	 * atomic writer will wake the thread when it is done with
+	 * the important output.
+	 */
+	if (ctxt->thread)
+		return false;
+
+	/*
+	 * If the active context is on the same CPU then there is
+	 * obviously no handshake possible.
+	 */
+	if (old.cpu == cpu)
+		goto check_hostile;
+
+	/*
+	 * If the caller did not request spin-waiting or a request with the
+	 * same or higher priority is pending then check whether a hostile
+	 * takeover is due.
+	 */
+	if (!ctxt->spinwait || old.req_prio >= ctxt->prio)
+		goto check_hostile;
+
+	/* Proceed further with spin acquire */
+	if (!cons_setup_handover(ctxt))
+		return false;
+
+	/*
+	 * Setup the request in state[REAL]. Hand in the state, which was
+	 * used to make the decision to spinwait above, for comparison.
+	 */
+	if (!cons_setup_request(ctxt, old))
+		return false;
+
+	/* Now spin on it */
+	if (!cons_try_acquire_spin(ctxt))
+		return false;
+success:
+	/* Common updates on success */
+	return true;
+
+check_hostile:
+	if (!ctxt->hostile)
+		return false;
+
+	if (!cons_state_try_cmpxchg(con, STATE_REAL, &old, &new))
+		goto again;
+
+	ctxt->hostile = true;
+	copy_full_state(ctxt->state, new);
+	goto success;
+}
+
+/**
+ * cons_try_acquire - Try to acquire the console for printk output
+ * @ctxt:	Pointer to an aquire context which contains
+ *		all information about the acquire mode
+ *
+ * Returns: True if the acquire was successful. False on fail.
+ *
+ * In case of success @ctxt->state contains the acquisition
+ * state.
+ *
+ * In case of fail @ctxt->old_state contains the state
+ * which was read from @con->state for analysis by the caller.
+ */
+static bool __maybe_unused cons_try_acquire(struct cons_context *ctxt)
+{
+	if (__cons_try_acquire(ctxt))
+		return true;
+
+	ctxt->state.atom = 0;
+	return false;
+}
+
+/**
+ * __cons_release - Release the console after output is done
+ * @ctxt:	The acquire context which contains the state
+ *		at cons_try_acquire()
+ *
+ * Returns:	True if the release was regular
+ *
+ *		False if the console is in unusable state or was handed over
+ *		with handshake or taken	over hostile without handshake.
+ *
+ * The return value tells the caller whether it needs to evaluate further
+ * printing.
+ */
+static bool __cons_release(struct cons_context *ctxt)
+{
+	struct console *con = ctxt->console;
+	struct cons_state old, new, hstate;
+
+	if (WARN_ON_ONCE(!(con->flags & CON_NO_BKL)))
+		return false;
+
+	cons_state_read(con, STATE_REAL, &old);
+
+again:
+	if (!cons_state_full_match(old, ctxt->state))
+		return false;
+
+	/*
+	 * Release it directly when:
+	 * - the console has been disabled
+	 * - no handover request is pending
+	 */
+	if (!cons_state_ok(old) || !old.req_prio)
+		goto unlock;
+
+	/* Read the handover target state */
+	cons_state_read(con, STATE_HANDOVER, &hstate);
+
+	/* If the waiter gave up hstate is 0 */
+	if (!hstate.atom)
+		goto unlock;
+
+	/*
+	 * If a higher priority waiter raced against a lower priority
+	 * waiter then wait for it to update the real state.
+	 */
+	if (hstate.cur_prio != old.req_prio)
+		goto again;
+
+	/* Switch the state and preserve the sequence on 64bit */
+	copy_bit_state(new, hstate);
+	copy_seq_state64(new, old);
+	if (!cons_state_try_cmpxchg(con, STATE_REAL, &old, &new))
+		goto again;
+
+	return true;
+
+unlock:
+	copy_full_state(new, old);
+	new.locked = 0;
+	new.thread = 0;
+	new.cur_prio = CONS_PRIO_NONE;
+	new.req_prio = CONS_PRIO_NONE;
+
+	if (!cons_state_try_cmpxchg(con, STATE_REAL, &old, &new))
+		goto again;
+
+	return true;
+}
+
+/**
+ * cons_release - Release the console after output is done
+ * @ctxt:	The acquire context which contains the state
+ *		at cons_try_acquire()
+ *
+ * Returns:	True if the release was regular
+ *
+ *		False if the console is in unusable state or was handed over
+ *		with handshake or taken	over hostile without handshake.
+ *
+ * The return value tells the caller whether it needs to evaluate further
+ * printing.
+ */
+static bool __maybe_unused cons_release(struct cons_context *ctxt)
+{
+	bool ret = __cons_release(ctxt);
+
+	ctxt->state.atom = 0;
+	return ret;
+}
+
+/**
  * cons_nobkl_init - Initialize the NOBKL console state
  * @con:	Console to initialize
  */

