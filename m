Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9B362F5AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbiKRNOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241312AbiKRNOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:14:41 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE66D48774;
        Fri, 18 Nov 2022 05:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1668777279; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1AzedYug7GwDfLpFsnro4myCbhaA1IR7C6ixaVaUME=;
        b=GmSDzTT9zO9F5+ArV4OBentb2p3TFLkWEBcwzyPGr840UuzLLKZVF0FMtneV/g8mJ1TdUV
        MZr2jcUqtvvZtAIyOkkcirRb447kMDrKabwVOnenabd0QB0C3uMx7sJsP1gJ/z0Qu8ode7
        U/hA0c9LAFAHCA4WPUocmNom+o5R36Y=
Date:   Fri, 18 Nov 2022 13:14:29 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] mmc: jz4740: Don't change parent clock rate for some
 SoCs
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Message-Id: <5SOJLR.8XBYHE5WSC681@crapouillou.net>
In-Reply-To: <IBOJLR.I7JEODTRBACJ1@crapouillou.net>
References: <20221108045300.2084671-1-lis8215@gmail.com>
        <20221108045300.2084671-2-lis8215@gmail.com>
        <CAPDyKFrMqCL1-faBadVP3xB-5qiCYsyRUuOHbFZuOWfLdCXwig@mail.gmail.com>
        <59EJLR.DQ7KHQEAEUSG2@crapouillou.net>
        <CAKNVLfYpmJjQYFOy__PkmqcftQcQUYEKJ2V2K90MfG-1MBC_uA@mail.gmail.com>
        <IBOJLR.I7JEODTRBACJ1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le ven. 18 nov. 2022 =C3=A0 13:04:30 +0000, Paul Cercueil=20
<paul@crapouillou.net> a =C3=A9crit :
> Hi Siarhei,
>=20
> Le ven. 18 nov. 2022 =C3=A0 12:51:54 +0300, Siarhei Volkau=20
> <lis8215@gmail.com> a =C3=A9crit :
>> =D0=BF=D1=82, 18 =D0=BD=D0=BE=D1=8F=D0=B1. 2022 =D0=B3. =D0=B2 12:27, Pa=
ul Cercueil=20
>> =7F<paul@crapouillou.net>:
>>>=20
>>>  Hi,
>>>=20
>>>  (Ingenic SoCs maintainer here)
>>>=20
>>>  Le ven. 18 nov. 2022 =C3=A0 09:45:48 +0100, Ulf Hansson
>>>  <ulf.hansson@linaro.org> a =C3=A9crit :
>>>  > On Tue, 8 Nov 2022 at 05:53, Siarhei Volkau <lis8215@gmail.com>=20
>>> =7F=7Fwrote:
>>>  >>
>>>  >>  Some SoCs have one clock divider for all MMC units, thus=20
>>> =7F=7Fchanging
>>>  >> one
>>>  >>  affects others as well. This leads to random hangs and memory
>>>  >>  corruptions, observed on the JZ4755 based device with two MMC=20
>>> =7F=7Fslots
>>>  >>  used at the same time.
>>>  >
>>>  > Urgh, that sounds like broken HW to me.
>>>  >
>>>  > The MMC blocks could share a parent clock (that would need a=20
>>> fixed
>>>  > rate for it to be applied), assuming there is a separate=20
>>> =7F=7Fgate/divider
>>>  > available per block. But there isn't'?
>>>=20
>>>  They do share a parent clock and have separate gates, and each MMC=20
>>> =7F=7FIP
>>>  block has an internal divider for the bus frequency derived from=20
>>> =7F=7Fthat
>>>  shared clock.
>>>=20
>>>  >>
>>>  >>  List of SoCs affected includes: JZ4725b, JZ4755, JZ4760 and=20
>>> =7F=7FJZ4760b.
>>>  >>  However, the MMC driver doesn't distinguish JZ4760 and JZ4770
>>>  >>  which shall remain its behavior. For the JZ4755 is sufficient=20
>>> to
>>>  >>  use JZ4725b's binding. JZ4750 is outside of the patch.
>>>  >>
>>>  >>  The MMC core has its own clock divisor, rather coarse but=20
>>> =7F=7Fsuitable
>>>  >> well,
>>>  >>  and it shall keep the role of tuning clock for the MMC host in=20
>>> =7F=7Fthat
>>>  >>  case.
>>>  >
>>>  > The mmc core doesn't have a clock divisor, but it does control=20
>>> =7F=7Fthe bus
>>>  > clock frequency through the ->set_ios() host ops. It needs to do=20
>>> =7F=7Fthat,
>>>  > to be able to conform to the (e)MMC, SD and SDIO specifications.
>>>  >
>>>  > Can you please try to elaborate on the above, so I can better
>>>  > understand your point?
>>>=20
>>>  Yes, I don't really understand the patch, TBH.
>>>=20
>>>  The "clk_set_rate" call will only set the shared clock to the=20
>>> =7F=7F*maximum*
>>>  clock frequency (host->mmc->f_max) which should be the exact same
>>>  across all MMC IPs.
>>=20
>> That's the case I need different "f_max" for my HW, for some reason
>> internal slot can't do a full rate (48MHz) but the external can, the=20
>> =7Fsame
>> card used for checking. So I want to set 24M for mmc0, and 48M for=20
>> =7Fmmc1
>> with respect to hardware limitation.
>=20
> The JZ4760B programming manual states that the controller is "fully=20
> compatible with the SD Memory Card Specification 2.0". In that=20
> specification, the bus speed is max. 25 MHz.
>=20
> The programming manual also says: "In data transfer mode, the MSC=20
> controller can operate card with clock rate fpp (0 ~ 25Mhz)."
>=20
> So the max-frequency really should be 25 MHz.

