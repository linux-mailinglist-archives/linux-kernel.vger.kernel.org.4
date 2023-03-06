Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFC66AC28D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCFOKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjCFOJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:09:22 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417B665B4;
        Mon,  6 Mar 2023 06:07:57 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso5374791ota.1;
        Mon, 06 Mar 2023 06:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678111664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtOpygRybRdTgryIFngZaRO49/uV1PlMUt6BGCDduIA=;
        b=GwOipbKq7AzZLovFhdCldB570JfDMW5z8v/OcUY/hVyl4bcuwX/4Y7hPIgAmjLNfQJ
         nBEF2xG6Xzs5G9ZCE/6XFUJ9dwIXrigoL9D8Q5+un1AMIV3R1f44Z/AeJ+mI1zOCUkza
         fiZ6hMopIeoKBHe/1AhfPQD3Nq2wmXiMXysVAoZBC9CZcZPM9zqB/+TnLy2tQVrv4mii
         gil7J/3NfXQ+HUvnx0JLVPbv4goaDAmcrzIZS14P3JhEc8LsF02Sjnkpxb/3g1Lz/oXe
         S10DM13WigY4nmIiR5sH3hHAJn/+gf99esve4YTTE1YGDNegIlsPKSB6va8bkmGs2xJs
         3oDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtOpygRybRdTgryIFngZaRO49/uV1PlMUt6BGCDduIA=;
        b=PzrB7tRH3Inr4RLbFib5CZwZyHdMxyO6ijHhG6DYaPSyhVv1IC/88tWjnNyykPyKnq
         jSlNEOl1W2ml6iaMN0BBe3SarQc6/ZbIIDT+xuO0G4UQ8aOP9N4mjg/XGfhxEDfo5kBS
         0xiWjL21dzdHei4sTN3BzvWGM4Qy/Gf4HhZcSSyX6Wa6sRbpZLtiKfRuVAtsdHy9gIh7
         125cV0o6NvM898mVendMzAZsRoQMy6TOInJDcCkCuyLqeSALZ0LO+s8C21L9JbzxE5aj
         7hNNlGhWrJ7qtGd3nhMjsVFfhkXRrEKZLcoUbZqBLgBwjISDD+VR5IWMKD3L1TdvdkQr
         v7WA==
X-Gm-Message-State: AO0yUKXNobViv13g3PVFcYJJzuF4PSJuXHd/KjygKjpw1kRJ8ZX4DYoF
        0n/VGFdQHZ+w1bgrqsKMToV0FsFGmfGut4ffac4=
X-Google-Smtp-Source: AK7set/KCnaWsNZQY8Vo3wwDI8I9RVvXKdkU0ZmSZlhpP4gSrDFP3rxyVuwxZ5C+PG6ym4BH6FBPS3rqQKNIkZf8jSk=
X-Received: by 2002:a05:6830:2464:b0:693:d8a3:1f15 with SMTP id
 x36-20020a056830246400b00693d8a31f15mr3284470otr.6.1678111663787; Mon, 06 Mar
 2023 06:07:43 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <20230303002850.51858-6-arinc.unal@arinc9.com>
 <CAMhs-H-VGjP32AZc2cuY=Co4iqx8xPtvjr+hMg-haMMFaQzzsg@mail.gmail.com>
 <CAMhs-H8OsG-SEWigimG3fT-SGjZruH-7tnjff198Z2qhb0O=yA@mail.gmail.com>
 <2106f6d0-63cc-4656-1e52-19640994fb43@arinc9.com> <CAMhs-H869pR6CzaWfvf44w-ak+0OCyxnMEEU4kWYpw=C14ShsQ@mail.gmail.com>
 <fc6dc970-5bae-1c27-9473-8c9d90ac79a1@arinc9.com>
