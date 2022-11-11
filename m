Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83034625E67
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiKKPdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiKKPdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:33:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67395627C3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:33:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D44CD62022
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E7AC433C1;
        Fri, 11 Nov 2022 15:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668180795;
        bh=AzVpKtlfPqtmz1f38RB9V1qWySbbkpF85WLpd8OKAns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O8gLjJRPiBs/w1npPHNf/qZ1/S9gEHrIc8WKpJxYCDtLxJjh+cJWqEWGKtoPtj5Ui
         DOPrY2uReL/kPu2kwlZn+rx6ZKp2XEjPmx8Q1EgIsd+RIkk1ikZ9ECy3/skIFRRDoe
         ya2jNvgBjTXNUJOqjYhbMCPGjYkqd+3csD53b8PcgynyGRmfEB36tsxxrx4TTA2XIM
         RJnf+wrCM5kAoXxxeAahVZyQ2PdDppq3A4S6dsowkBPd/FXL96TPiqfGV2HPioLKM7
         qgsnJc3rsYHaBOYSuLFNO0nyzBijRCbjQ9HiLC18+4ycWuF8Y/HRYRTpw7dxrzL6hJ
         E3PVMJ3Vf3L7w==
Date:   Sat, 12 Nov 2022 00:33:11 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <rostedt@goodmis.org>, <joe.lawrence@redhat.com>,
        <zhaogongyi@huawei.com>
Subject: Re: [PATCH] kprobes: Update ftrace_ops when clearing ftrace-based
 aggrprobe's post_handler
Message-Id: <20221112003311.30ff643aee860d5b27e3617a@kernel.org>
In-Reply-To: <20221111101006.239177-1-lihuafei1@huawei.com>
References: <20221111101006.239177-1-lihuafei1@huawei.com>
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

On Fri, 11 Nov 2022 18:10:06 +0800
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

Ah, good catch! :D

> 
> For ftrace kprobe, update post_handler at the same time update
> ftrace_ops, moving it from kprobe_ipmodify_ops to kprobe_ftrace_ops.

Hmm, but I would not like this because there can be a time
window when it can miss an event. What about just skipping
clearing ap->post_handler in kprobe-on-ftrace case?

> 
> Fixes: 0bc11ed5ab60 ("kprobes: Allow kprobes coexist with livepatch")
> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  kernel/kprobes.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index cd9f5a66a690..f8bec48a9cf9 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1766,7 +1766,17 @@ static int __unregister_kprobe_top(struct kprobe *p)
>  				if ((list_p != p) && (list_p->post_handler))
>  					goto noclean;
>  			}
> -			ap->post_handler = NULL;
> +			/*
> +			 * For ftrace kprobe, we need to update ftrace_ops
> +			 * at the same time as we update post_handler, moving
> +			 * it from kprobe_ipmodify_ops to kprobe_ftrace_ops.
> +			 */
> +			if (unlikely(kprobe_ftrace(ap))) {
> +				disarm_kprobe(ap, false);
> +				ap->post_handler = NULL;
> +				arm_kprobe(ap);
> +			} else

So here, just add; (also, don't use unlikely/likely for this case, this
depends on where the user probes, not a systematically rare case.)

			if (!kprobe_ftrace(ap))

> +				ap->post_handler = NULL;

Thank you!

>  		}
>  noclean:
>  		/*
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
