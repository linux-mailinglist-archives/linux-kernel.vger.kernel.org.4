Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AB065C114
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbjACNrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237615AbjACNrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:47:09 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD828635F;
        Tue,  3 Jan 2023 05:47:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BD47E41F72;
        Tue,  3 Jan 2023 13:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672753624; bh=SzeP2MlAG4KKGlclpyZ3LHoOA2DHqwZs7rhwRxlnz2I=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=RJr3uN2VHgOtkd2I+TGE1MuzWqzXn48VlcpxAl/utHk5tWlq5s1PmcRk3EvfWH/oL
         yERJkLZbhKM/56Bqs4RRVz67nqT2TM4BqDicfvG6xS7/WBLpyrJv+H+Y6AeGi4jHSk
         Gr3TSox+PNUk4GRc+RrYcx4OMZCIUBogA0mmXGF5kWtF9Wwc6QER6FInmIzFVbNCuz
         Dl8T+WJ8P8B8BX+Vl9qx8cI/EReLAFiUIoF/Wpub7fyBRJIiCt/vp+tGh2Sh9xGwVp
         l9JzWazMBiJmoA/5rnczW2E+vPKsqzUyXZmrQJsnKFnkAfIxTW2gkH/g1qsI0FEOT2
         /MpfXfFCSVTcQ==
Message-ID: <3659477c-c822-c5d6-868c-ba40c5a80be6@marcan.st>
Date:   Tue, 3 Jan 2023 22:46:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Aditya Garg <gargaditya08@live.com>, aspriel@gmail.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        lina@asahilina.net, franky.lin@broadcom.com
Cc:     Orlando Chamberlain <redecorating@protonmail.com>,
        brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-wireless@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
References: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
 <f36dd8e3-9905-f04a-ed34-4be91ed1fec6@marcan.st>
 <F9EFCCD1-4407-42CC-8316-2F58AAC1AE7F@live.com>
 <ACC0D1F6-7857-4FF0-A474-4EC699572E1B@live.com>
 <9c5bdb0a-0877-ed16-f09f-164a9dab16d4@marcan.st>
 <18573bd1a38.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <3785835b-164b-28d1-6905-85454cabb69d@marcan.st>
 <6b30559d-9bcc-f3b3-d9b2-2406e9a044b7@broadcom.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 1/2] brcmfmac: Use separate struct to declare firmware
 names for Apple OTP chips
In-Reply-To: <6b30559d-9bcc-f3b3-d9b2-2406e9a044b7@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 22.30, Arend van Spriel wrote:
> On 1/3/2023 4:55 AM, Hector Martin wrote:
>> On 2023/01/03 3:27, Arend Van Spriel wrote:
>>> On January 2, 2023 4:15:41 PM Hector Martin <marcan@marcan.st> wrote:
>>>
>>>> On 02/01/2023 23.40, Aditya Garg wrote:
>>>>> From: Aditya Garg <gargaditya08@live.com>
>>>>>
>>>>> Commit 'dce45ded7619' added support for 89459 chip pcie device. It uses the
>>>>> BRCM4355 chip which is also found in Apple hardware. However this commit
>>>>> causes conflicts in the firmware naming between Apple hardware, which
>>>>> supports OTP and other non-Apple hardwares. So, this patch makes these
>>>>> Apple chips use their own firmware table so as to avoid possible conflicts
>>>>> like these in the future.
>>>>
>>>> I think my reply to Arend flew over your head.
>>>>
>>>> My point was that I'd rather have the Broadcom/Cypress people actually
>>>> answer my question so we can figure out how to do this *properly*,
>>>> instead of doing "safer-but-dumb" things (like this patch) because we
>>>> just don't have the information to do it properly.
>>>
>>> Fair enough. Can you accurately (re)state your question and I will try to
>>> answer it.
>>
>> As per my original email: Is the CYW89459 just a rebrand of the BCM4355,
>> or just a subset? Can we consider them equivalent, and equivalent to the
>> Apple part (BCM4355C1 / revision 12)?
> 
> There is probably no easy answer. Mainly because Cypress is a separate 
> entity. However, they use the same/similar technology and code base. So 
> let me first start with the chip naming. The wifi chip primarily has a 
> number and revision. The chip number is straighforward and can be read 
> from the device. The chip revision comes in two variants: 1) simple 
> increasing number as read from the device, and 2) a <letter><digit> 
> format. The latter start at a0, which you almost never see in the wild 
> unless we do it "first time right". Whenever spinning a new chip we 
> either increase the digit or the letter depending on type/amount of 
> changes. There is not predictable mapping between the revision variants. 
> Depending on the hurdles in a chip project we may move from a0 to b0, or 
> from b0 to b1 or whatever.

Right, this is standard chip spin numbering, that much I know.

> If CYW89459 chip reads chip number 0x4355 than it is a BCM4355. If it is 
> a different revision it may require different firmware. A different 
> letter will always require different firmware. A different digit may 
> work although the firmware can have code paths for a specific revision.

So is it always correct to have the same firmware (in a generic
situation, not a customized OEM build) for, say, a BCM4355 rev 12,
regardless of what the PCI ID programmed into the OTP is (and what the
marketing device name is)?

If so, then my conclusion is that the original patch I replied to is
incorrect, all the defines should've been called BCM4355 (not the
Cypress part number), and we probably need two firmware table entries
since (judging by the revision check elsewhere in that patch) there are
other revisions in the wild than the one Apple uses, and therefore there
should at the very least be a firmware name split at C1. It would then
be very helpful to know what revisions *do* exist and their correct naming.

If different PCI device IDs might need different firmware, then the
exiting firmware selection/table mechanism is insufficient.

> Happy New year to you. Thanks for clearly marking the rant. Makes it 
> easier to ignore, but let me get into this. I would not call bcmdhd the 
> downstream driver. It is a separate out-of-tree driver. Indeed resources 
> were pulled from brcm80211 development, but there always have been only 
> 2 or 3 people working on it. Me being the constant working mule and 
> these days only for 20% of my working hours to do the job. So you are 
> not really doing our job as we are not assigned to do so. I guess there 
> is no ROI for Broadcom or so it is perceived and there is no customer 
> pushing for it. That said I am always happy to help and clarify whatever 
> I can.

Is there any chance you can provide a list of chips/shipping revisions
and revision IDs, so we can stop guessing at the mappings in the
firmware table? Because this is effectively breaking userspace ABI every
time we make a change to an existing chip, as it can change the firmware
file name that userspace loads. This already happened with BCM4364,
where (at least) B2 and B3 revisions exist in the wild and we need
separate firmwares, yet it was added with a full mask, resulting in
people copying "the right firmware for them" manually and my patch to
split it into properly named firmwares will break those users.

- Hector
