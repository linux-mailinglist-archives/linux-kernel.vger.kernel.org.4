Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB3364CD26
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbiLNPgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbiLNPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:35:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A97162CB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:35:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 51DE81FDCF;
        Wed, 14 Dec 2022 15:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671032145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7pUv0ZD9S0AfJgVsaPfgue1q7h983DFZ7YFXKqbWqWk=;
        b=da8b2STZ6liRAYvUX3vud9/he8lHncPlz27t6+fjEs1Dgj6SYfauTzs+bKQk+Cm4p5y7vG
        UYQ83J09YlpXZcQpt2y5zPIbeSfFpp+KTWqHpuv0DgWPqb8WjNf92P5pm6n98Lh95OKKM0
        n8NOpTDTu6ot98k/TELSYydU7SGG8fE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671032145;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7pUv0ZD9S0AfJgVsaPfgue1q7h983DFZ7YFXKqbWqWk=;
        b=b1EisxYg7ncTSkLB1MsjuZfyHsxq/RSD4t3C0sa60hrEUNdcxFzuheqfGFnWBHDTb+vJWB
        W7BnEJlp2K+boqDQ==
Received: from ggherdovich.udp.ovpn2.nue.suse.de (unknown [10.163.44.102])
        by relay2.suse.de (Postfix) with ESMTP id A44432C141;
        Wed, 14 Dec 2022 15:35:44 +0000 (UTC)
Message-ID: <4dff11851bf3fd306ff623bbcc29fca4b2e690e1.camel@suse.cz>
Subject: Re: [PATCH] sched/core: Fix arch_scale_freq_tick() on tickless
 systems
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Yair Podemsky <ypodemsk@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        rafael.j.wysocki@intel.com, jlelli@redhat.com, mtosatti@redhat.com,
        nsaenz@kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 14 Dec 2022 16:35:42 +0100
In-Reply-To: <20221130125121.34407-1-ypodemsk@redhat.com>
References: <20221130125121.34407-1-ypodemsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-30 at 14:51 +0200, Yair Podemsky wrote:
> In order for the scheduler to be frequency invariant we measure the
> ratio between the maximum cpu frequency and the actual cpu frequency.
> During long tickless periods of time the calculations that keep track
> of that might overflow, in the function scale_freq_tick():
> 
> if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
> »       goto error;
> 
> eventually forcing the kernel to disable the feature for all cpus,
> and show the warning message
> "Scheduler frequency invariance went wobbly, disabling!".
> Let's avoid that by limiting the frequency invariant calculations
> to cpus with regular tick.
> 
> Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in frequency invariant accounting")
> Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
> Suggested-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Acked-by: Giovanni Gherdovich <ggherdovich@suse.cz>

> ---
> V1 -> V2: solution approach was changed from detecting long tickless periods
> to frequency invariant measurements on housekeeping cpus only.
> Link: ee89073a1e9de11c7bd7726eb5da71a0e8795099.camel@redhat.com
> ---
>  kernel/sched/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index daff72f00385..1bb0a840c817 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5469,7 +5469,9 @@ void scheduler_tick(void)
>  	unsigned long thermal_pressure;
>  	u64 resched_latency;
>  
> -	arch_scale_freq_tick();
> +	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
> +		arch_scale_freq_tick();
> +
>  	sched_clock_tick();
>  
>  	rq_lock(rq, &rf);

