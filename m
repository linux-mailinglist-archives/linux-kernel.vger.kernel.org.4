Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF56636D07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiKWWZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiKWWZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:25:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA40FF42C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:25:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 564FCB8246A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5FCC433C1;
        Wed, 23 Nov 2022 22:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669242346;
        bh=brVhZ/m5myoMxd89EQKefX1ZIC3YN8XJGn04cIPW2IM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/fwitokwe4NqytFop4Z+ANdsCav18Ke9taxc5wCl42sdWGsHPje6aKA9P8IKqWlh
         d7MUyM8px4DAN+FhcwbvGkHrvM5ojxe6DBP4JfLjgjl27H2vVkFnCV9GuwFrCkYmBe
         8/hBGREvRxBJt6eCt3FYtThJoa3pk/rZfqR2Si/rKixGIWImTaMUUQNlDyYCqYfWbj
         MdsvGP0bhZHdftFjI9Hjbz2RlEN4klFhArt4eEEeB9E0940ZYEoTvi/YEmYMcmrpfw
         jcNycitroN15bGxr6WMaZHUm49ktKTNapvCM5Zj9W7yw0iY2fGOHdyfg84iQOdZaEM
         lqaKV/M2euOEw==
Date:   Wed, 23 Nov 2022 23:25:43 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>, fweisbec@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, dave@stgolabs.net,
        josh@joshtriplett.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next][RFC]torture: avoid offline tick_do_timer_cpu
Message-ID: <20221123222543.GB1395324@lothringen>
References: <20221121035140.118651-1-zhouzhouyi@gmail.com>
 <20221122013754.GY4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122013754.GY4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 05:37:54PM -0800, Paul E. McKenney wrote:
> On Mon, Nov 21, 2022 at 11:51:40AM +0800, Zhouyi Zhou wrote:
> > @@ -358,7 +359,16 @@ torture_onoff(void *arg)
> >  			schedule_timeout_interruptible(HZ / 10);
> >  			continue;
> >  		}
> > +#ifdef CONFIG_NO_HZ_FULL
> > +		/* do not offline tick do timer cpu */
> > +		if (tick_nohz_full_running) {
> > +			cpu = (torture_random(&rand) >> 4) % maxcpu;
> > +			if (cpu >= tick_do_timer_cpu)
> 
> Why is this ">=" instead of "=="?
> 
> > +				cpu = (cpu + 1) % (maxcpu + 1);
> > +		} else
> > +#else
> >  		cpu = (torture_random(&rand) >> 4) % (maxcpu + 1);
> > +#endif
> 
> What happens if the value of tick_do_timer_cpu changes between the time of
> the check above and the call to torture_offline() below?  Alternatively,
> how is such a change in value prevented?

It can't, currently tick_do_timer_cpu is fixed when nohz_full is running.
It can however have special values at early boot such as TICK_DO_TIMER_NONE.
But if rcutorture is initialized after smp, it should be ok.

Thanks.

> 
> 							Thanx, Paul
> 
> >  		if (!torture_offline(cpu,
> >  				     &n_offline_attempts, &n_offline_successes,
> >  				     &sum_offline, &min_offline, &max_offline))
> > -- 
> > 2.34.1
> > 
