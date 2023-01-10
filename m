Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C8E664E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjAJVaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjAJV3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:29:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D61A63391
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:29:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC5D4618FA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 21:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDF9C433EF;
        Tue, 10 Jan 2023 21:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673386162;
        bh=6+0OY8eUYpnCAeEqKfz88uzJm0W2jlnfnve5G0tlpk8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IqoIMsAxT28m+/Q7W7S8CqmFHcUBnkOPgIullHDPKxN89TmxqFrk8/j5i0UBJjOTx
         XBMn+rjiFSegLz9XQVEQ3k9vBxrVKn46zLedd84X2apDReTLvMiQy9cp+seT2Q0klK
         eBcwes3wNb0uxlgN7IkwpDokOsHZNu0Rhl7YQQz9dcy0w65avlu7bhuV1ts9q9eT3/
         A2so/43gPYtijEXUScN1ci9xUOdQqUlzDPnLFY8LUTb/8/F47HML/PzJzumspCw4Hb
         x+M+eRAtRQVEA6qIJJTp4Wa3jzXT4m+CV92DTbYPYRSuyAzIHqwyJhZ0vcruQ7YlMg
         icZUAAIh0woGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D669A5C0687; Tue, 10 Jan 2023 13:29:21 -0800 (PST)
Date:   Tue, 10 Jan 2023 13:29:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 0/4] nolibc: add support for the s390 platform
Message-ID: <20230110212921.GR4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230109080910.26594-1-w@1wt.eu>
 <20230109191534.GU4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230110073242.GB3229@1wt.eu>
 <20230110092517.GA4626@1wt.eu>
 <20230110145334.GL4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230110161249.GB4649@1wt.eu>
 <20230110163210.GP4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230110175347.GC4649@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110175347.GC4649@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 06:53:47PM +0100, Willy Tarreau wrote:
> On Tue, Jan 10, 2023 at 08:32:10AM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 10, 2023 at 05:12:49PM +0100, Willy Tarreau wrote:
> > > On Tue, Jan 10, 2023 at 06:53:34AM -0800, Paul E. McKenney wrote:
> > > > Here is one of them, based on both the fixes and Sven's s390 support.
> > > > Please let me know if you need any other combination.
> > > 
> > > Thanks, here's the problem:
> > > 
> > > > 0 getpid = 1                             [OK]
> > > > 1 getppid = 0                            [OK]
> > > > 3 gettid = 1                             [OK]
> > > > 5 getpgid_self = 0                       [OK]
> > > > 6 getpgid_bad = -1 ESRCH                 [OK]
> > > > 7 kill_0[    1.940442] tsc: Refined TSC clocksource calibration: 2399.981 MHz
> > > > [    1.942334] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x229825a5278, max_idle_ns: 440795306804 ns
> > > >  = 0                             [OK]
> > > > 8 kill_CONT = 0           [    1.944987] clocksource: Switched to clocksource tsc
> > > >                [OK]
> > > > 9 kill_BADPID = -1 ESRCH                 [OK]
> > > (...)
> > > 
> > > It's clear that "grep -c ^[0-9].*OK" will not count all of them (2 are
> > > indeed missing).
> > > 
> > > We could probably start with "quiet" but that would be against the
> > > principle of using this to troubleshoot issues. I think we just stick
> > > to the current search of "FAIL" and that as long as a success is
> > > reported and the number of successes is within the expected range
> > > that could be OK. At least I guess :-/
> > 
> > Huh.  Would it make sense to delay the start of the nolibc testing by a
> > few seconds in order to avoid this sort of thing?  Or would that cause
> > other problems?
> 
> That would be quite annoying. Delaying is never long enough for some
> issues, too long for the majority of cases where there is no issue. I'd
> suggest that we just rely on the fail count for now (as it is) and that
> will allow us to collect a larger variety of discrepancies and probably
> figure a better solution at some point. For example if we find that it's
> always the TSC that does this, maybe starting x86 with notsc will be a
> good fix.

Sounds good to me!

							Thanx, Paul
