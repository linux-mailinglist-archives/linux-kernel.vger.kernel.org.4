Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738265F4945
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJDS1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJDS1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:27:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2906853D3F;
        Tue,  4 Oct 2022 11:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B540D614F6;
        Tue,  4 Oct 2022 18:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B88C433D6;
        Tue,  4 Oct 2022 18:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664908058;
        bh=6M/LvGJFTSCvuI10ZRfPX3txBJRAZvIVtrLdartB6aM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Tt6XjqSLKJGWXZ+Lj7Ovyj4+H+oQFXQH9o5uqOcLFp1BAVhriRH/tXSpqPfu0OFry
         vwOC1SDzoSAxV3u671n+lNq7BADrttZcjfR+HJAawZMIpV/2vsYNwAtiwHO9FnTYjx
         9KymlbDhYN5DcDgGNZzZ7GcmMFeEnCNNdJGi1puNl+uHDsWptBwgjnrAlB4iSBxcCy
         LJo/iu0Bb8RSML6JKd6/16zMUsDaM2Mjcjw2BbdHMDXde/NEhOBmyiTtQ9UaLNMPi9
         p5afwioNml66VuOv3n7urN2swfKPp92q+/tNPh8ssp5WmYd6EbHoNQLftQq2QQh0b3
         QNl1aUMxmPGVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A976D5C0641; Tue,  4 Oct 2022 11:27:37 -0700 (PDT)
Date:   Tue, 4 Oct 2022 11:27:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com
Subject: Re: [PATCH v7 02/11] rcu: Make call_rcu() lazy to save power
Message-ID: <20221004182737.GH4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-3-joel@joelfernandes.org>
 <Yzwb8vgYhAvDJzK+@pc636>
 <20221004133004.GD4196@paulmck-ThinkPad-P17-Gen-1>
 <YzxI1frUjDnB6MOP@pc636>
 <20221004155814.GG4196@paulmck-ThinkPad-P17-Gen-1>
 <YzxdM9tL6vwt2HQ4@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzxdM9tL6vwt2HQ4@pc636>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 06:20:03PM +0200, Uladzislau Rezki wrote:
> On Tue, Oct 04, 2022 at 08:58:14AM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 04, 2022 at 04:53:09PM +0200, Uladzislau Rezki wrote:
> > > On Tue, Oct 04, 2022 at 06:30:04AM -0700, Paul E. McKenney wrote:
> > > > On Tue, Oct 04, 2022 at 01:41:38PM +0200, Uladzislau Rezki wrote:
> > > > > >  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
> > > > > >  		rcu_nocb_lock_irqsave(rdp, flags);
> > > > > >  		lockdep_assert_held(&rdp->nocb_lock);
> > > > > >  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > > > > > -		if (bypass_ncbs &&
> > > > > > +		lazy_ncbs = READ_ONCE(rdp->lazy_len);
> > > > > > +
> > > > > > +		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
> > > > > > +		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
> > > > > > +		     bypass_ncbs > 2 * qhimark)) {
> > > > > Do you know why we want double "qhimark" threshold? It is not only this
> > > > > place, there are several. I am asking because it is not expected by the
> > > > > user.
> > > > 
> > > > OK, I will bite...  What does the user expect?  Or, perhaps a better
> > > > question, how is this choice causing the user problems?
> > > > 
> > > Yesterday when i was checking the lazy-v6 on Android i noticed the following:
> > > 
> > > <snip>
> > > ...
> > >      rcuop/4-48      [006] d..1   184.780328: rcu_batch_start: rcu_preempt CBs=15572 bl=121
> > >      rcuop/6-62      [000] d..1   184.796939: rcu_batch_start: rcu_preempt CBs=21503 bl=167
> > >      rcuop/6-62      [003] d..1   184.800706: rcu_batch_start: rcu_preempt CBs=24677 bl=192
> > >      rcuop/6-62      [005] d..1   184.803773: rcu_batch_start: rcu_preempt CBs=27117 bl=211
> > >      rcuop/6-62      [005] d..1   184.805732: rcu_batch_start: rcu_preempt CBs=22391 bl=174
> > >      rcuop/6-62      [005] d..1   184.809083: rcu_batch_start: rcu_preempt CBs=12554 bl=98
> > >      rcuop/6-62      [005] d..1   184.824228: rcu_batch_start: rcu_preempt CBs=16177 bl=126
> > >      rcuop/4-48      [006] d..1   184.836193: rcu_batch_start: rcu_preempt CBs=24129 bl=188
> > >      rcuop/4-48      [006] d..1   184.844147: rcu_batch_start: rcu_preempt CBs=25854 bl=201
> > >      rcuop/4-48      [006] d..1   184.847257: rcu_batch_start: rcu_preempt CBs=21328 bl=166
> > >      rcuop/4-48      [006] d..1   184.852128: rcu_batch_start: rcu_preempt CBs=21710 bl=169
> > > ...
> > > <snip>
> > > 
> > > On my device the "qhimark" is set to:
> > > 
> > > <snip>
> > > XQ-CT54:/sys/module/rcutree/parameters # cat qhimark
> > > 10000
> > > XQ-CT54:/sys/module/rcutree/parameters #
> > > <snip>
> > > 
> > > so i expect that once we pass 10 000 callbacks threshold the flush 
> > > should occur. This parameter gives us an opportunity to control a
> > > memory that should be reclaimed sooner or later.
> > 
> > I did understand that you were surprised.
> > 
> > But what problem did this cause other than you being surprised?
> > 
> It is not about surprising. It is about expectation. So if i set a
> threshold to 100 i expect it that around 100 callbacks my memory will
> be reclaimed. But the resolution is 2 * 100 in fact.
> 
> I am not aware about any issues with it. I just noticed such behaviour
> during testing.

Whew!!!

This value was arrived at when tuning this code to best deal with callback
floods.

							Thanx, Paul
