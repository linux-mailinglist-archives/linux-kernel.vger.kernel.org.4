Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D601066DA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbjAQJed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbjAQJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:33:25 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A81583C8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:32:53 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4a263c4ddbaso415022677b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FV9nUVm/3W8S9XiP51zEd4Rl44Fcj8LLaPZ2bVwALNE=;
        b=T7CgfJmnRp3JHN/VR2DJA2oyuzskW7ry7gryfRwHM6Kf/pwwm4aN3D/1fVDcakoMpK
         ZM61iW6f819f4/PK4wzG2DggDR51HP0ebzGUQ4vTirnJQe7A2oMZhVSG5XYet+V/h2LV
         WfhT4acFhTh8nE+ZDd6B3RVb+BayfTGynKysQbQ/dLmqKZeB5vCy4QAd0szmUVCHRXpE
         lsqFG/uqBqpzlOC9c6NeFSMCE71igtRKQD07+EUg9QTIZxXffJDoueOFknwpwkHtMw2+
         E/UA9+4VZOl6daYFtUfDujEIosnxyBf8L3Ju+UTGh70rLPoMkV1yaatcF46Fy8KRdZNP
         3X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV9nUVm/3W8S9XiP51zEd4Rl44Fcj8LLaPZ2bVwALNE=;
        b=YbUDKbYspa27GdNjmrT6fGVxpFAvWSi2x+r0o5dOgQdVhBj5IoIWcuPQo6TX4/WCCx
         IHWbLEhq3b6tzS2BDY+JJdm4GLCcTjEYpSuW3UGoFMMaxvzIB0FVxNbcUJ3k/3wcfkKs
         GzM51tsY3s3hxmxC5QRK2N1D+RJrc+cVNKjAh7Qpjbibwa3999pupOPFitLY9vczZHDD
         02uCn7FlOibomMe00zGpqcfWSSS+oDRhiqGd9GklUwDz/tu9+jGPTL7zfBHVhqwQ66NP
         bOA3/V7jIJQ7ztsgN6z5aBD+CKkvymVhiREo+7rEmpBps3LOPvv+5Kr3FhinpbTNxpTp
         EoQw==
X-Gm-Message-State: AFqh2kpDEI8SaTcE2AWgV/4iF2Llga3SwSWBwzslVqYh0RWdKAeYjYpC
        S7TvIjtM1xlHwkS9xQJ5Hez7z5TEOHkfZ+JMwZOrrw==
X-Google-Smtp-Source: AMrXdXvST+rBmxbQ9ZJsNpKFtnIQx3FB5ioNsIlBUX/oGsXIVVOg1Z8MnqkrQal43ozZal2Js56bI5hKZ38ZxjmSwyw=
X-Received: by 2002:a81:9b95:0:b0:3ea:9ce2:cd76 with SMTP id
 s143-20020a819b95000000b003ea9ce2cd76mr342335ywg.217.1673947972381; Tue, 17
 Jan 2023 01:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20230113083115.2590-1-nylon.chen@sifive.com> <Y8GjySjm9OjoZvCF@spud>
 <95F1EAA0-D8D6-4F8A-8049-5E7BFDE4C06C@jrtc27.com>
In-Reply-To: <95F1EAA0-D8D6-4F8A-8049-5E7BFDE4C06C@jrtc27.com>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Tue, 17 Jan 2023 17:32:40 +0800
Message-ID: <CAHh=Yk-WJMOc-h9V47CyMQpyXZ5hDrtOPnPE2QKkJKzMhjh+Cg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Change PWM-controlled LED pin active mode and algorithm
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Conor Dooley <conor@kernel.org>,
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

Hi Conor, Jessica

thanks for your reply.

