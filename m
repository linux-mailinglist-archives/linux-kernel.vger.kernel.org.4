Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B20621BC6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiKHSVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiKHSVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:21:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E121BBDE;
        Tue,  8 Nov 2022 10:21:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A48A8B81BED;
        Tue,  8 Nov 2022 18:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DCEC433C1;
        Tue,  8 Nov 2022 18:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667931697;
        bh=WivBg608EwuEkpMMcwoY2eMo338QcvFPVcdyOYtBcs8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fQxth3NhguGl4JRjEau4ytkdZ9OuCi0m5Oa8yPalGPwNuYR3jqD3f/zBm/XPoCQAM
         x3BIGW5EcHG7d0G2vep6xG1Bea6auPxDonXIlv0c2xAAuDVWIvjZ0u9kUEAV2H/nN9
         mM3DxGamSHBwoIM9MLKnnD+2Wk0w67IzmlMwd1sf4S/l6LyCOkssENcdn1FMIfLbh6
         Q1ZtuJVE/oG3F9M7WL48Wk8kr+aNokZhvOhiE1uQBarhvEFvdE61eikNm1SfFTPJW/
         ABpJep8a5s/QY366WHT7POv05C+HL9VPivRSzMKfmG75Gu/BxjhOMoiG4iLFKIlN8c
         dq/p+Qr+9Ch3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 93C715C1E87; Tue,  8 Nov 2022 10:21:35 -0800 (PST)
Date:   Tue, 8 Nov 2022 10:21:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v5 2/4] sched: Add helper kstat_cpu_softirqs_sum()
Message-ID: <20221108182135.GD3907045@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221104141118.119-1-thunder.leizhen@huawei.com>
 <20221104141118.119-3-thunder.leizhen@huawei.com>
 <bccb731a-f99d-91ab-6dca-c1182d55ff28@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bccb731a-f99d-91ab-6dca-c1182d55ff28@quicinc.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 08:00:56PM +0530, Mukesh Ojha wrote:
> Hi,
> 
> On 11/4/2022 7:41 PM, Zhen Lei wrote:
> > Similar to kstat_cpu_irqs_sum(), it counts the sum of all software
> > interrupts on a specified CPU.
> > 
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > ---
> >   include/linux/kernel_stat.h | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> > index 90e2fdc17d79ff8..898076e173a928a 100644
> > --- a/include/linux/kernel_stat.h
> > +++ b/include/linux/kernel_stat.h
> > @@ -67,6 +67,17 @@ static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
> >          return kstat_cpu(cpu).softirqs[irq];
> >   }
> 
> One header comment would have been good.

No argument, except that the other functions in this file are also quite
innocent of header comments.  :-/

I have no idea what the maintainer(s) of this code would think of a
separate patch supplying the header comments.

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
> > +
> >   /*
> >    * Number of interrupts per specific IRQ source, since bootup
> >    */
> 
> LGTM.
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

Applied all three, thank you!

							Thanx, Paul
