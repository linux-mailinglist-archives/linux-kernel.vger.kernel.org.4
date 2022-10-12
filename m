Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B15FC3AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJLKYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJLKYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D886B8C13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:24:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C03BA61491
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE47C433D6;
        Wed, 12 Oct 2022 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665570241;
        bh=ZQMcp5kz44UVGtd+nT2Vrn4lvJVaGZX9S/a6nuBoVWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GK8v5e45y8dzAdar6mgdIldLip8HKB2av9FM+ZjlPvjf8Cl63dEXFSe0ANiSIWN4N
         /blmSkd6qKysPu+3EzTKw3MIiv1TASWiWbO9Wds/vvv5ySGIBkYsCqaYgGA7sxJ8C5
         vAijLpXc+9nGi+AF80cqPpZMPcUNH8T2Is2SVHglZ1rry0AcPkntVM38MEsBOJ/3Kf
         d83SGAWL4ElLh27I8dyGQbDKSfgKn0iYR/FRraAdMB+hBKd0RoPeGMIDkT7C6DpqP+
         31Vb/4ju3E3l2MXHGwF5S0qMKMEsB2j1eNl1AOi2XD25ZwbBezmYOmq1KLaJC+YAVz
         SIvHhFF/bEHYg==
Date:   Wed, 12 Oct 2022 12:23:58 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rcu/nocb: Spare bypass locking upon normal enqueue
Message-ID: <20221012102358.GA1074896@lothringen>
References: <20221010223956.1041247-1-frederic@kernel.org>
 <20221010223956.1041247-3-frederic@kernel.org>
 <Y0TOSE3ZM/3uHRWX@google.com>
 <20221011192150.GA1052160@lothringen>
 <CAEXW_YTk+=SmC77PQASkwcMkmB0fyArJEKfPRVmK5+nS4E3y4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTk+=SmC77PQASkwcMkmB0fyArJEKfPRVmK5+nS4E3y4A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 07:47:07PM -0400, Joel Fernandes wrote:
> On Tue, Oct 11, 2022 at 3:21 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > On Tue, Oct 11, 2022 at 02:00:40AM +0000, Joel Fernandes wrote:
> > > On Tue, Oct 11, 2022 at 12:39:56AM +0200, Frederic Weisbecker wrote:
> > > > When a callback is to be enqueued to the normal queue and not the bypass
> > > > one, a flush to the bypass queue is always tried anyway. This attempt
> > > > involves locking the bypass lock unconditionally. Although it is
> > > > guaranteed not to be contended at this point, because only call_rcu()
> > > > can lock the bypass lock without holding the nocb lock, it's still not
> > > > free and the operation can easily be spared most of the time by just
> > > > checking if the bypass list is empty. The check is safe as nobody can
> > > > queue nor flush the bypass concurrently.
> > > >
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > ---
> > > >  kernel/rcu/tree_nocb.h | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > > index 094fd454b6c3..30c3d473ffd8 100644
> > > > --- a/kernel/rcu/tree_nocb.h
> > > > +++ b/kernel/rcu/tree_nocb.h
> > > > @@ -423,8 +423,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > > >             if (*was_alldone)
> > > >                     trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> > > >                                         TPS("FirstQ"));
> > > > -           WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > > > -           WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> > > > +           if (rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
> > > > +                   WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > > > +                   WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> > > > +           }
> > > >             return false; // Caller must enqueue the callback.
> > > >     }
> > >
> > > Instead of this, since as you mentioned that the bypass lock is not contended
> > > in this path, isn't it unnecessary to even check or attempt to acquire the
> > > lock in call_rcu() path? So how about something like the following, or would
> > > this not work for some reason?
> >
> > You're right. But it's a bit error prone and it adds quite some code complication
> > just for a gain on a rare event (bypass is supposed to be flushed on rare
> > occasions by the caller).
> 
> But the "checking of whether to flush" which leads to "acquiring the
> bypass lock first" , is not a rare event as you pointed out (can be
> spared most of the time as you said). The alternative I proposed
> removes the need for the frequent locking (which is another way of
> implementing what you suggested).

It's not rare as a whole but this quick-check patch addresses the fast path.
What you propose is to extend the API to also cover the other flushes in
rcu_nocb_try_bypass() that are slower path.

I think this makes the API more error prone (users may get it easily wrong)
and complicated for tiny, if measurable, gains.
