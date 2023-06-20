Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50805737285
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjFTRRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjFTRRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:17:09 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A68DE65
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:17:06 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id BeyRq9Ac9Axl5BeySqLWtt; Tue, 20 Jun 2023 19:17:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1687281425;
        bh=99hiLLnAyI5yDRgBpH9IVWLw2LVj2GwUR2aCEsKndXY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=rDvZx7HN/iruLYrTntNDAskOWqRRTycBqIqYGvcSdq/10hfbHinNiEEQw6CfQtgOj
         hU5kqVgOfMlDGDT8sq7LK29UrsS7KxHfBd9GKJlN9RUuchiXxC+aH5seNscmODDNXs
         7gt4hVyfA7hGZyBRWoqtg6W6mwxSGmVmAmPhdwjE/IGrBINMoPRw9rXMp9WWy2NHCx
         o3V0CLkfGgaz/yfsjVLd+wHHqQo6B49um1pve8Db6kpC2ox12e9u/Z5vIxaPiLOe2x
         eOXYaR6fTeypLQOUA0VJfi/uuZFFuhTBUSXdNZIxtYULL4dVnb/qvV3fyiUFMvWzaN
         qHJCCo6KCPK/g==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 Jun 2023 19:17:05 +0200
X-ME-IP: 86.243.2.178
Message-ID: <458e18b0-cdf7-1a27-ed18-00dd6858615e@wanadoo.fr>
Date:   Tue, 20 Jun 2023 19:16:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] gnss: Use devm_regulator_get_enable_optional()
To:     Johan Hovold <johan@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <62effa7aa1a2023a77709e6416c57d9cb79a5ccc.1686995765.git.christophe.jaillet@wanadoo.fr>
 <ZJFqCQ8bbBoX3l1g@hovoldconsulting.com>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZJFqCQ8bbBoX3l1g@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20/06/2023 à 10:57, Johan Hovold a écrit :
> On Sat, Jun 17, 2023 at 11:57:09AM +0200, Christophe JAILLET wrote:
>> Use devm_regulator_get_enable_optional() instead of hand writing it. It
>> saves some line of code.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Note that regulator_disable() is now called after gnss_serial_free() in
>> the error handling path of the probe and in the remove function, but it
>> looks harmless to me.
> 
> Yeah, that bit should be fine.
> 
>> ---
>>   drivers/gnss/mtk.c | 26 ++++----------------------
>>   1 file changed, 4 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
>> index c62b1211f4fe..d3d31295d4e0 100644
>> --- a/drivers/gnss/mtk.c
>> +++ b/drivers/gnss/mtk.c
>> @@ -17,7 +17,6 @@
>>   #include "serial.h"
>>   
>>   struct mtk_data {
>> -	struct regulator *vbackup;
>>   	struct regulator *vcc;
>>   };
>>   
>> @@ -87,30 +86,16 @@ static int mtk_probe(struct serdev_device *serdev)
>>   		goto err_free_gserial;
>>   	}
>>   
>> -	data->vbackup = devm_regulator_get_optional(&serdev->dev, "vbackup");
>> -	if (IS_ERR(data->vbackup)) {
>> -		ret = PTR_ERR(data->vbackup);
>> -		if (ret == -ENODEV)
>> -			data->vbackup = NULL;
>> -		else
>> -			goto err_free_gserial;
>> -	}
>> -
>> -	if (data->vbackup) {
>> -		ret = regulator_enable(data->vbackup);
>> -		if (ret)
>> -			goto err_free_gserial;
>> -	}
>> +	ret = devm_regulator_get_enable_optional(&serdev->dev, "vbackup");
>> +	if (ret)
>> +		goto err_free_gserial;
> 
> But this breaks the driver as the new helper still returns -ENODEV when
> the optional is resource is not present.

Ouch!

Thanks for the feedback. I urgently need to double check some other 
similar proposals I've made.

Sorry for the broken patch :(

CJ

> 
> Wolfram already suggested using this new helper here:
> 
> 	https://lore.kernel.org/lkml/20230523064310.3005-3-wsa+renesas@sang-engineering.com
> 
> and also got the error handling right even if that patch will require a
> respin for other reasons.
> 
> As I mentioned in my reply to Wolfram, I'm generally sceptical of
> helpers like this one, but in this case where there are no dependencies
> on other resources I guess it's ok.
> 
> Johan
> 

