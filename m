Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2599614C42
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiKAOHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiKAOHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:07:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2B31A80E;
        Tue,  1 Nov 2022 07:07:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 256EAB81DBF;
        Tue,  1 Nov 2022 14:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56E7C433C1;
        Tue,  1 Nov 2022 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667311639;
        bh=qa2NiLkvwqh21P7yD2YxH/oo+2IG9kAry/2hB7aqHHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BPr7RLqm09Zk2SCcceYlzd588wpwZzzCjLQ+HqeVic/FprOXymQgYV57sFd3tLTte
         /+lVpFZRYrK5kfNM0YKZGYLQLK542ydckeL1393kJ7dyo1e4C87MibTVCA+SSx4no6
         rdMCpVUiTxrEjzqAqbcJGhiYaB/LmtGPQOnoW+D+EkFR5okjUYLQiGFoEzdkr7sqHJ
         Kf4EdTMpdz40LRP3a1P7g7Q20r+LYycytGZwg8VdBxTQL9v4juZLq9KlVVn+Ybo7FM
         FUM8wIpjqSBHFtBQ7HGmxJjBsIqJpW5qeWYIL3b3k6ZBat88SruosPXGxVb8iJu0Cb
         YIZ+slw6AcEsw==
Date:   Tue, 1 Nov 2022 23:07:16 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: Fix use-after-free for dynamic ftrace_ops
Message-Id: <20221101230716.22c7b52728990f6b192795c0@kernel.org>
In-Reply-To: <20221101064146.69551-1-lihuafei1@huawei.com>
References: <20221101064146.69551-1-lihuafei1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 14:41:46 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> KASAN reported a use-after-free with ftrace ops [1]. It was found from
> vmcore that perf had registered two ops with the same content
> successively, both dynamic. After unregistering the second ops, a
> use-after-free occurred.
> 
> In ftrace_shutdown(), when the second ops is unregistered, the
> FTRACE_UPDATE_CALLS command is not set because there is another enabled
> ops with the same content.  Also, both ops are dynamic and the ftrace
> callback function is ftrace_ops_list_func, so the
> FTRACE_UPDATE_TRACE_FUNC command will not be set. Eventually the value
> of 'command' will be 0 and ftrace_shutdown() will skip the rcu
> synchronization.
> 
> However, ftrace may be activated. When the ops is released, another CPU
> may be accessing the ops.  Add the missing synchronization to fix this
> problem.
> 
> [1]
> BUG: KASAN: use-after-free in __ftrace_ops_list_func kernel/trace/ftrace.c:7020 [inline]
> BUG: KASAN: use-after-free in ftrace_ops_list_func+0x2b0/0x31c kernel/trace/ftrace.c:7049
> Read of size 8 at addr ffff56551965bbc8 by task syz-executor.2/14468
> 
> CPU: 1 PID: 14468 Comm: syz-executor.2 Not tainted 5.10.0 #7
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x0/0x40c arch/arm64/kernel/stacktrace.c:132
>  show_stack+0x30/0x40 arch/arm64/kernel/stacktrace.c:196
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b4/0x248 lib/dump_stack.c:118
>  print_address_description.constprop.0+0x28/0x48c mm/kasan/report.c:387
>  __kasan_report mm/kasan/report.c:547 [inline]
>  kasan_report+0x118/0x210 mm/kasan/report.c:564
>  check_memory_region_inline mm/kasan/generic.c:187 [inline]
>  __asan_load8+0x98/0xc0 mm/kasan/generic.c:253
>  __ftrace_ops_list_func kernel/trace/ftrace.c:7020 [inline]
>  ftrace_ops_list_func+0x2b0/0x31c kernel/trace/ftrace.c:7049
>  ftrace_graph_call+0x0/0x4
>  __might_sleep+0x8/0x100 include/linux/perf_event.h:1170
>  __might_fault mm/memory.c:5183 [inline]
>  __might_fault+0x58/0x70 mm/memory.c:5171
>  do_strncpy_from_user lib/strncpy_from_user.c:41 [inline]
>  strncpy_from_user+0x1f4/0x4b0 lib/strncpy_from_user.c:139
>  getname_flags+0xb0/0x31c fs/namei.c:149
>  getname+0x2c/0x40 fs/namei.c:209
>  [...]
> 
> Allocated by task 14445:
>  kasan_save_stack+0x24/0x50 mm/kasan/common.c:48
>  kasan_set_track mm/kasan/common.c:56 [inline]
>  __kasan_kmalloc mm/kasan/common.c:479 [inline]
>  __kasan_kmalloc.constprop.0+0x110/0x13c mm/kasan/common.c:449
>  kasan_kmalloc+0xc/0x14 mm/kasan/common.c:493
>  kmem_cache_alloc_trace+0x440/0x924 mm/slub.c:2950
>  kmalloc include/linux/slab.h:563 [inline]
>  kzalloc include/linux/slab.h:675 [inline]
>  perf_event_alloc.part.0+0xb4/0x1350 kernel/events/core.c:11230
>  perf_event_alloc kernel/events/core.c:11733 [inline]
>  __do_sys_perf_event_open kernel/events/core.c:11831 [inline]
>  __se_sys_perf_event_open+0x550/0x15f4 kernel/events/core.c:11723
>  __arm64_sys_perf_event_open+0x6c/0x80 kernel/events/core.c:11723
>  [...]
> 
> Freed by task 14445:
>  kasan_save_stack+0x24/0x50 mm/kasan/common.c:48
>  kasan_set_track+0x24/0x34 mm/kasan/common.c:56
>  kasan_set_free_info+0x20/0x40 mm/kasan/generic.c:358
>  __kasan_slab_free.part.0+0x11c/0x1b0 mm/kasan/common.c:437
>  __kasan_slab_free mm/kasan/common.c:445 [inline]
>  kasan_slab_free+0x2c/0x40 mm/kasan/common.c:446
>  slab_free_hook mm/slub.c:1569 [inline]
>  slab_free_freelist_hook mm/slub.c:1608 [inline]
>  slab_free mm/slub.c:3179 [inline]
>  kfree+0x12c/0xc10 mm/slub.c:4176
>  perf_event_alloc.part.0+0xa0c/0x1350 kernel/events/core.c:11434
>  perf_event_alloc kernel/events/core.c:11733 [inline]
>  __do_sys_perf_event_open kernel/events/core.c:11831 [inline]
>  __se_sys_perf_event_open+0x550/0x15f4 kernel/events/core.c:11723
>  [...]
> 

