Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BC76A8015
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCBKlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCBKlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:41:49 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B2B2CFE6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:41:46 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-536bbef1c5eso418988337b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1677753706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szoAPIE9RLg8SyW+42dEQKwq5qglsGdZPucFgQhY0/A=;
        b=gtHXWnWEP7JrkAkqs7UngZsUtO12av+z17lis0xLuEyWguFdxpE7zD4/gRcrSbv4L3
         yjXXUO9hTUiTmKdAdBlW0gKaBZKKXpX4D9ZpvYvbtZuEJ7p0KaPbfHYaamVpoYgwElQs
         HiqxuJAHg9Hhc0tp2XQshv04T+2GF8hoXUpGLum0j8N3yDDrfRf3KhXR3OlcvRbEKl5G
         JU/ka4ea4V8Z0gWbvWteKXgwnZH9Iq2i9aQVK98iAIsZ2Kym5S5PqyxR7WjcaTMFvKVa
         rc9MVd2v3QVxwnblV2KkIKSNA4SfX8GrWkfeUsplhvLEOWxdYvLAlxJEF4GS9hV5uter
         pSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677753706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szoAPIE9RLg8SyW+42dEQKwq5qglsGdZPucFgQhY0/A=;
        b=BJkIB6zi7OCjzF4+JwYVc2JkKIFO5JWMsMfGnqi2paZZGvpVeJrvZaEv1Dux+go+VP
         YYA9zs8ZcvyLghPXdwZfK3WlU0HumwjD7WOGRcXx/JH+sYK9ZjmyAvJ0S1aA+N9l7yGp
         z0Wo1N5/hlP5BJ/V/0JFZh4C55oVoBlZBvSg6esO6Z3agMRioBAnIow6eaTuQ0i1VT84
         T58Z4+lL4BQ4Ia2pOaMljAWHKqUg5ny99SVlcU925lXhnVOVy0FJdNDNEn8ivnFPCntB
         SvOdExl5bsFp+svq6hM6Odz2OrdrMBwGHvEkF0dQ0d9bZsnFhZXV7moqdhNdXb9HnitL
         Cwvg==
X-Gm-Message-State: AO0yUKX5T9JLHMdJ1cGZphOjX6LOt2x2VAGSonveH8lSUGeuINtaMT8d
        hxPKf2M78R7RyzE9Z0B7TetifBMr1LrU+zupzmTb8w==
X-Google-Smtp-Source: AK7set87M/AbgxYhMgy1BNJoD32ttiD+1yNN3ghOZW22JFluXJamrHcQOmG2Ay4OU54yPfNiSO4wP3Fp8RerwNWIWtQ=
X-Received: by 2002:a81:441b:0:b0:52e:d2a7:1ba1 with SMTP id
 r27-20020a81441b000000b0052ed2a71ba1mr5998495ywa.1.1677753706026; Thu, 02 Mar
 2023 02:41:46 -0800 (PST)
MIME-Version: 1.0
References: <20230130093229.27489-1-nylon.chen@sifive.com> <20230130093229.27489-3-nylon.chen@sifive.com>
 <20230130101707.pdvabl3na2wpwxqu@pengutronix.de> <CAHh=Yk_hFOjwY1mbmYk8yqH_AKDs1_3J+5pYQStseNsZukPSoA@mail.gmail.com>
 <20230301092050.gwwbfsltyuow7pq6@pengutronix.de>
In-Reply-To: <20230301092050.gwwbfsltyuow7pq6@pengutronix.de>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Thu, 2 Mar 2023 18:41:31 +0800
Message-ID: <CAHh=Yk-Yt4q78tpThGR=HTz-Rgjp0LsU1H=eULgo3pg8scS=XA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe

Thanks for your reply.

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2023=E5=B9=
=B43=E6=9C=881=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:21=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hello Nylon,
>
> On Wed, Feb 01, 2023 at 04:56:42PM +0800, Nylon Chen wrote:
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2023=
=E5=B9=B41=E6=9C=8830=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:17=E5=
=AF=AB=E9=81=93=EF=BC=9A
> > > On Mon, Jan 30, 2023 at 05:32:29PM +0800, Nylon Chen wrote:
> > > > The `frac` variable represents the pulse inactive time, and the res=
ult of
> > > > this algorithm is the pulse active time. Therefore, we must reverse=
 the
> > > > result.
> > > >
> > > > The reference is SiFive FU740-C000 Manual[0].
> > > >
> > > > [0]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-8=
6ed8b16acba_fu740-c000-manual-v1p6.pdf
> > > >
> > > > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > > > ---
> > > >  drivers/pwm/pwm-sifive.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > > index 62b6acc6373d..a5eda165d071 100644
> > > > --- a/drivers/pwm/pwm-sifive.c
> > > > +++ b/drivers/pwm/pwm-sifive.c
> > > > @@ -158,6 +158,7 @@ static int pwm_sifive_apply(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> > > >       frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> > > >       /* The hardware cannot generate a 100% duty cycle */
> > > >       frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > > > +     frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
> > >
> > > The same problem exists in pwm_sifive_get_state(), doesn't it?
> > >
> > > As fixing this is an interruptive change anyhow, this is the opportun=
ity
> > > to align the driver to the rules tested by PWM_DEBUG.
> > >
> > > The problems I see in the driver (only checked quickly, so I might be
> > > wrong):
> > >
> > >  - state->period !=3D ddata->approx_period isn't necessarily a proble=
m. If
> > >    state->period > ddata->real_period that's fine and the driver shou=
ld
> > >    continue
> > >
> > >  - frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> > >    is wrong for two reasons:
> > >    it should round down and use the real period.
> > >
> > I need a little time to clarify your assumptions. If possible, I will
> > make similar changes.
> >
> > e.g.
> > rounddown(num, state->period);
> > if (state->period < ddata->approx_period)
> >     ...
>
> the idea is that for a given request apply should do the following to
> select the hardware setting:
>
>  - Check polarity, if the hardware doesn't support it, return -EINVAL.
>    (A period always starts with the active phase for the duration of
>    duty_cycle. For normal polarity active =3D high.)
>  - Pick the biggest period length possible that is not bigger than the
>    requested period.
>  - For the picked period, select the biggest duty_cycle possible that is
>    not bigger than the requested duty_cycle.
>
> Then if possible switch to the selected setting in an atomic step.
>
> Does this clearify your doubts?
I need a little time to clarify your assumptions. Thanks again.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
