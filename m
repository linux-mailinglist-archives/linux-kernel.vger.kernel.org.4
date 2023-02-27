Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7AD6A454D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjB0O4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjB0Oz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:55:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803E72D68;
        Mon, 27 Feb 2023 06:55:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26732B80D54;
        Mon, 27 Feb 2023 14:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7C9C433D2;
        Mon, 27 Feb 2023 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677509744;
        bh=2QrzAfKZY4OPPKpyJkn5qM/7xuOVZoXSSIqyOxpALJM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iZpW8caqpGwhUauzk3OVLMZ7ydAG08LNXEX6LKS32VxbMjXskYdpTXWYCwSPFV41W
         cZwGcB+Pvh87+0huEiTjwZvkG2pMxDhgPrG7qFdbz23vsN1MMFGjJEvVO6i9RYZvPO
         fc5QkSLTm4iOJz2bfUljiKlq8mpOMImlmVx/swy4xe2+5KgLjlZgzHsUhH2jMTCZw/
         wu9vpqXEiajUJrnW+IzfU95SeF6pjhiKR2k/mBTQBVaq1SJRI6ZcZWx/1PVcPbrtoY
         FnOVqCX6bIWHDUSxjqFfa7c/NOH41pzgVmNr626VwjRU0G+25URwiHaiblowUBvdOf
         RYyFzb2tmkgdA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5D26D5C0146; Mon, 27 Feb 2023 06:55:44 -0800 (PST)
Date:   Mon, 27 Feb 2023 06:55:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <20230227145544.GC2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <IA1PR11MB617175CA398D425B7489CE4889AF9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <764CA486-6FB2-4667-B8CB-56E3AC31FD58@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <764CA486-6FB2-4667-B8CB-56E3AC31FD58@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 08:22:06AM -0500, Joel Fernandes wrote:
> 
> 
> > On Feb 27, 2023, at 2:53 AM, Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrote:
> > 
> > ﻿
> >> 
> >> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> >> Sent: Saturday, February 25, 2023 11:34 AM
> >> To: linux-kernel@vger.kernel.org
> >> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>; Frederic Weisbecker
> >> <frederic@kernel.org>; Lai Jiangshan <jiangshanlai@gmail.com>; linux-
> >> doc@vger.kernel.org; Paul E. McKenney <paulmck@kernel.org>;
> >> rcu@vger.kernel.org
> >> Subject: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
> >> completed
> >> 
> >> On many systems, a great deal of boot happens after the kernel thinks the
> >> boot has completed. It is difficult to determine if the system has really
> >> booted from the kernel side. Some features like lazy-RCU can risk slowing
> >> down boot time if, say, a callback has been added that the boot
> >> synchronously depends on.
> >> 
> >> Further, it is better to boot systems which pass 'rcu_normal_after_boot' to
> >> stay expedited for as long as the system is still booting.
> >> 
> >> For these reasons, this commit adds a config option
> >> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter
> >> rcupdate.boot_end_delay.
> >> 
> >> By default, this value is 20s. A system designer can choose to specify a value
> >> here to keep RCU from marking boot completion.  The boot sequence will not
> >> be marked ended until at least boot_end_delay milliseconds have passed.
> > 
> > Hi Joel,
> > 
> > Just some thoughts on the default value of 20s, correct me if I'm wrong :-).
> > 
> > Does the OS with CONFIG_PREEMPT_RT=y kernel concern more about the 
> > real-time latency than the overall OS boot time?
> 
> But every system has to boot, even an RT system.
> 
> > 
> > If so, we might make rcupdate.boot_end_delay = 0 as the default value 
> > (NOT the default 20s) for CONFIG_PREEMPT_RT=y kernels? 
> 
> Could you measure how much time your RT system takes to boot before the application runs?
> 
> I can change it to default 0 essentially NOOPing it, but I would rather have a saner default (10 seconds even), than having someone forget to tune this for their system.

Provide a /sys location that the userspace code writes to when it
is ready?  Different systems with different hardware and software
configurations are going to take different amounts of time to boot,
correct?

								Thanx, Paul

> Thanks,
> 
>  - Joel
> 
> 
> > 
> > -Qiuxu
> > 
> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >> ---
> >> v1->v2:
> >>    Update some comments and description.
> >> ...
> > 
