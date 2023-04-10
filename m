Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676876DC7F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjDJOkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDJOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:40:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8437730DA;
        Mon, 10 Apr 2023 07:40:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w11so5015944pjh.5;
        Mon, 10 Apr 2023 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681137639; x=1683729639;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A31u6jRSepHToKl1ZHJ1t1wEod+/nXxHkMwASeYu3RU=;
        b=BdufJJlPdoAH4B+HsqoNIN+mXLqOoiFqwUgIFBVcB2aICOtIllUNyANmVmxhfuFIhu
         z/eOAyChh7PEpmso/t01uSqOjLVFbdX2HI8EqjY+vp/xMuN3YzkNdtwBxQTHqAY+46zU
         KUH2tJ19k5oYLYRaNw+vTZQVDVHu2jIHyFSOjkHH4/uwRzJOiYqJDuQEHZVIZUm2e4fM
         sE0rL6CS1YPpnp4Z3GxHAmMugLCG+RUWtdNWJ0lvuPka/TueYgUg24sN9AKBdX/jqJYD
         uTlTF+umdHbR9/1CucIJbdA+Lv/3ankEad/Ul7BqedxgWM5159+ZqCoSWX1L7IYBFY+M
         52Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681137639; x=1683729639;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A31u6jRSepHToKl1ZHJ1t1wEod+/nXxHkMwASeYu3RU=;
        b=ae6GVrqViwP6tdd3ztiS58f9dYlFJcKyBpdviyxfhul6Q6g4LuuZplrr1de98N4R/z
         6Ibvg4Iek+p4XW176bPbkt71WHbEhfCqmbrG0gD8N/EeAsF7opEJeg5wm7QehUIz6jjC
         FhhwVyDfT9wMva9W0466FZIWsE2mf0ofXpUO81DjEwY1wfDQsMv9EWA6RJNX1pXnWMLz
         Zy0mf4Ob7nNlVfAz9vGQnBKRpQ6RF3dJGDUqL+0xQIui8F3Wgz7vE4+VOr2BgvP3/mO0
         +YSXNk4Xxc2QIm7W9+GKyhrR+Vawef34RxBBV9OPWPgBfOCtjVN4AsdP6O++Hh0bU3/Q
         eLgQ==
X-Gm-Message-State: AAQBX9dYlTN+20TciWWy6Na/L+e2bo9+FxVlnh+xgRxSQQb1UevTAjvl
        fxyg2i7FbolF7AVVcdkUOuY=
X-Google-Smtp-Source: AKy350Y/Ji/yq7bdgpV8uPXL50TjXJvKLJJLww0gdapehHa/Bdh/6wQgfykIiZp/C4lj0bQGDDXWdQ==
X-Received: by 2002:a17:902:e5c7:b0:1a1:7da3:ef5b with SMTP id u7-20020a170902e5c700b001a17da3ef5bmr12986261plf.7.1681137638805;
        Mon, 10 Apr 2023 07:40:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j20-20020a170902759400b0019309be03e7sm7949646pll.66.2023.04.10.07.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 07:40:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7c71d182-2ac5-b01e-2875-5060fb509056@roeck-us.net>
Date:   Mon, 10 Apr 2023 07:40:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, Sascha Hauer <sha@pengutronix.de>,
        jerome Neanne <jneanne@baylibre.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
 <20230328150335.90238-2-Naresh.Solanki@9elements.com>
 <c88d3cdd-fb2f-c3ac-a9e8-e49f8e98b811@gmail.com>
 <17934bff-f728-d57a-c3c8-956634bd48c8@roeck-us.net>
 <3be67394-6082-1aeb-8a8d-90149217bdc7@gmail.com>
 <aea044ab-3a83-2369-aff7-5ef153618619@roeck-us.net>
 <0672fe4d-7293-4374-9186-29b008e5f8a2@sirena.org.uk>
 <CANhJrGO3X7pSsMBg6Gtf-q3=_JiCX4Qs=pGudL=etooM2F676g@mail.gmail.com>
 <d6a3ca82-7245-45e1-b8ff-a9970671b04f@sirena.org.uk>
 <CANhJrGMkwi1TVW_wGw=Boj1vRO_wGrd9=atOxKfbbdM4cwPGsw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/3] hwmon: (pmbus/core): Add regulator event support
In-Reply-To: <CANhJrGMkwi1TVW_wGw=Boj1vRO_wGrd9=atOxKfbbdM4cwPGsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 01:19, Matti Vaittinen wrote:
> to 6. huhtik. 2023 klo 16.43 Mark Brown (broonie@kernel.org) kirjoitti:
>>
>> On Thu, Apr 06, 2023 at 11:00:02AM +0300, Matti Vaittinen wrote:
>>> ke 5. huhtik. 2023 klo 18.19 Mark Brown (broonie@kernel.org) kirjoitti:
>>>> On Wed, Apr 05, 2023 at 07:18:32AM -0700, Guenter Roeck wrote:
> 
>>>> It can also try to avoid
>>>> interacting with hardware if that might not work.
>>
>>> It'd be great to have documentation / specification for sending and/or
>>> handling the regulator events. I don't think we currently have such.
>>> As far as I understand, the notifications can be picked up by all
>>> consumers of a regulator. I am a bit worried about:
>>> a) Situations where notification handlers 'collide' by doing 'actions'
>>> which are unexpected by other handlers
>>
>> I'm not sure what you're expecting there?  A device working with itself
>> shouldn't disrupt any other users.
> 
> I have no concrete idea, just a vague uneasy feeling knowing that
> devices tend to interact with each other. I guess it is more about the
> amount of uncertainty caused by my lack of knowledge regarding what
> could be done by these handlers. So, as I already said - if no one
> else is bothered by this then I definitely don't want to block the
> series. Still, if the error handling should be kept internal to PMBus
> - then we should probably either say that consumer drivers must not
> (forcibly) turn off the supply when receiving these notifications - or
> not send these notifications from PMBus and allow PMBus to decide
> error handling internally. (Again, I don't know if any in-tree
> consumer drivers do turn off the supply regulator in error handlers -
> but I don't think it is actually forbidden). Or am I just making  a
> problem that does not exist?
> 

For my part I (still) don't understand why this is considered a problem
for this driver but not for all the other drivers reporting various
error conditions to the regulator subsystem. At least some of them
also have programmable reaction to such error conditions.

Guenter

