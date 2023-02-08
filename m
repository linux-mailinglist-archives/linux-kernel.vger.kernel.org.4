Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF6368F30B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjBHQSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjBHQSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:18:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A3C33583;
        Wed,  8 Feb 2023 08:18:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC26B1477;
        Wed,  8 Feb 2023 08:18:51 -0800 (PST)
Received: from bogus (unknown [10.57.10.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DDEB3F8C6;
        Wed,  8 Feb 2023 08:18:07 -0800 (PST)
Date:   Wed, 8 Feb 2023 16:18:05 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     Kazuki <kazukih0205@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: s2idle breaks on machines without cpuidle support
Message-ID: <20230208161805.2dlx66oxphl25p3c@bogus>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
 <20230206101239.dret3fv65cnzpken@bogus>
 <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
 <20230208103511.w7jzxw6spy6humdn@bogus>
 <5f741a4f-f37d-079b-d464-59045ebef1ce@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f741a4f-f37d-079b-d464-59045ebef1ce@marcan.st>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 12:42:17AM +0900, Hector Martin wrote:
> On 08/02/2023 19.35, Sudeep Holla wrote:
> > On Wed, Feb 08, 2023 at 04:48:18AM +0900, Kazuki wrote:
> >> On Mon, Feb 06, 2023 at 10:12:39AM +0000, Sudeep Holla wrote:
> >>>
> >>> What do you mean by break ? More details on the observation would be helpful.
> >> For example, CLOCK_MONOTONIC doesn't stop even after suspend since
> >> these chain of commands don't get called.
> >>
> >> call_cpuidle_s2idle->cpuidle_enter_s2idle->enter_s2idle_proper->tick_freeze->sched_clock_suspend (Function that pauses CLOCK_MONOTONIC)
> >>
> >> Which in turn causes programs like systemd to crash since it doesn't
> >> expect this.
> > 
> > Yes expected IIUC. The per-cpu timers and counters continue to tick in
> > WFI and hence CLOCK_MONOTONIC can't stop.
> 
> The hardware counters would also keep ticking in "real" s2idle (with
> hypothetical PSCI idle support) and often in full suspend. There is a
> flag for this (CLOCK_SOURCE_SUSPEND_NONSTOP) that is set by default for
> ARM. So this isn't why CLOCK_MONOTONIC isn't stopping; there is
> machinery to make the kernel's view of time stop anyway, it's just not
> being invoked here.
>

Indeed, and I assumed s2idle was designed with those requirements but I
think I may be wrong especially looking at few points you have raised
provide my understanding is aligned with yours.

> This is somewhat orthogonal to the issue of PSCI. These machines can't
> physically support PSCI and KVM at the same time (they do not have EL3),
> so PSCI is not an option. We will be starting a conversation about how
> to provide something "like" PSCI over some other sort of transport to
> solve this soon. So that will "fix" this issue once it's all implemented.
>

All the best for the efforts.

> However, these machines aren't the only ones without PSCI (search for
> "spin-table" in arch/arm64/boot/dts, this isn't new and these aren't the
> first).

Yes I am aware of it and if you see arch/arm64/kernel/smp_spin_table.c
we don't support CPU hotplug or suspend for such a system.

> It seems broken that Linux currently implements s2idle in such a
> way that it violates the userspace clock behavior contract on systems
> without a cpuidle driver (and does so silently, to make it worse).

Just to check if I understand this correctly, are you referring to:
cpuidle_idle_call()->default_idle_call() if cpuidle_not_available()
And the problem is it idles there in wfi but CLOCK_MONOTONIC isn't
stopping as expected by the userspace ? If so, fair enough. If not, I
may be missing to understand something.

> So that should be fixed regardless of whether we end up coming up with a
> PSCI alternative or not for these platforms.

If above understanding is correct, I agree. But not sure what was the
motivation behind the current behaviour.

> There's no fundamental reason why s2idle can't work properly with plain WFI.
>

Fair enough. I hadn't thought much of it before as most of the platforms
I have seen or used have at-least one deeper than WFI state these days.
On arm32, this was common but each platform managed suspend_set_ops
on its own and probably can do the same s2idle_set_ops.

--
Regards,
Sudeep
