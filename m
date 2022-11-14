Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8D627444
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbiKNBt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbiKNBtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:49:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E32E008
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 17:48:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C561BCE0DFA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C192CC433C1;
        Mon, 14 Nov 2022 01:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668390520;
        bh=gTd9UhAaGpNsBapc5RUCtXQ9L4C/RtjoD3c4Wp8gGsM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XvV46F3egoKsPWAaUtLPPeAfXQ6fG9eGMUSpabNrNU+x/MBiihFZQsQvZThwJQGJ1
         gPng0eM9beZRSJPngKUU5OdAMSf8NtZv/5fXRDNAVSPhWXKTopH+HHcfABQL5Kc2AT
         Ed51nRZN4nop9OsIWPBVk0YPCGe3FM96JwnMUOZ0ymDYwRM1M//L0mq5PvsHMQ7oFt
         eiuoM20rT3EEerHnDaqeWX9dmPyK7r/DhbVFo9Ydtrw33Un30mp6xOhsYJIAt4p9Qn
         SOTYwCzvTQvtVZI1PiukCDZQ68nhkLiTbCG5d39yWgzftvtZTQu7h05P14MrY9RKcS
         SlB61gYkCNy6A==
Date:   Mon, 14 Nov 2022 10:48:37 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <rostedt@goodmis.org>,
        <joe.lawrence@redhat.com>, <zhaogongyi@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kprobes: Skip clearing aggrprobe's post_handler in
 kprobe-on-ftrace case
Message-Id: <20221114104837.9b284586fcce589e0e7e6a42@kernel.org>
In-Reply-To: <20221112070000.35299-1-lihuafei1@huawei.com>
References: <20221112070000.35299-1-lihuafei1@huawei.com>
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

On Sat, 12 Nov 2022 15:00:00 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> In __unregister_kprobe_top(), if the currently unregistered probe has
> post_handler but other child probes of the aggrprobe do not have
> post_handler, the post_handler of the aggrprobe is cleared. If this is
> a ftrace-based probe, there is a problem. In later calls to
> disarm_kprobe(), we will use kprobe_ftrace_ops because post_handler is
> NULL. But we're armed with kprobe_ipmodify_ops. This triggers a WARN in
> __disarm_kprobe_ftrace() and may even cause use-after-free:
> 
>   Failed to disarm kprobe-ftrace at kernel_clone+0x0/0x3c0 (error -2)
>   WARNING: CPU: 5 PID: 137 at kernel/kprobes.c:1135 __disarm_kprobe_ftrace.isra.21+0xcf/0xe0
>   Modules linked in: testKprobe_007(-)
>   CPU: 5 PID: 137 Comm: rmmod Not tainted 6.1.0-rc4-dirty #18
>   [...]
>   Call Trace:
>    <TASK>
>    __disable_kprobe+0xcd/0xe0
>    __unregister_kprobe_top+0x12/0x150
>    ? mutex_lock+0xe/0x30
>    unregister_kprobes.part.23+0x31/0xa0
>    unregister_kprobe+0x32/0x40
>    __x64_sys_delete_module+0x15e/0x260
>    ? do_user_addr_fault+0x2cd/0x6b0
>    do_syscall_64+0x3a/0x90
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>    [...]
> 
> For the kprobe-on-ftrace case, we keep the post_handler setting to
> identify this aggrprobe armed with kprobe_ipmodify_ops. This way we
> can disarm it correctly.

This looks good to me. Thanks!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Fixes: 0bc11ed5ab60 ("kprobes: Allow kprobes coexist with livepatch")
> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  kernel/kprobes.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index cd9f5a66a690..3050631e528d 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1766,7 +1766,13 @@ static int __unregister_kprobe_top(struct kprobe *p)
>  				if ((list_p != p) && (list_p->post_handler))
>  					goto noclean;
>  			}
> -			ap->post_handler = NULL;
> +			/*
> +			 * For the kprobe-on-ftrace case, we keep the
> +			 * post_handler setting to identify this aggrprobe
> +			 * armed with kprobe_ipmodify_ops.
> +			 */
> +			if (!kprobe_ftrace(ap))
> +				ap->post_handler = NULL;
>  		}
>  noclean:
>  		/*
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
