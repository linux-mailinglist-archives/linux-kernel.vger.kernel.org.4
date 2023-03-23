Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329F96C69B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjCWNk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCWNkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:40:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8753CC05
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:40:23 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679578821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=wz8CZAPcIfmrZ68A0HMjB0hfrt/dOSiXceUwjv9ZVHg=;
        b=liS1kq1aSyvDxntjynw9h90Z9glCIIx9ZM5NF1O8hS1S0JhBwZt4p4SbG1BLe/iSQe1IIb
        SaG5rp7vIalY65mlQh5QbKYzFrp4cX3mMjociX3mPu7XtEDGTgkIAfSJXsh0XSYkfhOLy7
        qAhufqQy7P/TM75Ut10U54gQT6DKuGVuGRJi/9v0KBfYhNrXIBvAnNyalKNLQfLURvFcS0
        b+2QA9/uQ7ANUS0ozlB5Bi2+c38+k4KcgTtViGuL1wOGTZVzXBDdthPaxyBrGiW9uJyUUb
        Ug/vNZlhLsae49TYzIsVl+LmhfieUHY0xaRue2C2ToHEApmQ+uazDerJlhOEsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679578821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=wz8CZAPcIfmrZ68A0HMjB0hfrt/dOSiXceUwjv9ZVHg=;
        b=6UW0OIf1XpOZkmfsnjU4cE+ydQLhXYnwjA/x72JHaL5QNLXW2Nom5VF4+yLeLV3UuDU+/a
        RoVe5n3QfM4z2ZCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 07/18] printk: nobkl: Add buffer management
In-Reply-To: <ZBndaSUFd4ipvKwj@alley>
Date:   Thu, 23 Mar 2023 14:44:43 +0106
Message-ID: <87y1nna8po.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-21, Petr Mladek <pmladek@suse.com> wrote:
>> +static __ref void cons_context_set_pbufs(struct cons_context *ctxt)
>> +{
>> +	struct console *con = ctxt->console;
>> +
>> +	/* Thread context or early boot? */
>> +	if (ctxt->thread)
>> +		ctxt->pbufs = con->thread_pbufs;
>> +	else if (!con->pcpu_data)
>> +		ctxt->pbufs = &early_cons_ctxt_data.pbufs;
>> +	else
>> +		ctxt->pbufs = &(this_cpu_ptr(con->pcpu_data)->pbufs);
>
> What exactly do we need the per-CPU buffers for, please?
> Is it for an early boot or panic or another scenario?

In case of hostile takeovers, the panic context needs to have a buffer
that the previous context (on another CPU) will not scribble
in. Currently, hostile takeovers only occur during panics. In early boot
there is only 1 CPU.

> I would expect that per-console buffer should be enough.
> The per-console atomic lock should define who owns
> the per-console buffer. The buffer must be accessed
> carefully because any context could loose the atomic lock.

A context will string-print its message into the buffer. During the
string-print it cannot check if it is still the owner. Another CPU may
be already actively printing on that console.

> Why is kthread special?

I believe the idea was that the kthread is not bound to any CPU. But
since migration must be disabled when acquiring the console, there is no
purpose for the kthread to have its own buffer. I will remove it.

> The per-CPU buffer actually looks dangerous. It might
> be used by more NOBKL consoles. How is the access synchronized
> please? By console_list_lock? It is not obvious to me.

Each console has its own set of per-CPU buffers (con->pcpu_data).

> On the contrary, we might need 4 static buffers for the early
> boot. For example, one atomic console might start printing
> in the normal context. Second atomic console might use
> the same static buffer in IRQ context. But the first console
> will not realize it because it did not loose the per-CPU
> atomic lock when the CPU handled the interrupt..
> Or is this handled another way, please?

You are correct! Although I think 3 initdata static buffers should
suffice. (2 if the system does not support NMI).


Your feedback points out that we are allocating a lot of extra memory
for the rare case of a hostile takeover from another CPU when in
panic. I suppose it would be enough to have a single dedicated panic
buffer to use in this case.

With all that in mind, we would have 3 initdata early buffers, a single
panic buffer, and per-console buffers. So the function would look
something like this:

static __ref void cons_context_set_pbufs(struct cons_context *ctxt)
{
	struct console *con = ctxt->console;

	if (atomic_read(&panic_cpu) == smp_processor_id())
		ctxt->pbufs = &panic_ctxt_data.pbufs;
	else if (con->pbufs)
		ctxt->pbufs = con->pbufs;
	else
		ctxt->pbufs = &early_cons_ctxt_data[early_nbcon_nested].pbufs;
}

It should be enough to increment @early_nbcon_nested in cons_get_wctxt()
and decrement it in a new cons_put_wctxt() that is called after
cons_atomic_flush_con().


Originally in tglx's design, hostile takeovers were allowed at any time,
which requires the per-CPU data per console. His idea was that the
policy about hostile takeovers should be implemented outside the nbcons
framework. However, with this newly proposed change in order to avoid
per-CPU buffers for every console, we are adding an implicit rule that
hostile takeovers only occur at panic. Maybe it is ok to hard-code this
particular policy. It would certainly save significant buffer space and
I not sure if hostile takeovers make sense outside of a panic context.

John
