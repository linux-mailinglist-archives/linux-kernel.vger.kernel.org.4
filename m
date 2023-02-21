Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFFD69E5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjBURQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjBURP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:15:59 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172EC1DB9E;
        Tue, 21 Feb 2023 09:15:49 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id d12so2402104ioe.10;
        Tue, 21 Feb 2023 09:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=l/TzWWvVuPq5evGqSb0iqFb4amroO0mXgoi8cE3IP+o=;
        b=NocRTBZ3U5XwcGyv8zx8mD4mBGVqBJNZtDWPQPt33asM1VtttoKHYPcNRR1UCezyzC
         TYd3C94kPoSKVUia2gcV5U5VrEcG6DHEXMffA9rTa8voFdYgquMKAMYkpNzDINBrtssB
         X7y5IScdFw40IcR6Vcdhu2aWqg43Gcc6dENGyw4lC58E2y628KlIK/g2Pcjp4SsrmFhf
         Cec7ddt9+IKFqLtoCGr4t0VYEvo6uCVBaeyVqzbTyePJdjd0N4ZDeqYWvutV2WgqSkZt
         lf7L0DyyAjyw9GQeWd7EQQUrqfY8EXTmYiu3UCL55d8mrtHQH8YLCvaLLL8M31j4W1YI
         BlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/TzWWvVuPq5evGqSb0iqFb4amroO0mXgoi8cE3IP+o=;
        b=mnaBlN+U1pfhbUNr8HTmXg5BKo9TdGHRH1S0yHhudTgDNwSHXiA4TED054e3Ie7vSw
         jHGO7Q1maXhjA7QLc8u9RmSfDy+otA6Dj/vptV+sSISQgON5kK7uRRsf1t82ELr+LroV
         5FOraXCO+DthywH5wizWEH8d+cusNqY6HDsyw3Ct+y0Qmea6EM89PX2QkJTpsKGuD6k7
         1N0GURi1/KiIyeWn/uMu5+vklrsQBSMEp8vlkX6LByP+kneb6bkXuw/deN/AhZgIpbQO
         YMd/0o70TRPKwB7SSxzpVe6CN0B8M28wynuIru3rI9RuFknYeVFQDUPPKbp/+pqisZ30
         Zxeg==
X-Gm-Message-State: AO0yUKVgtYvcbKsgLoLI3fwLQlT+Y8nVZ870ePWx6kE1Dm7F4wPSoLp3
        14yzjWuBZzkssB730Zioqh4=
X-Google-Smtp-Source: AK7set/xLBDMGbALSX6T3KG2tO/vxqerlafF7u2LCm+ILchLc/KLuvX0sqgBjzLlXhI7AXfR6O1giA==
X-Received: by 2002:a5e:9e0c:0:b0:741:8544:7cab with SMTP id i12-20020a5e9e0c000000b0074185447cabmr9276288ioq.16.1676999748443;
        Tue, 21 Feb 2023 09:15:48 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g13-20020a02bb8d000000b003b49e7d990asm1882544jan.30.2023.02.21.09.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 09:15:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <628cd274-38a2-fd67-3cea-eef5837f58a5@roeck-us.net>
Date:   Tue, 21 Feb 2023 09:15:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] hwmon: (adt7475) Fix setting of hysteresis registers
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        chris.packham@alliedtelesis.co.nz, hdegoede@redhat.com,
        jordan.crouse@amd.com, linux-kernel@vger.kernel.org
References: <20230219232956.23784-1-tony.obrien@alliedtelesis.co.nz>
 <20230219232956.23784-3-tony.obrien@alliedtelesis.co.nz>
 <20230220140826.GA4009286@roeck-us.net>
In-Reply-To: <20230220140826.GA4009286@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 06:08, Guenter Roeck wrote:
> On Mon, Feb 20, 2023 at 12:29:56PM +1300, Tony O'Brien wrote:
>> In temp_store(), for the hysteresis setting calculation there were two
>> errors.  The first tries to clamp the hysteresis value by comparing the
>> required hysteresis value to THERM - 15C.  This is incorrect since the
>> hysteresis value is a relative value whereas THERM - 15C is an absolute
> 
> No, it isn't. The hysteresis attribute is an absolute temperature.
> The value written into the attribute is expected to be in the range
> [THERM - 15, THERM] (in degrees C). The value written into the register
> is then in the range [15, 0]. I see nothing wrong with the current code.
> 
>> value. This causes it to always select 15C for hysteresis.  Change the
>> first parameter to THERM - val to compare two absolute temperatures.
>> The second error masks the wrong bits in the hysteresis register; indices
>> 0 and 2 should zero bits [7:4] and preserve bits [3:0], and index 1 should
>> zero bits [3:0] and preserve bits [7:4].
> 
> I'll have to verify that with the datasheet. Either case, one logical change
> per patch, please.
> 

Actually, the problem is obvious from the code. Still, either drop the first
part of the patch or separate into two patches and explain in detail what
you think is wrong in the first part. There is a comment in the code

                 /*
                  * The value will be given as an absolute value, turn it
                  * into an offset based on THERM
                  */

Maybe I am missing something, but I think that is exactly what the current
code is doing.

Thanks,
Guenter

> Thanks,
> Guenter
> 
>>
>> Fixes: 1c301fc5394f ("hwmon: Add a driver for the ADT7475 hardware monitoring chip")
>> Signed-off-by: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
>> ---
>>   drivers/hwmon/adt7475.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
>> index 77222c35a38e..68233191798e 100644
>> --- a/drivers/hwmon/adt7475.c
>> +++ b/drivers/hwmon/adt7475.c
>> @@ -484,14 +484,14 @@ static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
>>   		adt7475_read_hystersis(client);
>>   
>>   		temp = reg2temp(data, data->temp[THERM][sattr->index]);
>> -		val = clamp_val(val, temp - 15000, temp);
>> +		val = clamp_val(temp - val, temp - 15000, temp);
>>   		val = (temp - val) / 1000;
>>   
>>   		if (sattr->index != 1) {
>> -			data->temp[HYSTERSIS][sattr->index] &= 0xF0;
>> +			data->temp[HYSTERSIS][sattr->index] &= 0x0F;
>>   			data->temp[HYSTERSIS][sattr->index] |= (val & 0xF) << 4;
>>   		} else {
>> -			data->temp[HYSTERSIS][sattr->index] &= 0x0F;
>> +			data->temp[HYSTERSIS][sattr->index] &= 0xF0;
>>   			data->temp[HYSTERSIS][sattr->index] |= (val & 0xF);
>>   		}
>>   
>> -- 
>> 2.39.2
>>

