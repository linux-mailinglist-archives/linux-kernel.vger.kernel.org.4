Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB396E73FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjDSH1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjDSH1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:27:34 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBF93AA0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:27:32 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-761c5dc0527so182096439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681889252; x=1684481252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4+jpKL/ey0sd/NtAlMmoATIMCLxVjtS/CGh7GhFIsWo=;
        b=coR7f4X00Y7ryHU+Z4idQxfmdjqlGHCJGx78NGcPk412M6bXDwkjuOIVK94sqc/Hid
         e0ACG+uXDTggkYZE4qKSFzPGAuMFi3UuZJ0xxnZUGCEIWdgXeEcPmmkuDUTDwfdA6fD8
         jTp0VIhCVgFrjPfC7np8hlkuFAQnoQVR0Tv2YYAxzWkCNn7kMJ9ktqFrRjRWMjZ4R3b2
         chUONMbC4iu6lpaLBuYppB0/9Gtu66Ub0Nbhd+zaK5aQ1N1Sig5zOcm6Q4SQWPi5dylC
         9wBlLZ3J6q5VpyDK3gwR5gotYWOqf8YVRSpqfA9aRyiuP7bXw/hm009LivdPHOVZmIy4
         wIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681889252; x=1684481252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+jpKL/ey0sd/NtAlMmoATIMCLxVjtS/CGh7GhFIsWo=;
        b=hdyC04tMj9meJK5GOoclL2A5B/kP0qxVpyx+iFUg8GeLhF34wSg2nDMf8n3vFBsDO7
         t71hylqyS2hhrjLcKRO7yABNQSDiRShCmSuhrlveqgbqehsrONGA3aK3hS8ixPJh8SnN
         +jAqIxCTwRJdnyL3UUM7JZxdsar3sc1Qzlr6HVsZZxOQxm083DM7e76KovVS5z3eWGNw
         2VX/mXUMv6Ks/ONkwNI3x1opjHHTRJfrNlMg8YQlN4APDaUfLbnUxCFpXlOuOStYC4eW
         ADavRmzUwR9k38iNL4+ddBh5rbfz0+3lsCuH8Zpc8cm8/ezHvGGFq6bXyu7anSik8HSH
         aMyw==
X-Gm-Message-State: AAQBX9e5Qm+I+X5xNfI6tUidkY7keuHDktSKFriSG23D9MGFEcTNnZv9
        KNTg6GDjAqVqbeiWpMtIniF72Kh0GFz3KayqTFewCQ==
X-Google-Smtp-Source: AKy350blTI5TONuLs8GnSZz6w9ypGBawnp0MjSqjci2SqFJxc5IxHGUzrRALp6mBT4UpCH03jK6aBf0yNJ5KuK4YBgU=
X-Received: by 2002:a6b:e618:0:b0:760:ebae:4f8d with SMTP id
 g24-20020a6be618000000b00760ebae4f8dmr4016341ioh.8.1681889252043; Wed, 19 Apr
 2023 00:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230327120019.1027640-1-qiang1.zhang@intel.com>
In-Reply-To: <20230327120019.1027640-1-qiang1.zhang@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 19 Apr 2023 09:26:54 +0200
Message-ID: <CANpmjNOjPZm0hdxZmtp4HgqGpkevUvpj-9XGUe24rRTBRroiqg@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: Fix lockdep report invalid wait context
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 at 13:48, Zqiang <qiang1.zhang@intel.com> wrote:
>
> For kernels built with the following options and booting
>
> CONFIG_SLUB=y
> CONFIG_DEBUG_LOCKDEP=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_PROVE_RAW_LOCK_NESTING=y
>
> [    0.523115] [ BUG: Invalid wait context ]
> [    0.523315] 6.3.0-rc1-yocto-standard+ #739 Not tainted
> [    0.523649] -----------------------------
> [    0.523663] swapper/0/0 is trying to lock:
> [    0.523663] ffff888035611360 (&c->lock){....}-{3:3}, at: put_cpu_partial+0x2e/0x1e0
> [    0.523663] other info that might help us debug this:
> [    0.523663] context-{2:2}
> [    0.523663] no locks held by swapper/0/0.
> [    0.523663] stack backtrace:
> [    0.523663] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-rc1-yocto-standard+ #739
> [    0.523663] Call Trace:
> [    0.523663]  <IRQ>
> [    0.523663]  dump_stack_lvl+0x64/0xb0
> [    0.523663]  dump_stack+0x10/0x20
> [    0.523663]  __lock_acquire+0x6c4/0x3c10
> [    0.523663]  lock_acquire+0x188/0x460
> [    0.523663]  put_cpu_partial+0x5a/0x1e0
> [    0.523663]  __slab_free+0x39a/0x520
> [    0.523663]  ___cache_free+0xa9/0xc0
> [    0.523663]  qlist_free_all+0x7a/0x160
> [    0.523663]  per_cpu_remove_cache+0x5c/0x70
> [    0.523663]  __flush_smp_call_function_queue+0xfc/0x330
> [    0.523663]  generic_smp_call_function_single_interrupt+0x13/0x20
> [    0.523663]  __sysvec_call_function+0x86/0x2e0
> [    0.523663]  sysvec_call_function+0x73/0x90
> [    0.523663]  </IRQ>
> [    0.523663]  <TASK>
> [    0.523663]  asm_sysvec_call_function+0x1b/0x20
> [    0.523663] RIP: 0010:default_idle+0x13/0x20
> [    0.523663] RSP: 0000:ffffffff83e07dc0 EFLAGS: 00000246
> [    0.523663] RAX: 0000000000000000 RBX: ffffffff83e1e200 RCX: ffffffff82a83293
> [    0.523663] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8119a6b1
> [    0.523663] RBP: ffffffff83e07dc8 R08: 0000000000000001 R09: ffffed1006ac0d66
> [    0.523663] R10: ffff888035606b2b R11: ffffed1006ac0d65 R12: 0000000000000000
> [    0.523663] R13: ffffffff83e1e200 R14: ffffffff84a7d980 R15: 0000000000000000
> [    0.523663]  default_idle_call+0x6c/0xa0
> [    0.523663]  do_idle+0x2e1/0x330
> [    0.523663]  cpu_startup_entry+0x20/0x30
> [    0.523663]  rest_init+0x152/0x240
> [    0.523663]  arch_call_rest_init+0x13/0x40
> [    0.523663]  start_kernel+0x331/0x470
> [    0.523663]  x86_64_start_reservations+0x18/0x40
> [    0.523663]  x86_64_start_kernel+0xbb/0x120
> [    0.523663]  secondary_startup_64_no_verify+0xe0/0xeb
> [    0.523663]  </TASK>
>
> The local_lock_irqsave() is invoked in put_cpu_partial() and happens
> in IPI context, due to the CONFIG_PROVE_RAW_LOCK_NESTING=y (the
> LD_WAIT_CONFIG not equal to LD_WAIT_SPIN), so acquire local_lock in
> IPI context will trigger above calltrace.
>
> This commit therefore move qlist_free_all() from hard-irq context to
> task context.
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

