Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D73629596
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbiKOKRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiKOKR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:17:29 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A90B61;
        Tue, 15 Nov 2022 02:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1668507444; bh=WHr2ExZRk8L8KdSJaScpbxLlfZXqwuhVfiMdT9FUlO4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HHU0B6Ok7zVOQ49GSdWezvezxQQFIvFEgTgpYSFE4Vtag1ALbcHP29lab/37lJab8
         Nk5aKjq64KBx7F9ZwX8GC66jBGHvXrs74tX2QqFIf9s7OAdEIPOpKgKPG1jk6FcP/N
         Y3MKP4hoO3sYcO82on8O4/b8Li5lgOZDWaYw8swo=
Received: from [100.100.57.122] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 328F0600CE;
        Tue, 15 Nov 2022 18:17:24 +0800 (CST)
Message-ID: <fd5cc541-dfc6-d1cf-0865-669b11ce2e7a@xen0n.name>
Date:   Tue, 15 Nov 2022 18:17:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:108.0)
 Gecko/20100101 Thunderbird/108.0a1
Subject: Re: [PATCH v2 1/2] gpio: loongson: add dts/acpi gpio support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        lvjianmin <lvjianmin@loongson.cn>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20221114095332.21079-1-zhuyinbo@loongson.cn>
 <CAMRc=McnEiSj1Q51pG3Lc8e+HcXE_uU7dm=1VoOa__xOgyoZPg@mail.gmail.com>
 <8b24e3df-8c22-bd09-cfc1-b27e39a05c25@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <8b24e3df-8c22-bd09-cfc1-b27e39a05c25@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for jumping in, but...

On 2022/11/15 17:53, Yinbo Zhu wrote:
> 
> 
> 在 2022/11/15 下午5:05, Bartosz Golaszewski 写道:
>> On Mon, Nov 14, 2022 at 10:53 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>>>
>>> The latest Loongson series platform use dts or acpi framework to
>>> register gpio device resources, such as the Loongson-2 series
>>> SoC of LOONGARCH architecture. In order to support dts, acpi and
>>> compatibility with previous platform device resources in driver,
>>> this patch was added.
>>>
>>> Signed-off-by: lvjianmin <lvjianmin@loongson.cn>
>>> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
>>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>>> Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>> ---
>>> Change in v2:
>>>                  1. Fixup of_loongson_gpio_get_props and remove the 
>>> parse logic about
>>>                     "loongson,conf_offset", "loongson,out_offset", 
>>> "loongson,in_offset",
>>>                     "loongson,gpio_base", "loongson,support_irq" then 
>>> kernel driver will
>>>                     initial them that depend compatible except 
>>> "loongson,gpio_base".
>>>
>>>   arch/loongarch/include/asm/loongson.h         |  13 +
>>>   .../include/asm/mach-loongson2ef/loongson.h   |  12 +
>>>   .../include/asm/mach-loongson64/loongson.h    |  13 +
>>>   drivers/gpio/Kconfig                          |   6 +-
>>>   drivers/gpio/gpio-loongson.c                  | 422 +++++++++++++++---
>>>   5 files changed, 391 insertions(+), 75 deletions(-)
>>>
>>> diff --git a/arch/loongarch/include/asm/loongson.h 
>>> b/arch/loongarch/include/asm/loongson.h
>>> index 00db93edae1b..383fdda155f0 100644
>>> --- a/arch/loongarch/include/asm/loongson.h
>>> +++ b/arch/loongarch/include/asm/loongson.h
>>> @@ -60,6 +60,19 @@ static inline void xconf_writeq(u64 val64, 
>>> volatile void __iomem *addr)
>>>          );
>>>   }
>>>
>>> +/* ============== Data structrues =============== */
>>> +
>>> +/* gpio data */
>>> +struct platform_gpio_data {
>>> +       u32 gpio_conf;
>>> +       u32 gpio_out;
>>> +       u32 gpio_in;
>>> +       u32 support_irq;
>>> +       char *label;
>>> +       int gpio_base;
>>> +       int ngpio;
>>> +};
>>
>> This is a terrible name for an exported structure. You would at least
>> need some kind of a namespace prefix. But even then the need to add a
>> platform data structure is very questionable. We've moved past the
>> need for platform data in the kernel. I don't see anyone setting it up
>> in this series either. Could you provide more explanation on why you
>> would need it and who would use it?
> okay, I will add a namespace prefix, about this platform data was added
> that was to compatible with legacy platforms that do not support dts or
> acpi, then, the mips loongson platform or loongarch loongson platform

Why are you trying to support "legacy" LoongArch platforms when the 
architecture was just upstreamed *this year*?

> can implement the gpio device driver to initialize the
> platform_gpio_data structure as needed after exporting the structure.
>>
>>> +
>>>   /* ============== LS7A registers =============== */
>>>   #define LS7A_PCH_REG_BASE              0x10000000UL
>>>   /* LPC regs */
>>> diff --git a/arch/mips/include/asm/mach-loongson2ef/loongson.h 
>>> b/arch/mips/include/asm/mach-loongson2ef/loongson.h
>>> index ca039b8dcde3..b261cea4fee1 100644
>>> --- a/arch/mips/include/asm/mach-loongson2ef/loongson.h
>>> +++ b/arch/mips/include/asm/mach-loongson2ef/loongson.h
>>> @@ -315,4 +315,16 @@ extern unsigned long _loongson_addrwincfg_base;
>>>
>>>   #endif /* ! CONFIG_CPU_SUPPORTS_ADDRWINCFG */
>>>
>>> +/* ============== Data structrues =============== */
>>> +
>>> +/* gpio data */
>>> +struct platform_gpio_data {
>>> +       u32 gpio_conf;
>>> +       u32 gpio_out;
>>> +       u32 gpio_in;
>>> +       u32 support_irq;
>>> +       char *label;
>>> +       int gpio_base;
>>> +       int ngpio;
>>> +};
>>
>> No idea why you would need to duplicate it like this either. And why
>> put it in arch/.
> because loongson platform include mips and loongarch, and the gpio 
> device data was defined in arch/ in leagcy loongson gpio driver.  so the
> latest loongson gpio drvier add platform_gpio_data in same dir.

I think at this point it's hopefully clear, that the way forward to 
supporting Loongson IP blocks shared between MIPS/LoongArch SoCs is to 
start over and do things properly, making the code as platform-agnostic 
as possible. Just make sure the drivers can get initialized via DT and 
ACPI then you're all set -- the upstream kernel is guaranteed to use one 
of the two well-established boot flows for every Loongson chip it 
supports. Be it hard-coded DT in arch/mips/boot/dts/loongson, or the 
LoongArch ACPI/upcoming DT, no need for hard-coding things in arch/ in 
either case.

>>
>> [snip]
>>
>> I will hold off reviewing the rest of the patch until we get that 
>> clarified.
>>
>> Bartosz
>>
> 

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

