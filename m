Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF9F66B69A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 05:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjAPE1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 23:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjAPE0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 23:26:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6112C72A9;
        Sun, 15 Jan 2023 20:26:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3E69B80B8A;
        Mon, 16 Jan 2023 04:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7653FC433EF;
        Mon, 16 Jan 2023 04:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673843197;
        bh=U20J5YAsHE8av2PITxrTHMvpYfGswXbWZ0y/Ft6X5AY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZtOVNsEmMWlPIJ+TNtzGBZ10XNU3q/kIcAQJGdgOcX3Tz31LPe0C9UrWea9eXuMBy
         K4y57HGLuJ3Gn+QA8QxJdHEXHuqjvLH3jOJkiO4KKCMCuDBsreDPWnFZ97trejKX3k
         qrCNKBnMHHJ3iKLmYE4GOa93UjDraFPOPtOk/I73dqFXlKek+vYBmmAACksTP5RVsl
         xYbpjx6vZiSKsVMvOq+kD5JXcvh5oqa9rmb7+0t6nvnk+PeVMZyKHGT/Ij1GTxabH3
         xtwnOyT6oAmrAmyfdL5xE99nYUve9BEHy5baHJaZKjsCcUzWqt83xszQxQ+1Y+K2Ki
         0ODIWOr1/+bMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 242CC5C05A0; Sun, 15 Jan 2023 20:26:37 -0800 (PST)
Date:   Sun, 15 Jan 2023 20:26:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, fweisbec@gmail.com, urezki@gmail.com
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu: Track laziness during boot and
 suspend
Message-ID: <20230116042637.GO2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230112005223.2329802-1-joel@joelfernandes.org>
 <20230115162504.08ef72b0@rorschach.local.home>
 <CAEXW_YSNurO-hK+q2amP6wa96jr0KkZ_ggF+5x_sTHESC9vpNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSNurO-hK+q2amP6wa96jr0KkZ_ggF+5x_sTHESC9vpNw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 04:34:58PM -0500, Joel Fernandes wrote:
> On Sun, Jan 15, 2023 at 4:25 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 12 Jan 2023 00:52:22 +0000
> > "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> >
> > > -- a/kernel/rcu/update.c
> > > +++ b/kernel/rcu/update.c
> > > @@ -144,8 +144,45 @@ bool rcu_gp_is_normal(void)
> > >  }
> > >  EXPORT_SYMBOL_GPL(rcu_gp_is_normal);
> > >
> > > -static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
> > > +static atomic_t rcu_async_hurry_nesting = ATOMIC_INIT(1);
> > > +/*
> > > + * Should call_rcu() callbacks be processed with urgency or are
> > > + * they OK being executed with arbitrary delays?
> > > + */
> > > +bool rcu_async_should_hurry(void)
> > > +{
> > > +     return !IS_ENABLED(CONFIG_RCU_LAZY) ||
> > > +            atomic_read(&rcu_async_hurry_nesting);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rcu_async_should_hurry);
> > > +
> > > +/**
> > > + * rcu_async_hurry - Make future async RCU callbacks not lazy.
> > > + *
> > > + * After a call to this function, future calls to call_rcu()
> > > + * will be processed in a timely fashion.
> > > + */
> > > +void rcu_async_hurry(void)
> > > +{
> > > +     if (IS_ENABLED(CONFIG_RCU_LAZY))
> > > +             atomic_inc(&rcu_async_hurry_nesting);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rcu_async_hurry);
> > >
> >
> > Where do you plan on calling these externally, as they are being
> > marked exported?
> >
> > If you allow random drivers to enable this, I can see something
> > enabling it and hitting an error path that causes it to never disable
> > it.
> 
> You mean, just like rcu_expedite_gp() ?
> 
> > I wouldn't have EXPORT_SYMBOL_GPL() unless you really know that it is
> > needed externally.
> 
> At the moment it is not called externally but in the future, it could
> be from rcutorture. If you see rcu_expedite_gp(), that is exported
> too. I was just modeling it around that API.

It really should be invoked from rcutorture for testing purposes.
In current -rcu, TREE01 enables LAZY_RCU, so we are finally getting
coverage (aside from my manual enablement on part of the test grid that
I use).

So we need that export.

On the other hand, wasn't there some talk recently of targeted exports?
If that comes to pass, this could be exported to only rcutorture and
rcuscale.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> >
> > -- Steve
> >
> >
> > > +/**
> > > + * rcu_async_relax - Make future async RCU callbacks lazy.
> > > + *
> > > + * After a call to this function, future calls to call_rcu()
> > > + * will be processed in a lazy fashion.
> > > + */
> > > +void rcu_async_relax(void)
> > > +{
> > > +     if (IS_ENABLED(CONFIG_RCU_LAZY))
> > > +             atomic_dec(&rcu_async_hurry_nesting);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rcu_async_relax);
> > > +
> > > +static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
