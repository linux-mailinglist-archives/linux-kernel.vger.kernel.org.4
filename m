Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA6E66624A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjAKRvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjAKRvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:51:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B202DFE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:50:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C646B81BB2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4834C433F1;
        Wed, 11 Jan 2023 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673459456;
        bh=GpVC1Dzk0i09V4IPVyIyOyfYZGn4q0Ab9WKeG6xG8rg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rFEZ7P2U3oDglrsnTLUpTns6xNCYVIiJktusTB1ryoWoAL2zjtv489xgLKBaEcxCl
         z6rUByvRrKNGYPrq/zfdUTU20MRCB4bUm5e75LyVgRZf+MDiXh6relG7tHknjJeNsg
         JjDL5PG475BFjn28wqrN+zmha1xm/MoKwDwWuQOAMXBxOtVPBNLPFmzuFFqV63e+Fu
         78+WjpBb7uIxNEqBhO7OEqYDTYxE4hh2AcAUdC0RhOKrt1w7l4l+TriCWVeIHYFiFm
         aC0TyD6mtal/AKPpNlk22u2STFfrKmgYEAbiLkxn3UfQrdUFNWMiXV87nD1AyFP53K
         X3LcfJeFZtiZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 67C445C0920; Wed, 11 Jan 2023 09:50:56 -0800 (PST)
Date:   Wed, 11 Jan 2023 09:50:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Waiman Long <longman@redhat.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [PATCH clocksource 5/6] clocksource: Suspend the watchdog
 temporarily when high read latency detected
Message-ID: <20230111175056.GW4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105010429.GA1773522@paulmck-ThinkPad-P17-Gen-1>
 <20230105010701.1773895-5-paulmck@kernel.org>
 <87r0w1ia65.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0w1ia65.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 12:26:58PM +0100, Thomas Gleixner wrote:
> On Wed, Jan 04 2023 at 17:07, Paul E. McKenney wrote:
> > This can be reproduced by running memory intensive 'stream' tests,
> > or some of the stress-ng subcases such as 'ioport'.
> >
> > The reason for these issues is the when system is under heavy load, the
> > read latency of the clocksources can be very high.  Even lightweight TSC
> > reads can show high latencies, and latencies are much worse for external
> > clocksources such as HPET or the APIC PM timer.  These latencies can
> > result in false-positive clocksource-unstable determinations.
> >
> > Given that the clocksource watchdog is a continual diagnostic check with
> > frequency of twice a second, there is no need to rush it when the system
> > is under heavy load.  Therefore, when high clocksource read latencies
> > are detected, suspend the watchdog timer for 5 minutes.
> 
> We should have enough heuristics in place by now to qualify the output of
> the clocksource watchdog as a random number generator, right?

Glad to see that you are still keeping up your style, Thomas!  ;-)

We really do see the occasional clocksource skew in our fleet, and
sometimes it really is the TSC that is in disagreement with atomic-clock
time.  And the watchdog does detect these, for example, the 40,000
parts-per-million case discussed recently.  We therefore need a way to
check this, but without producing false positives on busy systems and
without the current kneejerk reflex of disabling TSC, thus rendering the
system useless from a performance standpoint for some important workloads.

Yes, if a system was 100% busy forever, this patch would suppress these
checks.  But 100% busy forever is not the common case, due to thermal
throttling and to security updates if nothing else.

With all that said, is there a better way to get the desired effects of
this patch?

							Thanx, Paul
