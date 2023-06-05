Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A247231DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjFEVCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjFEVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:01:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAA418E;
        Mon,  5 Jun 2023 14:01:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30af159b433so5346699f8f.3;
        Mon, 05 Jun 2023 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685998902; x=1688590902;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UuDqA9QdnJOky0P/4GZ0/HcprcAx5ORnIFMZhmVSsY=;
        b=rscLBPynR6TMxI19jepJvNbfgpFoEHAykXLqe5/ReQZhBnrYAM433Wdoogv9R/Cjpw
         3iCxKmox8WcVqKOJl2qYX30ykq1IsvFhawEeXY4RWis0gECfM/qEUL5a9gWlezCB5lIe
         ckHtKbb3qaqlYiXz11eLiR9YwWXTDxGuGTx5KvA1pUTL6ziTHzTtGQ0fJTPPZHTs/zcF
         3455YUmIVKgcrg1ABVjYpVODeCtJxC9XNCsPlegbQRVbAjq/e2gRvhV/5njs8NjNwOUK
         5MW+XXMT8NoQn7pBEvm2vKjsDKiXcJNwG3KaHcppDnfIhza3ZNjcgyflDEyCB1uXlezC
         SWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685998902; x=1688590902;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UuDqA9QdnJOky0P/4GZ0/HcprcAx5ORnIFMZhmVSsY=;
        b=eIunUAvkr3uCaSEZe2xxqq6GZStZIWxhG+cQA6UqAKW/W9PCIg5iK1TmJMHVj8JpQ7
         f0qjnPPWtKzF0o+ikd0/kc2hzD+VLGVwi5lPZSeQ1qzJafsajPNBkmJdTdN35BmBgb5R
         Vd0x0K7pq5ULa2JheoO2k71ciRefnL6KVUrM2fgHoIR4VVhrmnt0i3j9PRWOFXfr2WJX
         mmNjbtvsIzTNHvV2xXYfTf0+TdhkjZpuZQdTYRGjKC1XNAOj8yclTQXsgbBl/eu4Vj6q
         itv5zNQE3zzTnYXjMVmDNb305a65F6Ctyn8XfTQf0KiUQfZhe9RPMm9pf149m2e33muB
         QoyQ==
X-Gm-Message-State: AC+VfDzguw3q6UfNHh3ggA3bz+vgjqJE1+7CJBt7qvCedur1QbXcV5HA
        6L0YKCBx4B5zmUooDxj4cMdxUgLYJmQ=
X-Google-Smtp-Source: ACHHUZ7mNV6YQu9OB99bLB58sGz6QL4pOrfMccnMO+NFakN92T72Pr6TOxLePg7g9xlKisTHCE0niA==
X-Received: by 2002:adf:f8c9:0:b0:30a:ec3b:58d5 with SMTP id f9-20020adff8c9000000b0030aec3b58d5mr71328wrq.69.1685998902007;
        Mon, 05 Jun 2023 14:01:42 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c1fe:b00:f181:5e69:a6b8:882f? (dynamic-2a01-0c23-c1fe-0b00-f181-5e69-a6b8-882f.c23.pool.telefonica.de. [2a01:c23:c1fe:b00:f181:5e69:a6b8:882f])
        by smtp.googlemail.com with ESMTPSA id b12-20020a05600010cc00b003077a19cf75sm10601714wrx.60.2023.06.05.14.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 14:01:41 -0700 (PDT)
Message-ID: <bf7c71bf-4f04-0dd3-91e1-eb639b36e7d1@gmail.com>
Date:   Mon, 5 Jun 2023 23:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     George Stark <gnstark@sberdevices.ru>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        kernel <kernel@sberdevices.ru>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>
References: <20230602103211.2199283-1-gnstark@sberdevices.ru>
 <bf2d2814-5881-0f42-8b62-89c043b66e22@gmail.com>
 <ed8f95d2-ef62-d91a-618c-402ba1c9d09f@sberdevices.ru>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] pwm: meson: compute cnt register value in proper way
