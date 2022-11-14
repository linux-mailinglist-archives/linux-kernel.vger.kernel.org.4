Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B476A6288C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiKNS7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbiKNS7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:59:20 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F15C12090
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:59:08 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ouefj-0007cG-5m; Mon, 14 Nov 2022 19:59:07 +0100
Message-ID: <49ab0931-0d45-7884-e7b6-5c7d4de82ee2@leemhuis.info>
Date:   Mon, 14 Nov 2022 19:59:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [GIT PULL] arm64 updates for 6.1-rc1 #forregzbot
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221005144116.2256580-1-catalin.marinas@arm.com>
 <CAMi1Hd38YB2m_r=m0wuDz+wErii37fUq1BJnvN9=y6opDzo_Fw@mail.gmail.com>
 <Y0aq8y5mEZi14lJ/@arm.com>
 <CAMi1Hd3Y9AibeVnh9_KYJ2EXar7bBSypKm4Tixj47htM7ZOURw@mail.gmail.com>
 <CAMi1Hd1VBCFhf7+EXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAMi1Hd1VBCFhf7+EXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1668452350;dfce5e30;
X-HE-SMSGID: 1ouefj-0007cG-5m
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 08.11.22 18:28, Amit Pundir wrote:
> On Tue, 25 Oct 2022 at 18:08, Amit Pundir <amit.pundir@linaro.org> wrote:
>>
>> On Wed, 12 Oct 2022 at 17:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>>
>>> Hi Amit,
>>>
>>> On Sat, Oct 08, 2022 at 08:28:26PM +0530, Amit Pundir wrote:
>>>> On Wed, 5 Oct 2022 at 20:11, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>>>> Will Deacon (2):
>>>>>       arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()
>>>>
>>>> Hi Will,
>>>>
>>>> This patch broke AOSP on Dragonboard 845c (SDM845). I don't see any
>>>> relevant crash in the attached log and device silently reboots into
>>>> USB crash dump mode. The crash is fairly reproducible on db845c. I
>>>> could trigger it twice in 5 reboots and it always crash at the same
>>>> point during the boot process. Reverting this patch fixes the crash.
>>>>
>>>> I'm happy to test run any debug patche(s), that would help narrow
>>>> down this breakage.
>>>
>>> Cc'ing Robin, maybe he has a better idea (that's commit c44094eee32f).
>>> Architecturally the change shouldn't make any difference since the cache
>>> lines can be brought in via the linear mapping at any point. It's just
>>> less likely to hit a real bug (software or hardware). It's also possible
>>> that arch_dma_prep_coherent() is used outside the DMA API (if you have
>>> out of tree drivers).
>>>
>>> Leaving the original log in place for Robin. A question I have, with a
>>> successful boot, what's normally after the bpfloader lines are printed?
>>> We should try to pinpoint which device/driver causes this. It looks like
>>> it's well into user-space at that point (graphics about to start?)
>>
>> Further narrowed down the breakage to the userspace daemon rmtfs
>> https://github.com/andersson/rmtfs. Is there anything specific in the
>> userspace code that I should be paying attention to?

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced c44094eee32f
#regzbot title arm64: crash on the Qualcomm SM8250
#regzbot monitor
https://lore.kernel.org/all/20221114110329.68413-1-manivannan.sadhasivam@linaro.org/

#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
