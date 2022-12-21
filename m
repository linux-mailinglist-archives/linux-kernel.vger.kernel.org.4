Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732026534AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiLURK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiLURKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:10:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90969D49
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671642639; x=1703178639;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qLAXeL3HhqFbAsfoXNwMUX1DkaYJt2fY2Wes9uDuZW4=;
  b=bJ6jK0Ykpja79hbpVNFakqdOsJZqNPfojtoyK4GhFx03ozBHQN50/Sle
   hUHki45oqRF96nlO2u4Hfm/iRzssfBkd5KTYVb6/ndP3s6TdWkn/Ze6XT
   QxwaPtt9xhLdtZGkl+zCon7GDXr6JMc/htbdCy3ggk1x56MQ/t7i5PfPr
   WEhc9VRV3vHBYAkWFHl9NPl8ZTBhpase2+Fj5ewtH+kOMaa4n1fX9QKEQ
   W178Ui5ijacshD94znOwUjsvruhtCse31NxflVQV1LMNC+y9nr6rPTFh2
   dH4q0ob0JdPvIVoMjdeG0r2w0LAgcsrJelL+agji04C+Dkf01w9YFnLRE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="317562097"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="317562097"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 09:08:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="720009111"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="720009111"
Received: from sgeiser-mobl.amr.corp.intel.com (HELO [10.212.42.29]) ([10.212.42.29])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 09:08:37 -0800
Message-ID: <9c9c5739-ee6b-a66e-481b-9032d4a52568@linux.intel.com>
Date:   Wed, 21 Dec 2022 09:41:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] ASoC: Intel: sof-nau8825: fix module alias overflow
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org,
        Arnd Bergmann <arnd@arndb.de>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Takashi Iwai <tiwai@suse.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        David Lin <CTLIN0@nuvoton.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org,
        Yong Zhi <yong.zhi@intel.com>
References: <20221221132515.2363276-1-arnd@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221221132515.2363276-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/22 07:24, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The maximum name length for a platform_device_id entry is 20 characters
> including the trailing NUL byte. The sof_nau8825.c file exceeds that,
> which causes an obscure error message:
> 
> sound/soc/intel/boards/snd-soc-sof_nau8825.mod.c:35:45: error: illegal character encoding in string literal [-Werror,-Winvalid-source-encoding]
> MODULE_ALIAS("platform:adl_max98373_nau8825<U+0018><AA>");
>                                                    ^~~~
> include/linux/module.h:168:49: note: expanded from macro 'MODULE_ALIAS'
>                                                 ^~~~~~
> include/linux/module.h:165:56: note: expanded from macro 'MODULE_INFO'
>                                                        ^~~~
> include/linux/moduleparam.h:26:47: note: expanded from macro '__MODULE_INFO'
>                 = __MODULE_INFO_PREFIX __stringify(tag) "=" info
> 
> I could not figure out how to make the module handling robust enough
> to handle this better, but as a quick fix, using slightly shorter
> names that are still unique avoids the build issue.
> 
> Fixes: 8d0872f6239f ("ASoC: Intel: add sof-nau8825 machine driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd, yes unfortunately that keeps on happening. We cleaned-up a
bunch of Chromebook platforms but newer ones have the same long name
issue obviously.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/intel/boards/sof_nau8825.c              | 8 ++++----
>  sound/soc/intel/common/soc-acpi-intel-adl-match.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_nau8825.c b/sound/soc/intel/boards/sof_nau8825.c
> index 27880224359d..009a41fbefa1 100644
> --- a/sound/soc/intel/boards/sof_nau8825.c
> +++ b/sound/soc/intel/boards/sof_nau8825.c
> @@ -618,7 +618,7 @@ static const struct platform_device_id board_ids[] = {
>  
>  	},
>  	{
> -		.name = "adl_rt1019p_nau8825",
> +		.name = "adl_rt1019p_8825",
>  		.driver_data = (kernel_ulong_t)(SOF_NAU8825_SSP_CODEC(0) |
>  					SOF_SPEAKER_AMP_PRESENT |
>  					SOF_RT1019P_SPEAKER_AMP_PRESENT |
> @@ -626,7 +626,7 @@ static const struct platform_device_id board_ids[] = {
>  					SOF_NAU8825_NUM_HDMIDEV(4)),
>  	},
>  	{
> -		.name = "adl_max98373_nau8825",
> +		.name = "adl_max98373_8825",
>  		.driver_data = (kernel_ulong_t)(SOF_NAU8825_SSP_CODEC(0) |
>  					SOF_SPEAKER_AMP_PRESENT |
>  					SOF_MAX98373_SPEAKER_AMP_PRESENT |
> @@ -637,7 +637,7 @@ static const struct platform_device_id board_ids[] = {
>  	},
>  	{
>  		/* The limitation of length of char array, shorten the name */
> -		.name = "adl_mx98360a_nau8825",
> +		.name = "adl_mx98360a_8825",
>  		.driver_data = (kernel_ulong_t)(SOF_NAU8825_SSP_CODEC(0) |
>  					SOF_SPEAKER_AMP_PRESENT |
>  					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
> @@ -648,7 +648,7 @@ static const struct platform_device_id board_ids[] = {
>  
>  	},
>  	{
> -		.name = "adl_rt1015p_nau8825",
> +		.name = "adl_rt1015p_8825",
>  		.driver_data = (kernel_ulong_t)(SOF_NAU8825_SSP_CODEC(0) |
>  					SOF_SPEAKER_AMP_PRESENT |
>  					SOF_RT1015P_SPEAKER_AMP_PRESENT |
> diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> index 60aee56f94bd..1f79fef600ac 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> @@ -474,21 +474,21 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>  	},
>  	{
>  		.id = "10508825",
> -		.drv_name = "adl_rt1019p_nau8825",
> +		.drv_name = "adl_rt1019p_8825",
>  		.machine_quirk = snd_soc_acpi_codec_list,
>  		.quirk_data = &adl_rt1019p_amp,
>  		.sof_tplg_filename = "sof-adl-rt1019-nau8825.tplg",
>  	},
>  	{
>  		.id = "10508825",
> -		.drv_name = "adl_max98373_nau8825",
> +		.drv_name = "adl_max98373_8825",
>  		.machine_quirk = snd_soc_acpi_codec_list,
>  		.quirk_data = &adl_max98373_amp,
>  		.sof_tplg_filename = "sof-adl-max98373-nau8825.tplg",
>  	},
>  	{
>  		.id = "10508825",
> -		.drv_name = "adl_mx98360a_nau8825",
> +		.drv_name = "adl_mx98360a_8825",
>  		.machine_quirk = snd_soc_acpi_codec_list,
>  		.quirk_data = &adl_max98360a_amp,
>  		.sof_tplg_filename = "sof-adl-max98360a-nau8825.tplg",
> @@ -502,7 +502,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>  	},
>  	{
>  		.id = "10508825",
> -		.drv_name = "adl_rt1015p_nau8825",
> +		.drv_name = "adl_rt1015p_8825",
>  		.machine_quirk = snd_soc_acpi_codec_list,
>  		.quirk_data = &adl_rt1015p_amp,
>  		.sof_tplg_filename = "sof-adl-rt1015-nau8825.tplg",
