Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF9C64CBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiLNOGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLNOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:06:48 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC0D1E3EC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671026807; x=1702562807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kRnzKDaifLMzk91f4ryWfcXJa4yv7M4AXVG0yIWndXw=;
  b=nUVE+tJrLi+MEBmCSnfHxzjjAMKKzFawzpDuz20KAF9S3+DSfLqhj0DL
   CaSllQO0NieFOK3JbuNkvlWMxkrE5ZcA3YUlnmaDli/VbAEZ6tDKaLMXu
   hDunpaDlBu4q+JANsnITYY3ii9qGzb9fRPbywrRI5G+AP8P5pCQeAlDVt
   EbwW/5aYHar53FX3T1HheTs4GvbltSn/42VplupUAe+Umk+Cv4/ScPN10
   XCCrjWU9AdN6de3bJL6CxXIQA5WUhaLlNESYdn9njEV/HHbSeS9tRscWZ
   Eg+cPYLtkqtiWwzJq0fUUu6BS9jwx0z/YiqL2FMym4ZeQDHaEkdE98wwf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="318452723"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="318452723"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 06:06:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="681517232"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="681517232"
Received: from gajular-mobl1.amr.corp.intel.com (HELO [10.213.160.14]) ([10.213.160.14])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 06:06:28 -0800
Message-ID: <08403fff-359b-b5f4-d039-18eeef660637@linux.intel.com>
Date:   Tue, 13 Dec 2022 13:04:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] Add HP Stream 8 to bytcr_rt5640.c
Content-Language: en-US
To:     Moises Cardona <moisesmcardona@gmail.com>,
        cezary.rojewski@intel.com
Cc:     liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, hdegoede@redhat.com, oder_chiou@realtek.com,
        akihiko.odaki@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20221213173550.1567875-1-moisesmcardona@gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221213173550.1567875-1-moisesmcardona@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/22 11:35, Moises Cardona wrote:
> The HP Stream 8 tablet is identical to the HP Stream 7 in terms of the PCB,
> with the exception of the added SIM Card Slot. 
> Therefore, I'm submitting this patch which properly initializes the audio 
> and enables the headphone jack to work, just like it does in the 
> HP Stream 7.
> 
> Signed-off-by: Moises Cardona <moisesmcardona@gmail.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/intel/boards/bytcr_rt5640.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index fb9d9e271845..1d964b1ceff4 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -796,6 +796,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>  					BYT_RT5640_SSP0_AIF1 |
>  					BYT_RT5640_MCLK_EN),
>  	},
> +	{	/* HP Stream 8 */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP Stream 8 Tablet"),
> +		},
> +		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
> +					BYT_RT5640_MONO_SPEAKER |
> +					BYT_RT5640_JD_NOT_INV |
> +					BYT_RT5640_SSP0_AIF1 |
> +					BYT_RT5640_MCLK_EN),
> +	},
>  	{	/* I.T.Works TW891 */
>  		.matches = {
>  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