Jessica Clarke <jrtc27@jrtc27.com> =E6=96=BC 2023=E5=B9=B41=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=883:24=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 13 Jan 2023, at 18:32, Conor Dooley <conor@kernel.org> wrote:
> >
> > +CC Uwe, Thierry, linux-pwm
> >
> > Hey Nylon,
> >
> > Please run scripts/get_maintainer.pl before sending patches, you missed
> > both me & the PWM maintainers unfortunately!
> > AFAIK, the PWM maintainers use patchwork, so you will probably have to
> > resend this patchset so that it is on their radar.
> > I've marked the series as "Changes Requested" on the RISC-V one.
I got it. I will base it on get_maintainer.pl, re-sent it.
> >
> > On Fri, Jan 13, 2023 at 04:31:13PM +0800, Nylon Chen wrote:
> >
> >> According to the circuit diagram of User LEDs - RGB described in the
> >> manual hifive-unmatched-schematics-v3.pdf[0].
> >> The behavior of PWM is acitve-high.
> >>
> >> According to the descriptionof PWM for pwmcmp in SiFive FU740-C000
> >> Manual[1].
> >> The pwm algorithm is (PW) pulse active time  =3D (D) duty * (T) period=
[2].
> >> The `frac` variable is pulse "inactive" time so we need to invert it.
> >>
> >> So this patchset removes active-low in DTS and adds reverse logic to
> >> the driver.
> >>
> >> [0]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Unma=
tched/hifive-unmatched-schematics-v3.pdf
> >> [1]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Unma=
tched/fu740-c000-manual-v1p2.pdf
> >> [2]:https://en.wikipedia.org/wiki/Duty_cycle
> >
> > Please delete link 2, convert the other two to standard Link: tags and
> > put this information in the dts patch. Possibly into the PWM patch too,
> > depending on what the PWM maintainers think.
I got it. I will fix it.
> > This info should be in the commit history IMO and the commit message fo=
r
> > the dts patch says what's obvious from the diff without any explanation
> > as to why.
> >
> > I did a bit of looking around on lore, to see if I could figure out
> > why it was done like this in the first place, and I found:
> > https://lore.kernel.org/linux-pwm/CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG97eSX=
70=3DUaSbGCMMF_g@mail.gmail.com/
>
> That DTS documentation makes no sense to me, why does what the LED is
> wired to matter? Whether you have your transistor next to ground or
> next to Vdd doesn=E2=80=99t matter, what matters is whether the transisto=
r is
> on or off. Maybe what they mean is whether the *PWM's output* / *the
> transistor's input* is pulled to ground or Vdd? In which case the
> property would indeed not apply here.
>
> Unless that=E2=80=99s written assuming the LED is wired directly to the P=
WM, in
> which case it would make sense, but that=E2=80=99s a very narrow-minded v=
iew of
> what the PWM output is (directly) driving.
>
> Jess
>
This is a HiFive Unmatched/Unleashed LED-PWM layout

            VDD
               |
               |
           _____
           \        /   LED
            \     /
              ---
               |
               |
               |
         ______
        |              |
        -             |
        ^    -->    |------ PWM
        |___|___|
               |
               |
              __
               -
            GND

- the waveform
e.g. duty=3D30s, period=3D100s, actvie-high =3D 30%, active-low =3D 70%

V
^
|
| ----------|
|             |
|             |
|______ |__________ > t

When VCC is high, the LED will be illuminated, which is an active-high
logic. This is why we need to remove "active-low".

So, according to my understanding, Unleashed's DTS should also remove
active-low.
> > That doesn't explain the driver, but it does explain the dts being that
> > way. Perhaps a Fixes tag is also in order? But only if both patches get
> > one, otherwise backporting would lead to breakage.
> >
> > The min() construct appears to have been there since the RFC driver was
> > first posted.
> >
> > Thanks,
> > Conor.
> >
> >>
> >> Nylon Chen (2):
> >>  riscv: dts: sifive unmatched: Remove PWM controlled LED's active-low
> >
> > nit: s/sifive unmatched:/sifive: unmatched:/
I got it. I will fix it.

> >
> >>    properties
> >>  pwm: sifive: change the PWM controlled LED algorithm
> >>
> >> arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ----
> >> drivers/pwm/pwm-sifive.c                            | 1 +
> >> 2 files changed, 1 insertion(+), 4 deletions(-)
> >>
> >> --
> >> 2.36.1
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
