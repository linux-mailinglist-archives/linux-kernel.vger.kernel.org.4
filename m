Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFF27396B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjFVFKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjFVFKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:10:23 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069181BE7;
        Wed, 21 Jun 2023 22:10:09 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b5a1f873c4so1841311a34.3;
        Wed, 21 Jun 2023 22:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687410608; x=1690002608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=K30hKHPNlpwVBN4hAbzq27Ryl8UpEUmxkCcNKmrn040=;
        b=hMg2oNQ2hAJL6skCb2iWazvZcsAmFgSigwnotmuqZ8lfpc+lwaUIaalhEvD48Q1Trj
         wPRHOl1MuZHrRuAJVQ4yU2P0H2JKvETiQmH1tBChiNUHBjdBvEso56+0o1UeamnmmYRL
         XMoZdzXw7fsLfMUa7Yh5yxZ00SY9cAwtLwYF8xXkfLIPb61rpCNmCGMT3naAGElhaxlw
         wO7jXcBanTkvhDQMzm1uyTTR9CmEIAq/G5uVLMynQWrQVIDhmqivujSVhafGYGB63uku
         pzMg6sx/n7WxQRDOlEFMKNDUkQOoyP+4Djjxs0LlWAhyw9QOq1oNUgxqW4HPTSc/05Ei
         nz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687410608; x=1690002608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K30hKHPNlpwVBN4hAbzq27Ryl8UpEUmxkCcNKmrn040=;
        b=egLHbJvs/JO35mHJdvEbmrIc+u6Rv2KK0nTvTrnCeZIcslBBW43FTtn6C50lLB/TIB
         tRoOyde+6a1ruVNs0+oMaZV7YN7Fl2AGgwbuImpWchJ9v1qTGxv7HWyLlZ00mJNX1N97
         Q7UDYCbSFqAvA4KDCzwwFtRPNH8R/GPoYBySTufn161F1w0zk1+tpDKv3szUQ+alQoH4
         b/IgAAZgaKDZnH1b+RhMQIFJgKLYRjKHeldAFqDKjG+oCx0GrfP5K8C+K/C4Rfpd8PKy
         tg+iZ17KocbJXeM43wzWMUDavqZapUfDHuD7FW9wxJ6RFc15/HpIUN9df1osxOeC+b8t
         E/0A==
X-Gm-Message-State: AC+VfDywUdmvmP/XpQ6ZORTS1CVYhJqREesJWgFGyvxKafyWgijVzIN/
        7fwHcLg4DDBWtE8WAcmUS1LMlOnBBs8=
X-Google-Smtp-Source: ACHHUZ5v7BW6k7gRIME+ptq1So6ZyAFbBnaj54o3iiSkzJI+VzmesGTn5U+QNryohy3lx164UJEcnQ==
X-Received: by 2002:a05:6830:4c4:b0:6b5:9826:4a53 with SMTP id s4-20020a05683004c400b006b598264a53mr6223266otd.1.1687410608209;
        Wed, 21 Jun 2023 22:10:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g6-20020a6544c6000000b00520f4ecd71esm3546579pgs.93.2023.06.21.22.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 22:10:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a268ecb4-9580-10c7-b3aa-ac679bf3e4c3@roeck-us.net>
Date:   Wed, 21 Jun 2023 22:10:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] ata: octeon: Add compile test support
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-ide@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230614173633.2430653-1-robh@kernel.org>
 <20230614173633.2430653-2-robh@kernel.org>
 <23325977-ba37-4360-afb5-4ab38a66107e@roeck-us.net>
 <feef6589-d0d6-8e64-fefd-914c234dcfba@kernel.org>
 <167e83a0-8666-27af-5e2c-4ddda917795a@roeck-us.net>
 <78cce73d-16d1-e357-bee7-2176479604f4@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <78cce73d-16d1-e357-bee7-2176479604f4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/21/23 21:26, Damien Le Moal wrote:
> On 6/22/23 12:01, Guenter Roeck wrote:
>> On 6/21/23 17:57, Damien Le Moal wrote:
>>> On 6/22/23 01:51, Guenter Roeck wrote:
>>>> On Wed, Jun 14, 2023 at 11:36:33AM -0600, Rob Herring wrote:
>>>>> Add COMPILE_TEST to enable building Cavium Octeon drivers in MIPS
>>>>> allyesconfig/allmodconfig builds. There's a dependency on MIPS headers,
>>>>> so other arches can't be enabled.
>>>>>
>>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>>> ---
>>>>> Tested on allmodconfig build. Not sure if there's other MIPS configs
>>>>> where this doesn't work. We'll see what 0-day says.
>>>>
>>>> Odd, in next-20230621 I get:
>>>>
>>>> Building mips:allmodconfig ... failed
>>>
>>> Indeed odd. Given that this is an allmodconfig, I would assume that
>>> CONFIG_CAVIUM_OCTEON_SOC is set ?
>>>
>>
>> No, it is not. CONFIG_CAVIUM_OCTEON_SOC is a choice option,
>> meaning only one of the choices can be set, and mips:allmodconfig
>> selects a different choice.
> 
> OK. Then I think I need to drop this patch as I do not see how to allow
> COMPILE_TEST without CONFIG_CAVIUM_OCTEON_SOC being set.
> 

That is a contradiction anyway. COMPILE_TEST implies that the target is
independent of any other compile flags. If it depends on CONFIG_CAVIUM_OCTEON_SOC,
overriding that with COMPILE_TEST does not make sense.

Guenter

> Rob ?
> 
>>
>> Guenter
>>
>>>> --------------
>>>> Error log:
>>>> ERROR: modpost: "__udivdi3" [drivers/ata/pata_octeon_cf.ko] undefined!
>>>> ERROR: modpost: "octeon_get_io_clock_rate" [drivers/ata/pata_octeon_cf.ko] undefined!
>>>> ERROR: modpost: "__tracepoint_ata_bmdma_stop" [drivers/ata/pata_octeon_cf.ko] undefined!
>>>> ERROR: modpost: "__traceiter_ata_bmdma_stop" [drivers/ata/pata_octeon_cf.ko] undefined!
>>>> ERROR: modpost: "__divdi3" [drivers/ata/pata_octeon_cf.ko] undefined!
>>>> make[2]: [scripts/Makefile.modpost:144: Module.symvers] Error 1 (ignored)
>>>> make[2]: *** No rule to make target 'kernel/locking/locktorture.ko', needed by '__modfinal'.  Stop.
>>>> make[1]: [Makefile:1933: modules] Error 2 (ignored)
>>>>
>>>> Guenter
>>>
>>
> 

