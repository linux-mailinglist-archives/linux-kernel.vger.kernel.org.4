Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E0C60EA68
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbiJZUmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiJZUmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:42:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1A19F35E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666816922; x=1698352922;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mOfBCf6XTP3bipjZJg8e50uIHjhKswePx13nDq9hHWY=;
  b=alAClkq7/jN4paESihaKR+DbiVPmOobhariVpXD1mdLatcg78PMu1csQ
   GA+ubOVwuV4MomoPEPBd3UH8IsgiMR2Is3umuWuZ2xbpyDO+9ryubSQ2k
   8Qw2L5cf5r/J+j3Q4k86tt9yMk7tgM38BUazmna1vrl5roQeXYl2K7BVO
   /f/bjG3ymEEMj+evvajtpA/5U2eq7P/jB9qIFlF3zk2bRpBNeELsNqWJ2
   NdTdvwfpb8OR0y3+TLdR2X1sMwSv4vePLeMw/cbKaMg5hoc8gKMhasRkZ
   znqw6M2+ameUrOdjX+HMFQMPgzvKGtHtZ1mhYnwoekKXBQdsM1Khm8Q2l
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="288450849"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="288450849"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 13:42:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="610103325"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="610103325"
Received: from bcoan-mobl2.amr.corp.intel.com (HELO [10.209.189.197]) ([10.209.189.197])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 13:42:00 -0700
Message-ID: <6916c126-c710-330a-ffcd-50dd3cdc47d3@linux.intel.com>
Date:   Wed, 26 Oct 2022 15:34:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] ASoC: Intel: sof_rt5682: quirk auto detection
Content-Language: en-US
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     "balamurugan . c" <balamurugan.c@intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Chao Song <chao.song@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Gongjun Song <gongjun.song@intel.com>,
        linux-kernel@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Ajye Huang <ajye.huang@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Yong Zhi <yong.zhi@intel.com>
References: <20221026071409.3235144-1-brent.lu@intel.com>
 <20221026071409.3235144-3-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221026071409.3235144-3-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/22 02:14, Brent Lu wrote:
> To get rid of increasing board_ids array with similar quirks for every
> new platform, we implement a special board config 'sof_rt5682_auto' to
> compose quirk value at runtime. It detects SoC and amplifier type to
> determine the quirk value.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>  sound/soc/intel/boards/sof_rt5682.c           | 173 +++++++-----------
>  .../intel/common/soc-acpi-intel-adl-match.c   |  12 +-
>  .../intel/common/soc-acpi-intel-jsl-match.c   |   6 +-
>  .../intel/common/soc-acpi-intel-tgl-match.c   |   6 +-
>  4 files changed, 77 insertions(+), 120 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index 2358be208c1f..2dfccbaae53c 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -60,6 +60,7 @@
>  #define SOF_MAX98390_SPEAKER_AMP_PRESENT	BIT(24)
>  #define SOF_MAX98390_TWEETER_SPEAKER_PRESENT	BIT(25)
>  #define SOF_RT1019_SPEAKER_AMP_PRESENT	BIT(26)
> +#define SOF_RT5682_AUTO_DETECT	BIT(27)
>  
>  
>  /* Default: MCLK on, MCLK 19.2M, SSP0  */
> @@ -838,6 +839,65 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  	return NULL;
>  }
>  
> +static const struct {
> +	const u8 id[ACPI_ID_LEN];
> +	unsigned long quirk;
> +} spk_quirk_map[] = {
> +	{.id = "10EC1011", .quirk = SOF_RT1011_SPEAKER_AMP_PRESENT},
> +	{.id = "10EC1015", .quirk = SOF_RT1015_SPEAKER_AMP_PRESENT},
> +	{.id = "RTL1015", .quirk = SOF_RT1015P_SPEAKER_AMP_PRESENT},
> +	{.id = "RTL1019", .quirk = SOF_RT1019_SPEAKER_AMP_PRESENT},
> +	{.id = "MX98357A", .quirk = 0},
> +	{.id = "MX98360A", .quirk = SOF_MAX98360A_SPEAKER_AMP_PRESENT},
> +	{.id = "MX98373", .quirk = SOF_MAX98373_SPEAKER_AMP_PRESENT},
> +	{.id = "MX98390", .quirk = SOF_MAX98390_SPEAKER_AMP_PRESENT},
> +};
> +
> +static unsigned long sof_audio_auto_detect(struct device *dev)
> +{
> +	unsigned long quirk = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(spk_quirk_map); i++) {
> +		if (!acpi_dev_present(spk_quirk_map[i].id, NULL, -1))
> +			continue;
> +
> +		dev_dbg(dev, "%s detected\n", spk_quirk_map[i].id);
> +		quirk |= spk_quirk_map[i].quirk;
> +		quirk |= SOF_SPEAKER_AMP_PRESENT;
> +		break;
> +	}
> +
> +	if (soc_intel_is_jsl()) {
> +		quirk |= SOF_RT5682_MCLK_EN |
> +			 SOF_RT5682_MCLK_24MHZ |
> +			 SOF_RT5682_NUM_HDMIDEV(3) |
> +			 SOF_RT5682_SSP_CODEC(0);
> +
> +		if (quirk & SOF_SPEAKER_AMP_PRESENT)
> +			quirk |= SOF_RT5682_SSP_AMP(1);
> +	} else if (soc_intel_is_tgl()) {
> +		quirk |= SOF_RT5682_MCLK_EN |
> +			 SOF_RT5682_NUM_HDMIDEV(4) |
> +			 SOF_RT5682_SSP_CODEC(0);
> +
> +		if (quirk & SOF_SPEAKER_AMP_PRESENT)
> +			quirk |= SOF_RT5682_SSP_AMP(1);

This is a bit confusing: this quirk does not work for Volteer

	{
		.callback = sof_rt5682_quirk_cb,
		.matches = {
			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Volteer"),
			DMI_MATCH(DMI_OEM_STRING, "AUDIO-MAX98373_ALC5682I_I2S_UP4"),
		},
		.driver_data = (void *)(SOF_RT5682_MCLK_EN |
					SOF_RT5682_SSP_CODEC(0) |
					SOF_SPEAKER_AMP_PRESENT |
					SOF_MAX98373_SPEAKER_AMP_PRESENT |
					SOF_RT5682_SSP_AMP(2) |
					SOF_RT5682_NUM_HDMIDEV(4)),
	},

Same for Brya and all usages of SSP_AMP(2)


> -	{
> -		.name = "adl_rt1019_rt5682s",
> -		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
> -					SOF_RT5682_SSP_CODEC(0) |
> -					SOF_RT5682S_HEADPHONE_CODEC_PRESENT |

and HEADPHONE_CODEC_PRESENT is not handled either.

> -					SOF_SPEAKER_AMP_PRESENT |
> -					SOF_RT1019_SPEAKER_AMP_PRESENT |
> -					SOF_RT5682_SSP_AMP(1) |
> -					SOF_RT5682_NUM_HDMIDEV(4)),
> -	},

Overall I doubt that the SOC alone can tell you what the quirk is.

Maybe it's a default to avoid repeats of the same baseline
configuration, but there's not much else that can be infer from an SOC
definition in light of the creativity of our hardware friends who
routinely swap interfaces.
