Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D83769D22B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjBTRiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBTRiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:38:18 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672631CACA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GeR+vP6/ElpEIDxdEuWud+rR01AIi0Ee5iNSy+YMZrA=; b=cAzUKXP8CdZj7DFmPxusj+Eqwc
        l3Lzf9obE5+1cMBINw0LcIpJPVLcSJ1SDRn9tafrX/T2Py5ds6etbj+3isjwLN3JGC/MCOI1+qhYE
        LZb02w8Zpp5KydsEk9n8XqxmNUFA7QFbGpoguL9liOgCldw+FrDk1tjgtHZCSalPGpmlNr2VcAqvi
        xXd4gfflWFmrSuXmVehT03j/JmcBNW1BDqz+WrD2aFt8ndBRrqEpe6DdoMfxK+0SHCrrHbbmYmp1O
        HIFHI0zljLi8dMw91zzmfoWo5vWJtcn0Rcni0CsEt6UvbNVQ3EUsDti1Wlr0Vm+X7eEuZ9+6IIJMa
        COZUBINA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pUA70-00BsOi-1u;
        Mon, 20 Feb 2023 17:38:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A50853002BF;
        Mon, 20 Feb 2023 18:38:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E28020F18F6D; Mon, 20 Feb 2023 18:38:00 +0100 (CET)
Date:   Mon, 20 Feb 2023 18:38:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     shrikanth hegde <sshegde@linux.vnet.ibm.com>
Cc:     mingo@redhat.com, Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, bsegall@google.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Interleave cfs bandwidth timers for
 improved single thread performance at low utilization
Message-ID: <Y/Ov+DzOtA0iHfFO@hirez.programming.kicks-ass.net>
References: <9c57c92c-3e0c-b8c5-4be9-8f4df344a347@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c57c92c-3e0c-b8c5-4be9-8f4df344a347@linux.vnet.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 08:54:09PM +0530, shrikanth hegde wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff4dbbae3b10..7b69c329e05d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5939,14 +5939,25 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
> 
>  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  {
> -	lockdep_assert_held(&cfs_b->lock);
> +	struct hrtimer *period_timer = &cfs_b->period_timer;
> +	s64 incr = ktime_to_ns(cfs_b->period) / 10;
> +	ktime_t delta;
> +	u64 orun = 1;
> 
> +	lockdep_assert_held(&cfs_b->lock);
>  	if (cfs_b->period_active)
>  		return;
> 
>  	cfs_b->period_active = 1;
> -	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> -	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
> +	delta = ktime_sub(period_timer->base->get_time(),
> +			hrtimer_get_expires(period_timer));
> +	if (unlikely(delta >= cfs_b->period)) {
> +		orun = ktime_divns(delta, incr);
> +		hrtimer_add_expires_ns(period_timer, incr * orun);
> +	}
> +
> +	hrtimer_forward_now(period_timer, cfs_b->period);
> +	hrtimer_start_expires(period_timer, HRTIMER_MODE_ABS_PINNED);
>  }

What kind of mad hackery is this? Why can't you do the sane thing and
initialize the timer at !0 in init_cfs_bandwidth(), then any of the
forwards will stay in period -- as they should.

Please, go re-read Thomas's email.

*completely* untested...

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7c46485d65d7..4d6ea76096dc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5915,6 +5915,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	cfs_b->period_timer.node.expires = get_random_u32_below(cfs_b->period);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
 	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
