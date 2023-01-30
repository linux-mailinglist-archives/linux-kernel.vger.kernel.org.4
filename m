Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7B0680BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbjA3LKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjA3LKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:10:12 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60427689;
        Mon, 30 Jan 2023 03:10:10 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pMS36-0001VD-5k; Mon, 30 Jan 2023 12:10:08 +0100
Message-ID: <0b9537d1-837e-e728-34ef-7b2ce543c442@leemhuis.info>
Date:   Mon, 30 Jan 2023 12:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Regression] Bug 216885 - HID++ Logitech G903 generates full
 scroll wheel events with every hi-res tick when attached via USB
Content-Language: en-US, de-DE
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        David Roth <davidroth9@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus <luna+bugzilla@cosmos-ink.net>
References: <1bb93259-1c9f-5335-a0bf-fc8641b26650@leemhuis.info>
 <be545e72-8312-f213-0250-86a128b7b629@leemhuis.info>
 <CAO-hwJJtK3B2x8CAAYsB41X8D=1EpEYK+nSuVA+fXuz1LHkmSg@mail.gmail.com>
 <Y9efj49RfzZRIDGY@skade.schwarzvogel.de>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Y9efj49RfzZRIDGY@skade.schwarzvogel.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675077010;c3e6c657;
X-HE-SMSGID: 1pMS36-0001VD-5k
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.01.23 11:44, Tobias Klausmann wrote:
> On Mon, 30 Jan 2023, Benjamin Tissoires wrote:
> 
>> On Mon, Jan 30, 2023 at 10:56 AM Linux kernel regression tracking
>> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>>
>>> [ccing a few people that CCed to the bug]
>>>
>>> Hi, this is your Linux kernel regression tracker.
>>>
>>> On 05.01.23 09:12, Thorsten Leemhuis wrote:
>>>> [...] Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216885 :
>>>>
>>>>>  David Roth 2023-01-04 20:37:22 UTC
>>>>>
>>>>> Created attachment 303526 [details]
>>>>> Libinput record with G903 attached directly to USB
>>>>>
>>>>> Since
>>>>> https://lore.kernel.org/linux-input/20220914132146.6435-1-hadess@hadess.net/T/#u
>>>>> my Logitech G903 has gained hi res support. While normally a good
>>>>> thing, it seems that in this case it leads to generating one normal
>>>>> REL_WHEEL with each REL_WHEEL_HI_RES event instead of just a couple
>>>>> of REL_WHEEL_HI_RES, followed by the standard REL_WHEEL once a
>>>>> notch/tick is reached. This leads to overly sensitive scrolling and
>>>>> makes the wheel basically useless.
>>>
>>> Bastien, Benjamin, Jiri, that problem was reported 25 days ago now and
>>> there is still no fix in sight afaics (please correct me if I'm wrong)
>>> -- and based on the reports I've seen it seem quite a few people are
>>> hitting it. Hence please allow me to ask:
>>>
>>> Wouldn't it be best to revert that change for now (both in mainline and
>>> stable of course) and then reapply it once a fix for this problem is
>>> available? Or
>>
>> Last I heard was that Bastien was actively trying to understand the
>> problem.

Yup, no complains there. Thx for your work on this, Bastien.

But that debugging has already taken some time and it seem more is
needed. And apparently it's more than just a single user or two that is
affected by this. That's why I think it would be better to revert this
temporarily[1], unless a fix suddenly comes into sight.

[1] as strongly suggested by
https://docs.kernel.org/process/handling-regressions.html , which states
that a regression like this should ideally be fixed within a few days
after the report; we are long past this...

>> I do have a G903 here but it is lacking the feature the
>> reporters have, and so I can not reproduce (there is likely a new
>> firmware/model around).
>>
>> After a quick search on
>> https://support.logi.com/hc/en-us/search#q=G903&s=all it seems that
>> there are 2 G903: M-R0081 and M-R0068. I only own the 68 one which
>> explains why I can not reproduce it. :(
> 
> I have an affected mouse and am willing to try patches/fixes, but my
> kernel coding fu is weak. 

Thx for your help, too.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
