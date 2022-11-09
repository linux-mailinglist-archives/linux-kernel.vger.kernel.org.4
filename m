Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BBF623484
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiKIU1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiKIU1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:27:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3332FFC9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:27:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E0BDB81FFD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 20:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC427C433C1;
        Wed,  9 Nov 2022 20:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668025627;
        bh=4qgy6Cu33h6BZJh4BnljtIi9GkAx9UvRJKXodsRXUU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p//g2IeDkeJXR9DciCOt0VCk+VLBFcLEYMv1A4re8AFh0F4VAIfRFPI5YajyVVrIR
         gVLhRAdeOccSvbh4gRRJ1uc76p93AZzpRFCVPQw6Cl0Zkb+Ne5tBKn4R6hW1Ax2qk1
         6+5uFbH94Mfr9VyzlpAiUkv3LMkJiW/VoDwQm33uFmdLB8H2P0DIG3ITsnSjYoRaMr
         meNGADPcfjC1KZEGDOcECCkNaJfpKM8rCFYUevNoVBeBfguFqtuxtHHgjlb4+nB559
         2wd/8rycm6ULEoHSna3pS2A6dUA0v5Jss0o1L7fty/hIct52NHAwO96whTckYZhK86
         qGwMbMz2NM+Ig==
Date:   Thu, 10 Nov 2022 05:27:04 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: Fix memory leak of filter string
Message-Id: <20221110052704.1ef0e223f7c6a5528f95bab3@kernel.org>
In-Reply-To: <20221108235738.1021467-1-rafaelmendsr@gmail.com>
References: <20221108235738.1021467-1-rafaelmendsr@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Nov 2022 20:57:38 -0300
Rafael Mendonca <rafaelmendsr@gmail.com> wrote:

> The filter string doesn't get freed when a dynamic event is deleted. If a
> filter is set, then memory is leaked:
> 
> root@localhost:/sys/kernel/tracing# echo 'e:egroup/stat_runtime_4core \
>         sched/sched_stat_runtime runtime=$runtime:u32 if cpu < 4' >> dynamic_events
> root@localhost:/sys/kernel/tracing# echo "-:egroup/stat_runtime_4core"  >> dynamic_events
> root@localhost:/sys/kernel/tracing# echo scan > /sys/kernel/debug/kmemleak
> [  224.416373] kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> root@localhost:/sys/kernel/tracing# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff88810156f1b8 (size 8):
>   comm "bash", pid 224, jiffies 4294935612 (age 55.800s)
>   hex dump (first 8 bytes):
>     63 70 75 20 3c 20 34 00                          cpu < 4.
>   backtrace:
>     [<000000009f880725>] __kmem_cache_alloc_node+0x18e/0x720
>     [<0000000042492946>] __kmalloc+0x57/0x240
>     [<0000000034ea7995>] __trace_eprobe_create+0x1214/0x1d30
>     [<00000000d70ef730>] trace_probe_create+0xf6/0x110
>     [<00000000915c7b16>] eprobe_dyn_event_create+0x21/0x30
>     [<000000000d894386>] create_dyn_event+0xf3/0x1a0
>     [<00000000e9af57d5>] trace_parse_run_command+0x1a9/0x2e0
>     [<0000000080777f18>] dyn_event_write+0x39/0x50
>     [<0000000089f0ec73>] vfs_write+0x311/0xe50
>     [<000000003da1bdda>] ksys_write+0x158/0x2a0
>     [<00000000bb1e616e>] __x64_sys_write+0x7c/0xc0
>     [<00000000e8aef1f7>] do_syscall_64+0x60/0x90
>     [<00000000fe7fe8ba>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Additionally, in __trace_eprobe_create() function, if an error occurs after
> the call to trace_eprobe_parse_filter(), which allocates the filter string,
> then memory is also leaked. That can be reproduced by creating the same
> event probe twice:
> 
> root@localhost:/sys/kernel/tracing# echo 'e:egroup/stat_runtime_4core \
>         sched/sched_stat_runtime runtime=$runtime:u32 if cpu < 4' >> dynamic_events
> root@localhost:/sys/kernel/tracing# echo 'e:egroup/stat_runtime_4core \
>         sched/sched_stat_runtime runtime=$runtime:u32 if cpu < 4' >> dynamic_events
> -bash: echo: write error: File exists
> root@localhost:/sys/kernel/tracing# echo scan > /sys/kernel/debug/kmemleak
> [  207.871584] kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> root@localhost:/sys/kernel/tracing# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff8881020d17a8 (size 8):
>   comm "bash", pid 223, jiffies 4294938308 (age 31.000s)
>   hex dump (first 8 bytes):
>     63 70 75 20 3c 20 34 00                          cpu < 4.
>   backtrace:
>     [<000000000e4f5f31>] __kmem_cache_alloc_node+0x18e/0x720
>     [<0000000024f0534b>] __kmalloc+0x57/0x240
>     [<000000002930a28e>] __trace_eprobe_create+0x1214/0x1d30
>     [<0000000028387903>] trace_probe_create+0xf6/0x110
>     [<00000000a80d6a9f>] eprobe_dyn_event_create+0x21/0x30
>     [<000000007168698c>] create_dyn_event+0xf3/0x1a0
>     [<00000000f036bf6a>] trace_parse_run_command+0x1a9/0x2e0
>     [<00000000014bde8b>] dyn_event_write+0x39/0x50
>     [<0000000078a097f7>] vfs_write+0x311/0xe50
>     [<00000000996cb208>] ksys_write+0x158/0x2a0
>     [<00000000a3c2acb0>] __x64_sys_write+0x7c/0xc0
>     [<0000000006b5d698>] do_syscall_64+0x60/0x90
>     [<00000000780e8ecf>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Fix both issues by releasing the filter string in
> trace_event_probe_cleanup().
> 
> Fixes: 752be5c5c910 ("tracing/eprobe: Add eprobe filter support")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>

Thanks for the fix!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> ---
>  kernel/trace/trace_eprobe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index c2153bf59936..e888446d80fa 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -52,6 +52,7 @@ static void trace_event_probe_cleanup(struct trace_eprobe *ep)
>  	kfree(ep->event_system);
>  	if (ep->event)
>  		trace_event_put_ref(ep->event);
> +	kfree(ep->filter_str);
>  	kfree(ep);
>  }
>  
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
