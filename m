Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3A3694F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjBMSY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjBMSYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:24:51 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B70A1711
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676312690; x=1707848690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7YaAWm/KKRyxxvUTQf+fqxSN7Zv8wytNiNs/ZTuD2/E=;
  b=DKTJQj1/O2vfbRTpk5Ss6Nl/KPah0pfgtkTxrWTAchDRuVZqnZJvwmes
   NL1FJuRCHVfYeeQm9C4W0Sj3L6bTPCl+9FxRtQeS780WU0M5DyyBLZG58
   d/P8kSRwm5RUxCI2LLvV+Fx6zZFQglUz5xijowE74q8eGU3CiD+u5HqZl
   V8fc6xRJu6L3AV5d3JYDJWZwH3TFNzZt1iW2TpnRSOx4Ou1IpFrbCPrCL
   4KIipwmbjyxGU++Ba9APuBFFYgrQWNA6p3wVaHkifbxFo8ovW3jmefqRs
   SQWOjG+/tNgZRPjHUuFOaPvdaoLVc2UvUc0J1VCgQjDC98PJ/0DJAodhu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="328664071"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="328664071"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:24:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="701369311"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="701369311"
Received: from eatoledo-mobl.amr.corp.intel.com (HELO [10.212.18.132]) ([10.212.18.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:24:38 -0800
Message-ID: <9505941e-73a1-249b-08c2-83b86e7ef5c6@linux.intel.com>
Date:   Mon, 13 Feb 2023 12:15:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V2 5/8] soundwire: amd: add soundwire manager interrupt
 handling
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
 <20230213094031.2231058-6-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230213094031.2231058-6-Vijendar.Mukunda@amd.com>
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
> Add support for handling soundwire manager interrupts.

Try using the MIPI spelling: SoundWire

> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
> ---
>  drivers/soundwire/amd_manager.c   | 132 ++++++++++++++++++++++++++++++
>  drivers/soundwire/amd_manager.h   |   1 +
>  include/linux/soundwire/sdw_amd.h |   7 ++
>  3 files changed, 140 insertions(+)
> 
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index 14c88b80ab6d..87f9a987d93a 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -417,6 +417,47 @@ static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sd
>  	return SDW_CMD_OK;
>  }
>  
> +static void amd_sdw_process_ping_status(u64 response, struct amd_sdw_manager *amd_manager)
> +{
> +	u64 slave_stat = 0;

useless init

> +	u32 val = 0;

useless init

> +	u16 dev_index;
> +
> +	/* slave status response*/

response */

> +	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
> +	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
> +
> +	dev_dbg(amd_manager->dev, "%s: slave_stat:0x%llx\n", __func__, slave_stat);

newline?

> +	for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
> +		val = (slave_stat >> (dev_index * 2)) & AMD_SDW_MCP_SLAVE_STATUS_MASK;
> +		dev_dbg(amd_manager->dev, "%s val:0x%x\n", __func__, val);

you don't need __func__ in dev_dbg() logs, they can be added e.g. with
the option dyndbg=+pmf

> +		switch (val) {
> +		case SDW_SLAVE_ATTACHED:
> +			amd_manager->status[dev_index] = SDW_SLAVE_ATTACHED;
> +			break;
> +		case SDW_SLAVE_UNATTACHED:
> +			amd_manager->status[dev_index] = SDW_SLAVE_UNATTACHED;
> +			break;
> +		case SDW_SLAVE_ALERT:
> +			amd_manager->status[dev_index] = SDW_SLAVE_ALERT;
> +			break;
> +		default:
> +			amd_manager->status[dev_index] = SDW_SLAVE_RESERVED;
> +			break;
> +		}
> +	}
> +}
> +
> +static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_manager)
> +{
> +	u64 response = 0;

useless init

> +
> +	mutex_lock(&amd_manager->bus.msg_lock);
> +	response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
> +	mutex_unlock(&amd_manager->bus.msg_lock);
> +	amd_sdw_process_ping_status(response, amd_manager);
> +}
> +
>  static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
>  {
>  	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
> @@ -817,6 +858,95 @@ static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
>  					       dais, num_dais);
>  }
>  
> +static void amd_sdw_update_slave_status_work(struct work_struct *work)
> +{
> +	struct amd_sdw_manager *amd_manager =
> +		container_of(work, struct amd_sdw_manager, amd_sdw_work);
> +	int retry_count = 0;
> +
> +	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
> +		acp_reg_writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
> +		acp_reg_writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
> +	}
> +
> +update_status:
> +	sdw_handle_slave_status(&amd_manager->bus, amd_manager->status);
> +	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
> +		if (retry_count++ < SDW_MAX_DEVICES) {
> +			acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
> +				       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
> +			acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
> +				       amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
> +			amd_sdw_read_and_process_ping_status(amd_manager);
> +			goto update_status;
> +		} else {
> +			dev_err_ratelimited(amd_manager->dev,
> +					    "Device0 detected after %d iterations\n",
> +					    retry_count);
> +		}
> +	}

