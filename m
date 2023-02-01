Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F0F686231
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjBAI5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAI46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:56:58 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C9246168
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:56:57 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 129so21491117ybb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 00:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIDwgLQh+NbqNP8OLmpO2Vx3bIkolFmj8N0nOzJV3+k=;
        b=TLyEwLxYxs6dcNxg13tL0YvHZNaEW9ystM8icB0p1pEg3m4P/ZEXsxAhHEn5ADG8Ha
         cnRTVF/iaelxwZmVxFTfVD2YlSCKSt9ucC/HU4P3ALuEfDdy+8POAuguQSIBSp27nFP+
         E3KZ1wk/D9piWPJQJ7cVOFr0HlYhsOTHYXcNNOqKNsJCoAOKYRXdzHenkKZlLGQZHjUW
         mDsy3Wyb/o8g3eZDIrAICnOHwod4+DsXalQQ+X/Vq/BBAl8avH2ewj+uiRF9UL13CJZE
         4DIFVQVACV+aeF157msUhsPBPoo9OBYo1GR7xpN+VDvr5Cqr8SHc7IJhIJ2dUwQFkrIO
         SLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIDwgLQh+NbqNP8OLmpO2Vx3bIkolFmj8N0nOzJV3+k=;
        b=6CceE4qtjKW2MjLhEYiCQAI+dzPA2xFi3VNR8kpkIBzOoWGklfWTCXTkVWeqGDSEd+
         nZMONnsxAfW2MTe3rPNXtIhJZ92NevnQinej586sLWsifPopxMLBtkJilGDacuqq2kYa
         6B9KpdCZPuUL26vWvejcunBchHEAoyqLBq39+dyomVvGqVKyi/g1HAqsuwkOW2EJSDMz
         CzmAhzJBxZA2Ls0BNIEAnDcljg0fQ0fCOw69xRlP0HiyCkzyZ3kIrlAM4/w8qePbuMO0
         HbBRejbcS+PRIHzS35bV48BjgAZe4oV29gU0nYmbXHtmS0yHvd66mwdmCs7vaCQoo9AA
         U1hQ==
X-Gm-Message-State: AO0yUKU3wuwvGhLAzIk4m13I2ITiYd0k5Aq7db2cr+yDFbG2a5tewNpp
        /zMnvdMix1bGF+xeiBgpTT04wfG2WKmhL4bo18bcwA==
X-Google-Smtp-Source: AK7set8BNnJY9+pWPPb/CtKCpODIDdh4g/co09R/6gTTgNOK8AdgLPa9G6N+48YHmDvjNYnsTen/FrCksbGVOD6nEzc=
X-Received: by 2002:a25:8185:0:b0:80b:5cc8:6350 with SMTP id
 p5-20020a258185000000b0080b5cc86350mr277961ybk.154.1675241816664; Wed, 01 Feb
 2023 00:56:56 -0800 (PST)
MIME-Version: 1.0
References: <20230130093229.27489-1-nylon.chen@sifive.com> <20230130093229.27489-3-nylon.chen@sifive.com>
 <20230130101707.pdvabl3na2wpwxqu@pengutronix.de>
In-Reply-To: <20230130101707.pdvabl3na2wpwxqu@pengutronix.de>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Wed, 1 Feb 2023 16:56:42 +0800
Message-ID: <CAHh=Yk_hFOjwY1mbmYk8yqH_AKDs1_3J+5pYQStseNsZukPSoA@mail.gmail.com>
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

Hi Uwe,

Thanks for your reply.

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
>
I need a little time to clarify your assumptions. If possible, I will
make similar changes.

e.g.
rounddown(num, state->period);
if (state->period < ddata->approx_period)
    ...

thanks a lot.






> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
