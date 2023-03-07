Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D616AECB2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCGR5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCGR4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:56:48 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1A5A42CA;
        Tue,  7 Mar 2023 09:51:25 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327HpLNE009609;
        Tue, 7 Mar 2023 11:51:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678211481;
        bh=TeSXmU9DhjvVbGgHY346EmFzZWDOvALD/BX2vUw2yw8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=DlggNcNZgLKSvE4xZmQ5HNLdg7u0dC8nqGyTe9AzmVzc4o8nhndpJVcx0dwU3usNR
         pCeH8CcDxf7Lo8XW6TmZQkVXRE0tnHOa0I2OH/JphAPS0FhRTTsguqj1lRZQAQaHDJ
         CCIL3ysjft9/W6WE7a6axm1sudwFZM7KpXDUJk2w=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327HpLDR104963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 11:51:21 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 11:51:21 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 11:51:21 -0600
Received: from [128.247.81.39] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327HpLc0061869;
        Tue, 7 Mar 2023 11:51:21 -0600
Message-ID: <5124c165-d288-59f3-3dfb-9e5c203554cb@ti.com>
Date:   Tue, 7 Mar 2023 11:51:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/6] gpio: twl4030: Use devm_gpiochip_add_data() to
 simplify remove path
To:     Andy Shevchenko <andy@kernel.org>
CC:     Peter Tyser <ptyser@xes-inc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230307165432.25484-1-afd@ti.com>
 <20230307165432.25484-2-afd@ti.com> <ZAd4LcM4BOyRBWWb@smile.fi.intel.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <ZAd4LcM4BOyRBWWb@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 11:45 AM, Andy Shevchenko wrote:
> On Tue, Mar 07, 2023 at 10:54:28AM -0600, Andrew Davis wrote:
>> Use devm version of gpiochip add function to handle removal for us.
> 
> I do not see this change in the below code.
> Can you shed a light?
> 

Odd.. must have been lost in a rebase, will respin a v2.

Thanks,
Andrew

>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   drivers/gpio/gpio-twl4030.c | 16 ----------------
>>   1 file changed, 16 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
>> index c1bb2c3ca6f2..23f58bf3a415 100644
>> --- a/drivers/gpio/gpio-twl4030.c
>> +++ b/drivers/gpio/gpio-twl4030.c
>> @@ -492,18 +492,6 @@ static struct twl4030_gpio_platform_data *of_gpio_twl4030(struct device *dev,
>>   	return omap_twl_info;
>>   }
>>   
>> -/* Cannot use as gpio_twl4030_probe() calls us */
>> -static int gpio_twl4030_remove(struct platform_device *pdev)
>> -{
>> -	struct gpio_twl4030_priv *priv = platform_get_drvdata(pdev);
>> -
>> -	gpiochip_remove(&priv->gpio_chip);
>> -
>> -	/* REVISIT no support yet for deregistering all the IRQs */
>> -	WARN_ON(!is_module());
>> -	return 0;
>> -}
>> -
>>   static int gpio_twl4030_probe(struct platform_device *pdev)
>>   {
>>   	struct twl4030_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> @@ -581,12 +569,9 @@ static int gpio_twl4030_probe(struct platform_device *pdev)
>>   	if (ret < 0) {
>>   		dev_err(&pdev->dev, "could not register gpiochip, %d\n", ret);
>>   		priv->gpio_chip.ngpio = 0;
>> -		gpio_twl4030_remove(pdev);
>>   		goto out;
>>   	}
>>   
>> -	platform_set_drvdata(pdev, priv);
>> -
>>   	if (pdata->setup) {
>>   		int status;
>>   
>> @@ -615,7 +600,6 @@ static struct platform_driver gpio_twl4030_driver = {
>>   		.of_match_table = twl_gpio_match,
>>   	},
>>   	.probe		= gpio_twl4030_probe,
>> -	.remove		= gpio_twl4030_remove,
>>   };
>>   
>>   static int __init gpio_twl4030_init(void)
> 
