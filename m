Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800E572B266
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjFKPO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjFKPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:14:25 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7D419A;
        Sun, 11 Jun 2023 08:14:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-652dd220d67so3648197b3a.3;
        Sun, 11 Jun 2023 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686496463; x=1689088463;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WY33NERKlb17TukmGOgkhDaG5sdGDG/5hEoznoyZyc=;
        b=KwDvtnK+ZKfFuIcSDBnGZGcuyVdYfWVKiDGusWxDKK7vtT4+rOpxM6PZSVLv8DxmQW
         vAbTmuE8KHbyXmldyGPGn7On0esT7A1R7FX2K+uU/4twbBbhxhPv9ICSBb6hnVnFOpTn
         8S3Lot2Yi4PD6Nttp+N/Fu2Cv4Pe2uxpST2/uebP3QxHUyiou5Q+HjaZ1n4hBEPZjwkk
         iSEbv7JJoOHyyo/cVIxAUz8AgntHlytq3qj4iTD85j+wGkBTjMnCNm5XJc+HcfHTcWFm
         BPoGr9jY74VX3XBiE4X/QaPCHDsGWC5x0DpQhDWKcCEpkRkGGH37KX99qxBY/81jbnnm
         GuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686496463; x=1689088463;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WY33NERKlb17TukmGOgkhDaG5sdGDG/5hEoznoyZyc=;
        b=Nn59Tdvg1ivoHUWHd+1d5SoKpOw0OZYY03hgyKT1vFrLHG7krnYO2RgmKcoud2ywTI
         pM9iKmWFjJ3wejtvDbG3NyaV7z5oFZJlhNTQa4Gk0a9GgTCvc4EGNDc3BIRwyHf2aPRV
         aOHTtiNIB3HGcQwo4WJPITbVMEendlwG0ymm7X819C7YvQjeMxMk+w2fGrO9l3j7EHoQ
         cSg5neuIW3LkYUOKoa3lpSLpspM4kH45wdW0lE/Cx4Hem6N6craMUuZcjELPKhw9p3D8
         BbIHe5d6tWZ+u897M5HoQ+bkjBrgYxs+hGy+XD+bcEtYMgDPTSaF7L4gK29sTeacMbJl
         nvzw==
X-Gm-Message-State: AC+VfDyQ4NBxuiT53S/VH3O0nbCRSj/ts5QQoUw+gKgqOCDiX8XK6P9r
        TvaDX0PT8m1tmg/HZk6Jzy0=
X-Google-Smtp-Source: ACHHUZ43Ffz5wTnifjxwVl6GRz5Oa44su8A+B7LKcbE7NlYZIHGl1+2DlCG4ylI1qXLoHYRmpVaLdQ==
X-Received: by 2002:a05:6a00:1aca:b0:658:8eae:a8de with SMTP id f10-20020a056a001aca00b006588eaea8demr8076103pfv.4.1686496463153;
        Sun, 11 Jun 2023 08:14:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k67-20020a632446000000b005439aaf0301sm5910871pgk.64.2023.06.11.08.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 08:14:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1e9e0ce4-dc47-81d6-e3a5-681d4a9ba9b0@roeck-us.net>
Date:   Sun, 11 Jun 2023 08:14:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Thomas Gleixner <tglx@linutronix.de>,
        Ido Schimmel <idosch@nvidia.com>
References: <20230607200903.652580797@linuxfoundation.org>
 <b979807a-a437-4d3f-98f9-989da52abb30@roeck-us.net>
 <d35b1ff1-e198-481c-b1be-9e22445efe06@roeck-us.net>
 <ZITNw9cv/WoZcSaO@duo.ucw.cz>
 <39b34446-88a7-eeb5-cf95-e4f1843100b3@roeck-us.net>
Subject: Re: [PATCH 5.15 000/159] 5.15.116-rc1 review
In-Reply-To: <39b34446-88a7-eeb5-cf95-e4f1843100b3@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/23 14:14, Guenter Roeck wrote:
> Hi,
> 
> On 6/10/23 12:23, Pavel Machek wrote:
>> Hi!
>>
>>>> Build results:
>>>>     total: 155 pass: 155 fail: 0
>>>> Qemu test results:
>>>>     total: 499 pass: 498 fail: 1
>>>> Failed tests:
>>>>     arm:kudo-bmc:multi_v7_defconfig:npcm:usb0.1:nuvoton-npcm730-kudo:rootfs
>>>>
>>>> The test failure is spurious and not new. I observe it randomly on
>>>> multi_v7_defconfig builds, primarily on npcm platforms. There is no error
>>>> message, just a stalled boot. I have been trying to bisect for a while,
>>>> but I have not been successful so far. No immediate concern; I just wanted
>>>> to mention it in case someone else hits the same or a similar problem.
>>>>
>>>
>>> I managed to revise my bisect script sufficiently enough to get reliable
>>> results. It looks like the culprit is commit 503e554782c9 (" debugobject:
>>> Ensure pool refill (again)"); see bisect log below. Bisect on four
>>> different systems all have the same result. After reverting this patch,
>>> I do not see the problem anymore (again, confirmed on four different
>>> systems). If anyone has an idea how to debug this, please let me know.
>>> I'll be happy to give it a try.
>>
>> You may want to comment out debug_objects_fill_pool() in
>> debug_object_activate or debug_object_assert_init to see which one is
>> causing the failure...
>>
>> CONFIG_PREEMPT_RT is disabled for you, right? (Should 5.15 even have
>> that option?)
>>
> 
> CONFIG_PREEMPT_RT is disabled (it depends on ARCH_SUPPORTS_RT which is not
> enabled by any architecture in v5.15.y).
> 
> The added call in debug_object_activate() triggers the problem.
> Any idea what to do about it or how to debug it further ?
> 

I did some more debugging. The call to debug_object_activate()
from debug_hrtimer_activate() causes the immediate problem, and the
call from debug_timer_activate() causes a second (less likely) problem,
where the stall is seen during reboot.

In other words, the problem is (only) seen if DEBUG_OBJECTS_TIMERS
is enabled.

Guenter

