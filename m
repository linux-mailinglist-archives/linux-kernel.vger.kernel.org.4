Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1AF706756
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjEQMAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjEQL74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:59:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E29421D;
        Wed, 17 May 2023 04:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9D7D638AE;
        Wed, 17 May 2023 11:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8FEC4339B;
        Wed, 17 May 2023 11:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684324794;
        bh=+KJCyW8UcBpWC8n/rNnAChXGAO9waLTlJQG8Dp7ZVa0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A3wxgK//Fl+HRbw82WER6yeLjIrBy7NjkG7nKzaC9v+P1fj78NXLtyfTUYg6p8RW3
         bcAK0NdVb6cmJkcuG45bfXlMqsGuVB3TLoZ9orpTFPY1byepkeSx7xQjtgNU8zrKKD
         wTdJxIXAMwBx6Iy/a0uF9S1BYxfeG0GyYWMfIWmHRxsQhRcHkH1v9LzjA+kNLKpqv7
         e8r084YNf5nre8CudRHdqPB1LnJmYIUgarQqld+w/Od+y+7vBvaKV14OCnreYJC/FG
         6y/C9GMB3OgNGppJUtg0r4xA4tjwSUsps1xz2PWr2TMPKYhtqmtc7D/8CKGwlHTkOb
         B2qnlglxsW41Q==
Date:   Wed, 17 May 2023 20:59:47 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Conor Dooley <conor@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Yonghong Song <yhs@fb.com>, Ze Gao <zegao@tencent.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/4] rethook: use preempt_{disable, enable}_notrace
 in rethook_trampoline_handler
Message-Id: <20230517205947.c1710ed175519b59f56e09b1@kernel.org>
In-Reply-To: <20230517034510.15639-2-zegao@tencent.com>
References: <20230517034510.15639-1-zegao@tencent.com>
        <20230517034510.15639-2-zegao@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ze Gao,

On Wed, 17 May 2023 11:45:06 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> This patch replaces preempt_{disable, enable} with its corresponding
> notrace version in rethook_trampoline_handler so no worries about stack
> recursion or overflow introduced by preempt_count_{add, sub} under
> fprobe + rethook context.
> 
> Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
> Signed-off-by: Ze Gao <zegao@tencent.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/linux-trace-kernel/20230516071830.8190-2-zegao@tencent.com

Note that you don't need to add Link tag of the previous version for each patch.
I'll add it when I pick it :)

Thank you,

> ---
>  kernel/trace/rethook.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index 32c3dfdb4d6a..60f6cb2b486b 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -288,7 +288,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
>  	 * These loops must be protected from rethook_free_rcu() because those
>  	 * are accessing 'rhn->rethook'.
>  	 */
> -	preempt_disable();
> +	preempt_disable_notrace();
>  
>  	/*
>  	 * Run the handler on the shadow stack. Do not unlink the list here because
> @@ -321,7 +321,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
>  		first = first->next;
>  		rethook_recycle(rhn);
>  	}
> -	preempt_enable();
> +	preempt_enable_notrace();
>  
>  	return correct_ret_addr;
>  }
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
