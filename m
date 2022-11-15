Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C48629A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiKONgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiKONgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:36:12 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BD4FD9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:36:11 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id p1so4928235uak.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7mTdtGmnKT1l4rqdyKapBUF4iLXmO0p5rKdEhhg63U=;
        b=Tg69myXMlgXVtWUU1D5S5CfsA2sHtrEFASYjM3Hh2ugynyxm4UDnoXacIiTDLXGu8K
         N3qNP+RJN4u1X5cZbKCrh6w3gBErjlcfXs0sF0y+tfIvq1hpy0vGAQO7bMrz4LRhzq2m
         triyXAiiJB5E+LCOn4cigI2zeNHff/2UFdV9wcU7SUdJStthca1sjQPONzuIXKwwtNqB
         +9EJ+gbMWnHSQZU2kSkdW5j+69av11QBjBzRsw7lYw/PkPqvbg8tMKNJ0FPTNwD9Ax2X
         lV6EhWlFc6MYlMW3l+fpkMAYxUj4JjCza10rMwdlfzI7bJKbHjT5NSmUZ826E6oC3XCc
         0tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7mTdtGmnKT1l4rqdyKapBUF4iLXmO0p5rKdEhhg63U=;
        b=RosDmz8HPKyf3ALVqktkRvL3zAa94f9dmwE08jsiZAG2m6J5EZobsqMTYdEaPDv9xf
         4oi+u7VSCnAX1U0ZRE2X0Oi6UzxNH9x/O1GR6TSudtpSXP/scwL2A6sALUkDkgHWKJdN
         D6JK/8zR0/OcBK6jcqd3AJmtV1s9HE2bIcYVkDpoEmpV9WtDjAnOpXAHTEooee3sYHin
         ym4M5Egug8OSg07624QLu4to6c2VV+w8E5ht4YNIloIkZSrKWiBI7NR7xBTfYSuX6y6g
         4VzcudSurYU9Y+UwMR+7PlfV9sG0pytjc/Y2G6fcK6x5HSdGgjYkbgrf4Ili5EXsVdn+
         55Nw==
X-Gm-Message-State: ANoB5pnYeAQc6mpDGBAQAXR6/S/PFFCb0NDkMHxyirbpSrXWkGFxBBhB
        7D8Jf4VZ3fzo7y58H6mkyW0EludPXTqGwLF7rBTrvA==
X-Google-Smtp-Source: AA0mqf5DpPJ1UK4Q211u76/jWWRWitTx4shgsyTa5wMd5qmYtp/mR9opW5GexXaqFResUisdhUK+OUTg1mqUDaFVPTI=
X-Received: by 2002:ab0:15b2:0:b0:418:7beb:6f42 with SMTP id
 i47-20020ab015b2000000b004187beb6f42mr4857776uae.92.1668519367898; Tue, 15
 Nov 2022 05:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20221114095332.21079-1-zhuyinbo@loongson.cn> <CAMRc=McnEiSj1Q51pG3Lc8e+HcXE_uU7dm=1VoOa__xOgyoZPg@mail.gmail.com>
 <8b24e3df-8c22-bd09-cfc1-b27e39a05c25@loongson.cn> <fd5cc541-dfc6-d1cf-0865-669b11ce2e7a@xen0n.name>
 <9a448680-0bb6-c4f0-93d2-29a86fede2d4@loongson.cn>
