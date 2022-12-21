Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D225D6534A3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiLURKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLURKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:10:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F55C1B79B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671642638; x=1703178638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wka9nixoQhSQpZMewUy1mTEp3oCjGne3Bir7NjGErYw=;
  b=JpQPnGs0Sr6sz57M9OkugNtHaJWy6aD/RQ2ROZ42AHLfcEiX+qIStraC
   PoR+Vir8AAjWH9/clTpzp4MzU1XOhUv6ie6hAEnEsRaZrt1bsQOsyGoJc
   OxC0VA3Rw4z1di0HKVxuthVMtCR8OabU02Li+q4GA3eV1BSQAxaDjOLVz
   xgJytBCQNvQekKtgriQPTs5a67Sj6jAI/mLpQsM92atT2lbEMiKOxINli
   n2BAzjU7Pu2tkyUs+R4LwTPm5R+/fEij0ZH+dkAwc2JQrAopdJv20lru1
   i+DPxJQMC1rkSfdeNlu7AjOg/YxTYWT58mX7GhDuvqZMBJ7Tiv9R2TFXR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="317562111"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="317562111"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 09:08:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="720009149"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="720009149"
Received: from sgeiser-mobl.amr.corp.intel.com (HELO [10.212.42.29]) ([10.212.42.29])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 09:08:39 -0800
Message-ID: <3917a0cf-20bb-2e7f-60a8-d7ec0069d8fa@linux.intel.com>
Date:   Wed, 21 Dec 2022 09:42:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] ASoC: Intel: fix sof-nau8825 link failure
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        "balamurugan.c" <balamurugan.c@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20221221132559.2402341-1-arnd@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221221132559.2402341-1-arnd@kernel.org>
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



On 12/21/22 07:25, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The snd-soc-sof_nau8825.ko module fails to link unless the
> sof_realtek_common support is also enabled:
> 
> ERROR: modpost: "sof_rt1015p_codec_conf" [sound/soc/intel/boards/snd-soc-sof_nau8825.ko] undefined!
> ERROR: modpost: "sof_rt1015p_dai_link" [sound/soc/intel/boards/snd-soc-sof_nau8825.ko] undefined!
> 
> Fixes: 8d0872f6239f ("ASoC: Intel: add sof-nau8825 machine driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/intel/boards/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index a472de1909f4..9aee729c2406 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -558,6 +558,7 @@ config SND_SOC_INTEL_SOF_NAU8825_MACH
>  	select SND_SOC_HDAC_HDMI
>  	select SND_SOC_INTEL_HDA_DSP_COMMON
>  	select SND_SOC_INTEL_SOF_MAXIM_COMMON
> +	select SND_SOC_INTEL_SOF_REALTEK_COMMON
>  	help
>  	   This adds support for ASoC machine driver for SOF platforms
>  	   with nau8825 codec.
