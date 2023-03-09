Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADAF6B2FE1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjCIVxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCIVxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:53:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C5EE9F3E;
        Thu,  9 Mar 2023 13:53:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00486B82086;
        Thu,  9 Mar 2023 21:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36BBC433D2;
        Thu,  9 Mar 2023 21:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678398819;
        bh=gVe1cUDO+WBMiAC5mO7jr7DaRL2AjwTZFRI6YpgQqZ0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=p1iXQEvhXdm69RHcbiLRx/MV2wuTmn1H1YOs1H2JGBvtUDFHoC/guGthLp8ceaZa5
         3G3U9zeyDTmfAdfyhwCpNP7N/YLUodc1uyef+xiS5+6KXL2tMvLeuUVLODb7Qmzwfh
         5ACdq+KKj9OX27evXxBXqK8k086JFd52EIHQkuHQkPKRkB4F5jyXT/btsOTVVbzY+s
         jmqbU9I2PnbVC1iNevBvHFDsqwFtW5FBT3yhGP9SseZA5IwrH1cDdntkF1dK61+fP9
         SsOSvkSIe7KZUf8+QDKZb2Lo5ubdt0RtYizcQSCKKPq/xkQU4+t5gKgfbMC+OyZAEW
         u34BxpLmyqdZQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3C3381548D6B; Thu,  9 Mar 2023 13:53:39 -0800 (PST)
Date:   Thu, 9 Mar 2023 13:53:39 -0800
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
Message-ID: <1a4b1362-defb-4464-9217-32e6d3d4a8d2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <20230304010251.GD1301832@paulmck-ThinkPad-P17-Gen-1>
 <IA1PR11MB617141A98ADB1F301FCA07E589B69@IA1PR11MB6171.namprd11.prod.outlook.com>
 <20230306144950.GR1301832@paulmck-ThinkPad-P17-Gen-1>
 <IA1PR11MB61710CDB2B6B47118832770E89B79@IA1PR11MB6171.namprd11.prod.outlook.com>
 <20230307152226.GG1301832@paulmck-ThinkPad-P17-Gen-1>
 <IA1PR11MB61714CDAF82F337B0A384BAA89B59@IA1PR11MB6171.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB61714CDAF82F337B0A384BAA89B59@IA1PR11MB6171.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 03:17:09PM +0000, Zhuo, Qiuxu wrote:
> > From: Paul E. McKenney <paulmck@kernel.org>
> > [...]
> > >
> > > a's standard deviation is ~0.4.
> > > b's standard deviation is ~0.5.
> > >
> > > a's average 9.0 is at the upbound of the standard deviation of b's [8.0, 9].
> > > So, the measurements should be statistically significant to some degree.
> > 
> > That single standard deviation means that you have 68% confidence that the
> > difference is real.  This is not far above the 50% leval of random noise.
> > 95% is the lowest level that is normally considered to be statistically
> > significant.
> 
> 95% means there is no overlap between two standard deviations of a
> and two standard deviations of b.
> 
> This relies on either much less noise during testing or a big enough 
> difference between a and b. 
> 
> > > The calculated standard deviations are via:
> > > https://www.gigacalculator.com/calculators/standard-deviation-calculat
> > > or.php
> > 
> > Fair enough.  Formulas are readily available as well, and most spreadsheets
> > support standard deviation.
> > 
> > [...]
> >
> > > > Why don't you try applying this approach to the new data?  You will
> > > > need the general binomial formula.
> > >
> > >    Thank you Paul for the suggestion.
> > >    I just tried it, but not sure whether my analysis was correct ...
> > >
> > >    Analysis 1:
> > >    a's median is 8.9.
> > 
> > I get 8.95, which is the average of the 24th and 25th members of a in
> > numerical order.
> 
> Yes, it should be 8.95. Thanks for correcting me. 
> 
> > >    35/48 b's data points are less than 0.1 less than a's median.
> > >    For a's binomial distribution P(X >= 35) = 0.1%, where p=0.5.
> > >    So, we have strong confidence that b is 100ms faster than a.
> > 
> > I of course get quite a bit stronger confidence, but your 99.9% is good
> > enough.  And I get even stronger confidence going in the other direction.
> > However, the fact that a's median varies from 8.7 in the old experiment to
> > 8.95 in this experiment does give some pause.  These are after all supposedly
> > drawn from the same distribution.  Or did you use a different machine or
> > different OS version or some such in the two sets of measurements?
> > Different time of day and thus different ambient temperature, thus different
> > CPU clock frequency?
> 
> All the testing setups were identical except for the testing time. 
> 
>       Old a median   : 8.7
>       New a median : 8.95
> 
>       Old b median   : 8.2
>       New b median : 8.45
> 
> I'm a bit surprised that both new medians are exactly greater 0.25 more than 
> the old medians.  Coincidence?

