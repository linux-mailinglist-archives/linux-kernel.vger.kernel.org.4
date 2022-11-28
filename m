Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7490D63AEE6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiK1R2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiK1R2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:28:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76CA6444
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669656480; x=1701192480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wlocxIzZa2YAPiuBniHtUeU72dW8mhGyG945Z9QPseQ=;
  b=OA7aea87P+9Rd6sPCyg/7fPbpaSCPmmggCJq8R1gyPXY0lEG5TiEEoMx
   v2ThxvtcQ4qIZyOKFLT7ym+oUy+jF8BDoQJlNKlWIkEAFC5heEk6uvuQz
   Wj08p6xDqy0SVNzguDiMReJ4gr0D0RZYT4wHaVMWihKfN8PTjtWEk8w7Y
   +9IB/JWQwDQkLaHfWsxz3vX55MzQ8ELg2Q2hsruJfN4EZdf4cvtne9hZp
   vEhJl+NUD+00hrT+J1nAdrl449IqHEV7mH/giukNS+uvKtZpxFilB9vRy
   K+fiSnhBv0ZzKzE9Qn2ZzPL6GbNouH8RgaMNkFmPk/QPA/40zrRPKJspV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="295281628"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="295281628"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 09:27:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="888509534"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="888509534"
Received: from kschjaer-mobl.amr.corp.intel.com (HELO [10.212.114.246]) ([10.212.114.246])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 09:27:48 -0800
Message-ID: <2d207a51-d415-726b-3bc1-8788df2f06fd@linux.intel.com>
Date:   Mon, 28 Nov 2022 11:18:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] soundwire: bus_type: Avoid lockdep assert in
 sdw_drv_probe()
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20221121162453.1834170-1-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221121162453.1834170-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/22 10:24, Richard Fitzgerald wrote:
> Don't hold sdw_dev_lock while calling the peripheral driver
> probe() and remove() callbacks.
> 
> Holding sdw_dev_lock around the probe() and remove() calls
> causes a theoretical mutex inversion which lockdep will
> assert on. The peripheral driver probe will probably register
> a soundcard, which will take ALSA and ASoC locks. During

It's extremely unlikely that a peripheral driver would register a sound
card, this is what machine drivers do.

Which leads me to the question: is this a real problem?

Or did you mean 'register components', and if yes what would the problem
with lockdep be?

> normal operation a runtime resume suspend can be triggered
> while these locks are held and will then take sdw_dev_lock.
> 
> It's not necessary to hold sdw_dev_lock when calling the
> probe() and remove(), it is only used to prevent the bus core
> calling the driver callbacks if there isn't a driver or the
> driver is removing.


> If sdw_dev_lock is held while setting and clearing the
> 'probed' flag this is sufficient to guarantee the safety of
> callback functions.

not really, the 'probed' flag was kept for convenience. what this lock
really protects is the dereferencing of ops after the driver .remove
happens.

> The potential race of a bus event happening while probe() is
> executing is the same as the existing race of the bus event
> handler taking the mutex first and processing the event
> before probe() can run. In both cases the event has already
> happened before the driver is probed and ready to accept
> callbacks.

Sorry, I wasn't able to parse the first sentence in this paragraph. what
'existing race' are you referring to?

> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/soundwire/bus_type.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 04b3529f8929..963498db0fd2 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -105,20 +105,19 @@ static int sdw_drv_probe(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&slave->sdw_dev_lock);
> -
>  	ret = drv->probe(slave, id);
>  	if (ret) {
>  		name = drv->name;
>  		if (!name)
>  			name = drv->driver.name;
> -		mutex_unlock(&slave->sdw_dev_lock);
>  
>  		dev_err(dev, "Probe of %s failed: %d\n", name, ret);
>  		dev_pm_domain_detach(dev, false);
>  		return ret;
>  	}
>  
> +	mutex_lock(&slave->sdw_dev_lock);
> +
>  	/* device is probed so let's read the properties now */
>  	if (drv->ops && drv->ops->read_prop)
>  		drv->ops->read_prop(slave);
> @@ -167,14 +166,12 @@ static int sdw_drv_remove(struct device *dev)
>  	int ret = 0;
>  
>  	mutex_lock(&slave->sdw_dev_lock);
> -
>  	slave->probed = false;
> +	mutex_unlock(&slave->sdw_dev_lock);
>  
>  	if (drv->remove)
>  		ret = drv->remove(slave);
>  
> -	mutex_unlock(&slave->sdw_dev_lock);
> -
>  	dev_pm_domain_detach(dev, false);
>  
>  	return ret;
