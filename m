Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729DA72EE42
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjFMVs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjFMVsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:48:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD441BD2;
        Tue, 13 Jun 2023 14:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6238B63B41;
        Tue, 13 Jun 2023 21:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F151C433C8;
        Tue, 13 Jun 2023 21:48:47 +0000 (UTC)
Date:   Tue, 13 Jun 2023 17:48:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [RFC] fprobe call of rethook_try_get faults
Message-ID: <20230613174844.4d50991d@gandalf.local.home>
In-Reply-To: <ZICzdpvp46Xk1rIv@krava>
References: <ZICzdpvp46Xk1rIv@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 09:42:30 -0700
Jiri Olsa <olsajiri@gmail.com> wrote:

> I can't really reliable reproduce this, but while checking the code, I wonder
> we should call rethook_free only after we call unregister_ftrace_function like
> in the patch below

Yeah, I think you're right!

> 
> jirka
> 
> 
> ---
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 18d36842faf5..0121e8c0d54e 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -364,19 +364,13 @@ int unregister_fprobe(struct fprobe *fp)
>  		    fp->ops.saved_func != fprobe_kprobe_handler))
>  		return -EINVAL;
>  
> -	/*
> -	 * rethook_free() starts disabling the rethook, but the rethook handlers
> -	 * may be running on other processors at this point. To make sure that all
> -	 * current running handlers are finished, call unregister_ftrace_function()
> -	 * after this.
> -	 */
> -	if (fp->rethook)
> -		rethook_free(fp->rethook);

The above only waits for RCU to finish and then starts to free rethook.

This also means that something could be on the trampoline already and was
preempted. It could be that this code path gets preempted. Anyway, I don't
see how freeing rethook is safe before disabling all users.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> -
>  	ret = unregister_ftrace_function(&fp->ops);
>  	if (ret < 0)
>  		return ret;
>  
> +	if (fp->rethook)
> +		rethook_free(fp->rethook);
> +
>  	ftrace_free_filter(&fp->ops);
>  
>  	return ret;

