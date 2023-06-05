Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAEE722149
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjFEIo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjFEIoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:44:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324B81A8;
        Mon,  5 Jun 2023 01:44:15 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q65ow-0000MX-J4; Mon, 05 Jun 2023 10:44:10 +0200
Message-ID: <15bb2507-a145-7f1b-8e84-58aeb02484b9@leemhuis.info>
Date:   Mon, 5 Jun 2023 10:44:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from busy
To:     Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Mark Lord <mlord@pobox.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230531082428.21763-1-hadess@hadess.net>
 <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm>
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1685954656;1fc30558;
X-HE-SMSGID: 1q65ow-0000MX-J4
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.06.23 14:41, Jiri Kosina wrote:
> On Wed, 31 May 2023, Jiri Kosina wrote:
> 
>>> If an attempt at contacting a receiver or a device fails because the
>>> receiver or device never responds, don't restart the communication, only
>>> restart it if the receiver or device answers that it's busy, as originally
>>> intended.
>>>
>>> This was the behaviour on communication timeout before commit 586e8fede795
>>> ("HID: logitech-hidpp: Retry commands when device is busy").
>>>
>>> This fixes some overly long waits in a critical path on boot, when
>>> checking whether the device is connected by getting its HID++ version.
>>>
>>> Signed-off-by: Bastien Nocera <hadess@hadess.net>
>>> Suggested-by: Mark Lord <mlord@pobox.com>
>>> Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217412
> [...]  
>>
>> I have applied this even before getting confirmation from the reporters in 
>> bugzilla, as it's the right thing to do anyway.
> 
> Unfortunately it doesn't seem to cure the reported issue (while reverting 
> 586e8fede79 does):

BTW, remind me again: was fixing this by reverting 586e8fede79 for now a
option? I guess it's not, but if I'm wrong I wonder if that might at
this point be the best way forward.

> https://bugzilla.kernel.org/show_bug.cgi?id=217523#c2

FWIW, another comment showed up there:

```
> --- Comment #6 from vova7890 ---
> Same problem. I researched this some time ago. I noticed that if I add a small
> delay between commands to the dongle - everything goes fine. Repeated
> request(586e8fede7953b1695b5ccc6112eff9b052e79ac) made the situation more
> visible
```

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot ^backmonitor:
https://lore.kernel.org/all/15e5d50f-95fc-c7c9-0918-015f24c6fc6d@leemhuis.info/
