Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E495BFC05
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiIUKIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiIUKIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:08:32 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A11585FB6;
        Wed, 21 Sep 2022 03:08:26 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id z9so4037777qvn.9;
        Wed, 21 Sep 2022 03:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Q42qokBJHSJ02Yiksv4KQyCcXIUfc5O74ntw/Bpmgc0=;
        b=fhNGXeg3wDJnHhMmI8wNf1Tij6Pg5moL5mGDF3Iy4OBnFN8vaju6hczdziOevSJZLS
         VDOQ2IbITpgiQX8X24VsLhB3ZOk0QWcJP4iB0bOLNk06NOzrKaqbddodruLfQAfm2GXn
         z6aPg6H4VC4yHlgE+Sj/mQRdKDm4UEyd3+uR8fQ1wQUOhb8CH2OHHOqX0/+YOBe2FBXE
         hAXC7ZTIQBagA5KI+xADfGsJwHIku7v1acfiyed8XCIxtA2SRWLIKgVyI+O/pHTL13ge
         kMQH26Vehf6HV6/iWKEG5uxdx+GbRGU554f1A6dRIU6FFUHIYshrPoRvKWl6+0hC+e26
         edjg==
X-Gm-Message-State: ACrzQf0dyxA7q4VaF8YhVt1YHI5cM7kZprhzCaBExsC0sf0VRfWHirlj
        80e4BGpdS4Y+AZMXwJXTwR8Mj2oyHsVyarVm
X-Google-Smtp-Source: AMsMyM5zUfaboCdscy/A0la4qv/yz1+y8wOa95gNR2yHdwGqkMLVEsV6mWcmLu4lbmzsC/qZgcEonA==
X-Received: by 2002:a0c:e0d3:0:b0:4aa:9d28:6603 with SMTP id x19-20020a0ce0d3000000b004aa9d286603mr22469277qvk.91.1663754905200;
        Wed, 21 Sep 2022 03:08:25 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id d20-20020ae9ef14000000b006ce5fe31c2dsm1540455qkg.65.2022.09.21.03.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 03:08:23 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id g5so7278586ybg.11;
        Wed, 21 Sep 2022 03:08:22 -0700 (PDT)
X-Received: by 2002:a5b:104:0:b0:6b0:429:3fe9 with SMTP id 4-20020a5b0104000000b006b004293fe9mr23028012ybx.543.1663754902653;
 Wed, 21 Sep 2022 03:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
 <b0f2e13a-ff5d-5bfc-6dda-ca39bb57803e@linaro.org> <CA+V-a8t3ukpa1PNz=5fP+BTjWkFJmwDo_EJJYjO9YctF2=K1Vg@mail.gmail.com>
 <df9ff0bd-ad0e-4b5b-859d-dd913628edc8@linaro.org>
In-Reply-To: <df9ff0bd-ad0e-4b5b-859d-dd913628edc8@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Sep 2022 12:08:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXaWz4zP-Zrc4drxwVmbMjmGZHABVbUtO91fZXKawathw@mail.gmail.com>
Message-ID: <CAMuHMdXaWz4zP-Zrc4drxwVmbMjmGZHABVbUtO91fZXKawathw@mail.gmail.com>
Subject: Re: Similar SoCs with different CPUs and interrupt bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Sep 21, 2022 at 11:26 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 21/09/2022 11:20, Lad, Prabhakar wrote:
> >> What do you mean? Macros support string concatenation and simple
> >> arithmetic like adding numbers. I just tested it.
> >>
> > I did try the below:
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > index 689aa4ba416b..0f923c276cd3 100644
> > --- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > @@ -8,6 +8,8 @@
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/clock/r9a07g043-cpg.h>
> >
> > +#define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI nr na
> > +
> >  / {
> >      compatible = "renesas,r9a07g043";
> >      #address-cells = <2>;
> > @@ -128,7 +130,7 @@ ssi1: ssi@1004a000 {
> >              compatible = "renesas,r9a07g043-ssi",
> >                       "renesas,rz-ssi";
> >              reg = <0 0x1004a000 0 0x400>;
> > -            interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> > +            interrupts = <SOC_PERIPHERAL_IRQ(330, IRQ_TYPE_LEVEL_HIGH)>,
> >                       <GIC_SPI 331 IRQ_TYPE_EDGE_RISING>,
> >                       <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>,
> >                       <GIC_SPI 333 IRQ_TYPE_EDGE_RISING>;
> >
> > This worked as expected, but couldn't get the arithmetic operation
> > working. Could you please provide an example?
>
> diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> index ff6aab388eb7..0ecca775fa3f 100644
> --- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> @@ -8,6 +8,8 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/r9a07g043-cpg.h>
>
> +#define SOC_PERIPHERAL_IRQ_NUMBER(na)  (na + 32)
> +#define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI nr SOC_PERIPHERAL_IRQ_NUMBER(na)

#define SOC_PERIPHERAL_IRQ(nr, flags) GIC_SPI
SOC_PERIPHERAL_IRQ_NUMBER(nr) flags

>  / {
>         compatible = "renesas,r9a07g043";
>         #address-cells = <2>;
> @@ -128,7 +130,7 @@ ssi1: ssi@1004a000 {
>                         compatible = "renesas,r9a07g043-ssi",
>                                      "renesas,rz-ssi";
>                         reg = <0 0x1004a000 0 0x400>;
> -                       interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +                       interrupts = <SOC_PERIPHERAL_IRQ(330, IRQ_TYPE_LEVEL_HIGH)>,
>
>
>
> Or any other method like that....

Oh cool, seems like arithmetic is supported.
No idea what I did wrong last time I tried...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
