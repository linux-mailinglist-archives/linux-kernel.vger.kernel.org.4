Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F3561F227
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiKGLrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiKGLre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:47:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27501AD99;
        Mon,  7 Nov 2022 03:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667821650; x=1699357650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DNck0O7tKxZz4E60oTrC+FSvqpcG6re8AP26uzazs0k=;
  b=DbpziIA/KY/zim6KON8tGj+s86Iydj8uO0uXyhphCfEuauRbenxHYWSU
   lujHnGCJbbNDHIitDG2TimuvQqUatfPzn/tILJqz0ljijf94sK7CpB33k
   nUIIU0YHUrIbD3S2IVbN9E48i8wi2tKelc49kdEmQ98DqQFaqCCiAG5+e
   /sagzp0kWI+rNmBusDgVv7YJ5mlVmC9lM2buNCEpzdS0X3bzDjZ3bk4Ym
   j62+q/LY7jITsvv2FHNr2DMkyC4aUJGaK0Rjr6i0ZB876IMFEH1JU5hfA
   ZenaReyxeYSahInFt7MCUojxF0qh34Q+9IJhFlZl5zPhLp9ALIoSwLK0a
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="297882492"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="297882492"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:47:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="778463730"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="778463730"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by fmsmga001.fm.intel.com with SMTP; 07 Nov 2022 03:47:24 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 07 Nov 2022 13:47:23 +0200
Date:   Mon, 7 Nov 2022 13:47:23 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <Y2jwSwfRC3Q5x7Rm@intel.com>
References: <20220822114649.055452969@infradead.org>
 <Y1LVYaPCCP3BBS4g@intel.com>
 <Y1drd2gzxUJWdz5F@intel.com>
 <Y1e/Kd+1UQqeSwzY@hirez.programming.kicks-ass.net>
 <Y1kMv1GpKwOSIt8f@intel.com>
 <Y1kdRNNfUeAU+FNl@hirez.programming.kicks-ass.net>
 <Y1qC7d7QVJB8NCHt@intel.com>
 <Y1q3gzbPUCvEMHGD@hirez.programming.kicks-ass.net>
 <Y2Khj7n+tRq3r++O@intel.com>
 <Y2LsUIfbUiy2Ar0r@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2LsUIfbUiy2Ar0r@hirez.programming.kicks-ass.net>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 11:16:48PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 02, 2022 at 06:57:51PM +0200, Ville Syrjälä wrote:
> > On Thu, Oct 27, 2022 at 06:53:23PM +0200, Peter Zijlstra wrote:
> > > On Thu, Oct 27, 2022 at 04:09:01PM +0300, Ville Syrjälä wrote:
> > > > On Wed, Oct 26, 2022 at 01:43:00PM +0200, Peter Zijlstra wrote:
> > > 
> > > > > Could you please give the below a spin?
> > > > 
> > > > Thanks. I've added this to our CI branch. I'll try to keep and eye
> > > > on it in the coming days and let you know if anything still trips.
> > > > And I'll report back maybe ~middle of next week if we haven't caught
> > > > anything by then.
> > > 
> > > Thanks!
> > 
> > Looks like we haven't caught anything since I put the patch in.
> > So the fix seems good.
> 
> While writing up the Changelog, it occured to me it might be possible to
> fix another way, could I bother you to also run the below patch for a
> bit?

I swapped in the new patch to the CI branch. I'll check back
after a few days.

> 
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index cb2aa2b54c7a..daff72f00385 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4200,6 +4200,40 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	return success;
>  }
>  
> +static bool __task_needs_rq_lock(struct task_struct *p)
> +{
> +	unsigned int state = READ_ONCE(p->__state);
> +
> +	/*
> +	 * Since pi->lock blocks try_to_wake_up(), we don't need rq->lock when
> +	 * the task is blocked. Make sure to check @state since ttwu() can drop
> +	 * locks at the end, see ttwu_queue_wakelist().
> +	 */
> +	if (state == TASK_RUNNING || state == TASK_WAKING)
> +		return true;
> +
> +	/*
> +	 * Ensure we load p->on_rq after p->__state, otherwise it would be
> +	 * possible to, falsely, observe p->on_rq == 0.
> +	 *
> +	 * See try_to_wake_up() for a longer comment.
> +	 */
> +	smp_rmb();
> +	if (p->on_rq)
> +		return true;
> +
> +#ifdef CONFIG_SMP
> +	/*
> +	 * Ensure the task has finished __schedule() and will not be referenced
> +	 * anymore. Again, see try_to_wake_up() for a longer comment.
> +	 */
> +	smp_rmb();
> +	smp_cond_load_acquire(&p->on_cpu, !VAL);
> +#endif
> +
> +	return false;
> +}
> +
>  /**
>   * task_call_func - Invoke a function on task in fixed state
>   * @p: Process for which the function is to be invoked, can be @current.
> @@ -4217,28 +4251,12 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  int task_call_func(struct task_struct *p, task_call_f func, void *arg)
>  {
>  	struct rq *rq = NULL;
> -	unsigned int state;
>  	struct rq_flags rf;
>  	int ret;
>  
>  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>  
> -	state = READ_ONCE(p->__state);
> -
> -	/*
> -	 * Ensure we load p->on_rq after p->__state, otherwise it would be
> -	 * possible to, falsely, observe p->on_rq == 0.
> -	 *
> -	 * See try_to_wake_up() for a longer comment.
> -	 */
> -	smp_rmb();
> -
> -	/*
> -	 * Since pi->lock blocks try_to_wake_up(), we don't need rq->lock when
> -	 * the task is blocked. Make sure to check @state since ttwu() can drop
> -	 * locks at the end, see ttwu_queue_wakelist().
> -	 */
> -	if (state == TASK_RUNNING || state == TASK_WAKING || p->on_rq)
> +	if (__task_needs_rq_lock(p))
>  		rq = __task_rq_lock(p, &rf);
>  
>  	/*

-- 
Ville Syrjälä
Intel
