Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168E96E819C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjDSTDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDSTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:03:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1442120;
        Wed, 19 Apr 2023 12:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681931026; x=1713467026;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Hh8WUIR6eeK+AxsczOGGcqyUNQHx9FNhheYlsKci2Y=;
  b=Da/AF8m2fHuY++heJ9dpgsxTj33jirSNiKuchiw9Bw4flgLt3reOAfIK
   8rp5ONU3pnB5PZ6Y3lQI3D3RIgpwF08UMnkSxIBQLuwWduM/5u85Bwc13
   uurHU0QVvp3F4CJg/jG8nzYSJ5w//jkenvjjbnEme8dQvbjBJxqbvvDpD
   XjbdCCLLZREO0XABbtTSH59PviPp4bJZSymZANrZaNn7YhBgqYord+DZE
   h0nL6vWOFssX9/3wYUAdPWYCZymYWQ57ZdMAX9xHoKFLdQMcJcNlsB6b8
   SCuN4MIXg83FESU4U6UPuaKJmr/ukr3icLveG5YcZeTssSDog/yjIcCdM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="325148265"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="325148265"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 12:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="1021319731"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="1021319731"
Received: from gargicha-mobl1.amr.corp.intel.com (HELO [10.209.74.38]) ([10.209.74.38])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 12:03:19 -0700
Message-ID: <fbdee94e-b731-0471-e18f-b334ab0db7f5@linux.intel.com>
Date:   Wed, 19 Apr 2023 14:03:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] ASoC: SOF: Intel: hda-stream: Move three variable
 assignments behind condition checks in hda_dsp_iccmax_stream_hw_params()
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <c18331ca-3de9-d433-f477-b04103958b9c@web.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <c18331ca-3de9-d433-f477-b04103958b9c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/23 13:54, Markus Elfring wrote:
> Date: Wed, 19 Apr 2023 20:42:19 +0200
> 
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function “hda_dsp_iccmax_stream_hw_params”.
> 
> Thus avoid the risk for undefined behaviour by moving the assignment
> for three local variables behind some condition checks.
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 7d88b9608142f95ccdd3dfb190da4a5faddb1cc7 ("ASoC: SOF: Intel: hdac_ext_stream: consistent prefixes for variables/members")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Yes indeed, for some reason this was fixed in
hda_dsp_stream_hw_params() but not in the
hda_dsp_iccmax_stream_hw_params() variant.

Could we however use the same code as in hda_dsp_stream_hw_params() for
consistency?

	if (!hext_stream) {
		dev_err(sdev->dev, "error: no stream available\n");
		return -ENODEV;
	}

	if (!dmab) {
		dev_err(sdev->dev, "error: no dma buffer allocated!\n");
		return -ENODEV;
	}

	hstream = &hext_stream->hstream;
	sd_offset = SOF_STREAM_SD_OFFSET(hstream);
	mask = BIT(hstream->index);

Thanks!

> ---
>  sound/soc/sof/intel/hda-stream.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
> index 79d818e6a0fa..9c44127014fc 100644
> --- a/sound/soc/sof/intel/hda-stream.c
> +++ b/sound/soc/sof/intel/hda-stream.c
> @@ -407,10 +407,10 @@ int hda_dsp_iccmax_stream_hw_params(struct snd_sof_dev *sdev, struct hdac_ext_st
>  				    struct snd_dma_buffer *dmab,
>  				    struct snd_pcm_hw_params *params)
>  {
> -	struct hdac_stream *hstream = &hext_stream->hstream;
> -	int sd_offset = SOF_STREAM_SD_OFFSET(hstream);
> +	struct hdac_stream *hstream;
> +	int sd_offset;
>  	int ret;
> -	u32 mask = 0x1 << hstream->index;
> +	u32 mask;
> 
>  	if (!hext_stream) {
>  		dev_err(sdev->dev, "error: no stream available\n");
> @@ -422,9 +422,12 @@ int hda_dsp_iccmax_stream_hw_params(struct snd_sof_dev *sdev, struct hdac_ext_st
>  		return -ENODEV;
>  	}
> 
> +	hstream = &hext_stream->hstream;
>  	if (hstream->posbuf)
>  		*hstream->posbuf = 0;
> 
> +	sd_offset = SOF_STREAM_SD_OFFSET(hstream);
> +
>  	/* reset BDL address */
>  	snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR,
>  			  sd_offset + SOF_HDA_ADSP_REG_SD_BDLPL,
> @@ -459,6 +462,8 @@ int hda_dsp_iccmax_stream_hw_params(struct snd_sof_dev *sdev, struct hdac_ext_st
>  				sd_offset + SOF_HDA_ADSP_REG_SD_LVI,
>  				0xffff, (hstream->frags - 1));
> 
> +	mask = 0x1 << hstream->index;
> +
>  	/* decouple host and link DMA, enable DSP features */
>  	snd_sof_dsp_update_bits(sdev, HDA_DSP_PP_BAR, SOF_HDA_REG_PP_PPCTL,
>  				mask, mask);
> --
> 2.40.0
> 
