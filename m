Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126846231D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKIRt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiKIRtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:49:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687A725C7B;
        Wed,  9 Nov 2022 09:49:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05C0561C14;
        Wed,  9 Nov 2022 17:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46073C433D6;
        Wed,  9 Nov 2022 17:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668016159;
        bh=iuQVvtvtB8HYf4rE2xjy67B/UvlG9neLcNN/266qS7E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=C3ep/5HlG3cEYPt04OUQYkCm3jGL2sV+/sY+9K2yqaYSOtAeRTwRbbKkYSRT400nK
         RNs0BO/r/woj9xMK9x7LT9fhXnuAC5dWEYs+2GububLaBRNYpdN1F5DaRKMO2tw1LB
         TYDrDnJ8Y7rxOmCaMNffbKeWo/8KcDa7MLCwaey5tNFqxp7iIwz3Yn3q2dEYlXbKrv
         wWyJMUvfIvKHE86FiYV5XAevy2E0i77oIMwONMAVNrRabmg3Sx9+Ry5PKuA1gAFXnY
         Po2Iyy1oWEP052FqSIizUnr+Gf24RyedFY4v6QGplAAO4Ng5G5gJT8rCXXylR0P75D
         vPNrcwu9PCJKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B91405C0EBC; Wed,  9 Nov 2022 09:49:17 -0800 (PST)
Date:   Wed, 9 Nov 2022 09:49:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v3 01/40] rcu: implement lockdep_rcu_enabled for
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <20221109174917.GA734694@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-2-john.ogness@linutronix.de>
 <20221107180157.GL28461@paulmck-ThinkPad-P17-Gen-1>
 <87h6za602y.fsf@jogness.linutronix.de>
 <20221108192724.GI3907045@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108192724.GI3907045@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 11:27:24AM -0800, Paul E. McKenney wrote:
> On Mon, Nov 07, 2022 at 08:29:01PM +0106, John Ogness wrote:
> > On 2022-11-07, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >> Provide an implementation for debug_lockdep_rcu_enabled() when
> > >> CONFIG_DEBUG_LOCK_ALLOC is not enabled. This allows code to check
> > >> if rcu lockdep debugging is available without needing an extra
> > >> check if CONFIG_DEBUG_LOCK_ALLOC is enabled.
> > >> 
> > >> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > >
> > > If you would like me to take this one, please let me know.
> > 
> > Yes, it would be great if you would carry this in the rcu tree. This
> > printk series is already relying on the rcu tree for the NMI-safe
> > work. Thanks!
> 
> Very good, I have queued it.  It is currently on -rcu branch "dev",
> but will find its way to srcunmisafe.2022.10.21a in the next day or two.

But make that srcunmisafe.2022.11.09a, where it now resides.

The old srcunmisafe.2022.10.21a remains in its previous location, just
in case someone else is using it.  Branches are cheap...

							Thanx, Paul
