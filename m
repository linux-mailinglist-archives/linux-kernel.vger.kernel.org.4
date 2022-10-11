Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FCC5FBE81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJKXr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJKXrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:47:24 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2AB12D19
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 16:47:20 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o65so12185314iof.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 16:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2up8oYXI/EHVFioKzFzVTYRmRHPm+gCTG27DRC/Ipq8=;
        b=mssK7G/qevvoEJ2xSlhh0TtPZbnhwd3lNJFYSHTATmi525DN0KYOlqL+rUhyORcKil
         ljMjVpoWFOgAaO9Cln4LoaGzP0PqPV1+h57QXXHcqsYmR1hph5RXBylRwrwh4tyDaGNN
         p0qUPEUcBUPkqEuuGVwvNvO9/A8pWY3EO+P1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2up8oYXI/EHVFioKzFzVTYRmRHPm+gCTG27DRC/Ipq8=;
        b=q8l+ljq+AQpbEE97xofak0fV1PMKw15pQubSff1Ulfx+sIXGkXYfvSztTOieavvBd/
         L2GrObh9sjSAw7A6JLoSFahuaZZOKLVBGZZGchjrjIgW/NGrCPJnN4DiD10bv1aMGnt4
         Y/wp3idTDq7p2dfcsy6uhrWsmWEj5PckNkjCu2r07plpx4gvVYYO0+mgpBYWlAIrDQiZ
         1QizbiwRJNufy9VZQcvGVeC+4Ga5cDLN86adKUxdSdNd3OcNEiiqFFRGrsWVjn92McIe
         jf8EV3HC+sfkm9JVds+Lrp+oUo9fHdYSpXEqyyqsKw9rQzbxamUjYRM1iWA2VSnusWJN
         47SQ==
X-Gm-Message-State: ACrzQf09FYcAjzqcb++Y62PcMqRphCue2S88iG1z3hiyZRJtgXv/xUce
        xCjiRmCM9qRLIlJZ/3m3fl/x77w9pOOHqDw1CqQoel60gL4=
X-Google-Smtp-Source: AMsMyM5oGw44fELVGa/Eh4SpTAwjR9/pJGG4KPS3tpx10Ok+SmIeS5mBzpQ72CyRewR56Ba8n8XiTKONUqyX+LaimGU=
X-Received: by 2002:a6b:3f08:0:b0:6bc:7551:69f6 with SMTP id
 m8-20020a6b3f08000000b006bc755169f6mr3076585ioa.156.1665532038885; Tue, 11
 Oct 2022 16:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221010223956.1041247-1-frederic@kernel.org> <20221010223956.1041247-3-frederic@kernel.org>
 <Y0TOSE3ZM/3uHRWX@google.com> <20221011192150.GA1052160@lothringen>
In-Reply-To: <20221011192150.GA1052160@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 11 Oct 2022 19:47:07 -0400
Message-ID: <CAEXW_YTk+=SmC77PQASkwcMkmB0fyArJEKfPRVmK5+nS4E3y4A@mail.gmail.com>
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

On Tue, Oct 11, 2022 at 3:21 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Tue, Oct 11, 2022 at 02:00:40AM +0000, Joel Fernandes wrote:
> > On Tue, Oct 11, 2022 at 12:39:56AM +0200, Frederic Weisbecker wrote:
> > > When a callback is to be enqueued to the normal queue and not the bypass
> > > one, a flush to the bypass queue is always tried anyway. This attempt
> > > involves locking the bypass lock unconditionally. Although it is
> > > guaranteed not to be contended at this point, because only call_rcu()
> > > can lock the bypass lock without holding the nocb lock, it's still not
> > > free and the operation can easily be spared most of the time by just
> > > checking if the bypass list is empty. The check is safe as nobody can
> > > queue nor flush the bypass concurrently.
> > >
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > ---
> > >  kernel/rcu/tree_nocb.h | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > index 094fd454b6c3..30c3d473ffd8 100644
> > > --- a/kernel/rcu/tree_nocb.h
> > > +++ b/kernel/rcu/tree_nocb.h
> > > @@ -423,8 +423,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > >             if (*was_alldone)
> > >                     trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> > >                                         TPS("FirstQ"));
> > > -           WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > > -           WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> > > +           if (rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
> > > +                   WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > > +                   WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> > > +           }
> > >             return false; // Caller must enqueue the callback.
> > >     }
> >
> > Instead of this, since as you mentioned that the bypass lock is not contended
> > in this path, isn't it unnecessary to even check or attempt to acquire the
> > lock in call_rcu() path? So how about something like the following, or would
> > this not work for some reason?
>
> You're right. But it's a bit error prone and it adds quite some code complication
> just for a gain on a rare event (bypass is supposed to be flushed on rare
> occasions by the caller).

But the "checking of whether to flush" which leads to "acquiring the
bypass lock first" , is not a rare event as you pointed out (can be
spared most of the time as you said). The alternative I proposed
removes the need for the frequent locking (which is another way of
implementing what you suggested).