Nevermind. I read wrong, at least the SD spec. (the quote of the=20
programming manual is still concerning though).

It's rated for 25 MB/s, so 50 MHz on 4 lanes.

Cheers,
-Paul

>=20
>>>=20
>>>  So it doesn't matter if it's set 3 times by 3 different instances=20
>>> of
>>>  the IP, as long as they all request the same value.
>>>=20
>>>  Besides, I know for a fact that the mainline driver works fine on=20
>>> =7F=7Fthe
>>>  JZ4760(B) and JZ4725B.
>>>=20
>>>  Finally... even if it was correct, this change would break
>>>  compatibility with old Device Tree files.
>>>=20
>>>  Cheers,
>>>  -Paul
>>>=20
>>>  >>
>>>  >>  Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
>>>  >
>>>  > Kind regards
>>>  > Uffe
>>>  >
>>>  >>  ---
>>>  >>   drivers/mmc/host/jz4740_mmc.c | 10 +++++++++-
>>>  >>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>  >>
>>>  >>  diff --git a/drivers/mmc/host/jz4740_mmc.c
>>>  >> b/drivers/mmc/host/jz4740_mmc.c
>>>  >>  index dc2db9c18..d390ff31d 100644
>>>  >>  --- a/drivers/mmc/host/jz4740_mmc.c
>>>  >>  +++ b/drivers/mmc/host/jz4740_mmc.c
>>>  >>  @@ -114,6 +114,7 @@ enum jz4740_mmc_version {
>>>  >>          JZ_MMC_JZ4740,
>>>  >>          JZ_MMC_JZ4725B,
>>>  >>          JZ_MMC_JZ4760,
>>>  >>  +       JZ_MMC_JZ4770,
>>>  >>          JZ_MMC_JZ4780,
>>>  >>          JZ_MMC_X1000,
>>>  >>   };
>>>  >>  @@ -887,7 +888,13 @@ static int=20
>>> jz4740_mmc_set_clock_rate(struct
>>>  >> jz4740_mmc_host *host, int rate)
>>>  >>          int real_rate;
>>>  >>
>>>  >>          jz4740_mmc_clock_disable(host);
>>>  >>  -       clk_set_rate(host->clk, host->mmc->f_max);
>>>  >>  +
>>>  >>  +       /*
>>>  >>  +        * Changing rate on these SoCs affects other MMC units=20
>>> =7F=7Ftoo.
>>>  >>  +        * Make sure the rate is configured properly by the CGU
>>>  >> driver.
>>>  >>  +        */
>>>  >>  +       if (host->version !=3D JZ_MMC_JZ4725B && host->version !=
=3D
>>>  >> JZ_MMC_JZ4760)
>>>  >>  +               clk_set_rate(host->clk, host->mmc->f_max);
>>>  >>
>>>  >>          real_rate =3D clk_get_rate(host->clk);
>>>  >>
>>>  >>  @@ -992,6 +999,7 @@ static const struct of_device_id
>>>  >> jz4740_mmc_of_match[] =3D {
>>>  >>          { .compatible =3D "ingenic,jz4740-mmc", .data =3D (void *)
>>>  >> JZ_MMC_JZ4740 },
>>>  >>          { .compatible =3D "ingenic,jz4725b-mmc", .data =3D (void
>>>  >> *)JZ_MMC_JZ4725B },
>>>  >>          { .compatible =3D "ingenic,jz4760-mmc", .data =3D (void *)
>>>  >> JZ_MMC_JZ4760 },
>>>  >>  +       { .compatible =3D "ingenic,jz4770-mmc", .data =3D (void *)
>>>  >> JZ_MMC_JZ4770 },
>>>  >>          { .compatible =3D "ingenic,jz4775-mmc", .data =3D (void *)
>>>  >> JZ_MMC_JZ4780 },
>>>  >>          { .compatible =3D "ingenic,jz4780-mmc", .data =3D (void *)
>>>  >> JZ_MMC_JZ4780 },
>>>  >>          { .compatible =3D "ingenic,x1000-mmc", .data =3D (void *)
>>>  >> JZ_MMC_X1000 },
>>>  >>  --
>>>  >>  2.36.1
>>>  >>
>>>=20
>>>=20
>=20


