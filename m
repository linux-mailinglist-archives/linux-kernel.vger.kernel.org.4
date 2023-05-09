Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E9A6FC889
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjEIOIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjEIOII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414311FE3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA3CD61CD4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 14:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E819BC433D2;
        Tue,  9 May 2023 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683641285;
        bh=RnRS7BOKD9Sz/6TNOQGjEBtBLahisvztzzzUr3thwFg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jBJMuXaRmqLIE7KjRLUavojMfbsNXhjPSaH9U1pkZsGwHMcm7bWuTrvP2vbf0cMQV
         4i7P0EPgfOH72BJ/GbSQEeGTvAw1nulb22NLcyE3iQ2lJwNGjDHbrZlqc0DheZWkbG
         WIXkI1B95tOkZBn4x089Ry1eNl/0wX2B0PgZiaIu8760p0hueYvCUKeAKZaj9naqbJ
         3n40vz4AVugZIWCiqgQGBsB3wczC/ArwJ1IfLUQlaj/s95/OOnj2WJpGMMQt2PSVpt
         iijOS6MOP5lIgDLRUcN9Ea+YekSJ8UM5e94xv+J0F7pHs1UyEP6QC1+7VW+nntxj0T
         mBd3qbn07EpNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 69DACCE18EF; Tue,  9 May 2023 07:08:05 -0700 (PDT)
Date:   Tue, 9 May 2023 07:08:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: kernel/rcu/srcutree.c:1644 srcu_advance_state() warn:
 inconsistent returns '&ssp->srcu_sup->srcu_gp_mutex'.
Message-ID: <4bdbbcd3-6620-4320-ada5-02b71a54106c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c0937326-1cf1-429a-9883-30d9d79b01d0@kili.mountain>
 <c33b0348-7f86-47ce-913c-f1ebc6431f93@paulmck-laptop>
 <30f2e760-e2f3-4941-be9b-b9c5624fd861@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30f2e760-e2f3-4941-be9b-b9c5624fd861@kili.mountain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 08:40:33AM +0300, Dan Carpenter wrote:
