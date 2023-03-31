Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1E16D1E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCaKgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCaKgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:36:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBE26A58
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 03:36:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 24AA71FE0F;
        Fri, 31 Mar 2023 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680258963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/SubNly6CNy9pHqgLfpvVWjY0D9U9M44eXnof6cb4U8=;
        b=YyN5ZLMeN5zxuWVUSTDLcPmuZPg0kv1H/eqWEU2sgqkwckKlpTYgNl+a+rmCgv3kY2Vyxp
        I2Kbi8kIKA3po/JqMoxjqTEb0AX0i6aiZNA7vPd+dVwLsPjycSYKNXTy0Bm0U3vdqTNa/W
        364FZK8iEHV+PGUys43Yb3HzzoL4qRk=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EDA8C2C141;
        Fri, 31 Mar 2023 10:36:02 +0000 (UTC)
Date:   Fri, 31 Mar 2023 12:36:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: semantic: Re: [PATCH printk v1 10/18] printk: nobkl: Add emit
 function and callback functions for atomic printing
Message-ID: <ZCa3kg960HJPf9Ko@alley>
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

This is inconsistent and a bit confusing. This seems to be the only
function returning "true" when there is no pending output.

All the other functions cons_get_record(), console_emit_next_record(),
and printk_get_next_message() return false in this case.

It has to distinguish 3 different return states anyway, same as
console_emit_next_record(). I suggest to use the same semantic
and distinguish "no pending records" and "handed over lock"
via a "handover" flag. Or maybe the caller should just check
if it still owns the lock.

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

I would expect this check in console_is_usable(), same as for legacy
consoles.

And what is actually the difference between con->write_atomic()
and con->write_thread(), where write_thread() is added later
in 11th patch?

I guess that the motivation is that the kthread variant
might sleep. But I do not see it described anywhere.

Do we really need two callbacks? I would expect that the code
would be basically the same.

Maybe, the callback could call cond_resched() when running
in kthread but this information might be passed via a flag.

Or is this a preparation for tty code where the implementation
would be really different?

> +		done = con->write_atomic(con, wctxt);
> +	} else {
> +		cons_release(ctxt);
> +		WARN_ON_ONCE(1);
> +		return false;
> +	}

Best Regards,
Petr
