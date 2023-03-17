Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC71E6BF0CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCQSiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCQSiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:38:09 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12330584B9;
        Fri, 17 Mar 2023 11:37:59 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id g6so2686019iov.13;
        Fri, 17 Mar 2023 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679078278;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=doTBEIPrtJGrIVKGzCIV43Qeoz4CxJQQLeaZ0TGaW9Q=;
        b=hSbf2GewkqwWqibfrWgkVO7XXcHstCvhpYn/F4tkL6BYH44pB6P8kEuSebAOVrHMmL
         zi2RPkBYqkPVZsDvNup5EmBAlEd2IaokgDFflK8I3ytcHVnW0lF9l4kJzt16f5x9t0pM
         hGjPHt0szAsGj3sQuPmfzhj6nzmHG0BYF5TIJ2iwCGbVqLGNct5ZgSSyFsizv/S0b4BN
         lSSqXXzxJxZdp9sidj23nGsSMC5vnBJ8wS9Vwm1UFJqoDKxITXWkaDrmaPgS7+Sf+igo
         GhdG9GykYGdrQSoePQfnGTpSdUQiMAqsBWIp45fE9ALXsxFEoEALrvXjYF4S32E6IwsF
         LLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679078278;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doTBEIPrtJGrIVKGzCIV43Qeoz4CxJQQLeaZ0TGaW9Q=;
        b=ZfmpharfZNH9LcCVAh9RbHeVTX0N87xfFfskWpiwtSlO/Rq7WP/GNP0nbVikSOfrN5
         h50PEebuoFFTKf6zr/glLUp6zjEoJJS4ATrtHuafNT9reTzUluQuE/vXbQsFic58b55A
         GA8aKoIYG/kwNkyv5aPObn3aC5bAL2PI2aJNkZ89zSrJovUkpjwNvxddEcqnMdg+gZwu
         LmS83LxHJ90MJuz9EpS9XfOq7II3D8aiEWawFym1zujh6KIhRZ9uQyRE2vzt0QTHWedd
         a4kCLToa7GcVatBfmXtYA1QehyCAXKCYr74fqUXlksmrkLMEOkP4KV82h9X9AmsdYePo
         ZePQ==
X-Gm-Message-State: AO0yUKX18XZaAG68ngHAk3iIp5WZdK20jSHIsHCY4qoOEgL6jwy254Ue
        uxeK2aP8jHPaMcxh6h+EWtU=
X-Google-Smtp-Source: AK7set89qP2jQ0x7Zcy+DFqgPLQjIL0udBlesLSIV2ZSwz3/NAWdm44y9/1Aw9RHvJd3zAZMKUUTVA==
X-Received: by 2002:a5d:9c89:0:b0:752:fd8e:5ee4 with SMTP id p9-20020a5d9c89000000b00752fd8e5ee4mr386005iop.1.1679078278421;
        Fri, 17 Mar 2023 11:37:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e30-20020a026d5e000000b0040631c91311sm875212jaf.91.2023.03.17.11.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 11:37:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4b2d6f4a-4868-9ffe-e1e1-9feafe41ccdd@roeck-us.net>
Date:   Fri, 17 Mar 2023 11:37:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, ulf.hansson@linaro.org,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        adrian.hunter@intel.com, skhan@linuxfoundation.org,
        davidgow@google.com, pbrobinson@gmail.com, gsomlo@gmail.com,
        briannorris@chromium.org, arnd@arndb.de, krakoczy@antmicro.com,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221205085351.27566-1-tmaimon77@gmail.com>
 <20221205085351.27566-3-tmaimon77@gmail.com>
 <f28c7c34-077c-4c7e-afd8-c4180718d403@roeck-us.net>
 <CAHp75Vegm=jmuJ6q5qofuLKm_LggKmtQZWcVgQN=MG3kMMCTRA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
In-Reply-To: <CAHp75Vegm=jmuJ6q5qofuLKm_LggKmtQZWcVgQN=MG3kMMCTRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/23 10:36, Andy Shevchenko wrote:
> On Fri, Mar 17, 2023 at 4:16 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Mon, Dec 05, 2022 at 10:53:51AM +0200, Tomer Maimon wrote:
>>> Add Nuvoton NPCM BMC sdhci-pltfm controller driver.
>>>
>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>
>> I still don't see this driver in the upstream kernel, or in linux-next.
>>
>> Couple of comments:
>>
>> - devm ordering does not really matter here. The devm resource
>>    is the clock, it does not depend on local data, and it will be
>>    released last, so that is ok.
> 
> Not sure. Strictly speaking this is the problem. If you leave a clock
> going on in a wrong period of time it (theoretically) might break your
> hardware once and forever. Similar discussion about power, clock and
> reset signals has been held for camera sensors.
> 

In general I agree, but not here. The remove function (sdhci_pltfm_unregister)
does call clk_disable_unprepare(), so the clock isn't left running.

Also, I think it is worthwhile to point out that exactly the same sequence
(sdhci_pltfm_init followed by devm_clk_get and cleanup/removal with
sdhci_pltfm_unregister) is shared among several sdhci drivers (including
the memory leak I pointed out, but only in the aspeed driver).

On a higher level I do agree that the sdhci platform code is in need of cleanup,
but I don't think it is appropriate to tie such a cleanup to this driver
submission.

Note that I don't really care much, I just realized that this patch is stuck
when I tried to test booting from SD drive with qemu.

Guenter

