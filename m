Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295BA6AE496
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjCGPZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjCGPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:25:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9C1730;
        Tue,  7 Mar 2023 07:22:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A52CBB81901;
        Tue,  7 Mar 2023 15:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411F4C4339B;
        Tue,  7 Mar 2023 15:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678202547;
        bh=KbIiLNhqeEyzx6niDi9glBJj8B6x8z7c8vaxWx3SMIw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fe7vaQ4Bz3/c6W3/nJz2MCQzPWmjaywHHIMuhK9rzgBF/NTcOWn3RW58y9vtQ8oZd
         ly3MQmteRJKdB8uIJN78MNs7fxUD8vsE0hhUWXHUcSZ9GQVXck340rlsxidLDR/4ol
         F1dTJ7i5qaGz3lmKXxV33SsGk1sNHtlwxki7IKHU/ME4gksur45tTSbhws5RnzLSqh
         iQSuzVj8gaiAxSBlZaiRvkCKfsm2G6lr7XMZaGWAYGygqD8TF0DEv5UR20VFKCDEFn
         CRQwVeOiQhs9GSUeTu8NgKWEb9KPAFmxSs/WWRsFMp+ZyBeosowHazCZlnaycs6sAl
         cHkF0h6RS32cg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D6EB95C01E4; Tue,  7 Mar 2023 07:22:26 -0800 (PST)
Date:   Tue, 7 Mar 2023 07:22:26 -0800
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
Message-ID: <20230307152226.GG1301832@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <20230304010251.GD1301832@paulmck-ThinkPad-P17-Gen-1>
 <IA1PR11MB617141A98ADB1F301FCA07E589B69@IA1PR11MB6171.namprd11.prod.outlook.com>
 <20230306144950.GR1301832@paulmck-ThinkPad-P17-Gen-1>
 <IA1PR11MB61710CDB2B6B47118832770E89B79@IA1PR11MB6171.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB61710CDB2B6B47118832770E89B79@IA1PR11MB6171.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 07:49:49AM +0000, Zhuo, Qiuxu wrote:
> > From: Paul E. McKenney <paulmck@kernel.org>
> > [...]
> > >
> > > Thank you so much Paul for the detailed comments on the measured data.
> > >
> > > I'm curious how did you figure out the number 24 that we at *least* need.
> > > This can guide me on whether the number of samples is enough for
> > > future testing ;-).
> > 
> > It is a rough rule of thumb.  For more details and accuracy, study up on the
> > Student's t-test and related statistical tests.
> > 
> > Of course, this all assumes that the data fits a normal distribution.
> 
> Thanks for this extra information. Good to know the Student's t-test.
> 
> > > I did another 48 measurements (2x of 24) for each case (w/o and w/
> > > Joel's v2 patch) as below.
> > > All the testing configurations for the new testing are the same as
> > > before.
> > >
> > > a) Measured 48 times w/o v2 patch (in seconds):
> > >     8.4, 8.8, 9.2, 9.0, 8.3, 9.6, 8.8, 9.4,
> > >     8.7, 9.2, 8.3, 9.4, 8.4, 9.6, 8.5, 8.8,
> > >     8.8, 8.9, 9.3, 9.2, 8.6, 9.7, 9.2, 8.8,
> > >     8.7, 9.0, 9.1, 9.5, 8.6, 8.9, 9.1, 8.6,
> > >     8.2, 9.1, 8.8, 9.2, 9.1, 8.9, 8.4, 9.0,
> > >     9.8, 9.8, 8.7, 8.8, 9.1, 9.5, 9.5, 8.7
> > >     The average OS boot time was: ~9.0s
> > 
> > The range is 8.2 through 9.8.
> > 
> > > b) Measure 48 times w/ v2 patch (in seconds):
> > >     7.7, 8.6, 8.1, 7.8, 8.2, 8.2, 8.8, 8.2,
> > >     9.8, 8.0, 9.2, 8.8, 9.2, 8.5, 8.4, 9.2,
> > >     8.5, 8.3, 8.1, 8.3, 8.6, 7.9, 8.3, 8.3,
> > >     8.6, 8.9, 8.0, 8.5, 8.4, 8.6, 8.7, 8.0,
> > >     8.8, 8.8, 9.1, 7.9, 9.7, 7.9, 8.2, 7.8,
> > >     8.1, 8.5, 8.6, 8.4, 9.2, 8.6, 9.6, 8.3,
> > >     The average OS boot time was: ~8.5s
> > 
> > The range is 7.7 through 9.8.
> > 
> > There is again significant overlap, so it is again unclear that you have a
> > statistically significant difference.  So could you please calculate the standard
> > deviations?
> 
> a's standard deviation is ~0.4.
> b's standard deviation is ~0.5.
> 
> a's average 9.0 is at the upbound of the standard deviation of b's [8.0, 9].
> So, the measurements should be statistically significant to some degree.

That single standard deviation means that you have 68% confidence that the
difference is real.  This is not far above the 50% leval of random noise.
95% is the lowest level that is normally considered to be statistically
significant.

> The calculated standard deviations are via: 
> https://www.gigacalculator.com/calculators/standard-deviation-calculator.php

Fair enough.  Formulas are readily available as well, and most spreadsheets
support standard deviation.

