Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B2D68F3AD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjBHQpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjBHQpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:45:49 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5703146BA;
        Wed,  8 Feb 2023 08:45:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6FE0941EA7;
        Wed,  8 Feb 2023 16:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1675874724; bh=m1i8O+W10rt3DZgH9ppzcTcaV/+YHdYgZwJjReAf5EY=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=VnUjvLOnFRmpL64/CHoeMeH4PnHOxjtaa1hcTmTWgOdy4naFL0DoOvmTzOEToik+E
         69KRWvqO1JT5rT+2RjvT6MI9rEtI8JNLfFrAuA6ARWAdt0hnMb3yhvn2+LA301U0IE
         RJ/k/Prqbt9KCJHowrBxmnqwrOm27TpNbV4KVpLs/+uyQLIE0S1om+/AUN6DnYp12k
         d79aca3rT1cuCf0DlkJsGfa0lC5jrjC2Nyib1wSuqPdVMzOsUNHCCTAyZznYiwGDuu
         7kB/Sfx9R9Ai//Ra0wc9e/Q2VN8QOxcgA1yymJi/luPdon7hqYHglFe4abvTKUU5ME
         ROlZ77hQchNow==
Message-ID: <e069e779-3943-0f9a-6592-5b096a2a8076@marcan.st>
Date:   Thu, 9 Feb 2023 01:45:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Kazuki <kazukih0205@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
 <20230206101239.dret3fv65cnzpken@bogus>
 <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
 <20230208103511.w7jzxw6spy6humdn@bogus>
 <5f741a4f-f37d-079b-d464-59045ebef1ce@marcan.st>
 <20230208161805.2dlx66oxphl25p3c@bogus>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: s2idle breaks on machines without cpuidle support
In-Reply-To: <20230208161805.2dlx66oxphl25p3c@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 01.18, Sudeep Holla wrote:
> On Thu, Feb 09, 2023 at 12:42:17AM +0900, Hector Martin wrote:
>> On 08/02/2023 19.35, Sudeep Holla wrote:
>>> On Wed, Feb 08, 2023 at 04:48:18AM +0900, Kazuki wrote:
>>>> On Mon, Feb 06, 2023 at 10:12:39AM +0000, Sudeep Holla wrote:
>>>>>
>>>>> What do you mean by break ? More details on the observation would be helpful.
>>>> For example, CLOCK_MONOTONIC doesn't stop even after suspend since
>>>> these chain of commands don't get called.
>>>>
>>>> call_cpuidle_s2idle->cpuidle_enter_s2idle->enter_s2idle_proper->tick_freeze->sched_clock_suspend (Function that pauses CLOCK_MONOTONIC)
>>>>
>>>> Which in turn causes programs like systemd to crash since it doesn't
>>>> expect this.
>>>
>>> Yes expected IIUC. The per-cpu timers and counters continue to tick in
>>> WFI and hence CLOCK_MONOTONIC can't stop.
>>
>> The hardware counters would also keep ticking in "real" s2idle (with
>> hypothetical PSCI idle support) and often in full suspend. There is a
>> flag for this (CLOCK_SOURCE_SUSPEND_NONSTOP) that is set by default for
>> ARM. So this isn't why CLOCK_MONOTONIC isn't stopping; there is
>> machinery to make the kernel's view of time stop anyway, it's just not
>> being invoked here.
>>
> 
> Indeed, and I assumed s2idle was designed with those requirements but I
> think I may be wrong especially looking at few points you have raised
> provide my understanding is aligned with yours.
> 
>> This is somewhat orthogonal to the issue of PSCI. These machines can't
>> physically support PSCI and KVM at the same time (they do not have EL3),
>> so PSCI is not an option. We will be starting a conversation about how
>> to provide something "like" PSCI over some other sort of transport to
>> solve this soon. So that will "fix" this issue once it's all implemented.
>>
> 
> All the best for the efforts.
> 
>> However, these machines aren't the only ones without PSCI (search for
>> "spin-table" in arch/arm64/boot/dts, this isn't new and these aren't the
>> first).
> 
> Yes I am aware of it and if you see arch/arm64/kernel/smp_spin_table.c
> we don't support CPU hotplug or suspend for such a system.

We certainly support s2idle, except it's kind of broken as stated. Try
it, it works :-)

I didn't do anything special to enable s2idle on Apple platforms other
than make sure random drivers weren't broken and there was at least one
driver capable of triggering a wakeup. I just compile with
CONFIG_SUSPEND and s2idle works. Except for the part where
CLOCK_MONOTONIC keeps running. So generic kernels on spin_table
platforms ought to expose (broken) s2idle by default already.

>> It seems broken that Linux currently implements s2idle in such a
>> way that it violates the userspace clock behavior contract on systems
>> without a cpuidle driver (and does so silently, to make it worse).
> 
> Just to check if I understand this correctly, are you referring to:
> cpuidle_idle_call()->default_idle_call() if cpuidle_not_available()
> And the problem is it idles there in wfi but CLOCK_MONOTONIC isn't
> stopping as expected by the userspace ? If so, fair enough. If not, I
> may be missing to understand something.

Right. I'm not too certain on the details of exactly what suspend
machinery is running/supposed to, because this CLOCK_MONOTONIC issue was
a surprise to me when it came up. From my point of view s2idle "just
worked", it's only now that this has come up that we're realizing it's
winding up in a very different codepath to what would happen were
cpuidle/PSCI available. This was all silent from the user POV (it all
looks like it suspends/resumes normally as far as I can tell).

>> So that should be fixed regardless of whether we end up coming up with a
>> PSCI alternative or not for these platforms.
> 
> If above understanding is correct, I agree. But not sure what was the
> motivation behind the current behaviour.
> 
>> There's no fundamental reason why s2idle can't work properly with plain WFI.
>>
> 
> Fair enough. I hadn't thought much of it before as most of the platforms
> I have seen or used have at-least one deeper than WFI state these days.
> On arm32, this was common but each platform managed suspend_set_ops
> on its own and probably can do the same s2idle_set_ops.

Yeah, we do have one deeper idle state (and we should figure out how to
implement a PSCI alternative to enable it soon, since in particular for
certain SoCs plain WFI is quite a power hog since it keeps all the core
clusters powered up and at least partially clocked). But since we don't
have that yet, we've been using WFI-only s2idle so users have *some*
suspend ability.

- Hector