In-Reply-To: <9a448680-0bb6-c4f0-93d2-29a86fede2d4@loongson.cn>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 15 Nov 2022 14:35:56 +0100
Message-ID: <CAMRc=McQ-_3rmHFMW_f+oscuEi+18OJHYz7jBFLm_fh2qA1EHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: loongson: add dts/acpi gpio support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Linus Walleij <linus.walleij@linaro.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 2:07 PM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>
>
>
> =E5=9C=A8 2022/11/15 =E4=B8=8B=E5=8D=886:17, WANG Xuerui =E5=86=99=E9=81=
=93:
> > Sorry for jumping in, but...
> >
> > On 2022/11/15 17:53, Yinbo Zhu wrote:
> >>
> >>
> >> =E5=9C=A8 2022/11/15 =E4=B8=8B=E5=8D=885:05, Bartosz Golaszewski =E5=
=86=99=E9=81=93:
> >>> On Mon, Nov 14, 2022 at 10:53 AM Yinbo Zhu <zhuyinbo@loongson.cn> wro=
te:
> >>>>
> >>>> The latest Loongson series platform use dts or acpi framework to
> >>>> register gpio device resources, such as the Loongson-2 series
> >>>> SoC of LOONGARCH architecture. In order to support dts, acpi and
> >>>> compatibility with previous platform device resources in driver,
> >>>> this patch was added.
> >>>>
> >>>> Signed-off-by: lvjianmin <lvjianmin@loongson.cn>
> >>>> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
> >>>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> >>>> Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
> >>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> >>>> ---
> >>>> Change in v2:
> >>>>                  1. Fixup of_loongson_gpio_get_props and remove the
> >>>> parse logic about
> >>>>                     "loongson,conf_offset", "loongson,out_offset",
> >>>> "loongson,in_offset",
> >>>>                     "loongson,gpio_base", "loongson,support_irq"
> >>>> then kernel driver will
> >>>>                     initial them that depend compatible except
> >>>> "loongson,gpio_base".
> >>>>
> >>>>   arch/loongarch/include/asm/loongson.h         |  13 +
> >>>>   .../include/asm/mach-loongson2ef/loongson.h   |  12 +
> >>>>   .../include/asm/mach-loongson64/loongson.h    |  13 +
> >>>>   drivers/gpio/Kconfig                          |   6 +-
> >>>>   drivers/gpio/gpio-loongson.c                  | 422
> >>>> +++++++++++++++---
> >>>>   5 files changed, 391 insertions(+), 75 deletions(-)
> >>>>
> >>>> diff --git a/arch/loongarch/include/asm/loongson.h
> >>>> b/arch/loongarch/include/asm/loongson.h
> >>>> index 00db93edae1b..383fdda155f0 100644
> >>>> --- a/arch/loongarch/include/asm/loongson.h
> >>>> +++ b/arch/loongarch/include/asm/loongson.h
> >>>> @@ -60,6 +60,19 @@ static inline void xconf_writeq(u64 val64,
> >>>> volatile void __iomem *addr)
> >>>>          );
> >>>>   }
> >>>>
> >>>> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Data structrues =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> >>>> +
> >>>> +/* gpio data */
> >>>> +struct platform_gpio_data {
> >>>> +       u32 gpio_conf;
> >>>> +       u32 gpio_out;
> >>>> +       u32 gpio_in;
> >>>> +       u32 support_irq;
> >>>> +       char *label;
> >>>> +       int gpio_base;
> >>>> +       int ngpio;
> >>>> +};
> >>>
> >>> This is a terrible name for an exported structure. You would at least
> >>> need some kind of a namespace prefix. But even then the need to add a
> >>> platform data structure is very questionable. We've moved past the
> >>> need for platform data in the kernel. I don't see anyone setting it u=
p
> >>> in this series either. Could you provide more explanation on why you
> >>> would need it and who would use it?
> >> okay, I will add a namespace prefix, about this platform data was adde=
d
> >> that was to compatible with legacy platforms that do not support dts o=
r
> >> acpi, then, the mips loongson platform or loongarch loongson platform
> >
> > Why are you trying to support "legacy" LoongArch platforms when the
> > architecture was just upstreamed *this year*?
> the leagacy gpio driver had support LoongArch, and you can find some
> gpio register defined in arch/loongarch/include
> /asm/loongson.h in legacy gpio driver, such as LOONGSON_GPIODATA,
> The legacy gpio driver is the driver that doesn't include my gpio patch.
> >
> >> can implement the gpio device driver to initialize the
> >> platform_gpio_data structure as needed after exporting the structure.
> >>>
> >>>> +
> >>>>   /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D LS7A registers =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> >>>>   #define LS7A_PCH_REG_BASE              0x10000000UL
> >>>>   /* LPC regs */
> >>>> diff --git a/arch/mips/include/asm/mach-loongson2ef/loongson.h
> >>>> b/arch/mips/include/asm/mach-loongson2ef/loongson.h
> >>>> index ca039b8dcde3..b261cea4fee1 100644
> >>>> --- a/arch/mips/include/asm/mach-loongson2ef/loongson.h
> >>>> +++ b/arch/mips/include/asm/mach-loongson2ef/loongson.h
> >>>> @@ -315,4 +315,16 @@ extern unsigned long _loongson_addrwincfg_base;
> >>>>
> >>>>   #endif /* ! CONFIG_CPU_SUPPORTS_ADDRWINCFG */
> >>>>
> >>>> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Data structrues =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> >>>> +
> >>>> +/* gpio data */
> >>>> +struct platform_gpio_data {
> >>>> +       u32 gpio_conf;
> >>>> +       u32 gpio_out;
> >>>> +       u32 gpio_in;
> >>>> +       u32 support_irq;
> >>>> +       char *label;
> >>>> +       int gpio_base;
> >>>> +       int ngpio;
> >>>> +};
> >>>
> >>> No idea why you would need to duplicate it like this either. And why
> >>> put it in arch/.
> >> because loongson platform include mips and loongarch, and the gpio
> >> device data was defined in arch/ in leagcy loongson gpio driver.  so t=
he
> >> latest loongson gpio drvier add platform_gpio_data in same dir.
> >
> > I think at this point it's hopefully clear, that the way forward to
> > supporting Loongson IP blocks shared between MIPS/LoongArch SoCs is to
> > start over and do things properly, making the code as platform-agnostic
> > as possible. Just make sure the drivers can get initialized via DT and
> > ACPI then you're all set -- the upstream kernel is guaranteed to use on=
e
> > of the two well-established boot flows for every Loongson chip it
> > supports. Be it hard-coded DT in arch/mips/boot/dts/loongson, or the
> > LoongArch ACPI/upcoming DT, no need for hard-coding things in arch/ in
> > either case.
> Our old platforms are used by customers, but we will not maintain those
> platforms. Adding dts/acpi support to those old platforms not only makes
> no sense, but also affects their use. Because the configuration of
> dts/acpi requires the support of the firmware team, but in fact, we have
> no one to maintain those old platforms.
>
> in a words, My patch to upstream was supposed to consider dts/acpi in
> LoongArch platform  But I have to consider the original legacy gpio
> driver and to compatible with it.

Which legacy driver are you referring to? Neither gpio-loongson nor
gpio-loongson1 define any platform data. If it wasn't needed before
then it's sure we won't be adding it in 2022. If you have board-files
upstream that need to use this driver then you can do fine with
regular device properties.

Bartosz
