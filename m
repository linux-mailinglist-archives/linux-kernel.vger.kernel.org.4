Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE8166E0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjAQOc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjAQOcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:32:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A5565AD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:31:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 879436131B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E3CC433D2;
        Tue, 17 Jan 2023 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673965877;
        bh=upnhqNKt4a6HJSP2mcFoaVwH1pixvsfteas0MFy764A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AeJr9Q+kCXrN3avZQaD+FwgJWUtWUligGvnm6LnSw8eFmuJwYOYEK3i+ex+Fn+ipx
         dL+j0Ak75XLZdf78XrQzsfjXaF9VVTt80HHZqhluLEHhjbv16+uXEIGJINDa4OG8Y9
         QRGNy9bP0SuAEaeC6Rnm2RT+QszD8l5GXOgZwwaYKG7MBS3rfUwwhK6L2xpznSSjtA
         cV+PXcZMJ0OKDNH8PoqpywUB23AO/eKtaBe28O8XHeBMGmDNhdxcxFXh++CrIECIoB
         pv9fBO2nvBE7/oTMlHpafidAvB8Zagwiz/eq70Zh/1U22Zz7XgelrhkXcjYg1XFqJC
         H98wz5FbgW58A==
Date:   Tue, 17 Jan 2023 23:31:13 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] trace,hardirq: No moar _rcuidle() tracing
Message-Id: <20230117233113.2fda1900e48969bebd0d1604@kernel.org>
In-Reply-To: <Y8ZmeGlNPLvuARBB@gmail.com>
References: <20230112194314.845371875@infradead.org>
        <20230112195541.477416709@infradead.org>
        <20230117132446.02ec12e4c10718de27790900@kernel.org>
        <Y8ZiIMHyXX/yW1EI@hirez.programming.kicks-ass.net>
        <Y8ZmeGlNPLvuARBB@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 10:17:16 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Jan 17, 2023 at 01:24:46PM +0900, Masami Hiramatsu wrote:
> > > Hi Peter,
> > > 
> > > On Thu, 12 Jan 2023 20:43:49 +0100
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > Robot reported that trace_hardirqs_{on,off}() tickle the forbidden
> > > > _rcuidle() tracepoint through local_irq_{en,dis}able().
> > > > 
> > > > For 'sane' configs, these calls will only happen with RCU enabled and
> > > > as such can use the regular tracepoint. This also means it's possible
> > > > to trace them from NMI context again.
> > > > 
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > 
> > > The code looks good to me. I just have a question about comment.
> > > 
> > > > ---
> > > >  kernel/trace/trace_preemptirq.c |   21 +++++++++++++--------
> > > >  1 file changed, 13 insertions(+), 8 deletions(-)
> > > > 
> > > > --- a/kernel/trace/trace_preemptirq.c
> > > > +++ b/kernel/trace/trace_preemptirq.c
> > > > @@ -20,6 +20,15 @@
> > > >  static DEFINE_PER_CPU(int, tracing_irq_cpu);
> > > >  
> > > >  /*
> > > > + * ...
> > > 
> > > Is this intended? Wouldn't you leave any comment here?
> > 
> > I indeed forgot to write the comment before posting, my bad :/ Ingo fixed
> > it up when he applied.
> 
> For completeness, I've attached the final commit, which has this comment 
> included:
> 
> +/*
> + * Use regular trace points on architectures that implement noinstr
> + * tooling: these calls will only happen with RCU enabled, which can
> + * use a regular tracepoint.
> + *
> + * On older architectures, use the rcuidle tracing methods (which
> + * aren't NMI-safe - so exclude NMI contexts):
> + */

Thanks! This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Thanks,
> 
> 	Ingo
> 
> ================>
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu, 12 Jan 2023 20:43:49 +0100
> Subject: [PATCH] tracing, hardirq: No moar _rcuidle() tracing
> 
> Robot reported that trace_hardirqs_{on,off}() tickle the forbidden
> _rcuidle() tracepoint through local_irq_{en,dis}able().
> 
> For 'sane' configs, these calls will only happen with RCU enabled and
> as such can use the regular tracepoint. This also means it's possible
> to trace them from NMI context again.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/r/20230112195541.477416709@infradead.org
> ---
>  kernel/trace/trace_preemptirq.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
> index 629f2854e12b..f992444a0b1f 100644
> --- a/kernel/trace/trace_preemptirq.c
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -19,6 +19,20 @@
>  /* Per-cpu variable to prevent redundant calls when IRQs already off */
>  static DEFINE_PER_CPU(int, tracing_irq_cpu);
>  
> +/*
> + * Use regular trace points on architectures that implement noinstr
> + * tooling: these calls will only happen with RCU enabled, which can
> + * use a regular tracepoint.
> + *
> + * On older architectures, use the rcuidle tracing methods (which
> + * aren't NMI-safe - so exclude NMI contexts):
> + */
> +#ifdef CONFIG_ARCH_WANTS_NO_INSTR
> +#define trace(point)	trace_##point
> +#else
> +#define trace(point)	if (!in_nmi()) trace_##point##_rcuidle
> +#endif
> +
>  /*
>   * Like trace_hardirqs_on() but without the lockdep invocation. This is
>   * used in the low level entry code where the ordering vs. RCU is important
> @@ -28,8 +42,7 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
>  void trace_hardirqs_on_prepare(void)
>  {
>  	if (this_cpu_read(tracing_irq_cpu)) {
> -		if (!in_nmi())
> -			trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
> +		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
>  		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
>  		this_cpu_write(tracing_irq_cpu, 0);
>  	}
> @@ -40,8 +53,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_prepare);
>  void trace_hardirqs_on(void)
>  {
>  	if (this_cpu_read(tracing_irq_cpu)) {
> -		if (!in_nmi())
> -			trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> +		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
>  		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
>  		this_cpu_write(tracing_irq_cpu, 0);
>  	}
> @@ -63,8 +75,7 @@ void trace_hardirqs_off_finish(void)
>  	if (!this_cpu_read(tracing_irq_cpu)) {
>  		this_cpu_write(tracing_irq_cpu, 1);
>  		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
> -		if (!in_nmi())
> -			trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
> +		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
>  	}
>  
>  }
> @@ -78,8 +89,7 @@ void trace_hardirqs_off(void)
>  	if (!this_cpu_read(tracing_irq_cpu)) {
>  		this_cpu_write(tracing_irq_cpu, 1);
>  		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
> -		if (!in_nmi())
> -			trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> +		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
>  	}
>  }
>  EXPORT_SYMBOL(trace_hardirqs_off);


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
