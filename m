Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5AC5FC44A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJLLX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJLLXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:23:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D85BC1486
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 04:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCAE0B81A61
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84070C433D6;
        Wed, 12 Oct 2022 11:23:19 +0000 (UTC)
Date:   Wed, 12 Oct 2022 07:23:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     eadavis@sina.com
Cc:     syzbot+dfcc5f4da15868df7d4d@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mhiramat@kernel.org, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] mm: slab, with same context require fs_reclaim lock
Message-ID: <20221012072319.1a678100@rorschach.local.home>
In-Reply-To: <20220927071134.1674904-1-eadavis@sina.com>
References: <00000000000074b50005e997178a@google.com>
        <20220927071134.1674904-1-eadavis@sina.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 15:11:34 +0800
eadavis@sina.com wrote:

> From: Edward Adam Davis <eadavis@sina.com>
> 
>  1. ENABLE_SOFTIRQ held the fs_reclaim lock:
>  {SOFTIRQ-ON-W} state was registered at:
>   lock_acquire kernel/locking/lockdep.c:5666 [inline]
>   lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
>   __fs_reclaim_acquire mm/page_alloc.c:4674 [inline]
>   fs_reclaim_acquire+0x115/0x160 mm/page_alloc.c:4688
>   might_alloc include/linux/sched/mm.h:271 [inline]
>   slab_pre_alloc_hook mm/slab.h:700 [inline]
>   slab_alloc mm/slab.c:3278 [inline]
>   kmem_cache_alloc_trace+0x38/0x460 mm/slab.c:3557
>   kmalloc include/linux/slab.h:600 [inline]
>   kzalloc include/linux/slab.h:733 [inline]
>   alloc_workqueue_attrs+0x39/0xc0 kernel/workqueue.c:3394
>   wq_numa_init kernel/workqueue.c:5964 [inline]
>   workqueue_init+0x12f/0x8ae kernel/workqueue.c:6091
>   kernel_init_freeable+0x3fb/0x73a init/main.c:1607
>   kernel_init+0x1a/0x1d0 init/main.c:1512
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> 
>  2. IN_SOFTIRQ require the fs_reclaim lock:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_usage_bug kernel/locking/lockdep.c:3961 [inline]
>  valid_state kernel/locking/lockdep.c:3973 [inline]
>  mark_lock_irq kernel/locking/lockdep.c:4176 [inline]
>  mark_lock.part.0.cold+0x18/0xd8 kernel/locking/lockdep.c:4632
>  mark_lock kernel/locking/lockdep.c:4596 [inline]
>  mark_usage kernel/locking/lockdep.c:4527 [inline]
>  __lock_acquire+0x11d9/0x56d0 kernel/locking/lockdep.c:5007
>  lock_acquire kernel/locking/lockdep.c:5666 [inline]
>  lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
>  __fs_reclaim_acquire mm/page_alloc.c:4674 [inline]
>  fs_reclaim_acquire+0x115/0x160 mm/page_alloc.c:4688
>  might_alloc include/linux/sched/mm.h:271 [inline]
>  slab_pre_alloc_hook mm/slab.h:700 [inline]
>  slab_alloc mm/slab.c:3278 [inline]
> 
>  move slab_pre_alloc_hook() to irq context, confirm the context to IN_SOFTIRQ.
> 
> Link: https://syzkaller.appspot.com/bug?extid=dfcc5f4da15868df7d4d
> Reported-by: syzbot+dfcc5f4da15868df7d4d@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@sina.com>
> Changes in v2: 
> 	comments update. 
> ---
>  mm/slab.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 10e96137b44f..29d49d1b1e96 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3275,15 +3275,19 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
>  	bool init = false;
>  
>  	flags &= gfp_allowed_mask;
> +	local_irq_save(save_flags);

Please do not do this. Open coding interrupt disabling due to locking
issues is not the solution. You need to make the locks themselves
disable interrupts if need be. This breaks PREEMPT_RT, and creates a
"big kernel lock" situation where there's random interrupts being
disabled for no apparent reason.

-- Steve


>  	cachep = slab_pre_alloc_hook(cachep, lru, &objcg, 1, flags);
> -	if (unlikely(!cachep))
> +	if (unlikely(!cachep)) {
> +		local_irq_restore(save_flags);
>  		return NULL;
> +	}
>  
>  	objp = kfence_alloc(cachep, orig_size, flags);
> -	if (unlikely(objp))
> +	if (unlikely(objp)) {
> +		local_irq_restore(save_flags);
>  		goto out;
> +	}
>  
> -	local_irq_save(save_flags);
>  	objp = __do_cache_alloc(cachep, flags);
>  	local_irq_restore(save_flags);
>  	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);

