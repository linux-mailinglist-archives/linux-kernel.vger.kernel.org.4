Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FBF675C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjATSAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjATSAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:00:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01515A3174
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:59:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCF9D62021
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 17:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7DAC433D2;
        Fri, 20 Jan 2023 17:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674237579;
        bh=Ld76O77ny84RJKHmvpGdXQieva9SHOnFTQQyuHXcetY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NdAy50Ca41uXNoIERjaUG9TwJU2b99AXDBEtYuZntiefo8oIAIsfHyCtISNIwTCKt
         C0fKKnlAik+qGUt+SImlc2yphco+HUeakC9pV3KqDv6gnqgvmusv4fte9vDIZz+3mb
         gW4NAkGAs9cBb61YbfpfgjOYpR8ojNQ57MlkT4hYJxJQGkmIKIRIKxyih13LJE4FDr
         jf4yolMvPdfC4SueNVg7+UReGlLwJiTnIOyayUPuFaKAJrQUo7x3wbhaCmXidxLnHo
         cRegurnaBZtKPD6rn+Xtt4B5JFUt1unZ4pPRefNbVi3TubQJF9/1uGtLbPgdfVfVaW
         ntJ9bnHMfRirA==
Date:   Fri, 20 Jan 2023 17:59:32 +0000
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
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, qperret@google.com
Subject: Re: [PATCH v10 2/5] sched: Use user_cpus_ptr for saving user
 provided cpumask in sched_setaffinity()
Message-ID: <20230120175931.GA22417@willie-the-truck>
References: <20220922180041.1768141-1-longman@redhat.com>
 <20220922180041.1768141-3-longman@redhat.com>
 <20230117160825.GA17756@willie-the-truck>
 <2bb8c031-03a9-ef93-1505-6e7fbcc6d847@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bb8c031-03a9-ef93-1505-6e7fbcc6d847@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Waiman,

Cheers for the quick reply.

On Tue, Jan 17, 2023 at 01:13:31PM -0500, Waiman Long wrote:
> On 1/17/23 11:08, Will Deacon wrote:
> > On Thu, Sep 22, 2022 at 02:00:38PM -0400, Waiman Long wrote:
> > > The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
> > > Introduce task_struct::user_cpus_ptr to track requested affinity"). It
> > > is currently used only by arm64 arch due to possible asymmetric CPU
> > > setup. This patch extends its usage to save user provided cpumask
> > > when sched_setaffinity() is called for all arches. With this patch
> > > applied, user_cpus_ptr, once allocated after a successful call to
> > > sched_setaffinity(), will only be freed when the task exits.

[...]

> > We've tracked this down as the cause of an arm64 regression in Android and I've
> > reproduced the issue with mainline.
> > 
> > Basically, if an arm64 system is booted with "allow_mismatched_32bit_el0" on
> > the command-line, then the arch code will (amongst other things) call
> > force_compatible_cpus_allowed_ptr() and relax_compatible_cpus_allowed_ptr()
> > when exec()'ing a 32-bit or a 64-bit task respectively.
> 
> IOW, relax_compatible_cpus_allowed_ptr() can be called without a previous
> force_compatible_cpus_allowed_ptr(). Right?

In practice, these functions are only called by arm64 during exec. As above,
exec()'ing a 32-bit task calls force_compatible_cpus_allowed_ptr() and
exec()'ing a 64-bit task calls relax_compatible_cpus_allowed_ptr(). So
they don't come in pairs at all; it's just that calling relax_[...] should
try to restore the affinity mask if it was previously clobbered by
force_[...].

> A possible optimization in this case is to add a bit flag in the task_struct
> to indicate a previous call to force_compatible_cpus_allowed_ptr(). Without
> that flag set, relax_compatible_cpus_allowed_ptr() can return immediately.

How is this an optimisation over a pointer comparison?

> > I've had a crack at fixing the code above to restore the old behaviour, and it
> > seems to work for my basic tests (still pending confirmation from others):
> > 
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index bb1ee6d7bdde..0d4a11384648 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3125,17 +3125,16 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);
> >   void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
> >   {
> >          struct affinity_context ac = {
> > -               .new_mask  = task_user_cpus(p),
> > +               .new_mask  = p->user_cpus_ptr,
> >                  .flags     = 0,
> >          };
> > -       int ret;
> >          /*
> >           * Try to restore the old affinity mask with __sched_setaffinity().
> >           * Cpuset masking will be done there too.
> >           */
> > -       ret = __sched_setaffinity(p, &ac);
> > -       WARN_ON_ONCE(ret);
> > +       if (ac.new_mask)
> > +               WARN_ON_ONCE(__sched_setaffinity(p, &ac));
> >   }
> >   void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
> > 
> > 
> > With this change, task_user_cpus() is only used by restrict_cpus_allowed_ptr()
> > so I'd be inclined to remove it altogether tbh.
> > 
> > What do you think?
> 
> The problem here is that force_compatible_cpus_allowed_ptr() can be called
> without a matching relax_compatible_cpus_allowed_ptr() at the end. So we may
> end up artificially restrict the number of cpus that can be used when
> running a 64-bit binary.

Hmm, is this because an intervening call to sched_setaffinity() could've
set ->user_cpus_ptr? If so, I'd have thought that would also point to a
superset of the effective affinity -- is that not the case?

> What do you think about the idea of having a bit flag to track that?

I'm not hugely happy with that approach because it's adding additional state
which is only needed for arm64, and only when operating in this funny
asymmetric mode. I also don't understand how it would interact with the new
sched_setaffinity() behaviour; would we need to clear the flag when that
function updates the mask?

Since I'm basically trying to re-instate the v6.1 behaviour to fix the arm64
regression, I'm happy to review/test any proposal you have, but as we get
closer to the 6.2 release I'm wondering whether it would make more sense to
revert the sched_setaffinity() changes for now and I can help you with arm64
review and testing if we bring the changes back for e.g. 6.4.

Will
