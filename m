Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1722671136
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjARCcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjARCcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:32:39 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0185A4FAF5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:32:38 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-4d0f843c417so336161297b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhVRdi04ykAfBKvh2XosikgPFb7sAZbc1JGthKJqlS4=;
        b=Xsfz/HHBDO/vDBykab7FsTxQ82hjIhSdfx0E/zL+3YXYxMdPCwksOi8E1/nqlOb7v4
         Y/y+0A4dmitkt2zcYOuAEuIwjfYP8CbQYLo7znzidRpFEUpMm9nc1FTkj7YN0GBfizPH
         1AZ35hc9Abk2cT75pqRwbuBN50r7mYOrOgv51wT91c4vqJyxqnfOP8NjTroHhwjHt0bT
         QAwFtUqOtRPOv4sTrZE4IZlZ0GRLGCRQkuG8+HkitDgNLIC7O9kk4MWtFqGIyn5Kv3NO
         2i17tWm5g4dJh3IxoksPy8Uw7xjpkAzAoO/32zkSPqKV0556sLX4hP3P9O+C4mw6VLXV
         B7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhVRdi04ykAfBKvh2XosikgPFb7sAZbc1JGthKJqlS4=;
        b=aSKl1/4L6AacQlUM/c6GRg25iRnHCDGGjQHazRagEvX0g1M2tzLwfNgz7NWPjeyaww
         j+MrIzrJBaJg6g4kTiMONIL5Kh1n4WpkTW9Dkrb/BBgkHm9y0qtAqMv/EBPit3gmego0
         h/JLAhCD4+wrq8Kl/Bp5wETd5kK8a1mR9isGaslRulUSUkbB0akFb8NggIUleZQ9BV+G
         4I/fR1ULP6pWOuBU/6F0X+i8Dhpwo0rar1k5HOee2kzELjhbp+lIwIIg0i1wkg9VN7qE
         qVwrjj0Pix9TgFWtwE3kYuwM1Z1dfsxL1aXLHWcuBLy52NIPJnKEl5AnESTfjs/9V5jp
         CUpQ==
X-Gm-Message-State: AFqh2kqxOvn34ttc8/pRnSAD94MZHyHWcDDE6Qwv9gAcjq6C3LlFLRiS
        cFeu48R7xd4bqIurBbBWu80625NZ3XRAusKifz3UHVOJqjaUF8g0MS8=
X-Google-Smtp-Source: AMrXdXupPoFgOwerETPCheh2dd9flISZCoiKBPocpXAh78KmGug8wpLEHcBdK2SAvDjD/HXUyWDuSMhRqrjDKbftW2Q=
X-Received: by 2002:a81:5246:0:b0:3d0:c950:c581 with SMTP id
 g67-20020a815246000000b003d0c950c581mr505917ywb.304.1674009157129; Tue, 17
 Jan 2023 18:32:37 -0800 (PST)
MIME-Version: 1.0
References: <20230113083115.2590-1-nylon.chen@sifive.com> <Y8GjySjm9OjoZvCF@spud>
 <95F1EAA0-D8D6-4F8A-8049-5E7BFDE4C06C@jrtc27.com> <Y8K1a+xs6tbo7kV4@spud>
In-Reply-To: <Y8K1a+xs6tbo7kV4@spud>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Wed, 18 Jan 2023 10:32:25 +0800
Message-ID: <CAHh=Yk9jUFiwzw+RQDoyb7xDoHGXFzNprdXn8szmMZb5FB4jLw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Change PWM-controlled LED pin active mode and algorithm
To:     Conor Dooley <conor@kernel.org>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
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

Conor Dooley <conor@kernel.org> =E6=96=BC 2023=E5=B9=B41=E6=9C=8814=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8810:00=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Jess!
>
> On Fri, Jan 13, 2023 at 07:24:56PM +0000, Jessica Clarke wrote:
> > On 13 Jan 2023, at 18:32, Conor Dooley <conor@kernel.org> wrote:
> > >
>
> > > Please run scripts/get_maintainer.pl before sending patches, you miss=
ed
> > > both me & the PWM maintainers unfortunately!
> > > AFAIK, the PWM maintainers use patchwork, so you will probably have t=
o
> > > resend this patchset so that it is on their radar.
> > > I've marked the series as "Changes Requested" on the RISC-V one.
> > >
> > > On Fri, Jan 13, 2023 at 04:31:13PM +0800, Nylon Chen wrote:
> > >
> > >> According to the circuit diagram of User LEDs - RGB described in the
> > >> manual hifive-unmatched-schematics-v3.pdf[0].
> > >> The behavior of PWM is acitve-high.
> > >>
> > >> According to the descriptionof PWM for pwmcmp in SiFive FU740-C000
> > >> Manual[1].
> > >> The pwm algorithm is (PW) pulse active time  =3D (D) duty * (T) peri=
od[2].
> > >> The `frac` variable is pulse "inactive" time so we need to invert it=
.
> > >>
> > >> So this patchset removes active-low in DTS and adds reverse logic to
> > >> the driver.
> > >>
> > >> [0]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Un=
matched/hifive-unmatched-schematics-v3.pdf
> > >> [1]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Un=
matched/fu740-c000-manual-v1p2.pdf
> > >> [2]:https://en.wikipedia.org/wiki/Duty_cycle
> > >
> > > Please delete link 2, convert the other two to standard Link: tags an=
d
> > > put this information in the dts patch. Possibly into the PWM patch to=
o,
> > > depending on what the PWM maintainers think.
> > > This info should be in the commit history IMO and the commit message =
for
> > > the dts patch says what's obvious from the diff without any explanati=
on
> > > as to why.
> > >
> > > I did a bit of looking around on lore, to see if I could figure out
> > > why it was done like this in the first place, and I found:
> > > https://lore.kernel.org/linux-pwm/CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG97e=
SX70=3DUaSbGCMMF_g@mail.gmail.com/
> >
> > That DTS documentation makes no sense to me, why does what the LED is
> > wired to matter?
>
> ```
>       active-low:
>         description:
>           For PWMs where the LED is wired to supply rather than ground.
> ```
>
> > Whether you have your transistor next to ground or
> > next to Vdd doesn=E2=80=99t matter, what matters is whether the transis=
tor is
> > on or off. Maybe what they mean is whether the *PWM's output* / *the
> > transistor's input* is pulled to ground or Vdd? In which case the
> > property would indeed not apply here.
> >
> > Unless that=E2=80=99s written assuming the LED is wired directly to the=
 PWM, in
> > which case it would make sense, but that=E2=80=99s a very narrow-minded=
 view of
> > what the PWM output is (directly) driving.
>
> I would suspect that it was written with that assumption.
> Probably was the case on the specific board this property was originally
> added for.
>
Hi Conor

As you can see, there is also the same description in U-Boot.

But in U-Boot, the DTS of Unmatched/Unleashed has not been added active-low=
.

This is because active-high should be correct if we look at the circuit dia=
gram.
> Maybe it'd be a bit more foolproof written as "For LEDs that are
> illuminated while the PWM output is low. For example, where an LED is
> wired between supply and the PWM output."?
>
