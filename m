Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B7C6C3709
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCUQiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCUQiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:38:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E2BC651
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:38:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D18E721E69;
        Tue, 21 Mar 2023 16:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679416684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75NZSyygx2lstlqfDbzVwOfIzbH0byOyQMOGCINC048=;
        b=f8P7m1ge3oRJfoNF9biJ7pOTtTZebdhtmKo+s7/L6kxMO76x2uSuMUC+rCI458nXMwNDBZ
        6IktAu2Ioz+zxPPPnZKlxBhMcpAOQ/PV5P3T4X/F/6lek9Z49kgH1Ox2n/s0aJiPeeuiyl
        CofInc3+fMM3Unh50RwQPnQjX9RuGnQ=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 75FDF2C141;
        Tue, 21 Mar 2023 16:38:04 +0000 (UTC)
Date:   Tue, 21 Mar 2023 17:38:01 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 07/18] printk: nobkl: Add buffer management
Message-ID: <ZBndaSUFd4ipvKwj@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-8-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:07, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> In case of hostile takeovers it must be ensured that the previous
> owner cannot scribble over the output buffer of the emergency/panic
> context. This is achieved by:
> 
>  - Adding a global output buffer instance for early boot (pre per CPU
>    data being available).
> 
>  - Allocating an output buffer per console for threaded printers once
>    printer threads become available.
> 
>  - Allocating per CPU output buffers per console for printing from
>    all contexts not covered by the other buffers.
> 
>  - Choosing the appropriate buffer is handled in the acquire/release
>    functions.
> 
> The output buffer is wrapped into a separate data structure so other
> context related fields can be added in later steps.
> 
> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
> @@ -166,6 +166,47 @@ static inline bool cons_check_panic(void)
>  	return pcpu != PANIC_CPU_INVALID && pcpu != smp_processor_id();
>  }
>  
> +static struct cons_context_data early_cons_ctxt_data __initdata;
> +
> +/**
> + * cons_context_set_pbufs - Set the output text buffer for the current context
> + * @ctxt:	Pointer to the acquire context
> + *
> + * Buffer selection:
> + *   1) Early boot uses the global (initdata) buffer
> + *   2) Printer threads use the dynamically allocated per-console buffers
> + *   3) All other contexts use the per CPU buffers
> + *
> + * This guarantees that there is no concurrency on the output records ever.
> + * Early boot and per CPU nesting is not a problem. The takeover logic
> + * tells the interrupted context that the buffer has been overwritten.
> + *
> + * There are two critical regions that matter:
> + *
> + * 1) Context is filling the buffer with a record. After interruption
> + *    it continues to sprintf() the record and before it goes to
> + *    write it out, it checks the state, notices the takeover, discards
> + *    the content and backs out.
> + *
> + * 2) Context is in a unsafe critical region in the driver. After
> + *    interruption it might read overwritten data from the output
> + *    buffer. When it leaves the critical region it notices and backs
> + *    out. Hostile takeovers in driver critical regions are best effort
> + *    and there is not much that can be done about that.
> + */
> +static __ref void cons_context_set_pbufs(struct cons_context *ctxt)
> +{
> +	struct console *con = ctxt->console;
> +
> +	/* Thread context or early boot? */
> +	if (ctxt->thread)
> +		ctxt->pbufs = con->thread_pbufs;
> +	else if (!con->pcpu_data)
> +		ctxt->pbufs = &early_cons_ctxt_data.pbufs;
> +	else
> +		ctxt->pbufs = &(this_cpu_ptr(con->pcpu_data)->pbufs);

What exactly do we need the per-CPU buffers for, please?
Is it for an early boot or panic or another scenario?

I would expect that per-console buffer should be enough.
The per-console atomic lock should define who owns
the per-console buffer. The buffer must be accessed
carefully because any context could loose the atomic lock.
Why is kthread special?

The per-CPU buffer actually looks dangerous. It might
be used by more NOBKL consoles. How is the access synchronized
please? By console_list_lock? It is not obvious to me.


On the contrary, we might need 4 static buffers for the early
boot. For example, one atomic console might start printing
in the normal context. Second atomic console might use
the same static buffer in IRQ context. But the first console
will not realize it because it did not loose the per-CPU
atomic lock when the CPU handled the interrupt..
Or is this handled another way, please?

Best Regards,
Petr
