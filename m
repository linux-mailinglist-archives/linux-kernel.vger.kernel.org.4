Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC996709C11
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjESQK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjESQKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:10:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9018FC9;
        Fri, 19 May 2023 09:10:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94a342f7c4cso654119366b.0;
        Fri, 19 May 2023 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684512652; x=1687104652;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shR9tZ5xiaUJ9C4wWURqYuO7Qqx5kQ3Rtd+uNyelifI=;
        b=OfjoobpT9uQF4m5zhukOOavH5dDTVfys7/MeRv7VK28aAKRy30BShQ6lKs58R4kMmc
         MnbpOOTGl0ETnKxnSQaBQl5JDgw8g5zP9JWEQdSMOeAiTsyjCb8sqezzCxjN3OEtDEN2
         QPPU/2dtmEw9lNinyhObJiQHj14y6YdeIhL8PGuVpei3GjrV9t+ZLXo95fP11FXowRdO
         Dt8CpxJ5xUk3LPpXVDd1VtZ/PwCd/NZGKu/PkmHgVZpth2mvfH6dTwYeGUDuYhgv2i4A
         5vNcpC8AZg3ieGBPB5s0dwUlWTl1oF3M1TIIphc7BC0VVVWJgncW17df8uMYjUs1yY7Y
         /iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684512652; x=1687104652;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shR9tZ5xiaUJ9C4wWURqYuO7Qqx5kQ3Rtd+uNyelifI=;
        b=dv/gstk9BzmawAzDKT982xl7/Wn3ub9EpHvfsrAY00sDgKBHQ0RcGup2AbmzT6klbF
         vV7oYdZ09o+RgyJN2hs5YW/1O3d7ZpASb5arl3dr6UhJLR24nvX7RFNZd+ZrvoRS4t/r
         GZ9woVh0v4FPCv3vtERStQTGbgsm3jFiBiP7fptHYfwWAHxrnDO7AkgZP6lCgb57UGjz
         kBT/8TZpahZ0dRcPN11jrFQ8s7C1o2U/54d7ZvRyJ4sD8VgDyJQj0hbUYJnrOx7bRhQm
         8+kr0WwPe2tIgIhVSjs+i8Qf5FuMpefp9/IpX/H4Mvh7yBDcMFk187Zvh/EpEaDRZzKD
         mrzg==
X-Gm-Message-State: AC+VfDwJ4ArcQtlgvMCd9PrOLLQtPcm1vlT7KseYIRAyTw/fO5B8w58O
        A1ux8xqSy1HvIivn6u27aBk=
X-Google-Smtp-Source: ACHHUZ51F8Of6ajEOG4kC19Rjv1qy/hiNer8vMIgrh6QrItztf/4VfKsyoLOjahdva0jY3U7GQ+jug==
X-Received: by 2002:a17:907:3fa8:b0:960:ddba:e5c5 with SMTP id hr40-20020a1709073fa800b00960ddbae5c5mr3186651ejc.11.1684512651750;
        Fri, 19 May 2023 09:10:51 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c53c:ab00:54b1:eb24:1f4e:3a15? (dynamic-2a01-0c23-c53c-ab00-54b1-eb24-1f4e-3a15.c23.pool.telefonica.de. [2a01:c23:c53c:ab00:54b1:eb24:1f4e:3a15])
        by smtp.googlemail.com with ESMTPSA id e20-20020a170906845400b0096f7b7b6f11sm508427ejy.106.2023.05.19.09.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 09:10:51 -0700 (PDT)
Message-ID: <573d96df-7b08-4fa2-668b-58ff674a314e@gmail.com>
Date:   Fri, 19 May 2023 18:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru>
 <20230426095805.15338-7-ddrokosov@sberdevices.ru>
 <CAFBinCA2OhtVaCJDi8ZfAFLSE4oUgxYBDScaP_WW63curEK8Mg@mail.gmail.com>
 <20230512140630.qd33rwzaalmadpmk@CAB-WSD-L081021>
 <CAFBinCA8e9evk+9hTEgoNOD_+3DBst6vYDcradmr2c996jdUmw@mail.gmail.com>
 <20230517103456.p3sjxzbepvg7cr2r@CAB-WSD-L081021>
 <CAFBinCCPf+asVakAxeBqV-jhsZp=i2zbShByTCXfYYAQ6cCnHg@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v14 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
