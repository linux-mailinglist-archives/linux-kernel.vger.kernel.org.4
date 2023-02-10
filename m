Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E971C69267A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 20:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjBJTgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 14:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjBJTgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:36:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0450063109
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:36:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B43CB825D5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 19:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2E1C433EF;
        Fri, 10 Feb 2023 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676057801;
        bh=oN+rsgGSred0f4lbfL61c78DlSbuemL3ohydHAzvL5Y=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=j0WvEGFmVBac8/wz2juo0KiAozoewtq5eldlomiqyeTzcAKI/KRUb1h25xTvSmE71
         cp4NElGOC39IBax9M9G8ho352EVMO2HBbybZvwMipxu3EhJ3a5uvFi6TEt2B43jpVw
         iTLaVUIWJ5dGve9ivu4aBIX1/R5yDMt5qs+ML7Fh4gi3dYw0otYavDTm8pKgDK/4/H
         f0TSw3iqw20SvUF248DKk5ZGzRvDLdZGGJZXERo1PBbC0WqRbxlsH8YMoav0tK7vSU
         n8E7tn22sNgn5iqFM8zYdc0sOKxB+5kToEOVIZCGEUjOdfhTetDjT7MYNe8cRku4Wk
         c+ntVG+wGnr4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BEC365C0A1A; Fri, 10 Feb 2023 11:36:40 -0800 (PST)
Date:   Fri, 10 Feb 2023 11:36:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [GIT PULL v2 clocksource] Clocksource watchdog commits for v6.3
Message-ID: <20230210193640.GA3325193@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Thomas,

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/clocksource.2023.02.06b

for you to fetch changes up to 0051293c533017e2a860e0a0a33517bc40240fff:

  clocksource: Enable TSC watchdog checking of HPET and PMTMR only when requested (2023-02-06 16:38:30 -0800)

This adds commit 0051293c5330 ("clocksource: Enable TSC watchdog checking
of HPET and PMTMR only when requested") to the previous pull request as
discussed here:

https://lore.kernel.org/lkml/20230131012440.GA1251465@paulmck-ThinkPad-P17-Gen-1/

----------------------------------------------------------------
Clocksource watchdog commits for v6.3

This pull request contains the following:

o	Improvements to clocksource-watchdog console messages.

o	Loosening of the clocksource-watchdog skew criteria to match
	those of NTP (500 parts per million, relaxed from 400 parts
	per million).  If it is good enough for NTP, it is good enough
	for the clocksource watchdog.

o	Suspend clocksource-watchdog checking temporarily when high
	memory latencies are detected.	This avoids the false-positive
	clock-skew events that have been seen on production systems
	running memory-intensive workloads.

o	On systems where the TSC is deemed trustworthy, use it as the
	watchdog timesource, but only when specifically requested using
	the tsc=watchdog kernel boot parameter.  This permits clock-skew
	events to be detected, but avoids forcing workloads to use the
	slow HPET and ACPI PM timers.  These last two timers are slow
	enough to cause systems to be needlessly marked bad on the one
	hand, and real skew does sometimes happen on production systems
	running production workloads on the other.  And sometimes it is
	the fault of the TSC, or at least of the firmware that told the
	kernel to program the TSC with the wrong frequency.

o	Add a tsc=revalidate kernel boot parameter to allow the kernel
	to diagnose cases where the TSC hardware works fine, but was told
	by firmware to tick at the wrong frequency.  Such cases are rare,
	but they really have happened on production systems.

----------------------------------------------------------------
Feng Tang (2):
      clocksource: Suspend the watchdog temporarily when high read latency detected
      x86/tsc: Add option to force frequency recalibration with HW timer

Paul E. McKenney (5):
      clocksource: Loosen clocksource watchdog constraints
      clocksource: Improve read-back-delay message
      clocksource: Improve "skew is too large" messages
      clocksource: Verify HPET and PMTMR when TSC unverified
      clocksource: Enable TSC watchdog checking of HPET and PMTMR only when requested

Yunying Sun (1):
      clocksource: Print clocksource name when clocksource is tested unstable

 Documentation/admin-guide/kernel-parameters.txt | 10 ++++
 arch/x86/include/asm/time.h                     |  1 +
 arch/x86/kernel/hpet.c                          |  2 +
 arch/x86/kernel/tsc.c                           | 55 +++++++++++++++++--
 drivers/clocksource/acpi_pm.c                   |  6 ++-
 kernel/time/Kconfig                             |  6 ++-
 kernel/time/clocksource.c                       | 72 +++++++++++++++++--------
 7 files changed, 123 insertions(+), 29 deletions(-)
