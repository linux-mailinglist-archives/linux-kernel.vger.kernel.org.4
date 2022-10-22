Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF99E608F59
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 21:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJVTso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 15:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJVTsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 15:48:39 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E7A12909D;
        Sat, 22 Oct 2022 12:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666468116; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQAJ80Z9XfDphOpg7EzTa812SC27eRmwyuk3vTJDJKA=;
        b=YDYZtkozwO78kvoJN6aFoiFtrbloMSRhxpPyjUTXe04p374GLJn50/5UM6hzyimc8T4pKt
        PkcdkwZh4t/bsz3wjtAOeCfHSelrewZE+3hVK+4QPYR3Wu6LsNfI4/Ajhu7cfRTxGVr5BL
        dOmNBuS+uawCckKPSdmCmSYuhrdrhJg=
Date:   Sat, 22 Oct 2022 20:48:25 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 1/9] ASoC: jz4740-i2s: Handle independent FIFO flush
 bits
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <P076KR.VI33CVGCD2OG3@crapouillou.net>
In-Reply-To: <20221022191308.82348-2-aidanmacdonald.0x0@gmail.com>
References: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
        <20221022191308.82348-2-aidanmacdonald.0x0@gmail.com>
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

Le sam. 22 oct. 2022 =E0 20:13:00 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> On the JZ4740, there is a single bit that flushes (empties) both
> the transmit and receive FIFO. Later SoCs have independent flush
> bits for each FIFO.
>=20
> Independent FIFOs can be flushed before the snd_soc_dai_active()
> check because it won't disturb other active streams. This ensures
> that the FIFO we're about to use is always flushed before starting
> up. With shared FIFOs we can't do that because if another substream
> is active, flushing its FIFO would cause underrun errors.
>=20
> This also fixes a bug: since we were only setting the JZ4740's
> flush bit, which corresponds to the TX FIFO flush bit on other
> SoCs, other SoCs were not having their RX FIFO flushed at all.
>=20
> Fixes: 967beb2e8777 ("ASoC: jz4740: Add jz4780 support")
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

If you have a Fixes: tag you need to Cc linux-stable as well.
See "option 1" of=20
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Also, a cover letter with a description of the changes is good, but you=20
should still add a changelog per patch (below the --- line so that it=20
doesn't end up in the commit message). That makes it much easier to=20
review.

With the Cc line added:
Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 39=20
> ++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index c4c1e89b47c1..83cb81999c6f 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -55,7 +55,8 @@
>  #define JZ_AIC_CTRL_MONO_TO_STEREO BIT(11)
>  #define JZ_AIC_CTRL_SWITCH_ENDIANNESS BIT(10)
>  #define JZ_AIC_CTRL_SIGNED_TO_UNSIGNED BIT(9)
> -#define JZ_AIC_CTRL_FLUSH		BIT(8)
> +#define JZ_AIC_CTRL_TFLUSH		BIT(8)
> +#define JZ_AIC_CTRL_RFLUSH		BIT(7)
>  #define JZ_AIC_CTRL_ENABLE_ROR_INT BIT(6)
>  #define JZ_AIC_CTRL_ENABLE_TUR_INT BIT(5)
>  #define JZ_AIC_CTRL_ENABLE_RFS_INT BIT(4)
> @@ -90,6 +91,8 @@ enum jz47xx_i2s_version {
>  struct i2s_soc_info {
>  	enum jz47xx_i2s_version version;
>  	struct snd_soc_dai_driver *dai;
> +
> +	bool shared_fifo_flush;
>  };
>=20
>  struct jz4740_i2s {
> @@ -116,19 +119,44 @@ static inline void jz4740_i2s_write(const=20
> struct jz4740_i2s *i2s,
>  	writel(value, i2s->base + reg);
>  }
>=20
> +static inline void jz4740_i2s_set_bits(const struct jz4740_i2s *i2s,
> +	unsigned int reg, uint32_t bits)
> +{
> +	uint32_t value =3D jz4740_i2s_read(i2s, reg);
> +	value |=3D bits;
> +	jz4740_i2s_write(i2s, reg, value);
> +}
> +
>  static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
>  	struct snd_soc_dai *dai)
>  {
>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> -	uint32_t conf, ctrl;
> +	uint32_t conf;
>  	int ret;
>=20
> +	/*
> +	 * When we can flush FIFOs independently, only flush the FIFO
> +	 * that is starting up. We can do this when the DAI is active
> +	 * because it does not disturb other active substreams.
> +	 */
> +	if (!i2s->soc_info->shared_fifo_flush) {
> +		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +			jz4740_i2s_set_bits(i2s, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_TFLUSH);
> +		else
> +			jz4740_i2s_set_bits(i2s, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_RFLUSH);
> +	}
> +
>  	if (snd_soc_dai_active(dai))
>  		return 0;
>=20
> -	ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
> -	ctrl |=3D JZ_AIC_CTRL_FLUSH;
> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
> +	/*
> +	 * When there is a shared flush bit for both FIFOs, the TFLUSH
> +	 * bit flushes both FIFOs. Flushing while the DAI is active would
> +	 * cause FIFO underruns in other active substreams so we have to
> +	 * guard this behind the snd_soc_dai_active() check.
> +	 */
> +	if (i2s->soc_info->shared_fifo_flush)
> +		jz4740_i2s_set_bits(i2s, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_TFLUSH);
>=20
>  	ret =3D clk_prepare_enable(i2s->clk_i2s);
>  	if (ret)
> @@ -443,6 +471,7 @@ static struct snd_soc_dai_driver jz4740_i2s_dai =3D=20
> {
>  static const struct i2s_soc_info jz4740_i2s_soc_info =3D {
>  	.version =3D JZ_I2S_JZ4740,
>  	.dai =3D &jz4740_i2s_dai,
> +	.shared_fifo_flush =3D true,
>  };
>=20
>  static const struct i2s_soc_info jz4760_i2s_soc_info =3D {
> --
> 2.38.1
>=20


