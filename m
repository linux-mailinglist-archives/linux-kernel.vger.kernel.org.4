Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0397A65B9E4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 04:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbjACD4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 22:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjACD4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 22:56:11 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBFD105;
        Mon,  2 Jan 2023 19:56:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6956041DF4;
        Tue,  3 Jan 2023 03:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672718166; bh=0co2iDbnvPtc0hBv0PZI8JkI2F1BtjH5BwsUTUdoWwo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=F/gg5uQz2GRvyTw8JUQ9eD8pT3T7lNap/jZ4jF+9I3v6rKQc8R5NaIqQQRZQHwhwC
         q2D21Wp9zpgw3YcmU2QA08cc1Qe9auVnTvF97uOoKszA/jeZzPhFz1jU6ijnfy7Hec
         W5PIKQNBb48WwH1mCKTNLG/MB4PZOZZC2AsPgqDbqKWGpJUPcCgzTx2DB9kzj/lhK9
         teAKQRabAaukXjSs+bNMcqYiJIB4o31ZfflLmRJqxORwdtrk0mChMtSYFo4nwUEbUw
         SIgEbbp5nc3UouzEKNk2LtZK/PSP81XlY0rLBtkUUFYVln4ZTer4p1siGsRuCkzCQ+
         8Hkpn2mrtpOaw==
Message-ID: <3785835b-164b-28d1-6905-85454cabb69d@marcan.st>
Date:   Tue, 3 Jan 2023 12:55:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] brcmfmac: Use separate struct to declare firmware
 names for Apple OTP chips
Content-Language: en-US
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
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
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <18573bd1a38.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
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

On 2023/01/03 3:27, Arend Van Spriel wrote:
> On January 2, 2023 4:15:41 PM Hector Martin <marcan@marcan.st> wrote:
> 
>> On 02/01/2023 23.40, Aditya Garg wrote:
>>> From: Aditya Garg <gargaditya08@live.com>
>>>
>>> Commit 'dce45ded7619' added support for 89459 chip pcie device. It uses the
>>> BRCM4355 chip which is also found in Apple hardware. However this commit
>>> causes conflicts in the firmware naming between Apple hardware, which
>>> supports OTP and other non-Apple hardwares. So, this patch makes these
>>> Apple chips use their own firmware table so as to avoid possible conflicts
>>> like these in the future.
>>
>> I think my reply to Arend flew over your head.
>>
>> My point was that I'd rather have the Broadcom/Cypress people actually
>> answer my question so we can figure out how to do this *properly*,
>> instead of doing "safer-but-dumb" things (like this patch) because we
>> just don't have the information to do it properly.
> 
> Fair enough. Can you accurately (re)state your question and I will try to 
> answer it.

As per my original email: Is the CYW89459 just a rebrand of the BCM4355,
or just a subset? Can we consider them equivalent, and equivalent to the
Apple part (BCM4355C1 / revision 12)?

More specifically:
- What BCM4355 variants exist in the wild, and what are their PCI device
IDs and revision IDs?
- Is a single firmware nominally intended to be compatible with all of
those variants? Does that include the CYW89459 branded parts?
- If CYW89459 is a rebrand of BCM4355, is it complete, or are there
still chips being sold as BCM4355?

Even more specifically, bcmdhd has these device IDs:

#define BCM4355_D11AC_ID    0x43dc  /* 4355 802.11ac dualband device */
#define BCM4355_D11AC2G_ID  0x43fc  /* 4355 802.11ac 2.4G device */
#define BCM4355_D11AC5G_ID  0x43fd  /* 4355 802.11ac 5G device */

But the patch I'm replying to uses PCI ID 0x4355, which instead should be:

#define BCM43237_D11N_ID    0x4355  /* 43237 802.11n dualband device */
#define BCM43237_D11N5G_ID  0x4356  /* 43237 802.11n 5GHz device */

So what's up with the BCM43237? Is that a 4355 variant? Is this what got
rebranded as CYW89459? Is it firmware-compatible with the others?

<rant>

I'm going to be honest here: I'm quite saddened by the state of brcmfmac
and Broadcom's neglect of this driver. Other than the Apple OTP /
firmware selection shenanigans, everything else I'm having to implement
to support Apple machines are features that Broadcom's downstream bcmdhd
driver *already* supports on non-Apple machines, not Apple-specific. Not
only that, people are asking for modern WiFi features like newer crypto
modes that bcmdhd supports but brcmfmac doesn't. It seems clear that
Broadcom isn't interested in maintaining this driver and updating it to
support newer chips and features. So I'm basically doing your job for
you all. Which is fine, but if I'm going to be in charge of implementing
all this stuff for you, *please* help me by at least clarifying the
device variant / firmware feature related issues, because getting that
wrong will cause regressions or firmware naming scheme breaks down the
line, and that sucks for users.

</rant>

- Hector
