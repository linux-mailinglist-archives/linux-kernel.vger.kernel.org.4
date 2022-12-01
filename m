Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9D163F778
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiLAS2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLAS2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:28:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DBEF4B743
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:28:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6683DD6E;
        Thu,  1 Dec 2022 10:28:44 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA7F03F73B;
        Thu,  1 Dec 2022 10:28:36 -0800 (PST)
Message-ID: <83d16969-9d23-1dc5-c9dd-03542b43a52e@arm.com>
Date:   Thu, 1 Dec 2022 18:28:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] perf/arm-cmn: Cope with spurious IRQs better
Content-Language: en-GB
To:     Geoff Blake <blakgeof@amazon.com>
Cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <bc8183fcd7f6ca07b0d56aa8061d816485b84341.1669822447.git.robin.murphy@arm.com>
 <f41af5cb-7fc7-4bd3-ec9e-53071b9a41f9@amazon.com>
 <c34db006-4d5b-fb71-f998-63fcdcde6c0b@arm.com>
 <99fd664c-bf59-b8c0-29d0-6eccfc1c8e80@amazon.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <99fd664c-bf59-b8c0-29d0-6eccfc1c8e80@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-30 23:13, Geoff Blake wrote:
> 
>>>   From my perspective, this is a worse solution as now we're sweeping an
>>> issue under the rug and consuming CPU cycles handling IRQs we should not
>>> be getting in the first place.  While an overflow IRQ from the cmn should
>>> not be high frequency, there is a non-zero chance in the future it could
>>> be and this could lead to a very hard to debug performance issue instead
>>> of the current problem, which is discovering we need to clean up better
>>> from a noisy kernel message.
>>
>> Kexec is not the only possible source of spurious IRQs. If they cause a
>> problem for this driver, that cannot be robustly addressed by trying to
>> rely on whatever software might happen to run before this driver.
> 
> Sure, I can agree with the assertion a spurious IRQ could come from
> anywhere, in that case though, shouldn't the behavior still be to log
> spurious IRQs as a warning instead of silently sinking them?

We still have to handle the interrupt anyway to avoid it getting 
disabled behind our back, and beyond that it's not really something 
that's actionable by the user. What would we say?

	dev_warn(dev, "Something harmless, and in some cases expected, 
happened! If you've just rebooted after a kernel panic, maybe try having 
the kernel not panic?");

Perhaps that should be a core IRQ helper so that many other drivers can 
also call it too?

Furthermore if you're worried about performance implications from a 
theoretical interrupt storm, I can tell you from experience that logging 
to a serial console from a high-frequency interrupt handler is one of 
the best ways to cripple a system to the point where reaching for the 
power switch is the only option.

>>> The driver as best I can grok currently is optimized to limit the amount
>>> of register writes for the common use-case, which is setting and unsetting
>>> events, so all the wiring for the PMU to feed events to the DTC is done up
>>> front on load: DTC_CTL's DT_EN bit is set immediately during probe, as is
>>> OVFL_INTR_EN. All the DN states and DTM PMU_CONFIG_PMU_EN is deferred
>>> for when an event is actually set, and here we go through all of them
>>> anyways for each event unless its bynodeid, so the expense of setting
>>> events grows linearly with the mesh size anyways.
>>
>> If arm_cmn_init_dtc() writing 0 to PMCR didn't stop the PMU then we've
>> got bigger problems, because that's how we expect to start and stop it
>> in normal operation. I'm not ruling out that some subtle bug in that
>> regard might exist, since I've still not yet had a chance to reproduce
>> and observe this behaviour on my board, but I've also not seen
>> sufficient evidence to suggest that that is the case either. (Now that
>> I'm looking closely, I think there *is* actually a small oversight for
>> the DTMs, but that would lead to different symptoms than you reported)
> 
>> At least the writes to PMOVSR_CLR *did* clearly work, because you're
>> seeing the "nobody cared" message from the IRQ core rather than the
>> WARN_ON(!dtc->counters[i]) which would happen if a fresh overflow was
>> actually asserted. Currently I would expect to see up to 4 of those
>> messages since there can be up to 4 IRQs, but once those are all
>> requested, enabled, and "handled", all the spurious initially-latched
>> state should be cleared and any *new* overflows will be indicated in
>> PMOVSR. I don't see how a single IRQ could ever be unhandled more than
>> once anyway, if the first time disables it.
> 
> I do see 4 of these "nobody cared" messages in all the times I've
> reproduced it, but saw no need to copy paste all of them in with the
> original post.

For reference, the key point to look for is that the IRQ numbers are 
different, so it's not actually the *same* message multiple times, it's 
multiple messages representing distinct causes.

>  Looking back over the code I see why more clearly your
> assertion we only need to clear the DT_EN bit as the PMU is off at
> the DTC with the PMCR set to 0 on init, but it is really hard to
> see why that is with all the various places bits of configuration is done,
> but it is still not easy to verify if unsetting that bit is sufficient to
> not get into some odd corner cases.

The DTC_CTL documentation seems fairly unambiguous:

[0]	dt_en	Enables debug, trace, and PMU features

The design intent is that the PMU counters do not count when the entire 
PMU feature is disabled. I'm pretty sure I did confirm that empirically 
during development too (I recall the sheer number of different "enable" 
bits baffled me at the beginning, and there was actually one that did 
nothing, which I think did eventually get removed from the documentation).

Of course clearing PMCR_PMU_EN is sufficient to simply stop counting, 
which we also depend on for correct operation, but I believe clearing 
DT_EN allows it to put all of the DT logic into a quiescent state.

> Is there any argument against me taking another pass and try separating
> out discovery, from a shared reset/initialization code path?

Frankly, yes. Discovery and initialisation are already as distinct as I 
could realistically make them:

	err = arm_cmn_discover(cmn, rootnode);
	if (err)
		return err;

	err = arm_cmn_init_dtcs(cmn);
	if (err)
		return err;

	err = arm_cmn_init_irqs(cmn);
	if (err)
		return err;

It's true that that DTM initialisation is still entangled in the middle 
of the discovery walk, but the alternatives are to separately initialise 
the DTM data and registers from two different places (yuck), or 
duplicate a chunk of the discovery process in a subsequent 
initialisation phase to establish the XP/DTM relationship (also yuck).

With the possible exception of arm_cmn_init_irqs() which may contain a 
teeny bit of self-indulgence, I've tried hard to make most of the code 
as concise and clear as it can be within the bounds of the perf API and 
the way the CMN PMU fundamentally works, also balanced with trying to 
keep memory footprint and runtime overhead from getting out of hand 
(still a bit of a losing battle when updating a single event count might 
require 148 register reads...). I accept that it's a bit of a personal 
preference that less code is easier to follow than more code, but I 
don't think it's a particularly rare one, and the fact is that the way 
the CMN PMU works is rather complicated compared to most other PMUs, so 
that brings an unavoidable level of complexity to the driver, and adding 
more code to do additional unnecessary work cannot conceivably make it 
any less complex.

Thanks,
Robin.
