Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D10A68215B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjAaBYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAaBYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:24:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279BA21A11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:24:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E6FCB81891
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1306DC433D2;
        Tue, 31 Jan 2023 01:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675128281;
        bh=tIoQ3mGo3qACY5bcEi+ZYv6uYIXGGi2MgJ4tmLqx3wY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=qbmvCp0WpPTUZv3WzmF/W5zZEM9a3fz1R9Rzwj0v/qm7jkH//22Q27wbqUbjv0QTV
         itASKOtEReBC96AwdKYmKyZABSSMo1fn3kHeZ6XT6hSYhyVAIyumASY91LVpZc8H6v
         RbClhXo2+wFlBG3ao1SCUA8xVy01Ia+1O6wM7fWzjCDZJInfjmeJ114AelnHEwPpkY
         hUykR2Y1eftncr5lkXMDRgKthmdjzbNrPJgifvWHizd0pol8B0G+QtSii4V2cO+11k
         Lk0nejuS2pB0LHeZ6ol6ttBmkqpb5fstRGFUDgC9BR0xdMq0RZV4RPHLT20ea1jUPI
         r0vHinGdjIpsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A6B2C5C08D8; Mon, 30 Jan 2023 17:24:40 -0800 (PST)
Date:   Mon, 30 Jan 2023 17:24:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [GIT PULL clocksource] Clocksource watchdog commits for v6.3]
Message-ID: <20230131012440.GA1251465@paulmck-ThinkPad-P17-Gen-1>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/clocksource.2023.01.30a

for you to fetch changes up to 39836ec34f4698cfc80df4b2953e10fb9fa03506:

  x86/tsc: Add option to force frequency recalibration with HW timer (2023-01-24 15:18:36 -0800)

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
	watchdog timesource.  This permits clock-skew events to be
	detected, but avoids forcing workloads to use the slow HPET
	and ACPI PM timers.  These last two timers are slow enough to
	cause systems to be needlessly marked bad on the one hand, and
	real skew does sometimes happen on production systems running
	production workloads on the other.  And sometimes it is the fault
	of the TSC, or at least of the firmware that told the kernel to
	program the TSC with the wrong frequency.

o	Add a tsc=revalidate kernel boot parameter to allow the kernel
	to diagnose cases where the TSC hardware works fine, but was told
	by firmware to tick at the wrong frequency.  Such cases are rare,
	but they really have happened on production systems.

----------------------------------------------------------------
Feng Tang (2):
      clocksource: Suspend the watchdog temporarily when high read latency detected
      x86/tsc: Add option to force frequency recalibration with HW timer

Paul E. McKenney (4):
      clocksource: Loosen clocksource watchdog constraints
      clocksource: Improve read-back-delay message
      clocksource: Improve "skew is too large" messages
      clocksource: Verify HPET and PMTMR when TSC unverified

Yunying Sun (1):
      clocksource: Print clocksource name when clocksource is tested unstable

 Documentation/admin-guide/kernel-parameters.txt |  4 ++
 arch/x86/include/asm/time.h                     |  1 +
 arch/x86/kernel/hpet.c                          |  2 +
 arch/x86/kernel/tsc.c                           | 39 ++++++++++++--
 drivers/clocksource/acpi_pm.c                   |  6 ++-
 kernel/time/Kconfig                             |  6 ++-
 kernel/time/clocksource.c                       | 72 +++++++++++++++++--------
 7 files changed, 102 insertions(+), 28 deletions(-)
