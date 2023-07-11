Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDC974F5BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjGKQmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGKQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A4412F;
        Tue, 11 Jul 2023 09:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BB6F61562;
        Tue, 11 Jul 2023 16:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AC4C433C8;
        Tue, 11 Jul 2023 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093718;
        bh=e12fVv+jbg+rtuqgZVdbfY4QsX3pyZ0VOma3IqU2+NY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZA/ODN8NQ5VUYztVEv5WCj/EDFBzIgVSBCbRM8NBJgB04WuxBTE9U+m3rV/eFzGbY
         eecTHXoY3UfvaaRq1fMeI2KQF1UbO21eUW4TJNMFUNxNf4iBfcvUMk6iZDx1QmpKIg
         Zl55cGXb2v/WSII0Th2ZwiS2p+K5jJbJ1CWY3Q57xOUrm9h/2jtLwD48dT8zfZnack
         tneQPkaq+r3SpbZ5/+y+K83NPjcPN8VE0J+3jyuNe2CEF6anJulMSDWZwENXHnOraY
         xSb0/bo+KrIRUmhbrVTQTYewg0IQiu/RQAwCatuKoqmEj9R4WkEVWC32AxRZ53XYAJ
         c0kAL6xmQbAvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 709E9CE03F1; Tue, 11 Jul 2023 09:41:58 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:41:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [linus:master] [rcu/nocb]  7625926086:
 WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_try_bypass
Message-ID: <842683bc-5859-48be-8ca5-17a1e4bf3f39@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202307111535.4823c255-oliver.sang@intel.com>
 <ZK1983kQCrN+zCqs@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK1983kQCrN+zCqs@lothringen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 06:06:11PM +0200, Frederic Weisbecker wrote:
> On Tue, Jul 11, 2023 at 04:48:06PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_try_bypass" on:
> > 
> > commit: 7625926086765123251f765d91fc3a70617d334d ("rcu/nocb: Fix shrinker race against callback enqueuer")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linus/master Linux 6.5-rc1]
> > [test failed on linux-next/master fe57d0d86f03a8b2afe2869a95477d0ed1824c96]
> > 
> > in testcase: trinity
> > version: trinity-i386-abe9de86-1_20230429
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	group: group-00
> > 
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> > 
> > 
> > compiler: gcc-12
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > the WARNING only happens in a low rate (10 out of 204 runs as below).
> > but since we never observed the issue on parent, and we also noticed
> > there is a WARN_ON_ONCE in code change, so just report what we observed
> > in our tests FYI.
> > 
> > 5c83cedbaaad6dfe 7625926086765123251f765d91f
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :202          5%          10:204   dmesg.RIP:rcu_nocb_bypass_lock
> >            :202          5%          10:204   dmesg.RIP:rcu_nocb_try_bypass
> >            :202          5%          10:204   dmesg.WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_bypass_lock
> >            :202          5%          10:204   dmesg.WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_try_bypass
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202307111535.4823c255-oliver.sang@intel.com
> > 
> > 
> > 
> > [ 315.569574][ T16] WARNING: CPU: 1 PID: 16 at kernel/rcu/tree_nocb.h:124
> > rcu_nocb_try_bypass (kernel/rcu/tree_nocb.h:124 kernel/rcu/tree_nocb.h:513)
> 
> It's:
> 
> static void rcu_nocb_wait_contended(struct rcu_data *rdp)
> {
> 	WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
> 	while (WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended))) <<< HERE
> 		cpu_relax();
> }
> 
> This is called on enqueue time by rcu_nocb_try_bypass().
> 
> The places that can increment ->nocb_lock_contended are:
> 
> * rcu_nocb_try_bypass() itself, but it's not re-entrant
> 
> * rcu_nocb_rdp_deoffload(), but it executes on the local CPU with
>   IRQs disabled, so rcu_nocb_try_bypass() can't race
>   
> * lazy_rcu_shrink_scan(): that's indeed the issue here
> 
> * rcu_barrier_entrain(), executed either locally with IRQs disabled
>   or remotely when the target is dead, so can't race with rcu_nocb_try_bypass()
>   
> * rcutree_migrate_callback(): locally with IRQs disabled, can't race
> 
> So indeed lazy_rcu_shrink_scan() is the only possible culprit. But then
> I wonder, what is the purpose of this ->nocb_lock_contended if it's actually
> not an allowed behaviour?
> 
> Paul, any recollection of that?

Heh!

The purpose was to see if this lock was ever contended.  I guess we now
have an answer, which is "Yes, but rarely."

It looks like the victim commit increased the size of the ->nocb_lock
critical section, just enough to make this happen sometimes.

Removing the WARN_ON_ONCE() seems appropriate, especially given that
this only happens when shrinking.

Should we add something that monitors that lock's contention?  It is
often the case that lock contention rises over time as new features and
optimizations are added.

							Thanx, Paul