Good catch! This should go stable tree too.

Cc: stable@vger.kernel.org
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

But I'm not sure what commit this is fixed. Maybe commit a4c35ed24112
("ftrace: Fix synchronization location disabling and freeing ftrace_ops").
Steve, can you add Fixed: ?

Also, I found a typo below.

> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  kernel/trace/ftrace.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index fbf2543111c0..4219cc2a04a6 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3030,13 +3030,16 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
>  
>  	if (!command || !ftrace_enabled) {
>  		/*
> -		 * If these are dynamic or per_cpu ops, they still
> -		 * need their data freed. Since, function tracing is
> -		 * not currently active, we can just free them
> -		 * without synchronizing all CPUs.
> +		 * If these are dynamic, they still need their data freed. If
> +		 * function tracing is currently active, we neet to synchronize
                                                          ^need

Thank you!

> +		 * all CPUs before we can release them.
>  		 */
> -		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
> +		if (ops->flags & FTRACE_OPS_FL_DYNAMIC) {
> +			if (ftrace_enabled)
> +				goto sync_rcu;
> +
>  			goto free_ops;
> +		}
>  
>  		return 0;
>  	}
> @@ -3083,6 +3086,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
>  	 * ops.
>  	 */
>  	if (ops->flags & FTRACE_OPS_FL_DYNAMIC) {
> + sync_rcu:
>  		/*
>  		 * We need to do a hard force of sched synchronization.
>  		 * This is because we use preempt_disable() to do RCU, but
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
