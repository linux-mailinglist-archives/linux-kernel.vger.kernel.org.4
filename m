Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CC16EA7F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjDUKKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjDUKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:10:10 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D575C650
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:10:07 -0700 (PDT)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6AAB341B35
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682071805;
        bh=5YumTTaZigtajWfQ+JzNYvW7LQCQxaN5lHA7qa2E8us=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=OgqwOD0CIw9KL/XUcWgbupJU0JE99bgTFfSpEYbwCe6JpZ0I4YFe8uPTgPEdE/jJO
         yBxnRSc8Szymr73p8y2XgYjP1KXA+75ZosZi28IIlMCOWLm3GJhJxVOdZnMHfKYuAi
         Oc4zTzlS0GWJqWwR9Vz0Wewq468cAjOUYXh+mCAdF9wFBaRm5O+0btyTpOU4+7bAeQ
         0vZAFbT1fmSulsm2kdz2BquUOzLx7skrkcJZnJDx3ZqkVv5MT4HfEVghuwiYJuo48d
         U8Oz9PrJnljKAunKyJpn0Yqzdvle5YQwHuSxtpZuF+oKNizWUcdnp85u0EekkdMF+J
         JDVLJKVXgeYgQ==
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74e04ba5cbbso123148085a.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682071803; x=1684663803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YumTTaZigtajWfQ+JzNYvW7LQCQxaN5lHA7qa2E8us=;
        b=CqlHOsIV5YyID//mXK0pFhngctgY+UUC/fR2utM8yS/jAzMmo49T2hzlm+hR9eRtxQ
         1nU1wViQcQfNQD7uXeX5BAJ+XpMQhwGPMHMiw9v5WOkLEaelLD3bZvLkLIufX3+/eyIx
         wcLmevBts579GT2y6BMJZPu+5mnkYeVtXKDcDeOPqbAVPJwosbDKCAbcjShpd0RBwF76
         Cdv06aVJmLSRqKpg/JQ0aKS2lXjDGw/dZtBM+RduH0sbl6wNo65uvXoCwczJN2wMx/EQ
         k18QhOTxmWf5KyWVy5W9G1IQFDheJvMNJ6tqXfddSJaLNuUgujpozD4rMqKmqq/rFQi/
         VDYA==
X-Gm-Message-State: AAQBX9dzFg7NbsRRn+3cZLHgBykG2JfNWHC5cHPo5AuQoRRzdswYzjat
        cU1RIeumoGA0GrB/NzkGywsFgd/28ccX+nTIsxI6I6H9QS0AqQNrqlXucU+mGl7Zwa17hjSR6IT
        Tu4kmRrHAIn1RDzbjZ38YZaozEX9XgchSGmfD2w0nm/Gxbe38j2d+yXnEkQ==
X-Received: by 2002:a05:622a:1817:b0:3ec:48a3:d597 with SMTP id t23-20020a05622a181700b003ec48a3d597mr7349059qtc.60.1682071803345;
        Fri, 21 Apr 2023 03:10:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y2Ct3bKH9HpK7ssNl4cHQnZUXUWvdVJwevDhOvPemPOTtXGlc1hhOeSveMf1sjnhPC6kLUdb+2WAHj2K+Quqc=
X-Received: by 2002:a05:622a:1817:b0:3ec:48a3:d597 with SMTP id
 t23-20020a05622a181700b003ec48a3d597mr7349024qtc.60.1682071803038; Fri, 21
 Apr 2023 03:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230420093457.18936-1-nylon.chen@sifive.com> <20230420093457.18936-3-nylon.chen@sifive.com>
 <CAJM55Z-smXpgL+QyTSeAWt=B-RS_qtbrFZtJpP-cQS0gsQnDSw@mail.gmail.com>
 <CAHh=Yk86AV542Y7wG6rkHTc4va1Gof3uXtj84zzK5m+khL_Aiw@mail.gmail.com>
 <CAJM55Z9TPVyJyWwWAS2FznSc8FvnR7qMxQ412eMzBkD=5abp6g@mail.gmail.com> <CAHh=Yk9mBDtFM4TRKEknNgrMN9qK4XtmPWLAT2E2P3RHwVh6ww@mail.gmail.com>
