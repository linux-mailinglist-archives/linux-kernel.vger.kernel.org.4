Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DC9706360
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjEQIzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEQIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:55:39 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084AC1738;
        Wed, 17 May 2023 01:55:36 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-75774360e46so30666485a.2;
        Wed, 17 May 2023 01:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684313735; x=1686905735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJSseMeMqF5rb+EL1gqYyz1Bbm5YjOsNfD94F8FrFJQ=;
        b=Bf//QUAgiFN0oDDSafog7FM+q1o1RvNS7cR08xUer4CUNVE30OljRYUqOnS9uuGn08
         Hrf2Xnacvr+xSe+CEzxZywbegVeCrEww/LaAKY+eDHh01C/2ihH7goJwP3iYKiuhR8EO
         PA1GKBdrkmOWH2pmI12kem6MonHFpvhdN20Ym3CgiVDzUcZFoWBqxOgRAmL7PRriEy4Z
         3RCDw2bY0sVHPtBQ10RP/jLZO2/CVyxelMeKi2AZTayAdknwNOBdsY04pOAESpqs56Vy
         YLDKVg/AzdWyP7q+XtdJiCK3OwgoAOl4lUtiFn7ClguUIBEasY5D+NF/Jjsh36G6QUsy
         YUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313735; x=1686905735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJSseMeMqF5rb+EL1gqYyz1Bbm5YjOsNfD94F8FrFJQ=;
        b=XPmgmRYEdkTUzKc/uB0TSl/9vA6KUp3heCab4kQGiZ6hanEF4tZle/hP+neHnXoMfR
         Ryjm1JL0ZHDEGHy3nEgG80qfnZ7C5WnFt3ALdZ0B9R3fV1ScibgT+2so/MHgschPgqa1
         AiOZQVLDUM/Othh9MRfuoYUNz0lCFSjmT3HUWUJmTcjtXDFJx0Ef3tJAbIir9DwrVKW9
         6WSC+rd9YLiXOwej8/3N+cZKTmu1mmyf1coyEX93uAR/QfW1+CdXkueg0OWhw8/pqaZs
         FGWb40D+X6MwIa5dcHrEC0Wa3rY8SEjGnLoGAKjpOWM/V7hd62lDJ9mVntzk52SWSu2y
         Z2qQ==
X-Gm-Message-State: AC+VfDyQ4bqZU8gxphbxeOmEeqeJ6SvKEb3U78cMzv0cEvCaA/pI0jCk
        RSEJrAkinI5LT5bkeTo+UShpdF3AQVyyqYgY5+sUUzz1IMPf/A==
X-Google-Smtp-Source: ACHHUZ5iBQ+uufZwsHSmotJRGyX4OWDZawQTeX2E4nLqs1gBteEx6bfxQV0yltCWxu285NfaUgGMn7/f6fkhh2crox8=
X-Received: by 2002:a05:6214:130b:b0:56f:52ba:cce6 with SMTP id
 pn11-20020a056214130b00b0056f52bacce6mr67962542qvb.19.1684313734942; Wed, 17
 May 2023 01:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
 <b36fcdf1-45ab-0c06-efe4-237df0612466@alliedtelesis.co.nz>
 <CACRpkdbiSAFoJP_JB1d_6gQ+Xx7Y+mLAh=C6Za+fpyWuRe6Gbw@mail.gmail.com>
 <31a23398-9b0e-4a19-3576-84fcfd3ce4b5@alliedtelesis.co.nz>
 <ZGQH8/hH0Llx3rzZ@sol> <a61415db-fa3f-2fce-9c21-08d8dd026960@alliedtelesis.co.nz>
In-Reply-To: <a61415db-fa3f-2fce-9c21-08d8dd026960@alliedtelesis.co.nz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 May 2023 11:54:58 +0300
Message-ID: <CAHp75VfSnb2DWX8iMZ7BiSnrEquZdbzvTD+bcHk_Oc_rh7ectw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "johan@kernel.org" <johan@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 2:50=E2=80=AFAM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
> On 17/05/23 10:47, Kent Gibson wrote:

...

> The first is a userspace driver for a Power Over Ethernet Controller+PSE
> chipset (I'll refer to this as an MCU since the thing we talk to is
> really a micro controller with a vendor supplied firmware on it that
> does most of the PoE stuff). Communication to the MCU is based around
> commands sent via i2c. But there are a few extra GPIOs that are used to
> reset the MCU as well as provide a mechanism for quickly dropping power
> on certain events (e.g. if the temperature monitoring detects a problem).

Why does the MCU have no in-kernel driver?

> We do have a small kernel module that grabs the GPIOs based on the
> device tree and exports them with a known names (e.g. "poe-reset",
> "poe-dis") that the userspace driver can use.

So, besides that you repeat gpio-aggregator functionality, you already
have a "proxy" driver in the kernel. What prevents you from doing more
in-kernel?

>  Back when that code was
> written we did consider not exporting the GPIOs and instead having some
> other sysfs/ioctl interface into this kernel module but that seemed more
> work than just calling gpiod_export() for little gain. This is where
> adding the gpio-names property in our .dts would allow libgpiod to do
> something similar.
>
> Having the GPIOs in sysfs is also convenient as we can have a systemd
> ExecStopPost script that can drop power and/or reset the MCU if our
> application crashes.

I'm a bit lost. What your app is doing and how that is related to the
(userspace) drivers?

> I'm not sure if the GPIO chardev interface deals
> with releasing the GPIO lines if the process that requested them exits
> abnormally (I assume it does) and obviously our ExecStopPost script
> would need updating to use some of the libgpiod applications to do what
> it currently does with a simple 'echo 1 >.../poe-reset'
>
> The second application is a userspace driver for a L3 network switch
> (actually two of them for different silicon vendors). Again this needs
> to deal with resets for PHYs connected to the switch that the kernel has
> no visibility of as well as the GPIOs for the SFP cages. Again we have a
> slightly less simple kernel module that grabs all these GPIOs and
> exports them with known names. This time there are considerably more of
> these GPIOs (our largest system currently has 96 SFP+ ports with 4 GPIOs
> per port) so we're much more reliant on being able to do things like
> `for x in port*tx-dis; do echo 1 >$x; done`

Hmm... Have you talked to the net subsystem guys? I know that there is
a lot going on around SFP cage enumeration for some of the modules
(Marvell?) and perhaps they can advise something different.

> I'm sure both of these applications could be re-written around libgpiod
> but that would incur a significant amount of regression testing on
> existing platforms. And I still consider dealing with GPIO chips an
> extra headache that the applications don't need (particularly with the
> sheer number of them the SFP case).

It seems to me that having no in-kernel driver for your stuff is the
main point of all headache here. But I might be mistaken.

--=20
With Best Regards,
Andy Shevchenko
