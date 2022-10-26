Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1660DDCF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJZJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiJZJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:12:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C13887099;
        Wed, 26 Oct 2022 02:11:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DA93B82142;
        Wed, 26 Oct 2022 09:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD45AC433D7;
        Wed, 26 Oct 2022 09:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666775517;
        bh=PIimMuLI9CNMLaeCfbictJucLoaPL0eK1eBLGMFnxpQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lz/ZVOLZ0RY+Fl3Pd24Uq9YwYNAdB4ICZIy47vDgasUY4JHFGG3o+tRQ96ghIRakv
         tK1GYbGaHpSjaXaNcniJitP0OiLY9EWCog1Pr5tfWQuzVlRSRKo0ZabwycsOqOOQW7
         3bkYDa8CVpr/Tv9LYlj+gwj3vzmIS4LROGTOaWrFMxEKz0sYX0f9EGDIK9UBUPI/9E
         5+MBhHLj/ntmtCaXS4JzWxaI0PGsNtUAZlpBjD6tBBqTa62NAK69P66EFX6a1gUZQC
         98FNY3+S4sg2CGr9jR4NEXPWCdI6VqufBlzYy81ktXlBQT9p+dROXGoOy5K82UF/jr
         Hsn1BZoOuHIEw==
Date:   Wed, 26 Oct 2022 18:11:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] tracing/fprobe: Fix to check whether fprobe is
 registered correctly
Message-Id: <20221026181153.5cf1b967c5c97b68f077cbc6@kernel.org>
In-Reply-To: <166653477373.988423.13256491425983587550.stgit@mhiramat.roam.corp.google.com>
References: <166653477373.988423.13256491425983587550.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2022 23:19:33 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since commit ab51e15d535e ("fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag
> for fprobe") introduced fprobe_kprobe_handler() for fprobe::f_op::func,
> unregister_fprobe() fails to unregister the registered if user specifies
> FPROBE_FL_KPROBE_SHARED flag.
> To check it correctly, it should confirm the fprobe::f_op::func is either
> fprobe_handler() or fprobe_kprobe_handler().
> 
> Fixes: ab51e15d535e ("fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag for fprobe")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fprobe.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index aac63ca9c3d1..9000d8ea6274 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -301,7 +301,8 @@ int unregister_fprobe(struct fprobe *fp)
>  {
>  	int ret;
>  
> -	if (!fp || fp->ops.func != fprobe_handler)
> +	if (!fp || (fp->ops.func != fprobe_handler &&
> +		    fp->ops.func != fprobe_kprobe_handler))

Oops, ops.func can be changed by ftrace itself. Hmm, maybe I should check fp->ops.saved_func instead.

Thank you,

>  		return -EINVAL;
>  
>  	/*
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
