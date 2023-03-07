Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FADF6AE5FB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCGQJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCGQIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:08:40 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD877A90E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678205246; x=1709741246;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aKRuKYTcqGrUuI2WKGB8Q8fERVnjNx4bLC45l3EvKXk=;
  b=HY5wsD4wLMp/ImbcCVieEvkm6b4ZDpCYLOCHTol9jkAKFSTskyo7E3kO
   Eaes0T5gTCbze58zeBzwaqdITdPQFWHksPyvKjUXsTNOCYP/QbnGszarj
   xIGhaUKha186R74VrLH6HjlCfZPhK8gKg+m+6civD7KOi4X73M3MciSMI
   /aqoIb7zESA9FDT+QIHzDcV+MHI9LdMdU72wjTcR/XLJCIi4eFprNr7hR
   kqinrG0vKd7wrKcB9wIcnZ4fFf21KMOsGvfPl4xM44KNkuZGuDyYzGFm3
   2u+pabOPXTQa21gXl3e/sQzAcOHsxFzq1v87ZgcKnoDk6Xae01/bwkp5r
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="334603054"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="334603054"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 08:06:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="786744558"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="786744558"
Received: from mcdoll-mobl.amr.corp.intel.com (HELO [10.255.36.231]) ([10.255.36.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 08:06:17 -0800
Message-ID: <09453549-73b3-bedb-89f6-61d482cabdf9@linux.intel.com>
Date:   Tue, 7 Mar 2023 09:25:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V6 2/8] soundwire: amd: Add support for AMD Manager driver
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-3-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230307133135.545952-3-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int amd_init_sdw_manager(struct amd_sdw_manager *amd_manager)
> +{
> +	u32 val;
> +	int ret;
> +
> +	acp_reg_writel(AMD_SDW_ENABLE, amd_manager->mmio + ACP_SW_EN);
> +	ret = read_poll_timeout(acp_reg_readl, val, val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
> +				amd_manager->mmio + ACP_SW_EN_STATUS);
> +	if (ret)
> +		return ret;
> +
> +	/* SoundWire manager bus reset */
> +	acp_reg_writel(AMD_SDW_BUS_RESET_REQ, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
> +	ret = read_poll_timeout(acp_reg_readl, val, (val & AMD_SDW_BUS_RESET_DONE), ACP_DELAY_US,
> +				AMD_SDW_TIMEOUT, false, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
> +	if (ret)
> +		return ret;
> +
> +	acp_reg_writel(AMD_SDW_BUS_RESET_CLEAR_REQ, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
> +	ret = read_poll_timeout(acp_reg_readl, val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
> +				amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
> +	if (ret) {
> +		dev_err(amd_manager->dev, "Failed to reset SoundWire manager instance%d\n",
> +			amd_manager->instance);
> +		return ret;
> +	}
> +
> +	acp_reg_writel(AMD_SDW_DISABLE, amd_manager->mmio + ACP_SW_EN);
> +	return read_poll_timeout(acp_reg_readl, val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
> +				 amd_manager->mmio + ACP_SW_EN_STATUS);
> +}

ironically the change to use read_poll_timeout makes the code less clear
IMHO, specifically because the success criteria are

'val', 'val & AMD_SDW_BUS_RESET_DONE', '!val', '!val'

It's hard to review and hard to spot potential issues. You may want to
add comments on what you are trying to check. Same comment for all the
rest of the code.

> +
> +static int amd_enable_sdw_manager(struct amd_sdw_manager *amd_manager)
> +{
> +	u32 val;
> +
> +	acp_reg_writel(AMD_SDW_ENABLE, amd_manager->mmio + ACP_SW_EN);
> +	return read_poll_timeout(acp_reg_readl, val, val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
> +				 amd_manager->mmio + ACP_SW_EN_STATUS);
> +}
> +
> +static int amd_disable_sdw_manager(struct amd_sdw_manager *amd_manager)
> +{
> +	u32 val;
> +
> +	acp_reg_writel(AMD_SDW_DISABLE, amd_manager->mmio + ACP_SW_EN);
> +	/*
> +	 * After invoking manager disable sequence, check whether
> +	 * manager has executed clock stop sequence. In this case,
> +	 * manager should ignore checking enable status register.
> +	 */
> +	val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
> +	if (val)
> +		return 0;
> +	return read_poll_timeout(acp_reg_readl, val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
> +				 amd_manager->mmio + ACP_SW_EN_STATUS);
> +}
> +
> +static void amd_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
> +{
> +	struct sdw_manager_reg_mask *reg_mask = amd_manager->reg_mask;
> +	u32 val;
> +
> +	mutex_lock(amd_manager->acp_sdw_lock);
> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
> +	val |= reg_mask->acp_sdw_intr_mask;
> +	acp_reg_writel(val, amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
> +	mutex_unlock(amd_manager->acp_sdw_lock);
> +
> +	acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
> +		       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
> +	acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11, amd_manager->mmio +
> +		       ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
> +	acp_reg_writel(AMD_SDW_IRQ_ERROR_MASK, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
> +}
> +
> +static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
> +{
> +	struct sdw_manager_reg_mask *reg_mask = amd_manager->reg_mask;
> +	u32 val;
> +
> +	mutex_lock(amd_manager->acp_sdw_lock);
> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
> +	val &= ~reg_mask->acp_sdw_intr_mask;
> +	acp_reg_writel(val, amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
> +	mutex_unlock(amd_manager->acp_sdw_lock);
> +
> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
> +}
> +
> +static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
> +{
> +	u32 frame_size;
> +
> +	frame_size = (amd_manager->rows_index << 3) | amd_manager->cols_index;
> +	acp_reg_writel(frame_size, amd_manager->mmio + ACP_SW_FRAMESIZE);
> +}
> +
> +static void amd_sdw_ctl_word_prep(u32 *lower_word, u32 *upper_word, u32 cmd_type,
> +				  struct sdw_msg *msg, int cmd_offset)
> +{
> +	u32 upper_data;
> +	u32 lower_data = 0;
> +	u16 addr;
> +	u8 addr_upper, addr_lower;

nit-pick: use the same convention for data and addr, e.g. upper_data,
upper_addr. Same comment for the rest of the code.

> +	u8 data = 0;
> +
> +	addr = msg->addr + cmd_offset;
> +	addr_upper = (addr & 0xFF00) >> 8;
> +	addr_lower = addr & 0xFF;
> +
> +	if (cmd_type == AMD_SDW_CMD_WRITE)
> +		data = msg->buf[cmd_offset];
> +
> +	upper_data = FIELD_PREP(AMD_SDW_MCP_CMD_DEV_ADDR, msg->dev_num);
> +	upper_data |= FIELD_PREP(AMD_SDW_MCP_CMD_COMMAND, cmd_type);
> +	upper_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_HIGH, addr_upper);
> +	lower_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_LOW, addr_lower);
> +	lower_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_DATA, data);
> +
> +	*upper_word = upper_data;
> +	*lower_word = lower_data;
> +}
