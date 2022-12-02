Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853BC640A1C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiLBQEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiLBQEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:04:16 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DE689AC3;
        Fri,  2 Dec 2022 08:02:50 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p18Ux-0005Di-Pr; Fri, 02 Dec 2022 17:02:47 +0100
Message-ID: <9a03c244-adff-afaf-7385-d8e89cd3f338@leemhuis.info>
Date:   Fri, 2 Dec 2022 17:02:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
Content-Language: en-US, de-DE
To:     Dave Chiluk <chiluk@ubuntu.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Cc:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
 <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
 <CAMfi-DRE-u5TNu2zAL-7A-ENHM9EiJeYJ38BL_FMdk6QmW7c9w@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAMfi-DRE-u5TNu2zAL-7A-ENHM9EiJeYJ38BL_FMdk6QmW7c9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669996970;1d693492;
X-HE-SMSGID: 1p18Ux-0005Di-Pr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.12.22 16:37, Dave Chiluk wrote:
> The other possibility is that this is actually a bios bug, as the DSM
> is being read out of ACPI.  In which case that would be Dell's fault.

Yes and no, but no:

A kernel change exposed this problem, hence it doesn't matter if the
BIOS is faulty: it's makes it a kernel regression and those are not
allowed. For more on this see
https://docs.kernel.org/admin-guide/reporting-issues.html

That at least would be the normal approach. But the thing is: the legal
implications when it comes to things like wifi make this somewhat
trickier. :-/

> On Thu, Dec 1, 2022 at 5:33 AM Coelho, Luciano <luciano.coelho@intel.com> wrote:
>>
>> On Thu, 2022-12-01 at 11:14 +0100, Thorsten Leemhuis wrote:
>>> Hi, this is your Linux kernel regression tracker.
>>>
>>> Luca, I noticed a regression report in bugzilla where I'd like your
>>> advice on. To quote https://bugzilla.kernel.org/show_bug.cgi?id=216753
>>
>> Hi Thorsten wearing-the-regression-hat, 🙂

:-D

>> I'm not the maintainer of iwlwifi anymore, so I'm adding the new
>> maintainer here, Gregory Greenman.

Well, you where the author of the commit, that's why I addressed you.
But if Gregory or someone else steps in that's of course totally fine
for me as well. :-D

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

>> Gregory, can you take a look?
>>
>>
>>>> It looks like the self-managed regulatory information is causing the 6ghz band to be disabled on my AX211 (in the US).
>>>> iw reg get shows no 6ghz bands (output at the bottom).
>>>>
>>>> $ sudo iw phy0 channel
>>>> ...
>>>> Band 4:
>>>>     * 5955 MHz [1] (disabled)
>>>>     * 5975 MHz [5] (disabled)
>>>>     * 5995 MHz [9] (disabled)
>>>>         ....(continues with all disabled
>>>>         * 7115 MHz [233] (disabled)
>>>> ...
>>>>
>>>> I was able to narrow this down to having been introduced during the 5.16 development window, as 5.15.79 linux-stable kernel works and the 5.16.12 does
>>>> not (earlier builds of 5.16 kernel fail to boot on my machine for some reason).
>>>>
>>>> I found https://community.frame.work/t/kernel-5-16-6ghz-disabled-ax210/15675/5
>>>> and they imply that this regression was introduced by
>>>> 698b166ed3464e1604a0e6a3e23cc1b529a5adc1
>>>> I haven't independently verified this commit as the definitive issue.
>>>
>>> You authored 698b166ed346 ("iwlwifi: mvm: read 6E enablement flags from
>>> DSM and pass to FW"). As it is a regressions is ideally should be dealt
>>> with. But this area in tricky due to the legal implications. Hence I
>>> wonder: is there anything we can do about this, or is this simply a case
>>> where we have to bite the bullet and live with this regression?
>>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>
>>> P.S.: As the Linux kernel's regression tracker I deal with a lot of
>>> reports and sometimes miss something important when writing mails like
>>> this. If that's the case here, don't hesitate to tell me in a public
>>> reply, it's in everyone's interest to set the public record straight.
> 
> 
