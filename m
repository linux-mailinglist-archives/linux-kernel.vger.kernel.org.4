Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303975EB00C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiIZSgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiIZSgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:36:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553792F01E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F484B80D42
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 18:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E743AC433D6;
        Mon, 26 Sep 2022 18:36:14 +0000 (UTC)
Date:   Mon, 26 Sep 2022 14:37:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     <mingo@redhat.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] kprobes: Mark ftrace mcount handler functions nokprobe
Message-ID: <20220926143723.73032f8c@gandalf.local.home>
In-Reply-To: <20220919084533.42318-1-liaochang1@huawei.com>
References: <20220919084533.42318-1-liaochang1@huawei.com>
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

On Mon, 19 Sep 2022 16:45:33 +0800
Liao Chang <liaochang1@huawei.com> wrote:

> Mark ftrace mcount handler functions nokprobe since probing on these
> functions probably reaches mcount recursivly during kprobe breakpoint
> handler for some architecture(tested for riscv, arm64), and reenter
> kprobe is treated as a fatal error, causes kernel panic.

This looks to me that the affected archs should be made more robust for this
case than to add this to the generic code.

-- Steve


> 
> Pesudo code below demonstrate this problem:
> 
>   mcount
>     function_trace_call (probed)
>       arch_breakpoint_handler
>         arch_setup_singlestep [mcount]
>           function_trace_call (probed)
>             arch_breakpoint_handler
>               reenter_kprobe
>                 BUG
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  kernel/trace/trace_functions.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index 9f1bfbe105e8..440a678a8c7c 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -16,6 +16,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/slab.h>
>  #include <linux/fs.h>
> +#include <linux/kprobes.h>
>  
>  #include "trace.h"
>  
> @@ -194,6 +195,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
>  
>  	ftrace_test_recursion_unlock(bit);
>  }
> +NOKPROBE_SYMBOL(function_trace_call);
>  
>  #ifdef CONFIG_UNWINDER_ORC
>  /*
> @@ -245,6 +247,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
>  	atomic_dec(&data->disabled);
>  	local_irq_restore(flags);
>  }
> +NOKPROBE_SYMBOL(function_stack_trace_call);
>  
>  static inline bool is_repeat_check(struct trace_array *tr,
>  				   struct trace_func_repeats *last_info,
> @@ -321,6 +324,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>  out:
>  	ftrace_test_recursion_unlock(bit);
>  }
> +NOKPROBE_SYMBOL(function_no_repeats_trace_call);
>  
>  static void
>  function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
> @@ -363,6 +367,7 @@ function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>  	atomic_dec(&data->disabled);
>  	local_irq_restore(flags);
>  }
> +NOKPROBE_SYMBOL(function_stack_no_repeats_trace_call);
>  
>  static struct tracer_opt func_opts[] = {
>  #ifdef CONFIG_STACKTRACE

