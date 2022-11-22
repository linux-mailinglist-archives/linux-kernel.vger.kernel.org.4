Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8829E633E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiKVOG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiKVOF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:05:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA90067F49
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EKwKjSTqKXwp8tYXuUQOHMQ+oh69AIUxWEM3EoBEMPg=; b=gZK/cTDMA+f2pShuPctqCSFwDG
        qtIW7x0gN1+r00+C8+KGKXptaeKhDv9KWr+tGJt26TKLdDfcJ9wcyJSYbjCHzHnlqORKdS5NWGWvE
        wwixBQwEkx0qzaxBoJi1ox6bePQLOHzEkYXEaiiW1rKLBde4NRM09rlTIsMyk4b6K40AT/Yxwabqm
        lO380LIbQqB3n4cLvoJgr3cugJd5rcYlYAmitiIQTQs+9M98SrBP18S5tQfr73qhsKCKGQikcQpzh
        WULdPBws6pcljYmrVURnk11Vr2FxXnuvpVgaNv1i2OdAhCx47iprL7GAWQfXqKc+Egyt8bClDU7EF
        hpZpIFfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxTtc-006Qhe-VG; Tue, 22 Nov 2022 14:05:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C99FA3001D7;
        Tue, 22 Nov 2022 15:05:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF1852077D3E6; Tue, 22 Nov 2022 15:05:01 +0100 (CET)
Date:   Tue, 22 Nov 2022 15:05:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     wangbiao3@xiaomi.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, brauner@kernel.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, wenjieli@qti.qualcomm.com,
        chenguanyou@xiaomi.com, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/1] sched: fix user_mask double free
Message-ID: <Y3zXDZeTUgDz2hJ8@hirez.programming.kicks-ass.net>
References: <cover.1669020858.git.wangbiao3@xiaomi.com>
 <b8970a530d420109ee9fe0b268e097fb839211b0.1669020858.git.wangbiao3@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8970a530d420109ee9fe0b268e097fb839211b0.1669020858.git.wangbiao3@xiaomi.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


So you failed:

 - to Cc the original author of this code (Will Deacon)
 - to report what version this is against (apparently Linus' tree)
 - to check if this still applies to the latest tree (it doesn't)
 - to Cc the author of the code it now conflicts with (Waiman)
 - write something coherent in the changelog.
 - to include a Fixes tag.

Still, let me try and make sense of things...

On Mon, Nov 21, 2022 at 06:04:20PM +0800, wangbiao3@xiaomi.com wrote:
> From: wangbiao3 <wangbiao3@xiaomi.com>
> 
> Clone/Fork a new task,call dup_task_struct->arch_dup_task_struct(tsk,orig)
> which copy the data of parent/sibling task inclding p->user_cpus_ptr,so
> the user_cpus_ptr of newtask is the same with orig task's.When
> dup_task_struct call dup_user_cpus_ptr(tsk, orig, node),it return 0
> dircetly if src->user_cpus_ptris free by other task,in this case ,
> the newtask's address of user_cpus_ptr is not changed.

(even just inserting some whitespace would've made it so much easier to
read)

But, the only way that would be possible is if
force_compatible_cpus_allowed_ptr() were to be called on !current, and
that just doesn't happen, the only callsite is:

arch/arm64/kernel/process.c:                    force_compatible_cpus_allowed_ptr(current);

And you can't be in fork() and exec() at the same time.

If it were possible to call restrict_cpus_allowed_ptr() on a non-current
task then yes, absolutely, which is why:

  8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")

also wraps the thing in pi_lock, but looking at it now, perhaps it needs
to do the alloc/copy first and swap under pi_lock instead.

(leaving the rest for the newly Cc'ed)

> Finally,
> wakup newtask to execute, call task_cpu_possible_mask-->
> do_set_cpus_allowed to set new task's user_cpus_ptr(user_mask) which
> call kfree user_mask at the end. So cause a slub double free panic.
> 
> Use pi_lock to protect content of user_cpus_ptr in dup_user_cpus_ptr and
> clear dst->user_cpus_ptr when found src->user_cpus_ptr is null
> 
> kernel BUG at mm/slub.c:363!
> Call trace:
>  __slab_free+0x230/0x28c
>  kfree+0x220/0x2cc
>  do_set_cpus_allowed+0x74/0xa4
>  select_fallback_rq+0x12c/0x200
>  wake_up_new_task+0x26c/0x304
>  kernel_clone+0x2c0/0x470
>  __arm64_sys_clone+0x5c/0x8c
>  invoke_syscall+0x60/0x150
>  el0_svc_common.llvm.13030543509303927816+0x98/0x114
>  do_el0_svc_compat+0x20/0x30
>  el0_svc_compat+0x28/0x90
>  el0t_32_sync_handler+0x7c/0xbc
>  el0t_32_sync+0x1b8/0x1bc
> 
> Signed-off-by: wangbiao3 <wangbiao3@xiaomi.com>
> ---
>  kernel/sched/core.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index daff72f00385..b013d8b777b4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2584,29 +2584,38 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
>         __do_set_cpus_allowed(p, new_mask, 0);
>  }
> 
> +static inline struct cpumask *clear_user_cpus_ptr(struct task_struct *p)
> +{
> +       struct cpumask *user_mask = NULL;
> +
> +       swap(p->user_cpus_ptr, user_mask);
> +
> +       return user_mask;
> +}
> +
>  int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
>                       int node)
>  {
> -       if (!src->user_cpus_ptr)
> -               return 0;
> +       unsigned long flags;
> +       struct cpumask *user_mask = NULL;
> 
>         dst->user_cpus_ptr = kmalloc_node(cpumask_size(), GFP_KERNEL, node);
>         if (!dst->user_cpus_ptr)
>                 return -ENOMEM;
> 
> +       /* Use pi_lock to protect content of user_cpus_ptr */
> +       raw_spin_lock_irqsave(&src->pi_lock, flags);
> +       if (!src->user_cpus_ptr) {
> +               user_mask = clear_user_cpus_ptr(dst);
> +               raw_spin_unlock_irqrestore(&src->pi_lock, flags);
> +               kfree(user_mask);
> +               return 0;
> +       }
>         cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
> +       raw_spin_unlock_irqrestore(&src->pi_lock, flags);
>         return 0;
>  }
> 
> -static inline struct cpumask *clear_user_cpus_ptr(struct task_struct *p)
> -{
> -       struct cpumask *user_mask = NULL;
> -
> -       swap(p->user_cpus_ptr, user_mask);
> -
> -       return user_mask;
> -}
> -
>  void release_user_cpus_ptr(struct task_struct *p)
>  {
>         kfree(clear_user_cpus_ptr(p));
> --
> 2.38.1
> 
> #/******?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#
