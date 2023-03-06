Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623156AC3DE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjCFOun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjCFOu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:50:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152BB28841;
        Mon,  6 Mar 2023 06:50:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6AF9B80EAB;
        Mon,  6 Mar 2023 14:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8651EC433D2;
        Mon,  6 Mar 2023 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678114190;
        bh=TE0W+LaMhDGxS/vr7StqcQQsX7jPg1CK3evY/RWpwVk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RFbnWAly9D67z4evYHgo1ae0juUFrCYym8+73f1ySC7zFrLxbpIKET/CrQ/cWTGwa
         8TkBJpDMp+NAAWR93IyulbespqFMv4n4OgDc4RZZq02NhmMxEcikCgDrpqyU/ffzij
         hV3RaS2RY6+IyNNIFac2FNEBp1dofxM9R4u7+ONWVCw5TYxyIOKyIpX8Vy6He479lo
         zzfa0v8VFxZqWjlXCwi7Rg5KQEjddniak6QmEx+/IvJf/SO/4vzMGIxtWDmycNCbaX
         lWGSypoOVV4JU6laz8uHQ8COqHI2j8YZdr59bgiogRTBd1WethO9PO6E1QunwIY884
         hZC0DR/CbSnxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2A8125C00F1; Mon,  6 Mar 2023 06:49:50 -0800 (PST)
Date:   Mon, 6 Mar 2023 06:49:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <20230306144950.GR1301832@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <20230304010251.GD1301832@paulmck-ThinkPad-P17-Gen-1>
 <IA1PR11MB617141A98ADB1F301FCA07E589B69@IA1PR11MB6171.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA1PR11MB617141A98ADB1F301FCA07E589B69@IA1PR11MB6171.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 08:24:44AM +0000, Zhuo, Qiuxu wrote:
> > From: Paul E. McKenney <paulmck@kernel.org>
> > [...]
> > > Qiuxu also noted impressive boot-time improvements with earlier
> > > version of patch. An excerpt from the data he shared:
> > >
> > > 1) Testing environment:
> > >     OS            : CentOS Stream 8 (non-RT OS)
> > >     Kernel     : v6.2
> > >     Machine : Intel Cascade Lake server (2 sockets, each with 44 logical
> > threads)
> > >     Qemu  args  : -cpu host -enable-kvm, -smp 88,threads=2,sockets=2,
> > > …
> > >
> > > 2) OS boot time definition:
> > >     The time from the start of the kernel boot to the shell command line
> > >     prompt is shown from the console. [ Different people may have
> > >     different OS boot time definitions. ]
> > >
> > > 3) Measurement method (very rough method):
> > >     A timer in the kernel periodically prints the boot time every 100ms.
> > >     As soon as the shell command line prompt is shown from the console,
> > >     we record the boot time printed by the timer, then the printed boot
> > >     time is the OS boot time.
> > >
> > > 4) Measured OS boot time (in seconds)
> > >    a) Measured 10 times w/o this patch:
> > >         8.7s, 8.4s, 8.6s, 8.2s, 9.0s, 8.7s, 8.8s, 9.3s, 8.8s, 8.3s
> > >         The average OS boot time was: ~8.7s
> > >
> > >    b) Measure 10 times w/ this patch:
> > >         8.5s, 8.2s, 7.6s, 8.2s, 8.7s, 8.2s, 7.8s, 8.2s, 9.3s, 8.4s
> > >         The average OS boot time was: ~8.3s.
> > 
> > Unfortunately, given that a's average is within one standard deviation of b's
> > average, this is most definitely not statistically significant.
> > Especially given only ten measurements for each case -- you need *at*
> > *least* 24, preferably more.  Especially in this case, where you don't really
> > know what the underlying distribution is.
> 
> Thank you so much Paul for the detailed comments on the measured data.
> 
> I'm curious how did you figure out the number 24 that we at *least* need.
> This can guide me on whether the number of samples is enough for 
> future testing ;-).

It is a rough rule of thumb.  For more details and accuracy, study up
on the Student's t-test and related statistical tests.

