Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5082F65BE76
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbjACKyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACKyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:54:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D34DE0A8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:54:51 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so45146108lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 02:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBmEORUktmC2vHOscQjNLXVVbcXPef8IPSJnCs/MHUM=;
        b=EFeCoB14ySDWcoZR6RuLaGUisduJZHnKuJDaOG0CU65D9sUaQw4mvaSUXd2LrZettN
         OqcjWMXcBJfuQA70UbzUZ0PK62I72np9gtBPCqxxOs/v7yhhWUTCHwgR0qJhh5pmBCR8
         LFc2jJllR8Aay07qPBefkXDr2sVihvTsCjNMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBmEORUktmC2vHOscQjNLXVVbcXPef8IPSJnCs/MHUM=;
        b=vaey7sKlosToimTJ7MOuROHb5oSLHtRftWAqUbiFRCMSRwn22CBu/hJ1ttRFSYGKup
         sK+Kfg/DWLmyKcQo8g9H3pB7bMDM9EnlQd8uUQjIF25eVJB01f4yQO6UrF1dte+LEeYP
         wESURHdEy+3orZWlRg0ohEwD/dN3VfDJEp1fFv3fNwUJu2DkrubobNF0agBp0PJmbKeb
         ffLrT90ic5aep/MGmz0uWBR+Q6nUiIhpxmXeFNzZX/WVh+T3UnCTQRIxk1WM/H3ZTRrW
         zq94rtW3x7CW8mzzxXzmDFZwrU7JibgbHogc50Z0wrtEJT05NwjH3ewwBfP0ilMLpPo3
         WoEw==
X-Gm-Message-State: AFqh2krN60R8zZt1xViaVRQSVz4KjMcvItJHL5vpsJLQ8OcxkAafR7S6
        kGuxcbblkUzlU7+49OauHKJO5Q==
X-Google-Smtp-Source: AMrXdXsnsff8SCNcPGkk+I73UG73EDCiOyH4di6nrtgrbOeFou6NxpM5e2KHETmQ4OhNhCSUMXhcQA==
X-Received: by 2002:a05:6512:2821:b0:4b5:26f3:2247 with SMTP id cf33-20020a056512282100b004b526f32247mr14287181lfb.69.1672743289288;
        Tue, 03 Jan 2023 02:54:49 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p2-20020ac246c2000000b004b5a85e369asm4802638lfo.252.2023.01.03.02.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 02:54:48 -0800 (PST)
Message-ID: <ed79eb76-1ce9-a02d-78c6-0f9127dbc918@rasmusvillemoes.dk>
Date:   Tue, 3 Jan 2023 11:54:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] Input: edt-ft5x06 - always do msleep(300) during
 initialization
Content-Language: en-US, da
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
References: <20221202105800.653982-1-linux@rasmusvillemoes.dk>
 <Y4pCtm4J3HWhYl8/@nixie71>
 <58ec9951-32d7-6967-3571-d18c667ae478@rasmusvillemoes.dk>
 <Y46wMrS7iN6yBsBf@nixie71>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Y46wMrS7iN6yBsBf@nixie71>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2022 04.00, Jeff LaBundy wrote:
> Hi Rasmus,
> 
> On Mon, Dec 05, 2022 at 09:59:08AM +0100, Rasmus Villemoes wrote:
>> On 02/12/2022 19.23, Jeff LaBundy wrote:
>>> + Mark
>>>
>>> Hi Rasmus,
>>>
>>> On Fri, Dec 02, 2022 at 11:57:59AM +0100, Rasmus Villemoes wrote:
>>>> We have a board with an FT5446, which is close enough to a
>>>> FT5506 (i.e. it also supports up to 10 touch points and has similar
>>>> register layout) for this driver to work. However, on our board the
>>>> iovcc and vcc regulators are indeed controllable (so not always-on),
>>>> but there is no reset or wakeup gpio hooked up.
>>>>
>>>> Without a large enough delay between the regulator_enable() calls and
>>>> edt_ft5x06_ts_identify(), the first edt_ft5x06_ts_readwrite() call
>>>> fails with -ENXIO and thus the device fails to probe. So
>>>> unconditionally do an mdelay(300) instead of only when a reset-gpio is
>>>> present.
>>>>
>>>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>>
>>> This is just my $.02, but it does not seem we are on the correct path
>>> here. 300 ms sounds more like bulk capacitor charge time rather than
>>> anything to do with this specific IC; is that a reasonable assumption?
>>>
>>> Normally, we want to do the following:
>>>
>>> 1. Enable regulator
>>> 2. Wait for voltage rail to stabilize (RC time constant)
>>> 3. Wait for any applicable POR delay (IC datasheet)
>>> 4. Deassert reset
>>> 5. Wait for any applicable reset delay (IC datasheet)
>>> 6. Start communication
>>>
>>> Here we are dealing with step (2), 
>>
>> Nope, we are really essentially dealing with step 5, even if there's no
>> reset gpio that we've flipped around. The data sheet says to wait 200 ms
>> (and I don't know why the driver does 300, perhaps there's some other
>> chip in the family with that value, or perhaps it was just a
>> belt-and-suspenders choice) after releasing reset. It's just that
>> "releasing reset" is, in my case, effectively happens at the same time
>> as the regulators are enabled.
>>
>> I also played around with some smaller values. As I wrote, with no
>> delay, I would get -ENXIO, but with both 50 and 100, the chip would
>> "respond", but the values were essentially garbage (and not reproducible
>> from one boot to the next). So even if it's a rather long time, it most
>> definitely is a hard requirement to wait that long - perhaps we could
>> make it 200, but I'd rather not reduce that time when I don't know if
>> other variants have that 300 as a requirement.
>>
>> Even if we could interrogate the regulator and ask it if "are you
>> actually always-on", I'd rather not make the delay conditional on that;
>> we cannot know if it has been on for 300+ ms, and since the device does
>> respond, but not correctly, we could end up with probing and
>> initializing the device, but in a wrong state. That's a recipe for
>> impossible debugging (add a single printk somewhere earlier and the
>> timing changes so that suddenly it gets initialized correctly...).
> 
> Thank you for these additional details, especially with my having taken
> us on a tangent :) Perhaps the controller requires so much time because
> it is loading firmware internally. Based on this information, the patch
> seems reasonable to me.
> 
> Reviewed-by: Jeff LaBundy <jeff@labundy.com>

Thanks.

Dmitry, any chance this could get picked up? I don't see it in
next-20221226.

Rasmus

