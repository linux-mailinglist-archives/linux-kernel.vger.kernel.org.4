Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED8A697FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBOPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBOPtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:49:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B5334F63;
        Wed, 15 Feb 2023 07:49:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D05B761C81;
        Wed, 15 Feb 2023 15:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9024C4339B;
        Wed, 15 Feb 2023 15:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676476144;
        bh=4W4esv+w8gI12LSlPGfl6ZnF0FcOF+BHGyG/jHssSWs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ekR5Yc4jNaFPCOtGRX7yje6zK1y+jU0cQettdt3+F+csZ8rRe1qwzWgUwWAiB38XU
         7JmPx4FziY/uGZvInSchqxJQsgK24b9qNfshMlg2C4NiLXKTcCztOvxeCiI6AHqnQO
         qXVctaDYvFgXg94mWilAUKTfMWtF/j0kjtuAHhZ9kzCCCK+4jSNvApwEdef+ScCKGK
         cta49kugLGrMoWf2C/zzbDYi5YScf+DXCrHbWO7gIdFnvk4kEx6aZuNlD7kN6kK1gw
         AYL+6MWe92e8VPUwIqFj51DE4lQH96XSOc101LqwiI/91D36QAhjcxZQbKMIqh3nhA
         A4XMOY/mM48Gw==
Date:   Thu, 16 Feb 2023 00:48:59 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <ast@kernel.org>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] x86/kprobes: Fix arch_check_optimized_kprobe check
 within optimized_kprobe range
Message-Id: <20230216004859.ab66b42e2e0029cf042fe194@kernel.org>
In-Reply-To: <20230215115430.236046-4-yangjihong1@huawei.com>
References: <20230215115430.236046-1-yangjihong1@huawei.com>
        <20230215115430.236046-4-yangjihong1@huawei.com>
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

On Wed, 15 Feb 2023 19:54:30 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> When arch_prepare_optimized_kprobe calculating jump destination address,
> it copies original instructions from jmp-optimized kprobe (see
> __recover_optprobed_insn), and calculated based on length of original
> instruction.
> 
> arch_check_optimized_kprobe does not check KPROBE_FLAG_OPTIMATED when
> checking whether jmp-optimized kprobe exists.
> As a result, setup_detour_execution may jump to a range that has been
> overwritten by jump destination address, resulting in an inval opcode error.

OK, good catch !! I missed "delayed unoptimization" case here too.

> 
> For example, assume that register two kprobes whose addresses are
> <func+9> and <func+11> in "func" function.
> The original code of "func" function is as follows:
> 
>    0xffffffff816cb5e9 <+9>:     push   %r12
>    0xffffffff816cb5eb <+11>:    xor    %r12d,%r12d
>    0xffffffff816cb5ee <+14>:    test   %rdi,%rdi
>    0xffffffff816cb5f1 <+17>:    setne  %r12b
>    0xffffffff816cb5f5 <+21>:    push   %rbp
> 
> 1.Register the kprobe for <func+11>, assume that is kp1, corresponding optimized_kprobe is op1.
>   After the optimization, "func" code changes to:
> 
>    0xffffffff816cc079 <+9>:     push   %r12
>    0xffffffff816cc07b <+11>:    jmp    0xffffffffa0210000
>    0xffffffff816cc080 <+16>:    incl   0xf(%rcx)
>    0xffffffff816cc083 <+19>:    xchg   %eax,%ebp
>    0xffffffff816cc084 <+20>:    (bad)
>    0xffffffff816cc085 <+21>:    push   %rbp
> 
> Now op1->flags == KPROBE_FLAG_OPTIMATED;
> 
> 2. Register the kprobe for <func+9>, assume that is kp2, corresponding optimized_kprobe is op2.
> 
> register_kprobe(kp2)
>   register_aggr_kprobe
>     alloc_aggr_kprobe
>       __prepare_optimized_kprobe
>         arch_prepare_optimized_kprobe
>           __recover_optprobed_insn    // copy original bytes from kp1->optinsn.copied_insn,
>                                       // jump address = <func+14>
> 
> 3. disable kp1:
> 
> disable_kprobe(kp1)
>   __disable_kprobe
>     ...
>     if (p == orig_p || aggr_kprobe_disabled(orig_p)) {
>       ret = disarm_kprobe(orig_p, true)       // add op1 in unoptimizing_list, not unoptimized
>       orig_p->flags |= KPROBE_FLAG_DISABLED;  // op1->flags ==  KPROBE_FLAG_OPTIMATED | KPROBE_FLAG_DISABLED
>     ...
> 
> 4. unregister kp2
> __unregister_kprobe_top
>   ...
>   if (!kprobe_disabled(ap) && !kprobes_all_disarmed) {
>     optimize_kprobe(op)
>       ...
>       if (arch_check_optimized_kprobe(op) < 0) // because op1 has KPROBE_FLAG_DISABLED, here not return
>         return;
>       p->kp.flags |= KPROBE_FLAG_OPTIMIZED;   //  now op2 has KPROBE_FLAG_OPTIMIZED
>   }
> 
> "func" code now is:
> 
>    0xffffffff816cc079 <+9>:     int3
>    0xffffffff816cc07a <+10>:    push   %rsp
>    0xffffffff816cc07b <+11>:    jmp    0xffffffffa0210000
>    0xffffffff816cc080 <+16>:    incl   0xf(%rcx)
>    0xffffffff816cc083 <+19>:    xchg   %eax,%ebp
>    0xffffffff816cc084 <+20>:    (bad)
>    0xffffffff816cc085 <+21>:    push   %rbp
> 
> 5. if call "func", int3 handler call setup_detour_execution:
> 
>   if (p->flags & KPROBE_FLAG_OPTIMIZED) {
>     ...
>     regs->ip = (unsigned long)op->optinsn.insn + TMPL_END_IDX;
>     ...
>   }
> 
> The code for the destination address is
> 
>    0xffffffffa021072c:  push   %r12
>    0xffffffffa021072e:  xor    %r12d,%r12d
>    0xffffffffa0210731:  jmp    0xffffffff816cb5ee <func+14>
> 
> However, <func+14> is not a valid start instruction address. As a result, an error occurs.

OK, it has been introduced by the same commit as previous one. (delayed unoptimization)

> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  arch/x86/kernel/kprobes/opt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
> index 3718d6863555..e6d9bd038401 100644
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -353,7 +353,7 @@ int arch_check_optimized_kprobe(struct optimized_kprobe *op)
>  
>  	for (i = 1; i < op->optinsn.size; i++) {
>  		p = get_kprobe(op->kp.addr + i);
> -		if (p && !kprobe_disabled(p))
> +		if (p && (!kprobe_disabled(p) || kprobe_optimized(p)))

Hmm, can you rewrite this with kprobe_disarmed() instead of kprobe_disabled()?
Since this is checking there are any other kprobes are "armed" on the address
where it will be replaced by jump. So it is natural to use "disarmed" check.

Thank you,


>  			return -EEXIST;
>  	}
>  
> -- 
> 2.30.GIT
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
