Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A0863A7C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiK1MCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiK1MAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:00:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD8C18B27
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDF8AB80D88
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A11C4315C;
        Mon, 28 Nov 2022 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669636816;
        bh=s8HTQY8UHN5dZej09qiZkVk+0Pf068ApxSd4spgbW8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAoJRYGiK+WR4soWiM4j+Tjgu3098aU+PNHTqh+UuFslYHjkymkBUlCd0Rck6uTu7
         kh/1Vt9xJMvoJ0XygbUBxXDLo60kzRTfB29c+ALWBe1d05Hb276Hsi6zesun6jm/KO
         rV/ldVtrp8FoqRGP0IGUguF6mTj8kGfvgXWlQegSjUa/VdA00TzQ5Ugss2/9hddAba
         RtXUcU3yewbt5Z0ADdwJrg6vA87yra/jHBuOULXzxxnf2p6YE5MnUmSRt1ajM6RlId
         Np7x2qp2jthQ0aB0iUfrn3h9PdYBVlmF9urfrIwmcgVY7V83JJ5k/aECGpL9y63QO9
         Q3+7nQyrgnOVw==
Date:   Mon, 28 Nov 2022 12:00:10 +0000
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
        Phil Auld <pauld@redhat.com>,
        Wenjie Li <wenjieli@qti.qualcomm.com>,
        David Wang =?utf-8?B?546L5qCH?= <wangbiao3@xiaomi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH-tip v4] sched: Fix NULL user_cpus_ptr check in
 dup_user_cpus_ptr()
Message-ID: <20221128120008.GA25090@willie-the-truck>
References: <20221125023943.1118603-1-longman@redhat.com>
 <92b99a5e-1588-4e08-a652-72e9c51421cf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92b99a5e-1588-4e08-a652-72e9c51421cf@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 08:43:27PM -0500, Waiman Long wrote:
> On 11/24/22 21:39, Waiman Long wrote:
> > In general, a non-null user_cpus_ptr will remain set until the task dies.
> > A possible exception to this is the fact that do_set_cpus_allowed()
> > will clear a non-null user_cpus_ptr. To allow this possible racing
> > condition, we need to check for NULL user_cpus_ptr under the pi_lock
> > before duping the user mask.
> > 
> > Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
> > Signed-off-by: Waiman Long <longman@redhat.com>
> 
> This is actually a pre-existing use-after-free bug since commit 07ec77a1d4e8
> ("sched: Allow task CPU affinity to be restricted on asymmetric systems").
> So it needs to be fixed in the stable release as well. Will resend the patch
> with an additional fixes tag and updated commit log.

Please can you elaborate on the use-after-free here? Looking at
07ec77a1d4e8, the mask is only freed in free_task() when the usage refcount
has dropped to zero and I can't see how that can race with fork().

What am I missing?

Will

> >   kernel/sched/core.c | 32 ++++++++++++++++++++++++++++----
> >   1 file changed, 28 insertions(+), 4 deletions(-)
> > 
> >   [v4] Minor comment update
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 8df51b08bb38..f2b75faaf71a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2624,19 +2624,43 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
> >   int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
> >   		      int node)
> >   {
> > +	cpumask_t *user_mask;
> >   	unsigned long flags;
> > +	/*
> > +	 * Always clear dst->user_cpus_ptr first as their user_cpus_ptr's
> > +	 * may differ by now due to racing.
> > +	 */
> > +	dst->user_cpus_ptr = NULL;
> > +
> > +	/*
> > +	 * This check is racy and losing the race is a valid situation.
> > +	 * It is not worth the extra overhead of taking the pi_lock on
> > +	 * every fork/clone.
> > +	 */
> >   	if (!src->user_cpus_ptr)
> >   		return 0;
> > -	dst->user_cpus_ptr = kmalloc_node(cpumask_size(), GFP_KERNEL, node);
> > -	if (!dst->user_cpus_ptr)
> > +	user_mask = kmalloc_node(cpumask_size(), GFP_KERNEL, node);
> > +	if (!user_mask)
> >   		return -ENOMEM;
> > -	/* Use pi_lock to protect content of user_cpus_ptr */
> > +	/*
> > +	 * Use pi_lock to protect content of user_cpus_ptr
> > +	 *
> > +	 * Though unlikely, user_cpus_ptr can be reset to NULL by a concurrent
> > +	 * do_set_cpus_allowed().
> > +	 */
> >   	raw_spin_lock_irqsave(&src->pi_lock, flags);
> > -	cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
> > +	if (src->user_cpus_ptr) {
> > +		swap(dst->user_cpus_ptr, user_mask);
> > +		cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
> > +	}
> >   	raw_spin_unlock_irqrestore(&src->pi_lock, flags);
> > +
> > +	if (unlikely(user_mask))
> > +		kfree(user_mask);
> > +
> >   	return 0;
> >   }
> 
