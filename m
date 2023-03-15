Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DEF6BAD0B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjCOKHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjCOKH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:07:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A864BE8F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8B2361CC3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB50C433EF;
        Wed, 15 Mar 2023 10:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678874813;
        bh=a1mBgV1xiO8Grnca7MjKIp4dVrfIFe61NhyeSSkXJvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COg5KEa4yQ+1jyzTij5CZJvyoDVHmbYd48Dsty1NHaKfFNASUDoxWEFMna0I5OQEM
         DO8HD9OwxjZCjvWx/W6t28J0zpjAIDNxmRDpzHNRHVub+QL+j3aMDnQRmquPGpXZ9y
         YWHpFfexpcEs0unxHMTqcYAFS/AIWYRf9leHNS1kPNGJkj0zHMiyKKvumJweusEV9C
         pjgzaDm84fRnPTwj3X+1WvTmajaYTWLddZNxHkqCi4wG8+AEscHJsLkmhjlqDA9k8o
         w2pdnan8ZRwpCQHxc5Eyk7GUeQclaURJjqlqAYv7HW6XSA6Bzs0UXI7L01aXw3uWf5
         xrNZSugTNASqg==
Date:   Wed, 15 Mar 2023 15:36:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, amadeuszx.slawinski@linux.intel.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 5/8] soundwire: amd: add SoundWire manager interrupt
 handling
