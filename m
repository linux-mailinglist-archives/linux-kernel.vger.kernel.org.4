Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45D16865A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjBAMCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBAMCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:02:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874E327D72
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:02:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2148361776
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB852C433D2;
        Wed,  1 Feb 2023 12:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675252964;
        bh=41Xyg3jeP8WJJmfHvsoU4JXbVCVGlTLKPezm4OBpJK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6MtAi9X147T7iYnUcH9rmp5gsgYxpihzHT+65ttexPl2R3YLw8AKfGRk5NUyB+Dp
         9oaSGdwtrvhJ9CVgjhB2RZbZMZyOHsOwr1DPBapqmQ/e68Efv+swiJrHBoPFQYhcjY
         d+dC/JagWSz0hqMpdCW06GAe/5s1fjdeDUy46XiNabZne3duroJRdeS66f7bL7bYOn
         UyiAhiJGCPhASPE3BHIm00hz/05cLBi2oZcertJ2g7hOxiV9+HUZzhtpBoH+RMS3Z0
         Qj6r4PUVGusg+Z0drEiaxh45M1bHsNksGh7xh6zcbryZGXsQfhU3ZLjTZw4hG9XQUD
         ZnAw1Ng4jCX6g==
Date:   Wed, 1 Feb 2023 13:02:41 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>, fweisbec@gmail.com,
        mingo@kernel.org, liwei391@huawei.com, adobriyan@gmail.com,
        mirsad.todorovac@alu.unizg.hr, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC] tick/nohz: fix data races in get_cpu_idle_time_us()
Message-ID: <Y9pU4cunJd3aI9+S@lothringen>
References: <20230128020051.2328465-1-liaoyu15@huawei.com>
 <20230201045302.316-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201045302.316-1-hdanton@sina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 12:53:02PM +0800, Hillf Danton wrote:
> On Tue, 31 Jan 2023 15:44:00 +0100 Thomas Gleixner <tglx@linutronix.de>
> > 
> > Seriously this procfs accuracy is the least of the problems and if this
> > would be the only issue then we could trivially fix it by declaring that
> > the procfs output might go backwards. It's an estimate after all. If
> > there would be a real reason to ensure monotonicity there then we could
> > easily do that in the readout code.
> > 
> > But the real issue is that both get_cpu_idle_time_us() and
> > get_cpu_iowait_time_us() can invoke update_ts_time_stats() which is way
> > worse than the above procfs idle time going backwards.
> > 
> > If update_ts_time_stats() is invoked concurrently for the same CPU then
> > ts->idle_sleeptime and ts->iowait_sleeptime are turning into random
> > numbers.
> > 
> > This has been broken 12 years ago in commit 595aac488b54 ("sched:
> > Introduce a function to update the idle statistics").
> 
> [...]
> 
> > 
> > P.S.: I hate the spinlock in the idle code path, but I don't have a
> >       better idea.
> 
> Provided the percpu rule is enforced, the random numbers mentioned above
> could be erased without another spinlock added.
> 
> Hillf
> +++ b/kernel/time/tick-sched.c
> @@ -640,13 +640,26 @@ static void tick_nohz_update_jiffies(kti
>  /*
>   * Updates the per-CPU time idle statistics counters
>   */
> -static void
> -update_ts_time_stats(int cpu, struct tick_sched *ts, ktime_t now, u64 *last_update_time)
> +static u64 update_ts_time_stats(int cpu, struct tick_sched *ts, ktime_t now,
> +				int io, u64 *last_update_time)
>  {
>  	ktime_t delta;
>  
> +	if (last_update_time)
> +		*last_update_time = ktime_to_us(now);
> +
>  	if (ts->idle_active) {
>  		delta = ktime_sub(now, ts->idle_entrytime);
> +
> +		/* update is only expected on the local CPU */
> +		if (cpu != smp_processor_id()) {

Why not just updating it only on idle exit then?

> +			if (io)

I fear it's not up to the caller to decides if the idle time is IO or not.

> +				delta = ktime_add(ts->iowait_sleeptime, delta);
> +			else
> +				delta = ktime_add(ts->idle_sleeptime, delta);
> +			return ktime_to_us(delta);
> +		}
> +
>  		if (nr_iowait_cpu(cpu) > 0)
>  			ts->iowait_sleeptime = ktime_add(ts->iowait_sleeptime, delta);
>  		else

But you kept the old update above.

So if this is not the local CPU, what do you do?

You'd need to return (without updating iowait_sleeptime):

      ts->idle_sleeptime + ktime_sub(ktime_get(), ts->idle_entrytime)

Right? But then you may race with the local updater, risking to return
the delta added twice. So you need at least a seqcount.

But in the end, nr_iowait_cpu() is broken because that counter can be
decremented remotely and so the whole thing is beyond repair:

CPU 0                       CPU  1                    CPU 2
-----                       -----                     ------
//io_schedule() TASK A
current->in_iowait = 1
rq(0)->nr_iowait++
//switch to idle
                    // READ /proc/stat
                    // See nr_iowait_cpu(0) == 1
                    return ts->iowait_sleeptime + ktime_sub(ktime_get(), ts->idle_entrytime)

                                                      //try_to_wake_up(TASK A)
                                                      rq(0)->nr_iowait--
//idle exit
// See nr_iowait_cpu(0) == 0
ts->idle_sleeptime += ktime_sub(ktime_get(), ts->idle_entrytime)


Thanks.
