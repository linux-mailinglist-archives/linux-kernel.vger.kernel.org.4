Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC076749EC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 04:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjATDRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 22:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjATDRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 22:17:31 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B613A83B9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:17:14 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id y25so6124971lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kqRsGV1hLKEL4T2IM0trJmyGv/h6of60RLenPHHF3Ik=;
        b=NPdVT/5TG8Cg1V/NBoiJyjXFh+GKRcfLnySBsiE33eddp14XzN3Yt28Zx3V1qYGhik
         S3t6Us2p6fDNvC0cxbZBlIyxhZNVC8de0Vz/MZfoCIZWuG2S8bXtAMn2gjqr82holuzQ
         w/KSnrfa+LsuaQUZkOlgSL69bxy3p0Z71Q0/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqRsGV1hLKEL4T2IM0trJmyGv/h6of60RLenPHHF3Ik=;
        b=6ydCNge9SQP5ODpc2TeSDNvMY30i5UED4Iu+ZglOc4k07aIYudkExBot+yQfSGZL45
         5SYyl8aLeoNdDkAYDRVPPrKFzryvLWIqVjDfwlttEJPppj9elISsBsU6QCu36TKcQzID
         yCbjgupvQ7IGd0eTWDQu9OKPrYgboyJsSCgFstIwXXskfz88F27+5KRK67fQPSFCfoyq
         /b1RP0Zaztrxj1K9BHlzDO0zpa+Ta7yjK0SMhcrjMU2wilFUy3yoHLdD11IWeMSrGclc
         uU3gH60x5Rv+gJw27ri5/TrwcV1mN72qp77CTjNUwvIUpFcGuYEYVXtQe1yXK0HX9VPC
         w/KQ==
X-Gm-Message-State: AFqh2kqOf170A40t45WHbBdUJgH8T/QL0V6O84+2mUbvIQgBBN3RHuzo
        V91QjEeyp5CQB4bnThNo+7FlTQFGL2zK7nebn2T9cz7Dz8Bczw==
X-Google-Smtp-Source: AMrXdXuuACt/lA0GUYLJvhp+7C4AD8/P/VjBxiXTznvTjyVcTLFTOJm5SG/DHJ05n/8izLTdYkACXpXSZLUYqJvDaZk=
X-Received: by 2002:ac2:5ec4:0:b0:4cb:3b:846e with SMTP id d4-20020ac25ec4000000b004cb003b846emr601857lfq.128.1674184632329;
 Thu, 19 Jan 2023 19:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20230118073014.2020743-1-qiang1.zhang@intel.com>
 <20230118180714.GD2948950@paulmck-ThinkPad-P17-Gen-1> <Y8oHL0uuSEef5aiI@google.com>
In-Reply-To: <Y8oHL0uuSEef5aiI@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 20 Jan 2023 03:17:00 +0000
Message-ID: <CAEXW_YRiiEh_PTm0c7aa-DXUVdHGO77_ohxws_Lpcu_8fvSi_A@mail.gmail.com>
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Jan 20, 2023 at 3:14 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Jan 18, 2023 at 10:07:14AM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 18, 2023 at 03:30:14PM +0800, Zqiang wrote:
> > > When inovke rcu_report_qs_rdp(), if current CPU's rcu_data structure's ->
> > > grpmask has not been cleared from the corresponding rcu_node structure's
> > > ->qsmask, after that will clear and report quiescent state, but in this
> > > time, this also means that current grace period is not end, the current
> > > grace period is ongoing, because the rcu_gp_in_progress() currently return
> > > true, so for non-offloaded rdp, invoke rcu_accelerate_cbs() is impossible
> > > to return true.
> > >
> > > This commit therefore remove impossible rcu_gp_kthread_wake() calling.
> > >
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> >
> > Queued (wordsmithed as shown below, as always, please check) for further
> > testing and review, thank you both!
> >
> >                                                       Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit fbe3e300ec8b3edd2b8f84dab4dc98947cf71eb8
> > Author: Zqiang <qiang1.zhang@intel.com>
> > Date:   Wed Jan 18 15:30:14 2023 +0800
> >
> >     rcu: Remove never-set needwake assignment from rcu_report_qs_rdp()
> >
> >     The rcu_accelerate_cbs() function is invoked by rcu_report_qs_rdp()
> >     only if there is a grace period in progress that is still blocked
> >     by at least one CPU on this rcu_node structure.  This means that
> >     rcu_accelerate_cbs() should never return the value true, and thus that
> >     this function should never set the needwake variable and in turn never
> >     invoke rcu_gp_kthread_wake().
> >
> >     This commit therefore removes the needwake variable and the invocation
> >     of rcu_gp_kthread_wake() in favor of a WARN_ON_ONCE() on the call to
> >     rcu_accelerate_cbs().  The purpose of this new WARN_ON_ONCE() is to
> >     detect situations where the system's opinion differs from ours.
> >
> >     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >     Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index b2c2045294780..7a3085ad0a7df 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1956,7 +1956,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
> >  {
> >       unsigned long flags;
> >       unsigned long mask;
> > -     bool needwake = false;
> >       bool needacc = false;
> >       struct rcu_node *rnp;
> >
> > @@ -1988,7 +1987,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
> >                * NOCB kthreads have their own way to deal with that...
> >                */
> >               if (!rcu_rdp_is_offloaded(rdp)) {
> > -                     needwake = rcu_accelerate_cbs(rnp, rdp);
> > +                     /*
> > +                      * The current GP has not yet ended, so it
> > +                      * should not be possible for rcu_accelerate_cbs()
> > +                      * to return true.  So complain, but don't awaken.
> > +                      */
> > +                     WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
> >               } else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
> >                       /*
> >                        * ...but NOCB kthreads may miss or delay callbacks acceleration
> > @@ -2000,8 +2004,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
> >               rcu_disable_urgency_upon_qs(rdp);
> >               rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> >               /* ^^^ Released rnp->lock */
> > -             if (needwake)
> > -                     rcu_gp_kthread_wake();
>
> AFAICS, there is almost no compiler benefit of doing this, and zero runtime
> benefit of doing this. The WARN_ON_ONCE() also involves a runtime condition
> check of the return value of rcu_accelerate_cbs(), so you still have a
> branch. Yes, maybe slightly smaller code without the wake call, but I'm not
> sure that is worth it.
>
> And, if the opinion of system differs, its a bug anyway, so more added risk.
>
>
> >
> >               if (needacc) {
> >                       rcu_nocb_lock_irqsave(rdp, flags);
>
> And when needacc = true, rcu_accelerate_cbs_unlocked() tries to do a wake up
> anyway, so it is consistent with nocb vs !nocb.

Sorry, I mean "inconsistent".

Thanks,

 - Joel
