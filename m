Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E346659F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjAKLY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjAKLYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:24:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B58C178B8;
        Wed, 11 Jan 2023 03:24:19 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E9B476602D94;
        Wed, 11 Jan 2023 11:24:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673436258;
        bh=9716wfRPFGOMs2DfirAMEiT8iDV6vFXibBOCO8LljYQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VLXPwvkFWpaY5B8KiMxxfHYdCj4qvsGayFP32SHSuMUrmiTrr5Lgpw2+ixur1a0dc
         JinECQxCjip9zpnIDZhog2Xy5Jn0ocW2mnVfaohx9+zVIx8+BPtvKiFWC5A0Am+m3O
         HqEfYorBrEsILwWVkuS6WplZJ/VhUloUtExalSLTUzB+NlnPOvcs37V7qN8h/+QFfP
         7j5+jvgHMPmUeawX0DCWdoPZ68pSHeU0Sh7YipKHGoGuxeuGYOQmYdHcUOiDmBeBbw
         TRpbPy6mGUW1JtW3Xr0UmpaYjnd2+s2FGjBQ24CUaJ68bnqC9YFMSaA/f7JAlB8rWn
         TIHJ0hUA0ok8A==
Message-ID: <d3a71fe5-d631-9390-1bc2-7aaad834bec8@collabora.com>
Date:   Wed, 11 Jan 2023 12:24:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] usb: gadget: u_ether: Don't warn in
 gether_setup_name_default()
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20230106161759.66019-1-jonathanh@nvidia.com>
 <87cab5a1-a122-2b10-43b4-7a5819ff55ef@collabora.com>
 <e1a29bfd-7553-ec43-431e-0828191d2127@nvidia.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <e1a29bfd-7553-ec43-431e-0828191d2127@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

W dniu 11.01.2023 o 11:35, Jon Hunter pisze:
> 
> On 10/01/2023 16:31, Andrzej Pietrasiewicz wrote:
>> Hi,
>>
>> Hasn't there been a similar patch already?
> 
> There could be, but I was not aware. Do you happen to have a link to it?

Nope, I only rely on my memory, which can obviously be faulty.

> 
>> W dniu 6.01.2023 o 17:17, Jon Hunter pisze:
>>> The function gether_setup_name_default() is called by various USB
>>> ethernet gadget drivers. This function always generates the MAC address
>>> for the ethernet gadget device and always prints a warning when
>>> generating the MAC address. Given that these messages are expected, make
>>> these prints informational instead of warnings.
>>>
>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>> ---
>>>   drivers/usb/gadget/function/u_ether.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/function/u_ether.c 
>>> b/drivers/usb/gadget/function/u_ether.c
>>> index 8f12f3f8f6ee..c19d66cd1446 100644
>>> --- a/drivers/usb/gadget/function/u_ether.c
>>> +++ b/drivers/usb/gadget/function/u_ether.c
>>> @@ -845,13 +845,13 @@ struct net_device *gether_setup_name_default(const char 
>>> *netname)
>>>       snprintf(net->name, sizeof(net->name), "%s%%d", netname);
>>>       eth_random_addr(dev->dev_mac);
>>> -    pr_warn("using random %s ethernet address\n", "self");
>>> +    pr_info("using random %s ethernet address\n", "self");
>>
>> As far as I can tell this function is called by all Ethernet gadgets,
>> and using random Ethernet addresses is the default behavior for all of them,
>> including legacy gadgets. Why to inform about the default situation happening?
>> So in fact maybe it would be better to eliminate the pr_warn() altogether,
>> instead of replacing it with pr_info()? If the user does not care to
>> explicitly set some non-default address(es), why would she care to know
>> that a randomly selected address has been chosen? Note that learning
>> _what_ specific address has been chosen is perfectly doable without
>> these pr_info() calls.
> 
> 
> That would be fine with me. This print has been there for a long time and so I 
> figured people wanted some sort of message. I would be happy to remove.

It has. Maybe it's been a mistake?

A properly working driver should be silent. In case of Ethernet gadgets
using random MAC addresses is a proper (and default) behavior.

I think it's worth trying to just remove pr_warn(). Or, at least,
change to pr_debug(), because these messages look more like
debugging messages no regular user should be interested in.

There's also the maintainer who can have his say.

@Greg?

As a side note, there's quite a lot of cleanup needed in gadgets' messaging.

Regards,

Andrzej

> 
> Jon
> 

