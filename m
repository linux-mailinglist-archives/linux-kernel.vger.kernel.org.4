Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6405F5351
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJEL3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJEL3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:29:02 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69626AA09;
        Wed,  5 Oct 2022 04:28:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bs18so16771719ljb.1;
        Wed, 05 Oct 2022 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CEITx3hKWsQE1W6cvtumLnUWvrrlUZolLVqlW13PCT0=;
        b=mb4fsNKoqT4HgQ+VRwj1pUMn8dnJQcsEUOyySOYMndZHWZ7SB93crSUWpYqU+7c19N
         3v+01uM2AiCfOz/nut/ugSaviI9iIPmiZMmV+l27xF4Dy+h4GqvjxHZpe2mh4ypinvga
         GfxeAQKaDgY5KDrSm0MQbS9bec6EpFl3x65NM9hcckNRNMRn4ESUsJ1lt1ORhHkWFoVw
         ZYe3UGSh7zU14rvKnMgjAQDMvjHCRsqFUXTcezrVwUETYBkTphbopC6yfbuoyj4Ek6qm
         nLR2KDCETShNRxwqHN1YDz6wpEmjZXI2+8je6CX2EHQYNmCt3In4nUktg/kXzCMQlOPk
         P30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEITx3hKWsQE1W6cvtumLnUWvrrlUZolLVqlW13PCT0=;
        b=N+26MgbjXBVDFQLdnpUZB79Wcnjm1sC8GiyKdO+bvSuLBxEskK7b9DUNtZFICWgte3
         NXc41sq+7bE48ygCuNOwU6DGkTWKcQsE6zYUwRapVD72x58Qzujzd2qG2xsZrOHS4cqw
         pzjEQ5QdvKZA5oo9pHw0ANSdDs2KR6ZCWQoytbvZsWd34b6BUlsgPD6j7/GkEqMFvg5u
         jZXaObyoC+PkAtayeKGnwzMXXKTAF3qN18JM5770JihrABMMc+kb9mJH552OymEUvNjz
         XnDRwyhJ3NeC8jNkNyxcQj2K/lIiQACTssS8uCe+DgD8bHHZG11naSkrsp04yJ2S8KFU
         j8/Q==
X-Gm-Message-State: ACrzQf3EIpWPsMaUo5JoQ6CT2rBJyb2NfVfteMmCHs4jNSdvu0C7mSX9
        5cycmN/n/X+CDwnO8OmFYYA=
X-Google-Smtp-Source: AMsMyM48Vd3xdHPr79NrTu3yWGk58GsYxcx5KIYKxSDHwN14/2aIUBJqZmr7KNy1g/YvS1SF0mJACQ==
X-Received: by 2002:a2e:8541:0:b0:261:b44b:1a8b with SMTP id u1-20020a2e8541000000b00261b44b1a8bmr10432735ljj.46.1664969338058;
        Wed, 05 Oct 2022 04:28:58 -0700 (PDT)
Received: from pc636 (host-90-235-26-170.mobileonline.telia.com. [90.235.26.170])
        by smtp.gmail.com with ESMTPSA id i2-20020a2ea362000000b0026c2fec2f8esm1591317ljn.84.2022.10.05.04.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 04:28:57 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 5 Oct 2022 13:28:55 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com
Subject: Re: [PATCH v7 02/11] rcu: Make call_rcu() lazy to save power
Message-ID: <Yz1qd2u3ZJN22sqo@pc636>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-3-joel@joelfernandes.org>
 <Yzwb8vgYhAvDJzK+@pc636>
 <20221004133004.GD4196@paulmck-ThinkPad-P17-Gen-1>
 <YzxI1frUjDnB6MOP@pc636>
 <20221004155814.GG4196@paulmck-ThinkPad-P17-Gen-1>
 <YzxdM9tL6vwt2HQ4@pc636>
 <20221004182737.GH4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004182737.GH4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 11:27:37AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 04, 2022 at 06:20:03PM +0200, Uladzislau Rezki wrote:
