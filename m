Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B3B624BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKJU1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKJU1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:27:09 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45291C429;
        Thu, 10 Nov 2022 12:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668112028; x=1699648028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m+ZS3rOfRmRa8UfzE++QCfs9Vzmvg4hPfC+PSx0NcaM=;
  b=AJSHeQxjBWLyJ8QssGw7kdJtThX5LMAVnpHq6co2s9Cxqkh2nzr+g+R4
   vEfNCLTB7Afbbwr1lyPz4pM+qiGrAoGTWKgpszkb1OUaRdaKiYtjNqEi8
   JGVpEBzz9IJVQtd4ONh9WNJmyHHKC9PkBCymP3ly/KSiQ4id737iFuhmX
   8pS3CFO1qoRR8rZLeuZafe8PSxo5PvUWKskKU37B9ZsI00xUoNN38wcj6
   feILyxHOvoo/7v5ydaoGMRFH+FJdaXUPgxWAAcc2UFLz412urDmPcXpRf
   OXy/Pn0n3rlA2kecuJT3e7Sxm/BI3iQWu8rptPBpCE7kir1aBWthix2lU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="309060811"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="309060811"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 12:27:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="637320121"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="637320121"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by orsmga002.jf.intel.com with SMTP; 10 Nov 2022 12:27:03 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 10 Nov 2022 22:27:02 +0200
Date:   Thu, 10 Nov 2022 22:27:02 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, rjw@rjwysocki.net, oleg@redhat.com,
        rostedt@goodmis.org, mingo@kernel.org, mgorman@suse.de,
        intel-gfx@lists.freedesktop.org, tj@kernel.org,
        Will Deacon <will@kernel.org>, dietmar.eggemann@arm.com,
        ebiederm@xmission.com
Subject: Re: [Intel-gfx] [PATCH v3 6/6] freezer, sched: Rewrite core freezer
 logic
Message-ID: <Y21elgaCwy3FNk70@intel.com>
References: <Y1LVYaPCCP3BBS4g@intel.com>
 <Y1drd2gzxUJWdz5F@intel.com>
 <Y1e/Kd+1UQqeSwzY@hirez.programming.kicks-ass.net>
 <Y1kMv1GpKwOSIt8f@intel.com>
 <Y1kdRNNfUeAU+FNl@hirez.programming.kicks-ass.net>
 <Y1qC7d7QVJB8NCHt@intel.com>
 <Y1q3gzbPUCvEMHGD@hirez.programming.kicks-ass.net>
 <Y2Khj7n+tRq3r++O@intel.com>
 <Y2LsUIfbUiy2Ar0r@hirez.programming.kicks-ass.net>
 <Y2jwSwfRC3Q5x7Rm@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2jwSwfRC3Q5x7Rm@intel.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 01:47:23PM +0200, Ville Syrjälä wrote:
> On Wed, Nov 02, 2022 at 11:16:48PM +0100, Peter Zijlstra wrote:
> > On Wed, Nov 02, 2022 at 06:57:51PM +0200, Ville Syrjälä wrote:
> > > On Thu, Oct 27, 2022 at 06:53:23PM +0200, Peter Zijlstra wrote:
> > > > On Thu, Oct 27, 2022 at 04:09:01PM +0300, Ville Syrjälä wrote:
> > > > > On Wed, Oct 26, 2022 at 01:43:00PM +0200, Peter Zijlstra wrote:
> > > > 
> > > > > > Could you please give the below a spin?
> > > > > 
> > > > > Thanks. I've added this to our CI branch. I'll try to keep and eye
> > > > > on it in the coming days and let you know if anything still trips.
> > > > > And I'll report back maybe ~middle of next week if we haven't caught
> > > > > anything by then.
> > > > 
> > > > Thanks!
> > > 
> > > Looks like we haven't caught anything since I put the patch in.
> > > So the fix seems good.
> > 
> > While writing up the Changelog, it occured to me it might be possible to
> > fix another way, could I bother you to also run the below patch for a
> > bit?
> 
> I swapped in the new patch to the CI branch. I'll check back
> after a few days.

CI hasn't had anything new to report AFAICS, so looks like this
version is good as well.

> 
> > 
> > ---
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index cb2aa2b54c7a..daff72f00385 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4200,6 +4200,40 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >  	return success;
> >  }
> >  
> > +static bool __task_needs_rq_lock(struct task_struct *p)
> > +{
> > +	unsigned int state = READ_ONCE(p->__state);
> > +
> > +	/*
> > +	 * Since pi->lock blocks try_to_wake_up(), we don't need rq->lock when
> > +	 * the task is blocked. Make sure to check @state since ttwu() can drop
> > +	 * locks at the end, see ttwu_queue_wakelist().
> > +	 */
> > +	if (state == TASK_RUNNING || state == TASK_WAKING)
> > +		return true;
> > +
> > +	/*
> > +	 * Ensure we load p->on_rq after p->__state, otherwise it would be
> > +	 * possible to, falsely, observe p->on_rq == 0.
> > +	 *
> > +	 * See try_to_wake_up() for a longer comment.
> > +	 */
> > +	smp_rmb();
> > +	if (p->on_rq)
> > +		return true;
> > +
> > +#ifdef CONFIG_SMP
> > +	/*
> > +	 * Ensure the task has finished __schedule() and will not be referenced
> > +	 * anymore. Again, see try_to_wake_up() for a longer comment.
> > +	 */
> > +	smp_rmb();
> > +	smp_cond_load_acquire(&p->on_cpu, !VAL);
> > +#endif
> > +
> > +	return false;
> > +}
> > +
> >  /**
> >   * task_call_func - Invoke a function on task in fixed state
> >   * @p: Process for which the function is to be invoked, can be @current.
> > @@ -4217,28 +4251,12 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >  int task_call_func(struct task_struct *p, task_call_f func, void *arg)
> >  {
> >  	struct rq *rq = NULL;
> > -	unsigned int state;
> >  	struct rq_flags rf;
> >  	int ret;
> >  
> >  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
> >  
> > -	state = READ_ONCE(p->__state);
> > -
> > -	/*
> > -	 * Ensure we load p->on_rq after p->__state, otherwise it would be
> > -	 * possible to, falsely, observe p->on_rq == 0.
> > -	 *
> > -	 * See try_to_wake_up() for a longer comment.
> > -	 */
> > -	smp_rmb();
> > -
> > -	/*
> > -	 * Since pi->lock blocks try_to_wake_up(), we don't need rq->lock when
> > -	 * the task is blocked. Make sure to check @state since ttwu() can drop
> > -	 * locks at the end, see ttwu_queue_wakelist().
> > -	 */
> > -	if (state == TASK_RUNNING || state == TASK_WAKING || p->on_rq)
> > +	if (__task_needs_rq_lock(p))
> >  		rq = __task_rq_lock(p, &rf);
> >  
> >  	/*
> 
> -- 
> Ville Syrjälä
> Intel

-- 
Ville Syrjälä
Intel
