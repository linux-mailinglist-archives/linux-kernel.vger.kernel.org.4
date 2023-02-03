Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228E2688E93
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 05:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjBCE3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 23:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBCE3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 23:29:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E4F10FA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 20:29:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA073B827B1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 04:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2938C433EF;
        Fri,  3 Feb 2023 04:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675398544;
        bh=eYbq0SC1PyTkqvcTGRv8dNRuMeaKujrIMTopEEytvcU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aTKBq9aySB7K27v+Z42vUQQrew8j6TUpbZpneeafzzu4gM+JycQM8mUWb16+jTjCP
         yDbWoLakZ+KKNsjRHPkyCg7uOPkb8FCWaIVhwAvj3U6WyzMlob21U4WJmgNFQgYuIn
         YE81sFLHNH0EmU1qtlSMcQW1q0PYQ7pB4PnGHXZwfKV7MQH1iBzmTSyLbpwPrK7fk2
         h+hUWgqzg3WF+oOsFFrds369EdHG1A49et56aLvgCnC1OhVyjY0fOqulIuXp1ka/VO
         f7ptrVJqTgUokhRipnhvLJq2xsoO+i7N83LhN6PS7FsqwgNbbadqx1ESiGq+cBSIuG
         J3T/8FeS2OHug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 323D65C0DE7; Thu,  2 Feb 2023 20:29:04 -0800 (PST)
Date:   Thu, 2 Feb 2023 20:29:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC][PATCH 1/4] locktorture: Add nested_[un]lock() hooks and
 nlocks parameter
Message-ID: <20230203042904.GE2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230202223409.2812443-1-jstultz@google.com>
 <20230203020509.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <CANDhNCrSCrCgGDaGstS9=3vEqow=iiF5qWOhbzrstMbD5afXAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCrSCrCgGDaGstS9=3vEqow=iiF5qWOhbzrstMbD5afXAQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 07:56:05PM -0800, John Stultz wrote:
> On Thu, Feb 2, 2023 at 6:05 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Feb 02, 2023 at 10:34:06PM +0000, John Stultz wrote:
> > > In order ot extend locktorture to support lock nesting, add
> > > nested_lock() and nested_unlock() hooks to the torture ops.
> > >
> > > These take a 32bit lockset mask which is generated at random,
> > > so some number of locks will be taken before the main lock is
> > > taken and released afterwards.
> > >
> > > Additionally, add nlocks module parameter to allow specifying
> > > the number of nested locks to be used.
> > >
> > > This has been helpful to uncover issues in the proxy-exec
> > > series development.
> > >
> > > This was inspired by locktorture extensions originally implemented
> > > by Connor O'Brien, for stress testing the proxy-execution series:
> > >   https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/
> > >
> > > Comments or feedback would be greatly appreciated!
> >
> > I have pulled this in for testing and further review, thank you!
> >
> > Should either of these files have a locktorture.nlocks=<whatever>
> > added?
> >
> > tools/testing/selftests/rcutorture/configs/lock/LOCK02.boot
> > tools/testing/selftests/rcutorture/configs/lock/LOCK05.boot
> >
> > The first is for mutex_lock and the second for rtmutex_lock.
> 
> Potentially? I wasn't aware of these files. Is there some
> documentation on the intent behind them?

There is a LOCK02 file that contains Kconfig options and the LOCK02.boot
file contains kernel boot parameters.  There is a CFLIST file that
contains the list of such files that the command below will test by
default.

The best documentation is probably here:

https://paulmck.livejournal.com/57769.html
https://paulmck.livejournal.com/58077.html

> While the nested locking is useful to cause different lock chains to
> test boosting or proxy-execution, I worry they may cause extra noise
> that could distract from just thrashing the *mutex lock primitive if
> that's the existing intent.

The intent is to find bugs by whatever means necessary, within reason.

> So we might want additional config files for the nested case.

That would work.

> > This did pass a quick "torture.sh --do-none --do-locktorture", which is
> > good, but this uses the existing .boot files.
> 
> Yeah, probably no effective change in that case.

At least nothing else got broken.  ;-)

							Thanx, Paul
