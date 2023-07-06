Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5478C7494BB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 06:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjGFEgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 00:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGFEgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 00:36:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549321BCE;
        Wed,  5 Jul 2023 21:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7F2C6184A;
        Thu,  6 Jul 2023 04:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD284C433C8;
        Thu,  6 Jul 2023 04:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688618193;
        bh=AYmEf4kiL2UaxWitCr6OKYONu/l9HwO55saa1YDC5Y8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gddoht5G/GUlhPxBTqrMlK5Oj7OiOV9NOdv1SyThjWB6I8cJQYLXAk2u374jXAtqk
         YbLmWyrMoOZdlr7m2lAbQgZQkyISqIcYh0tUN4N33wQxTL/tXjDBj41Ko7MBfR2r7n
         llEuWmAalJiBwIqEz/AJ0MCjgARqq15AeM3nyvb/s8vRS+1vgJOfvnbxIUFy7QVvcx
         JhkGQKO9m3ayCsukJ3loYcXzPznNwl5QVuthj8ddNz5CXF46LuyFJx63ZuuchonRy0
         L0bykYpmt/VusjrF9ah7Hs0Fd0nnQVvJpyR99hCbdhO8s716bggQMfY/UrVWU3/Hl9
         SNc/UlQHAS2LA==
Date:   Thu, 6 Jul 2023 13:36:30 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Naveen N Rao <naveen@kernel.org>
Cc:     <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] trace/kprobe: Display the actual notrace function
 when rejecting a probe
Message-Id: <20230706133630.dc5b67322c840c8a2abd60a7@kernel.org>
In-Reply-To: <20230609075809.434392-1-naveen@kernel.org>
References: <20230609075809.434392-1-naveen@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naveen,

Sorry I missed this patch.

On Fri,  9 Jun 2023 13:28:09 +0530
Naveen N Rao <naveen@kernel.org> wrote:

> Trying to probe update_sd_lb_stats() using perf results in the below
> message in the kernel log:
> 	trace_kprobe: Could not probe notrace function _text
> 
> This is because 'perf probe' specifies the kprobe location as an offset
> from '_text':
> 	$ sudo perf probe -D update_sd_lb_stats
> 	p:probe/update_sd_lb_stats _text+1830728
> 
> However, the error message is misleading and doesn't help convey the
> actual notrace function that is being probed. Fix this by looking up the
> actual function name that is being probed. With this fix, we now get the
> below message in the kernel log:
> 	trace_kprobe: Could not probe notrace function update_sd_lb_stats.constprop.0
> 
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
> v2: Update within_notrace_func() stub macro with the second parameter to 
> fix the build error reported by the kernel test robot.
> 
> - Naveen
> 
>  kernel/trace/trace_kprobe.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 74adb82331dd81..2d695db5425e7c 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -449,9 +449,8 @@ static bool __within_notrace_func(unsigned long addr)
>  	return !ftrace_location_range(addr, addr + size - 1);
>  }
>  
> -static bool within_notrace_func(struct trace_kprobe *tk)
> +static bool within_notrace_func(struct trace_kprobe *tk, unsigned long addr)
>  {
> -	unsigned long addr = trace_kprobe_address(tk);
>  	char symname[KSYM_NAME_LEN], *p;
>  
>  	if (!__within_notrace_func(addr))
> @@ -471,12 +470,14 @@ static bool within_notrace_func(struct trace_kprobe *tk)
>  	return true;
>  }
>  #else
> -#define within_notrace_func(tk)	(false)
> +#define within_notrace_func(tk, addr)	(false)
>  #endif

Is this for avoiding redundant calling the trace_kprobe_address(tk)? If so,
please pass only 'addr' to the function since 'tk' is only used for calling
trace_kprobe_address(tk) in the within_notrace_func(). :)

Thank you,

>  
>  /* Internal register function - just handle k*probes and flags */
>  static int __register_trace_kprobe(struct trace_kprobe *tk)
>  {
> +	unsigned long addr = trace_kprobe_address(tk);
> +	char symname[KSYM_NAME_LEN];
>  	int i, ret;
>  
>  	ret = security_locked_down(LOCKDOWN_KPROBES);
> @@ -486,9 +487,9 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
>  	if (trace_kprobe_is_registered(tk))
>  		return -EINVAL;
>  
> -	if (within_notrace_func(tk)) {
> +	if (within_notrace_func(tk, addr)) {
>  		pr_warn("Could not probe notrace function %s\n",
> -			trace_kprobe_symbol(tk));
> +			lookup_symbol_name(addr, symname) ? trace_kprobe_symbol(tk) : symname);
>  		return -EINVAL;
>  	}
>  
> 
> base-commit: e46ad59233cf16daf4f3b9dd080003f01ac940fe
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
