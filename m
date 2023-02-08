Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4252268F243
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjBHPma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjBHPm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:42:28 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6032AA;
        Wed,  8 Feb 2023 07:42:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 56F4B41EA7;
        Wed,  8 Feb 2023 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1675870944; bh=9EEEtXkSzKmNuZPuh2VHDQl9lpD/J0a/AFRac3FFtQo=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=w46pOOne4H8Ry9Vrf1BwQn6dgb11NEULDBl2gQpPNN4a114LEGt56yCxpufMp6k83
         nBDdN2v647BIdcKSNnVKgU4o1/XxmVhQwjIjMTDsugegQ5e84MvcPAp/v8fZTz4I00
         EH/Q3AwpWJ2r7X9lq8Jl7iXt/sc1ri8VQg5KZ0SsYu951K4QOQ5niFGyjU6bceEzSj
         M/ZJv/UMtIHRN93qWkqDtPHfp7mopBRfHFh45Br/bwAn4ilaCePCwLZUtNi5IpYxKo
         BGW/cqtjZvAV+ncFY8ac9wTf38H61oxQ+ZT22N2Ameqvrc7kuJFeYj2KJaiA2HWmC/
         J6XsrhiUWPc7w==
Message-ID: <5f741a4f-f37d-079b-d464-59045ebef1ce@marcan.st>
Date:   Thu, 9 Feb 2023 00:42:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>, Kazuki <kazukih0205@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
 <20230206101239.dret3fv65cnzpken@bogus>
 <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
 <20230208103511.w7jzxw6spy6humdn@bogus>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: s2idle breaks on machines without cpuidle support
In-Reply-To: <20230208103511.w7jzxw6spy6humdn@bogus>
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

On 08/02/2023 19.35, Sudeep Holla wrote:
> On Wed, Feb 08, 2023 at 04:48:18AM +0900, Kazuki wrote:
>> On Mon, Feb 06, 2023 at 10:12:39AM +0000, Sudeep Holla wrote:
>>>
>>> What do you mean by break ? More details on the observation would be helpful.
>> For example, CLOCK_MONOTONIC doesn't stop even after suspend since
>> these chain of commands don't get called.
>>
>> call_cpuidle_s2idle->cpuidle_enter_s2idle->enter_s2idle_proper->tick_freeze->sched_clock_suspend (Function that pauses CLOCK_MONOTONIC)
>>
>> Which in turn causes programs like systemd to crash since it doesn't
>> expect this.
> 
> Yes expected IIUC. The per-cpu timers and counters continue to tick in
> WFI and hence CLOCK_MONOTONIC can't stop.

The hardware counters would also keep ticking in "real" s2idle (with
hypothetical PSCI idle support) and often in full suspend. There is a
flag for this (CLOCK_SOURCE_SUSPEND_NONSTOP) that is set by default for
ARM. So this isn't why CLOCK_MONOTONIC isn't stopping; there is
machinery to make the kernel's view of time stop anyway, it's just not
being invoked here.

This is somewhat orthogonal to the issue of PSCI. These machines can't
physically support PSCI and KVM at the same time (they do not have EL3),
so PSCI is not an option. We will be starting a conversation about how
to provide something "like" PSCI over some other sort of transport to
solve this soon. So that will "fix" this issue once it's all implemented.

However, these machines aren't the only ones without PSCI (search for
"spin-table" in arch/arm64/boot/dts, this isn't new and these aren't the
first). It seems broken that Linux currently implements s2idle in such a
way that it violates the userspace clock behavior contract on systems
without a cpuidle driver (and does so silently, to make it worse). So
that should be fixed regardless of whether we end up coming up with a
PSCI alternative or not for these platforms. There's no fundamental
reason why s2idle can't work properly with plain WFI.

- Hector