In-Reply-To: <ed8f95d2-ef62-d91a-618c-402ba1c9d09f@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.2023 09:11, George Stark wrote:
> On 6/2/23 23:52, Heiner Kallweit wrote:
>> On 02.06.2023 12:32, George Stark wrote:
>>> According to the datasheet, the PWM high and low clock count values
>>> should be set to at least one. Therefore, setting the clock count
>>> register to 0 actually means 1 clock count.
>>>
>>> Signed-off-by: George Stark <GNStark@sberdevices.ru>
>>> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>>> ---
>>> This patch is based on currently unmerged patch by Heiner Kallweit
>>> https://lore.kernel.org/linux-amlogic/23fe625e-dc23-4db8-3dce-83167cd3b206@gmail.com
>>> ---
>>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>>> index 834acd7..57e7d9c 100644
>>> --- a/drivers/pwm/pwm-meson.c
>>> +++ b/drivers/pwm/pwm-meson.c
>>> @@ -206,6 +206,11 @@
>>>           channel->pre_div = pre_div;
>>>           channel->hi = duty_cnt;
>>>           channel->lo = cnt - duty_cnt;
>>> +
>>> +        if (channel->hi)
>>> +            channel->hi--;
>>> +        if (channel->lo)
>>> +            channel->lo--;
> Hello Heiner
> 
> Thanks for review
>> I'm not sure whether we should do this. duty_cnt and cnt are results
>> of an integer division and therefore potentially rounded down.
>> The chip-internal increment may help to compensate such rounding
>> errors, so to say. With the proposed change we may end up with the
>> effective period being shorter than the requested one.
> Although chip-internal increment sometimes may help accidentally
> there are cases when the increment ruins precise calculation in unexpected way.
> 
> Here's our experience on meson a113l (meson-a1) with pwm driver based on ccf:
> we need to get pwm period as close as possible to 32768hz.
> config pwm to period 1/32768 = 30517ns, duty 15258n
> How driver calculates hi\lo regs:
> rate = NSEC_PER_SEC * 0xffff / 30517 = ~2147Mhz
> rate = clk_round_rate(rate) clk_round_rate selects fastest parent clock which is 64Mhz in our case then calculating hi\lo at last: period= mul_u64_u64_div_u64(rate, state->period, NSEC_PER_SEC); // 1953
> duty= mul_u64_u64_div_u64(rate, state->duty_cycle, NSEC_PER_SEC); // 976
> channel->hi= duty;
> channel->lo= period- duty;
> with the internal increment we'll have real output (1953-976 + 1 + 976 + 1) * 1 / 64Mhz = 32736.57Hz but we should have (1953-976 + 976) * 1 / 64Mhz = 32770.09Hz

Supposedly, depending on the prior rounding errors, something incrementing,
and sometimes not incrementing may provide the more precise result.
Another source of error is shown your example, the duty cycle isn't 50%
due to the rounding.
Not sure however where there's any use case where such small deviations
would cause problems. Therefore I don't have a strong opinion.

> | And IIRC this should not happen.
> Could you please explain why or point out doc/description where it's stated?
> If so we can add explicit check to prevent such a case

I think I got this wrong. When checking where I got this information from
I found the following in pwm_apply_state_debug():

if (state->enabled && state->period < s2.period)
  dev_warn(chip->dev,
  ".apply is supposed to round down period (requested: %llu, applied: %llu)\n",
  state->period, s2.period);

>>>       }
>>>         return 0;
>>> @@ -340,7 +345,8 @@
>>>       channel->lo = FIELD_GET(PWM_LOW_MASK, value);
>>>       channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
>>>   -    state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo + channel->hi);
>>> +    state->period = meson_pwm_cnt_to_ns(chip, pwm,
>>> +                        channel->lo + 1 + channel->hi + 1);
>>>       state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
>>>   
>> Doesn't channel->hi have to be incremented here too?
> Yes, lost the line. I'll fix it
> 
> Best regards
> George
>>>       return 0;
>>
> 