Of course, this all assumes that the data fits a normal distribution.

> I did another 48 measurements (2x of 24) for each case 
> (w/o and w/ Joel's v2 patch) as below. 
> All the testing configurations for the new testing
> are the same as before.
> 
> a) Measured 48 times w/o v2 patch (in seconds):
>     8.4, 8.8, 9.2, 9.0, 8.3, 9.6, 8.8, 9.4,
>     8.7, 9.2, 8.3, 9.4, 8.4, 9.6, 8.5, 8.8,
>     8.8, 8.9, 9.3, 9.2, 8.6, 9.7, 9.2, 8.8,
>     8.7, 9.0, 9.1, 9.5, 8.6, 8.9, 9.1, 8.6,
>     8.2, 9.1, 8.8, 9.2, 9.1, 8.9, 8.4, 9.0,
>     9.8, 9.8, 8.7, 8.8, 9.1, 9.5, 9.5, 8.7
>     The average OS boot time was: ~9.0s

The range is 8.2 through 9.8.

> b) Measure 48 times w/ v2 patch (in seconds):
>     7.7, 8.6, 8.1, 7.8, 8.2, 8.2, 8.8, 8.2,
>     9.8, 8.0, 9.2, 8.8, 9.2, 8.5, 8.4, 9.2,
>     8.5, 8.3, 8.1, 8.3, 8.6, 7.9, 8.3, 8.3,
>     8.6, 8.9, 8.0, 8.5, 8.4, 8.6, 8.7, 8.0,
>     8.8, 8.8, 9.1, 7.9, 9.7, 7.9, 8.2, 7.8,
>     8.1, 8.5, 8.6, 8.4, 9.2, 8.6, 9.6, 8.3,
>     The average OS boot time was: ~8.5s

The range is 7.7 through 9.8.

There is again significant overlap, so it is again unclear that you have
a statistically significant difference.  So could you please calculate
the standard deviations?

> @Joel Fernandes (Google), you may replace my old data with the above 
> new data in your commit message.
> 
> > But we can apply the binomial distribution instead of the usual normal
> > distribution.  First, let's sort and take the medians:
> > 
> > a: 8.2 8.3 8.4 8.6 8.7 8.7 8.8 8.8 9.0 9.3  Median: 8.7
> > b: 7.6 7.8 8.2 8.2 8.2 8.2 8.4 8.5 8.7 9.3  Median: 8.2
> > 
> > 8/10 of a's data points are greater than 0.1 more than b's median and 8/10
> > of b's data points are less than 0.1 less than a's median.
> > What are the odds that this happens by random chance?
> > 
> > This is given by sum_0^2 (0.5^10 * binomial(10,i)), which is about 0.055.
> 
> What's the meaning of 0.5 here? Was it the probability (we assume?) that 
> each time b's data point failed (or didn't satisfy) "less than 0.1 less than 
> a's median"?

The meaning of 0.5 is the probability of a given data point being on one
side or the other of the corresponding distribution's median.  This of
course assumes that the median of the measured data matches that of the
corresponding distribution, though the fact that the median is also a
mode of both of the old data sets gives some hope.

The meaning of the 0.1 is the smallest difference that the data could
measure.  I could have instead chosen 0.0 and asked if there was likely
some (perhaps tiny) difference, but instead, I chose to ask if there
was likely some small but meaningful difference.  It is better to choose
the desired difference before measuring the data.

Why don't you try applying this approach to the new data?  You will need
the general binomial formula.

							Thanx, Paul

> > This is not quite 95% confidence, so not hugely convincing, but it is at least
> > close.  Not that this is the confidence that (b) is 100ms faster than (a), not
> > just that (b) is faster than (a).
> > 
> > Not sure that this really carries its weight, but in contrast to the usual
> > statistics based on the normal distribution, it does suggest at least a little
> > improvement.  On the other hand, anyone who has carefully studied
> > nonparametric statistics probably jumped out of the boat several paragraphs
> > ago.  ;-)
> > 
> > A few more questions interspersed below.
> > 
> > 							Thanx, Paul
> > 
> > > Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