Possibly some semi-rare race condition makes boot take longer, and 48
boots has a higher probability of getting more of them?  But without
analyzing the boot sequence, your guess is as good as mine.

> > Assuming identical test setups, let's try the old value of 8.7 from old a to new
> > b.  There are 14 elements in new b greater than 8.6, for a probability of
> > 0.17%, or about 98.3% significance.  This is still OK.
> > 
> > In contrast, the median of the old b is 8.2, which gives extreme confidence.
> > So let's be conservative and use the large-set median.
> > 
> > In real life, additional procedures would be needed to estimate the
> > confidence in the median, which turns oout to be nontrivial.  When I apply
> 
> Luckily, I could just simply pick up the medians in numerical order in this case. ;-)
> 
> > this sort of technique, I usually have all data from each sample being on one
> > side of the median of the other, which simplifies things.  ;-)
> 
> I like all data points are on one side of the median of the other ;-)
> 
> But this also relies on either much less noise during testing or a big enough 
> difference between a and b, right?

Yes, life is indeed *much* easier when there is less noise or larger
differences.  ;-)

> > The easiest way to estimate bounds on the median is to "bootstrap", but that
> > works best if you have 1000 samples and can randomly draw 1000 sub-
> > samples each of size 10 from the larger sample and compute the median of
> > each.  You can sort these medians and obtain a cumulative distribution.
> 
> Good to know "bootstap".
> 
> > But you have to have an extremely good reason to collect data from 1000
> > boots, and I don't believe we have that good of a reason.
> >
> 
> 1000 boots, Oh my ...
> No. No. I don't have a good reason for that ;-)
> 
> > >    Analysis 2:
> > >    a's median - 0.4 = 8.9 - 0.4 = 8.5.
> > >    24/48 b's data points are less than 0.4 less than a's median.
> > >    The probability that a's data points are less than 8.5 is p = 7/48
> > > = 0.1458
> > This is only 85.4% significant, so...
> > 
> > >    For a's binomial distribution P(X >= 24) = 0.0%, where p=0.1458.
> > >    So, looks like we have confidence that b is 400ms faster than a.
> > 
> > ...we really cannot say anything about 400ms faster.  Again, you need 95%
> > and preferably 99% to really make any sort of claim.  You probably need
> > quite a few more samples to say much about 200ms, let alone 400ms.
> 
> OK. Thanks for correcting me. 
> 
> > Plus, you really should select the speedup and only then take the
> > measurements.  Otherwise, you end up fitting noise.
> > 
> > However, assuming identical tests setups, you really can calculate the median
> > from the full data set.
> > 
> > >    The calculated cumulative binomial distributions P(X) is via:
> > >
> > > https://www.gigacalculator.com/calculators/binomial-probability-calcul
> > > ator.php
> > 
> > The maxima program's binomial() function agrees with it, so good.  ;-)
> > 
> > >    I apologize if this analysis/discussion bored some of you. ;-)
> > 
> > Let's just say that it is a lot simpler when you are measuring larger
> > differences in data with tighter distributions.  Me, I usually just say "no" to
> > drawing any sort of conclusion from data sets that overlap this much.
> > Instead, I might check to see if there is some random events adding noise to
> > the boot duration, eliminate that, and hopefully get data that is easier to
> > analyze.
> 
> Agree. 
> 
> > But I am good with the 98.3% confidence in a 100ms improvement.
> > 
> > So if Joel wishes to make this point, he should feel free to take both of your
> > datasets and use the computation with the worse mean.
> 
> Thank you so much Paul for your patience and detailed 

And thank you for bearing with me.

							Thanx, Paul
