Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8DE704450
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 06:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjEPEZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 00:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEPEZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 00:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE32E199D;
        Mon, 15 May 2023 21:25:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FE8D625E2;
        Tue, 16 May 2023 04:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92322C433D2;
        Tue, 16 May 2023 04:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684211106;
        bh=9wMxAD6PoHOqDdlWCO7opXIh2VlJBRBjZmgi4WFmsCY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oK8Re3tiMtXuYviAqv9wSkvE2UgQAABR0Kf7JQJcDiUmz+dY2toTnDFVj3aBl1Gee
         pYITTkATnkx08Zjdy2ZRGCThhFrkNWnpcixE90k1tuVataacTYaGFQEWfHl4U4zPN+
         USgs20h3bxkJ9cnyGdoM8yROcYYDoHdX6yfJNffAXGQsH/D07GEj/6GDckKLcWPWsY
         un8XntvPTuMiCCOMRAEy+oxAoaz7IOt2mXHOtkq5Mb+z0LMiufgWBuYqgE3ThIuHd/
         Y9wL6FL0zIrkApWl/TY4h2DY7JTo5Clc1PU6xKMK0hVHoMG2qDp8T/CXwR4UNUAem9
         SDp5MgvUZsSJg==
Date:   Tue, 16 May 2023 13:25:02 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Ze Gao <zegao@tencent.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] rethook: use preempt_{disable, enable}_notrace in
 rethook_trampoline_handler
Message-Id: <20230516132502.c51be728bd086b8c9005ce57@kernel.org>
In-Reply-To: <a17a14abfb81cb0eea77c2ee10d7fc98d5d5a73e.1684120990.git.zegao@tencent.com>
References: <cover.1684120990.git.zegao@tencent.com>
        <a17a14abfb81cb0eea77c2ee10d7fc98d5d5a73e.1684120990.git.zegao@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ze Gao,

Thanks for the patch.

On Mon, 15 May 2023 11:26:38 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> This patch replace preempt_{disable, enable} with its corresponding
> notrace version in rethook_trampoline_handler so no worries about stack
> recursion or overflow introduced by preempt_count_{add, sub} under
> fprobe + rethook context.

So, have you ever see that recursion of preempt_count overflow case?

I intended to use the normal preempt_disable() here because it does NOT
prohibit any function-trace call (Note that both kprobes and
fprobe checks recursive call by itself) but it is used for preempt_onoff
tracer.

Thanks,

> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
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
