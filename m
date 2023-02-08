Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE2F68ED04
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjBHKgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBHKgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:36:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DB9D48A2F;
        Wed,  8 Feb 2023 02:35:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 797611042;
        Wed,  8 Feb 2023 02:35:57 -0800 (PST)
Received: from bogus (unknown [10.57.10.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 835903F8C6;
        Wed,  8 Feb 2023 02:35:13 -0800 (PST)
Date:   Wed, 8 Feb 2023 10:35:11 +0000
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
Message-ID: <20230208103511.w7jzxw6spy6humdn@bogus>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
 <20230206101239.dret3fv65cnzpken@bogus>
 <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 04:48:18AM +0900, Kazuki wrote:
> On Mon, Feb 06, 2023 at 10:12:39AM +0000, Sudeep Holla wrote:
> >
> > What do you mean by break ? More details on the observation would be helpful.
> For example, CLOCK_MONOTONIC doesn't stop even after suspend since
> these chain of commands don't get called.
>
> call_cpuidle_s2idle->cpuidle_enter_s2idle->enter_s2idle_proper->tick_freeze->sched_clock_suspend (Function that pauses CLOCK_MONOTONIC)
>
> Which in turn causes programs like systemd to crash since it doesn't
> expect this.

Yes expected IIUC. The per-cpu timers and counters continue to tick in
WFI and hence CLOCK_MONOTONIC can't stop.

> >
> > > 2. Suspend actually works on ARM64 machines even without proper
> > > cpuidle (PSCI cpuidle) since they support wfi, so the assumption here is wrong
> > > on such machines
> > >
> >
> > Sorry I am bit confused here. Your point (2) contradicts the $subject.
> drivers/cpuidle/cpuidle.c:
>
> bool cpuidle_not_available(struct cpuidle_driver *drv,
> 			   struct cpuidle_device *dev)
> {
> 	return off || !initialized || !drv || !dev || !dev->enabled;
> }
>
> The cpuidle framework reports ARM64 devices without PSCI cpuidle as
> "cpuidle not available" even when they support wfi, which causes suspend
> to fail, which shouldn't be happening since they do support idling.

Yes with just WFI, there will be no active cpuidle driver.

[...]

> > Again, since s2idle is userspace driven, I don't understand what do you
> > mean by unbootable kernel in the context of s2idle.
>
> Sorry, I meant "attempts to fix this bug have all led to an unbootable
> kernel."

Again I assume you mean kernel hang or crash and nothing to do with boot.
Once you enter s2i state with your changes/fix, it hangs or is unresponsive
as it might have either failed to enter or resume from the state.

--
Regards,
Sudeep
