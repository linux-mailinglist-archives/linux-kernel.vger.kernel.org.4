Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1B1748777
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjGEPHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjGEPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:07:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABD0F7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688569649; x=1720105649;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2VpaZbRfmHCXtXMLPIOmDje+7EMPnAYq7+Bzz2xAHJM=;
  b=Biy0hvfGulOPKrEBz1tRTzVuL1rP+U/6Obcwnlx98NFPrYe/AcOU8O4/
   9LdDLmAQ+eZJv2kM1sashhEK/ydcE51rMo1FXxORo++WvYUkkqnARTIWA
   a8+2BkbBNwOYLe7PLiUV7pyK1sdYY/im8PilRNfNkwPV+nIA61aBCizSU
   SaFiPA78QZpDRtg8RIsyef83PaNZ0NSSd1t89/dRokQmjZeJI/0aK00up
   C3qSUYcW1aFW9p2QjntXWS4NuCr8As3gB1iO1WAEfpgc4/oS8ioN+vfnf
   Yz8gb5+IG1YcwHHNDQUI0KMZFwA1/KztaqDuUSRJGS23Xw5VV9xUEBNgp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="429401366"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="429401366"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 08:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="669440968"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="669440968"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 08:07:25 -0700
Message-ID: <ac232872-734f-d192-d46c-555ebe3625c5@linux.intel.com>
Date:   Wed, 5 Jul 2023 17:07:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 7/8] ASoC: topology: suppress probe deferral errors
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230705123018.30903-1-johan+linaro@kernel.org>
 <20230705123018.30903-8-johan+linaro@kernel.org>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230705123018.30903-8-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/2023 2:30 PM, Johan Hovold wrote:
> Suppress probe deferral error messages when loading topologies and
> creating frontend links to avoid spamming the logs when a component has
> not yet been registered:
> 
>      snd-sc8280xp sound: ASoC: adding FE link failed
>      snd-sc8280xp sound: ASoC: topology: could not load header: -517
> 
> Note that dev_err_probe() is not used as the topology component can be
> probed and removed while the underlying platform device remains bound to
> its driver.

I'm not sure that I understand that argument... what's wrong with
dev_err_probe(tplg->dev, err, "ASoC: adding FE link failed\n");
instead of
dev_err(tplg->dev, "ASoC: adding FE link failed\n");
?
Personally I would prefer dev_err_probe() to be used as it also provides 
debug message.

> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   sound/soc/soc-topology.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index d0aca6b9058b..696c9647debe 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -1751,7 +1751,8 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
>   
>   	ret = snd_soc_add_pcm_runtimes(tplg->comp->card, link, 1);
>   	if (ret < 0) {
> -		dev_err(tplg->dev, "ASoC: adding FE link failed\n");
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(tplg->dev, "ASoC: adding FE link failed\n");
>   		goto err;
>   	}
>   
> @@ -2514,8 +2515,11 @@ static int soc_tplg_process_headers(struct soc_tplg *tplg)
>   			/* load the header object */
>   			ret = soc_tplg_load_header(tplg, hdr);
>   			if (ret < 0) {
> -				dev_err(tplg->dev,
> -					"ASoC: topology: could not load header: %d\n", ret);
> +				if (ret != -EPROBE_DEFER) {
> +					dev_err(tplg->dev,
> +						"ASoC: topology: could not load header: %d\n",
> +						ret);
> +				}
>   				return ret;
>   			}
>   

