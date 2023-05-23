Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BB270E634
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbjEWUF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjEWUFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:05:55 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79422119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:05:53 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 1YGTqQZli8SAU1YGUqtl2T; Tue, 23 May 2023 22:05:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684872351;
        bh=/qnVISKWAXZmn6jEXPdze5Xj6qd0T4Dgd6h8vC+mfcc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=t1dh+jmR482GRURFMLHX3TH45TMiVwJO/YRzPkTDZBW9mml9ATt7EUN01FeX4eOlM
         Pzsznu124bZpiSGr8FwOmeXtcSvV5bxO1zjLQ7JyjfZixW0UNAouvatqe4VaGYJIhi
         lzzeo+/OPIvnFSUytrqD0OiXa4EB0YG4nrE9ihdWTqkuQPOqaI4fzNWKNPkHgwC42w
         I09+0uPof0sFrJJbggdkeeok57kvZLO2kL7x0kfpGg0m1pUGF/p6GFgPcashr9G23C
         xIZzG3OGtcCdl+scHMt0SYzVTHhRFRzE7UiCka5tROJV8jG+BjWLagBsNd23kfMQB0
         oj5GiiKHuCV2Q==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 23 May 2023 22:05:51 +0200
X-ME-IP: 86.243.2.178
Message-ID: <b9207257-b04f-ee2e-7025-015b0f22358a@wanadoo.fr>
Date:   Tue, 23 May 2023 22:05:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pinctrl:sunplus: Add check for kmalloc
Content-Language: fr, en-US
To:     andy.shevchenko@gmail.com,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Cc:     Wells Lu <wellslutw@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1684836688-9204-1-git-send-email-wellslutw@gmail.com>
 <ZGztCHNr1jmpFq0A@surfacebook>
 <1560e9c0e5154802ab020b9da846d65f@sphcmbx02.sunplus.com.tw>
 <ZG0V6_bUaz3Thy0q@surfacebook>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZG0V6_bUaz3Thy0q@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/05/2023 à 21:37, andy.shevchenko@gmail.com a écrit :
> Tue, May 23, 2023 at 05:39:51PM +0000, Wells Lu 呂芳騰 kirjoitti:
>>>> Fix Smatch static checker warning:
>>>> potential null dereference 'configs'. (kmalloc returns null)
> 
> ...
> 
>>>>   			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
>>>> +			if (!configs)
>>>
>>>> +				return -ENOMEM;
>>>
>>> "Fixing" by adding a memory leak is not probably a good approach.
>>
>> Do you mean I need to free all memory which are allocated in this subroutine before
>> return -ENOMEM?
> 
> This is my understanding of the code. But as I said... (see below)
> 
> ...
> 
>>>>   			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
>>>> +			if (!configs)
>>>> +				return -ENOMEM;
>>>
>>> Ditto.
> 
> ...
> 
>>> It might be that I'm mistaken. In this case please add an explanation why in the commit
>>> message.
> 
> ^^^
> 

Hmmm, not so sure.

Should be looked at more carefully, but
   dt_to_map_one_config		(in /drivers/pinctrl/devicetree.c)
     .dt_node_to_map
       --> sppctl_dt_node_to_map

Should dt_to_map_one_config() fail, pinctrl_dt_free_maps() is called
(see 
https://elixir.bootlin.com/linux/v6.4-rc1/source/drivers/pinctrl/devicetree.c#L281)

pinctrl_dt_free_maps() calls dt_free_map(), which calls .dt_free_map, so 
pinctrl_utils_free_map()
(see 
https://elixir.bootlin.com/linux/v6.4-rc1/source/drivers/pinctrl/sunplus/sppctl.c#L978)

Finally the needed kfree seem to be called from here.
(see 
https://elixir.bootlin.com/linux/v6.4-rc1/source/drivers/pinctrl/pinctrl-utils.c#L119)


*This should obviously be double checked*, but looks safe to me.


BUT, in the same function, the of_get_parent() should be undone in case 
of error, as done at the end of the function, in the normal path.
This one seems to be missing, should a memory allocation error occur.


Just my 2c,

CJ