PROVE_RAW_LOCK_NESTING is for the benefit of RT kernels. So it's
unclear if this is fixing anything on non-RT kernels, besides the
lockdep warning.

I'd be inclined to say that having unified code for RT and non-RT
kernels is better.

Acked-by: Marco Elver <elver@google.com>

+Cc RT folks

> ---
>  v1->v2:
>  Modify the commit information and add Cc.
>
>  mm/kasan/quarantine.c | 34 ++++++++--------------------------
>  1 file changed, 8 insertions(+), 26 deletions(-)
>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 75585077eb6d..152dca73f398 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -99,7 +99,6 @@ static unsigned long quarantine_size;
>  static DEFINE_RAW_SPINLOCK(quarantine_lock);
>  DEFINE_STATIC_SRCU(remove_cache_srcu);
>
> -#ifdef CONFIG_PREEMPT_RT
>  struct cpu_shrink_qlist {
>         raw_spinlock_t lock;
>         struct qlist_head qlist;
> @@ -108,7 +107,6 @@ struct cpu_shrink_qlist {
>  static DEFINE_PER_CPU(struct cpu_shrink_qlist, shrink_qlist) = {
>         .lock = __RAW_SPIN_LOCK_UNLOCKED(shrink_qlist.lock),
>  };
> -#endif
>
>  /* Maximum size of the global queue. */
>  static unsigned long quarantine_max_size;
> @@ -319,16 +317,6 @@ static void qlist_move_cache(struct qlist_head *from,
>         }
>  }
>
> -#ifndef CONFIG_PREEMPT_RT
> -static void __per_cpu_remove_cache(struct qlist_head *q, void *arg)
> -{
> -       struct kmem_cache *cache = arg;
> -       struct qlist_head to_free = QLIST_INIT;
> -
> -       qlist_move_cache(q, &to_free, cache);
> -       qlist_free_all(&to_free, cache);
> -}
> -#else
>  static void __per_cpu_remove_cache(struct qlist_head *q, void *arg)
>  {
>         struct kmem_cache *cache = arg;
> @@ -340,7 +328,6 @@ static void __per_cpu_remove_cache(struct qlist_head *q, void *arg)
>         qlist_move_cache(q, &sq->qlist, cache);
>         raw_spin_unlock_irqrestore(&sq->lock, flags);
>  }
> -#endif
>
>  static void per_cpu_remove_cache(void *arg)
>  {
> @@ -362,6 +349,8 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
>  {
>         unsigned long flags, i;
>         struct qlist_head to_free = QLIST_INIT;
> +       int cpu;
> +       struct cpu_shrink_qlist *sq;
>
>         /*
>          * Must be careful to not miss any objects that are being moved from
> @@ -372,20 +361,13 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
>          */
>         on_each_cpu(per_cpu_remove_cache, cache, 1);
>
> -#ifdef CONFIG_PREEMPT_RT
> -       {
> -               int cpu;
> -               struct cpu_shrink_qlist *sq;
> -
> -               for_each_online_cpu(cpu) {
> -                       sq = per_cpu_ptr(&shrink_qlist, cpu);
> -                       raw_spin_lock_irqsave(&sq->lock, flags);
> -                       qlist_move_cache(&sq->qlist, &to_free, cache);
> -                       raw_spin_unlock_irqrestore(&sq->lock, flags);
> -               }
> -               qlist_free_all(&to_free, cache);
> +       for_each_online_cpu(cpu) {
> +               sq = per_cpu_ptr(&shrink_qlist, cpu);
> +               raw_spin_lock_irqsave(&sq->lock, flags);
> +               qlist_move_cache(&sq->qlist, &to_free, cache);
> +               raw_spin_unlock_irqrestore(&sq->lock, flags);
>         }
> -#endif
> +       qlist_free_all(&to_free, cache);
>
>         raw_spin_lock_irqsave(&quarantine_lock, flags);
>         for (i = 0; i < QUARANTINE_BATCHES; i++) {
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20230327120019.1027640-1-qiang1.zhang%40intel.com.
