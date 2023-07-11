Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9E074F468
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjGKQGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjGKQGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6083012F;
        Tue, 11 Jul 2023 09:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E83CB614F8;
        Tue, 11 Jul 2023 16:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA274C433C7;
        Tue, 11 Jul 2023 16:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689091574;
        bh=lIiHSNQhI0NPaeiwO6P+0Z9XTozkRssTiIbjVlaCYdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tOL9XRVRLm8PS290j1eRrAcuSmTU1uE1NPvXpFGAe6TW24o8DbOGlgz9sypocwcE8
         33cfkOgCBZvk0pBopVoytDj+DfBvU9KWG/XHZ4/z25ZB8MB44+yI+oGoPphLFhGmwY
         MLl1twEcu1nYf4N9lTyJTREmuqm8+jeVQola97g7d0JA+Hq6P9AzbGepY7riOW3URU
         6YioK/IsfvwJT2KbAEscf3LPkg3oOeEZtGZ9LcqLeDRxbz7i9wNrzWWZz/DhmpFOef
         Tz1UxDPoJxh6dBZlJ1ianWw+RV8a32VkB5Mqq5byYSO3+Eo/FeQNoYJmT38OLtc3xT
         iAUHSYsO9v5eQ==
Date:   Tue, 11 Jul 2023 18:06:11 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [linus:master] [rcu/nocb]  7625926086:
 WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_try_bypass
Message-ID: <ZK1983kQCrN+zCqs@lothringen>
References: <202307111535.4823c255-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307111535.4823c255-oliver.sang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 04:48:06PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_try_bypass" on:
> 
> commit: 7625926086765123251f765d91fc3a70617d334d ("rcu/nocb: Fix shrinker race against callback enqueuer")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master Linux 6.5-rc1]
> [test failed on linux-next/master fe57d0d86f03a8b2afe2869a95477d0ed1824c96]
> 
> in testcase: trinity
> version: trinity-i386-abe9de86-1_20230429
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-00
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> the WARNING only happens in a low rate (10 out of 204 runs as below).
> but since we never observed the issue on parent, and we also noticed
> there is a WARN_ON_ONCE in code change, so just report what we observed
> in our tests FYI.
> 
> 5c83cedbaaad6dfe 7625926086765123251f765d91f
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :202          5%          10:204   dmesg.RIP:rcu_nocb_bypass_lock
>            :202          5%          10:204   dmesg.RIP:rcu_nocb_try_bypass
>            :202          5%          10:204   dmesg.WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_bypass_lock
>            :202          5%          10:204   dmesg.WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_try_bypass
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202307111535.4823c255-oliver.sang@intel.com
> 
> 
> 
> [ 315.569574][ T16] WARNING: CPU: 1 PID: 16 at kernel/rcu/tree_nocb.h:124
> rcu_nocb_try_bypass (kernel/rcu/tree_nocb.h:124 kernel/rcu/tree_nocb.h:513)

It's:

static void rcu_nocb_wait_contended(struct rcu_data *rdp)
{
	WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
	while (WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended))) <<< HERE
		cpu_relax();
}

This is called on enqueue time by rcu_nocb_try_bypass().

The places that can increment ->nocb_lock_contended are:

* rcu_nocb_try_bypass() itself, but it's not re-entrant

* rcu_nocb_rdp_deoffload(), but it executes on the local CPU with
  IRQs disabled, so rcu_nocb_try_bypass() can't race
  
* lazy_rcu_shrink_scan(): that's indeed the issue here

* rcu_barrier_entrain(), executed either locally with IRQs disabled
  or remotely when the target is dead, so can't race with rcu_nocb_try_bypass()
  
* rcutree_migrate_callback(): locally with IRQs disabled, can't race

So indeed lazy_rcu_shrink_scan() is the only possible culprit. But then
I wonder, what is the purpose of this ->nocb_lock_contended if it's actually
not an allowed behaviour?

Paul, any recollection of that?

Thanks.
