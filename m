Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7981B6485F7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiLIPwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiLIPwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:52:36 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2FCF2E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670601154; x=1702137154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LaYjN6d7ULt99N+hp7NlDcDCUD1oPX2+XJgA2FoWXVc=;
  b=aTTqj+r/LlNJCafAN2sZunpxRq6nQBvzD3SxiU4eSRgvPFm4XqYyxPSu
   Zxn7cJNBrh6bN96pGXwKx/cMylMRNP0e+PjXBiy/E3ps8M1SLle0FoN9z
   AcrYbVMdedjW3KYdGRjFy5aDFy+SshJAylvI3EoJE9EflaSQCMOsuqLao
   JchaBMGsXY0mbTMdVBoXVyTK57Vixwx+hFF20WGl6ISZV7ufBGR42+dK+
   VJZz5o36ngCk+B80bM915HcJoN3u+694Qg1MPzhuFoGIu6eb/RLvpOOtD
   hry1Zw/pfYaATa7AssNHOuqVD6edR7EWmKrggKNRHh9hLI+TqK9wL6pNs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="297837821"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="297837821"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 07:52:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="754072080"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="754072080"
Received: from bdmeredi-mobl2.amr.corp.intel.com (HELO [10.212.15.195]) ([10.212.15.195])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 07:52:32 -0800
Message-ID: <eca17001-93ff-d379-1ab2-2927f1831e78@linux.intel.com>
Date:   Fri, 9 Dec 2022 09:52:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v1] ASoC: Intel: sof_nau8825: add support for nau8825 with
 amp nau8318
Content-Language: en-US
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org
References: <20221209150503.11875-1-ajye_huang@compal.corp-partner.google.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221209150503.11875-1-ajye_huang@compal.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/22 09:05, Ajye Huang wrote:
> This patch adds the driver data for two nau8318 speaker amplifiers on
> SSP1 and nau8825 on SSP0 for ADL platform.
> And reusing max98360's topology since DAI setting could be leveraged.
> 
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
>  sound/soc/intel/boards/Kconfig                |  1 +
>  sound/soc/intel/boards/sof_nau8825.c          | 23 +++++++++++++++++++
>  .../intel/common/soc-acpi-intel-adl-match.c   | 12 ++++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index a472de1909f4..3f68e9edd853 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -554,6 +554,7 @@ config SND_SOC_INTEL_SOF_NAU8825_MACH
>  	select SND_SOC_RT1015P
>  	select SND_SOC_MAX98373_I2C
>  	select SND_SOC_MAX98357A
> +	select SND_SOC_NAU8315

This looks inconsistent with the commit message. There are separate
Kconfigs for different codecs.

SND_SOC_NAU8315
SND_SOC_NAU8825

Which is it?

>  	select SND_SOC_DMIC
>  	select SND_SOC_HDAC_HDMI
>  	select SND_SOC_INTEL_HDA_DSP_COMMON
> diff --git a/sound/soc/intel/boards/sof_nau8825.c b/sound/soc/intel/boards/sof_nau8825.c
> index 27880224359d..0936450be153 100644
> --- a/sound/soc/intel/boards/sof_nau8825.c
> +++ b/sound/soc/intel/boards/sof_nau8825.c
> @@ -48,6 +48,7 @@
>  #define SOF_MAX98373_SPEAKER_AMP_PRESENT	BIT(15)
>  #define SOF_MAX98360A_SPEAKER_AMP_PRESENT	BIT(16)
>  #define SOF_RT1015P_SPEAKER_AMP_PRESENT	BIT(17)
> +#define SOF_NAU8318_SPEAKER_AMP_PRESENT	BIT(18)
>  
>  static unsigned long sof_nau8825_quirk = SOF_NAU8825_SSP_CODEC(0);
>  
> @@ -338,6 +339,13 @@ static struct snd_soc_dai_link_component rt1019p_component[] = {
>  	}
>  };
>  
> +static struct snd_soc_dai_link_component nau8318_components[] = {
> +	{
> +		.name = "NVTN2012:00",

Deep sigh...

This ACPI HID is already used to match with the 8815, so this is not
going to work if we confuse two independent drivers...

sound/soc/codecs/nau8315.c:

#ifdef CONFIG_ACPI
static const struct acpi_device_id nau8315_acpi_match[] = {
	{ "NVTN2010", 0 },
	{ "NVTN2012", 0},
	{},
};
MODULE_DEVICE_TABLE(acpi, nau8315_acpi_match);
#endif

How does this identify a NAU8825?


> +		.dai_name = "nau8315-hifi",

and again this makes a reference to 8815.

I will stop the review here.

NAK for this v1. Please clarify which codec you are using and make sure
all references are consistent.


> +	}
> +};
> +
>  static struct snd_soc_dai_link_component dummy_component[] = {
>  	{
>  		.name = "snd-soc-dummy",
> @@ -486,6 +494,11 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  			max_98360a_dai_link(&links[id]);
>  		} else if (sof_nau8825_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT) {
>  			sof_rt1015p_dai_link(&links[id]);
> +		} else if (sof_nau8825_quirk &
> +				SOF_NAU8318_SPEAKER_AMP_PRESENT) {
> +			links[id].codecs = nau8318_components;
> +			links[id].num_codecs = ARRAY_SIZE(nau8318_components);
> +			links[id].init = speaker_codec_init;
>  		} else {
>  			goto devm_err;
>  		}
> @@ -657,6 +670,16 @@ static const struct platform_device_id board_ids[] = {
>  					SOF_BT_OFFLOAD_SSP(2) |
>  					SOF_SSP_BT_OFFLOAD_PRESENT),
>  	},
> +	{
> +		.name = "adl_nau8318_nau8825",
> +		.driver_data = (kernel_ulong_t)(SOF_NAU8825_SSP_CODEC(0) |
> +					SOF_SPEAKER_AMP_PRESENT |
> +					SOF_NAU8318_SPEAKER_AMP_PRESENT |
> +					SOF_NAU8825_SSP_AMP(1) |
> +					SOF_NAU8825_NUM_HDMIDEV(4) |
> +					SOF_BT_OFFLOAD_SSP(2) |
> +					SOF_SSP_BT_OFFLOAD_PRESENT),
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(platform, board_ids);
> diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> index 60aee56f94bd..282b9c966ce6 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> @@ -450,6 +450,11 @@ static const struct snd_soc_acpi_codecs adl_lt6911_hdmi = {
>  	.codecs = {"INTC10B0"}
>  };
>  
> +static const struct snd_soc_acpi_codecs adl_nau8318_amp = {
> +	.num_codecs = 1,
> +	.codecs = {"NVTN2012"}
> +};
> +
>  struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>  	{
>  		.comp_ids = &adl_rt5682_rt5682s_hp,
> @@ -507,6 +512,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>  		.quirk_data = &adl_rt1015p_amp,
>  		.sof_tplg_filename = "sof-adl-rt1015-nau8825.tplg",
>  	},
> +	{
> +		.id = "10508825",
> +		.drv_name = "adl_nau8318_nau8825",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &adl_nau8318_amp,
> +		.sof_tplg_filename = "sof-adl-max98360a-nau8825.tplg",
> +	},
>  	{
>  		.id = "10508825",
>  		.drv_name = "sof_nau8825",
