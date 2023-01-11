Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AEB6660B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbjAKQhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbjAKQgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:36:20 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71884DE7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673454979; x=1704990979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=60RwI3ta0zzohG/RqWrOlSWa3GvLJ4TqPML70PsLVWQ=;
  b=TbX1UTHZ7mjJncz0ODwXd0QB7RCEoQqPZDeYFk4Fr1Z6mrT8zQO+cW+x
   CknFzH8CWU0KcOWyq8NdkHTBo1nA8+9sMa2I89RjrvQUw5WD4AV+6HZf+
   W0Z0C7vnzBgdkLYesJbcxitmHwH477hE+/xdIvOHazmxuW4AHez95XIyZ
   zOdypgptL0ybAJYYvMCWtkM2ML6vKKCfJ27wdYEU4LvgxllwDIwAmlyPo
   VTsC5845Xcc4OaNK2ifjkBRCrWAFGFPmSlmZk7ERL6gKhct9CMVDs2HU+
   hNIiZHeObEGKHPGtFhRtYfq2yYJspOnRgzM1Ynqa31ckrUQt5ixXaMW6j
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324704276"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324704276"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607408829"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607408829"
Received: from flobatol-mobl1.amr.corp.intel.com (HELO [10.212.110.208]) ([10.212.110.208])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:45 -0800
Message-ID: <a76043ad-c212-f625-8d0e-ef9460a078a5@linux.intel.com>
Date:   Wed, 11 Jan 2023 09:58:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 17/19] soundwire: amd: add pm_prepare callback and pm ops
 support
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-18-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230111090222.2016499-18-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/23 03:02, Vijendar Mukunda wrote:
> Add pm_prepare callback and System level pm ops support for
> AMD master driver.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
> ---
>  drivers/soundwire/amd_master.c | 76 ++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/soundwire/amd_master.c b/drivers/soundwire/amd_master.c
> index 2fd77a673c22..f4478cc17aac 100644
> --- a/drivers/soundwire/amd_master.c
> +++ b/drivers/soundwire/amd_master.c
> @@ -1552,6 +1552,80 @@ static int amd_sdwc_clock_stop_exit(struct amd_sdwc_ctrl *ctrl)
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
> +
> +	if (!pm_runtime_suspended(dev))
> +		return 0;
> +	ret = pm_request_resume(dev);
> +	if (ret < 0)
> +		dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused amd_pm_prepare(struct device *dev)
> +{
> +	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct sdw_bus *bus = &ctrl->bus;
> +	int ret;
> +
> +	if (bus->prop.hw_disabled || !ctrl->startup_done) {
> +		dev_dbg(bus->dev, "SoundWire master %d is disabled or not-started, ignoring\n",
> +			bus->link_id);
> +		return 0;
> +	}
> +	ret = device_for_each_child(bus->dev, NULL, amd_resume_child_device);
> +	if (ret < 0)
> +		dev_err(dev, "%s: amd_resume_child_device failed: %d\n", __func__, ret);
> +	if (pm_runtime_suspended(dev) && ctrl->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
> +		ret = pm_request_resume(dev);
> +		if (ret < 0) {
> +			dev_err(bus->dev, "pm_request_resume failed: %d\n", ret);
> +			return 0;
> +		}
> +	}
> +	return 0;
> +}

This seems to be inspired by the Intel code, but is this necessary here?

For Intel, we saw cases where we had to pm_resume before doing a system
suspend, otherwise the hardware was in a bad state.

Do you actually need to do so, or is is possible to do a system suspend
when the clock is stopped.

And in the case where the bus is in 'power-off' mode, do you actually
need to resume at all?

> +
> +static int __maybe_unused amd_suspend(struct device *dev)
> +{
> +	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct sdw_bus *bus = &ctrl->bus;
> +	int ret;
> +
> +	if (bus->prop.hw_disabled || !ctrl->startup_done) {
> +		dev_dbg(bus->dev, "SoundWire master %d is disabled or not-started, ignoring\n",
> +			bus->link_id);
> +		return 0;
> +	}
> +
> +	if (ctrl->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
> +		ret = amd_sdwc_clock_stop(ctrl);
> +		if (ret)
> +			return ret;
> +	} else if (ctrl->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
> +		ret = amd_sdwc_clock_stop(ctrl);

do you actually need to stop the clock before powering-off? This seems
counter intuitive and not so useful?

> +		if (ret)
> +			return ret;
> +		ret = amd_deinit_sdw_controller(ctrl);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  static int __maybe_unused amd_suspend_runtime(struct device *dev)
>  {
>  	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
> @@ -1638,6 +1712,8 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops amd_pm = {
> +	.prepare = amd_pm_prepare,
> +	SET_SYSTEM_SLEEP_PM_OPS(amd_suspend, amd_resume_runtime)
>  	SET_RUNTIME_PM_OPS(amd_suspend_runtime, amd_resume_runtime, NULL)
>  };
>  
