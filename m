Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DBC6D8CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjDFBqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjDFBqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:46:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3216C729B;
        Wed,  5 Apr 2023 18:46:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB13E642E7;
        Thu,  6 Apr 2023 01:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7A6C433D2;
        Thu,  6 Apr 2023 01:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680745572;
        bh=HDCBusMkO55J/81bAiDcUmDhrM9EeFRF67au4Tkp4JU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ckJt/UhduAy2IEVvv/Nexydv+11FUQggOYVoeE2xOeRohO7HfM9FCbpxGgQ8IZjeO
         X0CfjbmDwZyC0uyJi6SPW40YlTG4Ecg59sEDFNJbeUcjPTz37n69g1/E4Zl0YH59+f
         DzKnl4+3lnDxOn3rzoUCuthMlbMSGznw6gueDK3MkLXuaVvT5qWlxr7rG7Ydxbg2Xb
         rfyq3Np4x+FVVDFaXaxbVPqiHt3Js3IZ45uQ9+hRJTISv5IgEBJTc7g4c6h4a4i+QP
         9IkLgRlBBQRkiD5wGuXr8C1GlE6tLIHCLlSiJzl7BLvYInGTCdkU8vfg5Ve1vh7W+M
         Y1maXJ7COXfUw==
Date:   Thu, 6 Apr 2023 10:46:07 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] tracing: Free error logs of tracing instances
Message-Id: <20230406104607.b6ccc8b969d5031275ad0764@kernel.org>
In-Reply-To: <20230404194504.5790b95f@gandalf.local.home>
References: <20230404194504.5790b95f@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 19:45:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> When a tracing instance is removed, the error messages that hold errors
> that occurred in the instance needs to be freed. The following reports a
> memory leak:
> 
>  # cd /sys/kernel/tracing
>  # mkdir instances/foo
>  # echo 'hist:keys=x' > instances/foo/events/sched/sched_switch/trigger
>  # cat instances/foo/error_log
>  [  117.404795] hist:sched:sched_switch: error: Couldn't find field
>    Command: hist:keys=x
>                       ^
>  # rmdir instances/foo
> 
> Then check for memory leaks:
> 
>  # echo scan > /sys/kernel/debug/kmemleak
>  # cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff88810d8ec700 (size 192):
>   comm "bash", pid 869, jiffies 4294950577 (age 215.752s)
>   hex dump (first 32 bytes):
>     60 dd 68 61 81 88 ff ff 60 dd 68 61 81 88 ff ff  `.ha....`.ha....
>     a0 30 8c 83 ff ff ff ff 26 00 0a 00 00 00 00 00  .0......&.......
>   backtrace:
>     [<00000000dae26536>] kmalloc_trace+0x2a/0xa0
>     [<00000000b2938940>] tracing_log_err+0x277/0x2e0
>     [<000000004a0e1b07>] parse_atom+0x966/0xb40
>     [<0000000023b24337>] parse_expr+0x5f3/0xdb0
>     [<00000000594ad074>] event_hist_trigger_parse+0x27f8/0x3560
>     [<00000000293a9645>] trigger_process_regex+0x135/0x1a0
>     [<000000005c22b4f2>] event_trigger_write+0x87/0xf0
>     [<000000002cadc509>] vfs_write+0x162/0x670
>     [<0000000059c3b9be>] ksys_write+0xca/0x170
>     [<00000000f1cddc00>] do_syscall_64+0x3e/0xc0
>     [<00000000868ac68c>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> unreferenced object 0xffff888170c35a00 (size 32):
>   comm "bash", pid 869, jiffies 4294950577 (age 215.752s)
>   hex dump (first 32 bytes):
>     0a 20 20 43 6f 6d 6d 61 6e 64 3a 20 68 69 73 74  .  Command: hist
>     3a 6b 65 79 73 3d 78 0a 00 00 00 00 00 00 00 00  :keys=x.........
>   backtrace:
>     [<000000006a747de5>] __kmalloc+0x4d/0x160
>     [<000000000039df5f>] tracing_log_err+0x29b/0x2e0
>     [<000000004a0e1b07>] parse_atom+0x966/0xb40
>     [<0000000023b24337>] parse_expr+0x5f3/0xdb0
>     [<00000000594ad074>] event_hist_trigger_parse+0x27f8/0x3560
>     [<00000000293a9645>] trigger_process_regex+0x135/0x1a0
>     [<000000005c22b4f2>] event_trigger_write+0x87/0xf0
>     [<000000002cadc509>] vfs_write+0x162/0x670
>     [<0000000059c3b9be>] ksys_write+0xca/0x170
>     [<00000000f1cddc00>] do_syscall_64+0x3e/0xc0
>     [<00000000868ac68c>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> The problem is that the error log needs to be freed when the instance is
> removed.
> 
> Link: https://lore.kernel.org/lkml/76134d9f-a5ba-6a0d-37b3-28310b4a1e91@alu.unizg.hr/
> 
> Cc: stable@vger.kernel.org
> Fixes: 2f754e771b1a6 ("tracing: Have the error logs show up in the proper instances")
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
>  kernel/trace/trace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8ae51f1dea8e..352a804b016d 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9516,6 +9516,7 @@ static int __remove_instance(struct trace_array *tr)
>  	tracefs_remove(tr->dir);
>  	free_percpu(tr->last_func_repeats);
>  	free_trace_buffers(tr);
> +	clear_tracing_err_log(tr);
>  
>  	for (i = 0; i < tr->nr_topts; i++) {
>  		kfree(tr->topts[i].topts);
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
