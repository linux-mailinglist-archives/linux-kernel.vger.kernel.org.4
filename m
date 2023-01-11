Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E136660A6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjAKQgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjAKQgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:36:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D240C6244
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673454960; x=1704990960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=76lSxpjS7AmOwz8nezqUoaA4XsIIg5n3XpwLhwUttg0=;
  b=ivLGY70PwzNo+Co+NonYKjAun2PWjZaKdmHZq4OD8JJYEThCZg1lD11/
   i52YubyyN26KrNLgHXltSDUgNXF/Vaf5BksLRAZ8NcIYQ5mAzRLTHDmJ6
   kov6yC44ewvlsQFMkNgaWwGKbmrbK//sNyMxrEzj4dMzJAUeXxrCy14wQ
   fxhS18jdgLStTh/yIk/pVQ/Tgio4V9nVwfI8bC2zD/CWdgUggYm3R1njP
   vZjEnkAiuoK838vhf1GLzoq9tx4i+UclaVfS3EeNEAUc8IIlresRY3Pfj
   ctWDVb/acqzmjLpkhgaaNFNiLYE1XNlBDfiZJaPsNjFwJyTV/ibmD2lAA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324704054"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324704054"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607408415"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607408415"
Received: from flobatol-mobl1.amr.corp.intel.com (HELO [10.212.110.208]) ([10.212.110.208])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:16 -0800
Message-ID: <ff99cf26-56df-a3ae-ca0d-691d0cb034fc@linux.intel.com>
Date:   Wed, 11 Jan 2023 09:19:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 05/19] soundwire: amd: add soundwire interrupt handling
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
 <20230111090222.2016499-6-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230111090222.2016499-6-Vijendar.Mukunda@amd.com>
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




>  
> +static void amd_sdwc_process_ping_status(u64 response, struct amd_sdwc_ctrl *ctrl)
> +{
> +	u64 slave_stat = 0;
> +	u32 val = 0;
> +	u16 dev_index;
> +
> +	/* slave status from ping response*/

response */

> +	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
> +	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
> +
> +	dev_dbg(ctrl->dev, "%s: slave_stat:0x%llx\n", __func__, slave_stat);
> +	for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
> +		val = (slave_stat >> (dev_index * 2)) & AMD_SDW_MCP_SLAVE_STATUS_MASK;
> +		dev_dbg(ctrl->dev, "%s val:0x%x\n", __func__, val);
> +		switch (val) {
> +		case SDW_SLAVE_ATTACHED:
> +			ctrl->status[dev_index] = SDW_SLAVE_ATTACHED;
> +			break;
> +		case SDW_SLAVE_UNATTACHED:
> +			ctrl->status[dev_index] = SDW_SLAVE_UNATTACHED;
> +			break;
> +		case SDW_SLAVE_ALERT:
> +			ctrl->status[dev_index] = SDW_SLAVE_ALERT;
> +			break;
> +		default:
> +			ctrl->status[dev_index] = SDW_SLAVE_RESERVED;
> +			break;
> +		}
> +	}
> +}
> +
> +static void amd_sdwc_read_and_process_ping_status(struct amd_sdwc_ctrl *ctrl)
> +{
> +	u64 response = 0;
> +
> +	mutex_lock(&ctrl->bus.msg_lock);
> +	response = amd_sdwc_send_cmd_get_resp(ctrl, 0, 0);
> +	mutex_unlock(&ctrl->bus.msg_lock);
> +	amd_sdwc_process_ping_status(response, ctrl);

Is this saying that you actually need to send a PING frame manually
every time the manager needs to check the device status, including
interrupts?

> +}
> +
>  static u32 amd_sdwc_read_ping_status(struct sdw_bus *bus)
>  {
>  	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
> @@ -1132,6 +1173,119 @@ static int amd_sdwc_register_dais(struct amd_sdwc_ctrl *ctrl)
>  					       dais, num_dais);
>  }
>  
> +static void amd_sdwc_update_slave_status_work(struct work_struct *work)
> +{
> +	struct amd_sdwc_ctrl *ctrl =
> +		container_of(work, struct amd_sdwc_ctrl, amd_sdw_work);
> +	u32 sw_status_change_mask_0to7_reg;
> +	u32 sw_status_change_mask_8to11_reg;
> +
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		sw_status_change_mask_0to7_reg = SW_STATE_CHANGE_STATUS_MASK_0TO7;
> +		sw_status_change_mask_8to11_reg = SW_STATE_CHANGE_STATUS_MASK_8TO11;
> +		break;
> +	case ACP_SDW1:
> +		sw_status_change_mask_0to7_reg = P1_SW_STATE_CHANGE_STATUS_MASK_0TO7;
> +		sw_status_change_mask_8to11_reg = P1_SW_STATE_CHANGE_STATUS_MASK_8TO11;
> +		break;
> +	default:
> +		dev_err(ctrl->dev, "Invalid Soundwire controller instance\n");
> +		return;
> +	}
> +
> +	if (ctrl->status[0] == SDW_SLAVE_ATTACHED) {
> +		acp_reg_writel(0, ctrl->mmio + sw_status_change_mask_0to7_reg);
> +		acp_reg_writel(0, ctrl->mmio + sw_status_change_mask_8to11_reg);
> +	}
> +
> +update_status:
> +	sdw_handle_slave_status(&ctrl->bus, ctrl->status);
> +	if (ctrl->status[0] == SDW_SLAVE_ATTACHED) {
> +		acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, ctrl->mmio + sw_status_change_mask_0to7_reg);
> +		acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
> +			       ctrl->mmio + sw_status_change_mask_8to11_reg);
> +		amd_sdwc_read_and_process_ping_status(ctrl);
> +		goto update_status;
> +	}

well no, you have to use some sort of retry count. You cannot handle
interrupts in a loop like this, a faulty or chatty device would keep
signaling an issue and you would be stuck here for a while.

In addition, it's not clear if this is really needed. We added this loop
in cadence_master.c because of issues with multiple devices becoming
attached at the same time and how the hardware works. As it turns out,
this update_status loop seems to be a paranoid case, the actually cause
for devices de-attaching was found by Cirrus Logic and fixed in
"soundwire: cadence: fix updating slave status when a bus has multiple
peripherals"

You would need to explain how the status is detected and if any race
conditions can occur.

