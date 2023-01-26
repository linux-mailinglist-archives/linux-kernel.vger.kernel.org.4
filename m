Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9467C529
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 08:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbjAZHyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 02:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjAZHyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 02:54:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC9066EC8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 23:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674719640; x=1706255640;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1kryI9fmp/0/7tgRDGf0+gzDLXBckxfaq5aCAfPWxFM=;
  b=WYSrWSRGWpzcPQddIkKJF2BvO06+SI4Xr7fPy4pApt9Z2wWoudBgBUI9
   oNW3NUqlmIYfPo0YKQfUZM5uBtX9VYmD6R3TGVboRubHyBYO2gtdysmtS
   HwQ4t0Ty9wj1W0J1FW0VPEnJwwsF/sN21RZsWEPHoT2JwWGjo+jiJBcxk
   bm51FLy+LpQxDMT7Zjg3CqplHISihNHFs3lL00aMpLRPs0MwcHpCTcOEs
   tdho4b2d5jxkKRRVN947NH63o02KdXe3mQv+g+EYzdcLh/6eamvgU5w0n
   5kHo/eHB4lvsYl/ul5NZvqp1nv9e0wtL9BOQvf5uN6eUOPQZxb/AMpEw4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="325430951"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="325430951"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 23:54:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="805294069"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="805294069"
Received: from mericx-mobl.ger.corp.intel.com (HELO [10.252.29.93]) ([10.252.29.93])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 23:53:56 -0800
Message-ID: <6f0301dd-ce1f-084a-f29b-27bf897804de@linux.intel.com>
Date:   Thu, 26 Jan 2023 09:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/5] ASoC: amd: acp: Refactor i2s clocks programming
 sequence
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Vijendar.Mukunda@amd.com,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
References: <20230109132104.1259479-1-venkataprasad.potturu@amd.com>
 <20230109132104.1259479-4-venkataprasad.potturu@amd.com>
 <92052eef-3c61-7f3e-75c1-09b76cd38e24@linux.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <92052eef-3c61-7f3e-75c1-09b76cd38e24@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/01/2023 19:15, Pierre-Louis Bossart wrote:
> This patch adds new Sparse warnings [1]:
> 
> sound/soc/amd/acp/acp-mach-common.c:189:35: error: restricted
> snd_pcm_format_t degrades to integer
> sound/soc/amd/acp/acp-mach-common.c:333:35: error: restricted
> snd_pcm_format_t degrades to integer
> sound/soc/amd/acp/acp-mach-common.c:478:35: error: restricted
> snd_pcm_format_t degrades to integer
> sound/soc/amd/acp/acp-mach-common.c:619:35: error: restricted
> snd_pcm_format_t degrades to integer
> 
>> @@ -193,7 +163,11 @@ static int acp_card_rt5682_hw_params(struct snd_pcm_substream *substream,
>>  	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
>>  	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
>>  	int ret;
>> -	unsigned int fmt;
>> +	unsigned int fmt, srate, ch, format;
>> +
>> +	srate = params_rate(params);
>> +	ch = params_channels(params);
>> +	format = 8 * params_format(params);
> 
> This last line looks suspicious, no? format-to-physical-size conversions
> should be using existing macros.

not only that, but the "8 * params_format(params)" is certainly not
correct for the purpose.

params_format() returns SNDRV_PCM_FORMAT_*, which is basically an enum:
SNDRV_PCM_FORMAT_S8		0
SNDRV_PCM_FORMAT_S16_LE		2
SNDRV_PCM_FORMAT_S24_LE		6
SNDRV_PCM_FORMAT_S24_3LE	32
SNDRV_PCM_FORMAT_S32_LE		10

include/uapi/sound/asound.h

> Should it be
> 
> format = params_physical_width(params);

I believe this was the intention.

> 
> ?
> 
> 
>> +	/* Set tdm/i2s1 master bclk ratio */
>> +	ret = snd_soc_dai_set_bclk_ratio(codec_dai, ch * format);
>> +	if (ret < 0) {
>> +		dev_err(rtd->dev, "Failed to set rt5682 tdm bclk ratio: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if (!drvdata->soc_mclk) {
>> +		ret = acp_clk_enable(drvdata, srate, ch * format);
>> +		if (ret < 0) {
>> +			dev_err(rtd->card->dev, "Failed to enable HS clk: %d\n", ret);
>> +			return ret;
>> +		}
> 
> [1]
> https://github.com/thesofproject/linux/actions/runs/4005001249/jobs/6874834205

-- 
Péter
