Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B73C6A479B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjB0RNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjB0RNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:13:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4357DA6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677517988; x=1709053988;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v7SeSzLWRnY4KlcEImoHo5oqZX4MNLiw33Iga3FRf4M=;
  b=WGY1XHO53S1sokaGKijkmPayjD/0gnGM7kooPz0sxWRBl64ABCat8UY1
   QciA/OuaXcTp0UAbA/HXk+oz3nfFaSzREQ+oxDt01Jue8Gx1OdBMhyeP9
   H60+r7vUW4kVKYwIUNtDlCkuRqFCvArLskWqBzTGnypOjQdP5Csm61Djk
   eSjcZbYQgRikyjatiqdSJBiyVeVwTWxRYhg7jC3NVYLE4YPIWHPqdxuPb
   4cbDa9z9AptjbV8hXYDbqZk2BTodI1biyfRyk7+DQr0gDkTBA6xcp/qsg
   /Ww2cM6ihHDP/Jmqan/UgFWZTpDTmK7SCMdfIkyya1LZkOgZB8LVyALZP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313583783"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="313583783"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 09:08:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="651302272"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="651302272"
Received: from jaidenno-mobl.amr.corp.intel.com (HELO [10.212.85.4]) ([10.212.85.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 09:08:40 -0800
Message-ID: <82c7303b-131e-0633-2c08-5b4b414ad941@linux.intel.com>
Date:   Mon, 27 Feb 2023 12:07:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V4 8/8] soundwire: amd: add pm_prepare callback and pm ops
 support
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
 <20230227154801.50319-9-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230227154801.50319-9-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/23 10:48, Vijendar Mukunda wrote:
> Add pm_prepare callback and System level pm ops support for
> AMD SoundWire manager driver.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>

seems like you missed my comments in
https://lore.kernel.org/alsa-devel/7d32d552-6ca0-3c40-11ce-c8d727cadc05@linux.intel.com/

> ---
>  drivers/soundwire/amd_manager.c | 89 +++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index 88f0ad7ea7ec..5337443d9aea 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -1141,6 +1141,93 @@ static int amd_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
>  	return 0;
>  }
>  
> +static int amd_resume_child_device(struct device *dev, void *data)
> +{
> +	int ret;
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +
> +	if (!slave->probed) {
> +		dev_dbg(dev, "skipping device, no probed driver\n");
> +		return 0;
> +	}
> +	if (!slave->dev_num_sticky) {
> +		dev_dbg(dev, "skipping device, never detected on bus\n");
> +		return 0;
> +	}
> +	if (!pm_runtime_suspended(dev))
> +		return 0;
> +	ret = pm_request_resume(dev);

I think it's just better to let the pm_runtime framework deal with the
states than do this is two steps.

> +	if (ret < 0)
> +		dev_err(dev, "pm_request_resume failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused amd_pm_prepare(struct device *dev)
> +{
> +	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
> +	struct sdw_bus *bus = &amd_manager->bus;
> +	int ret;
> +
> +	if (bus->prop.hw_disabled) {
> +		dev_dbg(bus->dev, "SoundWire manager %d is disabled, ignoring\n",
> +			bus->link_id);
> +		return 0;
> +	}
> +	/*
> +	 * When multiple peripheral devices connected over the same link, if SoundWire manager
> +	 * device is not in runtime suspend state, observed that device alerts are missing
> +	 * without pm_prepare on AMD platforms in clockstop mode0.
> +	 */
> +	if (pm_runtime_suspended(dev) && amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
> +		ret = pm_request_resume(dev);

same here.

> +		if (ret < 0) {
> +			dev_err(bus->dev, "pm_request_resume failed: %d\n", ret);
> +			return 0;
> +		}
> +	}
> +	/* To force peripheral devices to system level suspend state, resume the devices
> +	 * from runtime suspend state first. Without that unable to dispatch the alert
> +	 * status to peripheral driver during system level resume as they are in runtime
> +	 * suspend state.
> +	 */
> +	ret = device_for_each_child(bus->dev, NULL, amd_resume_child_device);
> +	if (ret < 0)
> +		dev_err(dev, "amd_resume_child_device failed: %d\n", ret);
> +	return 0;
> +}
> +
> +static int __maybe_unused amd_suspend(struct device *dev)
> +{
> +	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
> +	struct sdw_bus *bus = &amd_manager->bus;
> +	int ret;
> +
> +	if (bus->prop.hw_disabled) {
> +		dev_dbg(bus->dev, "SoundWire manager %d is disabled, ignoring\n",
> +			bus->link_id);
> +		return 0;
> +	}
> +
> +	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
> +		ret = amd_sdw_clock_stop(amd_manager);
> +		if (ret)
> +			return ret;
> +	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
> +		/*
> +		 * As per hardware programming sequence on AMD platforms,
> +		 * clock stop should be invoked first before powering-off
> +		 */
> +		ret = amd_sdw_clock_stop(amd_manager);
> +		if (ret)
> +			return ret;
> +		ret = amd_deinit_sdw_manager(amd_manager);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  static int __maybe_unused amd_suspend_runtime(struct device *dev)
>  {
>  	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
> @@ -1213,6 +1300,8 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops amd_pm = {
> +	.prepare = amd_pm_prepare,
> +	SET_SYSTEM_SLEEP_PM_OPS(amd_suspend, amd_resume_runtime)
>  	SET_RUNTIME_PM_OPS(amd_suspend_runtime, amd_resume_runtime, NULL)
>  };
>  
