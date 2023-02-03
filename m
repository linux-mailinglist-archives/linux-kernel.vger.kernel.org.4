Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DF6689DED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjBCPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjBCPPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:15:31 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8530C9B6E1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675437196; x=1706973196;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W3Jq52wmDkGkiCNS8FGkdRczTKkbx7NwWGh/ueXpCRs=;
  b=fje2GrsDm+3mSjMtdSproXIrX0xmZSSifPHizsXGmILMvsgvPoiA9+Sn
   WgBUxhE+c4jZ3KOtPrmWnhxjGDsHcqrjeSPubNaU5nytr2u5ilSBFPDEA
   HqHQqZ9gKMRKDDQaJo7otlHUw7hNRpQHNGeo7cjxdVIoRPeHs0qrmV3pJ
   vtdjc0d8wk/Cn1shH9iAAF3aui4fxB6lSCeMH7DkZDG8dew2FQla7J3bO
   hPW16nlmkO28ZxzEWUO2u0LltH2hOcGLq5E9MIYYyyoxUBrBgirYjkvWm
   5Wm6mW038hAXE4BWm1aX2gn/3Qw/0GhPd61czSshz691UWpmp9fh4iPsp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="330898267"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="330898267"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 07:11:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="729290035"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="729290035"
Received: from albuitra-desk.amr.corp.intel.com (HELO [10.209.172.145]) ([10.209.172.145])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 07:11:40 -0800
Message-ID: <854f131d-3777-2728-d2fc-4f3cf315a80d@linux.intel.com>
Date:   Fri, 3 Feb 2023 08:28:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] ASoC: SOF: fix intel-soundwire link failure
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        sound-open-firmware@alsa-project.org
References: <20230202102247.806749-1-arnd@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230202102247.806749-1-arnd@kernel.org>
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



On 2/2/23 04:22, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> My randconfig build setup ran into a rare build failure with
> 
> CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=y
> CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE=m
> CONFIG_SOUNDWIRE=y
> CONFIG_SOUNDWIRE_INTEL=m
> CONFIG_SND_SOC_SOF_HDA=y
> CONFIG_SND_SOC_SOF_INTEL_TGL=y
> 
> x86_64-linux-ld: sound/soc/sof/intel/hda.o: in function `hda_init_caps':
> hda.c:(.text+0x691): undefined reference to `sdw_intel_cnl_hw_ops'
> x86_64-linux-ld: hda.c:(.text+0x6f2): undefined reference to `sdw_intel_probe'
> x86_64-linux-ld: sound/soc/sof/intel/hda.o: in function `hda_sdw_startup':
> hda.c:(.text+0x1c40): undefined reference to `sdw_intel_startup'
> x86_64-linux-ld: sound/soc/sof/intel/hda.o: in function `hda_sdw_process_wakeen':
> hda.c:(.text+0x1cb6): undefined reference to `sdw_intel_process_wakeen_event'
> x86_64-linux-ld: sound/soc/sof/intel/hda.o: in function `hda_dsp_interrupt_thread':
> hda.c:(.text+0x1d67): undefined reference to `sdw_intel_thread'
> x86_64-linux-ld: sound/soc/sof/intel/hda.o: in function `hda_dsp_remove':
> hda.c:(.text+0x2655): undefined reference to `sdw_intel_exit'
> 
> My best understanding is that the definition of
> SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE was intended to avoid this
> problem, but got it wrong for the SND_SOC_SOF_INTEL_SOUNDWIRE=m case,
> where the 'select' is meant to set SOUNDWIRE_INTEL to the value of
> SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE rather than the intersection of
> SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE and SND_SOC_SOF_INTEL_SOUNDWIRE.
> 
> Change the condition to check for SND_SOC_SOF_INTEL_SOUNDWIRE to be a
> boolean rather than a tristate expression in order to propagate this
> as intended.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I could not figure out if this is a recent regression or if the
> problem has existed for a long time and is just really hard to
> trigger. I first saw it on linux-next-20230201.
> ---
>  sound/soc/sof/intel/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
> index 36a0e2bf30ff..715ba8a7f2f8 100644
> --- a/sound/soc/sof/intel/Kconfig
> +++ b/sound/soc/sof/intel/Kconfig
> @@ -322,8 +322,8 @@ config SND_SOC_SOF_HDA_PROBES
>  
>  config SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
>  	tristate
> -	select SOUNDWIRE_INTEL if SND_SOC_SOF_INTEL_SOUNDWIRE
> -	select SND_INTEL_SOUNDWIRE_ACPI if SND_SOC_SOF_INTEL_SOUNDWIRE
> +	select SOUNDWIRE_INTEL if SND_SOC_SOF_INTEL_SOUNDWIRE != n
> +	select SND_INTEL_SOUNDWIRE_ACPI if SND_SOC_SOF_INTEL_SOUNDWIRE != n

I think the problem has been around for a very long time. I can't figure
out what we tried to fix and why the Kconfig is written this way.

We already have this:

config SND_SOC_SOF_INTEL_SOUNDWIRE
	tristate "SOF support for SoundWire"
	default SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
	depends on SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
	depends on ACPI && SOUNDWIRE
	depends on !(SOUNDWIRE=m && SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=y)

We're doing something wrong here if both of the Kconfigs make references
to the value of the other.

The only requirement here is that we want to be able to build if
SoundWire is not enabled. We have a similar requirement for HDaudio, but
for some reason it's only a boolean for HDaudio and a tristate for
SoundWire. I have no idea if it was intentional or not, it's been too
much time already since we looked at this....
