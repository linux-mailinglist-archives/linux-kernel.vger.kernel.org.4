Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267AC5F3FFC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiJDJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiJDJlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:41:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3CA58B55;
        Tue,  4 Oct 2022 02:37:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1CBA76601A43;
        Tue,  4 Oct 2022 10:37:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664876253;
        bh=JcZcxWfPtp/23nmDfJdl1YuwXmFYJ/qI2LMQEzf65QY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jlgya9Zm/Vh1dYsussQ09jXNPAVV7p5mi6CrthUPRTS66JwOHH4vw2kaX4ywJOZS7
         FUi+1nbCXT25mqTzWAYQ9rejTXihRRsruHF8zZ6W9UqWxpg6r+6xKOUESiQSSavu0B
         wq/wzmAdtxqAtGE2mzCdE5WO0ymyEh5E2/5SUcPJmlAypeBPK3C73CBNJ9eGAsV9c/
         jpR+Ludyx80EHeEw9I9QkPzqPUHjQRLIPWi+Zestm8RRNCx1cPEGXEhdkUswQUo8m5
         axNrCUrXrZkIuk/UDp5g5YXGg1WTETU0AueVDqnD+wN0lhkrOJzwurhzeCpxK+gVrP
         ASlLz5i5h8bAQ==
Message-ID: <0d017f04-cad3-fa76-5d2d-daaa052f2e62@collabora.com>
Date:   Tue, 4 Oct 2022 11:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 04/12] ASoC: mediatek: mt8188: support adda in platform
 driver
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        tiwai@suse.com, robh+dt@kernel.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220930145701.18790-1-trevor.wu@mediatek.com>
 <20220930145701.18790-5-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220930145701.18790-5-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/09/22 16:56, Trevor Wu ha scritto:
> Add mt8188 adda dai driver support.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>   sound/soc/mediatek/mt8188/mt8188-dai-adda.c | 639 ++++++++++++++++++++
>   1 file changed, 639 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8188/mt8188-dai-adda.c
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-adda.c b/sound/soc/mediatek/mt8188/mt8188-dai-adda.c
> new file mode 100644
> index 000000000000..ba8f622bb107
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8188/mt8188-dai-adda.c
> @@ -0,0 +1,639 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MediaTek ALSA SoC Audio DAI ADDA Control
> + *
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Bicycle Tsai <bicycle.tsai@mediatek.com>
> + *         Trevor Wu <trevor.wu@mediatek.com>
> + *         Chun-Chia Chiu <chun-chia.chiu@mediatek.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/regmap.h>
> +#include "mt8188-afe-clk.h"
> +#include "mt8188-afe-common.h"
> +#include "mt8188-reg.h"
> +
> +#define ADDA_HIRES_THRES 48000
> +
> +enum {
> +	SUPPLY_SEQ_CLOCK_SEL,
> +	SUPPLY_SEQ_ADDA_DL_ON,
> +	SUPPLY_SEQ_ADDA_MTKAIF_CFG,
> +	SUPPLY_SEQ_ADDA_UL_ON,
> +	SUPPLY_SEQ_ADDA_AFE_ON,
> +};
> +
> +enum {
> +	MTK_AFE_ADDA_DL_RATE_8K = 0,
> +	MTK_AFE_ADDA_DL_RATE_11K = 1,
> +	MTK_AFE_ADDA_DL_RATE_12K = 2,
> +	MTK_AFE_ADDA_DL_RATE_16K = 3,
> +	MTK_AFE_ADDA_DL_RATE_22K = 4,
> +	MTK_AFE_ADDA_DL_RATE_24K = 5,
> +	MTK_AFE_ADDA_DL_RATE_32K = 6,
> +	MTK_AFE_ADDA_DL_RATE_44K = 7,
> +	MTK_AFE_ADDA_DL_RATE_48K = 8,
> +	MTK_AFE_ADDA_DL_RATE_96K = 9,
> +	MTK_AFE_ADDA_DL_RATE_192K = 10,
> +};
> +
> +enum {
> +	MTK_AFE_ADDA_UL_RATE_8K = 0,
> +	MTK_AFE_ADDA_UL_RATE_16K = 1,
> +	MTK_AFE_ADDA_UL_RATE_32K = 2,
> +	MTK_AFE_ADDA_UL_RATE_48K = 3,
> +	MTK_AFE_ADDA_UL_RATE_96K = 4,
> +	MTK_AFE_ADDA_UL_RATE_192K = 5,
> +};
> +
> +enum {
> +	DELAY_DATA_MISO1 = 0,
> +	DELAY_DATA_MISO0 = 1,
> +};
> +
> +struct mtk_dai_adda_priv {
> +	unsigned int dl_rate;
> +	unsigned int ul_rate;
> +};
> +

..snip..

