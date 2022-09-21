Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06975E56D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 01:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiIUXwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 19:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIUXws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 19:52:48 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FC49C235
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:52:47 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c11so5254888qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FECpFjJKptYi5/betqKscw8Hm9Di8iX5KVsNY1fQlRU=;
        b=kFqIxb3c7aTOYtvRywPvr9C0DSxKXgUgqp0kyxd19QkCGttl5By0bLXCvIZgFE55pl
         3PvK57KsFb4puWctDuYXpLaBq0qYJjuftNOL7Nw5kb0U1/xv2ftOS+r9LToZNnfFR/SS
         BxWW7hkSw3f7hehfX+r7ESdZgWZw/L/b97cgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FECpFjJKptYi5/betqKscw8Hm9Di8iX5KVsNY1fQlRU=;
        b=6SM/1i6J4+0GShg50c8QehyXcA0MMg2lmswyUCYGDl07V0R99ZgcmIte5lyBm5iPy5
         kAcwjnD2L/Albj0M/0neI9wRq8oG+zA8MpcFHCOgl23noGVisXReYLQ5Din5ucdvPc2P
         sSiZPx/+F8iTcR81D70oIPG5MlCnb+1MxJOy3WQUmWAmqu+hf++wSkf5zZC+xLeWRfDC
         hLkyJLtcTo8I4xFabQ/g2LTapRIQuVxXWaF7smk6zQtRLHCW8GfCjcyHSGs4BkPzSPPd
         UqDFG/aa1uNo9w7RvVAiCK8hUh8LuCIkP+f7plOMzkFGU0J0TkKqI4O1uKru3q0DPZZQ
         q9bA==
X-Gm-Message-State: ACrzQf10J/MmFrqNkvYUcYArOaodO5+QoANbVpznwoCAIhKjyncp0t2i
        bRI+pt7NWMEMIcIHdh5CSC/+Dw==
X-Google-Smtp-Source: AMsMyM7ptLfmiaAWJuvmyCcT2G+Lv43MG0ZAuZIBYJ10L0kPb08iAHb2HGZmAJkSzKA2lpAbe7GA+g==
X-Received: by 2002:a05:622a:241:b0:35d:75:88a0 with SMTP id c1-20020a05622a024100b0035d007588a0mr765726qtx.370.1663804366400;
        Wed, 21 Sep 2022 16:52:46 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id l3-20020a05620a28c300b006b872b606b1sm2930436qkp.128.2022.09.21.16.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 16:52:45 -0700 (PDT)
Date:   Wed, 21 Sep 2022 23:52:45 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <YyujzQ/sU/aAdx4r@google.com>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen>
 <Yxfggt1/cLBhUi/y@google.com>
 <20220907094014.GA193994@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907094014.GA193994@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 11:40:14AM +0200, Frederic Weisbecker wrote:
> On Wed, Sep 07, 2022 at 12:06:26AM +0000, Joel Fernandes wrote:
> > > > @@ -326,13 +372,20 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > > >   * Note that this function always returns true if rhp is NULL.
> > > >   */
> > > >  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > > > -				  unsigned long j)
> > > > +				  unsigned long j, unsigned long flush_flags)
> > > >  {
> > > > +	bool ret;
> > > > +
> > > >  	if (!rcu_rdp_is_offloaded(rdp))
> > > >  		return true;
> > > >  	rcu_lockdep_assert_cblist_protected(rdp);
> > > >  	rcu_nocb_bypass_lock(rdp);
> > > > -	return rcu_nocb_do_flush_bypass(rdp, rhp, j);
> > > > +	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
> > > > +
> > > > +	if (flush_flags & FLUSH_BP_WAKE)
> > > > +		wake_nocb_gp(rdp, true);
> > > 
> > > Why the true above?
> > > 
> > > Also should we check if the wake up is really necessary (otherwise it means we
> > > force a wake up for all rdp's from rcu_barrier())?
> > > 
> > >        was_alldone = rcu_segcblist_pend_cbs(&rdp->cblist);
> > >        ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
> > >        if (was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist))
> > >        	  wake_nocb_gp(rdp, false);
> > 
> > You mean something like the following right? Though I'm thinking if its
> > better to call wake_nocb_gp() from tree.c in entrain() and let that handle
> > the wake. That way, we can get rid of the extra FLUSH_BP flags as well and
> > let the flush callers deal with the wakeups..
> 
> Ah yes that could make sense if only one caller cares.
> 
> > 
> > Anyway, for testing this should be good...
> > 
> > ---8<-----------------------
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index bd8f39ee2cd0..e3344c262672 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -382,15 +382,19 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >  				  unsigned long j, unsigned long flush_flags)
> >  {
> >  	bool ret;
> > +	bool was_alldone;
> >  
> >  	if (!rcu_rdp_is_offloaded(rdp))
> >  		return true;
> >  	rcu_lockdep_assert_cblist_protected(rdp);
> >  	rcu_nocb_bypass_lock(rdp);
> > +	if (flush_flags & FLUSH_BP_WAKE)
> > +		was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> > +
> 
> You can check that outside bypass lock (but you still need nocb_lock).
> 
> >  	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
> >  
> > -	if (flush_flags & FLUSH_BP_WAKE)
> > -		wake_nocb_gp(rdp, true);
> > +	if (flush_flags & FLUSH_BP_WAKE && was_alldone)
> > +		wake_nocb_gp(rdp, false);
> 
> That doesn't check if the bypass list was empty.

I am ending up with something like the below for v6, after discussing with
Paul on IRC he pointed out we only need to do the rcu_barrier() related
wakeup when all the CBs are lazy in the bypass list. Otherwise timer goes
off. I think Frederic mentioned something similar above in different words.

I prefer to keep this logic in tree_nocb.h since rcu_barrier_entrain()
shouldn't have to deal with nocb internals (in theory anyway).

Looks Ok?

thanks,

 - Joel

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH for v6] fixup! rcu: Introduce call_rcu_lazy() API implementation

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index c197534d0c99..fd056358f041 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -375,18 +375,26 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, unsigned long flush_flags)
 {
 	bool ret;
-	bool was_alldone;
+	bool was_alldone = false;
+	bool bypass_all_lazy = false;
 
 	if (!rcu_rdp_is_offloaded(rdp))
 		return true;
 	rcu_lockdep_assert_cblist_protected(rdp);
 	rcu_nocb_bypass_lock(rdp);
-	if (flush_flags & FLUSH_BP_WAKE)
+
+	if (flush_flags & FLUSH_BP_WAKE) {
 		was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+		bypass_all_lazy =
+		  (rcu_cblist_n_cbs(&rdp->nocb_bypass) == rdp->lazy_len);
+	}
 
 	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
 
-	if (flush_flags & FLUSH_BP_WAKE && was_alldone)
+	// Wake up the nocb GP thread if needed. GP thread could be sleeping
+	// while waiting for lazy timer to expire (otherwise rcu_barrier may
+	// end up waiting for the duration of the lazy timer).
+	if (flush_flags & FLUSH_BP_WAKE && was_alldone && bypass_all_lazy)
 		wake_nocb_gp(rdp, false);
 
 	return ret;
-- 
2.37.3.998.g577e59143f-goog

