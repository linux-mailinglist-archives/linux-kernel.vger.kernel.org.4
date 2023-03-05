Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634576AB195
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 18:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjCER0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 12:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCER0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 12:26:06 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6361114B;
        Sun,  5 Mar 2023 09:26:02 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pYs7S-0001Uk-Mt; Sun, 05 Mar 2023 18:25:58 +0100
Message-ID: <5a7cd098-1d83-6297-e802-ce998c8ec116@leemhuis.info>
Date:   Sun, 5 Mar 2023 18:25:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Regression] rt2800usb - Wifi performance issues and connection
 drops
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Thomas Mann <rauchwolke@gmx.net>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Johannes Berg <johannes.berg@intel.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <b8efebc6-4399-d0b8-b2a0-66843314616b@leemhuis.info>
To:     Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <b8efebc6-4399-d0b8-b2a0-66843314616b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678037162;dfdfbc9f;
X-HE-SMSGID: 1pYs7S-0001Uk-Mt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.23 17:24, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217119 :
> 
>>  Thomas Mann 2023-03-03 15:12:03 UTC
>>
>> After the update of linux to 6.2.x, i get connection drops and bandwidth problems.
>>
>> 6.2.1 was completely unusable and 6.2.2 still has bandwidth problems but works a bit better
>>
>> The device in use is:
>>
>> 13d3:3273 IMC Networks 802.11 n/g/b Wireless LAN USB Mini-Card
>>
>> Downgrading the kernel to 6.1.[14,15] fixes the problem and the wifi gets stable again and the available bandwidth increases.

Quick update from bugzilla:

```
--- Comment #4 from Thomas Mann (rauchwolke@gmx.net) ---
i bisected and found the commit that introduced the regression:

# first bad commit: [4444bc2116aecdcde87dce80373540adc8bd478b] wifi:
mac80211: Proper mark iTXQs for resumption
```

That's a commit from Alexander, applied by Johannes.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

>> demsg shows no errors
>>
>> [tag] [reply] [−]
>> Private
>> Comment 1 The Linux kernel's regression tracker (Thorsten Leemhuis) 2023-03-04 05:45:33 UTC
>>
>> Please attach dmesg [without it most people won't even know which driver is in use for your card]
>>
>> [tag] [reply] [−]
>> Private
>> Comment 2 Thomas Mann 2023-03-04 12:36:45 UTC
>>
>> drive in use is rt2800usb
>>
>> [tag] [reply] [−]
>> Private
>> Comment 3 Thomas Mann 2023-03-04 12:38:01 UTC
>>
>> Created attachment 303840 [details]
>> dmesg output
>>
> 
> 
> See the ticket for more details.
> 
> 
> [TLDR for the rest of this mail: I'm adding this report to the list of
> tracked Linux kernel regressions; the text you find below is based on a
> few templates paragraphs you might have encountered already in similar
> form.]
> 
> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
> 
> #regzbot introduced: v6.1..v6.2
> https://bugzilla.kernel.org/show_bug.cgi?id=217119

P.S.:

#regzbot introduced: 4444bc2116aecdcde8
#regzbot ignore-activity

> #regzbot title: net: wireless: rt2800usb: wifi performance issues and
> connection drops
> #regzbot ignore-activity
> 
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.
> 
> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
> this thread sees some discussion). See page linked in footer for details.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
