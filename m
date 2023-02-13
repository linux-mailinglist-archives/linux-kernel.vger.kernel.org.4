Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C74C694F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBMSZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBMSYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:24:52 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7DA134
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676312691; x=1707848691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tMEckqgOlH5nqIW0iJkz8l92zxlASQbCXtqfirb5BWY=;
  b=liQOAVRTGdAtTe1C9ey4iLGxM+UHL7+13YqRGsQSP/YVm3MYYxnMO/uF
   pjt2eOdlGQKi60WaUPeC5BKYzq91sNKSE1uWvZPnmRKt0EMJ589L2LA+n
   IRuiTGwOzo6mZAf4vlZhx4L0HWM8rxTR1vMV3KgDJg8Hzv7z2CJcBZhw9
   BAPZWocCxIpRAZSqL5bl6BPioYXQRVlJ70XixMY+yc/lPDu7ShEVZ8fSS
   fRau8jdifcXky45FeBlJj/LX+GXnYMh6i5g0pZR3ODUTjoeY//qZerZP5
   zerv8rHsUec/N6LHC/xsiNgjzMAaf8gGsZeZZcvfWucEGFl/SJGYbxcA4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="328664088"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="328664088"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:24:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="701369338"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="701369338"
Received: from eatoledo-mobl.amr.corp.intel.com (HELO [10.212.18.132]) ([10.212.18.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:24:42 -0800
Message-ID: <cd70a91c-231e-1bca-b0ac-4041cba0daad@linux.intel.com>
Date:   Mon, 13 Feb 2023 12:24:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V2 7/8] soundwire: amd: handle soundwire wake enable
 interrupt
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
 <20230213094031.2231058-8-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230213094031.2231058-8-Vijendar.Mukunda@amd.com>
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
> Add wake enable interrupt support for both the soundwire manager
> instances.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
> ---
>  drivers/soundwire/amd_manager.c | 10 ++++++++++
>  drivers/soundwire/amd_manager.h |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index eced189ba6e0..e53dc67f8529 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -934,6 +934,13 @@ static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_chang
>  	}
>  }
>  
> +static void amd_sdw_process_wake_event(struct amd_sdw_manager *amd_manager)
> +{
> +	pm_request_resume(amd_manager->dev);
> +	acp_reg_writel(0x00, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
> +}
> +
>  static void amd_sdw_irq_thread(struct work_struct *work)
>  {
>  	struct amd_sdw_manager *amd_manager =
> @@ -945,6 +952,9 @@ static void amd_sdw_irq_thread(struct work_struct *work)
>  	status_change_0to7 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
>  	dev_dbg(amd_manager->dev, "%s [SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
>  		__func__, amd_manager->instance, status_change_0to7, status_change_8to11);
> +	if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK)
> +		return amd_sdw_process_wake_event(amd_manager);
> +

it's not clear what 8to11 might have to do with the wake enable?

Can't you have a wake for devices 1..7?


>  	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
>  		amd_sdw_read_and_process_ping_status(amd_manager);
>  	} else {
> diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
> index 6ec37612ae4e..86bc6d4f48bf 100644
> --- a/drivers/soundwire/amd_manager.h
> +++ b/drivers/soundwire/amd_manager.h
> @@ -190,6 +190,7 @@
>  #define AMD_SDW_CLK_STOP_DONE				1
>  #define AMD_SDW_CLK_RESUME_REQ				2
>  #define AMD_SDW_CLK_RESUME_DONE				3
> +#define AMD_SDW_WAKE_STAT_MASK				BIT(16)
>  
>  enum amd_sdw_cmd_type {
>  	AMD_SDW_CMD_PING = 0,
