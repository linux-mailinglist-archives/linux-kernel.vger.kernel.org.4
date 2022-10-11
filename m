Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236925FAA7F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJKCI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJKCIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:08:21 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9398683233
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:08:18 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id a2so6485500iln.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OXeO+1VdI04/TSXkNnClFCQVHzkwrtY/gPIxUeGoO7g=;
        b=k4p94NgXrwuWzK3oCVC8GU2dOUNZokW75bdYj1cadNJR+BMy/k6g5bJDTCtROTr6rJ
         OwLDEbB2He1a09kP/1IKJAolJZvJRfpfoa3bMaeTbc3URDzSzUE6eync9O2HWhRcVBzW
         Y77oTvav2FSABVf0s3P/z9RdgxOoFd4FbsMrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXeO+1VdI04/TSXkNnClFCQVHzkwrtY/gPIxUeGoO7g=;
        b=DzzR89IYbFJYdq+xE0ehAxn2C2rwWnKRuAyKgtVSP3Kz4VRZdZvbwt3KSHFD0J7tb8
         9+j+AlLmfU0Q90W5k+DUWQlaKAfhbOL0R8cVxG5W9VCz5sYlI6lLpPaHAhlOSNWpQ49T
         9XOrVfVCcKnsHsKNQeJoZ9tr6Xp56+c3vNd3SPW+nlBjk+RXe1TSRbUiQWevEOmkK7eq
         /34lE1NEiYkOol352bKVEmshrLYjoSOn0zMFKD9bXiMYet5qaYT2JczIA5/xaFL110EJ
         NXK1nY0oEXFxIq3JdJl9ZYt/bIi7vrPv5O1rAiE6He+N5Cjnx5zjhb+pMU+FdD8Y73p2
         9hrA==
X-Gm-Message-State: ACrzQf05K0ZTDyqU9hyqJdh3o6eKyEa03ak1fxXdu402IteVqdHQ0UVY
        0DUAihL+88n3ZVHhP5gAk3HiGzFqjXEFVGlzVafCmdHrRlbEfg==
X-Google-Smtp-Source: AMsMyM59pEj3vrTj4M4BEsGAjgRc/WCVYuxC+6gATk1EAlLbFeP/8G2uSufXjr0cFPBgjnFT9a3ES5edijr2imbMI0A=
X-Received: by 2002:a05:6e02:164c:b0:2fc:7179:bc41 with SMTP id
 v12-20020a056e02164c00b002fc7179bc41mr1721066ilu.190.1665454097827; Mon, 10
 Oct 2022 19:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221010223956.1041247-1-frederic@kernel.org> <20221010223956.1041247-3-frederic@kernel.org>
 <Y0TOSE3ZM/3uHRWX@google.com>
In-Reply-To: <Y0TOSE3ZM/3uHRWX@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 10 Oct 2022 22:08:05 -0400
Message-ID: <CAEXW_YT=KGtr8SCc=kmxpAsB8e_5ML9PW5zV5Rph9a1MOjeC1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] rcu/nocb: Spare bypass locking upon normal enqueue
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 10:00 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Tue, Oct 11, 2022 at 12:39:56AM +0200, Frederic Weisbecker wrote:
> > When a callback is to be enqueued to the normal queue and not the bypass
> > one, a flush to the bypass queue is always tried anyway. This attempt
> > involves locking the bypass lock unconditionally. Although it is
> > guaranteed not to be contended at this point, because only call_rcu()
> > can lock the bypass lock without holding the nocb lock, it's still not
> > free and the operation can easily be spared most of the time by just
> > checking if the bypass list is empty. The check is safe as nobody can
> > queue nor flush the bypass concurrently.
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/tree_nocb.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 094fd454b6c3..30c3d473ffd8 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -423,8 +423,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >               if (*was_alldone)
> >                       trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> >                                           TPS("FirstQ"));
> > -             WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > -             WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> > +             if (rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
> > +                     WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > +                     WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> > +             }
> >               return false; // Caller must enqueue the callback.
> >       }
>
> Instead of this, since as you mentioned that the bypass lock is not contended
> in this path, isn't it unnecessary to even check or attempt to acquire the
> lock in call_rcu() path? So how about something like the following, or would
> this not work for some reason?
>
> Thanks.
>
> ---8<-----------------------
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c

