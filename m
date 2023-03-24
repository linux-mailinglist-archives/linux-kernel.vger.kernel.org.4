Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEFE6C7EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjCXNhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCXNhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:37:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852671EBD2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679665030; x=1711201030;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hrxu6Dq+/7P2nTvs2nQdBfPtx5S00hxfReedkevyPEg=;
  b=Bu7ImfsXerUdToKURaZGCEVwzUygamyA+mHjX9SYfuW4+zxA3HeJ3fdw
   e/i4hK23p4q+tXtE6EzkdLM+0MCiyReVRq8/C+3rOn2xNEmeXCmc6t8Yj
   RVNBb4NWmJZa7jaWWEbufdctEFm01O+DkVev0YS3v6TkqIFwuf/NsAuo5
   mbnWMXEfJ5Gm6dSNdp993/xdn4jda+dMxiOa8I2jQ/Qruzq5FZp3jjvHw
   I3M6viDToAftyb4KnE0HCl2jgnCI4MuUsbr8Hefla+Tes/NLbWlzfYH9Q
   p8QXeQetJqP1W8ifRzqkKnFBY+NCHtsK1qZdZ07OZHTNXsff9z1G/4diL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="339803892"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="339803892"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 06:37:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="685168715"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="685168715"
Received: from kvnguye3-mobl1.amr.corp.intel.com (HELO [10.212.145.31]) ([10.212.145.31])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 06:37:09 -0700
Message-ID: <9440fa8f-f50b-716f-7c9f-d7d9d7d183f5@linux.intel.com>
Date:   Fri, 24 Mar 2023 07:56:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [RESEND PATCH] ASoC: soc-compress: Inherit atomicity from DAI
 link for Compress FE
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
        vkoul@kernel.org, daniel.baluta@gmail.com
References: <20230324124019.30826-1-daniel.baluta@oss.nxp.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230324124019.30826-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/23 07:40, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> After commit bbf7d3b1c4f40 ("ASoC: soc-pcm: align BE 'atomicity' with
> that of the FE") BE and FE atomicity must match.
> 
> In the case of Compress PCM there is a mismatch in atomicity between FE
> and BE and we get errors like this:
> 
> [   36.434566]  sai1-wm8960-hifi: dpcm_be_connect: FE is atomic but BE
> is nonatomic, invalid configuration
> [   36.444278]  PCM Deep Buffer: ASoC: can't connect SAI1.OUT
> 
> In order to fix this we must inherit the atomicity from DAI link
> associated with current PCM Compress FE.
> 
> Fixes: bbf7d3b1c4f4 ("ASoC: soc-pcm: align BE 'atomicity' with that of the FE")
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/soc-compress.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index e7aa6f360cab..d649b0cf4744 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -622,6 +622,9 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>  			return ret;
>  		}
>  
> +		/* inherit atomicity from DAI link */
> +		be_pcm->nonatomic = rtd->dai_link->nonatomic;
> +
>  		rtd->pcm = be_pcm;
>  		rtd->fe_compr = 1;
>  		if (rtd->dai_link->dpcm_playback)
