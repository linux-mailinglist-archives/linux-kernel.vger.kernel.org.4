Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E7B68A0DA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjBCRvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjBCRve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:51:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C435386B4;
        Fri,  3 Feb 2023 09:51:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F662B82B71;
        Fri,  3 Feb 2023 17:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6CAC433EF;
        Fri,  3 Feb 2023 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675446684;
        bh=UajoyW9n+yiaQw+xQj/VWfYTICp5snUgdh2mt8zSTVI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FYliuYY7TBloFrvBYEvn5cjfa5hASN+DrCzpJ+ZgxZ2yrR0MUvv57Cw5egWMWUgpN
         4ckb9eFaC371ZQAOXbhzItzRo82CdoPdtoty99AWHMwymSZoJHw5B2khR7HgPZs5oX
         sMrohWMiU0oYOdY4ReCWUKMNNQ0lKYC6iC3EvbP7/t3MePhH6Gd+4XVNaUcJYQ12/t
         4R+KnEskeAu2KMpIruZq3Qo5VnKjGB8JKNFjx3n/x3LdmBe0FRGmL6pAD2CswzqnLF
         T3gH/VoGIkQizGp3Ww2lLmiLqi/COPAKRi8dGh9+3Lobuib1QndspEB6ibQk0EyJiQ
         cMBY9v08yytmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B91AC5C06D0; Fri,  3 Feb 2023 09:51:23 -0800 (PST)
Date:   Fri, 3 Feb 2023 09:51:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rcutorture: Create nocb tasks only for rcu testing
 and CONFIG_RCU_NOCB_CPU=y kernel
Message-ID: <20230203175123.GK2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230203064054.3418539-1-qiang1.zhang@intel.com>
 <CAEXW_YR3F+hb4hWuaONM4qCqAkH_6MMBWKAaK7b2TAzodKhz8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YR3F+hb4hWuaONM4qCqAkH_6MMBWKAaK7b2TAzodKhz8g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 12:29:23PM -0500, Joel Fernandes wrote:
> On Fri, Feb 3, 2023 at 1:35 AM Zqiang <qiang1.zhang@intel.com> wrote:
> >
> > When setting nocbs_nthreads to start rcutorture test with a non-zero value,
> > the nocb tasks will be created and invoke rcu_nocb_cpu_offload/deoffload()
> > to toggle CPU's callback-offload state, but this is meaningless for non-rcu
> > testing or CONFIG_RCU_NOCB_CPU=n kernel create nocb tasks to periodically
> > toggle CPU's callback-offload state and adds unnecessary testing overhead.
> >
> > This commit therefore add checks for cur_ops types and CONFIG_RCU_NOCB_CPU
> > options when nocbs_nthreads is non-zero to avoid unnecessary nocb task
> > creation.
> >
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued and pushed, thank you both!

Note that this loses testing of the offload/de-offload API when there
is nothing to offload or de-offload, but that is not necessarily the job
of rcutorture.  Or if it is the job of rcutorture, perhaps it is a single
pair of calls somewhere.  And that can certainly be a separate patch.

But perhaps Frederic has an opinion on what testing is needed for this
case, and if so where that testing should live.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > ---
> >  kernel/rcu/rcutorture.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 297da28ce92d..d01127e0e8cd 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -3708,6 +3708,12 @@ rcu_torture_init(void)
> >                 pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
> >                 fqs_duration = 0;
> >         }
> > +       if (nocbs_nthreads != 0 && (cur_ops != &rcu_ops ||
> > +                                       !IS_ENABLED(CONFIG_RCU_NOCB_CPU))) {
> > +               pr_alert("rcu-torture types: %s and CONFIG_RCU_NOCB_CPU=%d, nocb toggle disabled.\n",
> > +                               cur_ops->name, IS_ENABLED(CONFIG_RCU_NOCB_CPU));
> > +               nocbs_nthreads = 0;
> > +       }
> >         if (cur_ops->init)
> >                 cur_ops->init();
> >
> > --
> > 2.25.1
> >
