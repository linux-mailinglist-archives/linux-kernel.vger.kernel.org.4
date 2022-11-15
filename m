Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FDE62A1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiKOTLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiKOTK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:10:58 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE011C92B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:10:57 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id i10so29835935ejg.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7zUeISTpfROPOAumwGjosfHUKHNhvpIAE+hikozVXow=;
        b=ZMjCu+EGd3BAayMpj+Qs2X8LsZTn7rQfelK9qSfJ98Twxm0/F/nAYQ5og2/Br8J+AA
         yBSWyZFegdSg0XQPYdwZ8XU59hbNcQg7BMXIVtfd6U9sxkKsACR7NaHFQimgXCp6kN5u
         8EmpC65NWCigc+MghndwR7IVSYUSX7wKe+uyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zUeISTpfROPOAumwGjosfHUKHNhvpIAE+hikozVXow=;
        b=u+98KXeW+bri3p6IXc2zQ+3jgqX9GA1F7u2edmvjdz8rRpZZOTH8SLuWJhWQFjqYXN
         EJVF5y/w1H1mQ1JIeYFuhaCtpqp+C5Djm4jVSxBqtqhMcLDt0VweVNJW7xPyiYqZpgcc
         DPapoDyyEpE305vs7/S5Q1YZcvctv54pDUX7W9OvJhSU33UWpEUugHXk7WuTf1CGGDYv
         sk92Taiy6N2ffYJLkjqCbfFaGJVOnFtkbBY1EVm6NJyMw+Nwj/buGgiRuMIqzKEm/VR5
         TAx9sjz49J1WY5NspPbwoWu8RZlVraUTn5677PSAISmo4AAYO7NxkEdyDjS6QGnzP5BQ
         W88g==
X-Gm-Message-State: ANoB5pkcRGy/zZ3PQ9ZhtpGw/x/lh0ZXf6wOBdqx6kYjE8x4cAGKCIv3
        +IhlMr+e1iUvdxpppeDJcHWiqg==
X-Google-Smtp-Source: AA0mqf6YJtScIOh84jMpYoP2ge7MMj9GKqUAOpVkXuvl3nP8qga5tGl4XjjNs92jDpYpAUgqrlQLyA==
X-Received: by 2002:a17:906:c284:b0:7a1:6786:444f with SMTP id r4-20020a170906c28400b007a16786444fmr15014484ejz.409.1668539455702;
        Tue, 15 Nov 2022 11:10:55 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id ce11-20020a170906b24b00b007ad9c826d75sm5867616ejb.61.2022.11.15.11.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 11:10:55 -0800 (PST)
Message-ID: <6d76cc6d-9db7-5b18-e4f1-dc220b3929a3@rasmusvillemoes.dk>
Date:   Tue, 15 Nov 2022 20:10:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
Content-Language: en-US, da
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
 <20221111143921.742194-6-linux@rasmusvillemoes.dk>
 <20221112170705.7efe1673@jic23-huawei>
 <095a454b55cf497392a621649f24e067@analog.com>
 <20221114194447.2528f699@jic23-huawei>
 <0d6b3e4047df9f560079a562bc167bd7a0bf2d28.camel@gmail.com>
 <20221115161052.00002633@Huawei.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20221115161052.00002633@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 17.10, Jonathan Cameron wrote:
> On Tue, 15 Nov 2022 15:49:46 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
>> On Mon, 2022-11-14 at 19:44 +0000, Jonathan Cameron wrote:
>>> On Mon, 14 Nov 2022 13:52:26 +0000
>>> "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com> wrote:
>>>   
>>>>>
>>>>> I'm a little confused on polarity here.  The pin is a !reset so
>>>>> we need to drive it low briefly to trigger a reset.
>>>>> I'm guessing for your board the pin is set to active low? (an
>>>>> example
>>>>> in the dt would have made that clearer) Hence the pulse
>>>>> in here to 1 is actually briefly driving it low before restoring
>>>>> to high?
>>>>>
>>>>> For a pin documented as !reset that seems backwards though you
>>>>> have
>>>>> called it reset so that is fine, but this description doesn't
>>>>> make that
>>>>> celar.    
>>>>
>>>> My opinion is that the driver shouldn't exactly know the polarity
>>>> of the reset,
>>>> and just assume that setting the reset GPIO to 1 means putting it
>>>> in reset,
>>>> and setting it to 0 means bringing out of reset.  
>>>
>>> Agreed. I'd just like a comment + example in the dt-binding to make
>>> the point
>>> that the pin is !reset.
>>>
>>> Preferably with an example in the dt binding of the common case of it
>>> being wired
>>> up to an active low pin.
>>>
>>> The main oddity here is the need to pulse it rather than request it
>>> directly as
>>> in the reset state and then just set that to off.
>>>
>>>   
>>
>> Agreed... In theory we should be able to request the gpio with
>> GPIOD_OUT_HIGH and then just bring the device out of reset
> 
> If I recall correctly the datasheet specifically calls out that a pulse
> should be used.  No idea if that's actually true, or if it was meant
> to be there just to say it needs to be set for X nsecs.

So the data sheet says

  The hardware reset is initiated by pulsing the RESET pin low. The
RESET pulse width must comply with the specifications in Table 11.

and table 11 says that the pulse must be min 50us, max 1ms. We don't
really have any way whatsoever to ensure that we're not rescheduled
right before pulling the gpio high again (deasserting the reset), so the
pulse could effectively be much more than 1ms. But I have a hard time
believing that that actually matters (i.e., what state would the chip be
in if we happen to make a pulse 1234us wide?). But what might be
relevant, and maybe where that 1ms figure really comes from, can perhaps
be read in table 10, which lists a "device reset time" of 1ms, with the
description

  Time taken for device reset and calibration memory upload to complete
hardware or software reset events after the device is powered up

so perhaps we should ensure a 1ms delay after the reset (whether we used
the software or gpio method). But that would be a separate fix IMO (and
I'm not sure we actually need it).

I don't mind requesting the gpio with GPIOD_OUT_HIGH, but I'd still keep
the gpiod_set_value(, 1) in the reset function, otherwise it's a bit too
magic for my taste.

Rasmus

