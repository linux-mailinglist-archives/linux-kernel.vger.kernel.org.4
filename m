Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E980671F09
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjAROJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjAROIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:08:46 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE4C5AB77
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674049770; x=1705585770;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FeABRWZG/7wT2V4yotl0KXOF5NebpsvSF1ap6am3g1M=;
  b=focWksFdNG4QXsYBs6UNWgnGPz8Ia4k/WwX4iC1dztc5ysV9HnL7VzTk
   O3p6NX2IxW4R9Jwku/CsCYmgNzSq18MEawYOpexnYYshO5Rzafh4CZuJb
   AqAI5GWsjogB4zIXTkpP1cdwB2qxj/octV5ef1YtTw+2NMxl/M1x1qgTP
   fRw1xXv5GEpqihBfarb9NvSvLfGGI5zMkjsURCOsCooV89zLsue+2IS0r
   OQ5gxGA4qsmeGsJyubToLdbkcMK1Nc6My7EM2Kcc5QzB3g2EDbsASma7Y
   UKOtuHKHstXSQHaCWBFsN9+z9lorWtqkDMYZ16afggefh3ZxEOKzl4EjU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="411221685"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="411221685"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 05:49:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="988549431"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="988549431"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 05:49:27 -0800
Message-ID: <5da005dd-e34e-ff08-7a97-8a37b231ed5e@linux.intel.com>
Date:   Wed, 18 Jan 2023 14:49:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 3/4] ASoC: ts3a227e: add set_jack and
 get_jack_supported_type
Content-Language: en-US
To:     Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, kernel@axis.com,
        linux-kernel@vger.kernel.org
References: <20230118125226.333214-1-astrid.rost@axis.com>
 <20230118125226.333214-4-astrid.rost@axis.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230118125226.333214-4-astrid.rost@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/2023 1:52 PM, Astrid Rost wrote:
> Add set_jack and get_jack_supported_type
> to allow simple-card-utils to add a jack for it.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>   sound/soc/codecs/ts3a227e.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
> index 2305a472d132..212dfd2b60ed 100644
> --- a/sound/soc/codecs/ts3a227e.c
> +++ b/sound/soc/codecs/ts3a227e.c
> @@ -258,7 +258,22 @@ int ts3a227e_enable_jack_detect(struct snd_soc_component *component,
>   }
>   EXPORT_SYMBOL_GPL(ts3a227e_enable_jack_detect);
>   
> -static struct snd_soc_component_driver ts3a227e_soc_driver;
> +static int ts3a227e_set_jack(struct snd_soc_component *component,
> +			     struct snd_soc_jack *jack, void *data)
> +{
> +	return ts3a227e_enable_jack_detect(component, jack);
> +}

Patch looks ok, but it seems that ts3a227e_enable_jack_detect() doesn't 
check if jack is NULL, before calling snd_jack_set_key() I guess this 
should be also fixed, as _set_jack can be called with jack being NULL to 
disable jack detection. Optionally, while set_jack is being added I 
would also just get rid of 
EXPORT_SYMBOL_GPL(ts3a227e_enable_jack_detect); and convert all other 
users to snd_soc_component_set_jack as it currently serves as bad example.

> +
> +static int ts3a227e_get_supported_jack_type(struct snd_soc_component *component)
> +{
> +	return TS3A227E_JACK_MASK;
> +}
> +
> +static const struct snd_soc_component_driver ts3a227e_soc_driver = {
> +	.name = "ti,ts3a227e",
> +	.set_jack = ts3a227e_set_jack,
> +	.get_jack_supported_type = ts3a227e_get_supported_jack_type,
> +};
>   
>   static const struct regmap_config ts3a227e_regmap_config = {
>   	.val_bits = 8,

