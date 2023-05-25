Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4727117FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjEYUUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjEYUUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:20:35 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6BC2B2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:20:31 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 2FqCqufk3dqvJ2FqCqE3j8; Thu, 25 May 2023 20:37:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685039858;
        bh=1V5pkMn4BMTp1h5OvBsWdGPSnHQ9uFThzMpgbp/eqHU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fNy/Ew0TL3Rj/aSaKcjnjwy4CdGuWN2o9IzlX/gRCdScUjpcHCS3nZIOlyXGzdkPN
         cT9Lkioinz6V03F/4avy10IBr6UBGLKrVBrcTId/D+5TNkZ5AovQpeIWn0ds234rKC
         y+RVkKechZA0SDSuc8ZJoKpuSNAc1Hfcf6HViSk2bHo74hX5dIGdi7LCpRcVG969a8
         WHiJp/UuC1+5cQpyeUAkD2YLhXRSe9mEd/KeZsrmx0PHzoIb7lPhSHTp8leA+W8pMj
         txmVFjlxTuEKp3i7JWyiIVUG2FdUJiVvLSrA2JyLVtW+L1pE/U22YjXljcyy0SB1PN
         50rOiVTKMkngQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 25 May 2023 20:37:38 +0200
X-ME-IP: 86.243.2.178
Message-ID: <dbb3c0bd-3b09-2b59-8cd1-2838b9880abf@wanadoo.fr>
Date:   Thu, 25 May 2023 20:37:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: RE: [PATCH] pinctrl:sunplus: Add check for kmalloc
To:     =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Wells Lu <wellslutw@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Janitors <kernel-janitors@vger.kernel.org>
References: <1684836688-9204-1-git-send-email-wellslutw@gmail.com>
 <ZGztCHNr1jmpFq0A@surfacebook>
 <1560e9c0e5154802ab020b9da846d65f@sphcmbx02.sunplus.com.tw>
 <ZG0V6_bUaz3Thy0q@surfacebook>
 <b9207257-b04f-ee2e-7025-015b0f22358a@wanadoo.fr>
 <dd0ea27640d2420eb3b521076c643919@sphcmbx02.sunplus.com.tw>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <dd0ea27640d2420eb3b521076c643919@sphcmbx02.sunplus.com.tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/05/2023 à 05:22, Wells Lu 呂芳騰 a écrit :
>> Le 23/05/2023 à 21:37, andy.shevchenko@gmail.com a écrit :
>>> Tue, May 23, 2023 at 05:39:51PM +0000, Wells Lu 呂芳騰 kirjoitti:
>>>>>> Fix Smatch static checker warning:
>>>>>> potential null dereference 'configs'. (kmalloc returns null)
>>>
>>> ...
>>>
>>>>>>    			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
>>>>>> +			if (!configs)
>>>>>
>>>>>> +				return -ENOMEM;
>>>>>
>>>>> "Fixing" by adding a memory leak is not probably a good approach.
>>>>
>>>> Do you mean I need to free all memory which are allocated in this
>>>> subroutine before return -ENOMEM?
>>>
>>> This is my understanding of the code. But as I said... (see below)
>>>
>>> ...
>>>
>>>>>>    			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
>>>>>> +			if (!configs)
>>>>>> +				return -ENOMEM;
>>>>>
>>>>> Ditto.
>>>
>>> ...
>>>
>>>>> It might be that I'm mistaken. In this case please add an
>>>>> explanation why in the commit message.
>>>
>>> ^^^
>>>
>>
>> Hmmm, not so sure.
>>
>> Should be looked at more carefully, but
>>     dt_to_map_one_config		(in /drivers/pinctrl/devicetree.c)
>>       .dt_node_to_map
>>         --> sppctl_dt_node_to_map
>>
>> Should dt_to_map_one_config() fail, pinctrl_dt_free_maps() is called (see
>> https://elixir.bootlin.com/linux/v6.4-rc1/source/drivers/pinctrl/devicetree.c#L281)
>>
>> pinctrl_dt_free_maps() calls dt_free_map(), which calls .dt_free_map, so
>> pinctrl_utils_free_map()
>> (see
>> https://elixir.bootlin.com/linux/v6.4-rc1/source/drivers/pinctrl/sunplus/sppctl.c#L97
>> 8)
>>
>> Finally the needed kfree seem to be called from here.
>> (see
>> https://elixir.bootlin.com/linux/v6.4-rc1/source/drivers/pinctrl/pinctrl-utils.c#L119
>> )
>>
>>
>> *This should obviously be double checked*, but looks safe to me.
>>
>>
>> BUT, in the same function, the of_get_parent() should be undone in case
>> of error, as done at the end of the function, in the normal path.
>> This one seems to be missing, should a memory allocation error occur.
>>
>>
>> Just my 2c,
>>
>> CJ
> 
> Thank you for your comments.
> 
>  From the report of kmemleak, returning -ENOMEM directly causes memory leak. We
> need to free any memory allocated in this subroutine before returning -ENOMEM.
> 
> I'll send a new patch that will free the allocated memory and call of_node_put()
> when an error happens.

Hi,
(adding Dan in copy because the initial report is related to smatch)

I don't use kmemleak, but could you share some input about its report?


I've not rechecked my analysis, but it looked promising.
Maybe Dan could also give a look at it and confirm your finding, or dig 
further with smatch to make sure that its static analysis was complete 
enough.

CJ


> 
> 
> Best regards,
> Wells Lu

