Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537436E5FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjDRL2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDRL2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:28:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B0744A5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:28:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sz19so15201437ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681817322; x=1684409322;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w6NsCT8fL5/XZ/Xo/dI3ZN+KFkFYbBSVPM1DADRkB6k=;
        b=hWZKDuBJZSv4zyFL+9V7yyCgcnKPC6PUqrZ8oezozIjbmztNCbh+KehMw018al4FAk
         R9n1bEqVOzv0uuEF8xf3H2ls5S3a1974ytijqjAMEb9uTqlf6yCjCsWUAK8I0oY/KiUP
         /QrRHJtuuIwOn4mhENUf/lO+kB5g0nvCmJXkCs2NArRRPK+OkPROmeRLN4f75h9jgiGJ
         YjagMR0yWtqd5XA8SZsBGmmjWoCYkfo/Src1j8Tnzn6Ah8bmszNRGU8Gm1+Vc2Go1DOX
         w3EGNvLnKIPLtcXMqAqAVamXnF8V+PNiCvqVcnaEfBSm/N0iAey4Q7WszhO5nUokncQ5
         pOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681817322; x=1684409322;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6NsCT8fL5/XZ/Xo/dI3ZN+KFkFYbBSVPM1DADRkB6k=;
        b=MGNIjXqh9EJJKQLVbR4IK3pXaAL+azJul8tIDbh6+PBSIWMCbEK2512zqYtnF6oZJ2
         qz2nDEsBYS7IAiGdpnNbqQKv1XIofrsrWHG65yoyAXPIG0dcWBjYf7QAZqCnc2n1N7wy
         cTkSuwYSgcuRs0dnpfiKGUJYFJ/XLUu8h4fK0x5m0navM0BMo+oeq84mR4W5CyXCRlLz
         FUFDjl+bRoSF0PQ4gSMttbVLM4Obh99WENogk9/YJnErQIR6xWkXfJQoDhvD+Yp0uZ2m
         AUjXzXUWHlU2a7sfn5HZcszEo/st0Hf7o7i/RmDFFkp+XUvRK6dxDuoHv9OPmZQYD9hO
         KR3w==
X-Gm-Message-State: AAQBX9f84TzSqUhcbhM6jQHrPDOTD0SGV9dpIP3byFM5ejPfkChu5Pr+
        TiZhpfXx0x2FytffzLbfsYw=
X-Google-Smtp-Source: AKy350bE1rHKT1cGnDuHOknHOr7IOAThbHneyw2Ou0U5/belGPT7MM5G5zPycvSFFORiKwT3o42KmQ==
X-Received: by 2002:a17:907:8c8b:b0:878:7c18:8fd9 with SMTP id td11-20020a1709078c8b00b008787c188fd9mr10140419ejc.44.1681817321640;
        Tue, 18 Apr 2023 04:28:41 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id w3-20020a170906b18300b0094b5ce9d43dsm7927208ejy.85.2023.04.18.04.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 04:28:41 -0700 (PDT)
Message-ID: <5bf0020f7d8ca5622f0fb43cd1f821a8498eca71.camel@gmail.com>
Subject: Re: iio: ad7192: Pending IRQ on SDO/RDY causing retrigger of
 interrupt handler and missing every sample
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Date:   Tue, 18 Apr 2023 13:30:50 +0200
In-Reply-To: <CAPJMGm6qcPG1DpuAunz8vGz_LHfpMZmr=i06qcXJRJuAyc84GQ@mail.gmail.com>
References: <CAPJMGm4GaSjD6bdqMwCr2EVZGenWzT-nCCf3BMRaD1TSfAabpA@mail.gmail.com>
         <6d58a58cd7e8a7cbb91b2658e9a85b44b34b64dc.camel@gmail.com>
         <CAPJMGm5WxnmtyW2DnZe4rSUFJ-KtKGmNsf7pStcaK=4suBHWuw@mail.gmail.com>
         <3c5f31cf533ef26ea586e2d18b31995541a95411.camel@gmail.com>
         <f57b8e3d-4382-015e-743b-8663c55d9f84@metafoo.de>
         <CAPJMGm6qcPG1DpuAunz8vGz_LHfpMZmr=i06qcXJRJuAyc84GQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-04-07 at 10:51 +0200, Fabrizio Lamarque wrote:
