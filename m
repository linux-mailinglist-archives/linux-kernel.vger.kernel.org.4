Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2531667D0AF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjAZPzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjAZPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:55:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50762BF39
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:55:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0907F618B0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84EDC433EF;
        Thu, 26 Jan 2023 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674748531;
        bh=JsaqBugdvm0bKSn7JKiVG39TV2mp7Z1zU4P2n5J37Y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XiZqiEicyPY8ZmKU5MdtBbnox3cw+bw0efxeN2ntwi3YjyqlJqRxq79RYKjxQ1YWL
         swIKChF3Q7GCzUlWFuz2xdpdnvN1/Cb96xo3spb/u9ekIbWg0KcZyka6us+tEqWrxb
         GtCR6dm6dC+k3CStz0TGxhQ26KXITzOZONhSTX1FtLnX7X0SsIQMLiTRQ7z6gk1MJg
         9ohtSjlym9jH1vkZ+5iBw1h+DDZnywOu6FFYltb4583I2Q/D1k3W1wm+H1iTbBxL16
         7PYW6OqH7Sqk0XWnqJMxEvrrKIYcM8qxm0jvKKIH6l4lTsWxuUQoJmiOD7y+GCtss3
         asczqX8cFsSXQ==
Date:   Thu, 26 Jan 2023 15:55:24 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        regressions@leemhuis.info
Subject: Re: [PATCH v2] sched: Store restrict_cpus_allowed_ptr() call state
Message-ID: <20230126155524.GA29438@willie-the-truck>
References: <20230121021749.55313-1-longman@redhat.com>
 <20230124194805.GA27257@willie-the-truck>
 <70cf3890-efb1-cf35-2f94-f2b09092231f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70cf3890-efb1-cf35-2f94-f2b09092231f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 03:08:09PM -0500, Waiman Long wrote:
> On 1/24/23 14:48, Will Deacon wrote:
> > On Fri, Jan 20, 2023 at 09:17:49PM -0500, Waiman Long wrote:
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 853d08f7562b..f93f62a1f858 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -886,6 +886,9 @@ struct task_struct {
> > >   	unsigned			sched_contributes_to_load:1;
> > >   	unsigned			sched_migrated:1;
> > > +	/* restrict_cpus_allowed_ptr() bit, serialized by scheduler locks */
> > > +	unsigned			cpus_allowed_restricted:1;
> > > +
> > >   	/* Force alignment to the next boundary: */
> > >   	unsigned			:0;
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index bb1ee6d7bdde..48234dc9005b 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -2999,15 +2999,40 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> > >   	struct rq *rq;
> > >   	rq = task_rq_lock(p, &rf);
> > > +
> > > +	if (ctx->flags & (SCA_CLR_RESTRICT | SCA_SET_RESTRICT)) {
> > > +		p->cpus_allowed_restricted = 0;
> > I don't think this is ever called on the SCA_SET_RESTRICT path, as
> > restrict_cpus_allowed_ptr() calls __set_cpus_allowed_ptr_locked() directly.
> > In my testing, we see a failure in the following sequence:
> > 
> >    1. A 64-bit task has an affinity of 0xf
> >    2. It exec()s a 32-bit program and is forcefully restricted to the set
> >       of 32-bit-capable cores. Let's say that new mask is 0xc
> >    3. The 32-bit task now exec()s a 64-bit program again
> > 
> > And now we're still stuck with 0xc after step 3 whereas we should restore
> > 0xf.
> I am sorry that missed it. You are right. For setting the
> cpus_allowed_restricted bit, it should be done directly in
> restrict_cpus_allowed_ptr().
> > > +	} else if (p->cpus_allowed_restricted) {
> > > +		/*
> > > +		 * If force_compatible_cpus_allowed_ptr() has been called,
> > > +		 * we can't extend cpumask to beyond what is in cpus_mask.
> > > +		 */
> > > +		if (!cpumask_and(rq->scratch_mask, ctx->new_mask,
> > > +				 &p->cpus_mask)) {
> > > +			task_rq_unlock(rq, p, &rf);
> > > +			return -EINVAL;
> > > +		}
> > Why is this masking actually needed? __sched_setaffinity() already
> > takes into account the task_cpu_possible_mask(), which is why I asked you
> > before [1] about cases where the saved affinity is not simply a superset
> > of the effective affinity.
> 
> I kind of overlook the use of task_cpu_possible_mask() in
> __set_cpus_allowed_ptr_locked. So we don't really need that masking. That
> make the patch even simpler then. I will send out a v3.

Thanks; I'll give it a spin when I see it.

Will