In-Reply-To: <fc6dc970-5bae-1c27-9473-8c9d90ac79a1@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 6 Mar 2023 15:07:31 +0100
Message-ID: <CAMhs-H_SryQqCZ3mB_VsO20ZSvKCMR5V9E7wrt+a-kbcqQxsWQ@mail.gmail.com>
Subject: Re: [PATCH 05/20] pinctrl: ralink: move to mediatek as mtmips
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 3:18 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9=
.com> wrote:
>
> Heyo,
>
> On 3.03.2023 13:57, Sergio Paracuellos wrote:
> > Hi Ar=C4=B1n=C3=A7,
> >
> > On Fri, Mar 3, 2023 at 9:16 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@ar=
inc9.com> wrote:
> >>
> >> Hey Sergio,
> >>
> >> On 3.03.2023 09:34, Sergio Paracuellos wrote:
> >>> On Fri, Mar 3, 2023 at 7:17 AM Sergio Paracuellos
> >>> <sergio.paracuellos@gmail.com> wrote:
> >>>>
> >>>>    Hi Ar=C4=B1n=C3=A7,
> >>>>
> >>>> On Fri, Mar 3, 2023 at 1:30 AM <arinc9.unal@gmail.com> wrote:
> >>>>>
> >>>>> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >>>>>
> >>>>> This platform from Ralink was acquired by MediaTek in 2011. Then, M=
ediaTek
> >>>>> introduced new SoCs which utilise this platform. Move the driver to
> >>>>> mediatek pinctrl directory. Rename the ralink core driver to mtmips=
.
> >>>>>
> >>>>> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >>>>> ---
> >>>>>    drivers/pinctrl/Kconfig                       |  1 -
> >>>>>    drivers/pinctrl/Makefile                      |  1 -
> >>>>>    drivers/pinctrl/mediatek/Kconfig              | 51 ++++++++++-
> >>>>>    drivers/pinctrl/mediatek/Makefile             | 63 +++++++------
> >>>>>    .../{ralink =3D> mediatek}/pinctrl-mt7620.c     | 34 +++----
> >>>>>    .../{ralink =3D> mediatek}/pinctrl-mt7621.c     | 30 +++----
> >>>>>    .../{ralink =3D> mediatek}/pinctrl-mt76x8.c     | 60 ++++++-----=
--
> >>>>>    .../pinctrl-mtmips.c}                         | 90 +++++++++----=
------
> >>>>>    .../pinctrl-mtmips.h}                         | 16 ++--
> >>>>>    .../{ralink =3D> mediatek}/pinctrl-rt2880.c     | 20 ++---
> >>>>>    .../{ralink =3D> mediatek}/pinctrl-rt305x.c     | 44 ++++-----
> >>>>>    .../{ralink =3D> mediatek}/pinctrl-rt3883.c     | 28 +++---
> >>>>>    drivers/pinctrl/ralink/Kconfig                | 40 ---------
> >>>>>    drivers/pinctrl/ralink/Makefile               |  9 --
> >>>>>    14 files changed, 246 insertions(+), 241 deletions(-)
> >>>>>    rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-mt7620.c (=
81%)
> >>>>>    rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-mt7621.c (=
80%)
> >>>>>    rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-mt76x8.c (=
81%)
> >>>>>    rename drivers/pinctrl/{ralink/pinctrl-ralink.c =3D> mediatek/pi=
nctrl-mtmips.c} (74%)
> >>>>>    rename drivers/pinctrl/{ralink/pinctrl-ralink.h =3D> mediatek/pi=
nctrl-mtmips.h} (75%)
> >>>>>    rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt2880.c (=
71%)
> >>>>>    rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt305x.c (=
75%)
> >>>>>    rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt3883.c (=
80%)
> >>>>>    delete mode 100644 drivers/pinctrl/ralink/Kconfig
> >>>>>    delete mode 100644 drivers/pinctrl/ralink/Makefile
> >>>>>
> >>>>> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> >>>>> index dcb53c4a9584..8a6012770640 100644
> >>>>> --- a/drivers/pinctrl/Kconfig
> >>>>> +++ b/drivers/pinctrl/Kconfig
> >>>>> @@ -537,7 +537,6 @@ source "drivers/pinctrl/nomadik/Kconfig"
> >>>>>    source "drivers/pinctrl/nuvoton/Kconfig"
> >>>>>    source "drivers/pinctrl/pxa/Kconfig"
> >>>>>    source "drivers/pinctrl/qcom/Kconfig"
> >>>>> -source "drivers/pinctrl/ralink/Kconfig"
> >>>>>    source "drivers/pinctrl/renesas/Kconfig"
> >>>>>    source "drivers/pinctrl/samsung/Kconfig"
> >>>>>    source "drivers/pinctrl/spear/Kconfig"
> >>>>> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> >>>>> index d5939840bb2a..ada6ed1d4e91 100644
> >>>>> --- a/drivers/pinctrl/Makefile
> >>>>> +++ b/drivers/pinctrl/Makefile
> >>>>> @@ -66,7 +66,6 @@ obj-y                         +=3D nomadik/
> >>>>>    obj-y                          +=3D nuvoton/
> >>>>>    obj-$(CONFIG_PINCTRL_PXA)      +=3D pxa/
> >>>>>    obj-$(CONFIG_ARCH_QCOM)                +=3D qcom/
> >>>>> -obj-$(CONFIG_PINCTRL_RALINK)   +=3D ralink/
> >>>>>    obj-$(CONFIG_PINCTRL_RENESAS)  +=3D renesas/
> >>>>>    obj-$(CONFIG_PINCTRL_SAMSUNG)  +=3D samsung/
> >>>>>    obj-$(CONFIG_PINCTRL_SPEAR)    +=3D spear/
> >>>>> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/med=
iatek/Kconfig
> >>>>> index a71874fed3d6..2eeb55010563 100644
> >>>>> --- a/drivers/pinctrl/mediatek/Kconfig
> >>>>> +++ b/drivers/pinctrl/mediatek/Kconfig
> >>>>> @@ -1,6 +1,6 @@
> >>>>>    # SPDX-License-Identifier: GPL-2.0-only
> >>>>>    menu "MediaTek pinctrl drivers"
> >>>>> -       depends on ARCH_MEDIATEK || COMPILE_TEST
> >>>>> +       depends on ARCH_MEDIATEK || RALINK || COMPILE_TEST
> >>>>>
> >>>>>    config EINT_MTK
> >>>>>           tristate "MediaTek External Interrupt Support"
> >>>>> @@ -22,6 +22,12 @@ config PINCTRL_MTK
> >>>>>    config PINCTRL_MTK_V2
> >>>>>           tristate
> >>>>>
> >>>>> +config PINCTRL_MTK_MTMIPS
> >>>>> +       bool
> >>>>> +       depends on RALINK
> >>>>> +       select PINMUX
> >>>>> +       select GENERIC_PINCONF
> >>>>> +
> >>>>>    config PINCTRL_MTK_MOORE
> >>>>>           bool
> >>>>>           depends on OF
> >>>>> @@ -43,6 +49,49 @@ config PINCTRL_MTK_PARIS
> >>>>>           select OF_GPIO
> >>>>>           select PINCTRL_MTK_V2
> >>>>>
> >>>>> +# For MIPS SoCs
> >>>>> +config PINCTRL_MT7620
> >>>>> +       bool "MediaTek MT7620 pin control"
> >>>>> +       depends on SOC_MT7620 || COMPILE_TEST
> >>>>> +       depends on RALINK
> >>>>> +       default SOC_MT7620
> >>>>> +       select PINCTRL_MTK_MTMIPS
> >>>>> +
> >>>>> +config PINCTRL_MT7621
> >>>>> +       bool "MediaTek MT7621 pin control"
> >>>>> +       depends on SOC_MT7621 || COMPILE_TEST
> >>>>> +       depends on RALINK
> >>>>> +       default SOC_MT7621
> >>>>> +       select PINCTRL_MTK_MTMIPS
> >>>>> +
> >>>>> +config PINCTRL_MT76X8
> >>>>> +       bool "MediaTek MT76X8 pin control"
> >>>>> +       depends on SOC_MT7620 || COMPILE_TEST
> >>>>> +       depends on RALINK
> >>>>> +       default SOC_MT7620
> >>>>> +       select PINCTRL_MTK_MTMIPS
> >>>>> +
> >>>>> +config PINCTRL_RT2880
> >>>>> +       bool "Ralink RT2880 pin control"
> >>>>> +       depends on SOC_RT288X || COMPILE_TEST
> >>>>> +       depends on RALINK
> >>>>> +       default SOC_RT288X
> >>>>> +       select PINCTRL_MTK_MTMIPS
> >>>>> +
> >>>>> +config PINCTRL_RT305X
> >>>>> +       bool "Ralink RT305X pin control"
> >>>>> +       depends on SOC_RT305X || COMPILE_TEST
> >>>>> +       depends on RALINK
> >>>>> +       default SOC_RT305X
> >>>>> +       select PINCTRL_MTK_MTMIPS
> >>>>> +
> >>>>> +config PINCTRL_RT3883
> >>>>> +       bool "Ralink RT3883 pin control"
> >>>>> +       depends on SOC_RT3883 || COMPILE_TEST
> >>>>> +       depends on RALINK
> >>>>> +       default SOC_RT3883
> >>>>> +       select PINCTRL_MTK_MTMIPS
> >>>>> +
> >>>>
> >>>> I am not a Kconfig expert at all but...
> >>>>
> >>>> Should not all of these be depends on SOC_XXX || (COMPILE_TEST &&
> >>>> RALINK) and avoid the " depends on RALINK" next line in all of them?
> >>
> >> This seems to do the same thing but I'm following the "either change
> >> them all or fit into the crowd" ideology.
> >>
> >>>>
> >>>> Just asking since we have yet arch read and write register operation=
s
> >>>> in pinctrl common ralink code. Having in this way, when we address
> >>>> this arch thing  in the next series just removing the "&& RALINK" pa=
rt
> >>>> makes the review pretty obvious.
> >>
> >> You'd have to change RALINK with OF since we're still depending on tha=
t.
> >> RALINK selects OF by default so it's currently a hidden dependency.
> >>
> >>>>
> >>>> Other than that, changes look good to me.
> >>>
> >>> I think "depends on SOC_XXX || (COMPILE_TEST && MIPS)" would work als=
o
> >>> and might be more accurate for compile testing targets.
> >
> > Are you sure? SOC_XXX here is already being enabled only if RALINK is
> > already enabled, right? [0]
>
> I'm not sure who's your reply to, or what it's about here.

