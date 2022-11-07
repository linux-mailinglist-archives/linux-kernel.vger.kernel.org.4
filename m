Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F71361F78A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiKGPZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiKGPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:25:51 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A29A1B3;
        Mon,  7 Nov 2022 07:25:50 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 175B184DF9;
        Mon,  7 Nov 2022 16:25:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667834748;
        bh=FPh/2Lps2gSNBBEpj2mp+HQ0XsRPC3xrI5k7dVky1aI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zhmfWzh6xmSA5xEeypcJ5w2NobW88mVxV86f9TGdXjDuHO9XZsBYcUQeOpzi1Z8vF
         dHAL5Q9o8Oat6qC2kDil6AyCzjvQI6MxGtFl+JM2A3+0DC2USi4v3riVwIFbXTam4j
         cD+hGsZ2DdEAZhQayqM/mGKOtQTfhrYCs2OPTrM77tU8VaexCDvflnwj2XCS79Cam0
         c0TD5lwDd4dMCSe/vJHKMoqeetJkspXqzZmXaaxTe+aWzyxm5Be5rqbAThA0hbYu78
         aDkFnz6EpCaJ14HSijQet04loLdGw04SyJ156ahh4EP8FZy/8Xqc0BUMNa+eKO7lni
         CtaS04dY0n7pg==
Message-ID: <f0e80866-9f7c-4a95-3dbc-c2950162c703@denx.de>
Date:   Mon, 7 Nov 2022 16:25:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] extcon: usbc-tusb320: Call the Type-C IRQ handler only if
 a port is registered
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
References: <20221107144810.588755-1-y.oudjana@protonmail.com>
 <49a553b3-bd79-7845-41c4-2b8a3a3d4932@denx.de>
 <AGGZKR.PDKF4SHFJVZC3@gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <AGGZKR.PDKF4SHFJVZC3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 16:02, Yassine Oudjana wrote:
> 
> On Mon, Nov 7 2022 at 15:51:55 +01:00:00, Marek Vasut <marex@denx.de> 
> wrote:
>> On 11/7/22 15:48, Yassine Oudjana wrote:
>>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>
>>> Commit bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
>>> added an optional Type-C interface to the driver but missed to check
>>> if it is in use when calling the IRQ handler. This causes an oops on
>>> devices currently using the old extcon interface. Check if a Type-C
>>> port is registered before calling the Type-C IRQ handler.
>>>
>>> Fixes: bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
>>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>> ---
>>>   drivers/extcon/extcon-usbc-tusb320.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/extcon/extcon-usbc-tusb320.c 
>>> b/drivers/extcon/extcon-usbc-tusb320.c
>>> index 41041ff0fadb..037bc11b2a48 100644
>>> --- a/drivers/extcon/extcon-usbc-tusb320.c
>>> +++ b/drivers/extcon/extcon-usbc-tusb320.c
>>> @@ -327,7 +327,14 @@ static irqreturn_t tusb320_irq_handler(int irq, 
>>> void *dev_id)
>>>           return IRQ_NONE;
>>>         tusb320_extcon_irq_handler(priv, reg);
>>> -    tusb320_typec_irq_handler(priv, reg);
>>> +
>>> +    /*
>>> +     * Type-C support is optional for backward compatibility.
>>
>> It's the other way around, extcon is the legacy, type-c is the new, 
>> right ?
> 
> Type-C is the new one, yes. This comment is somewhat similar to the one 
> in tusb320_typec_probe():
> 
> /* The Type-C connector is optional, for backward compatibility. */

Ahhh, The Type-C connector support is indeed optional to avoid breaking 
any of the older systems which only use/provide extcon.

> Perhaps a better way to say this in both comments would be "to maintain" 
> instead of "for".

I think best just drop the "for backward compatibility" altogether, like so:

/*
  * Type-C support is optional. Only call the Type-C handler if a
  * port had been registered previously.
  */
