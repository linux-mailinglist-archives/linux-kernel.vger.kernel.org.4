Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A96DDC04
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDKNZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDKNZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:25:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BC11BC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681219505; x=1712755505;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P/iDhHTGwWX+IUkevSeJym7AO9IHqFOgQHaG3NtyP2I=;
  b=P7564HU2HO1iL5YXKGLGUcr7S5KAqI2BtYXVDLJRMFOwegvNcjpLnQNF
   iNIS8OQ77hh+QonNt6NnL6lG5g25hoPgIf7aOcTRx9CEuDvLb30B3DU5S
   kHqn0rLT1XTE3T7eW8RatzIZvkW1HdBMy/8knFtBwjT2eIRT7h7Jcj1+q
   aKFrm9GVC0KtgwJVGtHZRx5ssyEsVMnvokutHAWYww3FEIOpsyK04GbaH
   fhg+WqoF2GFMZYNaih3A4UZ5Ko+owmxzsPjPJ0J0L1ffPcMWX9KI/SpCM
   8Zyzhm6meybfhcKUU8DT3BRvktu3Snc2U1Yy7p4tNelxsoCPp36v/R8A/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="429901270"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="429901270"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 06:25:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="799909332"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="799909332"
Received: from rpearman-mobl.amr.corp.intel.com (HELO [10.252.132.237]) ([10.252.132.237])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 06:25:03 -0700
Message-ID: <14976031-7d63-4069-8647-3cee41064215@linux.intel.com>
Date:   Tue, 11 Apr 2023 08:25:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: soc-compress: set pcm nonatomic flag from dai_link
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
References: <20230411110831.813-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230411110831.813-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/23 06:08, Srinivas Kandagatla wrote:
> In compress offload case we never set nonatomic flag on a new pcm. This triggers
> below configuration error with DPCM on Qualcomm setup where dai_links are marked
> as nonatomic.
> 
> "FE is atomic but BE is nonatomic, invalid configuration"
> 
> Fix this by Updating the pcm nonatomic flag correcly from the respective dai_link.
> 
> CC: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/soc-compress.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index 554c329ec87f..a8d70274cab8 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -615,6 +615,7 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>  			return ret;
>  		}
>  
> +		be_pcm->nonatomic = rtd->dai_link->nonatomic;
>  		rtd->pcm = be_pcm;
>  		rtd->fe_compr = 1;
>  		if (rtd->dai_link->dpcm_playback)

isn't this fixed already? Daniel Baluta sent a patch for this, already
applied by Mark:

https://lore.kernel.org/alsa-devel/20230324124019.30826-1-daniel.baluta@oss.nxp.com/