In-Reply-To: <CAFBinCCPf+asVakAxeBqV-jhsZp=i2zbShByTCXfYYAQ6cCnHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.2023 22:04, Martin Blumenstingl wrote:
> Hi Dmitry,
> 
> On Wed, May 17, 2023 at 12:34 PM Dmitry Rokosov
> <ddrokosov@sberdevices.ru> wrote:
> [...]
>>>> Additionally, the CCF determines the best ancestor based on how close
>>>> its rate is to the given one, based on arithmetic calculations. However,
>>>> we have independent knowledge that a certain clock would be better, with
>>>> less jitter and fewer intermediaries, which will likely improve energy
>>>> efficiency. Sadly, the CCF cannot take this into account.
>>> I agree that the implementation in CCF is fairly simple. There's ways
>>> to trick it though: IIRC if there are multiple equally suitable clocks
>>> it picks the first one. For me all of this has worked so far which is
>>> what makes me curious in this case (not saying that anything is wrong
>>> with your approach).
>>>
>>> Do you have a (real world) example where the RTC clock should be
>>> preferred over another clock?
>>>
>>
>> Yes, a real-life example is the need for a 32Khz clock for an external
>> wifi chip. There is one option to provide this clock with high
>> precision, which is RTC + GENCLK.
>>
>>> I'm thinking about the following scenario.
>>> PWM parents:
>>> - XTAL: 24MHz
>>> - sys: not sure - let's say 166.67MHz
>>> - RTC: 32kHz
>>>
>>> Then after that there's a divider and a gate.
>>>
>>> Let's say the PWM controller needs a 1MHz clock: it can take that from
>>> XTAL or sys. Since XTAL is evenly divisible to 1MHz CCF will pick that
>>> and use the divider.
>>> But let's say the PWM controller needs a 32kHz clock: CCF would
>>> automatically pick the RTC clock.
>>> So is your implementation there to cover let's say 1kHz where
>>> mathematically 24MHz can be divided evenly to 1kHz (and thus should
>>> not result in any jitter) but RTC gives better precision in the real
>>> world (even though it's off by 24Hz)?
>>>
>>
>> I don't think so. The highest precision that RTC can provide is from a
>> 32KHz rate only. However, I believe that a 1kHz frequency can also be
>> achieved by using xtal 24MHz with a divider, which can provide high
>> precision as well.
> Thank you again for the great discussion on IRC today.
> Here's my short summary so I don't forget before you'll follow up on this.
> 
> In general there's two known cases where the RTC clock needs to be used:
> a) When using the GENCLK output of the SoC to output the 32kHz RTC
> clock and connect that to an SDIO WiFi chip clock input (this seems
> useful in my understanding because the RTC clock provides high
> precision)
> b) When using the PWM controller to output a 32kHz clock signal. In
> this case my understanding is that using the RTC clock as input to the
> PWM controller results in the best possible signal
> 
> The second case won't be supported with Heiner's patches [0] that use
> CCF (common clock framework) in the PWM controller driver.
> In this series the parent clock is calculated using:
>   freq = div64_u64(NSEC_PER_SEC * (u64)0xffff, period);
> 
> A 32kHz clock means a PWM period of 30518ns. So with the above

To be precise: 30517,578125ns
What means that the PWM framework can't say "I want 32768Hz",
but just "I want something being very close to 32768Hz".
So what you need is some simple heuristic to interpret the
PWM request -> "PWM requests 30518ns, but supposedly it wants
32768Hz"

NSEC_PER_SEC / 30518 = 32767 (rounded down from 32767,547)
clk_round_rate(channel->clk, 32767) would return 0 (I *think*),
because it tries to find the next lower clock.

The SoC families I'm familiar with have fclkin2 as PWM parent.
That's 1 GHz in my case, what results in a frequency of 32.767,547Hz
for period = 30518n.
What you're saying is that newer generations don't have PWM parents
>24MHz any longer?


> calculation the PWM driver is asking for a clock rate of >=2GHz.
> We concluded that letting the common clock framework choose the best
> possible parent (meaning: removing CLK_SET_RATE_NO_REPARENT here) can
> be a way forward.
> But this means that the PWM controller driver must try to find the
> best possible parent somehow. The easiest way we came up with
> (pseudo-code):
>   freq = NSEC_PER_SEC / period;
>   fin_freq = clk_round_rate(channel->clk, freq);
>   if (fin_freq != freq) {
>     freq = div64_u64(NSEC_PER_SEC * (u64)0xffff, period);
>     fin_freq = clk_round_rate(channel->clk, freq);
>   }
> 
> The idea is: for a requested 32kHz signal the PWM period is 30518ns.
> The updated logic would find that there's a matching clock input and
> use that directly. If not: use the original logic as suggested by
> Heiner.
> 
> 
> Best regards,
> Martin
> 
> 
> [0] https://lore.kernel.org/linux-amlogic/9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com/

