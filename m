Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB16119B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJ1R5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJ1R5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFFC1EA57D;
        Fri, 28 Oct 2022 10:57:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D10E0629A0;
        Fri, 28 Oct 2022 17:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A06C433D7;
        Fri, 28 Oct 2022 17:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666979830;
        bh=C9+YCGC1n24X+HLB2Ag9bB27vqjvZDxZ4l2jLCIpHnM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g5p2QmVPjiHfDV6KtfaHaTaEyksRUljwjIsdl9/TCabZ3VwoXaqr86R5N6vEM529m
         33eVMtGmwT3U+MzwIVKTYnI7UHYijLsFSYj2Q3seospsZxA4WJ46iBRj+Sa8tuqnTu
         QPyCPGbrsNDzYprPSwgEF621KxZ4hZRuded3ezWRIxjRenmDCuWVtX+9iJYkj05K3T
         u53wukn8SIReKPu+UD/Hec9vXyDWVj++yb8g6kX/jFR423bRjk6BzQAt7i1cOODgGw
         Luc4eqheG936kyU6zZm9l+/w9IiIbmuYmSAriECqm9Yxh/iq5S+yYwCzfsntjaxt4G
         fA3tSt9xbeW1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DDBB25C0692; Fri, 28 Oct 2022 10:57:09 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:57:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] sched: Add helper kstat_cpu_softirqs_sum()
Message-ID: <20221028175709.GP5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221022124525.2080-1-thunder.leizhen@huawei.com>
 <20221022124525.2080-2-thunder.leizhen@huawei.com>
 <MW5PR84MB18423C3F30D3F789EB48D0A5AB339@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR84MB18423C3F30D3F789EB48D0A5AB339@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 07:04:53PM +0000, Elliott, Robert (Servers) wrote:
> 
> > Similar to kstat_cpu_irqs_sum(), it counts the sum of all software
> > interrupts on a specified CPU.
> > 
> > diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> > @@ -67,6 +67,17 @@ static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
> >         return kstat_cpu(cpu).softirqs[irq];
> >  }
> > 
> > +static inline unsigned int kstat_cpu_softirqs_sum(int cpu)
> > +{
> > +	int i;
> > +	unsigned int sum = 0;
> > +
> > +	for (i = 0; i < NR_SOFTIRQS; i++)
> > +		sum += kstat_softirqs_cpu(i, cpu);
> > +
> > +	return sum;
> > +}
> 
> In the function upon which this is based:
> 
> irqs_sumstruct kernel_stat {
>         unsigned long irqs_sum;
>         unsigned int softirqs[NR_SOFTIRQS];
> };
> 
> static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
> {
>         return kstat_cpu(cpu).irqs_sum;
> }
> 
> kstat_cpu_irqs_sum returns an unsigned long as an unsigned int, which
> could cause large values to be truncated. Should that return
> unsigned long? The only existing caller is fs/proc/stat.c which
> puts it into a u64:
>         u64 sum = 0;
>         ...
>         sum             += kstat_cpu_irqs_sum(i);
> 
> The softirqs field is an unsigned int, so the new function doesn't have
> this inconsistency.

Good point!

Zhen Lei, thoughts?

							Thanx, Paul
