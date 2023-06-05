Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF6C722C6E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjFEQZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFEQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:25:20 -0400
Received: from sasl.smtp.pobox.com (pb-sasl2.pobox.com [64.147.108.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C92EA;
        Mon,  5 Jun 2023 09:25:19 -0700 (PDT)
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-sasl2.pobox.com (Postfix) with ESMTP id F3A6D919A1;
        Mon,  5 Jun 2023 12:25:16 -0400 (EDT)
        (envelope-from mlord@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=subject:to
        :cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=Kkit9hxeaRzj
        sC+jEwyCGJmNshi/SBvv1rGprkktDfg=; b=WcF8hI+G3hD4gxX55dXQE6G/SLoe
        jEKA6SadjiZH2sPbl2flhQQOZ9xE7+Fqg3KMePstywt3afxeJd1WMBfhZs423vTx
        W8ayQQYGJRluvaUEPVK6YZdGgrPHoi3uOL4w1duEw/pUuXz0oL2y/H8HTtayDN2v
        anj81MLK88IdkJA=
Received: from pb-sasl2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-sasl2.pobox.com (Postfix) with ESMTP id D6DFB9199F;
        Mon,  5 Jun 2023 12:25:16 -0400 (EDT)
        (envelope-from mlord@pobox.com)
Received: from [10.0.0.9] (unknown [24.156.181.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-sasl2.pobox.com (Postfix) with ESMTPSA id B46879199E;
        Mon,  5 Jun 2023 12:25:15 -0400 (EDT)
        (envelope-from mlord@pobox.com)
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from busy
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
References: <20230531082428.21763-1-hadess@hadess.net>
 <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm>
 <15bb2507-a145-7f1b-8e84-58aeb02484b9@leemhuis.info>
 <7ko33em3pqdaeghkt6wumzks6fz2lzztmqyhyzvv3kisjovmvr@mojlmkmrqlml>
From:   Mark Lord <mlord@pobox.com>
Message-ID: <2c10eb8f-8804-d47f-7b15-5da56ffb5414@pobox.com>
Date:   Mon, 5 Jun 2023 12:25:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7ko33em3pqdaeghkt6wumzks6fz2lzztmqyhyzvv3kisjovmvr@mojlmkmrqlml>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 8E120F22-03BD-11EE-A498-77FD3825B25C-82205200!pb-sasl2.pobox.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-05 10:27 AM, Benjamin Tissoires wrote:
> 
> On Jun 05 2023, Linux regression tracking (Thorsten Leemhuis) wrote:
>>
>> On 03.06.23 14:41, Jiri Kosina wrote:
>>> On Wed, 31 May 2023, Jiri Kosina wrote:
>>>
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
> Could be. I don't think we thought at simply reverting it because it is
> required for some new supoprted devices because they might differ
> slightly from what we currently supported.
> 
> That being said, Bastien will be unavailable for at least a week AFAIU,
> so maybe we should revert that patch.
> 
>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=217523#c2

Pardon me, but I don't understand what that "retry" loop
is even attempting to do inside function hidpp_send_message_sync().

It appears to unconditionally loop until:
   (1) the __hidpp_send_report() fails,
or (2) it gets a HIDPP_ERROR,
or (3) it gets a HIDPP20_ERROR other than HIDPP20_ERROR_BUSY,
or (4) until it has looped 3 times, which appears to be the normal exit.

It doesn't seem to have any provision to exit the loop earlier on "success"
(whatever that is).

And so when it finally does exit after the 3 iterations,
it then returns the last value of "ret",
which will be zero from the __hidpp_send_report() call,
or sometimes the most recent non-BUSY HIDPP20_ERROR seen.

Obviously I'm missing something, as otherwise this code would never have
passed review and made it into the Linux kernel in the first place.  Right?

What is this code trying to do?  And what am I not seeing?
-- 
Mark Lord