> On Sat, May 06, 2023 at 11:45:35AM -0700, Paul E. McKenney wrote:
> > On Sat, May 06, 2023 at 10:22:04AM +0300, Dan Carpenter wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   418d5c98319f67b9ae651babea031b5394425c18
> > > commit: e3a6ab25cfa0fcdcb31c346b9871a566d440980d srcu: Move ->srcu_gp_mutex from srcu_struct to srcu_usage
> > > config: x86_64-randconfig-m001-20230501 (https://download.01.org/0day-ci/archive/20230506/202305060951.I8mz6eHt-lkp@intel.com/config)
> > > compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Reported-by: Dan Carpenter <error27@gmail.com>
> > > | Link: https://lore.kernel.org/r/202305060951.I8mz6eHt-lkp@intel.com/
> > > 
> > > smatch warnings:
> > > kernel/rcu/srcutree.c:1644 srcu_advance_state() warn: inconsistent returns '&ssp->srcu_sup->srcu_gp_mutex'.
> > > 
> > > vim +1644 kernel/rcu/srcutree.c
> > > 
> > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1584  static void srcu_advance_state(struct srcu_struct *ssp)
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1585  {
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1586  	int idx;
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1587  
> > > e3a6ab25cfa0fc Paul E. McKenney 2023-03-17  1588  	mutex_lock(&ssp->srcu_sup->srcu_gp_mutex);
> > > da915ad5cf25b5 Paul E. McKenney 2017-04-05  1589  
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1590  	/*
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1591  	 * Because readers might be delayed for an extended period after
> > > da915ad5cf25b5 Paul E. McKenney 2017-04-05  1592  	 * fetching ->srcu_idx for their index, at any point in time there
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1593  	 * might well be readers using both idx=0 and idx=1.  We therefore
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1594  	 * need to wait for readers to clear from both index values before
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1595  	 * invoking a callback.
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1596  	 *
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1597  	 * The load-acquire ensures that we see the accesses performed
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1598  	 * by the prior grace period.
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1599  	 */
> > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1600  	idx = rcu_seq_state(smp_load_acquire(&ssp->srcu_gp_seq)); /* ^^^ */
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1601  	if (idx == SRCU_STATE_IDLE) {
> > > b3fb11f7e9c3c6 Paul E. McKenney 2023-03-17  1602  		spin_lock_irq_rcu_node(ssp->srcu_sup);
> > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1603  		if (ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed)) {
> > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1604  			WARN_ON_ONCE(rcu_seq_state(ssp->srcu_gp_seq));
> > > b3fb11f7e9c3c6 Paul E. McKenney 2023-03-17  1605  			spin_unlock_irq_rcu_node(ssp->srcu_sup);
> > > e3a6ab25cfa0fc Paul E. McKenney 2023-03-17  1606  			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1607  			return;
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1608  		}
> > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1609  		idx = rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq));
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1610  		if (idx == SRCU_STATE_IDLE)
> > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1611  			srcu_gp_start(ssp);
> > > b3fb11f7e9c3c6 Paul E. McKenney 2023-03-17  1612  		spin_unlock_irq_rcu_node(ssp->srcu_sup);
> > > da915ad5cf25b5 Paul E. McKenney 2017-04-05  1613  		if (idx != SRCU_STATE_IDLE) {
> > > e3a6ab25cfa0fc Paul E. McKenney 2023-03-17  1614  			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1615  			return; /* Someone else started the grace period. */
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1616  		}
> > > da915ad5cf25b5 Paul E. McKenney 2017-04-05  1617  	}
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1618  
> > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1619  	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN1) {
> > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1620  		idx = 1 ^ (ssp->srcu_idx & 1);
> > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1621  		if (!try_check_zero(ssp, idx, 1)) {
> > > e3a6ab25cfa0fc Paul E. McKenney 2023-03-17  1622  			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1623  			return; /* readers present, retry later. */
> > > da915ad5cf25b5 Paul E. McKenney 2017-04-05  1624  		}
> > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1625  		srcu_flip(ssp);
> > > b3fb11f7e9c3c6 Paul E. McKenney 2023-03-17  1626  		spin_lock_irq_rcu_node(ssp->srcu_sup);
> > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1627  		rcu_seq_set_state(&ssp->srcu_gp_seq, SRCU_STATE_SCAN2);
> > > 282d8998e9979c Paul E. McKenney 2022-03-08  1628  		ssp->srcu_n_exp_nodelay = 0;
> > > b3fb11f7e9c3c6 Paul E. McKenney 2023-03-17  1629  		spin_unlock_irq_rcu_node(ssp->srcu_sup);
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1630  	}
> > > dad81a2026841b Paul E. McKenney 2017-03-25  1631  
> > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1632  	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
> > > 
> > > We don't mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex) if this if
> > > statement is false.
> > 
> > Hmmm...
> > 
> > I could make the above line read something like the following:
> > 
> > 	if (!WARN_ON_ONCE(rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)) != SRCU_STATE_SCAN2)) {
> 
> Smatch ignores WARN_ON().  WARNings are triggered all the time, so it's
> not like a BUG() which stops the code flow.
> 
> > 
> > The theory is that there are only three legal values for ->srcu_gp_seq.
> > Because we hold ->srcu_gp_mutex, no one else can change it.   The first
> > "if" statement either returns or sets that state to SRCU_STATE_SCAN1.
> > The second "if" statement also either returns or sets that state to
> > SRCU_STATE_SCAN2.  So that statement should not be false.
> 
> Smatch can't figure out that the statement is true.  The issue there is
> that ssp->srcu_sup->srcu_gp_seq stores a value in the low bits and a
> different value in the high bits.  This seems like something that might
> be worth handling correctly at some point, but that point is in the
> distant future...
> 
> Just ignore this one.

Fair enough!  Yeah, I could imagine that this would be non-trivial.

Is there a not-reached annotation that Smatch pays attention to?

							Thanx, Paul
