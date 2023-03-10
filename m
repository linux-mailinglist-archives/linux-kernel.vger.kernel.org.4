Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E66B360A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 06:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCJFYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 00:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCJFYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 00:24:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8170DF73A2;
        Thu,  9 Mar 2023 21:24:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 788D360AB8;
        Fri, 10 Mar 2023 05:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE43C433D2;
        Fri, 10 Mar 2023 05:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678425843;
        bh=11/oeDd475kGskQ2Zo4dMEJ9xAPQrvW8B5KRsslcyAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XZ16GuZUo7TYJ2V3pyLXRK+CgS4Zx64Jsl7hq/uvuUtp6RIwKq28wT28IALGlGguz
         WG0UaWygcdZoB4reIFn5QKyPgp2TVRJ0Hha8Z1twKV8WRZWiCMAGV5eJOwhw3k+q6F
         SdMl9DbclMQUU3BEiaMunaUZ0KSYGlVrBLdm7OYvtC2rXWuIXv0qTQzhVIp8vPbtVR
         0xzKG+5qSkefQBHyoaLVOxVQtkjPvm/PS3PWHPP3As64z2PtbGmQK04jN0OwLp1ypB
         xuvAiZUNGAPgBTCwaP3WYWrk+icJNfjrDOFLXyKSTMSnBpZC+mDPzcqw94F3k9Vcx+
         Vcx8InAuAWbEA==
Date:   Fri, 10 Mar 2023 14:24:00 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     rostedt@goodmis.org, bristot@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/osnoise: set several trace_osnoise.c variables
 storage-class-specifier to static
Message-Id: <20230310142400.072ce534ddec8e375e8dfa99@kernel.org>
In-Reply-To: <20230309150414.4036764-1-trix@redhat.com>
References: <20230309150414.4036764-1-trix@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
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

On Thu,  9 Mar 2023 10:04:14 -0500
Tom Rix <trix@redhat.com> wrote:

> smatch reports several similar warnings
> kernel/trace/trace_osnoise.c:220:1: warning:
>   symbol '__pcpu_scope_per_cpu_osnoise_var' was not declared. Should it be static?
> kernel/trace/trace_osnoise.c:243:1: warning:
>   symbol '__pcpu_scope_per_cpu_timerlat_var' was not declared. Should it be static?
> kernel/trace/trace_osnoise.c:335:14: warning:
>   symbol 'interface_lock' was not declared. Should it be static?
> kernel/trace/trace_osnoise.c:2242:5: warning:
>   symbol 'timerlat_min_period' was not declared. Should it be static?
> kernel/trace/trace_osnoise.c:2243:5: warning:
>   symbol 'timerlat_max_period' was not declared. Should it be static?
> 
> These variables are only used in trace_osnoise.c, so it should be static
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  kernel/trace/trace_osnoise.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index f68ca1e6460f..cf395d2e8775 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -217,7 +217,7 @@ struct osnoise_variables {
>  /*
>   * Per-cpu runtime information.
>   */
> -DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
> +static DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
>  
>  /*
>   * this_cpu_osn_var - Return the per-cpu osnoise_variables on its relative CPU
> @@ -240,7 +240,7 @@ struct timerlat_variables {
>  	u64			count;
>  };
>  
> -DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
> +static DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
>  
>  /*
>   * this_cpu_tmr_var - Return the per-cpu timerlat_variables on its relative CPU
> @@ -332,7 +332,7 @@ struct timerlat_sample {
>  /*
>   * Protect the interface.
>   */
> -struct mutex interface_lock;
> +static struct mutex interface_lock;
>  
>  /*
>   * Tracer data.
> @@ -2239,8 +2239,8 @@ static struct trace_min_max_param osnoise_print_stack = {
>  /*
>   * osnoise/timerlat_period: min 100 us, max 1 s
>   */
> -u64 timerlat_min_period = 100;
> -u64 timerlat_max_period = 1000000;
> +static u64 timerlat_min_period = 100;
> +static u64 timerlat_max_period = 1000000;
>  static struct trace_min_max_param timerlat_period = {
>  	.lock	= &interface_lock,
>  	.val	= &osnoise_data.timerlat_period,
> -- 
> 2.27.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
