Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3B3694F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjBMSZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBMSYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:24:52 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633411BE1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676312691; x=1707848691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c+q7Nn9Rsvv1nO+4W6DB2XtQZhG0cfDRiAWTu+oyL1k=;
  b=H3xVc7TKYHQslpR2e/sCGpOsV6HDzbGufJOUyQlYbuAYqzQ4ZvXxnl25
   oDdMR64myboUAj2FfqKXepVyYeudjInaNnH4r/7NnfdV1Ys8tvuwaYgcq
   5ctELlkEQc0ALcAkDjK2bnt5ELYwm9sDGxvLHzEFsZd8O7vyCzPs3xb83
   6LL7sVUhsb9W+pyEyCLRJ8+NoUtJlSdhTJs8MvbNRQFlbO6t3i12CCB9H
   Nirwk5sTjCLMu0swoQOcR7qhszXbzBKQm2xpJRChK9qRlIEIiS7Vb0qPW
   t4m++7LxJYtbw+MfC+zL9gwOU0fwHn/Sa2Npn94vGE7GRunxJdmcpzGeE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="328664081"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="328664081"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:24:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="701369326"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="701369326"
Received: from eatoledo-mobl.amr.corp.intel.com (HELO [10.212.18.132]) ([10.212.18.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:24:40 -0800
Message-ID: <383a8166-bc60-8557-e76b-f6287c967598@linux.intel.com>
Date:   Mon, 13 Feb 2023 12:20:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V2 6/8] soundwire: amd: add runtime pm ops for AMD
 soundwire manager driver
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, vkoul@kernel.org
Cc:     amadeuszx.slawinski@linux.intel.com, Mario.Limonciello@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
 <20230213094031.2231058-7-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230213094031.2231058-7-Vijendar.Mukunda@amd.com>
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



On 2/13/23 03:40, Vijendar Mukunda wrote:
> Add support for runtime pm ops for AMD soundwire manager driver.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
> ---
>  drivers/soundwire/amd_manager.c   | 163 ++++++++++++++++++++++++++++++
>  drivers/soundwire/amd_manager.h   |   3 +
>  include/linux/soundwire/sdw_amd.h |  16 +++
>  3 files changed, 182 insertions(+)
> 
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index 87f9a987d93a..eced189ba6e0 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_registers.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/wait.h>
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> @@ -185,6 +186,15 @@ static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
>  	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>  }
>  
> +static int amd_deinit_sdw_manager(struct amd_sdw_manager *amd_manager)
> +{
> +	int ret;
> +
> +	amd_disable_sdw_interrupts(amd_manager);
> +	ret = amd_disable_sdw_manager(amd_manager);
> +	return ret;
> +}
> +
>  static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
>  {
>  	u32 frame_size;
> @@ -1043,6 +1053,12 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
>  	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
>  	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
>  	schedule_work(&amd_manager->probe_work);
> +	/* Enable runtime PM */
> +	pm_runtime_set_autosuspend_delay(dev, AMD_SDW_MASTER_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);

that doesn't sound good to me, why do this here and not in the work
function? That creates a racy case where the device might suspend before
being initialized.

>  	return 0;
>  }
>  
> @@ -1057,14 +1073,161 @@ static int amd_sdw_manager_remove(struct platform_device *pdev)
>  	amd_disable_sdw_interrupts(amd_manager);
>  	sdw_bus_master_delete(&amd_manager->bus);
>  	ret = amd_disable_sdw_manager(amd_manager);
> +	pm_runtime_disable(&pdev->dev);

shouldn't you do the pm_runtime_disable first?

>  	return ret;
>  }

> +/* AMD pm_runtime quirk definitions */
> +
> +/*
> + * Force the clock to stop(ClockStopMode0) when suspend callback
> + * is invoked.
> + */
> +#define AMD_SDW_CLK_STOP_MODE		1
> +
> +/*
> + * Stop the bus when runtime suspend/system level suspend callback
> + * is invoked. If set, a complete bus reset and re-enumeration will
> + * be performed when the bus restarts.
> + */
> +#define AMD_SDW_POWER_OFF_MODE		2

You need to clarify this mode, can you deal with device in-band wakes if
the power is off?

>  #define ACP_SDW0	0
>  #define ACP_SDW1	1
>  
> @@ -57,6 +71,7 @@ struct sdw_amd_dai_runtime {
>   * @instance: soundwire manager instance
>   * @quirks: soundwire manager quirks
>   * @wake_en_mask: wake enable mask per soundwire manager
> + * @clk_stopped: flag set to true when clock is stopped
>   * @power_mode_mask: flag interprets amd soundwire manager power mode
>   * @dai_runtime_array: dai runtime array
>   */
> @@ -86,6 +101,7 @@ struct amd_sdw_manager {
>  	u32 quirks;
>  	u32 wake_en_mask;
>  	u32 power_mode_mask;
> +	bool clk_stopped;
>  
>  	struct sdw_amd_dai_runtime **dai_runtime_array;
>  };
