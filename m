Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25047744C13
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 05:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGBDDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 23:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGBDDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 23:03:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C991706;
        Sat,  1 Jul 2023 20:03:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-668704a5b5bso2637295b3a.0;
        Sat, 01 Jul 2023 20:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688267016; x=1690859016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+WkD1spmkCtSByMtGbTNiya9x18zjitcw6zTIWUJH4=;
        b=GIbz09WVg7xNtgefGpf32hZ6ZxYca2OFbdDyTaszABCACg/4CH9MkOu4l4Nl3gxgWN
         YubC5PWZmWa/GRi1Yvv5hyi5OzFxtuOaAMuf4jz8syzRofFApCctiDHpW4j2F5iFV6Sn
         gX2dJXhNdW8cumMub8w/D25yGfhpOEcokRmyu6Q0vBLlXVq1Klrlx+hldFChw2Lx8fn5
         fF+VNnsqA0IVp0wYhY0sSsZbwNFQOoy1NS5Gt/z3P5pcYNX6UXtlRbBIVqcYwT6Ahchs
         GUYpAyq2sArhVdvrxeT3JLF/Ff7yZVAhYkcJ9W8ATeCBayghWoFCp2CO5ZTqPSWNhiD2
         ZwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688267016; x=1690859016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+WkD1spmkCtSByMtGbTNiya9x18zjitcw6zTIWUJH4=;
        b=a6LyStjvMhFrqay5MdyHFJAtHmXyteE6P5q/QSzIxiA/PZK4mxUeE/LVLUsxGhsRuz
         NWAu3ReiXAazWP0DDMLg4uax6AUlK9GwqvToxeQnbEPmbEua7Aac12NNmjvPPBLTg33q
         szs79eiF/7QtezqLDejxtlROsHYYIcwj1xtrGlxGQXJfa5l5Oen7aVbuM1XedGMW2ZQr
         ZfeXN66M3cMg21TmrbkNf8Qp4vzxZq2YHo1DJDmgp8o63+rO6+OmOfGwF+BoQlDsZasD
         mecHqEvX1uKZB/ORRkggMWAXYKH7XeZ2A49dpKLPKeO7EXeZoTHh/t5TSJ4xo0lK/RIK
         tl2A==
X-Gm-Message-State: ABy/qLZKxRek3BobVEiihOFmYtREXIHm0mwnkNtm+Oo9JjSY62TkoiMX
        0U06oEgH2Tm0O3HRYQfIQA8=
X-Google-Smtp-Source: APBJJlE3EOfGlv4GwutC6Fr9Wf5e7s+tgg0H+RBJMnTQRCrpa9+9+63Ln4KG7fGGJ8CZdXFrLQkyig==
X-Received: by 2002:a05:6a00:1806:b0:66b:6021:10fe with SMTP id y6-20020a056a00180600b0066b602110femr9802737pfa.31.1688267015903;
        Sat, 01 Jul 2023 20:03:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 5-20020aa79145000000b006688e3de86fsm11979372pfi.85.2023.07.01.20.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 20:03:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8d0e1a7c-3533-4b02-c1d6-3732f9680b2b@roeck-us.net>
Date:   Sat, 1 Jul 2023 20:03:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 6/6] watchdog/hardlockup: Define
 HARDLOCKUP_DETECTOR_ARCH
To:     Doug Anderson <dianders@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "David S . Miller" <davem@davemloft.net>
References: <20230616150618.6073-1-pmladek@suse.com>
 <20230616150618.6073-7-pmladek@suse.com>
 <7cfc15f1-d8d0-4418-b7a1-5aa9e90e3fb3@roeck-us.net>
 <CAD=FV=UsgweS0pTpr=6xE-+Dx0fqXgjN=3Gf-4MQcNAzjL+64w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAD=FV=UsgweS0pTpr=6xE-+Dx0fqXgjN=3Gf-4MQcNAzjL+64w@mail.gmail.com>
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

On 7/1/23 09:08, Doug Anderson wrote:
> Hi,
> 
> On Sat, Jul 1, 2023 at 7:40 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Fri, Jun 16, 2023 at 05:06:18PM +0200, Petr Mladek wrote:
>>> The HAVE_ prefix means that the code could be enabled. Add another
>>> variable for HAVE_HARDLOCKUP_DETECTOR_ARCH without this prefix.
>>> It will be set when it should be built. It will make it compatible
>>> with the other hardlockup detectors.
>>>
>>> The change allows to clean up dependencies of PPC_WATCHDOG
>>> and HAVE_HARDLOCKUP_DETECTOR_PERF definitions for powerpc.
>>>
>>> As a result HAVE_HARDLOCKUP_DETECTOR_PERF has the same dependencies
>>> on arm, x86, powerpc architectures.
>>>
>>> Signed-off-by: Petr Mladek <pmladek@suse.com>
>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>> ...
>>> --- a/include/linux/nmi.h
>>> +++ b/include/linux/nmi.h
>>> @@ -9,7 +9,7 @@
>>>   #include <asm/irq.h>
>>>
>>>   /* Arch specific watchdogs might need to share extra watchdog-related APIs. */
>>> -#if defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)
>>> +#if defined(CONFIG_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)
>>
>> This results in:
>>
>> arch/powerpc/platforms/pseries/mobility.c: In function 'pseries_migrate_partition':
>> arch/powerpc/platforms/pseries/mobility.c:753:17: error: implicit declaration of function 'watchdog_hardlockup_set_timeout_pct'; did you mean 'watchdog_hardlockup_stop'? [-Werror=implicit-function-declaration]
>>    753 |                 watchdog_hardlockup_set_timeout_pct(factor);
>>
>> with ppc64_defconfig -CONFIG_HARDLOCKUP_DETECTOR, because the dummy
>> for watchdog_hardlockup_set_timeout_pct() is still defined in
>> arch/powerpc/include/asm/nmi.h which is no longer included.
> 
> Can you test with:
> 
> https://lore.kernel.org/r/20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a9e1a9d4c4@changeid
> 

Sorry for the noise. I didn't find that one.

Yes, that should work. It is a bit odd that including both linux/nmi.h
and asm/nmi.h is required, but as it turns out that is actually quite common.

Thanks,
Guenter


