Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4D9667982
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbjALPjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbjALPiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:38:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AD4129;
        Thu, 12 Jan 2023 07:29:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D35C5B81E80;
        Thu, 12 Jan 2023 15:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88ECFC433F0;
        Thu, 12 Jan 2023 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673537353;
        bh=zRqbA/9aTVgnFDge+C5nyFszzES2x1v+sbtjufa6dEU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Nor1IcHyEYEXHJUvCqEFXffEg+s4IbCGwR3TxgvGIbYrP2cWpNWpDcCETn3RigcXl
         snocMiiyw37s4/VIQfmjewNX/1hhSwj39NcyVgbNOcaa9YYXJ3nNnw/NKLXACymHCZ
         MwclJAg9+byv/au23jtaSELRhDI6O43Xw7n6B3RRcU87kxSA4wznZiV4UBpggZUk7L
         sWhCkYuYsZWC0/MX1/rPKHyqhppG6ZK4vW+Kb/8Ne+tyBA8ewZCTWgbCsk1BUzluu6
         BsVzOUj+T9a116zxnkkLzvWoyTCcl2jEwazjXRHxuGckMNdFm5A5fLKhX3fzKiq3SZ
         cbd6E0OiOzGXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 37D2F5C0AF8; Thu, 12 Jan 2023 07:29:13 -0800 (PST)
Date:   Thu, 12 Jan 2023 07:29:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Remove duplicate settings for rcu boost kthreads
 affinity
Message-ID: <20230112152913.GL4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221215090029.2972236-1-qiang1.zhang@intel.com>
 <20221217010919.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880B9403488CAB5DF9810FFDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58806ABF242993103390A6F5DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221221192622.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <Y8AiGy6iYiUk7iB+@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8AiGy6iYiUk7iB+@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 04:07:07PM +0100, Frederic Weisbecker wrote:
> On Wed, Dec 21, 2022 at 11:26:22AM -0800, Paul E. McKenney wrote:
> > On Sat, Dec 17, 2022 at 01:02:03PM +0000, Zhang, Qiang1 wrote:
> > commit 5815245b56229198d5f5d0c48c26d3c0c53ee222
> > Author: Zqiang <qiang1.zhang@intel.com>
> > Date:   Wed Dec 21 11:15:43 2022 -0800
> > 
> >     rcu: Remove redundant call to rcu_boost_kthread_setaffinity()
> >     
> >     The rcu_boost_kthread_setaffinity() function is invoked at
> >     rcutree_online_cpu() and rcutree_offline_cpu() time, early in the online
> >     timeline and late in the offline timeline, respectively.  It is also
> >     invoked from rcutree_dead_cpu(), however, in the absence of userspace
> >     manipulations (for which userspace must take responsibility), this call
> >     is redundant with that from rcutree_offline_cpu().  This redundancy can
> >     be demonstrated by printing out the relevant cpumasks
> >     
> >     This commit therefore removes the call to rcu_boost_kthread_setaffinity()
> >     from rcutree_dead_cpu().
> >     
> >     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul

> Thanks!
> 
> 
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index c3255d27286c4..a6181b76fd5ab 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -4165,15 +4165,10 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
> >   */
> >  int rcutree_dead_cpu(unsigned int cpu)
> >  {
> > -	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > -	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> > -
> >  	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> >  		return 0;
> >  
> >  	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> > -	/* Adjust any no-longer-needed kthreads. */
> > -	rcu_boost_kthread_setaffinity(rnp, -1);
> >  	// Stop-machine done, so allow nohz_full to disable tick.
> >  	tick_dep_clear(TICK_DEP_BIT_RCU);
> >  	return 0;
