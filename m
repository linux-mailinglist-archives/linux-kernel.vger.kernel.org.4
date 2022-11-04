Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B96619851
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiKDNnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiKDNnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:43:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBA22EF78;
        Fri,  4 Nov 2022 06:43:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 222AF621CC;
        Fri,  4 Nov 2022 13:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F090C433D7;
        Fri,  4 Nov 2022 13:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667569396;
        bh=LPyJaxaOHK4G2D48z6wF/Zc06S5BTDosBA89vgZ2y4k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kE3AnVQtlAjHQl05ZDPcMaE+T3APoJ27ZAZUYt/YvUuX/mVuIe6HprPEmjDzodfBb
         zTuFmevsVGQaiY1ftU/vc9OpHLHIwBH4sfHyMlKmZN/D12jkAY2diSb0KFO2yrJcDQ
         LEjpp4T8MfWtnSgCqb/Cj4D1BPpusw60rVtfNpjl3GXh9FvvOafHPjfzYCF2cqOn9S
         cU1O/q903X2p3c+46N+G8Su3NcHU0FBvaglL3cwUb+/DIGi0NDwxBsp+DDTPoJzi3A
         SdvXqhrSk9xddhvyylZYplxG9iSdAMdRgAufXMJNZwetEyhRxHyUgUAHbFkoGlZiIp
         +SyXxuawWpwSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 22EDC5C0A0A; Fri,  4 Nov 2022 06:43:16 -0700 (PDT)
Date:   Fri, 4 Nov 2022 06:43:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
Message-ID: <20221104134316.GM5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
 <20221104021224.102-5-thunder.leizhen@huawei.com>
 <311242b9-e61c-376f-4db1-f3d6b30ec84e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <311242b9-e61c-376f-4db1-f3d6b30ec84e@huawei.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 11:12:02AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/11/4 10:12, Zhen Lei wrote:
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index d4a97e40ea9c3e2..44d49819a31f050 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -158,6 +158,22 @@ union rcu_noqs {
> >  	u16 s; /* Set of bits, aggregate OR here. */
> >  };
> >  
> > +/*
> > + * Record the snapshot of the core stats at 1/2 rcu stall timeout. The member
> > + * gp_seq is used to ensure that all members are updated only once during the
> > + * second half period. The snapshot is taken only if this gp_seq is not equal
> > + * to rdp->gp_seq.
> > + */
> > +struct rcu_snap_record {
> > +	unsigned long	gp_seq;		/* Track rdp->gp_seq counter */
> > +	u64		cputime_irq;	/* Accumulated cputime of hard irqs */
> > +	u64		cputime_softirq;/* Accumulated cputime of soft irqs */
> > +	u64		cputime_system; /* Accumulated cputime of kernel tasks */
> > +	unsigned long	nr_hardirqs;	/* Accumulated number of hard irqs */
> > +	unsigned int	nr_softirqs;	/* Accumulated number of soft irqs */
> > +	unsigned long long nr_csw;	/* Accumulated number of task switches */
> > +};
> > +
> >  /* Per-CPU data for read-copy update. */
> >  struct rcu_data {
> >  	/* 1) quiescent-state and grace-period handling : */
> > @@ -262,6 +278,7 @@ struct rcu_data {
> >  	short rcu_onl_gp_flags;		/* ->gp_flags at last online. */
> >  	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
> >  	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
> > +	struct rcu_snap_record snap_record; /* Snapshot of core stats at 1/2 rcu stall timeout */
> >  
> >  	int cpu;
> >  };
> 
> Sorry, I forgot to update linux-rcu.git. There is a conflict here.
> 
> ----------------
>  	int cpu;
>   };
> ------------should be--------
>  	long lazy_len;			/* Length of buffered lazy callbacks. */
>  	int cpu;
> ----------------

Not a problem!  Looks good otherwise.

So please just rebase your series onto -rcu and repost.

							Thanx, Paul
