Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CD46891A2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjBCIJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjBCII4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:08:56 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C6895D11
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:06:51 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5249a65045aso26619497b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 00:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsQ1fz/5ts1oSbk5jHHBvcB4Ie2MesFk+szUUh6A4jY=;
        b=LrIwQLQExZfBlHn96+8T9yAYVF7blScAuSGTxSWxoA4gsaRWuliWlI/EmEpMiQszqy
         ItKdQsPVYDFI28Tee4ozKKOFmJpNbUFnzqLlySzvHIFtJMmeYJEU/FQDQPxO9tGnWImb
         ChxHReQT5QbqbWjN8sBcG4F9yrFw8JdAZ/oJRU2puvshBFvS43slCt/lWOAXEoBsrYSQ
         zLyAozAoYMY8rclOnYjO6ztyX7NdziBo1sVv9jsOBETK/jrWOGrchy1uLIGUrODiaV46
         Jmu17ImPhr9sA4dYAIyM8v/9YE1/IZlGVvl5wislwhzJmfmZs3Yz7Cg4FgPWs61G7dUH
         Y35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsQ1fz/5ts1oSbk5jHHBvcB4Ie2MesFk+szUUh6A4jY=;
        b=2GSYHjAr2IhL99O3W37B1+hXg3XX3sIoO1DMTBmEjZdl+4OLHAycRg1AjnvurEzjuq
         xzjdOMXZlt6Wnml1SjsqzfarqXJ5rE9WbQFioFsPLL/TjSZavURSBALWbMWYgkBWNqUC
         iOfhsHvqhuNQo+GeeSUOHy72PNu320TMBKko8EdUbj9VLaCt/9EdOmmzKpDaWU7zsnq1
         9wmyXYa8BKZuPQBSVc7fFsH8HIiCHEDb8MqyLbzOFt8bGsfZmxTBNudt26BYEtzOaFhP
         9XQFskl4aYLugN5Zo0fWepeAatthw4bvoGnUhnNhN6GGbbVCDIsKMz/EzxeFvPMeZpeH
         qgrA==
X-Gm-Message-State: AO0yUKUW/B0X2gODfxMI0I0UpTC+MHTvJIJjXSVqLd8hZesd3jrs1etT
        cYuS92YzLHbZnTQVlMPxob4s2ju4R5Bb9cJ5pB5aUQ==
X-Google-Smtp-Source: AK7set/o+IabmEdqaU/6vnUZGJwr98FRwvsJQoYCYLMkAqoqU7g2zvHizcifaV74heDDmMnxUXCX16hSI10n6ex5G1g=
X-Received: by 2002:a81:2515:0:b0:4fd:417b:7b8a with SMTP id
 l21-20020a812515000000b004fd417b7b8amr1014395ywl.404.1675411611090; Fri, 03
 Feb 2023 00:06:51 -0800 (PST)
MIME-Version: 1.0
References: <20230130093229.27489-1-nylon.chen@sifive.com> <20230130093229.27489-3-nylon.chen@sifive.com>
 <20230130101707.pdvabl3na2wpwxqu@pengutronix.de>
In-Reply-To: <20230130101707.pdvabl3na2wpwxqu@pengutronix.de>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Fri, 3 Feb 2023 16:06:38 +0800
Message-ID: <CAHh=Yk85NHbm9eUKLm75GUP4gSP5eYFjVabTUXseyB6wHD4D=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: sifive: change the PWM controlled LED algorithm
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     aou@eecs.berkeley.edu, conor@kernel.org,
        emil.renner.berthing@canonical.com, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, nylon7717@gmail.com,
        zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2023=E5=B9=
=B41=E6=9C=8830=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:17=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On Mon, Jan 30, 2023 at 05:32:29PM +0800, Nylon Chen wrote:
> > The `frac` variable represents the pulse inactive time, and the result =
of
> > this algorithm is the pulse active time. Therefore, we must reverse the
> > result.
> >
> > The reference is SiFive FU740-C000 Manual[0].
> >
> > [0]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8=
b16acba_fu740-c000-manual-v1p6.pdf
> >
> > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > ---
> >  drivers/pwm/pwm-sifive.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > index 62b6acc6373d..a5eda165d071 100644
> > --- a/drivers/pwm/pwm-sifive.c
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -158,6 +158,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >       frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> >       /* The hardware cannot generate a 100% duty cycle */
> >       frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > +     frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
>
> The same problem exists in pwm_sifive_get_state(), doesn't it?
>
> As fixing this is an interruptive change anyhow, this is the opportunity
> to align the driver to the rules tested by PWM_DEBUG.
>
> The problems I see in the driver (only checked quickly, so I might be
> wrong):
>

>  - state->period !=3D ddata->approx_period isn't necessarily a problem. I=
f
>    state->period > ddata->real_period that's fine and the driver should
>    continue
>
>  - frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
>    is wrong for two reasons:
>    it should round down and use the real period.
are you mean state->period is a redundancy variable so we can use
ddata->real_period directly?

it seems reasonable, but I don't get your point, why do we need to
change the algorithm to DIV_ROUND_DOWN_ULL() and change the if-else
condition.

frac =3D DIV_ROUND_DOWN_ULL(num, ddata->real_period);
if (state->period < ddata->approx_period) {
    ...
}

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
