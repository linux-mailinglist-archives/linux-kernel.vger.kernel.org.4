Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B26B616118
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiKBKoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKBKoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:44:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81831A3AC;
        Wed,  2 Nov 2022 03:44:18 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4017D660293F;
        Wed,  2 Nov 2022 10:44:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667385857;
        bh=7I+QHBWjXxivPsU0CF0EiLAC03a7MhfEqs5o1FOXxLg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Oo6F5aYwAxPLUDE6xKJsRgiC+PQFAQuTrDNMda3YvUKBGll07jsH1+EM/kTbSf22U
         j10DtNLnmGUlhUvWDrSZkorI/NpOfHVO0vWtqrm7NSsL5mbzKhps6V4qECh9JY9e/9
         a6RpeAK9jnl67NtEolIn/+gnsG1ELYQwZxLKOrTIHoyAXxrTjZBUWtj11NYEfOC6Pn
         v8fZ7Vd7cN3jdAx7iRX5uq+mRASp/ScSkiKsT3jup1KOF5z1jCaQDEZYHTHQCFAyAB
         7d+ZM0UKJZZrisQIeC9CCTb4EVzUWIyF7b6EJQLm8axoBLKoYUzoI9BqctX6SJUmrM
         SSAkREHo5cTow==
Message-ID: <549e1ff6-821a-1c26-0a4f-021bed27b093@collabora.com>
Date:   Wed, 2 Nov 2022 11:44:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5 2/2] ASoC: mediatek: mt8186-rt5682: Modify machine
 driver for two DMICs case
Content-Language: en-US
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
References: <20221031122224.1846221-1-ajye_huang@compal.corp-partner.google.com>
 <20221031122224.1846221-3-ajye_huang@compal.corp-partner.google.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221031122224.1846221-3-ajye_huang@compal.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 31/10/22 13:22, Ajye Huang ha scritto:
> Having two DMICs, a front DMIC and a Rear DMIC,
> but only host audio input AUX port0 is used for these two Dmics.
> A "dmic-gpios" property is used for a mixer control to switch
> the dmic signal source between the Front and Rear Dmic.
> 
> Refer to this one as an example,
> commit 3cfbf07c6d27
> ("ASoC: qcom: sc7180: Modify machine driver for 2mic")
> 
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
>   .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     | 102 +++++++++++++++++-
>   1 file changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
> index 2414c5b77233..75351734464c 100644
> --- a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
> +++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
> @@ -7,6 +7,8 @@
>   // Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
>   //
>   
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/input.h>
>   #include <linux/module.h>
>   #include <linux/of_device.h>
> @@ -39,6 +41,8 @@
>   
>   struct mt8186_mt6366_rt1019_rt5682s_priv {
>   	struct snd_soc_jack headset_jack, hdmi_jack;
> +	struct gpio_desc *dmic_sel;
> +	int dmic_switch;
>   };
>   
>   /* Headset jack detection DAPM pins */
> @@ -68,6 +72,94 @@ static struct snd_soc_codec_conf mt8186_mt6366_rt1019_rt5682s_codec_conf[] = {
>   	},
>   };
>   
> +static int dmic_get(struct snd_kcontrol *kcontrol,
> +		    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
> +	struct mtk_soc_card_data *soc_card_data =
> +		snd_soc_card_get_drvdata(dapm->card);
> +	struct mt8186_mt6366_rt1019_rt5682s_priv *priv = soc_card_data->mach_priv;
> +
> +	ucontrol->value.integer.value[0] = priv->dmic_switch;
> +	return 0;
> +}
> +
> +static int dmic_set(struct snd_kcontrol *kcontrol,
> +		    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
> +	struct mtk_soc_card_data *soc_card_data =
> +		snd_soc_card_get_drvdata(dapm->card);
> +	struct mt8186_mt6366_rt1019_rt5682s_priv *priv = soc_card_data->mach_priv;
> +
> +	priv->dmic_switch = ucontrol->value.integer.value[0];
> +	if (priv->dmic_sel) {
> +		gpiod_set_value(priv->dmic_sel, priv->dmic_switch);
> +		dev_info(dapm->card->dev, "dmic_set_value %d\n",
> +			 priv->dmic_switch);
> +	}
> +	return 0;
> +}
> +
> +static const char * const dmic_mux_text[] = {
> +	"FrontMic",
> +	"RearMic",

Why are the two words joined?
s/FrontMic/Front Mic/g
s/RearMic/Rear Mic/g

Like that, we keep it consistent with the naming that was given in the commit
that you mentioned in the commit description.

Regards,
Angelo
