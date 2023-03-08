Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368026B0684
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjCHL7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjCHL7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:59:15 -0500
X-Greylist: delayed 1571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 03:59:14 PST
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7780782373;
        Wed,  8 Mar 2023 03:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=2K9uVgNLJ8zhyr40M8P3UHt1yzkrIUdnvgfd5nwEeNY=; b=dBTqazkMRHLJLmakcB17035K+L
        tDEWF4UinIZH6gy+nYiUN/ySLkuoVapqCz4w8MJxGmaYwUTxGPpRiW3soX60jBqp23kcIK/ua4JNI
        fHHGbDcrlcYxNPvS3M8GiXrCoej5acV8ZOfSxSh0BMg5SLCT4ap4padg8BLqsj+/UicmTso/gN7gy
        DaqM/7X0ZB4pYTkCBSwOPfno93EU6qmNJU91e/ANbQVOx1zeDTRAxyl5bsG0PXUYKHi3QIAkj6zvk
        8328ae6zn5apvi+CbECVhVm3pO04qoqeUCDZNiaOHD9S1aXwyK6NR7LzF9I7DyB6iRW0YjYkg1gy4
        sl1+BjhQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pZs2V-0007r9-PG; Wed, 08 Mar 2023 12:32:59 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pZs2V-000FRN-9y; Wed, 08 Mar 2023 12:32:59 +0100
Message-ID: <bf88f6f6-681e-866f-4bd4-8c9a80796ac5@metafoo.de>
Date:   Wed, 8 Mar 2023 03:32:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/2] hwmon: ina2xx: add optional regulator support
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308094024.14115-1-clamor95@gmail.com>
 <20230308094024.14115-3-clamor95@gmail.com>
 <378db0d7-4d5a-a445-3e1a-ee6d8da5a9e2@linaro.org>
 <CAPVz0n2KgUKi-m+kjvbxq8fA_G0+KNHtkNe4T0UGpmasMjWK2A@mail.gmail.com>
 <a1187c2e-122e-36d1-dddd-c7beba282800@roeck-us.net>
 <70325083-25B9-434F-9F48-9EE7AE28B550@gmail.com>
Content-Language: en-US
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <70325083-25B9-434F-9F48-9EE7AE28B550@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26835/Wed Mar  8 09:35:43 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 03:19, Svyatoslav Ryhel wrote:
>
> 8 березня 2023 р. 13:13:18 GMT+02:00, Guenter Roeck <linux@roeck-us.net> написав(-ла):
>> On 3/8/23 02:35, Svyatoslav Ryhel wrote:
>>> ср, 8 бер. 2023 р. о 12:25 Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> пише:
>>>> On 08/03/2023 10:40, Svyatoslav Ryhel wrote:
>>>>> Some devices may need a specific supply provided
>>>>> for this sensor to work properly, like p895 does.
>>>>>
>>>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>>>> ---
>>>>>    drivers/hwmon/ina2xx.c | 12 ++++++++++++
>>>>>    1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
>>>>> index 00fc70305a89..4a3e2b1bbe8b 100644
>>>>> --- a/drivers/hwmon/ina2xx.c
>>>>> +++ b/drivers/hwmon/ina2xx.c
>>>>> @@ -119,6 +119,7 @@ struct ina2xx_data {
>>>>>         long power_lsb_uW;
>>>>>         struct mutex config_lock;
>>>>>         struct regmap *regmap;
>>>>> +     struct regulator *vdd_supply;
>>>>>
>>>>>         const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS];
>>>>>    };
>>>>> @@ -656,6 +657,17 @@ static int ina2xx_probe(struct i2c_client *client)
>>>>>                 return PTR_ERR(data->regmap);
>>>>>         }
>>>>>
>>>>> +     data->vdd_supply = devm_regulator_get_optional(dev, "vdd");
>>>>> +     if (IS_ERR(data->vdd_supply))
>>>>> +             return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
>>>>> +                                  "failed to get vdd regulator\n");
>>>>> +
>>>>> +     ret = regulator_enable(data->vdd_supply);
>>>>> +     if (ret < 0) {
>>>>> +             dev_err(dev, "failed to enable vdd power supply\n");
>>>>> +             return ret;
>>>> And where is disable? On each error path, removal etc.
>>>>
>>> error path ok, should I create a remove function just to disable the regulator?
>>>
>> Use devm_add_action_or_reset().
>>
>> Guenter
>>
> That is good suggestion. Thanks!

There is a new function devm_regulator_get_enable(). It will both 
request the regulator and enable in and then automatically disable and 
free it when the device is removed.

The API can be slightly confusing in this regard. In your case you also 
want to use the non-optional API. The optional API is for cases where 
you need to know whether a regulator is connected or not. If you do not 
need to know use the non-optional API, if no regulator is specified the 
regulator framework will just a return a noop regulator as a 
placeholder. The optional version will actually return an error if no 
regulator is specified, so with your patch existing users of this driver 
will break.


