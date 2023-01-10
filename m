Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA396645B9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbjAJQNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238413AbjAJQNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:13:02 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CC0953729
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:13:01 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30AGCna3006955;
        Tue, 10 Jan 2023 17:12:49 +0100
Date:   Tue, 10 Jan 2023 17:12:49 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 0/4] nolibc: add support for the s390 platform
Message-ID: <20230110161249.GB4649@1wt.eu>
References: <20230109080910.26594-1-w@1wt.eu>
 <20230109191534.GU4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230110073242.GB3229@1wt.eu>
 <20230110092517.GA4626@1wt.eu>
 <20230110145334.GL4028633@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110145334.GL4028633@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 06:53:34AM -0800, Paul E. McKenney wrote:
> Here is one of them, based on both the fixes and Sven's s390 support.
> Please let me know if you need any other combination.

Thanks, here's the problem:

> 0 getpid = 1                             [OK]
> 1 getppid = 0                            [OK]
> 3 gettid = 1                             [OK]
> 5 getpgid_self = 0                       [OK]
> 6 getpgid_bad = -1 ESRCH                 [OK]
> 7 kill_0[    1.940442] tsc: Refined TSC clocksource calibration: 2399.981 MHz
> [    1.942334] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x229825a5278, max_idle_ns: 440795306804 ns
>  = 0                             [OK]
> 8 kill_CONT = 0           [    1.944987] clocksource: Switched to clocksource tsc
>                [OK]
> 9 kill_BADPID = -1 ESRCH                 [OK]
(...)

It's clear that "grep -c ^[0-9].*OK" will not count all of them (2 are
indeed missing).

We could probably start with "quiet" but that would be against the
principle of using this to troubleshoot issues. I think we just stick
to the current search of "FAIL" and that as long as a success is
reported and the number of successes is within the expected range
that could be OK. At least I guess :-/

Thanks,
Willy
