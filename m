Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32CB6816C4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbjA3Qp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbjA3Qpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:45:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66CC17F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675097150; x=1706633150;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bzhlMhBRkOUmPrjpCdDnzzR+fFMipbr7i6IM2UEnVds=;
  b=KpcvZNwIQoU+YGFXSKaeEVsPAkR4aCSIlAF/8B6MC1y5GUXBV/nXDNkn
   XsVt890CtdXuKpmy/phReQ4cAQusJxcX+ksPznFi4VE4BsPSvKuCv3sRJ
   g+WTqWuu8rXsK29jxDA/umomOA1rsEPhscKQKGGa6Qv4a5zSlaVb0Xn3K
   knn25FX0YiYqa2TA3TJw0f6BygV9SWb25Dx5CFVfN1TnQBHrGKC3iCyDG
   Dyi6ZuaUSWEwV1ghF6Uyumob7wZ2qzwc3o82jHe+TFk1QLBieLa5dxo6y
   RujehOM78aD+tsvAGZ9oD1OgdW1S+kuTG4CO4bFHFOXJSOJcq6CqTu0bX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="307260833"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="307260833"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:45:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="732763607"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="732763607"
Received: from inuber-mobl5.amr.corp.intel.com (HELO [10.212.58.60]) ([10.212.58.60])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:45:49 -0800
Message-ID: <c7651420-0233-7c18-f9b5-2350632035d1@linux.intel.com>
Date:   Mon, 30 Jan 2023 10:33:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v3 4/8] ASoC: cs42l42: Separate ASP config from PLL config
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
 <20230127165111.3010960-5-sbinding@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230127165111.3010960-5-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/23 10:51, Stefan Binding wrote:
