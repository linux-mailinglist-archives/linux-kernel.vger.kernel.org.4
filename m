Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1C7674B28
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjATErR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjATEqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:46:55 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C24CCE8BD
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:41:13 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id o7so4321451ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hEG/FnrwfdwZ3LPudI7/sJe1zUrUfL4egy48UifV8vY=;
        b=mXjFXgPO8jB/wmPB8hypYSvnxynqkSuIKNXSf76GcHmW97T8O7hQFPmM6V1qpiGfj/
         LDxX+pczDTsR/1joFzn3vWoywD4vSSiB67qX5VOOlDOQoN60lk/kr7dUofe0hQogwvm6
         43Vwv0K2Z0wpukdWwR+c/FbAPEH/EMoRQ37ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEG/FnrwfdwZ3LPudI7/sJe1zUrUfL4egy48UifV8vY=;
        b=6UqytxPDywpyUapRAzlNka2/c73fyunDt0Z3jOvVjnmcmn7UxeflgPPSexQG0OSeoj
         1otSixWWrsRbTL/Yd5s1CcG/0P26TkKDrjxQNWa4a9hPuehNwBtNgWY3BMksRvILHuV8
         ghTBfJM/RXtjzCGmQXz67vEzbnoqgxQWLRCoeCLTmq8NusSIKfI478pXswvesOAJ9Vjj
         N0B1GHWVLIZuqSwwjEol98DJxXIAaUw61U2r0wjU5722UBobat08MAdrkmjZFGs3nGqV
         PSTGJVJ0jUn7t/fLgAotav+clTMQpSWRseWTXX+SIVf6HlEjtiRrUKBjIIGUAXTS1WiA
         riNA==
X-Gm-Message-State: AFqh2kpyjts9oJ4d+HLCa7VlxcUMNjZYKzVgSURd32zLx4M7ZGPaM++I
        83lWnNbZ7f1sTHlrTUSLr2+m8/qrF7RT2XRKEq3VHQ==
X-Google-Smtp-Source: AMrXdXuP5AfH2L+1n9DRM8Qc3x1SuUWhgpbkO86atAMntY2fRalGTojFA+Zi/6YIqQjB8ZW8+7YEfHB4VmMuSrxLbDU=
X-Received: by 2002:a2e:a278:0:b0:276:4462:2d20 with SMTP id
 k24-20020a2ea278000000b0027644622d20mr712508ljm.19.1674189670741; Thu, 19 Jan
 2023 20:41:10 -0800 (PST)
MIME-Version: 1.0
References: <20230118073014.2020743-1-qiang1.zhang@intel.com>
 <20230118180714.GD2948950@paulmck-ThinkPad-P17-Gen-1> <Y8oHL0uuSEef5aiI@google.com>
 <PH0PR11MB5880980194CEA45416325716DAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880980194CEA45416325716DAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 20 Jan 2023 04:40:58 +0000
Message-ID: <CAEXW_YQKhr6y+R+2a_Z8WG8+BuNT4jMP8eAepO0Z-apU2a_ibw@mail.gmail.com>
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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

On Fri, Jan 20, 2023 at 4:09 AM Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
>
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
> >
> >AFAICS, there is almost no compiler benefit of doing this, and zero runtime
> >benefit of doing this. The WARN_ON_ONCE() also involves a runtime condition
> >check of the return value of rcu_accelerate_cbs(), so you still have a
> >branch. Yes, maybe slightly smaller code without the wake call, but I'm not
> >sure that is worth it.
> >
> >And, if the opinion of system differs, its a bug anyway, so more added risk.
> >
> >
> >
> >               if (needacc) {
> >                       rcu_nocb_lock_irqsave(rdp, flags);
> >
> >And when needacc = true, rcu_accelerate_cbs_unlocked() tries to do a wake up
> >anyway, so it is consistent with nocb vs !nocb.
>
> For !nocb, we invoked rcu_accelerate_cbs() before report qs,  so this GP is impossible to end
> and we also not set RCU_GP_FLAG_INIT to start new GP in rcu_accelerate_cbs().
> but for nocb, when needacc = true, we invoke rcu_accelerate_cbs_unlocked() after current CPU
> has reported qs,  if all CPU have been reported qs,  we will wakeup gp kthread to end this GP in
> rcu_report_qs_rnp().   after that, the rcu_accelerate_cbs_unlocked() is  possible to try to wake up
> gp kthread if this GP has ended at this time.   so nocb vs !nocb is likely to be inconsistent.
>

That is a fair point. But after gp ends,  rcu_check_quiescent_state()
-> note_gp_changes() which will do a accel + GP thread wake up at that
point anyway, once it notices that a GP has come to an end. That
should happen for both the nocb and !nocb cases right?

I am wondering if rcu_report_qs_rdp() needs to be rethought to make
both cases consistent.

Why does the nocb case need an accel + GP thread wakeup in the
rcu_report_qs_rdp() function, but the !nocb case does not?

(I am out of office till Monday but will intermittently (maybe) check
in, RCU is one of those things that daydreaming tends to lend itself
to...)

 - Joel
