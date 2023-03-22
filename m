Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DA16C4575
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCVI5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVI51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:57:27 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ADC37550;
        Wed, 22 Mar 2023 01:57:26 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v17so3319015oic.5;
        Wed, 22 Mar 2023 01:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679475446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9R65xRwnP78FkfCIDRDlxuQWuoh+B5jkgUQeHyiYKs4=;
        b=BzX2g/d/PwKi0WrbKxuspgEu6//KEqZez/h3Z4SUTXP7/jvKJFkby9B9GQO+KTUHsE
         W65sf9Gy/trXdSt90so1/GOmmoLLZARD4IsKZCkDk2etHFHpArvzQbnFQtnMyl0zJb+d
         8lMVmbmtH+esaMTP8fetOFOeRstHo8oBCemwCVBxkjMb7N/FqY8AzMSoUsWPeYbGu1lO
         0PUtqEt3FEOi1IGQQFlnkuPbUYhbVn73y+u/oa8h8rdfPHogNrQPuGYx1I3ZOuGrKFP2
         8SwuONbBbMSOwB+4qUVYYbU74/bATOlJOTBQ6EXFImNPzwm30PIfpebSvJmL75TiHoKq
         V8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679475446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9R65xRwnP78FkfCIDRDlxuQWuoh+B5jkgUQeHyiYKs4=;
        b=Zl1IL6AuV4YSn4BmDtU3YMsW3ouVdRK+LMgLttaI/Q/ZpP6E7AKd8gd0KaQ14frAAM
         9HZFV/VYAPrxRYIAEqQRQAFOA9c0m5KiJ+M1BSO0g0VGpshULpiCoUNkSaFLK1OJya0m
         YDEuKX7mH31AvN5YiNjxvaykw4JnWE/GlWqZUOw/I+5oUD83dhWrr7LR2CNyhR8zdSE8
         qsy8u/f6betY/IaovizQxB5ryUH2+h+lXCpSfozl/smU3jATUpmemi+3cFZ4dOmJh22T
         CkYTCl9/FRPvefj3wBYLQShB8IacsGlCvegung46yLBlw/+mdm4bX3b2A7iqKq7GmWGY
         ghEA==
X-Gm-Message-State: AO0yUKXuHz7Fcm05b6H24RxQOrBgpK9y7mDPRIAxHc/bagHWm+0ON8JC
        tun7qnUHcTgao8oKZvM9yZEctH05eUmUcail4XU=
X-Google-Smtp-Source: AK7set+0gKpKBhnJuNAs/qFQdwquhXaQRSm9yoz9xDZO2H2W0KpJg3sc6xxviuNxkxak1UH7Y50S1EOegHBtt+qnVtg=
X-Received: by 2002:aca:190a:0:b0:383:c459:1bc with SMTP id
 l10-20020aca190a000000b00383c45901bcmr778745oii.0.1679475445949; Wed, 22 Mar
 2023 01:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
 <20230321050034.1431379-2-sergio.paracuellos@gmail.com> <5f295438-8334-d374-2ae6-2a385ffb317d@linaro.org>
 <CAMhs-H_dSgcPNQVusHWVvztYHptOxSJ_o7G0eU9=M1C7RXdsVw@mail.gmail.com>
 <ce13ca6c-e61a-d31e-2626-d818a5d0e15e@arinc9.com> <20230321221837.GA1751474-robh@kernel.org>
 <5f9e9d79-a744-99cf-6a53-bd7342252b46@arinc9.com>
