Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525A16D1E11
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjCaKaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjCaK3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:29:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F289E7A9B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 03:29:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 579EB1F38C;
        Fri, 31 Mar 2023 10:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680258568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cqk+/mgelxAe37WJGeLVsBj9xDPakPqxm+xgKscnXIU=;
        b=UqmNGB2r1woQ6QiNgWIgXS65HuFybCsoz4OueIC5L1w/lrWk9tuB97FkUN4N1aJR4R+ZpD
        XfVwj3CXjOSnuTqKIbwIKP4ltMUBXRKRxiZC+1uiAm8SiV2scURs2JldM9v9jnn2nuSruC
        Vbz5+MFi4VSNbw/IplBi249Wl5lAqT8=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EF15C2C141;
        Fri, 31 Mar 2023 10:29:27 +0000 (UTC)
Date:   Fri, 31 Mar 2023 12:29:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: dropped handling: was: Re: [PATCH printk v1 10/18] printk: nobkl:
 Add emit function and callback functions for atomic printing
Message-ID: <ZCa2B3LxPW67mt6j@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-11-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:10, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Implement an emit function for non-BKL consoles to output printk
> messages. It utilizes the lockless printk_get_next_message() and
> console_prepend_dropped() functions to retrieve/build the output
> message. The emit function includes the required safety points to
> check for handover/takeover and calls a new write_atomic callback
> of the console driver to output the message. It also includes proper
> handling for updating the non-BKL console sequence number.
> 
> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
> @@ -1086,6 +1086,123 @@ bool console_exit_unsafe(struct cons_write_context *wctxt)
>  	return __console_update_unsafe(wctxt, false);
>  }
>  
> +/**
> + * cons_get_record - Fill the buffer with the next pending ringbuffer record
> + * @wctxt:	The write context which will be handed to the write function
> + *
> + * Returns:	True if there are records available. If the next record should
> + *		be printed, the output buffer is filled and @wctxt->outbuf
> + *		points to the text to print. If @wctxt->outbuf is NULL after
> + *		the call, the record should not be printed but the caller must
> + *		still update the console sequence number.
> + *
> + *		False means that there are no pending records anymore and the
> + *		printing can stop.
> + */
> +static bool cons_get_record(struct cons_write_context *wctxt)
> +{
> +	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	struct console *con = ctxt->console;
> +	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
> +	struct printk_message pmsg = {
> +		.pbufs = ctxt->pbufs,
> +	};
> +
> +	if (!printk_get_next_message(&pmsg, ctxt->newseq, is_extended, true))
> +		return false;
> +
> +	ctxt->newseq = pmsg.seq;
> +	ctxt->dropped += pmsg.dropped;
> +
> +	if (pmsg.outbuf_len == 0) {
> +		wctxt->outbuf = NULL;
> +	} else {
> +		if (ctxt->dropped && !is_extended)
> +			console_prepend_dropped(&pmsg, ctxt->dropped);
> +		wctxt->outbuf = &pmsg.pbufs->outbuf[0];
> +	}
> +
> +	wctxt->len = pmsg.outbuf_len;

This function seems to be needed only because we duplicate the information
in both struct printk_message and struct cons_write_context.

I think that we will not need this function at all if we bundle
struct printk_message into struct cons_context. I mean to replace:

struct cons_context {
	[...]
	struct printk_buffers	*pbufs;
	u64			newseq;
	unsigned long		dropped;
	[...]
}

with

struct cons_context {
	[...]
	struct printk_message pmsg;
	[...]
}

> +
> +	return true;
> +}
> +
> +/**
> + * cons_emit_record - Emit record in the acquired context
> + * @wctxt:	The write context that will be handed to the write function
> + *
> + * Returns:	False if the operation was aborted (takeover or handover).
> + *		True otherwise
> + *
> + * When false is returned, the caller is not allowed to touch console state.
> + * The console is owned by someone else. If the caller wants to print more
> + * it has to reacquire the console first.
> + *
> + * When true is returned, @wctxt->ctxt.backlog indicates whether there are
> + * still records pending in the ringbuffer,
> + */
> +static int __maybe_unused cons_emit_record(struct cons_write_context *wctxt)
> +{
> +	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	struct console *con = ctxt->console;
> +	bool done = false;
> +
> +	/*
> +	 * @con->dropped is not protected in case of hostile takeovers so
> +	 * the update below is racy. Annotate it accordingly.
> +	 */
> +	ctxt->dropped = data_race(READ_ONCE(con->dropped));
> +
> +	/* Fill the output buffer with the next record */
> +	ctxt->backlog = cons_get_record(wctxt);
> +	if (!ctxt->backlog)
> +		return true;
> +
> +	/* Safety point. Don't touch state in case of takeover */
> +	if (!console_can_proceed(wctxt))
> +		return false;
> +
> +	/* Counterpart to the read above */
> +	WRITE_ONCE(con->dropped, ctxt->dropped);

These racy hacks with ctxt-> dropped won't be needed if we bundle
strcut printk_message into struct cons_context.

> +
> +	/*
> +	 * In case of skipped records, Update sequence state in @con.
> +	 */
> +	if (!wctxt->outbuf)
> +		goto update;
> +
> +	/* Tell the driver about potential unsafe state */
> +	wctxt->unsafe = ctxt->state.unsafe;
> +
> +	if (!ctxt->thread && con->write_atomic) {
> +		done = con->write_atomic(con, wctxt);
> +	} else {
> +		cons_release(ctxt);
> +		WARN_ON_ONCE(1);
> +		return false;
> +	}
> +
> +	/* If not done, the write was aborted due to takeover */
> +	if (!done)
> +		return false;
> +
> +	/* If there was a dropped message, it has now been output. */
> +	if (ctxt->dropped) {
> +		ctxt->dropped = 0;
> +		/* Counterpart to the read above */
> +		WRITE_ONCE(con->dropped, ctxt->dropped);

I suggest to use atomic_t for con->dropped and use

		atomic_sub(ctxt->dropped, &con->dropped);

> +	}
> +update:
> +	ctxt->newseq++;
> +	/*
> +	 * The sequence update attempt is not part of console_release()
> +	 * because in panic situations the console is not released by
> +	 * the panic CPU until all records are written. On 32bit the
> +	 * sequence is separate from state anyway.
> +	 */
> +	return cons_seq_try_update(ctxt);
> +}

Best Regards,
Petr
