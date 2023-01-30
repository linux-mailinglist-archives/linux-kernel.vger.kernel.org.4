Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4AE6816C6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbjA3QqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbjA3Qpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:45:54 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAB942DF0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675097153; x=1706633153;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BGLsVIuFZDt/bF+jLZwFS5dn4p5TZfhk5DnFYH4e/nA=;
  b=ddyv6RNTaUFCEpv3FAksmfZ9oIypMCQIlXKhhylFy9f8Eq9tf6OvMun6
   1CefONTlGapYGsnz+Bd5NXgF18xg2QGAas0VtSdtEBTTzB9vkBkd4HlkF
   SYOzm1UdKe0OZVN4OIMeFgyiGPro9+WWsfZ8OiHDxSduhKSU2T89CJyhe
   34ISPD+n10o5e63+AiWIttEblCKru2pfgqLVUtnjumTJYZyTTX636Dqwm
   +n0fNq+PQWxCjgsKOKCN7f1GNm9vBDbMG01Sr7tpxjgYItLPS1E5OhHGf
   FW/TqWKhn073Jeua/V9saxBWjz5T72ktmqmsUHAyLgesvE8QN+l42Gs1n
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="307260864"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="307260864"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:45:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="732763631"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="732763631"
Received: from inuber-mobl5.amr.corp.intel.com (HELO [10.212.58.60]) ([10.212.58.60])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:45:52 -0800
Message-ID: <f0c8d03d-8190-383b-0536-a4006b1296c7@linux.intel.com>
Date:   Mon, 30 Jan 2023 10:40:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v3 7/8] ASoC: cs42l42: Don't set idle_bias_on
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
 <20230127165111.3010960-8-sbinding@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230127165111.3010960-8-sbinding@opensource.cirrus.com>
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
> idle_bias_on was set because cs42l42 has a "VMID" type pseudo-midrail
> supply (named FILT+), and these typically take a long time to charge.
> But the driver never enabled pm_runtime so it would never have powered-
> down the cs42l42 anyway.
> 
> In fact, FILT+ can charge to operating voltage within 12.5 milliseconds
> of enabling HP or ADC. This time is already covered by the startup
> delay of the HP/ADC.
> 
> The datasheet warning about FILT+ taking up to 1 second to charge only
> applies in the special cases that either the PLL is started or
> DETECT_MODE set to non-zero while both HP and ADC are off. The driver
> never does either of these.
> 
> Removing idle_bias_on allows the Soundwire host controller to suspend
> if there isn't a snd_soc_jack handler registered.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/codecs/cs42l42.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
> index aa8d724432ab8..e3edaa1a2761e 100644
> --- a/sound/soc/codecs/cs42l42.c
> +++ b/sound/soc/codecs/cs42l42.c
> @@ -597,7 +597,6 @@ const struct snd_soc_component_driver cs42l42_soc_component = {
>  	.num_dapm_routes	= ARRAY_SIZE(cs42l42_audio_map),
>  	.controls		= cs42l42_snd_controls,
>  	.num_controls		= ARRAY_SIZE(cs42l42_snd_controls),
> -	.idle_bias_on		= 1,
>  	.endianness		= 1,
>  };
>  EXPORT_SYMBOL_NS_GPL(cs42l42_soc_component, SND_SOC_CS42L42_CORE);
