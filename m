Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4F697F24
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjBOPI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjBOPI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:08:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8502FCD8;
        Wed, 15 Feb 2023 07:08:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC10A61A9C;
        Wed, 15 Feb 2023 15:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3B4C433D2;
        Wed, 15 Feb 2023 15:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676473734;
        bh=x5b3Cr/IE4onSb8sQCvX/MgoO8xJOCCnI717YbWkAac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cm3lJq5DUdRCyedw1+LZJMqlrsZ42DyA8mTxDH5p9bopuKEhr7oa3baGO2VzwgpjA
         ozz64qhq8JagZeqkLAjjjsOH4h8blpVM0j3PvqJ9rgSUUWvKYqxGquEVcHq9jQqOZd
         8EJeAbMRqdXwLYUxSX5MIKJk65ydxvNKUMPnqeJ1gAUXQHvibHV3aVrEayLcJZtq9s
         C1H/F1NxWLq0J2plYu9/X3w3nRtsgfLQWCKn9aqvopasm3UJxMCbzrRrV1SwhRaiBK
         TviqQDp8RJWcM13CNpq/8MNSQM8Cqy+wnFvU8EVNPOmEvxKl/qk8zcTia+CJR0q2CA
         2rMEu3qojZtoQ==
Date:   Thu, 16 Feb 2023 00:08:49 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <ast@kernel.org>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] x86/kprobes: Fix __recover_optprobed_insn check
 optimizing logic
Message-Id: <20230216000849.f0e332ebf35150cb5d5c4a29@kernel.org>
In-Reply-To: <20230215115430.236046-3-yangjihong1@huawei.com>
References: <20230215115430.236046-1-yangjihong1@huawei.com>
        <20230215115430.236046-3-yangjihong1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 19:54:29 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> Since the following commit:
> 
>   commit f66c0447cca1 ("kprobes: Set unoptimized flag after unoptimizing code")
> 
> modified the update timing of the KPROBE_FLAG_OPTIMIZED, a optimized_kprobe
> may be in the optimizing or unoptimizing state when op.kp->flags
> has KPROBE_FLAG_OPTIMIZED and op->list is not empty.
> 
> The __recover_optprobed_insn check logic is incorrect, a kprobe in the
> unoptimizing state may be incorrectly determined as unoptimizing.
> As a result, incorrect instructions are copied.

Ah, good catch!

> 
> The optprobe_queued_unopt function needs to be exported for invoking in
> arch directory.
> 
> Fixes: f66c0447cca1 ("kprobes: Set unoptimized flag after unoptimizing code")

Cc: stable@vger.kernel.org

> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  arch/x86/kernel/kprobes/opt.c | 4 ++--
>  include/linux/kprobes.h       | 1 +
>  kernel/kprobes.c              | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
> index e57e07b0edb6..3718d6863555 100644
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -46,8 +46,8 @@ unsigned long __recover_optprobed_insn(kprobe_opcode_t *buf, unsigned long addr)
>  		/* This function only handles jump-optimized kprobe */
>  		if (kp && kprobe_optimized(kp)) {
>  			op = container_of(kp, struct optimized_kprobe, kp);
> -			/* If op->list is not empty, op is under optimizing */
> -			if (list_empty(&op->list))
> +			/* If op is [un]optimized or under unoptimizing */

Hmm, this is a bit confusing comment. If it is unoptimized, the kprobe_optimized() returns false.
Thus the comment should be /* If op is optimized or under unoptimizing */.

Thank you,

> +			if (list_empty(&op->list) || optprobe_queued_unopt(op))
>  				goto found;
>  		}
>  	}
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index a0b92be98984..ab39285f71a6 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -378,6 +378,7 @@ extern void opt_pre_handler(struct kprobe *p, struct pt_regs *regs);
>  DEFINE_INSN_CACHE_OPS(optinsn);
>  
>  extern void wait_for_kprobe_optimizer(void);
> +bool optprobe_queued_unopt(struct optimized_kprobe *op);
>  #else /* !CONFIG_OPTPROBES */
>  static inline void wait_for_kprobe_optimizer(void) { }
>  #endif /* CONFIG_OPTPROBES */
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 0730e595f4c1..bf60eb26c873 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -661,7 +661,7 @@ void wait_for_kprobe_optimizer(void)
>  	mutex_unlock(&kprobe_mutex);
>  }
>  
> -static bool optprobe_queued_unopt(struct optimized_kprobe *op)
> +bool optprobe_queued_unopt(struct optimized_kprobe *op)
>  {
>  	struct optimized_kprobe *_op;
>  
> -- 
> 2.30.GIT
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