In-Reply-To: <5f9e9d79-a744-99cf-6a53-bd7342252b46@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 22 Mar 2023 09:57:13 +0100
Message-ID: <CAMhs-H_r0F=ewQqakzyo=XaUwCOXZACdWTuXZSXpueDy6xp=7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: clock: add mtmips SoCs system controller
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 9:36=E2=80=AFAM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.un=
al@arinc9.com> wrote:
>
> On 22.03.2023 01:18, Rob Herring wrote:
> > On Tue, Mar 21, 2023 at 10:09:59AM +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wro=
te:
> >> On 21.03.2023 10:00, Sergio Paracuellos wrote:
> >>> On Tue, Mar 21, 2023 at 7:45=E2=80=AFAM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 21/03/2023 06:00, Sergio Paracuellos wrote:
> >>>>> Adds device tree binding documentation for system controller node p=
resent
> >>>>> in Mediatek MIPS and Ralink SOCs. This node is a clock and reset pr=
ovider
> >>>>> for the rest of the world. This covers RT2880, RT3050, RT3052, RT33=
50,
> >>>>> RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.
> >>>>>
> >>>>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >>>>> ---
> >>>>>    .../bindings/clock/mediatek,mtmips-sysc.yaml  | 65 +++++++++++++=
++++++
> >>>>>    1 file changed, 65 insertions(+)
> >>>>>    create mode 100644 Documentation/devicetree/bindings/clock/media=
tek,mtmips-sysc.yaml
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mtmip=
s-sysc.yaml b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.=
yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..f07e1652723b
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.=
yaml
> >>>>> @@ -0,0 +1,65 @@
> >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: http://devicetree.org/schemas/clock/mediatek,mtmips-sysc.yaml=
#
> >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>> +
> >>>>> +title: MTMIPS SoCs System Controller
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >>>>> +
> >>>>> +description: |
> >>>>> +  MediaTek MIPS and Ralink SoCs provides a system controller to al=
low
> >>>>> +  to access to system control registers. These registers include c=
lock
> >>>>> +  and reset related ones so this node is both clock and reset prov=
ider
> >>>>> +  for the rest of the world.
> >>>>> +
> >>>>> +  These SoCs have an XTAL from where the cpu clock is
> >>>>> +  provided as well as derived clocks for the bus and the periphera=
ls.
> >>>>> +
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    items:
> >>>>> +      - enum:
> >>>>> +          - ralink,mt7620-sysc
> >>>>
> >>>> Since you decided to send it before we finish discussion:
> >>>> NAK - this is already used as mediatek
> >>>
> >>> Sorry, there was too much stuff commented so I preferred to clean up
> >>> all of them while maintaining the compatibles with the ralink prefix
> >>> instead since that was where the current discussion was at that point=
.
> >>>
> >>>>
> >>>>> +          - ralink,mt7620a-sysc
> >>>
> >>> As I have said, this one exists:
> >>>
> >>> arch/mips/ralink/mt7620.c:      rt_sysc_membase =3D
> >>> plat_of_remap_node("ralink,mt7620a-sysc");
> >>>
> >>>
> >>>>> +          - ralink,mt7628-sysc
> >>>>
> >>>> Same here.
> >>>>
> >>>>> +          - ralink,mt7688-sysc
> >>>>
> >>>> I expect you to check the others.
> >>>
> >>> I can change others to mediatek but that would be a bit weird, don't =
you think?
> >>
> >> I've seen some parts of the MTMIPS platform use mediatek compatible st=
rings
> >> thanks to Krzysztof pointing them out. I don't like having some parts =
of the
> >> MTMIPS platform (pci, mmc, usbphy, etc.) with mediatek compatible stri=
ng
> >> while others are ralink.
> >
> > That's unfortunate, but again, compatibles are just unique identifiers.
> > They are only wrong if they aren't unique...
>
> Understood. Sergio, please keep the new strings here ralink.

So if I have to maintain this as "ralink" I think this patch is ok as
it is now? If that is the case, I prefer to get Reviewed-by for this
patch as it is now by Krzysztof or Rob before changing anything in my
current code.

>
> >
> >> Like Krzysztof said [0], Ralink is now Mediatek, thus there is no conf=
lict
> >> and no issues with different vendor used. So I'd rather keep new thing=
s
> >> Ralink and gradually change these mediatek strings to ralink.
> >
> > So break the ABI multiple times slowly. Again, either you live with
> > *all* the existing compatible strings or you declare it is fine to brea=
k
> > the ABI on these platforms and switch everything at once. Carrying both
> > strings (in bindings or drivers) and breaking the ABI is lose-lose.
>
> If removing the mediatek strings from the drivers and bindings is better
> than keeping both strings on the drivers except the bindings, which
> would keep the ABI intact, I'll do the prior and do it all at once.
>
> Ar=C4=B1n=C3=A7

Thanks,
    Sergio Paracuellos