this seems rather inspired by the Cadence code, but is there really a
case where you need to re-check for devices? In the Cadence case, this
was added because we have a logical OR and new devices would not be handled.
> +}
> +
> +static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_change_8to11,
> +					struct amd_sdw_manager *amd_manager)
> +{
> +	u64 slave_stat = 0;

useless init

> +	u32 val = 0;

useless init

> +	int dev_index;
> +
> +	if (status_change_0to7 == AMD_SDW_SLAVE_0_ATTACHED)
> +		memset(amd_manager->status, 0, sizeof(amd_manager->status));
> +	slave_stat = status_change_0to7;
> +	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STATUS_8TO_11, status_change_8to11) << 32;
> +	dev_dbg(amd_manager->dev, "%s: status_change_0to7:0x%x status_change_8to11:0x%x\n",
> +		__func__, status_change_0to7, status_change_8to11);
> +	if (slave_stat) {
> +		for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
> +			if (slave_stat & AMD_SDW_MCP_SLAVE_STATUS_VALID_MASK(dev_index)) {
> +				val = (slave_stat >> AMD_SDW_MCP_SLAVE_STAT_SHIFT_MASK(dev_index)) &
> +				      AMD_SDW_MCP_SLAVE_STATUS_MASK;
> +				switch (val) {
> +				case SDW_SLAVE_ATTACHED:
> +					amd_manager->status[dev_index] = SDW_SLAVE_ATTACHED;
> +					break;
> +				case SDW_SLAVE_UNATTACHED:
> +					amd_manager->status[dev_index] = SDW_SLAVE_UNATTACHED;
> +					break;
> +				case SDW_SLAVE_ALERT:
> +					amd_manager->status[dev_index] = SDW_SLAVE_ALERT;
> +					break;
> +				default:
> +					amd_manager->status[dev_index] = SDW_SLAVE_RESERVED;
> +					break;
> +				}

the code seems identical to that in amd_sdw_process_ping_status(), is
there a need for a helper function?

> +			}
> +		}
> +	}
> +}
> +
> +static void amd_sdw_irq_thread(struct work_struct *work)
> +{
> +	struct amd_sdw_manager *amd_manager =
> +			container_of(work, struct amd_sdw_manager, amd_sdw_irq_thread);
> +	u32 status_change_8to11;
> +	u32 status_change_0to7;
> +
> +	status_change_8to11 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
> +	status_change_0to7 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
> +	dev_dbg(amd_manager->dev, "%s [SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
> +		__func__, amd_manager->instance, status_change_0to7, status_change_8to11);

remove __func__

> +	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
> +		amd_sdw_read_and_process_ping_status(amd_manager);
> +	} else {
> +		/* Check for the updated status on peripheral device */
> +		amd_sdw_update_slave_status(status_change_0to7, status_change_8to11, amd_manager);
> +	}
> +	if (status_change_8to11 || status_change_0to7)
> +		schedule_work(&amd_manager->amd_sdw_work);
> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
> +}