In-Reply-To: <CAHh=Yk9mBDtFM4TRKEknNgrMN9qK4XtmPWLAT2E2P3RHwVh6ww@mail.gmail.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 21 Apr 2023 12:09:47 +0200
Message-ID: <CAJM55Z_2HX6ja8axLWR+tiBbw=cUHXwaRwf=pE35dWLWV6pcGQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: sifive: change the PWM controlled LED algorithm
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     aou@eecs.berkeley.edu, conor@kernel.org, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 at 08:16, Nylon Chen <nylon.chen@sifive.com> wrote:
>
> Hi Emil,
>
> Emil Renner Berthing <emil.renner.berthing@canonical.com> =E6=96=BC 2023=
=E5=B9=B44=E6=9C=8820=E6=97=A5
> =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:46=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Thu, 20 Apr 2023 at 12:41, Nylon Chen <nylon.chen@sifive.com> wrote:
> > >
> > > Hi, Emil
> > >
> > > Emil Renner Berthing <emil.renner.berthing@canonical.com> =E6=96=BC 2=
023=E5=B9=B44=E6=9C=8820=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:04=
=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > > On Thu, 20 Apr 2023 at 11:35, Nylon Chen <nylon.chen@sifive.com> wr=
ote:
> > > > >
> > > > > The `frac` variable represents the pulse inactive time, and the r=
esult of
> > > > > this algorithm is the pulse active time. Therefore, we must rever=
se the
> > > > > result.
> > > > >
> > > > > The reference is SiFive FU740-C000 Manual[0]
> > > > >
> > > > > Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d=
8-86ed8b16acba_fu740-c000-manual-v1p6.pdf [0]
> > > > >
> > > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > > > > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > > > > ---
> > > > >  drivers/pwm/pwm-sifive.c | 9 ++++++---
> > > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > > > index 393a4b97fc19..d5d5f36da297 100644
> > > > > --- a/drivers/pwm/pwm-sifive.c
> > > > > +++ b/drivers/pwm/pwm-sifive.c
> > > > > @@ -132,13 +132,13 @@ static int pwm_sifive_apply(struct pwm_chip=
 *chip, struct pwm_device *pwm,
> > > > >  {
> > > > >         struct pwm_sifive_ddata *ddata =3D pwm_sifive_chip_to_dda=
ta(chip);
> > > > >         struct pwm_state cur_state;
> > > > > -       unsigned int duty_cycle;
> > > > > +       unsigned int duty_cycle, period;
> > > > >         unsigned long long num;
> > > > >         bool enabled;
> > > > >         int ret =3D 0;
> > > > >         u32 frac;
> > > > >
> > > > > -       if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > > > > +       if (state->polarity !=3D PWM_POLARITY_NORMAL && state->po=
larity !=3D PWM_POLARITY_INVERSED)
> > > > >                 return -EINVAL;
> > > > >
> > > > >         cur_state =3D pwm->state;
> > > > > @@ -154,10 +154,13 @@ static int pwm_sifive_apply(struct pwm_chip=
 *chip, struct pwm_device *pwm,
> > > > >          * calculating the register values first and then writing=
 them
> > > > >          * consecutively
> > > > >          */
> > > > > +       period =3D max(state->period, ddata->approx_period);
> > > >
> > > > Hi Nylon,
> > > >
> > > > I don't understand this patch. You introduce this new variable,
> > > > period, and set it here but you never seem to use it. If you planne=
d
> > > > to use it instead of state->period below, why should it be the max =
of
> > > > the old period and what is requested? What happens if the consumer
> > > > wants to lower the period?
> > > Sorry this was an oversight on my part, there was a line correction t=
hat didn't change to
> > > - frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> > > + frac =3D DIV64_U64_ROUND_CLOSEST(num, period);
> >
> > I see, so then my second question was why period needs to be the
> > larger of the previous period and the requested period.
> >
> > What happens if the requested period, state->period, is lower than the
> > old period, ddata->approx_period? Then the period will be changed to
> > state->period below, but the calculations will be made using period =3D
> > ddata->approx_period, right?
>
> Your understanding is correct. According to the new algorithm proposed
> by Uwe, the goal is to:
> Pick the biggest period length possible that is not bigger than the
> requested period.

Right, and to be clear: this patch doesn't do that.

If the previous period in ddata->approx_period is bigger than the
requested period in state->period, it will do the frac calculations
with the old period, but still set the period to the shorter requested
period.

> > > >
> > > > Also above you now allow both PWM_POLARITY_NORMAL and
> > > > PWM_POLARITY_INVERSED but you treat both cases the same.
> > > I may have misunderstood what Uwe means here, I will confirm again he=
re
> > > >
> > > > /Emil
> > > >
> > > > >         num =3D (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
> > > > >         frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> > > > > -       /* The hardware cannot generate a 100% duty cycle */
> > > > >         frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > > > > +       /* The hardware cannot generate a 100% duty cycle */
> > > > > +       frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
> > > > > +
> > > > >
> > > > >         mutex_lock(&ddata->lock);
> > > > >         if (state->period !=3D ddata->approx_period) {
> > > > > --
> > > > > 2.40.0
> > > > >
