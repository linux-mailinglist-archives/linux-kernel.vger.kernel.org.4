Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2336660AB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjAKQgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbjAKQgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:36:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A28E2BC4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673454968; x=1704990968;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gsngSkA9zuCYNZaMCNMhzxKvwqJqeTucuW8uvJ0fSwY=;
  b=Jg0Jcus7q/IicnNqBTOdPNbhWrOfxI0y3H7pwixe/LubyEQuUSrFe/Pn
   uOcm28EVcoiSFOwj+1cAbZvrA7wUGu6892Pq7SA1l+4hvobE23KNPFn34
   Mqbh86pO9gs98DqhPVZTYNBuazjAfyS3MFaHCbthDcQQrZYMxmhUFvyiE
   vcbBmEYbyVXmwrJitDmRHGVfyaS5DkiapjBja/HqKrf90+wJGHNi3Zrua
   t1OWGcOyKHvwqBaRE6tSqBgEpQbRdIk7zE65dydZgrg+Av2zQRugQv6OL
   32lV7W6qCBqOYJZbiNFWvZ39RG0UEXg4F+9yg7ZAXSp5kbNEmNLwMrNld
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324704176"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324704176"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607408685"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607408685"
Received: from flobatol-mobl1.amr.corp.intel.com (HELO [10.212.110.208]) ([10.212.110.208])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:33 -0800
Message-ID: <1af8aa6a-9896-4d35-48de-f084fd16ebc7@linux.intel.com>
Date:   Wed, 11 Jan 2023 09:47:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 14/19] soundwire: amd: add runtime pm ops for AMD master
 driver
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
 <20230111090222.2016499-15-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230111090222.2016499-15-Vijendar.Mukunda@amd.com>
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
> Add support for runtime pm ops for AMD master driver.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
> ---
>  drivers/soundwire/amd_master.c    | 205 ++++++++++++++++++++++++++++++
>  drivers/soundwire/amd_master.h    |   3 +
>  include/linux/soundwire/sdw_amd.h |   1 +
>  3 files changed, 209 insertions(+)
> 
> diff --git a/drivers/soundwire/amd_master.c b/drivers/soundwire/amd_master.c
> index c7063b8bdd7b..d2d7f07de202 100644
> --- a/drivers/soundwire/amd_master.c
> +++ b/drivers/soundwire/amd_master.c
> @@ -15,6 +15,7 @@
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_registers.h>
>  #include <linux/soundwire/sdw_amd.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/wait.h>
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> @@ -290,6 +291,17 @@ static int amd_disable_sdw_interrupts(struct amd_sdwc_ctrl *ctrl)
>  	return 0;
>  }
>  
> +static int amd_deinit_sdw_controller(struct amd_sdwc_ctrl *ctrl)
> +{
> +	int ret;
> +
> +	ret = amd_disable_sdw_interrupts(ctrl);
> +	if (ret)
> +		return ret;
> +	ret = amd_disable_sdw_controller(ctrl);
> +	return ret;
> +}
> +
>  static int amd_sdwc_set_frameshape(struct amd_sdwc_ctrl *ctrl, u32 rows, u32 cols)
>  {
>  	u32 sdw_rows, sdw_cols, frame_size;
> @@ -1387,6 +1399,12 @@ static int amd_sdwc_probe(struct platform_device *pdev)
>  	INIT_WORK(&ctrl->amd_sdw_work, amd_sdwc_update_slave_status_work);
>  	INIT_WORK(&ctrl->probe_work, amd_sdwc_probe_work);
>  	schedule_work(&ctrl->probe_work);
> +	/* Enable runtime PM */
> +	pm_runtime_set_autosuspend_delay(dev, AMD_SDW_MASTER_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
>  	return 0;
>  }
>  
> @@ -1398,14 +1416,201 @@ static int amd_sdwc_remove(struct platform_device *pdev)
>  	amd_disable_sdw_interrupts(ctrl);
>  	sdw_bus_master_delete(&ctrl->bus);
>  	ret = amd_disable_sdw_controller(ctrl);
> +	pm_runtime_disable(&pdev->dev);
>  	return ret;
>  }
>  
> +static int amd_sdwc_clock_stop(struct amd_sdwc_ctrl *ctrl)
> +{
> +	u32 clk_resume_ctrl_reg;
> +	u32 wake_en_reg;
> +	u32 val;
> +	u32 retry_count = 0;
> +	int ret;
> +
> +	ret = sdw_bus_prep_clk_stop(&ctrl->bus);
> +	if (ret < 0 && ret != -ENODATA) {
> +		dev_err(ctrl->dev, "prepare clock stop failed %d", ret);
> +		return ret;
> +	}
> +	ret = sdw_bus_clk_stop(&ctrl->bus);
> +	if (ret < 0 && ret != -ENODATA) {
> +		dev_err(ctrl->dev, "bus clock stop failed %d", ret);
> +		return ret;

You need to be very careful here, because returning an error may prevent
the device from suspending.

If it's safe and possible to recover during the resume step, you
probably want to log the error but let the suspend continue.

> +	}
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		clk_resume_ctrl_reg = ACP_SW_CLK_RESUME_CTRL;
> +		wake_en_reg = ACP_SW_WAKE_EN;
> +		break;
> +	case ACP_SDW1:
> +		clk_resume_ctrl_reg = ACP_P1_SW_CLK_RESUME_CTRL;
> +		wake_en_reg = ACP_SW1_WAKE_EN;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

why not store these offsets during the probe and use them directly here?
You know at probe time which master you're using.

> +
> +	do {
> +		val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
> +		if (val & AMD_SDW_CLK_STOP_DONE) {
> +			ctrl->clk_stopped = true;
> +			break;
> +		}
> +	} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
> +
> +	if (!ctrl->clk_stopped) {
> +		dev_err(ctrl->dev, "SDW%x clock stop failed\n", ctrl->instance);
> +		return -ETIMEDOUT;
> +	}
> +
> +	if (ctrl->wake_en_mask)
> +		acp_reg_writel(0x01, ctrl->mmio + wake_en_reg);
> +
> +	dev_dbg(ctrl->dev, "SDW%x clock stop successful\n", ctrl->instance);
> +	return 0;
> +}
> +
> +static int amd_sdwc_clock_stop_exit(struct amd_sdwc_ctrl *ctrl)
> +{
> +	int ret;
> +	u32 clk_resume_ctrl_reg;
> +	u32 val = 0;
> +	u32 retry_count = 0;
> +
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		clk_resume_ctrl_reg = ACP_SW_CLK_RESUME_CTRL;
> +		break;
> +	case ACP_SDW1:
> +		clk_resume_ctrl_reg = ACP_P1_SW_CLK_RESUME_CTRL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (ctrl->clk_stopped) {
> +		val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
> +		val |= AMD_SDW_CLK_RESUME_REQ;
> +		acp_reg_writel(val, ctrl->mmio + clk_resume_ctrl_reg);
> +		do {
> +			val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
> +			if (val & AMD_SDW_CLK_RESUME_DONE)
> +				break;
> +			usleep_range(10, 100);
> +		} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
> +		if (val & AMD_SDW_CLK_RESUME_DONE) {
> +			acp_reg_writel(0, ctrl->mmio + clk_resume_ctrl_reg);
> +			ret = sdw_bus_exit_clk_stop(&ctrl->bus);
> +			if (ret < 0)
> +				dev_err(ctrl->dev, "bus failed to exit clock stop %d\n", ret);
> +			ctrl->clk_stopped = false;
> +		}
> +	}
> +	if (ctrl->clk_stopped) {
> +		dev_err(ctrl->dev, "SDW%x clock stop exit failed\n", ctrl->instance);
> +		return -ETIMEDOUT;
> +	}
> +
> +	dev_dbg(ctrl->dev, "SDW%x clock stop exit successful\n", ctrl->instance);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused amd_suspend_runtime(struct device *dev)
> +{
> +	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct sdw_bus *bus = &ctrl->bus;
> +	int ret;
> +
> +	if (bus->prop.hw_disabled || !ctrl->startup_done) {

do you have a case where the startup is not done? This was an
Intel-specific thing.

> +		dev_dbg(bus->dev, "SoundWire master %d is disabled or not-started, ignoring\n",
> +			bus->link_id);
> +		return 0;
> +	}
> +	if (ctrl->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
> +		ret = amd_sdwc_clock_stop(ctrl);
> +		if (ret)
> +			return ret;
> +	} else if (ctrl->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
> +		ret = amd_sdwc_clock_stop(ctrl);
> +		if (ret)
> +			return ret;
> +		ret = amd_deinit_sdw_controller(ctrl);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static int __maybe_unused amd_resume_runtime(struct device *dev)
> +{
> +	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct sdw_bus *bus = &ctrl->bus;
> +	int ret;
> +	u32 clk_resume_ctrl_reg;
> +	u32 val = 0;
> +	u32 retry_count = 0;
> +
> +	if (bus->prop.hw_disabled || !ctrl->startup_done) {

same here

> +		dev_dbg(bus->dev, "SoundWire master %d is disabled or not-started, ignoring\n",
> +			bus->link_id);
> +		return 0;
> +	}
> +
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		clk_resume_ctrl_reg = ACP_SW_CLK_RESUME_CTRL;
> +		break;
> +	case ACP_SDW1:
> +		clk_resume_ctrl_reg = ACP_P1_SW_CLK_RESUME_CTRL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

select registers in the probe.

> +
> +	if (ctrl->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
> +		ret = amd_sdwc_clock_stop_exit(ctrl);
> +		if (ret)
> +			return ret;
> +	} else if (ctrl->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
> +		val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
> +		if (val) {
> +			val |= AMD_SDW_CLK_RESUME_REQ;
> +			acp_reg_writel(val, ctrl->mmio + clk_resume_ctrl_reg);
> +			do {
> +				val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
> +				if (val & AMD_SDW_CLK_RESUME_DONE)
> +					break;
> +				usleep_range(10, 100);
> +			} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
> +			if (val & AMD_SDW_CLK_RESUME_DONE) {
> +				acp_reg_writel(0, ctrl->mmio + clk_resume_ctrl_reg);
> +				ctrl->clk_stopped = false;
> +			}
> +		}
> +		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
> +		amd_init_sdw_controller(ctrl);
> +		amd_enable_sdw_interrupts(ctrl);
> +		ret = amd_enable_sdw_controller(ctrl);
> +		if (ret)
> +			return ret;
> +		ret = amd_sdwc_set_frameshape(ctrl, 50, 10);

this should be defined at probe time, using magic numbers like this will
not work in all cases and totally depends on the frame rate and
bandwidth needs.

> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
