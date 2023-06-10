Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0054772AE68
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjFJT3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFJT3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:29:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0204A1;
        Sat, 10 Jun 2023 12:29:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686425347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sDQkh7R8r+JHj9kd12veOPhXBKEv0IeIaB7glt+ZYI8=;
        b=p9xbwJKQY6jXUcbF8Lgy1JZGNjViLm/GvtbaM++XwToctffVSrcooTE2v+JwxTkYyhpOAQ
        nY/ihBLFGT+WaliMQjN/5UiyllA0P64nGGmXXzCdH/Htp3mDsQrMgIU6Uf4Roe7grQrE/2
        P3QZKbXU78fhqnz6USuGyNMWHsXw0vgOOYbmq3KxI6MzO0r4mCascfTiLYHM5pWlUv5xY4
        7FgXjWPj5z64jPmtHxGrwIBGo1+RVbXkMivuBgwZ+Lb6KwndEaoEpgz6StZKJNIH887pTA
        jqOw6zirjFcK8uPkoGOgko+4mCvhyjH96nEyF0FnbSFsF+ZeIjZCaUKrhkDXxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686425347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sDQkh7R8r+JHj9kd12veOPhXBKEv0IeIaB7glt+ZYI8=;
        b=52BAwhEHpD49JPShPAmEv+ZR+kF3JuNFRlmL4BruoBGezmR48PQImdZZ63o2ITKnyHFFiV
        rIPEcZcSlOlL+ICA==
To:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        npiggin@gmail.com, akpm@linux-foundation.org
Subject: Re: +
 lazy-tlb-fix-hotplug-exit-race-with-mmu_lazy_tlb_shootdown.patch added to
 mm-hotfixes-unstable branch
In-Reply-To: <20230525205253.E2FAEC433EF@smtp.kernel.org>
References: <20230525205253.E2FAEC433EF@smtp.kernel.org>
Date:   Sat, 10 Jun 2023 21:29:06 +0200
Message-ID: <87v8fv86bh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25 2023 at 13:52, Andrew Morton wrote:

Replying here as I wasn't cc'ed on the patch.

> @@ -1030,6 +1031,8 @@ static int take_cpu_down(void *_param)
>  	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
>  	int err, cpu = smp_processor_id();
>  
> +	idle_task_prepare_exit();
> +
>  	/* Ensure this CPU doesn't handle any more interrupts. */
>  	err = __cpu_disable();
>  	if (err < 0)
> --- a/kernel/sched/core.c~lazy-tlb-fix-hotplug-exit-race-with-mmu_lazy_tlb_shootdown
> +++ a/kernel/sched/core.c
> @@ -9373,19 +9373,33 @@ void sched_setnuma(struct task_struct *p
>   * Ensure that the idle task is using init_mm right before its CPU goes
>   * offline.
>   */
> -void idle_task_exit(void)
> +void idle_task_prepare_exit(void)

This function name along with the above comment is completely
misleading. It suggests this is about the idle task itself instead of
making it clear that this ensures that the kernel threads of the
outgoing CPU are not longer using a mm which is not init_mm.

The callsite is arbitratily chosen too. Why does this have to be done
from stomp machine context?

There is zero reason to do so. The last hotplug state before teardown is
CPUHP_AP_SCHED_WAIT_EMPTY. It invokes sched_cpu_wait_empty() in the
context of the CPU hotplug thread of the outgoing CPU.

sched_cpu_wait_empty() guarantees that there are no temporarily pinned
(via migrate disable) user space tasks on that CPU anymore. The
scheduler guarantees that there won't be user space tasks woken up on or
migrated to that CPU because the CPU is not in the cpu_active mask.

The stopper thread has absolutely nothing to do with that.

So sched_cpu_wait_empty() is the obvious place to handle that:

int sched_cpu_wait_empty(unsigned int cpu)
{
	balance_hotplug_wait();
+	sched_force_init_mm();
	return 0;
}

And then have:

/*
 * Invoked on the outgoing CPU in context of the CPU hotplug thread
 * after ensuring that there are no user space tasks left on the CPU.
 *
 * If there is a lazy mm in use on the hotplug thread, drop it and
 * switch to init_mm.
 *
 * The reference count on init_mm is dropped in finish_cpu().
 */
static void sched_force_init_mm(void)
{

No?

>  {
>  	struct mm_struct *mm = current->active_mm;
>  
> -	BUG_ON(cpu_online(smp_processor_id()));
> -	BUG_ON(current != this_rq()->idle);
> +	WARN_ON(!irqs_disabled());
>  
>  	if (mm != &init_mm) {
> -		switch_mm(mm, &init_mm, current);
> +		mmgrab_lazy_tlb(&init_mm);
> +		current->active_mm = &init_mm;
> +		switch_mm_irqs_off(mm, &init_mm, current);
>  		finish_arch_post_lock_switch();
> +		mmdrop_lazy_tlb(mm);
>  	}
> +	/* finish_cpu() will mmdrop the init_mm ref after this CPU stops */
> +}
> +
> +/*
> + * After the CPU is offline, double check that it was previously switched to
> + * init_mm. This call can be removed because the condition is caught in
> + * finish_cpu() as well.

So why adding it in the first place?

The changelog mumbles something about reducing churn, but I fail to see
that reduction. This adds 10 lines of pointless code and comments for
zero value.

Thanks,

        tglx
