Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4A8737C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjFUHb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjFUHbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:31:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4AD1710;
        Wed, 21 Jun 2023 00:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NaqaQxah/FrLZHICWXU12yQMjvpRgrOIvBO2ioW93AY=; b=KHNtTWbSJEl/nBGTJsXuEeIdgW
        qVjhcFPOFwYWiaWIa0LK1iFSvpDOOTZdB/Ozowojefd0Wvjq7x38/6KcqWQkDs/ZsGNRIe9ZzzNlC
        UAqFWAsLDDF3K1ujtfh0z18i/p46ELqQRAL2VzBhCbH+XNYUE60eADsxslcLBB0d737i7/MvbaNYf
        b1f6qfzS4YrNERERk5tSlre56eoPRP1Me7tOxjzrTtS41Qbxi6PXLf9FbbIFITU69OFrDIUU+v6Wy
        z/X2ILqzrNvfFfeXToHnHuiqj3/HqMiGuF39YrsJEWV4htcqVMeQrq2ODCecMJoP0NXXCZKNO8H+Q
        nm4NeHAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBsIr-00E6Ol-4c; Wed, 21 Jun 2023 07:30:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA10A3002A9;
        Wed, 21 Jun 2023 09:30:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F4EC2419FDEF; Wed, 21 Jun 2023 09:30:56 +0200 (CEST)
Date:   Wed, 21 Jun 2023 09:30:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v2 4/5] intel_idle: Add no_ibrs module parameter to force
 disable IBRS
Message-ID: <20230621073056.GB2046280@hirez.programming.kicks-ass.net>
References: <20230620140625.1001886-1-longman@redhat.com>
 <20230620140625.1001886-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620140625.1001886-5-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 10:06:24AM -0400, Waiman Long wrote:
> Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
> disables IBRS when the cstate is 6 or lower. However, there are
> some use cases where a customer may want to use max_cstate=1 to
> lower latency. 

And then add the WRMSRs to increase latency again...

Since you're mucking about with all this, perhaps see if you can measure
the latency impact of all this.

> Such use cases will suffer from the performance
> degradation caused by the enabling of IBRS in the sibling idle thread.
> Add a "no_ibrs" module parameter to force disable IBRS and the
> CPUIDLE_FLAG_IRQ_ENABLE flag if set.
> 
> In the case of a Skylake server with max_cstate=1, this new no_ibrs
> option will increase the IRQ response latency as IRQ will now be
> disabled.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  drivers/idle/intel_idle.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 07fa23707b3c..366dacccc971 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -69,6 +69,7 @@ static int max_cstate = CPUIDLE_STATE_MAX - 1;
>  static unsigned int disabled_states_mask __read_mostly;
>  static unsigned int preferred_states_mask __read_mostly;
>  static bool force_irq_on __read_mostly;
> +static bool no_ibrs __read_mostly;
>  
>  static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
>  
> @@ -1907,12 +1908,15 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
>  			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
>  			state->enter = intel_idle_xstate;
>  		} else if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
> -			   state->flags & CPUIDLE_FLAG_IBRS) {
> +			  ((state->flags & CPUIDLE_FLAG_IBRS) || no_ibrs)) {
>  			/*
>  			 * IBRS mitigation requires that C-states are entered
>  			 * with interrupts disabled.
>  			 */
> -			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
> +			if (no_ibrs && (state->flags & CPUIDLE_FLAG_IRQ_ENABLE))
> +				state->flags &= ~CPUIDLE_FLAG_IRQ_ENABLE;
> +			else
> +				WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
>  			state->enter = intel_idle_ibrs;
>  		} else if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE) {
>  			state->enter = intel_idle_irq;
> @@ -2165,3 +2169,9 @@ MODULE_PARM_DESC(preferred_cstates, "Mask of preferred idle states");
>   * 'CPUIDLE_FLAG_INIT_XSTATE' and 'CPUIDLE_FLAG_IBRS' flags.
>   */
>  module_param(force_irq_on, bool, 0444);
> +/*
> + * Force the disabling of IBRS when X86_FEATURE_KERNEL_IBRS is on and
> + * CPUIDLE_FLAG_IRQ_ENABLE isn't set.
> + */
> +module_param(no_ibrs, bool, 0444);
> +MODULE_PARM_DESC(no_ibrs, "Disable IBRS when idle");

Urgghhh.. the flag is CPUIDLE_FLAG_IBRS, so "no_ibrs" implies clearing
that flag.

