Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAEE65B31F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbjABOEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjABOE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:04:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD92657D;
        Mon,  2 Jan 2023 06:04:27 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A3E116602CD9;
        Mon,  2 Jan 2023 14:04:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672668265;
        bh=9SfAvpp+xUocwdOTAlc0yJwXpK/UtaHt4dqqho+pHyE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FuE68w9Iq0c5UKIwMSNQu25pCOt41tk2jo3M3UMRi/qXlIitOxMZ1BtXXW1fV2Q+g
         t0AruPk9jTmiNN5iaZQBC2fVELbtOzovIZHunj0BlTjUQtZqscrYrteCPgp67g6bPQ
         Sk81cMnUVnvxMqEQTjonzp19OmA20OwwNYZBObWpaZtUF9zH61RnYn8G1y9RY22P0n
         cmVo9bd7TMdPA6w6l6s80Kq08I7j7pcqR+BxAFJqazBtp6z/puX/4hUyPNkj1IxZPW
         g/8ppxSMVeQuC1Y5PQ9hDWnsC3AjrfVjimW2imhtsEOjueiu0Nuxs3kPUSfX+oZ8pI
         soch/rq5PAhjA==
Message-ID: <6309e7c5-f740-fa22-bdf0-937187b19285@collabora.com>
Date:   Mon, 2 Jan 2023 15:04:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 05/13] ASoC: mediatek: mt8188: support etdm in platform
 driver
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221230055443.16024-1-trevor.wu@mediatek.com>
 <20221230055443.16024-6-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221230055443.16024-6-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/12/22 06:54, Trevor Wu ha scritto:
> Add mt8188 etdm dai driver support.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>   sound/soc/mediatek/mt8188/mt8188-dai-etdm.c | 2591 +++++++++++++++++++
>   1 file changed, 2591 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c b/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
> new file mode 100644
> index 000000000000..f8e69d655706
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
> @@ -0,0 +1,2591 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MediaTek ALSA SoC Audio DAI eTDM Control
> + *
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Bicycle Tsai <bicycle.tsai@mediatek.com>
> + *         Trevor Wu <trevor.wu@mediatek.com>
> + *         Chun-Chia Chiu <chun-chia.chiu@mediatek.com>
> + */
> +

..snip..

> +
> +static int mtk_dai_etdm_get_clkdiv_id_by_dai_id(int dai_id)
> +{
> +	int clk_id = -1;
> +
> +	switch (dai_id) {
> +	case MT8188_AFE_IO_DPTX:
> +		clk_id = MT8188_CLK_TOP_APLL12_DIV9;

		return MT8188_CLK_TOP_APLL12_DIV_9;

> +		break;
> +	case MT8188_AFE_IO_ETDM1_IN:
> +		clk_id = MT8188_CLK_TOP_APLL12_DIV0;

		return MT8188_CLK_TOP_APLL12_DIV0;

> +		break;
> +	case MT8188_AFE_IO_ETDM2_IN:
> +		clk_id = MT8188_CLK_TOP_APLL12_DIV1;

return .....

> +		break;
> +	case MT8188_AFE_IO_ETDM1_OUT:
> +		clk_id = MT8188_CLK_TOP_APLL12_DIV2;
> +		break;
> +	case MT8188_AFE_IO_ETDM2_OUT:
> +		clk_id = MT8188_CLK_TOP_APLL12_DIV3;
> +		break;
> +	case MT8188_AFE_IO_ETDM3_OUT:
> +	default:
> +		break;
> +	}
> +
> +	return clk_id;

	return -EINVAL;

...so you don't need clk_id at all :-)

> +}
> +

..snip..

