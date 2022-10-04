Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6292E5F4760
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJDQUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJDQUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:20:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38092FC2C;
        Tue,  4 Oct 2022 09:20:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y5so2219342lfl.4;
        Tue, 04 Oct 2022 09:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=SveyVG2mWYMNYdeVcH2Zdn//FHQp2TdEQzivbSxpqms=;
        b=b9/Qcn91MRs9/wNxR5pNxG5RKvSpMrY+AOVE6cuBoWItmxnxZIJTv/j6Pt2Z+mi9Yk
         SRKFafVq46eIE5oTwLJoIbO8zb19xbIWDWWCz/pIABiz4aUNm6LgKrXIWOfHvfK4hcnJ
         VI9yW2QXGxQtQGT6uF9dkuotvvkSSVKWP9BIyFqyLsCoJkOPiZrGTd9llGs8aNgxiHaf
         ky9+EAJurB9F3liL8xbQeHxhvzXMt8+eQleEsv4EuNb22lr5oghSerV9zdeF5bWPyY/r
         KS6XLY3SyPWXRJtDU+l17ijJT+sl1Xn7UJCn9D48aemYP+g4CJF0Jkj5VSbVlb5tAsRh
         txBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=SveyVG2mWYMNYdeVcH2Zdn//FHQp2TdEQzivbSxpqms=;
        b=s8YNMZyeFecv1a6lDyI1fk4mRbs7kSgL1H4GZQ0uzUJTBSFsDhaBp0C855Ce0m5TjE
         gPSuijFJBp0PzexPPi7+9hJlmaF3uZ8Ijq91NqBFrnOXk0DNilDohaCSNrg761Rdsgib
         EY2mfE7QzUpVRiYlluq7vKeGh1xRGcVpK+9e2WIYPTye/OSJgf9zptITgrQ07xCquffc
         u6kq+hmeufYwzP0YnKJOzFe/nOihKAdX++ZCiVc19pnd19uTzPBtxX91prcWj5EDoAkV
         SJ4ZaSZhCwejzFpnk4c5ge5kvaC1FwFbZQo7nFkaSsdp11DsAwZpkcTTqUW8zzfpGfBd
         mnqQ==
X-Gm-Message-State: ACrzQf0eVUADzyCetg/GnmRgkVjUecMKX4hOOgLl0K2k0h0KhJ/MqVPT
        emPGCxt9mhccnNf98vPZBCdq7CYxZM8=
X-Google-Smtp-Source: AMsMyM59Z7sD203PT2U/H+KHGx3V1zUGLDiJdafzfOooCKTyeyPEtF5D75Vs6aqDfpAvPwqbdChq8A==
X-Received: by 2002:a05:6512:60d:b0:4a2:3c07:8a3 with SMTP id b13-20020a056512060d00b004a23c0708a3mr3902368lfe.512.1664900406844;
        Tue, 04 Oct 2022 09:20:06 -0700 (PDT)
Received: from pc636 (host-90-235-28-118.mobileonline.telia.com. [90.235.28.118])
        by smtp.gmail.com with ESMTPSA id e15-20020a2e930f000000b0026dcbf9902fsm1144035ljh.13.2022.10.04.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:20:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 4 Oct 2022 18:20:03 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com
Subject: Re: [PATCH v7 02/11] rcu: Make call_rcu() lazy to save power
Message-ID: <YzxdM9tL6vwt2HQ4@pc636>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-3-joel@joelfernandes.org>
 <Yzwb8vgYhAvDJzK+@pc636>
 <20221004133004.GD4196@paulmck-ThinkPad-P17-Gen-1>
 <YzxI1frUjDnB6MOP@pc636>
 <20221004155814.GG4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004155814.GG4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 08:58:14AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 04, 2022 at 04:53:09PM +0200, Uladzislau Rezki wrote:
> > On Tue, Oct 04, 2022 at 06:30:04AM -0700, Paul E. McKenney wrote:
> > > On Tue, Oct 04, 2022 at 01:41:38PM +0200, Uladzislau Rezki wrote:
> > > > >  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
> > > > >  		rcu_nocb_lock_irqsave(rdp, flags);
> > > > >  		lockdep_assert_held(&rdp->nocb_lock);
> > > > >  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > > > > -		if (bypass_ncbs &&
> > > > > +		lazy_ncbs = READ_ONCE(rdp->lazy_len);
> > > > > +
> > > > > +		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
> > > > > +		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
> > > > > +		     bypass_ncbs > 2 * qhimark)) {
> > > > Do you know why we want double "qhimark" threshold? It is not only this
> > > > place, there are several. I am asking because it is not expected by the
> > > > user.
> > > 
> > > OK, I will bite...  What does the user expect?  Or, perhaps a better
> > > question, how is this choice causing the user problems?
> > > 
> > Yesterday when i was checking the lazy-v6 on Android i noticed the following:
> > 
> > <snip>
> > ...
> >      rcuop/4-48      [006] d..1   184.780328: rcu_batch_start: rcu_preempt CBs=15572 bl=121
> >      rcuop/6-62      [000] d..1   184.796939: rcu_batch_start: rcu_preempt CBs=21503 bl=167
> >      rcuop/6-62      [003] d..1   184.800706: rcu_batch_start: rcu_preempt CBs=24677 bl=192
> >      rcuop/6-62      [005] d..1   184.803773: rcu_batch_start: rcu_preempt CBs=27117 bl=211
> >      rcuop/6-62      [005] d..1   184.805732: rcu_batch_start: rcu_preempt CBs=22391 bl=174
> >      rcuop/6-62      [005] d..1   184.809083: rcu_batch_start: rcu_preempt CBs=12554 bl=98
> >      rcuop/6-62      [005] d..1   184.824228: rcu_batch_start: rcu_preempt CBs=16177 bl=126
> >      rcuop/4-48      [006] d..1   184.836193: rcu_batch_start: rcu_preempt CBs=24129 bl=188
> >      rcuop/4-48      [006] d..1   184.844147: rcu_batch_start: rcu_preempt CBs=25854 bl=201
> >      rcuop/4-48      [006] d..1   184.847257: rcu_batch_start: rcu_preempt CBs=21328 bl=166
> >      rcuop/4-48      [006] d..1   184.852128: rcu_batch_start: rcu_preempt CBs=21710 bl=169
> > ...
> > <snip>
> > 
> > On my device the "qhimark" is set to:
> > 
> > <snip>
> > XQ-CT54:/sys/module/rcutree/parameters # cat qhimark
> > 10000
> > XQ-CT54:/sys/module/rcutree/parameters #
> > <snip>
> > 
> > so i expect that once we pass 10 000 callbacks threshold the flush 
> > should occur. This parameter gives us an opportunity to control a
> > memory that should be reclaimed sooner or later.
> 
> I did understand that you were surprised.
> 
> But what problem did this cause other than you being surprised?
> 
It is not about surprising. It is about expectation. So if i set a
threshold to 100 i expect it that around 100 callbacks my memory will
be reclaimed. But the resolution is 2 * 100 in fact.

I am not aware about any issues with it. I just noticed such behaviour
during testing.

--
Uladzislau Rezki
