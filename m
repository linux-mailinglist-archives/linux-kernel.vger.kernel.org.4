Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAFF5FC7B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJLOt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJLOt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:49:26 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D44CF874
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:49:24 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id f14so11029044qvo.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tpH7YacmPgJRhB88lfN4bgUYtMzcUBjV6s2E6XdIZEU=;
        b=JC3ySPLwRyfQg1Kmj0tnIBpxlSTXhQ1ixuoqE9QD7so5yjoihg8EmWgGQHFV7qkC2R
         hDMAPswfA/BB0yKl/SCc6FBpXOn3Inr2N6So/0xw/uFTDvDCyXyKE42j82EHBU2KxtvC
         N8rQ48IUtbFrQBQg+FaVQN9DG3ElLOrfbcctY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpH7YacmPgJRhB88lfN4bgUYtMzcUBjV6s2E6XdIZEU=;
        b=Vmn1TH/s6EGhLw3xud282h5BuEQJuPaaN2L/GoxIqTyZuNEISaDFpxuKq75NJsc7sx
         qCaDSkLfyKj0V/0fg+qmp/tY8MnqCunY8KCc9algC44OsSSMDt8p7Hc5PAxB2miBF0eJ
         /+BbY6aOTpkYco8l3lfkGfiuzYXytVi4rYFEE1LhFa9V5YXcfonN2tS/K9+rEQA+FIc8
         p4+7xNE6dis51zi2M49bkSZEMRFe4FdQPkJMdr1ibJfJEN+A5PfeS5glq6eSPkcWEYz+
         W7LGsF6hH74hQNAtGgK4royxmy1d5So6buT8exC/JKtRwomD/5H109y+WUWBw26pda/Y
         Lc9w==
X-Gm-Message-State: ACrzQf17c4uDTfZPteur0b5MpBQftZO5sZJwK9Mxn4/mG74cdcQ6XH9I
        9zrJp4TKnzs29IAkjsUDsBkhmezJBHlbQA==
X-Google-Smtp-Source: AMsMyM4dvLcVxOPBRm5dxkBxLGQ/wpAx/iHlZYPEHqw5AVD0y1AV31RaI/co0MFkPFcJqiMzYaAXMA==
X-Received: by 2002:ad4:5d6c:0:b0:4af:b5e0:63f1 with SMTP id fn12-20020ad45d6c000000b004afb5e063f1mr23576873qvb.35.1665586162906;
        Wed, 12 Oct 2022 07:49:22 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id ey23-20020a05622a4c1700b0035cf31005e2sm12874646qtb.73.2022.10.12.07.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 07:49:22 -0700 (PDT)
Date:   Wed, 12 Oct 2022 14:49:22 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rcu/nocb: Spare bypass locking upon normal enqueue
Message-ID: <Y0bT8jRig7b9PxTe@google.com>
References: <20221010223956.1041247-1-frederic@kernel.org>
 <20221010223956.1041247-3-frederic@kernel.org>
 <Y0TOSE3ZM/3uHRWX@google.com>
 <20221011192150.GA1052160@lothringen>
 <CAEXW_YTk+=SmC77PQASkwcMkmB0fyArJEKfPRVmK5+nS4E3y4A@mail.gmail.com>
 <20221012102358.GA1074896@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012102358.GA1074896@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 12:23:58PM +0200, Frederic Weisbecker wrote:
> On Tue, Oct 11, 2022 at 07:47:07PM -0400, Joel Fernandes wrote:
> > On Tue, Oct 11, 2022 at 3:21 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > >
> > > On Tue, Oct 11, 2022 at 02:00:40AM +0000, Joel Fernandes wrote:
> > > > On Tue, Oct 11, 2022 at 12:39:56AM +0200, Frederic Weisbecker wrote:
> > > > > When a callback is to be enqueued to the normal queue and not the bypass
> > > > > one, a flush to the bypass queue is always tried anyway. This attempt
> > > > > involves locking the bypass lock unconditionally. Although it is
> > > > > guaranteed not to be contended at this point, because only call_rcu()
> > > > > can lock the bypass lock without holding the nocb lock, it's still not
> > > > > free and the operation can easily be spared most of the time by just
> > > > > checking if the bypass list is empty. The check is safe as nobody can
> > > > > queue nor flush the bypass concurrently.
> > > > >
> > > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > > ---
> > > > >  kernel/rcu/tree_nocb.h | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > > > index 094fd454b6c3..30c3d473ffd8 100644
> > > > > --- a/kernel/rcu/tree_nocb.h
> > > > > +++ b/kernel/rcu/tree_nocb.h
> > > > > @@ -423,8 +423,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > > > >             if (*was_alldone)
> > > > >                     trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> > > > >                                         TPS("FirstQ"));
> > > > > -           WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > > > > -           WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> > > > > +           if (rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
> > > > > +                   WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > > > > +                   WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> > > > > +           }
> > > > >             return false; // Caller must enqueue the callback.
> > > > >     }
> > > >
> > > > Instead of this, since as you mentioned that the bypass lock is not contended
> > > > in this path, isn't it unnecessary to even check or attempt to acquire the
> > > > lock in call_rcu() path? So how about something like the following, or would
> > > > this not work for some reason?
> > >
> > > You're right. But it's a bit error prone and it adds quite some code complication
> > > just for a gain on a rare event (bypass is supposed to be flushed on rare
> > > occasions by the caller).
> > 
> > But the "checking of whether to flush" which leads to "acquiring the
> > bypass lock first" , is not a rare event as you pointed out (can be
> > spared most of the time as you said). The alternative I proposed
> > removes the need for the frequent locking (which is another way of
> > implementing what you suggested).
> 
> It's not rare as a whole but this quick-check patch addresses the fast path.
> What you propose is to extend the API to also cover the other flushes in
> rcu_nocb_try_bypass() that are slower path.

You can keep the same API though.

But there is also the unlock path which needs to be conditional, so I agree
it does complicate the code a bit more.

> I think this makes the API more error prone (users may get it easily wrong)
> and complicated for tiny, if measurable, gains.

Ok fair point. So then your original patch is good with me then. And nice
observation indeed.

thanks!

 - Joel