> +
> +static int mtk_dai_etdm_mclk_configure(struct mtk_base_afe *afe, int dai_id)
> +{
> +	struct mt8188_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_etdm_priv *etdm_data;
> +	int clk_id = mtk_dai_etdm_get_clk_id_by_dai_id(dai_id);
> +	int clkdiv_id = mtk_dai_etdm_get_clkdiv_id_by_dai_id(dai_id);
> +	int apll;
> +	int apll_clk_id;
> +	struct etdm_con_reg etdm_reg;
> +	int ret = 0;
> +
> +	if (clk_id < 0 || clkdiv_id < 0)
> +		return 0;
> +
> +	if (!is_valid_etdm_dai(dai_id))
> +		return -EINVAL;
> +	etdm_data = afe_priv->dai_priv[dai_id];
> +
> +	ret = get_etdm_reg(dai_id, &etdm_reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (etdm_data->mclk_dir == SND_SOC_CLOCK_OUT)
> +		regmap_set_bits(afe->regmap, etdm_reg.con1,
> +				ETDM_CON1_MCLK_OUTPUT);
> +	else
> +		regmap_clear_bits(afe->regmap, etdm_reg.con1,
> +				  ETDM_CON1_MCLK_OUTPUT);
> +
> +	if (etdm_data->mclk_freq) {
> +		apll = etdm_data->mclk_apll;
> +		apll_clk_id = mt8188_afe_get_mclk_source_clk_id(apll);
> +		if (apll_clk_id < 0)
> +			return apll_clk_id;
> +
> +		/* select apll */
> +		ret = mt8188_afe_set_clk_parent(afe, afe_priv->clk[clk_id],
> +						afe_priv->clk[apll_clk_id]);
> +		if (ret)
> +			return ret;
> +
> +		/* set rate */
> +		ret = mt8188_afe_set_clk_rate(afe, afe_priv->clk[clkdiv_id],
> +					      etdm_data->mclk_freq);

Check ret here...

> +	} else {
> +		if (etdm_data->mclk_dir == SND_SOC_CLOCK_OUT)
> +			dev_dbg(afe->dev, "%s mclk freq = 0\n", __func__);
> +	}
> +

...and return 0 here.

> +	return ret;
> +}
> +

..snip..

> +
> +static int mtk_dai_etdm_hw_params(struct snd_pcm_substream *substream,
> +				  struct snd_pcm_hw_params *params,
> +				  struct snd_soc_dai *dai)
> +{
> +	int ret = 0;
> +	unsigned int rate = params_rate(params);
> +	unsigned int bit_width = params_width(params);
> +	unsigned int channels = params_channels(params);
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct mt8188_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_etdm_priv *mst_etdm_data;
> +	int mst_dai_id;
> +	int slv_dai_id;
> +	int i;
> +
> +	dev_dbg(afe->dev, "%s '%s' period %u-%u\n",
> +		__func__, snd_pcm_stream_str(substream),
> +		params_period_size(params), params_periods(params));
> +
> +	if (is_cowork_mode(dai)) {
> +		mst_dai_id = get_etdm_cowork_master_id(dai);
> +		if (!is_valid_etdm_dai(mst_dai_id))
> +			return -EINVAL;
> +
> +		ret = mtk_dai_etdm_mclk_configure(afe, mst_dai_id);
> +		if (ret)
> +			return ret;
> +
> +		ret = mtk_dai_etdm_configure(afe, rate, channels,
> +					     bit_width, mst_dai_id);
> +		if (ret)
> +			return ret;
> +
> +		mst_etdm_data = afe_priv->dai_priv[mst_dai_id];
> +		for (i = 0; i < mst_etdm_data->cowork_slv_count; i++) {
> +			slv_dai_id = mst_etdm_data->cowork_slv_id[i];
> +			ret = mtk_dai_etdm_configure(afe, rate, channels,
> +						     bit_width, slv_dai_id);
> +			if (ret)
> +				return ret;
> +
> +			ret = mt8188_etdm_sync_mode_configure(afe, slv_dai_id);
> +			if (ret)
> +				return ret;
> +		}
> +	} else {
> +		ret = mtk_dai_etdm_mclk_configure(afe, dai->id);
> +		if (ret)
> +			return ret;
> +
> +		ret = mtk_dai_etdm_configure(afe, rate, channels,
> +					     bit_width, dai->id);

Check return value here...

> +	}
> +

...and return 0 here.

> +	return ret;
> +}
> +
> +static int mtk_dai_etdm_prepare(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct mt8188_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_etdm_priv *mst_etdm_data;
> +	int mst_dai_id;
> +	int slv_dai_id;
> +	int i;
> +	int ret = 0;
> +
> +	if (!is_valid_etdm_dai(dai->id))
> +		return -EINVAL;
> +	mst_etdm_data = afe_priv->dai_priv[dai->id];
> +
> +	dev_dbg(afe->dev, "%s(), dai id %d, prepared %d\n", __func__, dai->id,
> +		mst_etdm_data->is_prepared);
> +
> +	if (mst_etdm_data->is_prepared)
> +		return 0;
> +
> +	mst_etdm_data->is_prepared = true;
> +
> +	if (is_cowork_mode(dai)) {
> +		mst_dai_id = get_etdm_cowork_master_id(dai);
> +		if (!is_valid_etdm_dai(mst_dai_id))
> +			return -EINVAL;
> +		mst_etdm_data = afe_priv->dai_priv[mst_dai_id];
> +
> +		for (i = 0; i < mst_etdm_data->cowork_slv_count; i++) {
> +			slv_dai_id = mst_etdm_data->cowork_slv_id[i];
> +			ret |= mt8188_afe_enable_etdm(afe, slv_dai_id);
> +		}
> +
> +		ret |= mt8188_afe_enable_etdm(afe, mst_dai_id);

OR'ing return values is not an acceptable practice: you should check for error
right after the call and immediately take action if anything wrong happened.

> +	} else {
> +		ret = mt8188_afe_enable_etdm(afe, dai->id);

Same comment as the previous function: check ret here.

> +	}
> +
> +	return ret;
> +}
> +

..snip..

> +
> +static int mtk_dai_hdmitx_dptx_prepare(struct snd_pcm_substream *substream,
> +				       struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct mt8188_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_etdm_priv *etdm_data;
> +	int ret;
> +
> +	if (!is_valid_etdm_dai(dai->id))
> +		return -EINVAL;
> +	etdm_data = afe_priv->dai_priv[dai->id];
> +
> +	dev_dbg(afe->dev, "%s(), dai id %d, prepared %d\n", __func__, dai->id,
> +		etdm_data->is_prepared);
> +
> +	if (etdm_data->is_prepared)
> +		return 0;
> +
> +	etdm_data->is_prepared = true;
> +
> +	/* enable dptx interface */
> +	if (dai->id == MT8188_AFE_IO_DPTX)
> +		regmap_set_bits(afe->regmap, AFE_DPTX_CON, AFE_DPTX_CON_ON);
> +
> +	/* enable etdm_out3 */
> +	ret = mt8188_afe_enable_etdm(afe, dai->id);

You don't need the `ret` variable here...

	return mt8188_afe_enable_etdm(afe, dai->id);

> +
> +	return ret;
> +}
> +

Apart from this, looks good.

Regards,
Angelo