If this is too ugly, perhaps a new rcu_nocb_flush_bypass_locked()
function could be called from rcu_nocb_try_flush_bypass() while
keeping all other call sites as-is.

thanks,

 - Joel


> index ad8d4e52ae92..6235e72cca07 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3950,7 +3950,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>         debug_rcu_head_queue(&rdp->barrier_head);
>         rcu_nocb_lock(rdp);
>         was_done = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
> -       WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
> +       WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false, false));
>         if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>                 atomic_inc(&rcu_state.barrier_cpu_count);
>         } else {
> @@ -4379,7 +4379,7 @@ void rcutree_migrate_callbacks(int cpu)
>         my_rdp = this_cpu_ptr(&rcu_data);
>         my_rnp = my_rdp->mynode;
>         rcu_nocb_lock(my_rdp); /* irqs already disabled. */
> -       WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies, false));
> +       WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies, false, false));
>         raw_spin_lock_rcu_node(my_rnp); /* irqs already disabled. */
>         /* Leverage recent GPs and set GP for new callbacks. */
>         needwake = rcu_advance_cbs(my_rnp, rdp) ||
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 1d803d39f0d1..0adb8f97a56d 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -442,7 +442,7 @@ static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
>  static void rcu_init_one_nocb(struct rcu_node *rnp);
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -                                 unsigned long j, bool lazy);
> +                                 unsigned long j, bool lazy, bool nolock);
>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>                                 bool *was_alldone, unsigned long flags,
>                                 bool lazy);
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index c9a791407650..2164f5d79dec 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -328,7 +328,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>   * Note that this function always returns true if rhp is NULL.
>   */
>  static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_in,
> -                                    unsigned long j, bool lazy)
> +                                    unsigned long j, bool lazy, bool nolock)
>  {
>         struct rcu_cblist rcl;
>         struct rcu_head *rhp = rhp_in;
> @@ -359,7 +359,8 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_
>
>         rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
>         WRITE_ONCE(rdp->nocb_bypass_first, j);
> -       rcu_nocb_bypass_unlock(rdp);
> +       if (!nolock)
> +               rcu_nocb_bypass_unlock(rdp);
>         return true;
>  }
>
> @@ -372,13 +373,14 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_
>   * Note that this function always returns true if rhp is NULL.
>   */
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -                                 unsigned long j, bool lazy)
> +                                 unsigned long j, bool lazy, bool nolock)
>  {
>         if (!rcu_rdp_is_offloaded(rdp))
>                 return true;
>         rcu_lockdep_assert_cblist_protected(rdp);
> -       rcu_nocb_bypass_lock(rdp);
> -       return rcu_nocb_do_flush_bypass(rdp, rhp, j, lazy);
> +       if (!nolock)
> +               rcu_nocb_bypass_lock(rdp);
> +       return rcu_nocb_do_flush_bypass(rdp, rhp, j, lazy, nolock);
>  }
>
>  /*
> @@ -391,7 +393,7 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
>         if (!rcu_rdp_is_offloaded(rdp) ||
>             !rcu_nocb_bypass_trylock(rdp))
>                 return;
> -       WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, false));
> +       WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, false, false));
>  }
>
>  /*
> @@ -473,7 +475,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>                         trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>                                             TPS("FirstQ"));
>
> -               WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
> +               WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false, true));
>                 WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
>                 return false; // Caller must enqueue the callback.
>         }
> @@ -487,7 +489,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>                 rcu_nocb_lock(rdp);
>                 *was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>
> -               if (!rcu_nocb_flush_bypass(rdp, rhp, j, lazy)) {
> +               if (!rcu_nocb_flush_bypass(rdp, rhp, j, lazy, true)) {
>                         if (*was_alldone)
>                                 trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>                                                     TPS("FirstQ"));
> @@ -1136,7 +1138,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>          * return false, which means that future calls to rcu_nocb_try_bypass()
>          * will refuse to put anything into the bypass.
>          */
> -       WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
> +       WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false, false));
>         /*
>          * Start with invoking rcu_core() early. This way if the current thread
>          * happens to preempt an ongoing call to rcu_core() in the middle,
> @@ -1717,7 +1719,7 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
>  }
>
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -                                 unsigned long j, bool lazy)
> +                                 unsigned long j, bool lazy, bool nolock)
>  {
>         return true;
>  }
