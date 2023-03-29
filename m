Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDF16CDB85
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjC2OHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjC2OHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:07:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122D949EA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:06:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C3A9E1FDD4;
        Wed, 29 Mar 2023 14:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680098738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P4YiRKCGbb7zFcRYaCUV1Zc676ZtlP7PsjBe7l0/BPs=;
        b=lOvbzJadcgl48s3rzww1eI06mdCC2rs0luokW6svdLgzoB+5ceYPMPRFGeTw0GtBnF2JsU
        wLm/iy4Nchdgc0yC4ECR03ewUHxKz7MS0V/uh39HhpfjiL/dFxdBAAxxHJbUo+j/Ekwv1y
        QnQ+5VKiAYW1BkzivWL2MFq5HHsKrjI=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 94E422C16E;
        Wed, 29 Mar 2023 14:05:38 +0000 (UTC)
Date:   Wed, 29 Mar 2023 16:05:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: misc details: was: Re: [PATCH printk v1 09/18] printk: nobkl: Add
 print state functions
Message-ID: <ZCRFsu2VSmqTSGkS@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-10-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-10-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:09, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide three functions which are related to the safe handover
> mechanism and allow console drivers to denote takeover unsafe
> sections:
> 
>  - console_can_proceed()
> 
>    Invoked by a console driver to check whether a handover request
>    is pending or whether the console was taken over in a hostile
>    fashion.
> 
>  - console_enter/exit_unsafe()
> 
>    Invoked by a console driver to denote that the driver output
>    function is about to enter or to leave an critical region where a
>    hostile take over is unsafe. These functions are also
>    cancellation points.
> 
>    The unsafe state is stored in the console state and allows a
>    takeover attempt to make informed decisions whether to take over
>    and/or output on such a console at all. The unsafe state is also
>    available to the driver in the write context for the
>    atomic_write() output function so the driver can make informed
>    decisions about the required actions or take a special emergency
>    path.
> 
> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
> @@ -947,6 +947,145 @@ static void cons_free_percpu_data(struct console *con)
>  	con->pcpu_data = NULL;
>  }
>  
> +/**
> + * console_can_proceed - Check whether printing can proceed
> + * @wctxt:	The write context that was handed to the write function
> + *
> + * Returns:	True if the state is correct. False if a handover
> + *		has been requested or if the console was taken
> + *		over.
> + *
> + * Must be invoked after the record was dumped into the assigned record
> + * buffer and at appropriate safe places in the driver.  For unsafe driver
> + * sections see console_enter_unsafe().
> + *
> + * When this function returns false then the calling context is not allowed
> + * to go forward and has to back out immediately and carefully. The buffer
> + * content is no longer trusted either and the console lock is no longer
> + * held.
> + */
> +bool console_can_proceed(struct cons_write_context *wctxt)
> +{
> +	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	struct console *con = ctxt->console;
> +	struct cons_state state;
> +
> +	cons_state_read(con, CON_STATE_CUR, &state);
> +	/* Store it for analysis or reuse */
> +	copy_full_state(ctxt->old_state, state);
> +
> +	/* Make sure this context is still the owner. */
> +	if (!cons_state_full_match(state, ctxt->state))
> +		return false;
> +
> +	/*
> +	 * Having a safe point for take over and eventually a few
> +	 * duplicated characters or a full line is way better than a
> +	 * hostile takeover. Post processing can take care of the garbage.
> +	 * Continue if the requested priority is not sufficient.
> +	 */
> +	if (state.req_prio <= state.cur_prio)
> +		return true;
> +
> +	/*
> +	 * A console printer within an unsafe region is allowed to continue.
> +	 * It can perform the handover when exiting the safe region. Otherwise
> +	 * a hostile takeover will be necessary.
> +	 */
> +	if (state.unsafe)
> +		return true;

It took me quite some time to scratch my head around the above two comments.
The code is clear but the comments are somehow cryptic ;-)

It is probably because the 1st comment starts talking about a safe point.
But .unsafe is checked after the 2nd comment. And the word "allowed"
confused me in the 2nd comment.

I would explain this in these details in the function description. The
code will be self-explanatory then. I would write something like:

	 * The console is allowed to continue when it still owns the lock
	 * and there is no request from a higher priority context.
	 *
	 * The context might have lost the lock during a hostile takeover.
	 *
	 * The function will handover the lock when there is a request
	 * with a higher priority and the console is in a safe context.
	 * The new owner would print the same line again. But a duplicated
	 * part of a line is better than risking a hostile takeover in
	 * an unsafe context.

> +
> +	/* Release and hand over */
> +	cons_release(ctxt);
> +	/*
> +	 * This does not check whether the handover succeeded.

This is a bit ambiguous. What exactly means that the handover succeeded?
I guess that it means that the context with the higher priority
successfully took over the lock.

A "failure" might be when the other context timeouted and given up.
In that case, nobody would continue printing.

We actually should wake up the kthread when the lock was not
successfully passed. Or even better, we should release the lock
only when the request was still pending. It should be possible
with the cmpxchg().


> +	 * outermost callsite has to make the final decision whether printing
> +	 * should continue

This is a bit misleading. The current owner could not continue after
loosing the lock. It would need to re-start the entire operation.

Is this about the kthread or cons_flush*() layers? Yes, they have to
decide what to do next. Well, we should make it clear that we are talking
about this layer. The con->atomic_write() layer can only carefully
back off.

Maybe, we do not need to describe it here. It should be enough to
mention in the function description that the driver has to
carefully back off and that the buffer content is not longer
trusted. It is already mentioned there.

> +	 * or not (via reacquire, possibly hostile). The
> +	 * console is unlocked already so go back all the way instead of
> +	 * trying to implement heuristics in tons of places.
> +	 */
> +	return false;
> +}
> +
> +static bool __console_update_unsafe(struct cons_write_context *wctxt, bool unsafe)
 > +{
> +	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	struct console *con = ctxt->console;
> +	struct cons_state new;
> +
> +	do  {
> +		if (!console_can_proceed(wctxt))
> +			return false;
> +		/*
> +		 * console_can_proceed() saved the real state in
> +		 * ctxt->old_state
> +		 */
> +		copy_full_state(new, ctxt->old_state);
> +		new.unsafe = unsafe;
> +
> +	} while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &ctxt->old_state, &new));

This updates only the bit in struct cons_state. But there is also
"bool unsafe" in struct cons_write_context. Should the boolean
be updated as well?

Or is the boolean needed at all? It seems that it is set in
cons_emit_record() and never read.

> +
> +	copy_full_state(ctxt->state, new);
> +	return true;
> +}

Best Regards,
Petr
