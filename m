Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6285C68F08C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjBHORP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjBHORE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:17:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C49794617C;
        Wed,  8 Feb 2023 06:17:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F09AA1042;
        Wed,  8 Feb 2023 06:17:44 -0800 (PST)
Received: from bogus (unknown [10.57.10.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF1133F8C6;
        Wed,  8 Feb 2023 06:17:00 -0800 (PST)
Date:   Wed, 8 Feb 2023 14:16:58 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Kazuki <kazukih0205@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: s2idle breaks on machines without cpuidle support
Message-ID: <20230208141658.kede5ylqk4zqvrnj@bogus>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
 <20230206101239.dret3fv65cnzpken@bogus>
 <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
 <20230208103511.w7jzxw6spy6humdn@bogus>
 <20230208112031.sdfuluajjerf4wwp@kazuki-mac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208112031.sdfuluajjerf4wwp@kazuki-mac>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 08:20:31PM +0900, Kazuki wrote:
> On Wed, Feb 08, 2023 at 10:35:11AM +0000, Sudeep Holla wrote:
> > On Wed, Feb 08, 2023 at 04:48:18AM +0900, Kazuki wrote:
> > > On Mon, Feb 06, 2023 at 10:12:39AM +0000, Sudeep Holla wrote:
> > > >
> > > > What do you mean by break ? More details on the observation would be helpful.
> > > For example, CLOCK_MONOTONIC doesn't stop even after suspend since
> > > these chain of commands don't get called.
> > >
> > > call_cpuidle_s2idle->cpuidle_enter_s2idle->enter_s2idle_proper->tick_freeze->sched_clock_suspend (Function that pauses CLOCK_MONOTONIC)
> > >
> > > Which in turn causes programs like systemd to crash since it doesn't
> > > expect this.
> >
> > Yes expected IIUC. The per-cpu timers and counters continue to tick in
> > WFI and hence CLOCK_MONOTONIC can't stop.
> Yes, but it shouldn't be the case when suspending[1]. Currently that's what
> happens when we enter s2idle without a cpuidle driver. This doesn't seem
> to happen with S3 sleep [2].
>

Correct, but check the requirements to use syscore operations(mainly
syscore_suspend/resume where only one CPU is online with interrupts
disabled. In case of s2idle, all CPUs are idling and not offlined as
required by the syscore operations and hence it can't be used.

I was about ask you earlier as why can't you implement just system
suspend in PSCI where the last cpu just calls WFI if you are interested
in system sleep state. Or you can implement CPU_SUSPEND with an additional
retention state which enters PSCI implementation just to make sure there is
an active cpuidle driver and the s2idle state machinery works as expected.
It is built with those requirements and trying to work it out for WFI without
any idle driver or firmware implementation to back it up is just not going
to work.

--
Regards,
Sudeep
