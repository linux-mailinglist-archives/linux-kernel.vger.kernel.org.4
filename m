Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F366373D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKXIXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKXIXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:23:06 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7C12B260
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:23:05 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id 124so879601vsv.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qmRgK6iHDDD9jUd+afLu/0d0Ew0cdPS8bY9iC3x34M=;
        b=wrIlOBoMs6QQSclG7dH6GjVcfyrqXV0yQ1u3aG+e1sAqHH9Y+hHttWomM3LZqUw32k
         nkJkU1eMPUhvTLG6ds11eZR6MuazdqHYrPsVYBbaVDditxbUQVOrm1O2ywORTCwjS7EP
         +U7cMnomLkAZQb/5Hfdo/iUhj+31WBKdr6OnrupJVbqcemQ4R3q87icWxkahNWilgqtU
         S06UZIzovWkovRY41VSUfHF03vkQYG4LDoLdIbNpzbEcEX8Dv0jYLZN/DJrlEYW+e+Gn
         mO3WdJO1WCkFBf5RZT4w8Do+nJXlo5dFYteduLDUxfR0RvZ/pWDjKcIcvFVb46fCWxfs
         r11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qmRgK6iHDDD9jUd+afLu/0d0Ew0cdPS8bY9iC3x34M=;
        b=rSaWMl2g9XJAnCWygq/0pYR6M/Rg7+Vm7ZNOa1uDYPwCLsUwyTpi3SrO8Y6L5SqF5I
         mHMb0qTG9Oy3A3JM8/i5vb2qlEUVTMqM1kxr2F+U1yfrwFkQOALWkVPqoL75FOJ6pRyC
         tOerKXiCvB2/E6I8aO2XmDTLiQiGuTk/5XLSdA/WQsBro6HyI4NQJ0LG7GtxNnAmcqRT
         7B1td5zAFsVG7HasUt0n6y5Nx87x8bgL/3z05RyLjLamUWshUo7IShQSRlXSYxMIXwsC
         a3j0im/g8wfs3t/LLiXc0Q23pt/w3gnew2GaQw2RMJk5ZuTW4MpJX3vrK410shn0hyot
         8pJQ==
X-Gm-Message-State: ANoB5pk0EGRHb3yk4IMWWmX6XCW+OQKDVBb/RKl3SkeDyUHx4CKhkxnF
        1eQWK4EvwQjk/SLfKEUG5xNRRCrxOvIxQ+4EUOUNVw==
X-Google-Smtp-Source: AA0mqf5soPczq85B7Su9wnMaQiQuhCvUW6GSUbGBrWPQb6CMzXdAbt/bQwCjTHuBblb7HRlAv3kudwdSeixLE4PUChQ=
X-Received: by 2002:a05:6102:829:b0:3b0:6449:baba with SMTP id
 k9-20020a056102082900b003b06449babamr6403999vsb.61.1669278184524; Thu, 24 Nov
 2022 00:23:04 -0800 (PST)
MIME-Version: 1.0
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-12-uwe@kleine-koenig.org> <CAMRc=Mfjcs-BBFhr8O1O956f4jdvAzY9ofZs1fme8+Ki=T60JA@mail.gmail.com>
 <CAMRc=MfwSabay==DcyONc4AVgOPETsA5x3wuLX05Ndvfwiv4bg@mail.gmail.com> <20221123164132.gfglkwgknqkwywnq@pengutronix.de>
In-Reply-To: <20221123164132.gfglkwgknqkwywnq@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 24 Nov 2022 09:22:53 +0100
Message-ID: <CAMRc=Mf=h_nVAzRhY_YEuiur+9Wbx+kEwPj-iB=PqHn3ULYJ6A@mail.gmail.com>
Subject: Re: [PATCH 011/606] gpio: max732x: Convert to i2c's .probe_new()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        linux-gpio@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        Grant Likely <grant.likely@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 5:41 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Wed, Nov 23, 2022 at 04:49:05PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 23, 2022 at 10:47 AM Bartosz Golaszewski <brgl@bgdev.pl> wr=
ote:
> > >
> > > On Fri, Nov 18, 2022 at 11:46 PM Uwe Kleine-K=C3=B6nig <uwe@kleine-ko=
enig.org> wrote:
> > > >
> > > > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > >
> > > > .probe_new() doesn't get the i2c_device_id * parameter, so determin=
e
> > > > that explicitly in the probe function.
> > > >
> > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
> > > > ---
> > > >  drivers/gpio/gpio-max732x.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/gpio/gpio-max732x.c b/drivers/gpio/gpio-max732=
x.c
> > > > index da6972117030..68e982cdee73 100644
> > > > --- a/drivers/gpio/gpio-max732x.c
> > > > +++ b/drivers/gpio/gpio-max732x.c
> > > > @@ -608,9 +608,9 @@ static struct max732x_platform_data *of_gpio_ma=
x732x(struct device *dev)
> > > >         return pdata;
> > > >  }
> > > >
> > > > -static int max732x_probe(struct i2c_client *client,
> > > > -                                  const struct i2c_device_id *id)
> > > > +static int max732x_probe(struct i2c_client *client)
> > > >  {
> > > > +       const struct i2c_device_id *id =3D i2c_client_get_device_id=
(client);
> > > >         struct max732x_platform_data *pdata;
> > > >         struct device_node *node;
> > > >         struct max732x_chip *chip;
> > > > @@ -707,7 +707,7 @@ static struct i2c_driver max732x_driver =3D {
> > > >                 .name           =3D "max732x",
> > > >                 .of_match_table =3D of_match_ptr(max732x_of_table),
> > > >         },
> > > > -       .probe          =3D max732x_probe,
> > > > +       .probe_new      =3D max732x_probe,
> > > >         .id_table       =3D max732x_id,
> > > >  };
> > > >
> > > > --
> > > > 2.38.1
> > > >
> > >
> > > Applied, thanks!
> > >
> > > Bartosz
> >
> > Ugh, backing it out, I thought these patches were independent.
>
> They depend on i2c_client_get_device_id which you can get into your tree
> either by pulling in
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c=
/client_device_id_helper-immutable
>
> or by waiting until this hits Linus Torvald's tree and updating to that.
>
> I'd like to see the gpio patches go in via the gpio tree. If you choose
> not to pull in the above and apply now, I will resend (per subsystem)
> the remaining patches based on the next -rc1 containing that function.
>

That's alright, I pulled Wolfram's branch and re-applied the three patches.

Bart
