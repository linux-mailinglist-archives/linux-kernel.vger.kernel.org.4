Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0352B61DE03
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 21:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKEUcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 16:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiKEUc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 16:32:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B025BB7FD;
        Sat,  5 Nov 2022 13:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8954360BA8;
        Sat,  5 Nov 2022 20:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3E3C433C1;
        Sat,  5 Nov 2022 20:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667680343;
        bh=4IoyiSINcZesU5NJzWsAUfgEAFFynTO7glS9QxuuuOs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VedjwSz99ciD3apPl27Y0/mEDKEjrN00Vka/IajeGepbXBtBmy0jpvQtTa97iHoC/
         Cjl86A9A2mojNeO8qtzjxdWANkMz8a73t8Vdi00xEWyyes8B1lRXITyntbNRc99ZAZ
         DXpy6k82NBaRc0TgkphPV3VuOKksAzpYTFh88Jn3rDebrMmzgpgzFVQaNcxnOcz45S
         Ui6uI2ig0KeFOWZ3uRje/5v/cZEl/IHKb4YpbAM0fmSqMU5t4sDet50mJHcsnQ/Pfj
         OhDKcVwBvxPNqKGJM+1yzOl3ZMZTUwL2HJ3qmKp9/BQmgHH3GktCqadPazpRT9grkM
         xLFlC9tMQs/Vg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0B4B95C09A2; Sat,  5 Nov 2022 13:32:20 -0700 (PDT)
Date:   Sat, 5 Nov 2022 13:32:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
Message-ID: <20221105203220.GD28461@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
 <20221104021224.102-5-thunder.leizhen@huawei.com>
 <MW5PR84MB18425CBD1259317004F7771AAB3A9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <14e3aa38-98e6-01be-8cde-68fd1f85edf4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14e3aa38-98e6-01be-8cde-68fd1f85edf4@huawei.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 03:03:14PM +0800, Leizhen (ThunderTown) wrote:
> On 2022/11/5 9:58, Elliott, Robert (Servers) wrote:

[ . . . ]

> >> +int rcu_cpu_stall_cputime __read_mostly =
> >> IS_ENABLED(CONFIG_RCU_CPU_STALL_CPUTIME);
> > 
> > As a config option and module parameter, adding some more
> > instrumentation overhead might be worthwhile for other
> > likely causes of rcu stalls.
> > 
> > For example, if enabled, have these functions (if available
> > on the architecture) maintain a per-CPU running count of
> > their invocations, which also cause the CPU to be unavailable
> > for rcu: 
> > - kernel_fpu_begin() calls - FPU/SIMD context preservation,
> >   which also calls preempt_disable()
> > - preempt_disable() calls - scheduler context switches disabled
> > - local_irq_save() calls - interrupts disabled
> > - cond_resched() calls - lack of these is a problem
> > 
> > For kernel_fpu_begin and preempt_disable, knowing if it is
> > currently blocked for those reasons is probably the most
> > helpful.
> 
> These instructions is already in Documentation/RCU/stallwarn.rst

Excellent point -- this document also needs to be updated with this
new information.  I have pulled in your four patches as noted in my
previous email.  They are on the -rcu tree's "dev" branch.

Could you please send a patch containing an initial update to
stallwarn.rst?  The main thing I need is your perspective on how each
field is used.

							Thanx, Paul
