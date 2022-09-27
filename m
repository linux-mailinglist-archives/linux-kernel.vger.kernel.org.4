Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA425EBB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiI0HfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiI0He6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:34:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4426010565
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664264097; x=1695800097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aGdiIa2AskwQtLlBRejm6EBBRYZSm6Aal1pnfF0CKs4=;
  b=a6Q6dvkXQAxKqH9vLak5Qka7Uu808mzp1293ADG2+bOAfiASnFKUqfcO
   f8HNIXCVUqriLAsBNax7+6gyGHno05jJcwPZatRRD1wbjKtBbmVN8Ateo
   Rsa6zNxMLljUo0eDR6/o0wzV+ws8tq6McnV3rN9QQA5seLBIX7IMeQCjv
   JcVWZi2Q7LgaBmAn3cpSRcdqCWDsAEafLkIpEbZCkG7HCqfeaz99TTQNT
   Su8CRCH03l6HINA+TBzaH7OX5vx0jhnIt6qTqxFhKPJNwad+sbG27+N2w
   x+z8z9yLM/XLeVu9DCpWjrle4tAL0HE8Shh9DDl0MR9rENQ5fFl2RxPkU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="327602360"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="327602360"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:34:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="572558408"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="572558408"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.206]) ([10.99.249.206])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:34:52 -0700
Message-ID: <b54daa61-ba1d-81d4-5238-ca7cc2a41b48@linux.intel.com>
Date:   Tue, 27 Sep 2022 09:34:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] ASoC: soc-pcm: fix fe and be race when accessing
 substream->runtime
Content-Language: en-US
To:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Yanmin Zhang <yanmin_zhang@linux.intel.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        Zhang Yanmin <yanmin.zhang@intel.com>,
        Ramesh Babu <ramesh.babu@intel.com>,
        Dean Jenkins <Dean_Jenkins@mentor.com>,
        Ramesh Babu B <ramesh.babu.b@intel.com>,
        xiao jin <jin.xiao@intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
References: <1664210154-11552-1-git-send-email-erosca@de.adit-jv.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <1664210154-11552-1-git-send-email-erosca@de.adit-jv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/2022 6:35 PM, Eugeniu Rosca wrote:
> From: xiao jin <jin.xiao@intel.com>
> 
> After start of fe and be, fe might go to close without triggering
> STOP, and substream->runtime is freed. However, be is still at
> START state and its substream->runtime still points to the
> freed runtime.
> 

Well if it is being freed, maybe pointer should be set to NULL instead 
in place that happens?

> Later on, FE is opened/started again, and triggers STOP.
> snd_pcm_do_stop => dpcm_fe_dai_trigger
>                  => dpcm_fe_dai_do_trigger
>                  => dpcm_be_dai_trigger
>                  => dpcm_do_trigger
>                  => soc_pcm_trigger
>                  => skl_platform_pcm_trigger
> skl_platform_pcm_trigger accesses the freed old runtime data and
> kernel panic.
> 
> The patch fixes it by assigning be_substream->runtime in
> dpcm_be_dai_startup when be's state is START.
> 
> Signed-off-by: xiao jin <jin.xiao@intel.com>
> Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> ---
>   sound/soc/soc-pcm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 4f60c0a83311..6ca1d02065ce 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1608,6 +1608,8 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
>   		if (be->dpcm[stream].users++ != 0)
>   			continue;
>   
> +		be_substream->runtime = be->dpcm[stream].runtime;
> +
>   		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_NEW) &&
>   		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_CLOSE))
>   			continue;
> @@ -1615,7 +1617,6 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
>   		dev_dbg(be->dev, "ASoC: open %s BE %s\n",
>   			stream ? "capture" : "playback", be->dai_link->name);
>   
> -		be_substream->runtime = be->dpcm[stream].runtime;
>   		err = __soc_pcm_open(be, be_substream);
>   		if (err < 0) {
>   			be->dpcm[stream].users--;

