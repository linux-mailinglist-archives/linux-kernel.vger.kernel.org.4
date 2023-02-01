Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C97686846
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjBAO2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjBAO2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:28:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D8E1BDE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:28:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 471FDB8219F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70612C433EF;
        Wed,  1 Feb 2023 14:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675261730;
        bh=YroCa+avc6rV4GCcybGDD1acE12dRIov4jxYSHm88V0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U2Mhgl1rdL0Jzvs+9wFXh9wA8eb3DoUn7zkp+T8azFnhYLtvd55sb/56x04zVF3dJ
         mn1dnaqbmTUDfBEIpyLNjj6Hyt3LbBDlqx3kA4OYulUVweI4dVf3d7oIlIcD2aJTaa
         yDhVbnRNtPMeT0g8E2HyDdzqo5MrRgSQN46Gr6J8MifY1Y1OsXP3B+4OeFqDU8tifT
         YE7/QVAs8XkofazahY3PO7ARW/DQYQMvzPcDdx1I+VhBCj84rYqIZRkcgBKRGKFUdP
         LQzQFjsOnvzsBte9XsYTTAY4An0TCwZLCFAkgEsM6Ijc3sgpoRuw82bo3gCSEbT5ea
         f6PRvKA/TJL9w==
Date:   Wed, 1 Feb 2023 15:28:46 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>, fweisbec@gmail.com,
        mingo@kernel.org, liwei391@huawei.com, adobriyan@gmail.com,
        mirsad.todorovac@alu.unizg.hr, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC] tick/nohz: fix data races in get_cpu_idle_time_us()
Message-ID: <Y9p3HjW3yzn0UYrZ@lothringen>
References: <20230128020051.2328465-1-liaoyu15@huawei.com>
 <20230201045302.316-1-hdanton@sina.com>
 <20230201140117.539-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201140117.539-1-hdanton@sina.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 10:01:17PM +0800, Hillf Danton wrote:
> > > +++ b/kernel/time/tick-sched.c
> > > @@ -640,13 +640,26 @@ static void tick_nohz_update_jiffies(kti
> > >  /*
> > >   * Updates the per-CPU time idle statistics counters
> > >   */
> > > -static void
> > > -update_ts_time_stats(int cpu, struct tick_sched *ts, ktime_t now, u64 *last_update_time)
> > > +static u64 update_ts_time_stats(int cpu, struct tick_sched *ts, ktime_t now,
> > > +				int io, u64 *last_update_time)
> > >  {
> > >  	ktime_t delta;
> > >  
> > > +	if (last_update_time)
> > > +		*last_update_time = ktime_to_us(now);
> > > +
> > >  	if (ts->idle_active) {
> > >  		delta = ktime_sub(now, ts->idle_entrytime);
> > > +
> > > +		/* update is only expected on the local CPU */
> > > +		if (cpu != smp_processor_id()) {
> > 
> > Why not just updating it only on idle exit then?
> 
> This aligns to idle exit as much as it can by disallowing remote update.

I mean why bother updating if idle does it for us already?

One possibility is that we get some more precise values if we read during
long idle periods with nr_iowait_cpu() changes in the middle.

> > 
> > > +			if (io)
> > 
> > I fear it's not up to the caller to decides if the idle time is IO or not.
> 
> Could you specify a bit on your concern, given the callers of this function?

You are randomly stating if the elapsing idle time is IO or not depending on
the caller, without verifying nr_iowait_cpu(). Or am I missing something?

> > 
> > > +				delta = ktime_add(ts->iowait_sleeptime, delta);
> > > +			else
> > > +				delta = ktime_add(ts->idle_sleeptime, delta);
> > > +			return ktime_to_us(delta);
> 
> Based on the above comments, I guest you missed this line which prevents
> get_cpu_idle_time_us() and get_cpu_iowait_time_us() from updating ts.

Right...

> > But then you may race with the local updater, risking to return
> > the delta added twice. So you need at least a seqcount.
> 
> Add seqcount if needed. No problem.
> > 
> > But in the end, nr_iowait_cpu() is broken because that counter can be
> > decremented remotely and so the whole thing is beyond repair:
> > 
> > CPU 0                       CPU  1                    CPU 2
> > -----                       -----                     ------
> > //io_schedule() TASK A
> > current->in_iowait = 1
> > rq(0)->nr_iowait++
> > //switch to idle
> >                     // READ /proc/stat
> >                     // See nr_iowait_cpu(0) == 1
> >                     return ts->iowait_sleeptime + ktime_sub(ktime_get(), ts->idle_entrytime)
> > 
> >                                                       //try_to_wake_up(TASK A)
> >                                                       rq(0)->nr_iowait--
> > //idle exit
> > // See nr_iowait_cpu(0) == 0
> > ts->idle_sleeptime += ktime_sub(ktime_get(), ts->idle_entrytime)
> 
> Ah see your point.
> 
> The diff disallows remotely updating ts, and it is updated in idle exit
> after my proposal, so what nr_iowait_cpu() breaks is mitigated.

Only halfway mitigated. This doesn't prevent from backward or forward jumps
when non-updating readers are involved at all.

Thanks.

> 
> Thanks for taking a look, particularly the race linked to nr_iowait_cpu().
> 
> Hillf