Bad insertion between lines, sorry :). I was just trying to explain to
you that SOC_RTXX ralink stuff is only available when RALINK is
already selected.

>
> >
> >>
> >> This is not OK in both cases. If the driver is dependent on Ralink
> >> architecture code, choosing any other MIPS platform will make the driv=
er
> >> available to compile, which will fail.
> >
> > SOC_XXX is already dependent on RALINK for real uses but the driver is
> > going to be selected for other MIPS platforms only for COMPILE_TEST
> > targets. Ideally drivers should be arch agnostic so can be selected
> > for any single arch build. Now we have arch dependent read and write
> > calls in the code, so you need the right headers to be properly found
> > to be able to compile testing. I think MIPS is enough dependency here
> > to properly find them. But if not, this should be (COMPILE_TEST &&
> > RALINK)
>
> I expect below to work without requiring the MIPS option.
>
> ifeq ($(CONFIG_COMPILE_TEST),y)
> CFLAGS_pinctrl-mtmips.o         +=3D -I$(srctree)/arch/mips/include
> endif

Yes, this will work but won't be necessary at all when we get rid of
ralink arch dependent code in the next series.

>
> >
> >>
> >> If the driver is independent of Ralink architecture code, you're
> >> limiting the driver to be compiled only when a MIPS platform is select=
ed.
> >
> > So... how are you planning to allow compile testing of the driver in
> > any single arch when we get rid of all the arch dependent code? If you
> > make everything dependent on RALINK you cannot.
>
> I intend to make it dependent on OF, not RALINK.

Ok, I see, thanks for clarification.

>
> Ar=C4=B1n=C3=A7

Best regards,
    Sergio Paracuellos
