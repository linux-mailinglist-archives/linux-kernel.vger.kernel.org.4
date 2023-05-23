Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E9C70E52C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbjEWTNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEWTNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:13:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C29119;
        Tue, 23 May 2023 12:13:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-969f90d71d4so1180844766b.3;
        Tue, 23 May 2023 12:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684869229; x=1687461229;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldi8AGUTx7zIvnhIDgirP/2HuKJcRJ5qFJRH7LbrUDM=;
        b=iI2ve+6oZIk3VsfOpkmAoJu5FNErEQVjGna9+lnAm0sliZzREs3znkF15O/1Liymsz
         ulIo1Gtwhae7EAXquL8xd+Nhn2ei91XXzOj2y7cBj+Ubr7Zb/kkCeGxTfFzimozBo4oK
         fJpiYSCtkAAEzfVphPQb29fY5DxBpAT97EJ9Cw6Un5YrqwB7T7r4REwVWpvrX3xlT0te
         yLOcAUTpEH1dXalkJLyIRIRWTXbCATIee4jWVnlBsylt9yFk7EihZxS1x63AiatAZpUs
         0s5HpyjqKQPYmqRo4rgHMy/6bOOQNj8weRjZaz0yyR7lSMQBVe9M7nXkITE4s3WFE9jl
         ZHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684869229; x=1687461229;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldi8AGUTx7zIvnhIDgirP/2HuKJcRJ5qFJRH7LbrUDM=;
        b=DreVA0g5bh1B/62+Kt208K9E65cc37bIhcmIHzWn7XI0LWfJuXajdSepvm0Pg8RKNd
         Bt01f3mSgVW+OVcEOT2SRiJ67Au2lC6zzJ5G29VVj4/FTv/t7D/YXk2Vvdzn/oD2mcr1
         LjBUniasuNJ1recvoOkUL+LsQ1BNR+OQXyp8jh+UqICaDXu5uFTbwTCnZNIM2xWxIcKP
         a5NUEZmUMc4Y2cQk3nU2mwoIi+tJJEk25Sf6rSL9Kt1MiMMqtvyXpUcnH46AJhz3Ns4k
         VVQ9JNWzZgfkUDn24efIw2lD1eypznvgeCflNKVvzthnIiSPIO70/pA2x+pXTp/uJzrn
         q1Wg==
X-Gm-Message-State: AC+VfDxZdJmH8Y93B7dEVzxzlvheyfXOhxBZwogHmvdROxgwmb1draMV
        JD5ToBH7KmLVZCbzJ9Wxdhc=
X-Google-Smtp-Source: ACHHUZ7TRjjs+1trzDlMQKVpk+fzDYeiTzotYNAq2c88Gt5jXN6QXjRorz8EfbuFP+EZvBH212L50w==
X-Received: by 2002:a17:907:3ea9:b0:969:f433:9b54 with SMTP id hs41-20020a1709073ea900b00969f4339b54mr15907605ejc.39.1684869228400;
        Tue, 23 May 2023 12:13:48 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c4b9:3000:6c58:d026:2a46:c9d0? (dynamic-2a01-0c23-c4b9-3000-6c58-d026-2a46-c9d0.c23.pool.telefonica.de. [2a01:c23:c4b9:3000:6c58:d026:2a46:c9d0])
        by smtp.googlemail.com with ESMTPSA id rv25-20020a17090710d900b00965f6ad266bsm4746836ejb.119.2023.05.23.12.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 12:13:47 -0700 (PDT)
Message-ID: <2c1f7878-e58c-258f-283d-38d08ebaa07a@gmail.com>
Date:   Tue, 23 May 2023 21:13:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
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
 <573d96df-7b08-4fa2-668b-58ff674a314e@gmail.com>
 <20230522134425.pc5fhojf53v6q2jz@CAB-WSD-L081021>
 <a121266a-110a-8c4e-cd71-4e35165fc789@gmail.com>
 <20230523102318.kf3o5rtmqdy2patg@CAB-WSD-L081021>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v14 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
In-Reply-To: <20230523102318.kf3o5rtmqdy2patg@CAB-WSD-L081021>
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

