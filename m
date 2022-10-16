Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC9C6002D9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJPSX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJPSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:23:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E681040579;
        Sun, 16 Oct 2022 11:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79F8860DE6;
        Sun, 16 Oct 2022 18:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B4DC433D6;
        Sun, 16 Oct 2022 18:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665944604;
        bh=aPwiNLMoVuU3ql6A62evx6yCzs8kR0OVLUB2F9S194Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ldEULLb46QM1z7HQOVI0plPodg7KE0MaxgaaevHjapDJzQfxq3/t/c/lpaLhuSHYE
         iSFgpEHYcWYZSxtsmu8oKoTZC2tyV3e4ckED68bDxb1XE1f+zIEAQoma9wi7yFB3gT
         AnUUUOs5qBhwh0zNR1JpwuNahSOXMZbqlFKvRH1LYlcBA8hCpZEh2Ku4EdPAJY43/v
         bUtEHsOero/b3JEG91psuy/PUaDiPvNx0PHZAuzz+PKhDFGDdxnokmt70iDL3cAR8V
         OGu+PDZaLqM/vjMnUIBSns9JCXF2zqTRHXWZv6m0GPUHQSgfzXMWj13I5MpvbVcMGf
         kok+TxJv2HOZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7175F5C0624; Sun, 16 Oct 2022 11:23:24 -0700 (PDT)
Date:   Sun, 16 Oct 2022 11:23:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        frederic@kernel.org
Subject: Re: [PATCH v9 01/13] rcu: Fix missing nocb gp wake on rcu_barrier()
Message-ID: <20221016182324.GB5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221016162305.2489629-1-joel@joelfernandes.org>
 <20221016162305.2489629-2-joel@joelfernandes.org>
 <CAEXW_YTqgs__LBdyho4ZNuMbmY01KmH-8k_2j87qPS6kx1i8FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTqgs__LBdyho4ZNuMbmY01KmH-8k_2j87qPS6kx1i8FA@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 12:25:32PM -0400, Joel Fernandes wrote:
> On Sun, Oct 16, 2022 at 12:23 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > From: Frederic Weisbecker <frederic@kernel.org>
> >
> > In preparation of RCU lazy changes, wake up the RCU nocb gp thread if
> > needed after an entrain. Otherwise, the RCU barrier callback can wait in
> > the queue for several seconds before the lazy callbacks in front of it
> > are serviced.
> >
> > Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Change-Id: I830269cd41b18862a1a58b26ce3292c6c4457bc7
> 
> Ah, sorry for the Change-id Paul! If you don't mind, please edit this
> out from the change log for this and the next patch (it is only in
> these 2!)

That I can safely do.  ;-)

But not today, too many timezones yesterday.

							Thanx, Paul

>  - Joel
> 
> 
> > ---
> >  kernel/rcu/tree.c      | 11 +++++++++++
> >  kernel/rcu/tree.h      |  1 +
> >  kernel/rcu/tree_nocb.h |  5 +++++
> >  3 files changed, 17 insertions(+)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 5ec97e3f7468..67a1ae5151f5 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3894,6 +3894,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> >  {
> >         unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
> >         unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
> > +       bool wake_nocb = false;
> > +       bool was_alldone = false;
> >
> >         lockdep_assert_held(&rcu_state.barrier_lock);
> >         if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
> > @@ -3902,7 +3904,14 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> >         rdp->barrier_head.func = rcu_barrier_callback;
> >         debug_rcu_head_queue(&rdp->barrier_head);
> >         rcu_nocb_lock(rdp);
> > +       /*
> > +        * Flush bypass and wakeup rcuog if we add callbacks to an empty regular
> > +        * queue. This way we don't wait for bypass timer that can reach seconds
> > +        * if it's fully lazy.
> > +        */
> > +       was_alldone = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
> >         WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> > +       wake_nocb = was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
> >         if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
> >                 atomic_inc(&rcu_state.barrier_cpu_count);
> >         } else {
> > @@ -3910,6 +3919,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> >                 rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
> >         }
> >         rcu_nocb_unlock(rdp);
> > +       if (wake_nocb)
> > +               wake_nocb_gp(rdp, false);
> >         smp_store_release(&rdp->barrier_seq_snap, gseq);
> >  }
> >
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index d4a97e40ea9c..925dd98f8b23 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -439,6 +439,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
> >  static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
> >  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
> >  static void rcu_init_one_nocb(struct rcu_node *rnp);
> > +static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
> >  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >                                   unsigned long j);
> >  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index f77a6d7e1356..094fd454b6c3 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1558,6 +1558,11 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
> >  {
> >  }
> >
> > +static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
> > +{
> > +       return false;
> > +}
> > +
> >  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >                                   unsigned long j)
> >  {
> > --
> > 2.38.0.413.g74048e4d9e-goog
> >
