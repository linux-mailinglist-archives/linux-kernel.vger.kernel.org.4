Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5AB738CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjFURTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjFURTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:19:41 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5971CE2;
        Wed, 21 Jun 2023 10:19:38 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qC1UL-00010x-87; Wed, 21 Jun 2023 19:19:25 +0200
Message-ID: <cfe89ae9-90a6-2b04-a1ee-20569dc42ab4@leemhuis.info>
Date:   Wed, 21 Jun 2023 19:19:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from busy
Content-Language: en-US, de-DE
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Mark Lord <mlord@pobox.com>, Jiri Kosina <jikos@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
References: <20230531082428.21763-1-hadess@hadess.net>
 <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm>
 <15bb2507-a145-7f1b-8e84-58aeb02484b9@leemhuis.info>
 <nycvar.YFH.7.76.2306061527080.29760@cbobk.fhfr.pm>
 <42b6e582-f642-7521-135a-449140984211@leemhuis.info>
 <53903462-2552-b707-3831-cad3ef873b0d@leemhuis.info>
 <aa0e3371-dad1-3296-18fb-1957b92aa4d1@pobox.com>
 <ed27ca39-3609-695c-9f04-65c0bad343c2@leemhuis.info>
 <CAO-hwJLyA==_Wkyi-gTn-FOAAne2JKDfNMY2EaELoFDo5Qbe-A@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAO-hwJLyA==_Wkyi-gTn-FOAAne2JKDfNMY2EaELoFDo5Qbe-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687367978;f40bdf3e;
X-HE-SMSGID: 1qC1UL-00010x-87
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.06.23 17:10, Benjamin Tissoires wrote:
> On Wed, Jun 21, 2023 at 4:09 PM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> On 15.06.23 13:24, Mark Lord wrote:
>>> On 2023-06-15 03:24 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> ...
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=217412
>>>>
>>>> --- Comment #47 from Mark Blakeney ---
>>>> @Juha, kernel 6.3.7 adds the 2 patches intended to fix this bug and the
>>>> startup delay is now gone. However, I have had 2 cases over the last 5
>>>> days in which I have been running 6.3.7 where my mouse fails to be
>>>> detected at all after startup. I have to pull the Logitech receiver
>>>> out/in to get the mouse working. Never seen this issue before so I
>>>> suspect the patches are not right.
>>>> ```
>>>
>>> I too have had that happen with recent kernels,
>>
>> Ahh, good to know!
>>
>>> but have not yet put
>>> a finger to a specific version or cause.
>>>
>>> Just toggling the power button on the wireless mouse is enough for
>>> it to "re-appear".
>>>
>>> The 5.4.xx kernels never had this issue.  I went straight from those
>>> to the 6.3.xx ones, where it does happen sometimes, both with and without
>>> the recent "delay" fixes.
>>
>> From Mark Blakeney it sounded a lot like this is something that started
>> with 6.3, but would be good to confirm. Which brings me to the reason
>> why I write this mail:
>>
>> Is anyone still working on this? There was radio silence already for a
>> week now. Okay, it's not really urgent, but I guess this should not fall
>> through the cracks.
> 
> Sorry for the radio silence.

No worries, we all have much to do. But I thought it was time for a
quick status inquiry.

> I worked on hidpp yesterday and submitted
> a new patch for a problem that was overlooked in the previous fixes:
> https://lore.kernel.org/linux-input/20230621-logitech-fixes-v1-1-32e70933c0b0@redhat.com/

Great, many thx!

> The loop was not properly initializing all its local states, meaning
> that when we encountered a "please retry" from the device, we could
> never do the actual retry and returned a different error than in the
> 6.2 series.
> 
> Would anyone give it a shot?

Might be worth mentioning it in the bugzilla ticket, as I sadly can't CC
those people here. I'll do this for once (konstantin's bugbot will soon
solve this problem...)

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