On 23.05.2023 12:23, Dmitry Rokosov wrote:
> Heiner,
> 
> On Mon, May 22, 2023 at 10:35:59PM +0200, Heiner Kallweit wrote:
>> On 22.05.2023 15:44, Dmitry Rokosov wrote:
>>> Heiner,
>>>
>>> On Fri, May 19, 2023 at 06:10:50PM +0200, Heiner Kallweit wrote:
>>>> On 18.05.2023 22:04, Martin Blumenstingl wrote:
>>>>> Hi Dmitry,
>>>>>
>>>>> On Wed, May 17, 2023 at 12:34 PM Dmitry Rokosov
>>>>> <ddrokosov@sberdevices.ru> wrote:
>>>>> [...]
>>>>>>>> Additionally, the CCF determines the best ancestor based on how close
>>>>>>>> its rate is to the given one, based on arithmetic calculations. However,
>>>>>>>> we have independent knowledge that a certain clock would be better, with
>>>>>>>> less jitter and fewer intermediaries, which will likely improve energy
>>>>>>>> efficiency. Sadly, the CCF cannot take this into account.
>>>>>>> I agree that the implementation in CCF is fairly simple. There's ways
>>>>>>> to trick it though: IIRC if there are multiple equally suitable clocks
>>>>>>> it picks the first one. For me all of this has worked so far which is
>>>>>>> what makes me curious in this case (not saying that anything is wrong
>>>>>>> with your approach).
>>>>>>>
>>>>>>> Do you have a (real world) example where the RTC clock should be
>>>>>>> preferred over another clock?
>>>>>>>
>>>>>>
>>>>>> Yes, a real-life example is the need for a 32Khz clock for an external
>>>>>> wifi chip. There is one option to provide this clock with high
>>>>>> precision, which is RTC + GENCLK.
>>>>>>
>>>>>>> I'm thinking about the following scenario.
>>>>>>> PWM parents:
>>>>>>> - XTAL: 24MHz
>>>>>>> - sys: not sure - let's say 166.67MHz
>>>>>>> - RTC: 32kHz
>>>>>>>
>>>>>>> Then after that there's a divider and a gate.
>>>>>>>
>>>>>>> Let's say the PWM controller needs a 1MHz clock: it can take that from
>>>>>>> XTAL or sys. Since XTAL is evenly divisible to 1MHz CCF will pick that
>>>>>>> and use the divider.
>>>>>>> But let's say the PWM controller needs a 32kHz clock: CCF would
>>>>>>> automatically pick the RTC clock.
>>>>>>> So is your implementation there to cover let's say 1kHz where
>>>>>>> mathematically 24MHz can be divided evenly to 1kHz (and thus should
>>>>>>> not result in any jitter) but RTC gives better precision in the real
>>>>>>> world (even though it's off by 24Hz)?
>>>>>>>
>>>>>>
>>>>>> I don't think so. The highest precision that RTC can provide is from a
>>>>>> 32KHz rate only. However, I believe that a 1kHz frequency can also be
>>>>>> achieved by using xtal 24MHz with a divider, which can provide high
>>>>>> precision as well.
>>>>> Thank you again for the great discussion on IRC today.
>>>>> Here's my short summary so I don't forget before you'll follow up on this.
>>>>>
>>>>> In general there's two known cases where the RTC clock needs to be used:
>>>>> a) When using the GENCLK output of the SoC to output the 32kHz RTC
>>>>> clock and connect that to an SDIO WiFi chip clock input (this seems
>>>>> useful in my understanding because the RTC clock provides high
>>>>> precision)
>>>>> b) When using the PWM controller to output a 32kHz clock signal. In
>>>>> this case my understanding is that using the RTC clock as input to the
>>>>> PWM controller results in the best possible signal
>>>>>
>>>>> The second case won't be supported with Heiner's patches [0] that use
>>>>> CCF (common clock framework) in the PWM controller driver.
>>>>> In this series the parent clock is calculated using:
>>>>>   freq = div64_u64(NSEC_PER_SEC * (u64)0xffff, period);
>>>>>
>>>>> A 32kHz clock means a PWM period of 30518ns. So with the above
>>>>
>>>> To be precise: 30517,578125ns
>>>> What means that the PWM framework can't say "I want 32768Hz",
>>>> but just "I want something being very close to 32768Hz".
>>>> So what you need is some simple heuristic to interpret the
>>>> PWM request -> "PWM requests 30518ns, but supposedly it wants
>>>> 32768Hz"
>>>>
>>>> NSEC_PER_SEC / 30518 = 32767 (rounded down from 32767,547)
>>>> clk_round_rate(channel->clk, 32767) would return 0 (I *think*),
>>>> because it tries to find the next lower clock.
>>>>
>>>> The SoC families I'm familiar with have fclkin2 as PWM parent.
>>>> That's 1 GHz in my case, what results in a frequency of 32.767,547Hz
>>>> for period = 30518n.
>>>> What you're saying is that newer generations don't have PWM parents
>>>>> 24MHz any longer?
>>>
>>> No, of course not. For example, a fixed PLL (with all fclk_divX
>>> settings) has rates higher than 24MHz. However, we need to consider the
>>> 'heavy' background of such PWM.
>>>
>>> However, we have a "lightweight" clkin (special rtc32k) with a rate of
>>> 32kHz that we could potentially use as an input to produce a 32kHz
>>> output on the PWM lines. I don't see any reason why we should not
>>> support such special cases.
>>>
>>
>> Two more things to consider:
>> 1. When wanting a 32kHz (well, 32768Hz) output with a 50% duty cycle,
>>    then we need hi=0 and lo=0 with a 64kHz input clock.
>>    See point 2 for an explanation of why 0 and not 1.
>>    Means we couldn't use the RTC input clock. Did you consider this?
>>    Or do I miss something?
> 
> Nope, that's my fault. Using a 32kHz base clock for rates of 16kHz or
> lower that can be divided evenly is a good choice. However, as you
> mentioned in point 2, the problem with autoincrements should be fixed
> first.
> 
>> 2. Seems the PWM block internally increments hi and lo, except the
>>    constant_en bit is set on newer PWM block versions.
>>    For bigger cnt values the impact is negligible, but for very small
>>    values it's something we have to consider.
>>    This was one additional motivation for me to choose an input
>>    frequency that creates big cnt values.
> 
> George has a patchset for this and he will send it very soon as he
> mentioned in another email. Let's assume the code is already fixed and
> no longer has any issues. In my opinion, if we want to generate rates of
> 16kHz, 8kHz, 4kHz, etc., the best parent clock to use is a 32kHz RTC.
> High-rate clocks may not divide evenly and may not generate an accurate
> output rate. What do you think about it?
> 
With the logic in the CCF conversion patch set for these rates the 24MHz
xtal mux input would be used, creating exactly the requested rates.
So I see no difference here. What I don't know is whether power
consumption may be higher with a higher input rate, or whether quality
of the mux parent clocks differs.