Message-ID: <ZBGYubOYyu7E8ueo@matsya>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-6-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307133135.545952-6-Vijendar.Mukunda@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-03-23, 19:01, Vijendar Mukunda wrote:
> Add support for handling SoundWire manager interrupts.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Link: https://lore.kernel.org/lkml/20230227154801.50319-6-Vijendar.Mukunda@amd.com
> ---
>  drivers/soundwire/amd_manager.c   | 130 ++++++++++++++++++++++++++++++
>  drivers/soundwire/amd_manager.h   |   1 +
>  include/linux/soundwire/sdw_amd.h |   7 ++
>  3 files changed, 138 insertions(+)
> 
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index dd7fd4036d89..165078beca2e 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -357,6 +357,51 @@ static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sd
>  	return SDW_CMD_OK;
>  }
>  
> +static void amd_sdw_fill_slave_status(struct amd_sdw_manager *amd_manager, u16 index, u32 status)
> +{
> +	switch (status) {
> +	case SDW_SLAVE_ATTACHED:
> +		amd_manager->status[index] = SDW_SLAVE_ATTACHED;
> +		break;
> +	case SDW_SLAVE_UNATTACHED:
> +		amd_manager->status[index] = SDW_SLAVE_UNATTACHED;
> +		break;
> +	case SDW_SLAVE_ALERT:
> +		amd_manager->status[index] = SDW_SLAVE_ALERT;
> +		break;

why not:

        case SDW_SLAVE_ATTACHED:
        case SDW_SLAVE_UNATTACHED:
        case SDW_SLAVE_ALERT:
                amd_manager->status[index] = status;
                break;

> +	default:
> +		amd_manager->status[index] = SDW_SLAVE_RESERVED;
> +		break;
> +	}
> +}
> +
> +static void amd_sdw_process_ping_status(u64 response, struct amd_sdw_manager *amd_manager)
> +{
> +	u64 slave_stat;
> +	u32 val;
> +	u16 dev_index;
> +
> +	/* slave status response */
> +	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
> +	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
> +	dev_dbg(amd_manager->dev, "slave_stat:0x%llx\n", slave_stat);
> +	for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
> +		val = (slave_stat >> (dev_index * 2)) & AMD_SDW_MCP_SLAVE_STATUS_MASK;
> +		dev_dbg(amd_manager->dev, "val:0x%x\n", val);
> +		amd_sdw_fill_slave_status(amd_manager, dev_index, val);
> +	}
> +}
> +
> +static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_manager)
> +{
> +	u64 response;
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
> @@ -757,6 +802,89 @@ static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
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
> +	/*
> +	 * During the peripheral enumeration sequence, the SoundWire manager interrupts
> +	 * are masked. Once the device number programming is done for all peripherals,
> +	 * interrupts will be unmasked. Read the peripheral device status from ping command
> +	 * and process the response. This sequence will ensure all peripheral devices enumerated
> +	 * and initialized properly.
> +	 */
> +	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
> +		if (retry_count++ < SDW_MAX_DEVICES) {
> +			acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
> +				       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
> +			acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
> +				       amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
> +			amd_sdw_read_and_process_ping_status(amd_manager);
> +			goto update_status;

goto are mostly used for error handling, i dont thing case here deserves
a goto, can you please change this...

> +		} else {
> +			dev_err_ratelimited(amd_manager->dev,
> +					    "Device0 detected after %d iterations\n",
> +					    retry_count);
> +		}
> +	}
> +}
> +
> +static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_change_8to11,
> +					struct amd_sdw_manager *amd_manager)
> +{
> +	u64 slave_stat;
> +	u32 val;
> +	int dev_index;
> +
> +	if (status_change_0to7 == AMD_SDW_SLAVE_0_ATTACHED)
> +		memset(amd_manager->status, 0, sizeof(amd_manager->status));
> +	slave_stat = status_change_0to7;
> +	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STATUS_8TO_11, status_change_8to11) << 32;
> +	dev_dbg(amd_manager->dev, "status_change_0to7:0x%x status_change_8to11:0x%x\n",
> +		status_change_0to7, status_change_8to11);
> +	if (slave_stat) {
> +		for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
> +			if (slave_stat & AMD_SDW_MCP_SLAVE_STATUS_VALID_MASK(dev_index)) {
> +				val = (slave_stat >> AMD_SDW_MCP_SLAVE_STAT_SHIFT_MASK(dev_index)) &
> +				      AMD_SDW_MCP_SLAVE_STATUS_MASK;
> +				amd_sdw_fill_slave_status(amd_manager, dev_index, val);
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
> +	dev_dbg(amd_manager->dev, "[SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
> +		amd_manager->instance, status_change_0to7, status_change_8to11);
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
> +
>  static void amd_sdw_probe_work(struct work_struct *work)
>  {
>  	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
> @@ -847,6 +975,8 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  	dev_set_drvdata(dev, amd_manager);
> +	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
> +	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
>  	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
>  	/*
>  	 * Instead of having lengthy probe sequence, use deferred probe.
> diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
> index cad26034087b..807bc5a314d8 100644
> --- a/drivers/soundwire/amd_manager.h
> +++ b/drivers/soundwire/amd_manager.h
> @@ -185,6 +185,7 @@
>  #define AMD_SDW1_PAD_KEEPER_EN_MASK			0x10
>  #define AMD_SDW0_PAD_KEEPER_DISABLE_MASK		0x1E
>  #define AMD_SDW1_PAD_KEEPER_DISABLE_MASK		0xF
> +#define AMD_SDW_PREQ_INTR_STAT				BIT(19)
>  
>  enum amd_sdw_cmd_type {
>  	AMD_SDW_CMD_PING = 0,
> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
> index ac537419301d..df60bc0de6fc 100644
> --- a/include/linux/soundwire/sdw_amd.h
> +++ b/include/linux/soundwire/sdw_amd.h
> @@ -45,8 +45,11 @@ struct sdw_amd_dai_runtime {
>   * @mmio: SoundWire registers mmio base
>   * @acp_mmio: acp registers mmio base
>   * @reg_mask: register mask structure per manager instance
> + * @amd_sdw_irq_thread: SoundWire manager irq workqueue
> + * @amd_sdw_work: peripheral status work queue
>   * @probe_work: SoundWire manager probe workqueue
>   * @acp_sdw_lock: mutex to protect acp share register access
> + * @status: peripheral devices status array
>   * @num_din_ports: number of input ports
>   * @num_dout_ports: number of output ports
>   * @cols_index: Column index in frame shape
> @@ -65,10 +68,14 @@ struct amd_sdw_manager {
>  	void __iomem *acp_mmio;
>  
>  	struct sdw_manager_reg_mask *reg_mask;
> +	struct work_struct amd_sdw_irq_thread;
> +	struct work_struct amd_sdw_work;
>  	struct work_struct probe_work;
>  	/* mutex to protect acp common register access */
>  	struct mutex *acp_sdw_lock;
>  
> +	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
> +
>  	int num_din_ports;
>  	int num_dout_ports;
>  
> -- 
> 2.34.1

-- 
~Vinod
