Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382F4602CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJRNbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJRNbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:31:11 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8D8C6945;
        Tue, 18 Oct 2022 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666099867; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3MzspTM9Dr8LSMMQ6MITd3EeKWr2rZaVT6P5JRlgFc=;
        b=nAc34R932407pmkTMuqbozzx64BjLHj4VBOG8Q9x82Nm0YPEk6WYI4Uvc+AY6jgKIlUogL
        scmhs6NBK2SX5jpT1AvnxBbIwdc6oZb0UK1wNsQDthGPSXu24u6WwISI01Lqur1NB8HcAd
        G5hGjtV2EBVWvTh2Fu7f5al1oI1Bf94=
Date:   Tue, 18 Oct 2022 14:30:57 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 4/4] clk: Add Ingenic JZ4755 CGU driver
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <LVAYJR.C9X3GOLBHW113@crapouillou.net>
In-Reply-To: <CAKNVLfbbAaNdhWDo10XrUtyCM4R5E1CidC+TTQt8tUYbBU93qw@mail.gmail.com>
References: <20221016150110.3020451-1-lis8215@gmail.com>
        <20221016150110.3020451-5-lis8215@gmail.com>
        <0S4WJR.4KB18PR21S9K1@crapouillou.net>
        <CAKNVLfYEMwRC+4VuGcaENd1eTvbhWD9=uFDAhaz+1Fd8Aaqg_w@mail.gmail.com>
        <M0RWJR.TI6Q9ATD37DF3@crapouillou.net>
        <CAKNVLfbbAaNdhWDo10XrUtyCM4R5E1CidC+TTQt8tUYbBU93qw@mail.gmail.com>
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

Hi Siarhei,

Le lun., oct. 17 2022 at 21:07:47 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =C3=A9crit :
> =D0=BF=D0=BD, 17 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 20:24, Paul Cerc=
ueil=20
> <paul@crapouillou.net>:
>>=20
>>=20
>>=20
>>  Le lun., oct. 17 2022 at 20:10:56 +0300, Siarhei Volkau
>>  <lis8215@gmail.com> a =C3=A9crit :
>>  > =D0=BF=D0=BD, 17 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 12:24, Paul =
Cercueil
>>  > <paul@crapouillou.net>:
>>  >
>>  >>  > +     [JZ4755_CLK_AIC] =3D {
>>  >>  > +             "aic", CGU_CLK_GATE,
>>  >>  > +             .parents =3D { JZ4755_CLK_I2S, -1, -1, -1 },
>>  >>
>>  >>  Wrong parent here, should be JZ4755_CLK_EXT_HALF.
>>  >
>>  > I don't  agree, see Figure 20-13 in the JZ4755 PM.
>>=20
>>  20-13 describes the I2S clock, no?
>=20
> See 20.4.9 Serial Audio Clocks and Sampling Frequencies.
> It stated that: "For internal CODEC ... CODEC needs a 12MHz
> clock from CPM called SYS_CLK ...", but SYS_CLK is described
> only in the I2S Controller section. I assume it is the same clock.

Yes, and your SYS_CLK is the I2S clock, not the AIC clock.

>>=20
>>  AIC clock's parent is EXT/2 according to the diagram in 8.2.2.
>>=20
>=20
> It's a bit cryptic manual, who knows how it's done in the HW.
> I observed that codec runs on a desired sample rate only when PLL
> equals 432 or 216 MHz, but SYS_CLK is definitely configured to be
> 12MHz - from EXTCLK. On other PLL frequencies it is lower by
> 2-4% than expected. That isn't observed on JZ4725B.

The audio codec supplies SYS_CLK to the controller, not the other way=20
around. Parent the I2S clock to EXT/2 (which is 12 MHz) and it should=20
work fine, independently of the PLL.

The AIC clock does not drive anything, it only "powers" the AIC module.=20
It should be parented only to EXT/2, similar to what's done in every=20
other CGU driver.

Cheers,
-Paul


