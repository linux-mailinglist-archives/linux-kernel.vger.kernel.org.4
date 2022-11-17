Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2030A62DE0C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiKQO1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240425AbiKQO05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:26:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF6679E37;
        Thu, 17 Nov 2022 06:26:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61CC161EB0;
        Thu, 17 Nov 2022 14:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4473BC433C1;
        Thu, 17 Nov 2022 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668695211;
        bh=D1wwaHLrcK7v98VTHcsp0E+y8XbdwP5RwD0WwgWL2o0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7rZTPAT0gEHyEj2BGoOmE0ex1yRgX9Y7rkCasrlSear/w5e7Nt+uw1ZeXYWi2KUb
         /ZbFtFTa804+yGKSjj+bcodLz/KBzO0zR/nwMwsqoW/AzNVgIq+3r+Muvn/4GSZFBr
         fu/e2ttYP4ycVWdSgfFS9oDkXRw0hxiU/kPUwcYA+orGgFjCnUgVnedetXAJp1Kbot
         cqTfR++pT87Iib3hWvgv7orzwKsJGSVnbCYcDskBBNTPP4VeQma9gNGFBj789z6D0Z
         ftPFs8G+LPHU95xCGugNhDHawf30A4ycxpS8h0XbrQPs4vWvrKx19XCwYQendraeU8
         esQe+IfLZs9CA==
Date:   Thu, 17 Nov 2022 15:26:48 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v7 4/6] rcu: Add RCU stall diagnosis information
Message-ID: <20221117142648.GF839309@lothringen>
References: <20221111130709.247-1-thunder.leizhen@huawei.com>
 <20221111130709.247-5-thunder.leizhen@huawei.com>
 <20221116223942.GA838972@lothringen>
 <d4f7f41c-e1ef-606f-d700-3e67059bb06d@huawei.com>
 <20221117122238.GC839309@lothringen>
 <54aa07c4-b7e3-1a0e-e6a3-444573caba16@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54aa07c4-b7e3-1a0e-e6a3-444573caba16@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:25:44PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/11/17 20:22, Frederic Weisbecker wrote:
> > On Thu, Nov 17, 2022 at 09:57:18AM +0800, Leizhen (ThunderTown) wrote:
> >>
> >>
> >> On 2022/11/17 6:39, Frederic Weisbecker wrote:
> >>> On Fri, Nov 11, 2022 at 09:07:07PM +0800, Zhen Lei wrote:
> >>>> @@ -262,6 +279,8 @@ struct rcu_data {
> >>>>  	short rcu_onl_gp_flags;		/* ->gp_flags at last online. */
> >>>>  	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
> >>>>  	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
> >>>> +	struct rcu_snap_record snap_record; /* Snapshot of core stats at half of */
> >>>> +					    /* the first RCU stall timeout */
> >>>
> >>> This should be under #ifdef CONFIG_RCU_CPU_STALL_CPUTIME
> >>
> >> This will not work for now because we also support boot option
> >> rcupdate.rcu_cpu_stall_cputime.
> > 
> > I'm confused. If CONFIG_RCU_CPU_STALL_CPUTIME=n then rcupdate.rcu_cpu_stall_cputime has
> > no effect, right?
> 
> No, rcupdate.rcu_cpu_stall_cputime override CONFIG_RCU_CPU_STALL_CPUTIME. Because
> the default value of CONFIG_RCU_CPU_STALL_CPUTIME is n, so in most cases, we need
> rcupdate.rcu_cpu_stall_cputime as the escape route.
> 
> If CONFIG_RCU_CPU_STALL_CPUTIME=y is default, your suggestion is more
> appropriate.

Oh ok I thought it was a support Kconfig switch.

Then please just mention that rcupdate.rcu_cpu_stall_cputime overrides
CONFIG_RCU_CPU_STALL_CPUTIME behaviour in the Kconfig help text.

Thanks.
