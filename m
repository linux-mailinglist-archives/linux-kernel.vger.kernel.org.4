Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276C66B5059
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCJSsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCJSsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:48:13 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A7177E2B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678474092; x=1710010092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r03cO5GqkX9M+5ozAIBTo8H/tw88jbZWUChm4xxL/4A=;
  b=Tc5cVSS9YKDVmFiIwgOggxQgi+FL2+6/qzngv0UJNlwH8rb+afPaL2cW
   v0MIxbgg661lAlk/p9dGOeewbzeBPX8TLztifg4hz1YMpaeyS1uXPK8et
   Zi3WRZ8Gz9O6QRa3rfnbHp9t8hYABtwqcfpdrxENNIDGXoI1OQBULxpM2
   kUJS3S3wDH3dHqDw8oS26CLIMAyQJl0j62zPuSm1yWcPdzhHwuXiF8u3X
   iyu6uBhWfnHdrPsrHchgZsz2EPTdN87xTrBHQA3I2ykcubpXWvBlSGq+f
   nDNgpb61a2wvDvWqTB0OmNrpjuGEIWwhhey0WKoIQYniC3qhESBfSkk48
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="317193848"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="317193848"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:48:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="671178486"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="671178486"
Received: from ikably-mobl.amr.corp.intel.com (HELO [10.255.33.96]) ([10.255.33.96])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:48:10 -0800
Message-ID: <0456bd4e-cfee-b863-e02d-98084b5da0f6@linux.intel.com>
Date:   Fri, 10 Mar 2023 12:48:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v1] ASoC: Intel: sof_rt5682: Enable Bluetooth offload on
 adl_rt1019_rt5682
Content-Language: en-US
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>, dharageswari.r@intel.com,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        alsa-devel@alsa-project.org, Mac Chiang <mac.chiang@intel.com>
References: <20230310184201.1302232-1-ajye_huang@compal.corp-partner.google.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230310184201.1302232-1-ajye_huang@compal.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/23 12:42, Ajye Huang wrote:
> Enable Bluetooth audio offload for drv_name "adl_rt1019_rt5682" with
> following board configuration specifically:
> 
> SSP0 - rt5682 Headset
> SSP1 - alc1019p speaker amp
> SSP2 - Bluetooth audio
> 
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>
> ---
>  sound/soc/intel/boards/sof_rt5682.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index 4fe448295a90..2eec32846078 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -1109,7 +1109,9 @@ static const struct platform_device_id board_ids[] = {
>  					SOF_SPEAKER_AMP_PRESENT |
>  					SOF_RT1019_SPEAKER_AMP_PRESENT |
>  					SOF_RT5682_SSP_AMP(1) |
> -					SOF_RT5682_NUM_HDMIDEV(4)),
> +					SOF_RT5682_NUM_HDMIDEV(4) |
> +					SOF_BT_OFFLOAD_SSP(2) |
> +					SOF_SSP_BT_OFFLOAD_PRESENT),

This sounds good, but if the intent is to have BT offload enabled across
all ADL skews there are still misses, e.g.

.name = "adl_mx98357_rt5682",

Can we please try to add this BT offload in a more consistent manner, or
add a comment when this is officially not planned/supported?
