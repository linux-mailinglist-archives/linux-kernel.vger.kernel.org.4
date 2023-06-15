Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CA2730F12
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbjFOGHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbjFOGHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:07:20 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC40A26B0;
        Wed, 14 Jun 2023 23:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc
        :To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bOx+x+aNkJZYtlU42uTvVfhpkabjU4hq9FT92avJTsw=; b=ODu6UM+xWmOeodIoMdmuDTF96r
        C54Gahhiy8PbGgHLVd/SldQWCof1ghe4VGpqCTouqh3DSLGENgukeArgLJIvv3YSAbuVl60LdC/7X
        M3Rb2TqKLqclCI6UMBp8YJbHt1KiNEu4S7TWRD2lwSaA1mhsmxI8dr186LFmjL6eDXeu6aAQpqQli
        ZE6cKFlR14a0S/4VavqRzfNxWK5xNjBXaDzg532tNgB9mSRkHnhBEfrsz8pSA3UMJL67lQL1SKoAj
        WitHud0Od9/3AgK+R540dPJGJeEWhx6AwhrP2CdO6xMWzC+0EObUWp8AHg/linnE/pHOppviqgjVr
        xi+MppbQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:51988 helo=[192.168.69.84])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <andrej.picej@norik.com>)
        id 1q9g7r-005nfQ-01;
        Thu, 15 Jun 2023 08:06:30 +0200
Message-ID: <31ed2ed3-8b59-3903-c491-a10a4702c23d@norik.com>
Date:   Thu, 15 Jun 2023 08:06:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] rtc: rv3028: Improve trickle charger logic
Content-Language: en-GB
From:   Andrej Picej <andrej.picej@norik.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, upstream@phytec.de
References: <20230608090446.2899646-1-andrej.picej@norik.com>
 <20230608093155cedff41a@mail.local>
 <73bc2f5c-bdae-e57f-73ab-db5e453e0c7f@norik.com>
In-Reply-To: <73bc2f5c-bdae-e57f-73ab-db5e453e0c7f@norik.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8. 06. 23 12:35, Andrej Picej wrote:
> Hi Alexandre,
> 
> On 8. 06. 23 11:31, Alexandre Belloni wrote:
>> Hello,
>>
>> On 08/06/2023 11:04:46+0200, Andrej Picej wrote:
>>> +    ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &val_old);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    /* mask out only trickle charger bits */
>>> +    val_old = val_old & (RV3028_BACKUP_TCE | RV3028_BACKUP_TCR_MASK);
>>> +
>>>       /* setup trickle charger */
>>> -    if (!device_property_read_u32(&client->dev, 
>>> "trickle-resistor-ohms",
>>> -                      &ohms)) {
>>> +    if (device_property_read_u32(&client->dev, 
>>> "trickle-resistor-ohms", &ohms)) {
>>> +        /* disable the trickle charger */
>>> +        val = 0;
>>
>> You can't do that, this will break existing users that may set the
>> trickle charger from their bootloader for example.
> 
> hmm...ok I understand that idea. I thought that might be a problem. I 
> guess keeping default as it is has a higher priority.
> 
> What do you say if setting this property to 0 (or maybe -1) disabled the 
> trickle charger?
> So if users add:
> 
> trickle-resistor-ohms = <0>;
> or
> trickle-resistor-ohms = <(-1)>;
> 
> this would mean disable the trickle charger?
> 
> I know it is far from optimal, but this would solve both things:
> * not braking existing implementation,
> * users could disable the trickle charger.
> 
> What do you say.

Gentle ping. Would this be something you would consider?

Thanks,
Andrej

> 
> Thanks for your review.
> 
> Best regards,
> Andrej
> 
>>
>>> +    } else {
>>>           int i;
>>>           for (i = 0; i < ARRAY_SIZE(rv3028_trickle_resistors); i++)
>>> @@ -947,15 +957,21 @@ static int rv3028_probe(struct i2c_client *client)
>>>                   break;
>>>           if (i < ARRAY_SIZE(rv3028_trickle_resistors)) {
>>> -            ret = rv3028_update_cfg(rv3028, RV3028_BACKUP, 
>>> RV3028_BACKUP_TCE |
>>> -                         RV3028_BACKUP_TCR_MASK, RV3028_BACKUP_TCE | 
>>> i);
>>> -            if (ret)
>>> -                return ret;
>>> +            /* enable the trickle charger and setup its resistor 
>>> accordingly */
>>> +            val = RV3028_BACKUP_TCE | i;
>>>           } else {
>>>               dev_warn(&client->dev, "invalid trickle resistor 
>>> value\n");
>>>           }
>>>       }
>>> +    /* only update EEPROM if changes are necessary */
>>> +    if (val_old != val) {
>>> +        ret = rv3028_update_cfg(rv3028, RV3028_BACKUP, 
>>> RV3028_BACKUP_TCE |
>>> +                    RV3028_BACKUP_TCR_MASK, val);
>>> +        if (ret)
>>> +            return ret;
>>> +    }
>>> +
>>>       ret = rtc_add_group(rv3028->rtc, &rv3028_attr_group);
>>>       if (ret)
>>>           return ret;
>>> -- 
>>> 2.25.1
>>>
>>