> > On Tue, Oct 04, 2022 at 08:58:14AM -0700, Paul E. McKenney wrote:
> > > On Tue, Oct 04, 2022 at 04:53:09PM +0200, Uladzislau Rezki wrote:
> > > > On Tue, Oct 04, 2022 at 06:30:04AM -0700, Paul E. McKenney wrote:
> > > > > On Tue, Oct 04, 2022 at 01:41:38PM +0200, Uladzislau Rezki wrote:
> > > > > > >  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
> > > > > > >  		rcu_nocb_lock_irqsave(rdp, flags);
> > > > > > >  		lockdep_assert_held(&rdp->nocb_lock);
> > > > > > >  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > > > > > > -		if (bypass_ncbs &&
> > > > > > > +		lazy_ncbs = READ_ONCE(rdp->lazy_len);
> > > > > > > +
> > > > > > > +		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
> > > > > > > +		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
> > > > > > > +		     bypass_ncbs > 2 * qhimark)) {
> > > > > > Do you know why we want double "qhimark" threshold? It is not only this
> > > > > > place, there are several. I am asking because it is not expected by the
> > > > > > user.
> > > > > 
> > > > > OK, I will bite...  What does the user expect?  Or, perhaps a better
> > > > > question, how is this choice causing the user problems?
> > > > > 
> > > > Yesterday when i was checking the lazy-v6 on Android i noticed the following:
> > > > 
> > > > <snip>
> > > > ...
> > > >      rcuop/4-48      [006] d..1   184.780328: rcu_batch_start: rcu_preempt CBs=15572 bl=121
> > > >      rcuop/6-62      [000] d..1   184.796939: rcu_batch_start: rcu_preempt CBs=21503 bl=167
> > > >      rcuop/6-62      [003] d..1   184.800706: rcu_batch_start: rcu_preempt CBs=24677 bl=192
> > > >      rcuop/6-62      [005] d..1   184.803773: rcu_batch_start: rcu_preempt CBs=27117 bl=211
> > > >      rcuop/6-62      [005] d..1   184.805732: rcu_batch_start: rcu_preempt CBs=22391 bl=174
> > > >      rcuop/6-62      [005] d..1   184.809083: rcu_batch_start: rcu_preempt CBs=12554 bl=98
> > > >      rcuop/6-62      [005] d..1   184.824228: rcu_batch_start: rcu_preempt CBs=16177 bl=126
> > > >      rcuop/4-48      [006] d..1   184.836193: rcu_batch_start: rcu_preempt CBs=24129 bl=188
> > > >      rcuop/4-48      [006] d..1   184.844147: rcu_batch_start: rcu_preempt CBs=25854 bl=201
> > > >      rcuop/4-48      [006] d..1   184.847257: rcu_batch_start: rcu_preempt CBs=21328 bl=166
> > > >      rcuop/4-48      [006] d..1   184.852128: rcu_batch_start: rcu_preempt CBs=21710 bl=169
> > > > ...
> > > > <snip>
> > > > 
> > > > On my device the "qhimark" is set to:
> > > > 
> > > > <snip>
> > > > XQ-CT54:/sys/module/rcutree/parameters # cat qhimark
> > > > 10000
> > > > XQ-CT54:/sys/module/rcutree/parameters #
> > > > <snip>
> > > > 
> > > > so i expect that once we pass 10 000 callbacks threshold the flush 
> > > > should occur. This parameter gives us an opportunity to control a
> > > > memory that should be reclaimed sooner or later.
> > > 
> > > I did understand that you were surprised.
> > > 
> > > But what problem did this cause other than you being surprised?
> > > 
> > It is not about surprising. It is about expectation. So if i set a
> > threshold to 100 i expect it that around 100 callbacks my memory will
> > be reclaimed. But the resolution is 2 * 100 in fact.
> > 
> > I am not aware about any issues with it. I just noticed such behaviour
> > during testing.
> 
> Whew!!!
> 
> This value was arrived at when tuning this code to best deal with callback
> floods.
> 
Actually the "qhimark" is correctly handled by the caller and flush is
initiated exactly after what we have in the(as one of the conditions):

/sys/module/rcutree/parameters/qhimark

<snip>
if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
    ncbs >= qhimark) {
	rcu_nocb_lock(rdp);
<snip>

it is not doubled. I messed it up with another place where you double it:

<snip>
if (bypass_ncbs &&
    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
     bypass_ncbs > 2 * qhimark)) {
<snip>

it is in the nocb_gp_wait(). Indeed, it is needed if we have a real flood
scenario.

Thanks!

--
Uladzislau Rezki
