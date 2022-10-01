Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1137A5F1B2D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiJAJVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJAJVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:21:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAC8B875;
        Sat,  1 Oct 2022 02:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65A20B80E4A;
        Sat,  1 Oct 2022 09:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6850AC433D6;
        Sat,  1 Oct 2022 09:21:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="J7Gv+Xte"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664616092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=if3fWvrKon9mvOiTFOqskJT1rNyZazpBxNeaBASmzcw=;
        b=J7Gv+Xte2zkH3fows144+91p5bwA3nYCyD+OXNjiT+5vHvD2mOhk1E9dhAKJ8lbQypx7hO
        U3qeURYe0+JaYgpa495EGvLbd0up8zXFXl14d3h7e4NzBTlV7oXUKp30O4POg276vsZ3wf
        NUpib5a5L+DnSeGHqJwtPsy/e55yuqg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b19daad9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 1 Oct 2022 09:21:32 +0000 (UTC)
Date:   Sat, 1 Oct 2022 11:21:30 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH 2/2] random: spread out jitter callback to different CPUs
Message-ID: <YzgGmh6EQtWzO4HV@zx2c4.com>
References: <20220930231050.749824-1-Jason@zx2c4.com>
 <20220930231050.749824-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220930231050.749824-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 01:10:50AM +0200, Jason A. Donenfeld wrote:
> Rather than merely hoping that the callback gets called on another CPU,
> arrange for that to actually happen, by round robining which CPU the
> timer fires on. This way, on multiprocessor machines, we exacerbate
> jitter by touching the same memory from multiple different cores.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index fdf15f5c87dd..74627b53179a 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1209,6 +1209,7 @@ static void __cold try_to_generate_entropy(void)
>  	struct entropy_timer_state stack;
>  	unsigned int i, num_different = 0;
>  	unsigned long last = random_get_entropy();
> +	int cpu = -1;
>  
>  	for (i = 0; i < NUM_TRIAL_SAMPLES - 1; ++i) {
>  		stack.entropy = random_get_entropy();
> @@ -1223,8 +1224,17 @@ static void __cold try_to_generate_entropy(void)
>  	stack.samples = 0;
>  	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
>  	while (!crng_ready() && !signal_pending(current)) {
> -		if (!timer_pending(&stack.timer))
> -			mod_timer(&stack.timer, jiffies);
> +		if (!timer_pending(&stack.timer)) {
> +			preempt_disable();
> +			do {
> +				cpu = cpumask_next(cpu, cpu_online_mask);
> +				if (cpu == nr_cpumask_bits)
> +					cpu = cpumask_first(cpu_online_mask);
> +			} while (cpu == smp_processor_id() && cpumask_weight(cpu_online_mask) > 1);
> +			stack.timer.expires = jiffies;
> +			add_timer_on(&stack.timer, cpu);

Sultan points out that timer_pending() returns false before the function
has actually run, while add_timer_on() adds directly to the timer base,
which means del_timer_sync() might fail to notice a pending timer, which
means UaF. This seems like a somewhat hard problem to solve. So I think
I'll just drop this patch 2/2 here until a better idea comes around.

Jason
