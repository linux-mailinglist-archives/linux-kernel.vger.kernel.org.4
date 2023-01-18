Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2741672731
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjARSiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjARSiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:38:17 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C67BB47E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674067096; x=1705603096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=owfFCOcMWokMVQlRyhN3ellpSL+gLwNfYoAZb2lVBYw=;
  b=BzDkXHc6B00M4pA/enRLZwQ0/buLKSc61c7sJWWb6jQkVilDFTFJrQAM
   eM7Ftdcpd0S/0VqvLQ2QE4s2oZZiFUTbgy1DLshv+YYXIkYpL+2hIQkhd
   qvnmPzhJQZPBFTVkKMwdzJEwkH4vQOXUiwOLoVLOchImV/zGtx80SKgMH
   o1IrbgqHNgR6OBz00wngnGguIf/FE8wG5VVgLk6yoinh5shWx5ljGqXYr
   +KE1s8gG/ozGEvR4ZjxjCm+sb+wE0E3/t7K0PlwLSlcMgx28oiOr+nu0b
   N6msIOMsTGJgxSdrbxnprecYel2tp/Jh90Dd5DweOLCJQW4V7hz/WRYGR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="327138522"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="327138522"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:37:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783777262"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="783777262"
Received: from jaibarra-mobl.amr.corp.intel.com (HELO [10.209.131.1]) ([10.209.131.1])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:37:57 -0800
Message-ID: <6fa372b6-f8e7-aaf8-dee4-bc0dde2cb931@linux.intel.com>
Date:   Wed, 18 Jan 2023 10:46:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/8] ASoC: cs42l42: Ensure MCLKint is a multiple of the
 sample rate
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
 <20230118160452.2385494-4-sbinding@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230118160452.2385494-4-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/23 10:04, Stefan Binding wrote:
> From: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> The chosen clocking configuration must give an internal MCLK (MCLKint)
> that is an integer multiple of the sample rate.
> 
> On I2S each of the supported bit clock frequencies can only be generated
> from one sample rate group (either the 44100 or the 48000) so the code
> could use only the bitclock to look up a PLL config.
> 
> The relationship between sample rate and bitclock frequency is more
> complex on Soundwire and so it is possible to set a frame shape to
> generate a bitclock from the "wrong" group. For example 2*147 with a
> 48000 sample rate would give a bitclock of 14112000 which on I2S
> could only be derived from a 44100 sample rate.

The explanation is a bit convoluted, clearly the 147-row configuration
was only meant to be used with 44100 kHz. I don't think 48kHz can be
supported without using the source- or sink-controlled async modes.

This is still a valid change so:

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>



> ---
>  sound/soc/codecs/cs42l42.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
> index 82aa11d6937be..939f8bcc222c0 100644
> --- a/sound/soc/codecs/cs42l42.c
> +++ b/sound/soc/codecs/cs42l42.c
> @@ -653,7 +653,8 @@ static const struct cs42l42_pll_params pll_ratio_table[] = {
>  	{ 24576000, 1, 0x03, 0x40, 0x000000, 0x03, 0x10, 12288000, 128, 1}
>  };
>  
> -static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int clk)
> +static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int clk,
> +			      unsigned int sample_rate)
>  {
>  	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
>  	int i;
> @@ -668,6 +669,10 @@ static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(pll_ratio_table); i++) {
> +		/* MCLKint must be a multiple of the sample rate */
> +		if (pll_ratio_table[i].mclk_int % sample_rate)
> +			continue;
> +
>  		if (pll_ratio_table[i].sclk == clk) {
>  			cs42l42->pll_config = i;
>  
> @@ -893,6 +898,7 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
>  	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
>  	unsigned int channels = params_channels(params);
>  	unsigned int width = (params_width(params) / 8) - 1;
> +	unsigned int sample_rate = params_rate(params);
>  	unsigned int slot_width = 0;
>  	unsigned int val = 0;
>  	unsigned int bclk;
> @@ -956,11 +962,11 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
>  		break;
>  	}
>  
> -	ret = cs42l42_pll_config(component, bclk);
> +	ret = cs42l42_pll_config(component, bclk, sample_rate);
>  	if (ret)
>  		return ret;
>  
> -	cs42l42_src_config(component, params_rate(params));
> +	cs42l42_src_config(component, sample_rate);
>  
>  	return 0;
>  }
