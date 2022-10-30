Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DC0612A7B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 12:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJ3L6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 07:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3L6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 07:58:21 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF678BF7C;
        Sun, 30 Oct 2022 04:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667131099; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PoqpCs7UkUcDQ/eJ5UxDl3G9RkcflCO27aydlA+p8YI=;
        b=foe3rY0Mws/a0FLz2UPceasWglq7atRdpbjqdbxeEoMxDWdNJUDZy6QdqSF9LsxtSjTxMZ
        s3Xm19Ghw12/FIynrutoMOKF1YG6fAbxvQyUzewNLl6eFBrZi5uNt5ZYpqBBprXetCL0BT
        fFBf+Msg//55/1l7VaXslgoc0Oxw+sM=
Date:   Sun, 30 Oct 2022 11:58:09 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v1 3/3] ASoC: jz4740-i2s: Remove .set_sysclk()
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tsbogend@alpha.franken.de,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <XKEKKR.KWZ8D69P0CYL3@crapouillou.net>
In-Reply-To: <20221028103418.17578-4-aidanmacdonald.0x0@gmail.com>
References: <20221028103418.17578-1-aidanmacdonald.0x0@gmail.com>
        <20221028103418.17578-4-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
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

Le ven. 28 oct. 2022 =E0 11:34:18 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> .set_sysclk() is effectively unused here. No machine drivers use
> jz4740-i2s; and JZ4740_I2S_CLKSRC_EXT is the only selectable clock
> source with simple-card, but that is also the default source and
> has a fixed frequency, so configuring it would be redundant.
>=20
> simple-card ignores -ENOTSUPP error codes when setting the sysclock,
> so any device trees that do set the sysclock for some reason should
> still work.
>=20
> It's still possible to configure the clock parent manually in the
> device tree and control frequency using other simple-card options,
> so at the end of the day there's no real loss in functionality.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> Meant to be applied on top of jz4740-i2s cleanups series already
> in linux-next.
> Link:=20
> https://lore.kernel.org/alsa-devel/20221023143328.160866-1-aidanmacdonald=
.0x0@gmail.com/
>=20
>  sound/soc/jz4740/jz4740-i2s.c | 32 --------------------------------
>  sound/soc/jz4740/jz4740-i2s.h | 10 ----------
>  2 files changed, 42 deletions(-)
>  delete mode 100644 sound/soc/jz4740/jz4740-i2s.h
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index b620d4462d90..6d9cfe0a5041 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -23,8 +23,6 @@
>  #include <sound/initval.h>
>  #include <sound/dmaengine_pcm.h>
>=20
> -#include "jz4740-i2s.h"
> -
>  #define JZ_REG_AIC_CONF		0x00
>  #define JZ_REG_AIC_CTRL		0x04
>  #define JZ_REG_AIC_I2S_FMT	0x10
> @@ -273,35 +271,6 @@ static int jz4740_i2s_hw_params(struct=20
> snd_pcm_substream *substream,
>  	return 0;
>  }
>=20
> -static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
> -	unsigned int freq, int dir)
> -{
> -	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> -	struct clk *parent;
> -	int ret =3D 0;
> -
> -	switch (clk_id) {
> -	case JZ4740_I2S_CLKSRC_EXT:
> -		parent =3D clk_get(NULL, "ext");
> -		if (IS_ERR(parent))
> -			return PTR_ERR(parent);
> -		clk_set_parent(i2s->clk_i2s, parent);
> -		break;
> -	case JZ4740_I2S_CLKSRC_PLL:
> -		parent =3D clk_get(NULL, "pll half");
> -		if (IS_ERR(parent))
> -			return PTR_ERR(parent);
> -		clk_set_parent(i2s->clk_i2s, parent);
> -		ret =3D clk_set_rate(i2s->clk_i2s, freq);
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -	clk_put(parent);
> -
> -	return ret;
> -}
> -
>  static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
>  {
>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> @@ -318,7 +287,6 @@ static const struct snd_soc_dai_ops=20
> jz4740_i2s_dai_ops =3D {
>  	.trigger =3D jz4740_i2s_trigger,
>  	.hw_params =3D jz4740_i2s_hw_params,
>  	.set_fmt =3D jz4740_i2s_set_fmt,
> -	.set_sysclk =3D jz4740_i2s_set_sysclk,
>  };
>=20
>  #define JZ4740_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | \
> diff --git a/sound/soc/jz4740/jz4740-i2s.h=20
> b/sound/soc/jz4740/jz4740-i2s.h
> deleted file mode 100644
> index 4da14eac1145..000000000000
> --- a/sound/soc/jz4740/jz4740-i2s.h
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -
> -#ifndef _JZ4740_I2S_H
> -#define _JZ4740_I2S_H
> -
> -/* I2S clock source */
> -#define JZ4740_I2S_CLKSRC_EXT 0
> -#define JZ4740_I2S_CLKSRC_PLL 1
> -
> -#endif
> --
> 2.38.1
>=20


