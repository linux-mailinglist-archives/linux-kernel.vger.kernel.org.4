Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C14664B712
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbiLMONa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbiLMOMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:12:48 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD92420F54
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:11:50 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id n205so14305915oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=T9fBPZ3cvhwxlIbAToCD1RhaObrm4/4AXeDAeYG8TUw=;
        b=odseQVN4IOK1y7eLveSmHbFoNenj1BDOZ4ZzPItVmPos67biTmifn+ay8Q30JO89LB
         RLP2BwZYZFqT7PZSQhUdsEcwj1hrYNBOIKNWtrmp77TlcekN4KE/Z1eaS7KrdvqrhQip
         2Pj5FuvSpYYv3nb4UFf/McOERUvm3dEc9isVIzQbT5y5zY5TAesuTKKQ6rIQfOv1yilG
         y1z7ZDdI6005DdRnNdg+5FHekUfTL67vbiMBV8rdbKeBWLaQPCDfyT//HAKO+TR/ONkX
         UWNPRS+FYD3Y6fwwgTGDTr+pUTuCnTowBHX3ETZcmBpD86n4YVOU1HdPsk3rNrIb9QM9
         Sbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9fBPZ3cvhwxlIbAToCD1RhaObrm4/4AXeDAeYG8TUw=;
        b=myGopUWSLWiqVNRvt5IbuXt7+gpQ6LL9gAJEzW8HUlycRYrwfNbhAk76LlA8+6eoZh
         u2x20f2kK2pEaSWD84Pa5mbjwRuUWEZqbDPDvIE4bqUNNuaNPi/JeUmij4rfsqU1qvTU
         /+xrmI96m52ePhnK92HZa0ro1uvGMrI1tDXV+avDHtKTiaR/OeeuzpXdtJGVm89IEiW5
         TOopnb2vlB5RwckgmfMI3WFSeAv3SRfPhcceNgAaf+x4mMRoPXGVt6Iqov4IuNA8B6TG
         SdOgapFHB6BAiTu7dPSR0Yu7geGw8tJI/wFdgOEfWNbFzKLy5ADVQsyEiJnXuQ7wMvGC
         Iy9g==
X-Gm-Message-State: ANoB5plV5JnTWCyIcacVwnfngojAP/ABkwl5I1PwiACIrt8w1jTzHULe
        YFOHGfB3nSRWbiK430x3IGg=
X-Google-Smtp-Source: AA0mqf7gN36VXlHEBg1UtiDC/6eRgdKmc1ip6wevu8tWWQ/Ip+wyBsrGeMXvZzsONBvgFxHONsdp3Q==
X-Received: by 2002:a05:6808:1987:b0:35e:4393:8d71 with SMTP id bj7-20020a056808198700b0035e43938d71mr12693104oib.28.1670940709975;
        Tue, 13 Dec 2022 06:11:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a30-20020a544e1e000000b0035a9003b8edsm4561548oiy.40.2022.12.13.06.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 06:11:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fd532051-7b11-3a0a-0dd1-13e1820960db@roeck-us.net>
Date:   Tue, 13 Dec 2022 06:11:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: mainline build failure due to e240e53ae0ab ("mm, slub: add
 CONFIG_SLUB_TINY")
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>
References: <Y5hTTGf/RA2kpqOF@debian> <20221213131140.GA3622636@roeck-us.net>
 <48cd0d18-a13c-bf20-e064-2041f63b05bf@suse.cz>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <48cd0d18-a13c-bf20-e064-2041f63b05bf@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 05:27, Vlastimil Babka wrote:
> On 12/13/22 14:11, Guenter Roeck wrote:
>> On Tue, Dec 13, 2022 at 10:26:20AM +0000, Sudip Mukherjee (Codethink) wrote:
>>> Hi All,
>>>
>>> The latest mainline kernel branch fails to build xtensa allmodconfig
>>> with gcc-11 with the error:
>>>
>>> kernel/kcsan/kcsan_test.c: In function '__report_matches':
>>> kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
>>>    257 | }
>>>        | ^
>>>
>>> git bisect pointed to e240e53ae0ab ("mm, slub: add CONFIG_SLUB_TINY")
>>>
>>
>> In part that is because above commit changes Kconfig dependencies such
>> that xtensa:allmodconfig actually tries to build kernel/kcsan/kcsan_test.o.
>> In v6.1, CONFIG_KCSAN_KUNIT_TEST is not enabled for xtensa:allmodconfig.
> 
> OK, so IIUC
> - e240e53ae0ab introduces SLUB_TINY and adds !SLUB_TINY to KASAN's depend
> - allyesconfig/allmodconfig will enable SLUB_TINY
> - thus KASAN is disabled where it was previously enabled
> - thus KCSAN which depends on !KASAN is enabled where it was previously disabled
> - also arch/xtensa/Kconfig:    select ARCH_HAS_STRNCPY_FROM_USER if !KASAN
> 
>> Downside of the way SLUB_TINY is defined is that it is enabled for all
>> allmodconfig / allyesconfig builds, which then disables building a lot
>> of the more sophisticated memory allocation options.
> 
> It does disable KASAN, but seems that on the other hand allows enabling
> other stuff.
> Is there a way to exclude the SLUB_TINY option from all(mod/yes)config? Or
> it needs to be removed to SLUB_FULL and logically reversed?
> 

"depends on !COMPILE_TEST" should do it. Not sure though if that would just
hide the other compile failures seen with powerpc and arm allmodconfig
builds.

Guenter