>>
>>>>
>>>>
>>>>> calculation the PWM driver is asking for a clock rate of >=2GHz.
>>>>> We concluded that letting the common clock framework choose the best
>>>>> possible parent (meaning: removing CLK_SET_RATE_NO_REPARENT here) can
>>>>> be a way forward.
>>>>> But this means that the PWM controller driver must try to find the
>>>>> best possible parent somehow. The easiest way we came up with
>>>>> (pseudo-code):
>>>>>   freq = NSEC_PER_SEC / period;
>>>>>   fin_freq = clk_round_rate(channel->clk, freq);
>>>>>   if (fin_freq != freq) {
>>>>>     freq = div64_u64(NSEC_PER_SEC * (u64)0xffff, period);
>>>>>     fin_freq = clk_round_rate(channel->clk, freq);
>>>>>   }
>>>>>
>>>>> The idea is: for a requested 32kHz signal the PWM period is 30518ns.
>>>>> The updated logic would find that there's a matching clock input and
>>>>> use that directly. If not: use the original logic as suggested by
>>>>> Heiner.
>>>>>
>>>>>
>>>>> Best regards,
>>>>> Martin
>>>>>
>>>>>
>>>>> [0] https://lore.kernel.org/linux-amlogic/9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com/
>>>>
>>>
>>
> 

