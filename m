Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51301650481
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 20:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiLRT32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 14:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiLRT3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 14:29:25 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4CAC55
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 11:29:24 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id cf42so10908793lfb.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 11:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5bij1N+RE+NT9rs/4jhnhSd0S8EEIjWa3SSKr/msB/4=;
        b=ePQTk0MTRODA04FbnA3uNIjc2a4SD2UK6RAh0QOvsIkxW6bqPTjTkSKm3QEowTJJEy
         A9hBkppr/NfHGJONV1m9XekcOsItBqKV3AWCrq3j6UcCmtGB2tvuTOo5ObUFo8rAeRg1
         OkOJgID9XhPojTYBn26eop/aB1D9ZRI10UR/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bij1N+RE+NT9rs/4jhnhSd0S8EEIjWa3SSKr/msB/4=;
        b=JrSNTuNqTuc+3mWGlZdc/ucnnAOjRjejRCT5qDAvxi2EA+lmKxU2rT5azEekLMRoiX
         6VUM9LbR6Z32jAVzPdl8nlJLo4xrUlh4gNqz76DCOnEjTzY7Rgr03QGjaweNHzKpWIWQ
         mq+2qcm4mo0WOcKBqfeR6ruTe5k12/oZi0JFVRyC0pRp1iDFi+EYYvvYjU6eX0PFtNMQ
         mZJAbuzIiRJjBi0XW+I3b9Cpg3UHI/Gk7kvma9oVKTFdJYxLJnJQeETyxAcZAYUaP388
         TnGxxUeGiW/4M9PUxAxIiiBEh6tCQT6KNklXB0uFOp+nvdRESUDvZVmCRh+O4kXoCuWw
         aBGg==
X-Gm-Message-State: ANoB5pmGaRB1EHsggqyWTyjKBthajROM98d0pm3TWgAqvU+Go6fXJYBY
        Er7xdAjCrkb380g8tRteZuIFdoCdjHgpZMeT/JAvFA==
X-Google-Smtp-Source: AA0mqf4LMqkB8BEYG4UYs+n/qmkyqYzJ3QD5FVuG0+QT4cybCJR/0ULWwNxwRjMno/r/7HpND41baPm/9XzX9F2GAQ8=
X-Received: by 2002:ac2:4347:0:b0:4a4:782a:42ac with SMTP id
 o7-20020ac24347000000b004a4782a42acmr31538629lfl.468.1671391762982; Sun, 18
 Dec 2022 11:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20221215035755.2820163-1-qiang1.zhang@intel.com>
 <20221217010345.GF4001@paulmck-ThinkPad-P17-Gen-1> <PH0PR11MB5880526CB255AFF91F0D76A2DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588000890D537044BBAA209EDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221217051759.GK4001@paulmck-ThinkPad-P17-Gen-1> <Y550Z+MOq1IX3Wb4@google.com>
 <20221218180638.GR4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221218180638.GR4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 18 Dec 2022 14:29:10 -0500
Message-ID: <CAEXW_YSy4MyUW55Umtt4LRfX_4Dhdv0h2O=n+Zbq2ijakwGnBw@mail.gmail.com>
Subject: Re: [PATCH] rcu: Fix opposite might_sleep() check in rcu_blocking_is_gp()
To:     paulmck@kernel.org
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 1:06 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Dec 18, 2022 at 02:01:11AM +0000, Joel Fernandes wrote:
> > On Fri, Dec 16, 2022 at 09:17:59PM -0800, Paul E. McKenney wrote:
> > > On Sat, Dec 17, 2022 at 02:44:47AM +0000, Zhang, Qiang1 wrote:
> > > >
> > > > On Thu, Dec 15, 2022 at 11:57:55AM +0800, Zqiang wrote:
> > > > > Currently, if the system is in the RCU_SCHEDULER_INACTIVE state, invoke
> > > > > synchronize_rcu_*() will implies a grace period and return directly,
> > > > > so there is no sleep action due to waiting for a grace period to end,
> > > > > but this might_sleep() check is the opposite. therefore, this commit
> > > > > puts might_sleep() check in the correct palce.
> > > > >
> > > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > > >
> > > > >Queued for testing and review, thank you!
> > > > >
> > > > >I was under the impression that might_sleep() did some lockdep-based
> > > > >checking, but I am unable to find it.  If there really is such checking,
> > > > >that would be a potential argument for leaving this code as it is.
> > > > >
> > > > >
> > > > >__might_sleep
> > > > >   __might_resched(file, line, 0)
> > > > >      rcu_sleep_check()
> > > > >
> > > > >Does it refer to this rcu_sleep_check() ?
> > > > >
> > > > >If so, when in the RCU_SCHEDULER_INACTIVE state,  the debug_lockdep_rcu_enabled() is always
> > > > >return false, so the RCU_LOCKDEP_WARN() also does not produce an actual warning.
> > > >
> > > > and when the system_state == SYSTEM_BOOTING, we just did  rcu_sleep_check()  and then  return.
> > >
> > > Very good, thank you!
> > >
> > > Thoughts from others?
> >
> > Please consider this as a best-effort comment that might be missing details:
> >
> > The might_sleep() was added in 18fec7d8758d ("rcu: Improve synchronize_rcu()
> > diagnostics")
> >
> > Since it is illegal to call a blocking API like synchronize_rcu() in a
> > non-preemptible section, is there any harm in just calling might_sleep()
> > uncomditionally in rcu_block_is_gp() ? I think it is a bit irrelevant if
> > synchronize_rcu() is called from a call path, before scheduler is
> > initialized, or after. The fact that it was even called from a
> > non-preemptible section is a red-flag, considering if such non-preemptible
> > section may call synchronize_rcu() API in the future, after full boot up,
> > even if rarely.
> >
> > For this reason, IMHO there is still value in doing the might_sleep() check
> > unconditionally. Say if a common code path is invoked both before
> > RCU_SCHEDULER_INIT and *very rarely* after RCU_SCHEDULER_INIT.
> >
> > Or is there more of a point in doing this check if scheduler is initialized
> > from RCU perspective ?
>
> One advantage of its current placement would be if might_sleep() ever
> unconditionally checks for interrupts being disabled.
>
> I don't believe that might_sleep() will do that any time soon given the
> likely fallout from code invoked at early boot as well as from runtime,
> but why be in the way of that additional diagnostic check?

If I understand the current code, might_sleep() is invoked only if the
scheduler is INACTIVE from RCU perspective, and I don't think here are
reports of fall out. That is current code behavior.

Situation right now is: might_sleep() only if the state is INACTIVE.
Qiang's patch: might_sleep() only if the state is NOT INACTIVE.
My suggestion: might_sleep() regardless of the state.

Is there a reason my suggestion will not work? Apologies if I
misunderstood something.

thanks,

 - Joel


>
>                                                         Thanx, Paul
>
> > If not, I would do something like this:
> >
> > ---8<-----------------------
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 79aea7df4345..23c2303de9f4 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3435,11 +3435,12 @@ static int rcu_blocking_is_gp(void)
> >  {
> >       int ret;
> >
> > +     might_sleep();  /* Check for RCU read-side critical section. */
> > +
> >       // Invoking preempt_model_*() too early gets a splat.
> >       if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE ||
> >           preempt_model_full() || preempt_model_rt())
> >               return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
> > -     might_sleep();  /* Check for RCU read-side critical section. */
> >       preempt_disable();
> >       /*
> >        * If the rcu_state.n_online_cpus counter is equal to one,