> > > @Joel Fernandes (Google), you may replace my old data with the above
> > > new data in your commit message.
> > >
> > > > But we can apply the binomial distribution instead of the usual
> > > > normal distribution.  First, let's sort and take the medians:
> > > >
> > > > a: 8.2 8.3 8.4 8.6 8.7 8.7 8.8 8.8 9.0 9.3  Median: 8.7
> > > > b: 7.6 7.8 8.2 8.2 8.2 8.2 8.4 8.5 8.7 9.3  Median: 8.2
> > > >
> > > > 8/10 of a's data points are greater than 0.1 more than b's median
> > > > and 8/10 of b's data points are less than 0.1 less than a's median.
> > > > What are the odds that this happens by random chance?
> > > >
> > > > This is given by sum_0^2 (0.5^10 * binomial(10,i)), which is about 0.055.
> > >
> > > What's the meaning of 0.5 here? Was it the probability (we assume?)
> > > that each time b's data point failed (or didn't satisfy) "less than
> > > 0.1 less than a's median"?
> > 
> > The meaning of 0.5 is the probability of a given data point being on one side
> > or the other of the corresponding distribution's median.  This of course
> > assumes that the median of the measured data matches that of the
> > corresponding distribution, though the fact that the median is also a mode of
> > both of the old data sets gives some hope.
> 
>   Thanks for the detailed comments on the meaning of 0.5 here. :-)
> 
> > The meaning of the 0.1 is the smallest difference that the data could measure.
> > I could have instead chosen 0.0 and asked if there was likely some (perhaps
> > tiny) difference, but instead, I chose to ask if there was likely some small but
> > meaningful difference.  It is better to choose the desired difference before
> > measuring the data.
> 
>   Thanks for the detailed comments on the meaning of 0.1 here. :-)
> 
> > Why don't you try applying this approach to the new data?  You will need the
> > general binomial formula.
> 
>    Thank you Paul for the suggestion. 
>    I just tried it, but not sure whether my analysis was correct ...
> 
>    Analysis 1:
>    a's median is 8.9. 

I get 8.95, which is the average of the 24th and 25th members of a
in numerical order.

>    35/48 b's data points are less than 0.1 less than a's median.
>    For a's binomial distribution P(X >= 35) = 0.1%, where p=0.5.
>    So, we have strong confidence that b is 100ms faster than a.

I of course get quite a bit stronger confidence, but your 99.9% is
good enough.  And I get even stronger confidence going in the other
direction.  However, the fact that a's median varies from 8.7 in the old
experiment to 8.95 in this experiment does give some pause.  These are
after all supposedly drawn from the same distribution.  Or did you use
a different machine or different OS version or some such in the two
sets of measurements?  Different time of day and thus different ambient
temperature, thus different CPU clock frequency?

Assuming identical test setups, let's try the old value of 8.7 from old
a to new b.  There are 14 elements in new b greater than 8.6, for a
probability of 0.17%, or about 98.3% significance.  This is still OK.

In contrast, the median of the old b is 8.2, which gives extreme
confidence.  So let's be conservative and use the large-set median.

In real life, additional procedures would be needed to estimate the
confidence in the median, which turns oout to be nontrivial.  When I apply
this sort of technique, I usually have all data from each sample being
on one side of the median of the other, which simplifies things.  ;-)

The easiest way to estimate bounds on the median is to "bootstrap",
but that works best if you have 1000 samples and can randomly draw 1000
sub-samples each of size 10 from the larger sample and compute the median
of each.  You can sort these medians and obtain a cumulative distribution.
But you have to have an extremely good reason to collect data from 1000
boots, and I don't believe we have that good of a reason.

>    Analysis 2:
>    a's median - 0.4 = 8.9 - 0.4 = 8.5. 
>    24/48 b's data points are less than 0.4 less than a's median.
>    The probability that a's data points are less than 8.5 is p = 7/48 = 0.1458 
This is only 85.4% significant, so...

>    For a's binomial distribution P(X >= 24) = 0.0%, where p=0.1458.
>    So, looks like we have confidence that b is 400ms faster than a.

...we really cannot say anything about 400ms faster.  Again, you need 95%
and preferably 99% to really make any sort of claim.  You probably need
quite a few more samples to say much about 200ms, let alone 400ms.

Plus, you really should select the speedup and only then take the
measurements.  Otherwise, you end up fitting noise.

However, assuming identical tests setups, you really can calculate
the median from the full data set.

>    The calculated cumulative binomial distributions P(X) is via:
>    https://www.gigacalculator.com/calculators/binomial-probability-calculator.php

The maxima program's binomial() function agrees with it, so good.  ;-)

>    I apologize if this analysis/discussion bored some of you. ;-)

Let's just say that it is a lot simpler when you are measuring
larger differences in data with tighter distributions.  Me, I usually
just say "no" to drawing any sort of conclusion from data sets that
overlap this much.

Instead, I might check to see if there is some random events adding
noise to the boot duration, eliminate that, and hopefully get data
that is easier to analyze.

But I am good with the 98.3% confidence in a 100ms improvement.

So if Joel wishes to make this point, he should feel free to take both
of your datasets and use the computation with the worse mean.

							Thanx, Paul