> On Wed, Apr 5, 2023 at 4:35=E2=80=AFPM Lars-Peter Clausen <lars@metafoo.d=
e> wrote:
> >=20
> > On 4/5/23 06:49, Nuno S=C3=A1 wrote:
> > > [...]
> > > I just tested the patch, but, at least on the platform I'm working on
> > > (I.MX6), it does not
> > > solve the issue.
> > > Whereas the thread describes the very same issue I am experiencing, I
> > > am not sure
> > > IRQ_DISABLE_UNLAZY would have any impact. By reading CPU registers I =
see
> > > I was expecting to have. AFAIU, the lazy approach would be the respon=
sible
> > > for
> > > this behavior because when you call disable_irq() it does not really =
mask
> > > the
> > > IRQ in HW. Just marks it as disabled and if another IRQ event comes s=
et's
> > > it to
> > > PENDING and only then masks at HW level... If we "unlazy" the IRQ, we
> > > should
> > > mask the IRQ right away so I would expect not to have any pending IRQ=
...
> > >=20
> > > > the IRQ line disabled at the hardware level, but when the IRQ flag =
of
> > > > the processor
> > > > is set (and this happens even if the interrupt is masked in HW), th=
e
> > > > interrupt is immediately
> > > > triggered anyway.
> > > > (I see GPIOx_IMR cleared, so interrupt is masked, but GPIOx_ISR set=
. As
> > > > soon
> > > > as
> > > > enable_irq() is called the interrupt is triggered. Just by clearing
> > > > GPIOx_ISR before
> > > > enable_irq() solves the issue. I might share a few debug printk).
> >=20
> > This sounds to me that the GPIO driver should implement an
> > `irq_enable()` callback where it clears the pending bits before
> > unmasking. This is consistent with what other GPIO IRQ drivers do.
> >=20
>=20
> Hello Lars,
> =C2=A0thank you for your comments and for having a look at this.
>=20
> I am not really confident in dissecting how ARM interrupt management
> and NXP specific features. However, he "Delayed Interrupt" feature in
> kernel documentation (specific to ARM interrupt implementation),
> "prevents losing edge interrupts on hardware which does not store an
> edge interrupt event while the interrupt is disabled at the hardware
> level". This feature is always enabled for any ARM core.
> Indeed, NXP hardware _stores_ the GPIO edge interrupt when the IRQ is
> disabled. While not explicitly written in kernel docs, to my limited
> understanding enable_irq() should not clear the pending edge IRQ
> (eventually occurred when interrupt was disabled).
> I do not see anything that clearly does not conform to documentation
> in how IRQs are being managed.
>=20

So I'm still not convinced that's the right behavior. If we set
IRQ_DISABLE_UNLAZY, then I would expect that line to be masked/disabled as
soon as disable_irq() is called. Then, I would expect that no IRQ is saved
for a disabled/masked line or we should (I guess) at least be capable of
distinguish between "we want to get interrupts while processing one" or
"we really want to disable the line".

Anyways, I'm not really sure about this and it would be interesting to give
this a try in another platform.

> > the driver was written with the assumption that
> > irq_disable() will stop recording of IRQ events. If that does not hold
> > we might have to switch from irq_enable/irq_disable to
> > request_irq/free_irq, which will come with a slight overhead.
>=20
> request_irq/free_irq should clear the interrupt flags.
> However, since this change might have side effects on other ADI ADC
> drivers and trigger functionality, I'd be unable to provide a valid
> and verified patch (but I could test a proposed patch on my platform).
>=20
>=20

I would prefer the bindings approach. AFAIR, we should not really impose an=
y
flags (possibly overwriting what was described in dts) when requesting the
IRQ. Hence, dropping 'irq_flags' would actually make sense.=C2=A0

But this brings the question if anyone was relying on it and not properly
setting the flags in devicetree.


- Nuno S=C3=A1
