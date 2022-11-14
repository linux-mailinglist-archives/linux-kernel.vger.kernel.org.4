Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C22627E65
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbiKNMrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbiKNMrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:47:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BF0B2D;
        Mon, 14 Nov 2022 04:47:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84782B80EAE;
        Mon, 14 Nov 2022 12:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE62C433C1;
        Mon, 14 Nov 2022 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668430022;
        bh=saKhemVd1aOV0PdiOGoeabJGk2c8od3DuuLOsAVNbo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jbddwzQZEm1hVjcV0/Qmp6egyTC2kkyWfkt2WTZt/4Rd38GmRxsB/JSeRPhiv6uxW
         tMTHXv3ssVbOTvVe1S4y3qNVsdMYpbBLqt5LWT0/BBaQrN7DgduNZh2AYwibqu0ZYE
         JsmvWs306v+ot7GEOJjZ5L79kZ0W+syxF2z/6R1T30a6vbWmn5Y81TRMGNQRMFylws
         VorTvz+Vm+D0VoVj7rZhXkRQALrbqjStJh/VLunoc5HcKYEX1mG4xIulYIt1J043Jb
         hS6gDP8/Reo4xgkfCxYVSfl/e8XoOEFPkNfJS3YmYEwEmkrYche8lVTXVPgcuCVUgo
         MC2k5wSzjaXzA==
Date:   Mon, 14 Nov 2022 13:46:59 +0100
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
Message-ID: <20221114124659.GE590078@lothringen>
References: <20221111130709.247-1-thunder.leizhen@huawei.com>
 <20221111130709.247-5-thunder.leizhen@huawei.com>
 <20221114112438.GA472998@lothringen>
 <5f73bb77-e334-d604-d0cd-0ce7af45f209@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f73bb77-e334-d604-d0cd-0ce7af45f209@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 08:32:19PM +0800, Leizhen (ThunderTown) wrote:
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index ed93ddb8203d42c..3921aacfd421ba9 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -866,6 +866,24 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
> >>  			rdp->rcu_iw_gp_seq = rnp->gp_seq;
> >>  			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
> >>  		}
> >> +
> >> +		if (rcu_cpu_stall_cputime && rdp->snap_record.gp_seq != rdp->gp_seq) {
> >> +			int cpu = rdp->cpu;
> >> +			struct rcu_snap_record *rsrp;
> >> +			struct kernel_cpustat *kcsp;
> >> +
> >> +			kcsp = &kcpustat_cpu(cpu);
> >> +
> >> +			rsrp = &rdp->snap_record;
> >> +			rsrp->cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
> >> +			rsrp->cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
> >> +			rsrp->cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
> >> +			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(rdp->cpu);
> >> +			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(rdp->cpu);
> > 
> > Getting the sum of all CPU's IRQs, with even two iterations on all of them, look
> > costly. So I have to ask: why is this information useful and why can't we deduce
> > it from other CPUs stall reports?
> 
> Only the RCU stalled CPUs are recorded. Why all CPUs?

Bah, I misread kstat_cpu_softirqs_sum() kstat_cpu_irqs_sum() content. Sorry
about that, my brainfart... :-)