> From: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> Setup of the ASP (audio serial port) was being done as a side-effect of
> cs42l42_pll_config() and forces a restriction on the ratio of sample_rate
> to bit_clock that is invalid for Soundwire.
> 
> Move the ASP setup into a dedicated function.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/codecs/cs42l42.c | 81 +++++++++++++++++++++-----------------
>  sound/soc/codecs/cs42l42.h |  1 -
>  2 files changed, 44 insertions(+), 38 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
> index 939f8bcc222c0..d81c6eb1c1e59 100644
> --- a/sound/soc/codecs/cs42l42.c
> +++ b/sound/soc/codecs/cs42l42.c
> @@ -658,7 +658,6 @@ static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int
>  {
>  	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
>  	int i;
> -	u32 fsync;
>  
>  	/* Don't reconfigure if there is an audio stream running */
>  	if (cs42l42->stream_use) {
> @@ -684,40 +683,6 @@ static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int
>  					(pll_ratio_table[i].mclk_int !=
>  					24000000)) <<
>  					CS42L42_INTERNAL_FS_SHIFT);
> -
> -			/* Set up the LRCLK */
> -			fsync = clk / cs42l42->srate;
> -			if (((fsync * cs42l42->srate) != clk)
> -				|| ((fsync % 2) != 0)) {
> -				dev_err(component->dev,
> -					"Unsupported sclk %d/sample rate %d\n",
> -					clk,
> -					cs42l42->srate);
> -				return -EINVAL;
> -			}
> -			/* Set the LRCLK period */
> -			snd_soc_component_update_bits(component,
> -					CS42L42_FSYNC_P_LOWER,
> -					CS42L42_FSYNC_PERIOD_MASK,
> -					CS42L42_FRAC0_VAL(fsync - 1) <<
> -					CS42L42_FSYNC_PERIOD_SHIFT);
> -			snd_soc_component_update_bits(component,
> -					CS42L42_FSYNC_P_UPPER,
> -					CS42L42_FSYNC_PERIOD_MASK,
> -					CS42L42_FRAC1_VAL(fsync - 1) <<
> -					CS42L42_FSYNC_PERIOD_SHIFT);
> -			/* Set the LRCLK to 50% duty cycle */
> -			fsync = fsync / 2;
> -			snd_soc_component_update_bits(component,
> -					CS42L42_FSYNC_PW_LOWER,
> -					CS42L42_FSYNC_PULSE_WIDTH_MASK,
> -					CS42L42_FRAC0_VAL(fsync - 1) <<
> -					CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
> -			snd_soc_component_update_bits(component,
> -					CS42L42_FSYNC_PW_UPPER,
> -					CS42L42_FSYNC_PULSE_WIDTH_MASK,
> -					CS42L42_FRAC1_VAL(fsync - 1) <<
> -					CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
>  			if (pll_ratio_table[i].mclk_src_sel == 0) {
>  				/* Pass the clock straight through */
>  				snd_soc_component_update_bits(component,
> @@ -809,6 +774,46 @@ static void cs42l42_src_config(struct snd_soc_component *component, unsigned int
>  				      fs << CS42L42_CLK_OASRC_SEL_SHIFT);
>  }
>  
> +static int cs42l42_asp_config(struct snd_soc_component *component,
> +			      unsigned int sclk, unsigned int sample_rate)
> +{
> +	u32 fsync = sclk / sample_rate;
> +
> +	/* Set up the LRCLK */
> +	if (((fsync * sample_rate) != sclk) || ((fsync % 2) != 0)) {
> +		dev_err(component->dev,
> +			"Unsupported sclk %d/sample rate %d\n",
> +			sclk,
> +			sample_rate);
> +		return -EINVAL;
> +	}
> +	/* Set the LRCLK period */
> +	snd_soc_component_update_bits(component,
> +				      CS42L42_FSYNC_P_LOWER,
> +				      CS42L42_FSYNC_PERIOD_MASK,
> +				      CS42L42_FRAC0_VAL(fsync - 1) <<
> +				      CS42L42_FSYNC_PERIOD_SHIFT);
> +	snd_soc_component_update_bits(component,
> +				      CS42L42_FSYNC_P_UPPER,
> +				      CS42L42_FSYNC_PERIOD_MASK,
> +				      CS42L42_FRAC1_VAL(fsync - 1) <<
> +				      CS42L42_FSYNC_PERIOD_SHIFT);
> +	/* Set the LRCLK to 50% duty cycle */
> +	fsync = fsync / 2;
> +	snd_soc_component_update_bits(component,
> +				      CS42L42_FSYNC_PW_LOWER,
> +				      CS42L42_FSYNC_PULSE_WIDTH_MASK,
> +				      CS42L42_FRAC0_VAL(fsync - 1) <<
> +				      CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
> +	snd_soc_component_update_bits(component,
> +				      CS42L42_FSYNC_PW_UPPER,
> +				      CS42L42_FSYNC_PULSE_WIDTH_MASK,
> +				      CS42L42_FRAC1_VAL(fsync - 1) <<
> +				      CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
> +
> +	return 0;
> +}
> +
>  static int cs42l42_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
>  {
>  	struct snd_soc_component *component = codec_dai->component;
> @@ -904,8 +909,6 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
>  	unsigned int bclk;
>  	int ret;
>  
> -	cs42l42->srate = params_rate(params);
> -
>  	if (cs42l42->bclk_ratio) {
>  		/* machine driver has set the BCLK/samp-rate ratio */
>  		bclk = cs42l42->bclk_ratio * params_rate(params);
> @@ -966,6 +969,10 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
>  	if (ret)
>  		return ret;
>  
> +	ret = cs42l42_asp_config(component, bclk, sample_rate);
> +	if (ret)
> +		return ret;
> +
>  	cs42l42_src_config(component, sample_rate);
>  
>  	return 0;
> diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
> index a721366641127..17aab06adc8e6 100644
> --- a/sound/soc/codecs/cs42l42.h
> +++ b/sound/soc/codecs/cs42l42.h
> @@ -36,7 +36,6 @@ struct  cs42l42_private {
>  	int pll_config;
>  	u32 sclk;
>  	u32 bclk_ratio;
> -	u32 srate;
>  	u8 plug_state;
>  	u8 hs_type;
>  	u8 ts_inv;
