Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968595EC9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiI0Qkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiI0Qkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:40:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC6167076
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:40:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 79EDE1F37C;
        Tue, 27 Sep 2022 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664296816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y3MNsK5Wblnnj0OIrBf9gzOOF4wNby6S9EWKZMBC5Bk=;
        b=tnwmduoE2AerCmmDO2b0OOpdFvTWbHnSsd/tb5TsjLkGL5VhimgxWF+lVI5WjkyJ+jUKbv
        OqFY7OjYaBc4lywySTtjG2Qm/nVifAv4M2ZIuLKf9teuj4NPrVKbfojxHzZo+/hl5yzxCx
        DVaHpwtux5yUXadOEgeFWL+KKFk/myw=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DDC412C16B;
        Tue, 27 Sep 2022 16:40:15 +0000 (UTC)
Date:   Tue, 27 Sep 2022 18:40:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 2/2] lib/vsprintf: Initialize vsprintf's pointer hash
 once the random core is ready.
Message-ID: <YzMnb8NWlCpqsqSG@alley>
References: <20220927104912.622645-1-bigeasy@linutronix.de>
 <20220927104912.622645-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927104912.622645-3-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-09-27 12:49:12, Sebastian Andrzej Siewior wrote:
> The printk code invokes vnsprintf in order to compute the complete
> string before adding it into its buffer. This happens in an IRQ-off
> region which leads to a warning on PREEMPT_RT in the random code if the
> format strings contains a %p for pointer printing. This happens because
> the random core acquires locks which become sleeping locks on PREEMPT_RT
> which must not be acquired with disabled interrupts and or preemption
> disabled.
> By default the pointers are hashed which requires a random value on the
> first invocation (either by printk or another user which comes first.
> 
> One could argue that there is no need for printk to disable interrupts
> during the vsprintf() invocation which would fix the just mentioned
> problem. However printk itself can be invoked in a context with
> disabled interrupts which would lead to the very same problem.
> 
> Move the initialization of ptr_key into a worker and schedule it from
> subsys_initcall(). This happens early but after the workqueue subsystem
> is ready. Use get_random_bytes() to retrieve the random value if the RNG
> core is ready, otherwise schedule a worker in two seconds and try again.

Another advantage is that it removes a nested lock from the printk()
code path. A deadlock was partly prevented by the trylock. But there was
still a risk of a deadlock when printk() was called under base_crng.lock.

> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  lib/vsprintf.c | 44 ++++++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index bce63cbf23779..44b39ba56b796 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -751,31 +751,39 @@ static int __init debug_boot_weak_hash_enable(char *str)
>  early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
>  
>  static bool filled_random_ptr_key __read_mostly;
> +static siphash_key_t ptr_key __read_mostly;
> +static void fill_ptr_key_workfn(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(fill_ptr_key_work, fill_ptr_key_workfn);
> +
> +static void fill_ptr_key_workfn(struct work_struct *work)
> +{
> +	if (!rng_is_initialized()) {
> +		queue_delayed_work(system_unbound_wq, &fill_ptr_key_work, HZ  * 2);

Is there any particular reason not to use system_wq, please?

The unbound workqueue should be used only in special situations:

--- cut Documentation/core-api/workqueue.rst ---
``WQ_UNBOUND``
  Work items queued to an unbound wq are served by the special
  worker-pools which host workers which are not bound to any
  specific CPU.  This makes the wq behave as a simple execution
  context provider without concurrency management.  The unbound
  worker-pools try to start execution of work items as soon as
  possible.  Unbound wq sacrifices locality but is useful for
  the following cases.

  * Wide fluctuation in the concurrency level requirement is
    expected and using bound wq may end up creating large number
    of mostly unused workers across different CPUs as the issuer
    hops through different CPUs.

  * Long running CPU intensive workloads which can be better
    managed by the system scheduler.
--- cut ---

The thing is that unbound workqueues always process work items
in parallel. They create new workers when there is no idle one.

In compare, system_wq serializes the work items. They use
another worker only when a busy one goes into a sleep.
It is perfectly fine and preferred for work items that
do not need much CPU time.

I have tried it and system_wq works well here. It actually
even initializes the hash earlier here. But it is only by chance
because it happens on the 2nd attempt instead of 3rd one.

> +		return;
> +	}
> +
> +	get_random_bytes(&ptr_key, sizeof(ptr_key));
> +
> +	/* Pairs with smp_rmb() before reading ptr_key. */
> +	smp_wmb();
> +	WRITE_ONCE(filled_random_ptr_key, true);
> +}

With "system_wq":

Reviewed-by: Petr Mladek <pmladek@suse.com>

I could replace "system_unbound_wq" with "system_wq" when
pushing. Is anybody against it, please?

I am sorry that I have missed it when looking at the previous
version.

Best Regards,
Petr
