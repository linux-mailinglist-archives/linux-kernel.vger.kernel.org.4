Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E28A7394CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjFVBni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjFVBng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:43:36 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151651BD2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 18:43:34 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7651c01c753so35183085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 18:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398213; x=1689990213;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2W2wzbnc22E34EbORZKGvPQS49vmw0/Uolc37EYxlD0=;
        b=lEzKKvDWoU3LCr96wkAXanOwLNUGaULmnjOHcgnfNCeKORSkWQ9hbXJ5vdcPoZM8tx
         cbJdFieE8madk9+aiY1zvxEooArlCWCKhkHrIRCF4lo3RjehyleLAPSp74E/0bWIqpvk
         jzEGlj6FrMMy0JN23JdOUXhH2QmGau4UMq+k3U1gEAZ3eUOvF2Ijjz3//GCrDvxSGvNp
         KIpI05zBRWtrPyKQscz4/ejSq4pS5sMlcEA6Zoko/yr/EbwOpFFAK9b1vCDk5460nj5L
         AmPofBrd/44xqdTpmLzVLihmuW7KZaWWdeLrc/QfndWkjElPY7LmgxuzyGdMZUDW/Xoq
         Xt8w==
X-Gm-Message-State: AC+VfDwyufgiYEAIZ87TgkhjwJAbApqeF/fHHihopW/C88JMNEeb1cC4
        TUidUW6I5MP0R3mDQ8BgWA8=
X-Google-Smtp-Source: ACHHUZ6pizdQWxwOWhMlBdEH8nLmggfiRfY75uE94TPXk+uhJ0xgKsJ0EBtpdSbMhjAt5lMn3GSsQQ==
X-Received: by 2002:a05:620a:4456:b0:75b:23a1:833f with SMTP id w22-20020a05620a445600b0075b23a1833fmr24178412qkp.58.1687398213013;
        Wed, 21 Jun 2023 18:43:33 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:d965])
        by smtp.gmail.com with ESMTPSA id u4-20020ae9c004000000b007620864d547sm2837137qkk.120.2023.06.21.18.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 18:43:32 -0700 (PDT)
Date:   Wed, 21 Jun 2023 20:43:29 -0500
From:   David Vernet <void@manifault.com>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230622014329.GD15990@maniforge>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <ZI/x+RkSqpct4bM3@BLR-5CG11610CF.amd.com>
 <20230620200822.GC3027191@maniforge>
 <ZJKx/LQwc3bWS5nh@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJKx/LQwc3bWS5nh@BLR-5CG11610CF.amd.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 01:47:00PM +0530, Gautham R. Shenoy wrote:
> Hello David,
> On Tue, Jun 20, 2023 at 03:08:22PM -0500, David Vernet wrote:
> > On Mon, Jun 19, 2023 at 11:43:13AM +0530, Gautham R. Shenoy wrote:
> > > Hello David,
> > > 
> > > 
> > > On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
> > > [..snip..]
> > > 
> > > > +static void swqueue_enqueue(struct rq *rq, struct task_struct *p, int enq_flags)
> > > > +{
> > > > +	unsigned long flags;
> > > > +	struct swqueue *swqueue;
> > > > +	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> > > > +	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
> > > > +
> > > > +	/*
> > > > +	 * Only enqueue the task in the shared wakequeue if:
> > > > +	 *
> > > > +	 * - SWQUEUE is enabled
> > > > +	 * - The task is on the wakeup path
> > > > +	 * - The task wasn't purposefully migrated to the current rq by
> > > > +	 *   select_task_rq()
> > > > +	 * - The task isn't pinned to a specific CPU
> > > > +	 */
> > > > +	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> > > > +		return;
> > > 
> > > In select_task_rq_fair(), having determined if the target of task
> > > wakeup should be the task's previous CPU vs the waker's current CPU,
> > > we spend quite a bit of time already to determine if there is an idle
> > > core/CPU in the target's LLC. @rq would correspond to CPU chosen as a
> > > result of that scan or if no idle CPU exists, @rq corresponds to the
> > > target CPU determined by wake_affine_idle()/wake_affine_weight().
> > > 
> > > So if the CPU of @rq is idle here, can we not simply return here?
> > 
> > Hi Gautum,
> > 
> > Sorry, I'm not sure I'm quite following the issue you're pointing out.
> > We don't use swqueue if the task was migrated following
> > select_task_rq_fair(). That's the idea with us returning if the task was
> > migrated (the second conditional in that if). If I messed up that logic
> > somehow, it should be fixed.
> 
> Sorry, my bad. I see it now.
> 
> So as per this patch, the only time we enqueue the task on the shared
> wakeup is if the target of try_to_wake_up() is the same CPU where the
> task ran previously.
> 
> When wake_affine logic fails and the previous CPU is chosen as the
> target, and when there are no other idle cores/threads in the LLC of
> the previous CPU, it makes sense to queue the task on the
> shared-wakequeue instead of on a busy previous CPU.
> 
> And when that previous CPU is idle, the try_to_wake_up() would have
> woken it up via ttwu_queue(), so before going idle the next time it
> will check the shared queue for the task and find it. We should be
> good in this case.
> 
> Now, it is possible that select_task_rq_fair() ended up selecting the
> waker's CPU as the target based on the
> wake_affine_idle()/wake_affine_weight() logic. And if there is no idle
> core/thread on the waker's LLC, the target would be the busy waker
> CPU. In the case when the waker CPU is different from the task's
> previous CPU, due to ENQUEUE_MIGRATE flag being set, the task won't be
> queued on the shared wakequeue and instead has to wait on the busy
> waker CPU.
> 
> I wonder if it makes sense to enqueue the task on the shared wakequeue
> in this scenario as well.

Hello Gautham,

That's a good point. My original intention with opting out of using
swqueue if select_task_rq_fair() caused us to migrate is so that it
wouldn't interfere with decisions made with other select_task_rq_fair()
heuristics like wake_affine_*(). Basically just minimizing the possible
impact of swqueue. That said, I think it probably does make sense to
just enqueue in the swqueue regardless of whether ENQUEUE_MIGRATED is
set. One of the main goals of swqueue is work conservation, and in
hindsight it does feel somewhat artificial to add a heuristic that works
against that.

I'd like to hear what others think. In my opinion it's worth at least
running some tests on workloads that heavily utilize the CPU such as
kernel compile, and seeing what the outcomes are.

Thanks,
David
