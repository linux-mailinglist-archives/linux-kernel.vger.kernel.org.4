Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F361F70F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiKGPDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiKGPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:02:46 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8806300;
        Mon,  7 Nov 2022 07:02:44 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs21so16655365wrb.4;
        Mon, 07 Nov 2022 07:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WeHFAdZZTdn4mbGrD+QJCE0iLEhqlSNhWrz5LG27594=;
        b=O3n9G+wrRQheCpEvGuTOI6m1x1jCcOwfwcQhMJiGCXYDohvZRuuQHirtkTrdsdhCN5
         0EjchF5Q9ydSY+fysinpbM0Rl7G3yUZ2NK6rSEf+jSgGU0Mi9iTO/DKktsLTIjW2iDaI
         Hq8zQdKCC7c9iHRSKUW/hxWuA8bED1IaevzhXm+g3QbJ1lSeI+Q8SfntfEY15v2MKTn7
         fs7dMm1LdVLPlskYHf328LU78/UWErFFt5TIdQ/THeMDVb4w7O6rch4IBdayLEISo5J0
         Va4UtbxF6z8GKcx/ll3DB+iTeTk1fQMkm5jeKKS6LEG1D82+Cs3K2mL3r0T52PnkTwrv
         Gv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WeHFAdZZTdn4mbGrD+QJCE0iLEhqlSNhWrz5LG27594=;
        b=6XkpVjP6STjAmkZyTlAbbbeIp8M6TyWJEzOcYldEHDm6BqRP/mknkDRwUYIPejqgGi
         ljA++4tdm4eMGMHNZMk6Qx/CzKoxLXN9fLfyEIHm0LRTIbcinMJ1dO1gFWnby+Pw92GO
         lLmXk+Csxcj8O0H6PZSNTsUbLLMv4oMOt7qCBizJoEY+iOIpucEEQoM9axOa2ZkS63Y6
         1RoS0Y7O9KX0kcGoL/v9lCD9lK8a1GIlMtFA3chVGRNp9WI3RBoJUNsVC9M0vCHUhRFr
         MJYouwFpAAuupjuymaEupWVYdPzpTpgw5h6oKoFb6wRJDQJOH8yXUg+B9C74Wb0byoMn
         K+dg==
X-Gm-Message-State: ACrzQf1SxsYKDEEYmQb1ZJ/0N1ODJojfbRPEj5BvbP0svyeuy9kxs398
        NrQOlI7sZzi2BNRomydI3HI=
X-Google-Smtp-Source: AMsMyM7KKAl0zTuhuqqNa1+ra5tSWFKFoNiBKUDe3ZWRZG2ubssOWqHXKGBFQ7HKkxKEHKPWxXtTkA==
X-Received: by 2002:adf:fd4a:0:b0:236:87bc:a900 with SMTP id h10-20020adffd4a000000b0023687bca900mr30943428wrs.706.1667833363524;
        Mon, 07 Nov 2022 07:02:43 -0800 (PST)
Received: from [10.32.3.204] ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id u8-20020adfeb48000000b002366b17ca8bsm8882802wrn.108.2022.11.07.07.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:02:43 -0800 (PST)
Date:   Mon, 07 Nov 2022 18:02:34 +0300
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH] extcon: usbc-tusb320: Call the Type-C IRQ handler only if
 a port is registered
To:     Marek Vasut <marex@denx.de>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alvin =?iso-8859-2?q?=A9ipraga?= <alsi@bang-olufsen.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Message-Id: <AGGZKR.PDKF4SHFJVZC3@gmail.com>
In-Reply-To: <49a553b3-bd79-7845-41c4-2b8a3a3d4932@denx.de>
References: <20221107144810.588755-1-y.oudjana@protonmail.com>
        <49a553b3-bd79-7845-41c4-2b8a3a3d4932@denx.de>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Nov 7 2022 at 15:51:55 +01:00:00, Marek Vasut <marex@denx.de> 
wrote:
> On 11/7/22 15:48, Yassine Oudjana wrote:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>> Commit bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
>> added an optional Type-C interface to the driver but missed to check
>> if it is in use when calling the IRQ handler. This causes an oops on
>> devices currently using the old extcon interface. Check if a Type-C
>> port is registered before calling the Type-C IRQ handler.
>> 
>> Fixes: bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> ---
>>   drivers/extcon/extcon-usbc-tusb320.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/extcon/extcon-usbc-tusb320.c 
>> b/drivers/extcon/extcon-usbc-tusb320.c
>> index 41041ff0fadb..037bc11b2a48 100644
>> --- a/drivers/extcon/extcon-usbc-tusb320.c
>> +++ b/drivers/extcon/extcon-usbc-tusb320.c
>> @@ -327,7 +327,14 @@ static irqreturn_t tusb320_irq_handler(int irq, 
>> void *dev_id)
>>   		return IRQ_NONE;
>>     	tusb320_extcon_irq_handler(priv, reg);
>> -	tusb320_typec_irq_handler(priv, reg);
>> +
>> +	/*
>> +	 * Type-C support is optional for backward compatibility.
> 
> It's the other way around, extcon is the legacy, type-c is the new, 
> right ?

Type-C is the new one, yes. This comment is somewhat similar to the one 
in tusb320_typec_probe():

/* The Type-C connector is optional, for backward compatibility. */

Perhaps a better way to say this in both comments would be "to 
maintain" instead of "for".

> 
>> +	 * Only call the Type-C handler if a port had been registered
>> +	 * previously.
>> +	 */
>> +	if (priv->port)
>> +		tusb320_typec_irq_handler(priv, reg);
>>     	regmap_write(priv->regmap, TUSB320_REG9, reg);
> 
> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Thanks!

Thanks for the quick review!
Yassine