> +
> +static int mt8188_adda_mtkaif_init(struct mtk_base_afe *afe)
> +{
> +	struct mt8188_afe_private *afe_priv = afe->platform_priv;
> +	struct mtkaif_param *param = &afe_priv->mtkaif_params;
> +	int delay_data;
> +	int delay_cycle;
> +	unsigned int mask = 0;
> +	unsigned int val = 0;
> +
> +	/* set rx protocol 2 & mtkaif_rxif_clkinv_adc inverse */
> +	mask = (MTKAIF_RXIF_CLKINV_ADC | MTKAIF_RXIF_PROTOCOL2);
> +	val = (MTKAIF_RXIF_CLKINV_ADC | MTKAIF_RXIF_PROTOCOL2);
> +
> +	regmap_update_bits(afe->regmap, AFE_ADDA_MTKAIF_CFG0, mask, val);

This should be
	regmap_set_bits(afe->regmap, AFE_ADDA_MTKAIF_CFG0,
			MTKAIF_RXIF_CLKINV_ADC | MTKAIF_RXIF_PROTOCOL2);
> +
> +	mask = RG_RX_PROTOCOL2;
> +	val = RG_RX_PROTOCOL2;
> +	regmap_update_bits(afe->regmap, AFE_AUD_PAD_TOP, mask, val);

regmap_set_bits() again

> +
> +	if (!param->mtkaif_calibration_ok) {
> +		dev_info(afe->dev, "%s(), calibration fail\n",  __func__);
> +		return 0;
> +	}
> +
> +	/* set delay for ch1, ch2 */
> +	if (param->mtkaif_phase_cycle[MT8188_MTKAIF_MISO_0] >=
> +	    param->mtkaif_phase_cycle[MT8188_MTKAIF_MISO_1]) {
> +		delay_data = DELAY_DATA_MISO1;
> +		delay_cycle =
> +			param->mtkaif_phase_cycle[MT8188_MTKAIF_MISO_0] -
> +			param->mtkaif_phase_cycle[MT8188_MTKAIF_MISO_1];
> +	} else {
> +		delay_data = DELAY_DATA_MISO0;
> +		delay_cycle =
> +			param->mtkaif_phase_cycle[MT8188_MTKAIF_MISO_1] -
> +			param->mtkaif_phase_cycle[MT8188_MTKAIF_MISO_0];
> +	}
> +
> +	val = 0;
> +	mask = (MTKAIF_RXIF_DELAY_DATA | MTKAIF_RXIF_DELAY_CYCLE_MASK);
> +	val |= MTKAIF_RXIF_DELAY_CYCLE(delay_cycle) &
> +	       MTKAIF_RXIF_DELAY_CYCLE_MASK;

	val = FIELD_PREP(MTKAIF_RXIF_DELAY_CYCLE_MASK, delay_cycle);

> +	val |= delay_data << MTKAIF_RXIF_DELAY_DATA_SHIFT;

	val |= FIELD_PREP(MTKAIF_RXIF_DELAY_DATA, delay_data);

Can you please use bitfield access macros across the entire file (and the others)?
This will both increase human readability and add compile-time checks on register
fields.

> +	regmap_update_bits(afe->regmap, AFE_ADDA_MTKAIF_RX_CFG2, mask, val);
> +
> +	return 0;
> +}
> +
> +static int mtk_adda_mtkaif_cfg_event(struct snd_soc_dapm_widget *w,
> +				     struct snd_kcontrol *kcontrol,
> +				     int event)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +
> +	dev_dbg(afe->dev, "%s(), name %s, event 0x%x\n",
> +		__func__, w->name, event);
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		mt8188_adda_mtkaif_init(afe);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_adda_dl_event(struct snd_soc_dapm_widget *w,
> +			     struct snd_kcontrol *kcontrol,
> +			     int event)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +
> +	dev_dbg(afe->dev, "%s(), name %s, event 0x%x\n",
> +		__func__, w->name, event);
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMD:
> +		/* should delayed 1/fs(smallest is 8k) = 125us before afe off */
> +		usleep_range(125, 135);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static void mtk_adda_ul_mictype(struct mtk_base_afe *afe, bool dmic)
> +{
> +	unsigned int reg = AFE_ADDA_UL_SRC_CON0;
> +	unsigned int val = 0;
> +	unsigned int mask;
> +
> +	mask = (UL_SDM3_LEVEL_CTL | UL_MODE_3P25M_CH1_CTL |
> +		UL_MODE_3P25M_CH2_CTL);

	val = (UL_SDM3_LEVEL_CTL | UL_MODE_3P25M_CH1_CTL | UL_MODE_3P25M_CH2_CTL);

> +
> +	/* turn on dmic, ch1, ch2 */
> +	if (dmic)
		regmap_set_bits(afe->regmap, reg, val);
	else
		regmap_clear_bits(afe->regmap, reg, val);


> +		val = mask;
> +
> +	regmap_update_bits(afe->regmap, reg, mask, val);
> +}
> +

..snip..

> +
> +static int mtk_afe_adc_hires_connect(struct snd_soc_dapm_widget *source,
> +				     struct snd_soc_dapm_widget *sink)
> +{
> +	struct snd_soc_dapm_widget *w = source;
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8188_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_adda_priv *adda_priv;
> +
> +	adda_priv = afe_priv->dai_priv[MT8188_AFE_IO_ADDA];
> +
> +	if (!adda_priv) {
> +		dev_err(afe->dev, "%s adda_priv == NULL", __func__);
> +		return 0;

		return -EINVAL?

> +	}
> +
> +	return (adda_priv->ul_rate > ADDA_HIRES_THRES) ? 1 : 0;

	return !!(adda_priv->ul_rate > ADDA_HIRES_THRES);

> +}
> +
> +static int mtk_afe_dac_hires_connect(struct snd_soc_dapm_widget *source,
> +				     struct snd_soc_dapm_widget *sink)
> +{
> +	struct snd_soc_dapm_widget *w = source;
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8188_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_adda_priv *adda_priv;
> +
> +	adda_priv = afe_priv->dai_priv[MT8188_AFE_IO_ADDA];
> +
> +	if (!adda_priv) {
> +		dev_err(afe->dev, "%s adda_priv == NULL", __func__);
> +		return 0;

same here

> +	}
> +
> +	return (adda_priv->dl_rate > ADDA_HIRES_THRES) ? 1 : 0;
> +}
> +

..snip..

Regards,
Angelo


