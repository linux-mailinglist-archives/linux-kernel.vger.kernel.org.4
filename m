Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA35748591
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjGEN6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjGEN5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:57:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FD611B;
        Wed,  5 Jul 2023 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688565474; x=1720101474;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PdRHsWcUvKlFxrNHtPGxrZat7W9p+9tZkkMZRNnSzjQ=;
  b=G+qVJWgANbUBDr5M8wITIOro4rbNtyh4umU9dukluk26fuCIzssdgjKd
   bmoJ7Cs5RjKp3njt6wLbQH8jEYsuVut8a45JjWkQP59vOVwZ7DZvofqqx
   X8BthI+16KQR/9zJk/A/71sKBbflUwsKsd6GBL6DhxMbOno42GK29vzEb
   4lDszr9Wx4eHDPneRI4k9CecuSbbNX4G4SXmRWD2RGjPq3/JylBu0uM+g
   9nBUnJPSEGdbhCP4YacjtTTTQXRO+f0ZuA/A3JxDIabnnThLwYN2ZsK7v
   9ucTJDH8MInGiqJaByjBKCVPB+C77d554kjkEK9iVnPPTrOI/F2COhSUL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="342934605"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="342934605"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 06:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="965835533"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="965835533"
Received: from meggieha-mobl.ger.corp.intel.com (HELO [10.252.48.235]) ([10.252.48.235])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 06:57:49 -0700
Message-ID: <907ad7a3-3384-c0c4-90a9-5beab4cc45e0@linux.intel.com>
Date:   Wed, 5 Jul 2023 14:53:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/8] soundwire: fix enumeration completion
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rander Wang <rander.wang@linux.intel.com>
References: <20230705123018.30903-1-johan+linaro@kernel.org>
 <20230705123018.30903-2-johan+linaro@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230705123018.30903-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/23 14:30, Johan Hovold wrote:
> The soundwire subsystem uses two completion structures that allow
> drivers to wait for soundwire device to become enumerated on the bus and
> initialised by their drivers, respectively.
> 
> The code implementing the signalling is currently broken as it does not
> signal all current and future waiters and also uses the wrong
> reinitialisation function, which can potentially lead to memory
> corruption if there are still waiters on the queue.

That change sounds good, but I am not following the two paragraphs below.

> Not signalling future waiters specifically breaks sound card probe
> deferrals as codec drivers can not tell that the soundwire device is
> already attached when being reprobed. 

What makes you say that? There is a test in the probe and the codec
driver will absolutely be notified, see bus_type.c

	if (drv->ops && drv->ops->update_status) {
		ret = drv->ops->update_status(slave, slave->status);
		if (ret < 0)
			dev_warn(dev, "%s: update_status failed with status %d\n", __func__,
ret);
	}

> Some codec runtime PM
> implementations suffer from similar problems as waiting for enumeration
> during resume can also timeout despite the device already having been
> enumerated.

I am not following this either. Are you saying the wait_for_completion()
times out because of the init_completion/reinit_completion confusion, or
something else.

> Fixes: fb9469e54fa7 ("soundwire: bus: fix race condition with enumeration_complete signaling")
> Fixes: a90def068127 ("soundwire: bus: fix race condition with initialization_complete signaling")
> Cc: stable@vger.kernel.org      # 5.7
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Rander Wang <rander.wang@linux.intel.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/soundwire/bus.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 1ea6a64f8c4a..66e5dba919fa 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -908,8 +908,8 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
>  			"initializing enumeration and init completion for Slave %d\n",
>  			slave->dev_num);
>  
> -		init_completion(&slave->enumeration_complete);
> -		init_completion(&slave->initialization_complete);
> +		reinit_completion(&slave->enumeration_complete);
> +		reinit_completion(&slave->initialization_complete);
>  
>  	} else if ((status == SDW_SLAVE_ATTACHED) &&
>  		   (slave->status == SDW_SLAVE_UNATTACHED)) {
> @@ -917,7 +917,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
>  			"signaling enumeration completion for Slave %d\n",
>  			slave->dev_num);
>  
> -		complete(&slave->enumeration_complete);
> +		complete_all(&slave->enumeration_complete);
>  	}
>  	slave->status = status;
>  	mutex_unlock(&bus->bus_lock);
> @@ -1941,7 +1941,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
>  				"signaling initialization completion for Slave %d\n",
>  				slave->dev_num);
>  
> -			complete(&slave->initialization_complete);
> +			complete_all(&slave->initialization_complete);
>  
>  			/*
>  			 * If the manager became pm_runtime active, the peripherals will be
