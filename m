Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126EB67B844
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbjAYRRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbjAYRRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:17:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9018C10CE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674667012; x=1706203012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+FsfjVh96kHMiXflnl9uGUaz68h9YTawTmC/lL5rqUo=;
  b=moYJ+oLWwjq/Okp7zIV5E1GdID9vc2DP/Z9eOlGTRqhtS4aldPt54ums
   IXkELJWqYCDHl0T6GccoYLHILZ806JTZeAw0uDr7b1JsaEaEYD2JzwBIH
   WdNMJCwytFLzrLEHTDCHcofNUdTpgwaEjmAaql1IdGVDNjpYAWDdLjrPD
   w/Bkj7kLv0JwwdUV8gpUVXVsHzPo+Hvbd8YBFbQNHizWitVRJLlAdUjjy
   MeCmBdgibBQbryFigMM+BDE2gJeeED9j4ZXJr3JNxR5nNxCKezENcnEih
   mi5WbGooBOFMFRuhg9zgrzVEoKu9keuBZtBuzTyzyXzaVXyS5/HZY73Xx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="327868196"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="327868196"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 09:15:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="805068835"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="805068835"
Received: from bshunt-mobl.amr.corp.intel.com (HELO [10.212.37.80]) ([10.212.37.80])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 09:15:31 -0800
Message-ID: <92052eef-3c61-7f3e-75c1-09b76cd38e24@linux.intel.com>
Date:   Wed, 25 Jan 2023 11:15:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/5] ASoC: amd: acp: Refactor i2s clocks programming
 sequence
Content-Language: en-US
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Vijendar.Mukunda@amd.com,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20230109132104.1259479-1-venkataprasad.potturu@amd.com>
 <20230109132104.1259479-4-venkataprasad.potturu@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230109132104.1259479-4-venkataprasad.potturu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new Sparse warnings [1]:

sound/soc/amd/acp/acp-mach-common.c:189:35: error: restricted
snd_pcm_format_t degrades to integer
sound/soc/amd/acp/acp-mach-common.c:333:35: error: restricted
snd_pcm_format_t degrades to integer
sound/soc/amd/acp/acp-mach-common.c:478:35: error: restricted
snd_pcm_format_t degrades to integer
sound/soc/amd/acp/acp-mach-common.c:619:35: error: restricted
snd_pcm_format_t degrades to integer

> @@ -193,7 +163,11 @@ static int acp_card_rt5682_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
>  	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
>  	int ret;
> -	unsigned int fmt;
> +	unsigned int fmt, srate, ch, format;
> +
> +	srate = params_rate(params);
> +	ch = params_channels(params);
> +	format = 8 * params_format(params);

This last line looks suspicious, no? format-to-physical-size conversions
should be using existing macros.

Should it be

format = params_physical_width(params);

?


> +	/* Set tdm/i2s1 master bclk ratio */
> +	ret = snd_soc_dai_set_bclk_ratio(codec_dai, ch * format);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "Failed to set rt5682 tdm bclk ratio: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!drvdata->soc_mclk) {
> +		ret = acp_clk_enable(drvdata, srate, ch * format);
> +		if (ret < 0) {
> +			dev_err(rtd->card->dev, "Failed to enable HS clk: %d\n", ret);
> +			return ret;
> +		}

[1]
https://github.com/thesofproject/linux/actions/runs/4005001249/jobs/6874834205
