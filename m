Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BFC69244D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjBJRUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjBJRT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:19:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A612F6D61A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:19:57 -0800 (PST)
Date:   Fri, 10 Feb 2023 18:19:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676049596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aFfgSzkT6aQl211xQgCHvFiqA9QBifMZwcZhrp11M5k=;
        b=w6kAWnVYdJznEF0v6wiUTedvISGHdJEo2Qr4L2FLBcp/v4pm7XzWp5Qnsx9feSKJ+sA1Rn
        bU83XXALDwgAzaTcaH81V2gG8zKfye6xd97q1LIDDcCVqyfAJjhTxt9mgVVnhVygkdNryN
        XJRZn2fxAgNBOH6SyR57dyCnfJNo7WTrfb8EX/vhAGcbWtuBx7Vaq2I3CjoRLF1crmDaUE
        yy7I8spn7d4Pzn8D74G4Uq/UQ1UxkDeijQMBiixxd72t7zP8LHWxX1ovusuaK6Z/K/YHb1
        kbCm/zA1r+qX/cPAqyToqrYAlMc5jBJsBbinYbBtd3OIZfEeUZ939Oq6Mc/FVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676049596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aFfgSzkT6aQl211xQgCHvFiqA9QBifMZwcZhrp11M5k=;
        b=GWkL0j2MwygdvVLJ9rcU29gwlWGrGywo9l8B0qgZXJw4GesLu6JvRCDzRLdl/Vg6wuvxow
        vRJdag2l9KlMpGDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v5] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <Y+Z8uqzJQOMahKWH@linutronix.de>
References: <20230210161323.37400-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230210161323.37400-1-wander@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-10 13:13:21 [-0300], Wander Lairson Costa wrote:
> Under PREEMPT_RT, __put_task_struct() indirectly acquires sleeping
> locks. Therefore, it can't be called from an non-preemptible context.
> 
> One practical example is splat inside inactive_task_timer(), which is
> called in a interrupt context:
> 
> CPU: 1 PID: 2848 Comm: life Kdump: loaded Tainted: G W ---------
>  Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/15/2012
>  Call Trace:
>  dump_stack_lvl+0x57/0x7d
>  mark_lock_irq.cold+0x33/0xba
>  ? stack_trace_save+0x4b/0x70
>  ? save_trace+0x55/0x150
>  mark_lock+0x1e7/0x400
>  mark_usage+0x11d/0x140
>  __lock_acquire+0x30d/0x930
>  lock_acquire.part.0+0x9c/0x210
>  ? refill_obj_stock+0x3d/0x3a0
>  ? rcu_read_lock_sched_held+0x3f/0x70
>  ? trace_lock_acquire+0x38/0x140
>  ? lock_acquire+0x30/0x80
>  ? refill_obj_stock+0x3d/0x3a0
>  rt_spin_lock+0x27/0xe0
>  ? refill_obj_stock+0x3d/0x3a0
>  refill_obj_stock+0x3d/0x3a0
>  ? inactive_task_timer+0x1ad/0x340
>  kmem_cache_free+0x357/0x560
>  inactive_task_timer+0x1ad/0x340
>  ? switched_from_dl+0x2d0/0x2d0
>  __run_hrtimer+0x8a/0x1a0
>  __hrtimer_run_queues+0x91/0x130
>  hrtimer_interrupt+0x10f/0x220
>  __sysvec_apic_timer_interrupt+0x7b/0xd0
>  sysvec_apic_timer_interrupt+0x4f/0xd0
>  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
>  asm_sysvec_apic_timer_interrupt+0x12/0x20
>  RIP: 0033:0x7fff196bf6f5

Now that I looked around: There are other put_task_struct() while the rq
lock is held. I didn't look outside o dl.c.

> Instead of calling __put_task_struct() directly, we defer it using
> call_rcu(). A more natural approach would use a workqueue, but since
> in PREEMPT_RT, we can't allocate dynamic memory from atomic context,
> the code would become more complex because we would need to put the
> work_struct instance in the task_struct and initialize it when we
> allocate a new task_struct.
> 
> Changelog
> =========
> 
> v1:
> * Initial implementation fixing the splat.
> 
> v2:
> * Isolate the logic in its own function.
> * Fix two more cases caught in review.
> 
> v3:
> * Change __put_task_struct() to handle the issue internally.
> 
> v4:
> * Explain why call_rcu() is safe to call from interrupt context.
> 
> v5:
> * Explain why __put_task_struct() doesn't conflict with
>   put_task_sruct_rcu_user.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Reported-by: Hu Chunyu <chuhu@redhat.com>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Valentin Schneider <vschneid@redhat.com>
> Cc: Paul McKenney <paulmck@kernel.org>
> ---
>  kernel/fork.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9f7fe3541897..9bf30c725ed8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -840,7 +840,7 @@ static inline void put_signal_struct(struct signal_struct *sig)
>  		free_signal_struct(sig);
>  }
>  
> -void __put_task_struct(struct task_struct *tsk)
> +static void ___put_task_struct(struct task_struct *tsk)
>  {
>  	WARN_ON(!tsk->exit_state);
>  	WARN_ON(refcount_read(&tsk->usage));
> @@ -857,6 +857,37 @@ void __put_task_struct(struct task_struct *tsk)
>  	sched_core_free(tsk);
>  	free_task(tsk);
>  }
> +
> +static void __put_task_struct_rcu(struct rcu_head *rhp)
> +{
> +	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
> +
> +	___put_task_struct(task);
> +}
> +
> +void __put_task_struct(struct task_struct *tsk)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (!preemptible() || !in_task()))

No. If you do this on non-RT kernel with CONFIG_PROVE_RAW_LOCK_NESTING
then it will complain. And why do we have in_task() here?

If Oleg does not want the unconditional RCU then I would prefer an
explicit put task which delays it to RCU for the few users that need it.

A lockdep annotation _before_ ___put_task_struct() should spot users
which are not obviously visible from audit.

> +		/*
> +		 * under PREEMPT_RT, we can't call put_task_struct
> +		 * in atomic context because it will indirectly
> +		 * acquire sleeping locks.
> +		 *
> +		 * call_rcu() will schedule delayed_put_task_struct_rcu()
> +		 * to be called in process context.
> +		 *
> +		 * __put_task_struct() is called called when
> +		 * refcount_dec_and_test(&t->usage) succeeds.
> +		 *
> +		 * This means that it can't "conflict" with
> +		 * put_task_struct_rcu_user() which abuses ->rcu the same
> +		 * way; rcu_users has a reference so task->usage can't be
> +		 * zero after rcu_users 1 -> 0 transition.
> +		 */
> +		call_rcu(&tsk->rcu, __put_task_struct_rcu);
> +	else
> +		___put_task_struct(tsk);
> +}
>  EXPORT_SYMBOL_GPL(__put_task_struct);
>  
>  void __init __weak arch_task_cache_init(void) { }
> -- 
> 2.39.1
> 
