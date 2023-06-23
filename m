Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F348973BDD6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjFWReU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWReS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:34:18 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B745E1FC2;
        Fri, 23 Jun 2023 10:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687541652; bh=uijmNbUmIlHkh56jJTNP2T+S8lHX64iWOnrHTLZxmMY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c7ReWnrwTc9Z/yK/YxC63JsOxA9Ryx737DuAuXNPnXzjONrx43KxaW58qqTnmf5wa
         vcBAKCY6htQxSV4Ljc8ozyQ9fQAqvAKLzv2/2cTylYnPWouKP8/3deP8ypWTkbt+hO
         JkcqaXhSmlP1nGMj2yVoRdr+ONFZJkcIRgT8V2AU=
Received: from [192.168.9.172] (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id E9C0C600A9;
        Sat, 24 Jun 2023 01:34:11 +0800 (CST)
Message-ID: <ec964673-4dcd-df8d-9a90-15c84215080f@xen0n.name>
Date:   Sat, 24 Jun 2023 01:34:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] LoongArch: Add SMT (Simultaneous Multi-Threading) support
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Liupu Wang <wangliupu@loongson.cn>, Len Brown <lenb@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
References: <20230614093755.88881-1-wangliupu@loongson.cn>
 <CAJZ5v0iTKPbpskDVcsnVaWnhdvb5a-W2TVBfd0c=H2hVv8mOog@mail.gmail.com>
 <CAAhV-H7=+cyLK=whuYL3qD+CwFqxvSWywnLEVJ5W=0uqH+ZKiQ@mail.gmail.com>
 <CAJZ5v0jQD2ABKy3h9FXaKpvW9gcyTXngDAcVikZKQ5PxbyEH=g@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAJZ5v0jQD2ABKy3h9FXaKpvW9gcyTXngDAcVikZKQ5PxbyEH=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/24/23 01:20, Rafael J. Wysocki wrote:
> On Thu, Jun 15, 2023 at 4:31 AM Huacai Chen <chenhuacai@kernel.org> wrote:
>> Hi, Rafael,
>>
>> On Thu, Jun 15, 2023 at 2:24 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Wed, Jun 14, 2023 at 11:38 AM Liupu Wang <wangliupu@loongson.cn> wrote:
>>>> [snip]
>>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>>> index ccbeab9500ec..00dd309b6682 100644
>>>> --- a/drivers/acpi/Kconfig
>>>> +++ b/drivers/acpi/Kconfig
>>>> @@ -542,10 +542,10 @@ config ACPI_PFRUT
>>>>
>>>>   if ARM64
>>>>   source "drivers/acpi/arm64/Kconfig"
>>>> +endif
>>>>
>>>>   config ACPI_PPTT
>>>>          bool
>>>> -endif
>>> x86 doesn't use PPTT as of today.  Why do you enable it for them?
>> ACPI_PPTT is an invisible symbol, it cannot be enabled by explicitly
>> selecting and its default value is n, so I think it isn't enabled for
>> x86. On the other hand, moving it out of ARM64 can make other archs
>> don't need to modify this file any more if they need PPTT.
> AFAICS, setting ACPI_PPTT causes pptt.c to be compiled and if it is
> never going to be used by the given arch, it will just be dead code.
>
> Can't this be avoided?

FYI I've just tried a x86_64 defconfig build and ACPI_PPTT isn't being 
enabled, nor is there a pptt.o signifying the same thing.

 > drivers/acpi/Makefile
 > 109:obj-$(CONFIG_ACPI_PPTT)     += pptt.o

This should mean that, if nothing is selecting ACPI_PPTT then the file 
isn't going to be compiled? Right now it seems only arch/arm64 and 
arch/loongarch are doing so based on my cursory grep. Or do you mean we 
should be extra careful and keep the guard around the symbol to ensure 
it's nonexistent on other irrelevant arches?

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

