Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A21697EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBOO4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjBOOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:55:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E703B0EA;
        Wed, 15 Feb 2023 06:55:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FED9B81E9A;
        Wed, 15 Feb 2023 14:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576D6C4339B;
        Wed, 15 Feb 2023 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676472921;
        bh=qxE/xm8KxbMApDELbPj3eNbZD85qZ13Uw/t7nFI+kK8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PWi4wQ1Rq6h0sivGcooSxkqpKr7fs9IctoU+Ybo4+hNkRc9XlZY4gSBRrVUrsiyBt
         AlejPp0nqUm4265Pcj03htjhwSMy2WzuNeCQg7FodVsEWwAt8j2uFv2yWlc/5Y9IZP
         G5PghsPmCdp1ydprgHOOrrAUZVr1GhEpwPTBDatKS6m7ZL5rCpK57VI+Z/L6tmtdYG
         NyHeWcE/ler7J3ZtE6Vyit3qKC6ummhnYK39twR5+WkU6EPjNvjukSppjylBzDXkw4
         3GEZDUoDmsYpNHer64RcprWUq5yB1K2YnkKo3bDlxrY3g27lxbmvTtWJTTj/ZofR7w
         +oted11GtxGUw==
Date:   Wed, 15 Feb 2023 23:55:17 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <ast@kernel.org>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] kprobes: Fixed probe nodes not correctly removed
 when forcibly unoptimized
Message-Id: <20230215235517.800c5089318b5353e7304b67@kernel.org>
In-Reply-To: <20230215115430.236046-2-yangjihong1@huawei.com>
References: <20230215115430.236046-1-yangjihong1@huawei.com>
        <20230215115430.236046-2-yangjihong1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Thanks for reporting, but maybe this is a part of following fix.

https://lore.kernel.org/all/167448024501.3253718.13037333683110512967.stgit@devnote3/

Can you confirm that fixes the same issue?

Thank you,

On Wed, 15 Feb 2023 19:54:28 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> When unoptimize_kprobe forcibly unoptimize the kprobe, simply queue it in
> the freeing_list, and do_free_cleaned_kprobes directly reclaims the kprobe
> if unoptimizing_list is empty (see do_unoptimize_kprobes), which may cause
> WARN or UAF problems.
> 
> The specific scenarios are as follows:
> 
>                           Thread1
> arm_kprobe(p)
>   mutex_lock(&kprobe_mutex)
>   __arm_kprobe(kp)
>     p = get_optimized_kprobe(p->addr)
>     if (unlikely(_p))
>       unoptimize_kprobe(_p, true)  // now _p is queued in freeing_list
>   mutex_unlock(&kprobe_mutex)
> 
>                            Thread2
> kprobe_optimizer
>   mutex_lock(&kprobe_mutex)
>   do_unoptimize_kprobes
>     if (list_empty(&unoptimizing_list))
>       return;  // here directly returned and does not process freeing_list.
>   ...
>   do_free_cleaned_kprobes
>     foreach op in freeing_list:
>       WARN_ON_ONCE(!kprobe_unused(&op->kp))  // WANR will be triggered here.
>       free_aggr_kprobe((&op->kp)  // Delete op->kp directly, if access hash
>                                   // list later, UAF problem will be triggered.
>   mutex_unlock(&kprobe_mutex)
> 
> The freeing_list needs to be processed in do_unoptimize_kprobes regardless
> of whether unoptimizing_list is empty.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  kernel/kprobes.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 1c18ecf9f98b..0730e595f4c1 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -556,10 +556,9 @@ static void do_unoptimize_kprobes(void)
>  	lockdep_assert_cpus_held();
>  
>  	/* Unoptimization must be done anytime */
> -	if (list_empty(&unoptimizing_list))
> -		return;
> +	if (!list_empty(&unoptimizing_list))
> +		arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
>  
> -	arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
>  	/* Loop on 'freeing_list' for disarming */
>  	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
>  		/* Switching from detour code to origin */
> -- 
> 2.30.GIT
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
