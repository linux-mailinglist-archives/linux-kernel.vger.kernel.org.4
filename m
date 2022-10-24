Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5118A60BE8B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJXX35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiJXX3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:29:35 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD930275FE;
        Mon, 24 Oct 2022 14:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666616783; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9DWmVXnBB0alokK0Ux9UPjubSOauF60G+854IF0GBY=;
        b=IjAnjv6TPydu6+wMG8G3TtjNZOK2tnhXk2sAqS4Ja+Ztp3nEbHuzx05AWva//Tb6t69E78
        EXZCF9f8OtTT/oUA8K9DLsAzBaHF3Uq8GMMeY+cOjKp0PliA/a92lYjucSlVQ7QTG7BQe9
        OCA0RX4DUeCKgAkhXplgVeMj8Z8xQL4=
Date:   Mon, 24 Oct 2022 14:06:13 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 07/11] ASoC: jz4740-i2s: Make the PLL clock name
 SoC-specific
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Zhou Yanjie <zhouyu@wanyeetech.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Message-Id: <DQD9KR.BW8U6333OSCP3@crapouillou.net>
In-Reply-To: <JRrsX7Q4m5FUeeBs2yKTRMe5Ihaso8gi@localhost>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
        <20220708160244.21933-8-aidanmacdonald.0x0@gmail.com>
        <0269b850-f33a-7aa9-a3eb-83655bd4e19a@wanyeetech.com>
        <ROSYER.QTJF8J14H2YX1@crapouillou.net>
        <6f2c7a0b-b68b-fc42-1a82-2b69c114823f@wanyeetech.com>
        <UQ597w4FmzOT8p76tdRPhzECStUpFmYe@localhost>
        <HQ76KR.B1PM87E2GIYZ1@crapouillou.net>
        <JRrsX7Q4m5FUeeBs2yKTRMe5Ihaso8gi@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le dim. 23 oct. 2022 =C3=A0 14:29:24 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>=20
> Paul Cercueil <paul@crapouillou.net> writes:
>=20
>>  Hi Aidan,
>>=20
>>  Le sam. 22 oct. 2022 =C3=A0 18:15:05 +0100, Aidan MacDonald
>>  <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>>>  Zhou Yanjie <zhouyu@wanyeetech.com> writes:
>>>=20
>>>>   Hi Paul,
>>>>   On 2022/7/13 =E4=B8=8B=E5=8D=8811:07, Paul Cercueil wrote:
>>>>>   Hi Zhou,
>>>>>   Le mer., juil. 13 2022 at 22:33:44 +0800, Zhou Yanjie
>>>>>  <zhouyu@wanyeetech.com>
>>>>>   a =C3=A9crit :
>>>>>>   Hi Aidan,
>>>>>>   On 2022/7/9 =E4=B8=8A=E5=8D=8812:02, Aidan MacDonald wrote:
>>>>>>>   @@ -400,6 +402,7 @@ static const struct i2s_soc_info=20
>>>>>>> jz4740_i2s_soc_info
>>>>>>>  =3D
>>>>>>>   {
>>>>>>>         .field_tx_fifo_thresh    =3D REG_FIELD(JZ_REG_AIC_CONF,=20
>>>>>>> 8, 11),
>>>>>>>         .field_i2sdiv_capture    =3D=20
>>>>>>> REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>>>>>>>         .field_i2sdiv_playback    =3D=20
>>>>>>> REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>>>>>>>   +    .pll_clk_name        =3D "pll half",
>>>>>>>         .shared_fifo_flush    =3D true,
>>>>>>>     };
>>>>>>   Since JZ4760, according to the description of the I2SCDR=20
>>>>>> register,
>>>>>>   Ingenic SoCs no longer use PLL/2 clock, but directly use PLL=20
>>>>>> clock,
>>>>>>   so it seems also inappropriate to use "pll half" for these=20
>>>>>> SoCs.
>>>>>   The device tree passes the clock as "pll half". So the driver=20
>>>>> should use
>>>>>  this
>>>>>   name as well...
>>>>   I see...
>>>>   It seems that the device tree of JZ4770 has used "pll half"=20
>>>> already,
>>>>   but there is no "pll half" used anywhere in the device tree of=20
>>>> JZ4780,
>>>>   maybe we can keep the pll_clk_name of JZ4770 as "pll half", and=20
>>>> change
>>>>   the pll_clk_name of JZ4780 to a more reasonable name.
>>>>   Thanks and best regards!
>>>  Actually, the clock names in the DT are meaningless. The clk_get()=20
>>> call
>>>  matches only the clock's name in the CGU driver. So in fact the=20
>>> driver
>>>  is "broken" for jz4780. It seems jz4770 doesn't work correctly=20
>>> either,
>>>  it has no "pll half", and three possible parents for its "i2s"=20
>>> clock.
>>=20
>>  That's not true. The clock names are matched via DT.
>>=20
>>  Only in the case where a corresponding clock cannot be found via DT=20
>> will it
>>  search for the clock name among the clock providers. I believe this=20
>> is a legacy
>>  mechanism and you absolutely shouldn't rely on it.
>>=20
>>  -Paul
>>=20
>=20
> What you say is only true for clk_get() with a device argument. When=20
> the
> device argument is NULL -- which is the case in .set_sysclk() -- then
> the DT name is not matched. Check drivers/clk/clkdev.c, in clk_find().
> When the dev_id is NULL, it will not match any lookup entries with a
> non-null dev_id, and I believe dev_id is the mechanism that implements
> DT clock lookup. Only the wildcard entries from the CGU driver will be
> matched if dev_id is NULL, so the DT is being ignored.
>=20
> If you don't believe me, try changing "pll half" in the device tree=20
> and
> the I2S driver to something else. I have done this, and it doesn't=20
> work.
> That proves the name in the device tree is not being used.

Well, let's pass them a device pointer then.

> I agree we shouldn't rely on this, it's a legacy behavior, but the=20
> fact
> is that's how the driver already works. I'm dropping this patch=20
> because
> the driver is wrong and needs a different fix...

"How the driver already works" is a bit misleading, I never saw this=20
.set_sysclk() callback being called, so I can't really say that it=20
works.

>>>  I think a better approach is to have the DT define an array of=20
>>> parent
>>>  clocks for .set_sysclk()'s use, instead of hardcoding parents in=20
>>> the
>>>  driver. If the parent array is missing the driver can default to=20
>>> using
>>>  "ext" so existing DTs will work.
>=20
> As much as I like this idea there doesn't seem to be a mechanism for
> handling a free-floating array of clocks in the DT. Everything has
> to be put in the main "clocks" array. That makes it pretty hard to
> figure out which ones are meant to be the parent clocks.
>=20
> Do you know of any way to do this generically from the DT? If there's
> no way to get away from a hardcoded array of names in the driver, I=20
> can
> at least add a device argument to clk_get() so it'll use the DT names.

In jz4740_i2s_set_sysclk():

#define JZ4740_I2S_FIRST_PARENT_CLK 2
parent =3D of_clk_get(dev->of_node, JZ4740_I2S_FIRST_PARENT_CLK + clk_id);

is how I'd do it.

The DTs all have "aic", "i2s" as the first two clocks. It is even=20
enforced in the DT schemas.

Cheers,
-Paul


