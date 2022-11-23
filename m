Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EA86364B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiKWPw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238238AbiKWPvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:51:41 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AA0C67EC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:50:55 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id t85so8922139vkb.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lk0yfEtk3BvnUHwTPrp3NjmYiw9JacTy/YeEdlh9ydw=;
        b=IY4N6ZpBuG6R8rdLkhlKx0WqDftmupfzYYuCl9n6aPp4pmn3PmGuSibHJBo9Eqijm2
         vBvpEQcNVB0PoxKHy9s++hWwFQKsWI9K13WeKPRTfhR5LcpuBFFSjY0c8tUIwBFPuYmH
         lR6pFjB9n3ym8zzWPvXLm1lz5ztqPpIAfZ9XMnrnZzeQFhROVp3H5sCX0VuOTtQt2ZK9
         q/2lHr+LWXDybHf/fq6T4VnXO3xYri9pQLChrLu0xIX7xKgGs0u4FFy8p30bKkiEs9iC
         kB5tGyCyHxH2r4fCCzea5LAgNINvMt0jU9sDynyYV07QXrTzLg5UubCFA0NaW9YlLXSS
         3y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lk0yfEtk3BvnUHwTPrp3NjmYiw9JacTy/YeEdlh9ydw=;
        b=fZGNb/woO71zSEu1ZivhFv5kz7AGUEdT37/aPeswYmdWeORTAjeiGlDO6i01sNdQsn
         wuiRzuS1H/dXYey+bS5MhS3vafpxfH6bMu61SjFP8Wxu5re1hr9NDJ6y6sQ/XkB7z4E3
         zv5X0qQcTF9n5VWhlMK6inhNZit+9uA53apUZwgNgvQFOFFJHZfO0uA3yemPl0O8uEkw
         p7Ifrr3D8bB1KCt60OEPmpjYBt90ueLgj5REu0bv4mKAzM9Yf045Ge+Ucti5Cut5Vb9A
         MvrClatdDgF8H0dSCXb2zx2VniWLD25li1HnAa3cHc56n1nRHlqo5DEcE4MmLNs8JZM2
         i8Ag==
X-Gm-Message-State: ANoB5pm2cdopKg/HgjhBD1TIPsFuEycZ9gSEtL8Y4o+y8RbS4m2wu1eA
        6ueKjKeKp6MFmBwVQ0x30jWrOaozwK3WisqTWUBqUw==
X-Google-Smtp-Source: AA0mqf66qAjspGrg7C5iAS9j9Oucom4zx2aarOvSmzlAYEKQ3K1iN2thxwAPDtEjVXeIFxZXBuFd2Tlm/xIymBGZuZw=
X-Received: by 2002:a1f:54c1:0:b0:3b7:65cc:8ebc with SMTP id
 i184-20020a1f54c1000000b003b765cc8ebcmr10695118vkb.5.1669218654732; Wed, 23
 Nov 2022 07:50:54 -0800 (PST)
MIME-Version: 1.0
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-14-uwe@kleine-koenig.org> <CAMRc=Mc8QByAUsp5N1mD+rs-BayHs3A9sjjivzX_jGP2oQfHPg@mail.gmail.com>
In-Reply-To: <CAMRc=Mc8QByAUsp5N1mD+rs-BayHs3A9sjjivzX_jGP2oQfHPg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 23 Nov 2022 16:50:43 +0100
Message-ID: <CAMRc=MeB7gVQ5RFLBHFb49Nf4UOZejsir2OmpRU+pkF8jZf+tg@mail.gmail.com>
Subject: Re: [PATCH 013/606] gpio: pcf857x: Convert to i2c's .probe_new()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Nov 23, 2022 at 10:48 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Fri, Nov 18, 2022 at 11:46 PM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig=
.org> wrote:
> >
> > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >
> > .probe_new() doesn't get the i2c_device_id * parameter, so determine
> > that explicitly in the probe function.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/gpio/gpio-pcf857x.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-pcf857x.c b/drivers/gpio/gpio-pcf857x.c
> > index e98ea47d7237..cec2f2c78255 100644
> > --- a/drivers/gpio/gpio-pcf857x.c
> > +++ b/drivers/gpio/gpio-pcf857x.c
> > @@ -247,9 +247,9 @@ static const struct irq_chip pcf857x_irq_chip =3D {
> >
> >  /*--------------------------------------------------------------------=
-----*/
> >
> > -static int pcf857x_probe(struct i2c_client *client,
> > -                        const struct i2c_device_id *id)
> > +static int pcf857x_probe(struct i2c_client *client)
> >  {
> > +       const struct i2c_device_id *id =3D i2c_client_get_device_id(cli=
ent);
> >         struct pcf857x_platform_data    *pdata =3D dev_get_platdata(&cl=
ient->dev);
> >         struct device_node              *np =3D client->dev.of_node;
> >         struct pcf857x                  *gpio;
> > @@ -422,7 +422,7 @@ static struct i2c_driver pcf857x_driver =3D {
> >                 .name   =3D "pcf857x",
> >                 .of_match_table =3D of_match_ptr(pcf857x_of_table),
> >         },
> > -       .probe  =3D pcf857x_probe,
> > +       .probe_new =3D pcf857x_probe,
> >         .remove =3D pcf857x_remove,
> >         .shutdown =3D pcf857x_shutdown,
> >         .id_table =3D pcf857x_id,
> > --
> > 2.38.1
> >
>
> Applied, thanks!
>
> Bartosz

Same story as with the other ones:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
