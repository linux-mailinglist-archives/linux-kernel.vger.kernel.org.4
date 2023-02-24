Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924456A14F4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBXCfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBXCf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:35:28 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E967E1B57C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:35:26 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id n2so12932980lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QzfaTI7ZGPLbBQPeqlJFR4oQuUNmUeoWM5zoArnrQ2Q=;
        b=T6gUULrWxhw1OaHykD7Kae5fApaYDplIov36NZSQ90XSO7FoYlh0ht2C2IdxZ13/7m
         zBvmJEIvO897++d+owunLHwD6ZndArXxjGYBNSw5gaLI44ey3NFnBNlYu4M1tC8N4wG2
         AoawkfpqzUowc0Uq56Xx0Bh1ExKtJSZqr4WnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzfaTI7ZGPLbBQPeqlJFR4oQuUNmUeoWM5zoArnrQ2Q=;
        b=xkdneEe7X4Ln4bPVnCjCW22qv+/gOq2byQyBCKzT8T5VXlhWtJoD3qaJiJsQv3lTRo
         /vpGgL7u3X3BTJQ+2VFeFGOc73aaJ6MYvkuO/lERFSfqyk15S1kPy3mDc3SgbqoiM4lL
         0JK9yUYQoLoguLOVkVeJA8ywZpQ050RFFcdYx2M+oWYJ/Fw72s9JDa23Xoa88znNh0hL
         DuZBXY664aRDzTFrseGJSFJYtOTSXf5tmLWMZcErUJ9+telil2uYrOdISAaC8Pwugg1s
         xyZxtX8ZaB90RK0BUM+8aZNHXrJFhCAKKsvrwqamm9YcDZ2Ea6olFBSdWiQXsfbZS1WJ
         GFKw==
X-Gm-Message-State: AO0yUKWEnk6ixC4Y5iJA44B1In7En3HQEQOqR18q18Ev4fxM8u0ZzOGZ
        peNUv1Y/jz4JX2snpsGRxvwbjozYUko4TGKw9D/IIA==
X-Google-Smtp-Source: AK7set+kej7NQlVBfBwsnxFjkeCOWoGqZf1G6Y+tQohZVUI1C9VPJpNX5I9agVZ3XTd9/RCG1lMGqdJyBgYI9yIzwX8=
X-Received: by 2002:ac2:548c:0:b0:4db:345d:4f8a with SMTP id
 t12-20020ac2548c000000b004db345d4f8amr4364324lfk.11.1677206125049; Thu, 23
 Feb 2023 18:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20230223063022.2592212-1-qiang1.zhang@intel.com>
 <IA1PR11MB6171F5F6B525B6C599024C9D89AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <PH0PR11MB588084641FFB675A102BA503DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y/eP4h/chB8J0rAj@google.com> <PH0PR11MB58801B94B0374865394E9F8FDAA89@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y/ggCdoMEhMO8vs+@google.com>
In-Reply-To: <Y/ggCdoMEhMO8vs+@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 23 Feb 2023 21:35:13 -0500
Message-ID: <CAEXW_YRTOYu5ZR6aX7AaTGyCQJwjB2aEmuPMYExYD4A2csRP1w@mail.gmail.com>
Subject: Re: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in call_rcu_tasks_generic()
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:25 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Feb 24, 2023 at 12:36:05AM +0000, Zhang, Qiang1 wrote:
> > On Thu, Feb 23, 2023 at 08:43:05AM +0000, Zhang, Qiang1 wrote:
> > > > From: Zqiang <qiang1.zhang@intel.com>
> > > > Sent: Thursday, February 23, 2023 2:30 PM
> > > > To: paulmck@kernel.org; frederic@kernel.org; quic_neeraju@quicinc.com;
> > > > joel@joelfernandes.org
> > > > Cc: rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Subject: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
> > > > call_rcu_tasks_generic()
> > > >
> > > > According to commit '3063b33a347c ("Avoid raw-spinlocked wakeups from
> > > > call_rcu_tasks_generic()")', the grace-period kthread is delayed to wakeup
> > > > using irq_work_queue() is because if the caller of
> > > > call_rcu_tasks_generic() holds a raw spinlock, when the kernel is built with
> > > > CONFIG_PROVE_RAW_LOCK_NESTING=y, due to a spinlock will be hold in
> > > > wake_up(), so the lockdep splats will happen. but now using
> > > > rcuwait_wake_up() to wakeup grace-period kthread instead of wake_up(), in
> > > > rcuwait_wake_up() no spinlock will be acquired, so this commit remove using
> > > >
> > > >There are still spinlock-acquisition and spinlock-release invocations within the call path from rcuwait_wake_up().
> > > >
> > > >rcuwait_wake_up() -> wake_up_process() -> try_to_wake_up(), then:
> > > >
> > > >    raw_spin_lock_irqsave()
> > > >    ...
> > > >    raw_spin_unlock_irqrestore
> > >
> > > Yes, but this is raw_spinlock acquisition and release(note: spinlock will convert to
> > > sleepable lock in Preempt-RT kernel, but raw spinlock is not change).
> > >
> > > acquire raw_spinlock -> acquire spinlock  will trigger lockdep warning.
> > >
> > >Is this really safe in the long run though? I seem to remember there are
> > >weird locking dependencies if RCU is used from within the scheduler [1].
> > >
> >
> >
> > I have  been running rcutorture with rcutorture.type = tasks-tracing,
> > so far no problems have been found.
> >
> >
> > >I prefer to keep it as irq_work_queue() unless you are seeing some benefit.
> > >Generally, there has to be a 'win' or other justification for adding more
> > >risk.
> > >
> > >thanks,
> > >
> > >- Joel
> > >[1] http://www.joelfernandes.org/rcu/scheduler/locking/2019/09/02/rcu-schedlocks.html
> >
> >
> > The problem in this link,  in an earlier RCU version, rcu_read_unlock_special()
> > Invoke wakeup and enter scheduler can lead to deadlock, but my modification is for
> > call_rcu_tasks_generic(), even if there is a lock dependency problem, we should pay
> > more attention to rcu_read_unlock_trace_special()
>
> Consider ABBA deadlocks as well, not just self-deadlocks (which IIRC is what
> the straight-RCU rcu_read_unlock() issues were about).
>
> What prevents the following scenario?
>
> In the scheduler you have code like this:
>                 rq = task_rq_lock(p, &rf);
>                 trace_sched_wait_task(p);
>
> Someone can hook up a BPF program to that tracepoint that then calls
> rcu_read_unlock_trace() -> rcu_read_unlock_trace_special(). All of
> this while holding the rq and pi scheduler locks.
>
> That's A (rq lock) -> B (rtpcp lock).
>
> In another path, your change adds the following dependency due to doing
> wakeup under the rtpcp lock.
>
> That's call_rcu_tasks_generic() -> B (rtpcp lock) -> A (rq lock).

I would like to correct this last statement. That cannot happen but
the concern I guess is, can the following happen due to the change?

call_rcu_tasks_generic() -> B (some BPF lock) -> A (rq lock)

So by doing a wakeup in this change, you have added the dependency for
callers of call_rcu_tasks_trace() . Now, the BPF program is called
from the trace point above and you have ABBA deadlock possibility.

 - Joel
