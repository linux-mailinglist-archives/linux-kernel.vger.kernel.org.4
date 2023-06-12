Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7072C971
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbjFLPKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbjFLPKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:10:10 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAB6186;
        Mon, 12 Jun 2023 08:10:08 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q8jBG-0006SE-QN; Mon, 12 Jun 2023 17:10:06 +0200
Message-ID: <8065316b-0a3a-e7d5-28de-cc9fc9210ce5@leemhuis.info>
Date:   Mon, 12 Jun 2023 17:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Sometimes DVB broken with commit 6769a0b7ee0c3b
Content-Language: en-US, de-DE
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Hyunwoo Kim <imv4bel@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Thomas Voegtle <tv@lio96.de>, linux-kernel@vger.kernel.org
References: <da5382ad-09d6-20ac-0d53-611594b30861@lio96.de>
 <439d143b-1de7-6365-cf64-f1b44fd6d1cf@leemhuis.info>
 <20230605113727.69e7f309@sal.lan>
 <88d8a7c3-0018-cc9a-13aa-e3262e20e4aa@leemhuis.info>
 <20230605190046.63c98b3e@sal.lan>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230605190046.63c98b3e@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686582609;0188dfb9;
X-HE-SMSGID: 1q8jBG-0006SE-QN
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.23 20:00, Mauro Carvalho Chehab wrote:
> Em Mon, 5 Jun 2023 12:44:43 +0200
> Thorsten Leemhuis <regressions@leemhuis.info> escreveu:
>> On 05.06.23 12:37, Mauro Carvalho Chehab wrote:
>>> Em Mon, 5 Jun 2023 11:38:49 +0200
>>> "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> escreveu:
>>>>
>>>> On 30.05.23 13:12, Thomas Voegtle wrote:  
>>>>>
>>>>> I have the problem that sometimes my DVB card does not initialize
>>>>> properly booting Linux 6.4-rc4.
>>>>> This is not always, maybe in 3 out of 4 attempts.
>>>>> When this happens somehow you don't see anything special in dmesg, but
>>>>> the card just doesn't work.
>>>>>
>>>>> Reverting this helps:
>>>>> commit 6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f
>>>>[...]
>>>> Mauro: I wonder if this is something you or someone else has to look
>>>> into, as Hyunwoo Kim posted a few times per months to Linux lists, but
>>>> according  to a quick search on lore hasn't posted anything since ~two
>>>> months now. :-/  
>>>
>>> Yeah, I was slow applying this one, as I was afraid of it to cause
>>> troubles. The DVB frontend state machine is complex, and uses a
>>> semaphore to update its state. There was some past attempts of
>>> addressing some lifetime issues there that we ended needing to revert
>>> or not being applied, as the fix caused more harm than good.
>>> [...]  
>>
>> Thx for the update. That's unfortunate, but how it is sometimes. Which
>> leads to a follow-up question: is reverting the culprit temporarily an
>> option? Or did those old use-after-free problems became known to be a
>> problem we can't live with anymore for another few months?
> 
> Reverting the patch seems to be the way to proceed. Then, work on another
> way to address UAF. 
> 
> I'm not aware of dvb users complaining about troubles due to UAF, although 
> it seems that there's now a CVE for it. So, maybe someone complained against
> a distro Kernel, which caused the CVE to be opened.
> 
> So, while it is nice to have the lifetime issues fixed, last time I checked,
> the USB dvb-usb/dvb-usb-v2 have some logic that usually prevents it to cause 
> real issues during device removal, and unbinding DVB PCIe devices is 
> something that users don't do in practice.

Thx for the explanation and handling this. I noticed you posted a
revert, but it misses a fixes tag for the reverted commit and a Link: or
Closes: tag to the report. I think Linus would very much welcome at
least one of the latter in a situation like this (see [1] and [2]). I
would, too, as then regzbot would have noticed the patch posting. But
whatever, no big deal, let me tell regzbot about the latest progress
manually:

#regzbot monitor:
https://lore.kernel.org/all/20230609082238.3671398-1-mchehab@kernel.org/
#regzbot fix: Revert "media: dvb-core: Fix use-after-free on race
condition at dvb_frontend"

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

[2] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)

--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
