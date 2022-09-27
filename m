Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4825EC4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiI0Ntc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiI0Nt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:49:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EA612477B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:49:26 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664286565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=doHCftpEX9Bx6E/ShqAhQuaabtZ/kVoIscZHD6AATYw=;
        b=PmGqo8G8nmlq6Qad5m4UnR2UyRR4LcnFeFOQ+8meMgFbcFJH/Vh7CbOPoaTJrtwr908frv
        tJ5QbIAG7iAT0oJ99YlJJCpcPWCTj2z5+YJaY9RBZoJL63tm38PXqissUVTc/Ovj/Utk/B
        2WmVpuMEeioqe1CPD+C60fPVnK0RCSmuyzSNf/NsAJySOC8tyH+iSqQyHVo4fkOWA5w4WN
        NwarhCoL93qXqy8+mPHV3nQl0wFcuhreYz+VPb1ssEa8kcAB3hhjmlk9ybMZQOyLf4B/yG
        dGaeitVPmvzW/AoybcCzk2NFN1fd9eKS8jkYDbWa72ArRJl6roRsJzW2L4AcQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664286565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=doHCftpEX9Bx6E/ShqAhQuaabtZ/kVoIscZHD6AATYw=;
        b=a04GMzPYCq8NE/6O1MMtwS6LZBlqAlYSYyc/rNOUoXr4XTOe13So0ftuBK5VP9Y/Quor4l
        P3deeF0oCQ3fykDA==
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
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
Subject: Re: [patch RFC 20/29] printk: Add non-BKL console acquire/release
 logic
In-Reply-To: <20220910222301.539158418@linutronix.de>
References: <20220910221947.171557773@linutronix.de>
 <20220910222301.539158418@linutronix.de>
Date:   Tue, 27 Sep 2022 15:55:24 +0206
Message-ID: <87tu4tkjvf.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a fix that was used for the LPC2022 demo so that a hostile
takeover upon timeout is possible.

On 2022-09-11, Thomas Gleixner <tglx@linutronix.de> wrote:
> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
> +/**
> + * __cons_try_acquire - Try to acquire the console for printk output
> + * @ctxt:	Pointer to an aquire context which contains
> + *		all information about the acquire mode
> + *
> + * Returns: True if the acquire was successful. False on fail.
> + *
> + * In case of success @ctxt->state contains the acquisition
> + * state.
> + *
> + * In case of fail @ctxt->old_state contains the state
> + * which was read from @con->state for analysis by the caller.
> + */
> +static bool __cons_try_acquire(struct cons_context *ctxt)
> +{
> +	struct console *con = ctxt->console;
> +	unsigned int cpu = smp_processor_id();
> +	struct cons_state old, new;
> +
> +	if (WARN_ON_ONCE(!(con->flags & CON_NO_BKL)))
> +		return false;
> +
> +	cons_state_read(con, STATE_REAL, &old);
> +
> +again:
> +	if (cons_check_panic())
> +		return false;
> +
> +	/* Preserve it for the caller and for spinwait */
> +	copy_full_state(ctxt->old_state, old);
> +
> +	if (!cons_state_ok(old))
> +		return false;
> +
> +	/* Set up the new state for takeover */
> +	copy_full_state(new, old);
> +	new.locked = 1;
> +	new.thread = ctxt->thread;
> +	new.cur_prio = ctxt->prio;
> +	new.req_prio = CONS_PRIO_NONE;
> +	new.cpu = cpu;
> +
> +	/* Attempt to acquire it directly if unlocked */
> +	if (!old.locked) {
> +		if (!cons_state_try_cmpxchg(con, STATE_REAL, &old, &new))
> +			goto again;
> +
> +		ctxt->hostile = false;
> +		copy_full_state(ctxt->state, new);
> +		goto success;
> +	}
> +
> +	/*
> +	 * Give up if the calling context is the printk thread. The
> +	 * atomic writer will wake the thread when it is done with
> +	 * the important output.
> +	 */
> +	if (ctxt->thread)
> +		return false;
> +
> +	/*
> +	 * If the active context is on the same CPU then there is
> +	 * obviously no handshake possible.
> +	 */
> +	if (old.cpu == cpu)
> +		goto check_hostile;
> +
> +	/*
> +	 * If the caller did not request spin-waiting or a request with the
> +	 * same or higher priority is pending then check whether a hostile
> +	 * takeover is due.
> +	 */
> +	if (!ctxt->spinwait || old.req_prio >= ctxt->prio)
> +		goto check_hostile;
> +
> +	/* Proceed further with spin acquire */
> +	if (!cons_setup_handover(ctxt))
> +		return false;
> +
> +	/*
> +	 * Setup the request in state[REAL]. Hand in the state, which was
> +	 * used to make the decision to spinwait above, for comparison.
> +	 */
> +	if (!cons_setup_request(ctxt, old))
> +		return false;
> +
> +	/* Now spin on it */
> +	if (!cons_try_acquire_spin(ctxt))
> +		return false;

Instead of returning false here, it needs to:

		goto check_hostile;

cons_try_acquire_spin() may have failed due to a timeout, in which case
a hostile takeover might be necessary.

> +success:
> +	/* Common updates on success */
> +	return true;
> +
> +check_hostile:
> +	if (!ctxt->hostile)
> +		return false;
> +
> +	if (!cons_state_try_cmpxchg(con, STATE_REAL, &old, &new))
> +		goto again;
> +
> +	ctxt->hostile = true;
> +	copy_full_state(ctxt->state, new);
> +	goto success;
> +}

John Ogness
