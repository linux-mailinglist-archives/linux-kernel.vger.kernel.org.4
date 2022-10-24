Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF29260B6B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiJXTIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiJXTHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:07:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE900A231F;
        Mon, 24 Oct 2022 10:46:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h9so6295786wrt.0;
        Mon, 24 Oct 2022 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:references:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCRd4IMiplHGr02uOdIgEYhNwjtCaJaq8uNKGxsO7tA=;
        b=SiGLA+7446Gs22PXmMlRTtqX1bz+ACkFKZjJVkvf6rjOR8pzjYjdibWZ0SeACVvvPp
         NGYaxLnZt1He29HUKMNf96cBp3JzlwrOu5dofMW8pZnQEAsHEbdo66AAk3CkUcKavWPW
         XaZfOYQHu5S3r+oXxYlxu4wYsqZSETsQNXwCRgpDaDiFtzax3frHDz674avF6KJ2VsyG
         FND47Wfd6kBVr+yO077xpG4M6HucTR9QlypeIfYTvvsVFKIifgZgi+A2ULcyATWhqzlR
         6pxdiJ0ywItlbjhp7Rz0cB0k6qLP6sod8vWZsyP82Dv1ai2e9EPTtxEIX4cL2erotrrL
         iYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:references:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QCRd4IMiplHGr02uOdIgEYhNwjtCaJaq8uNKGxsO7tA=;
        b=irJ9T58oM8u1LI5FIBeHpJfqS2yj87m7h05QZgCa7bR/BW6o6jeKhUIVh51rn3YHIL
         wGvxLQFMD7ypBINiOMB8shSxSC75d5Kfzverjf8wpThuBaUcApNlapD70971wfxdYjsS
         CQMKYZWumOtLsiqRzKUlpsQNeJQ/niBHHvW/UJOi6kVfIcKcv9if+1OaOR2N1lU69A3W
         rD6KJrPwUgGN3NkiYNXKEsf6LTc3b04Yaw1JU8vVr2tQQxe7VxiKEvvJBnhRmFO3V/Hd
         CF2/jeKVwPSC/C5ziqg/KZG3LMIutHTfvss3enYT/hJR++PK0ZHz+SDRoHByXWJUUFzF
         PyjA==
X-Gm-Message-State: ACrzQf2cxdYIHB4X/el6WqqyYX2VV8fEq32AbFBsgPH344Dorhvh3Qsc
        zWYCs32YlTY3qw2EJmqPbUPkelphbTfzbA==
X-Google-Smtp-Source: AMsMyM4N5xLORfOZINF7JJiZPnZ4/OuZrHLGp8H9Ki94bRHAZ3WTC/Wc+OTTSER+TIgpjYr9uF9r0A==
X-Received: by 2002:a05:6000:2c5:b0:22f:5242:131d with SMTP id o5-20020a05600002c500b0022f5242131dmr21315545wry.228.1666628953935;
        Mon, 24 Oct 2022 09:29:13 -0700 (PDT)
Received: from localhost (188.28.11.70.threembb.co.uk. [188.28.11.70])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d6b44000000b0023677081f3asm67695wrw.42.2022.10.24.09.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:29:13 -0700 (PDT)
References: <20221023145653.177234-1-aidanmacdonald.0x0@gmail.com>
 <20221023145653.177234-6-aidanmacdonald.0x0@gmail.com>
 <AYP7KR.ZQW0GW51WJAG@crapouillou.net>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, zhouyu@wanyeetech.com,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] clk: ingenic: Add X1000 audio clocks
In-reply-to: <AYP7KR.ZQW0GW51WJAG@crapouillou.net>
Date:   Mon, 24 Oct 2022 17:29:09 +0100
Message-ID: <fJMRClXZsQ81yO6lF2VxgYlkyJhstHCq@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Cercueil <paul@crapouillou.net> writes:

