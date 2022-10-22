Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287C0608F7F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 22:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJVUEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 16:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJVUEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 16:04:06 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2A376578;
        Sat, 22 Oct 2022 13:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666469043; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ukvabM0JPo9IzHCTJ8vCAUmN8porn4JU/9khjkkZ7s=;
        b=oDeXW44Ideo1j1JauRc5lpNfKboKV3kgSCbG2dm8u4ZQ7QcIjZDnFuK/nwXJPzkNiPWPtC
        4MrBNnXzTLFabC494eWkJ4Qvk9s+o1vpu+qhDN8xljYRcUspLCyZ4vnC3NmJEbsq0FDcjp
        5UY6Aa1ZEilhhMGXte5P97eKbDys+mo=
Date:   Sat, 22 Oct 2022 21:03:53 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 07/11] ASoC: jz4740-i2s: Make the PLL clock name
 SoC-specific
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Zhou Yanjie <zhouyu@wanyeetech.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Message-Id: <HQ76KR.B1PM87E2GIYZ1@crapouillou.net>
In-Reply-To: <UQ597w4FmzOT8p76tdRPhzECStUpFmYe@localhost>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
        <20220708160244.21933-8-aidanmacdonald.0x0@gmail.com>
        <0269b850-f33a-7aa9-a3eb-83655bd4e19a@wanyeetech.com>
        <ROSYER.QTJF8J14H2YX1@crapouillou.net>
        <6f2c7a0b-b68b-fc42-1a82-2b69c114823f@wanyeetech.com>
        <UQ597w4FmzOT8p76tdRPhzECStUpFmYe@localhost>
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

Hi Aidan,

Le sam. 22 oct. 2022 =C3=A0 18:15:05 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>=20
> Zhou Yanjie <zhouyu@wanyeetech.com> writes:
>=20
>>  Hi Paul,
>>=20
>>  On 2022/7/13 =E4=B8=8B=E5=8D=8811:07, Paul Cercueil wrote:
>>>  Hi Zhou,
>>>=20
>>>  Le mer., juil. 13 2022 at 22:33:44 +0800, Zhou Yanjie=20
>>> <zhouyu@wanyeetech.com>
>>>  a =C3=A9crit :
>>>>  Hi Aidan,
>>>>=20
>>>>  On 2022/7/9 =E4=B8=8A=E5=8D=8812:02, Aidan MacDonald wrote:
>>>>>  @@ -400,6 +402,7 @@ static const struct i2s_soc_info=20
>>>>> jz4740_i2s_soc_info =3D
>>>>>  {
>>>>>        .field_tx_fifo_thresh    =3D REG_FIELD(JZ_REG_AIC_CONF, 8,=20
>>>>> 11),
>>>>>        .field_i2sdiv_capture    =3D REG_FIELD(JZ_REG_AIC_CLK_DIV,=20
>>>>> 0, 3),
>>>>>        .field_i2sdiv_playback    =3D REG_FIELD(JZ_REG_AIC_CLK_DIV,=20
>>>>> 0, 3),
>>>>>  +    .pll_clk_name        =3D "pll half",
>>>>>        .shared_fifo_flush    =3D true,
>>>>>    };
>>>>=20
>>>>=20
>>>>  Since JZ4760, according to the description of the I2SCDR register,
>>>>  Ingenic SoCs no longer use PLL/2 clock, but directly use PLL=20
>>>> clock,
>>>>  so it seems also inappropriate to use "pll half" for these SoCs.
>>>=20
>>>  The device tree passes the clock as "pll half". So the driver=20
>>> should use this
>>>  name as well...
>>=20
>>=20
>>  I see...
>>=20
>>  It seems that the device tree of JZ4770 has used "pll half" already,
>>  but there is no "pll half" used anywhere in the device tree of=20
>> JZ4780,
>>  maybe we can keep the pll_clk_name of JZ4770 as "pll half", and=20
>> change
>>  the pll_clk_name of JZ4780 to a more reasonable name.
>>=20
>>=20
>>  Thanks and best regards!
>=20
> Actually, the clock names in the DT are meaningless. The clk_get()=20
> call
> matches only the clock's name in the CGU driver. So in fact the driver
> is "broken" for jz4780. It seems jz4770 doesn't work correctly either,
> it has no "pll half", and three possible parents for its "i2s" clock.

That's not true. The clock names are matched via DT.

Only in the case where a corresponding clock cannot be found via DT=20
will it search for the clock name among the clock providers. I believe=20
this is a legacy mechanism and you absolutely shouldn't rely on it.

-Paul

> Since the driver only supports the internal codec, which requires the
> "ext" clock, there isn't a problem in practice.
>=20
> I'm just going to drop this patch and leave .set_sysclk() alone for=20
> now.
> I think a better approach is to have the DT define an array of parent
> clocks for .set_sysclk()'s use, instead of hardcoding parents in the
> driver. If the parent array is missing the driver can default to using
> "ext" so existing DTs will work.
>=20
> Regards,
> Aidan


