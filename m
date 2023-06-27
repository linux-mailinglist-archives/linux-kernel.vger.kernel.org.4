Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D8973FDE1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjF0OdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjF0OdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C11270F;
        Tue, 27 Jun 2023 07:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63B1F61073;
        Tue, 27 Jun 2023 14:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953C3C433C8;
        Tue, 27 Jun 2023 14:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687876389;
        bh=TJ2J28OZSyn0/aAiLQifM0puxoCRG3Y0sim/tHkp6HA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VPMPPD6DBEGwXu64CGl3oGLGa3i5K79EjbHf+ob2NWE1m5eGAXzE+O3Er0woCt53l
         5pDrlTM3KoT7gA8ULYbtHY0Ul4XF3FxMZ/uaguomkVR4ZvsJO1r0YSpJLyMKPDMzae
         IXRbB8lmY2dWHxUmG1i36lNnHkVsU2SbznUSCerxYY/8BAl40ZwSZRQ7fFua0Wm7XX
         deShR6MW5ESDESDfARifhn8W3a74ik8eDzJHalVj+Gjfa+qlG5q8XsKAxhiRVIztK8
         ZiNd4+f76FB1vxZaoKqs51XVEraphcw8DpdQSkMOFG9N6ackik2VV05Bwz2DeLjWwG
         QFWukSKcMEuBA==
Date:   Tue, 27 Jun 2023 23:33:06 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] fprobe: Release rethook after the ftrace_ops is
 unregistered
Message-Id: <20230627233306.b9b04d75f86944466f6534c2@kernel.org>
In-Reply-To: <20230615115236.3476617-1-jolsa@kernel.org>
References: <20230615115236.3476617-1-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, 15 Jun 2023 13:52:36 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> While running bpf selftests it's possible to get following fault:
> 
>   general protection fault, probably for non-canonical address \
>   0x6b6b6b6b6b6b6b6b: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
>   ...
>   Call Trace:
>    <TASK>
>    fprobe_handler+0xc1/0x270
>    ? __pfx_bpf_testmod_init+0x10/0x10
>    ? __pfx_bpf_testmod_init+0x10/0x10
>    ? bpf_fentry_test1+0x5/0x10
>    ? bpf_fentry_test1+0x5/0x10
>    ? bpf_testmod_init+0x22/0x80
>    ? do_one_initcall+0x63/0x2e0
>    ? rcu_is_watching+0xd/0x40
>    ? kmalloc_trace+0xaf/0xc0
>    ? do_init_module+0x60/0x250
>    ? __do_sys_finit_module+0xac/0x120
>    ? do_syscall_64+0x37/0x90
>    ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
>    </TASK>
> 
> In unregister_fprobe function we can't release fp->rethook while it's
> possible there are some of its users still running on another cpu.

Ah, OK. rethook_free() invoked call_rcu(rethook_free_rcu) to free the
rethook, and it is possible rethook_free_rcu() is called before disabling
all fprobe, then `rethook_try_get(fp->rethook)` will access fp->rethook
which has been freed.

> 
> Moving rethook_free call after fp->ops is unregistered with
> unregister_ftrace_function call.
> 
> Fixes: 5b0ab78998e3 ("fprobe: Add exit_handler support")
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!


> ---
>  kernel/trace/fprobe.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
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
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