> Hi Aidan,
>
> Le dim. 23 oct. 2022 =C3=A0 15:56:53 +0100, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>> The X1000's CGU supplies the I2S system clock to the AIC module
>> and ultimately the audio codec, represented by the "i2s" clock.
>> It is a simple mux which can either pass through EXCLK or a PLL
>> multiplied by a fractional divider (the "i2s_pll" clock).
>> The AIC contains a separate 1/N divider controlled by the I2S
>> driver, which generates the bit clock from the system clock.
>> The frame clock is always fixed to 1/64th of the bit clock.
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  drivers/clk/ingenic/x1000-cgu.c | 69 +++++++++++++++++++++++++++++++++
>>  1 file changed, 69 insertions(+)
>> diff --git a/drivers/clk/ingenic/x1000-cgu.c
>> b/drivers/clk/ingenic/x1000-cgu.c
>> index b2ce3fb83f54..341276e5e1ef 100644
>> --- a/drivers/clk/ingenic/x1000-cgu.c
>> +++ b/drivers/clk/ingenic/x1000-cgu.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/io.h>
>>  #include <linux/of.h>
>> +#include <linux/rational.h>
>>  #include <dt-bindings/clock/ingenic,x1000-cgu.h>
>> @@ -168,6 +169,37 @@ static const struct clk_ops x1000_otg_phy_ops =3D {
>>  	.is_enabled	=3D x1000_usb_phy_is_enabled,
>>  };
>> +static void
>> +x1000_i2spll_calc_m_n_od(const struct ingenic_cgu_pll_info *pll_info,
>> +			 unsigned long rate, unsigned long parent_rate,
>> +			 unsigned int *pm, unsigned int *pn, unsigned int *pod)
>> +{
>> +	const unsigned long m_max =3D GENMASK(pll_info->m_bits - 1, 0);
>> +	const unsigned long n_max =3D GENMASK(pll_info->n_bits - 1, 0);
>> +	unsigned long m, n;
>> +
>> +	rational_best_approximation(rate, parent_rate, m_max, n_max, &m, &n);
>> +
>> +	/* n should not be less than 2*m */
>> +	if (n < 2 * m)
>> +		n =3D 2 * m;
>> +
>> +	*pm =3D m;
>> +	*pn =3D n;
>> +	*pod =3D 1;
>> +}
>> +
>> +static void
>> +x1000_i2spll_set_rate_hook(const struct ingenic_cgu_pll_info *pll_info,
>> +			   unsigned long rate, unsigned long parent_rate)
>> +{
>> +	/*
>> +	 * For some reason, the I2S divider doesn't work properly after
>> +	 * updating I2SCDR unless I2SCDR1 is read & written back.
>> +	 */
>> +	writel(readl(cgu->base + CGU_REG_I2SCDR1), cgu->base + CGU_REG_I2SCDR1=
);
>
> Not fond of the nesting here, just use a variable.
>
> Besides... According to the documentation, bits 31 and 30 of this registe=
r are
> misconnected: writing to bit 31 will be reflected in bit 30, and vice-ver=
sa. So
> this would work only if the bits 30 and 31 have the same value.

From my tests it seems that reads are swapped w.r.t. the documented
bit positions, but not writes. I'm assuming this is the case because
when I write to the register with bit 30 (I2S_DEN) set, I can change
I2SDIV_D freely, but if bit 30 is 0, then I2SDIV_D is replaced by
I2SDIV_N/2 like the manual suggests.

> And worse than that, where do you actually set the register's value? Beca=
use
> bits 30/31, if cleared, will automatically compute the M/N values to the =
I2SCDR
> fields, overriding what the driver's .set_rate() callback is doing.

I don't initialize the register, but I2S_NEN (bit 31 of I2SCDR1) doesn't
cause I2SCDR to be automatically updated like I see with I2SCDR1 when
I2S_DEN =3D 0. It seems setting I2S_NEN to 1 has some other effect on the
clock output, but I don't have an oscilloscope so I'm not sure exactly
what it is. I'm limited to testing by ear.

For example, with f_in =3D 1008 MHz, M =3D 7, N =3D 2500, the output should
nominally be 2.8224 MHz (=3D 64 * 44.1 KHz). Now that works just fine
for playing 44.1 KHz audio if I set I2S_NEN to 0, but setting it to 1,
I need to increase M to 16 to get things to sound right. I've tested
a couple other frequencies but there isn't an obvious pattern to what
increase in M is needed (it always seems to need an increase).

I don't really care to play around with it because everything works
fine if I keep I2S_NEN =3D I2S_DEN =3D 0. I've tested that configuration
from 8 KHz to 192 KHz at typical audio frequencies and randomly chosen
non-standard frequencies, and haven't experienced any issues.

> Either we want that, and in that case the I2S clock should be a custom cl=
ock
> (since it wouldn't need to compute or write M/N), or we don't, and in thi=
s case
> bits 30/31 of this register should be set.

My experience suggests we should set I2S_NEN and I2S_DEN to 0 and
calculate output frequency as F_out =3D F_in * I2SDIV_M / I2SDIV_N.

Reading I2SCDR1 and writing the same value back is something I took
from the Ingenic BSP kernels. (The manual also suggests doing this.)
It worked fine for me so I didn't bother to invesigate it further.

The important part actually seems to be refreshing I2SDIV_D to a
"reasonable" value, which happens automatically when I2S_DEN =3D 0.
But the automatic calculation only happens when writing the register.

Writing 0 to I2SCDR1 solves both problems: the register is properly
initialized and I2SDIV_D gets updated automatically. That seems to
be the best solution.

>> +}
>> +
>>  static const s8 pll_od_encoding[8] =3D {itt
>>  	0x0, 0x1, -1, 0x2, -1, -1, -1, 0x3,
>>  };
>> @@ -319,6 +351,37 @@ static const struct ingenic_cgu_clk_info
>> x1000_cgu_clocks[] =3D {
>>  		.gate =3D { CGU_REG_CLKGR, 25 },
>>  	},
>> +	[X1000_CLK_I2SPLLMUX] =3D {
>> +		"i2s_pll_mux", CGU_CLK_MUX,
>> +		.parents =3D { X1000_CLK_SCLKA, X1000_CLK_MPLL, -1, -1 },
>
> If you have only 1 bit you can only have two parents, so you can remove t=
he
> -1s.
>

Thanks, will do.

Regards,
Aidan

>> +		.mux =3D { CGU_REG_I2SCDR, 31, 1 },
>> +	},
>> +
>> +	[X1000_CLK_I2SPLL] =3D {
>> +		"i2s_pll", CGU_CLK_PLL,
>> +		.parents =3D { X1000_CLK_I2SPLLMUX, -1, -1, -1 },
>
> .parents =3D { X1000_CLK_I2SPLLMUX, },
>
>> +		.pll =3D {
>> +			.reg =3D CGU_REG_I2SCDR,
>> +			.rate_multiplier =3D 1,
>> +			.m_shift =3D 13,
>> +			.m_bits =3D 9,
>> +			.n_shift =3D 0,
>> +			.n_bits =3D 13,
>> +			.calc_m_n_od =3D x1000_i2spll_calc_m_n_od,
>> +			.set_rate_hook =3D x1000_i2spll_set_rate_hook,
>> +		},
>> +	},
>> +
>> +	[X1000_CLK_I2S] =3D {
>> +		"i2s", CGU_CLK_MUX,
>> +		.parents =3D { X1000_CLK_EXCLK, -1, -1, X1000_CLK_I2SPLL },
>> +		/*
>> +		 * NOTE: the mux is at bit 30; bit 29 enables the M/N divider.
>> +		 * Therefore, the divider is disabled when EXCLK is selected.
>> +		 */
>> +		.mux =3D { CGU_REG_I2SCDR, 29, 2 },
>> +	},
>> +
>>  	[X1000_CLK_LCD] =3D {
>>  		"lcd", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
>>  		.parents =3D { X1000_CLK_SCLKA, X1000_CLK_MPLL },
>> @@ -426,6 +489,12 @@ static const struct ingenic_cgu_clk_info
>> x1000_cgu_clocks[] =3D {
>>  		.gate =3D { CGU_REG_CLKGR, 9 },
>>  	},
>> +	[X1000_CLK_AIC] =3D {
>> +		"aic", CGU_CLK_GATE,
>> +		.parents =3D { X1000_CLK_EXCLK, -1, -1, -1 },
>
> .parents =3D { X1000_CLK_EXCLK, },
>
> Cheers,
> -Paul
>
>> +		.gate =3D { CGU_REG_CLKGR, 11 },
>> +	},
>> +
>>  	[X1000_CLK_UART0] =3D {
>>  		"uart0", CGU_CLK_GATE,
>>  		.parents =3D { X1000_CLK_EXCLK, -1, -1, -1 },
>> --
>> 2.38.1
>>
