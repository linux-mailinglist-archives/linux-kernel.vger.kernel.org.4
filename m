Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517B1724B11
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjFFSTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbjFFSSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:18:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539A9170E;
        Tue,  6 Jun 2023 11:18:32 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q6bGG-00058y-Af; Tue, 06 Jun 2023 20:18:28 +0200
Message-ID: <42b6e582-f642-7521-135a-449140984211@leemhuis.info>
Date:   Tue, 6 Jun 2023 20:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from busy
Content-Language: en-US, de-DE
To:     Jiri Kosina <jikos@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Mark Lord <mlord@pobox.com>
References: <20230531082428.21763-1-hadess@hadess.net>
 <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm>
 <15bb2507-a145-7f1b-8e84-58aeb02484b9@leemhuis.info>
 <nycvar.YFH.7.76.2306061527080.29760@cbobk.fhfr.pm>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <nycvar.YFH.7.76.2306061527080.29760@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686075512;c8295519;
X-HE-SMSGID: 1q6bGG-00058y-Af
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.06.23 15:27, Jiri Kosina wrote:
> On Mon, 5 Jun 2023, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
>>>>> If an attempt at contacting a receiver or a device fails because the
>>>>> receiver or device never responds, don't restart the communication, only
>>>>> restart it if the receiver or device answers that it's busy, as originally
>>>>> intended.
>>>>>
>>>>> This was the behaviour on communication timeout before commit 586e8fede795
>>>>> ("HID: logitech-hidpp: Retry commands when device is busy").
>>>>>
>>>>> This fixes some overly long waits in a critical path on boot, when
>>>>> checking whether the device is connected by getting its HID++ version.
>>>>>
>>>>> Signed-off-by: Bastien Nocera <hadess@hadess.net>
>>>>> Suggested-by: Mark Lord <mlord@pobox.com>
>>>>> Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217412
>>> [...]  
>>>>
>>>> I have applied this even before getting confirmation from the reporters in 
>>>> bugzilla, as it's the right thing to do anyway.
>>>
>>> Unfortunately it doesn't seem to cure the reported issue (while reverting 
>>> 586e8fede79 does):
>>
>> BTW, remind me again: was fixing this by reverting 586e8fede79 for now a
>> option? I guess it's not, but if I'm wrong I wonder if that might at
>> this point be the best way forward.
> 
> This should now all be fixed by
> 
>     https://git.kernel.org/linus/7c28afd5512e371773dbb2bf95a31ed5625651d9

Jiri, Benjamin, many many thx for working on this.

Hmmm. No CC: <stable... tag.

Should we ask Greg to pick this up for 6.3 now, or better wait a few
days? He currently already has 6199d23c91ce ("HID: logitech-hidpp:
Handle timeout differently from busy") in his queue for the next 6.3.y
release.

Ciao, Thorsten

P.S.: If the answer is along the lines of "let's backport this quickly",
please consider directly CCing Greg.
