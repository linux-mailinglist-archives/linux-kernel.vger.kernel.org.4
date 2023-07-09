Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F01C74C44D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGINTM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Jul 2023 09:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGINTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:19:10 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D632CE;
        Sun,  9 Jul 2023 06:19:09 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5701eaf0d04so43044937b3.2;
        Sun, 09 Jul 2023 06:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688908748; x=1691500748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAsWFjQ8XQ0l4a3pjroso8uTitNWzeuQkFoqULC7cZw=;
        b=GRLkFAEMIN2RSyV/zyqsBsj7xW1bQefef1ka0qVb4Hxc+mX1ZCZO2L4VtCnfXHvTOf
         AxxwrrMsvUae95KPFyriSWruzNppps4xcmCxDpwC8dAqDEFV45XRX0gJKcUglSssNH01
         XQrLRT98fdFIg1MErBKxeu9aaTW4nWnTaKSygRsY5EP6UWhWQY4VQWUejM+1g5Q2cW2D
         AVp6RCIo3ZY59rdl5pPg65icVLiJSt2rl4MlPgAhGEqvzZiV2GmSW/ng7ANzCOUWU+Yy
         qNiXRGlaBiXsXCsBbuoJgNeVIb5fVh32OFbM5QXTsxKJAwTloUCk7o1Qh1rL7SogiMgO
         p5jA==
X-Gm-Message-State: ABy/qLbKCnFQIQZ0F3XgGRaDUjMBlbwRHUkoRZjWT/uXJIg4kP+MiFOM
        Jf13JlzESqpGmyfCR0NJ8951Bl97zlmKJg==
X-Google-Smtp-Source: APBJJlE6Ubfev6CzIHYqZpxdI+5ur12FdRnN70K7NByMGYxJXMTW+dm+fTajXPvXKVEybxp/R3n9wA==
X-Received: by 2002:a81:83c8:0:b0:56c:e2db:8d07 with SMTP id t191-20020a8183c8000000b0056ce2db8d07mr9604518ywf.33.1688908748288;
        Sun, 09 Jul 2023 06:19:08 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id w126-20020a814984000000b0057a0e5b18e0sm2411783ywa.142.2023.07.09.06.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 06:19:08 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-c5079a9f1c8so4295076276.0;
        Sun, 09 Jul 2023 06:19:08 -0700 (PDT)
X-Received: by 2002:a05:6902:185:b0:c1d:5719:7c74 with SMTP id
 t5-20020a056902018500b00c1d57197c74mr8062783ybh.31.1688908747883; Sun, 09 Jul
 2023 06:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230709121311.211720-1-contact@artur-rojek.eu>
 <bb896c311151f8ccc7d3e919877641a5e9fbb3ff.camel@physik.fu-berlin.de>
 <2c57d9cc03b6a430234c0016bf78fa22@artur-rojek.eu> <8c075658d00953ecb4383e1910c7b04fdaf870dd.camel@physik.fu-berlin.de>
In-Reply-To: <8c075658d00953ecb4383e1910c7b04fdaf870dd.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 9 Jul 2023 15:18:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWVP4Y4Bp+M-1rzVYmZnu4tVVQR6yAenVVYN+6ogw+Hkw@mail.gmail.com>
Message-ID: <CAMuHMdWVP4Y4Bp+M-1rzVYmZnu4tVVQR6yAenVVYN+6ogw+Hkw@mail.gmail.com>
Subject: Re: [PATCH] sh: hd64461: fix virq offsets
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Rich Felker <dalias@libc.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 9, 2023 at 2:59 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Sun, 2023-07-09 at 14:56 +0200, Artur Rojek wrote:
> > On 2023-07-09 14:48, John Paul Adrian Glaubitz wrote:
> > > On Sun, 2023-07-09 at 14:13 +0200, Artur Rojek wrote:
> > > > A recent change to start counting SuperH IRQ #s from 16 breaks support
> > > > for the Hitachi HD64461 companion chip.
> > > >
> > > > Move the offchip IRQ base and HD64461 IRQ # by 16 in order to
> > > > accommodate for the new virq numbering rules.
> > > >
> > > > Fixes: a8ac2961148e ("sh: Avoid using IRQ0 on SH3 and SH4")
> > > > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > > > --- a/arch/sh/cchips/Kconfig
> > > > +++ b/arch/sh/cchips/Kconfig
> > > > @@ -29,9 +29,9 @@ endchoice
> > > >  config HD64461_IRQ
> > > >   int "HD64461 IRQ"
> > > >   depends on HD64461
> > > > - default "36"
> > > > + default "52"
> > > >   help
> > > > -   The default setting of the HD64461 IRQ is 36.
> > > > +   The default setting of the HD64461 IRQ is 52.
> > > >
> > > >     Do not change this unless you know what you are doing.
> > > >
> > > > diff --git a/arch/sh/include/asm/hd64461.h
> > > > b/arch/sh/include/asm/hd64461.h
> > > > index afb24cb034b1..6d85db6cf54b 100644
> > > > --- a/arch/sh/include/asm/hd64461.h
> > > > +++ b/arch/sh/include/asm/hd64461.h
> > > > @@ -229,7 +229,7 @@
> > > >  #define  HD64461_NIMR            HD64461_IO_OFFSET(0x5002)
> > > >
> > > >  #define  HD64461_IRQBASE         OFFCHIP_IRQ_BASE
> > > > -#define  OFFCHIP_IRQ_BASE        64
> > > > +#define  OFFCHIP_IRQ_BASE        80
> > > >  #define  HD64461_IRQ_NUM         16
> > > >
> > > >  #define  HD64461_IRQ_UART        (HD64461_IRQBASE+5)
> > >
> > > I think it would be better to write this as (64 + 16) for consistency
> > > with the other changes made by Sergey.

Ideally, we want to have a #define for that...

> > Sure, I will send v2 with this change, although the same can't be
> > applied to HD64461_IRQ value above, so some inconsistency will exist
> > either way.
>
> That's okay, that's the user-facing part ;-).

Do we want to keep this Kconfig option? It is rather fragile, and there is
no in-tree config file overriding the default value.
Presumably it was introduced to support an out-of-tree board with
a different wiring.

BTW, there's also this (unused) definition:

arch/sh/include/mach-common/mach/hp6xx.h:#define HP680_HD64461_IRQ
 evt2irq(0x680)  /* IRQ4_IRQ */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
