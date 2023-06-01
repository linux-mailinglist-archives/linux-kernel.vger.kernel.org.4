Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164A871A0D3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjFAOsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjFAOs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:48:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6BE132
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685630906; x=1717166906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZjMPPnkOsUyvdtnWla3A8bZAJ3Ehv3zALg3Ikocts4A=;
  b=S2trG8t3Ihi4MG97jXsY5HBhTojUYENpQojaHuG69toO88PlF2HAj5dm
   2R2RJm3Tc/Cha9se8ZwEpM2MsaP8PWHSeBO4z0NZXvrDNPlX8+gxoWjux
   3cnzEyeRm68BT/kYXu015h0mUo91R+MBxzbn7fQwVJb43Xv0u+PmEMpSK
   GkcNy3p6Do4vvs1jqG3AXbeJpA2SbF57FspFxODtnczJJ7YPd6zo+BnhT
   tP7wX9YFFAWrxW5Xn/9rDh1RYjQVvcmgcRTr7WgUXE2VU2RUw83m1961t
   ishhW7SyHaXtMZ7QjsS+KIxEkJKxM+eLzVwQYzpMfxEWyy/B5kLyzFz/3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358871436"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="358871436"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881634867"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881634867"
Received: from gjayacha-mobl1.amr.corp.intel.com (HELO [10.209.41.36]) ([10.209.41.36])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:48:04 -0700
Message-ID: <18ec3299-56a6-2156-c856-55754fd8fa54@linux.intel.com>
Date:   Thu, 1 Jun 2023 09:08:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] ASoC: cs35l56: Remove NULL check from
 cs35l56_sdw_dai_set_stream()
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230601124907.3128170-1-rf@opensource.cirrus.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230601124907.3128170-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/23 07:49, Richard Fitzgerald wrote:
> The dma pointer must be set to the passed stream pointer, even
> if that pointer is NULL.
> 
> Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Yep, good catch, this is what we have for other codecs.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/codecs/cs35l56.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
> index 3c07bd1e959e..c03f9d3c9a13 100644
> --- a/sound/soc/codecs/cs35l56.c
> +++ b/sound/soc/codecs/cs35l56.c
> @@ -704,9 +704,6 @@ static int cs35l56_sdw_dai_hw_free(struct snd_pcm_substream *substream,
>  static int cs35l56_sdw_dai_set_stream(struct snd_soc_dai *dai,
>  				      void *sdw_stream, int direction)
>  {
> -	if (!sdw_stream)
> -		return 0;
> -
>  	snd_soc_dai_dma_data_set(dai, direction, sdw_stream);
>  
>  	return 0;
