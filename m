Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5398167A7B0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjAYA2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjAYA2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:28:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4855612C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:27:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CF6FB81731
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2996C433D2;
        Wed, 25 Jan 2023 00:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674606428;
        bh=vDMzljZkknYr4r5+qhqZbugmsIgZrz82l+Ne0kw9qag=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=T3i/mp3oopQFri74uZyDTKvTqOpbNccVgDovTd5qB6W+xivcGJ1a2cHOsYFKg9nVO
         Kei1oZyKreWqK9BI84pNgCCOhNAZqgBcGTrhkyK4tWyl9trXa/qR9CII1cCfs5a3Ok
         M2t4+jhXY6j4Y2hUAwiCuOkzSqtTy92NZDgMoM3YeycSloWreQFuLTqqX79e0pPd2v
         QSuyiO6SRYinMlXZEru0DxtGTJ1OfPkwej8J8qKL3ZxxSR1nE92Q/0XNoUhlMwq4Rf
         aq/VESyjOMMlpAcC9pzBDZq5Adeg96SCeZZqrWPLxqSLgEL7BHpTxh9KoxEpKrRPZH
         UeiVAJMlFsw8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 50BB15C1052; Tue, 24 Jan 2023 16:27:08 -0800 (PST)
Date:   Tue, 24 Jan 2023 16:27:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [PATCH clocksource v2 0/7] Clocksource watchdog updates for v6.3
Message-ID: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
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

Hello!

This series contains clocksource-watchdog updates:

1.	Print clocksource name when clocksource is tested unstable,
	courtesy of Yunying Sun.

2.	Loosen clocksource watchdog constraints.

3.	Improve read-back-delay message.

4.	Improve "skew is too large" messages.

5.	Suspend the watchdog temporarily when high read latency detected,
	courtesy of Feng Tang.

6.	Verify HPET and PMTMR when TSC unverified.

7.	x86/tsc: Add option to force frequency recalibration with HW
	timer, courtesy of Feng Tang.

Changes since v1:

o	Add system descriptions to #5 and #6 in response to questions
	from Thomas Gleixner.

o	Add patch #7.

						Thanx, Paul

------------------------------------------------------------------------

 arch/x86/kernel/tsc.c                             |   34 +++++++++-
 b/Documentation/admin-guide/kernel-parameters.txt |    4 +
 b/arch/x86/include/asm/time.h                     |    1 
 b/arch/x86/kernel/hpet.c                          |    2 
 b/arch/x86/kernel/tsc.c                           |    5 +
 b/drivers/clocksource/acpi_pm.c                   |    6 +
 b/kernel/time/Kconfig                             |    6 +
 b/kernel/time/clocksource.c                       |    4 -
 kernel/time/clocksource.c                         |   72 +++++++++++++++-------
 9 files changed, 104 insertions(+), 30 deletions(-)

