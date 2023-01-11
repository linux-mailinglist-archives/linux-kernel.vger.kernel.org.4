Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B101665D36
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjAKN76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjAKN7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:59:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAD7283
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673445590; x=1704981590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6GmdrrfPAFrTCzpxyHGgTB46FlBc6juYoJFaKX7l39E=;
  b=Z31EYzM7I1N3XpWwOeCUBUp1PkFIf7PhTyN9HYy1OhfxrSW7E6b/h1xs
   DfAaMHl9kZUbQM1Wu/IMu0RZkm5PDtdybH7m1YUHDFS0OnA6EfhcB145p
   qy9gE/kjEEKnYKtvfBk8EsxN4Mqfjbs03ObpIXsJMTHjWXbq8gtQ3Rj53
   xPzM82HfWe5SXQtaIN1HUpWm6CE+aRpZLdnmMQn6n9ZnFJ8W6GeZct2jh
   wDA1Ilm2hwZtQR9JfWT6uUxdyXus9H8x7YMyVrbczeZnWzTwib8i0+n5L
   X/9MIlnRspYRP2qTOW5qtSoWhYieCChZMWDs0bQ0hK/eTRqVUNsjL/u2u
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324652532"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324652532"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:59:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="687931532"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="687931532"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:59:46 -0800
Message-ID: <5dfc3961-206c-5a42-b648-74944de9212f@linux.intel.com>
Date:   Wed, 11 Jan 2023 14:59:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 02/19] soundwire: amd: Add support for AMD Master driver
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        Basavaraj.Hiregoudar@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Mario.Limonciello@amd.com, arungopal.kondaveeti@amd.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-3-Vijendar.Mukunda@amd.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230111090222.2016499-3-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 1/11/2023 10:02 AM, Vijendar Mukunda wrote:
> AMD ACP IP block has two soundwire controller devices.
> Add support for
> - Master driver probe & remove sequence
> - Helper functions to enable/disable interrupts, Initialize sdw controller,
>    enable sdw pads
> - Master driver sdw_master_ops & port_ops callbacks
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---

...

> +
> +static int amd_sdwc_compute_params(struct sdw_bus *bus)
> +{
> +	struct sdw_transport_data t_data = {0};
> +	struct sdw_master_runtime *m_rt;
> +	struct sdw_port_runtime *p_rt;
> +	struct sdw_bus_params *b_params = &bus->params;
> +	int port_bo, hstart, hstop, sample_int;
> +	unsigned int rate, bps;
> +
> +	port_bo  = 0;

Double space before '='.

> +	hstart = 1;
> +	hstop = bus->params.col - 1;
> +	t_data.hstop = hstop;
> +	t_data.hstart = hstart;
> +
> +	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
> +		rate = m_rt->stream->params.rate;
> +		bps = m_rt->stream->params.bps;
> +		sample_int = (bus->params.curr_dr_freq / rate);
> +		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
> +			port_bo = (p_rt->num * 64) + 1;
> +			dev_dbg(bus->dev, "p_rt->num=%d hstart=%d hstop=%d port_bo=%d\n",
> +				p_rt->num, hstart, hstop, port_bo);
> +			sdw_fill_xport_params(&p_rt->transport_params, p_rt->num,
> +					      false, SDW_BLK_GRP_CNT_1, sample_int,
> +					      port_bo, port_bo >> 8, hstart, hstop,
> +					      SDW_BLK_PKG_PER_PORT, 0x0);
> +
> +			sdw_fill_port_params(&p_rt->port_params,
> +					     p_rt->num, bps,
> +					     SDW_PORT_FLOW_MODE_ISOCH,
> +					     b_params->m_data_mode);
> +			t_data.hstart = hstart;
> +			t_data.hstop = hstop;
> +			t_data.block_offset = port_bo;
> +			t_data.sub_block_offset = 0;
> +		}
> +		amd_sdwc_compute_slave_ports(m_rt, &t_data);
> +	}
> +	return 0;
> +}
> +

...

> +
> +static int amd_sdwc_port_enable(struct sdw_bus *bus,
> +				struct sdw_enable_ch *enable_ch,
> +				unsigned int bank)
> +{
> +	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
> +	u32 dpn_ch_enable;
> +	u32 ch_enable_reg, channel_type;
> +
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		channel_type = enable_ch->port_num;
> +		break;
> +	case ACP_SDW1:
> +		channel_type = enable_ch->port_num + ACP_SDW0_MAX_DAI;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (channel_type) {
> +	case ACP_SDW0_AUDIO_TX:
> +		ch_enable_reg = ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP0;
> +		break;
> +	case ACP_SDW0_HS_TX:
> +		ch_enable_reg = ACP_SW_HEADSET_TX_CHANNEL_ENABLE_DP0;
> +		break;
> +	case ACP_SDW0_BT_TX:
> +		ch_enable_reg = ACP_SW_BT_TX_CHANNEL_ENABLE_DP0;
> +		break;
> +	case ACP_SDW1_BT_TX:
> +		ch_enable_reg = ACP_P1_SW_BT_TX_CHANNEL_ENABLE_DP0;
> +		break;
> +	case ACP_SDW0_AUDIO_RX:
> +		ch_enable_reg = ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP0;
> +		break;
> +	case ACP_SDW0_HS_RX:
> +		ch_enable_reg = ACP_SW_HEADSET_RX_CHANNEL_ENABLE_DP0;
> +		break;
> +	case ACP_SDW0_BT_RX:
> +		ch_enable_reg = ACP_SW_BT_RX_CHANNEL_ENABLE_DP0;
> +		break;
> +	case ACP_SDW1_BT_RX:
> +		ch_enable_reg = ACP_P1_SW_BT_RX_CHANNEL_ENABLE_DP0;
> +		break;
> +	default:
> +		dev_err(bus->dev, "%s:Invalid channel:%d\n", __func__, channel_type);
> +		return -EINVAL;
> +	}
> +
> +	dpn_ch_enable =  acp_reg_readl(ctrl->mmio + ch_enable_reg);

Double space after '='.

> +	u32p_replace_bits(&dpn_ch_enable, enable_ch->ch_mask, AMD_DPN_CH_EN_CHMASK);
> +	if (enable_ch->enable)
> +		acp_reg_writel(dpn_ch_enable, ctrl->mmio + ch_enable_reg);
> +	else
> +		acp_reg_writel(0, ctrl->mmio + ch_enable_reg);
> +	return 0;
> +}
> +

...

> +
> +static void amd_sdwc_probe_work(struct work_struct *work)
> +{
> +	struct amd_sdwc_ctrl *ctrl  = container_of(work, struct amd_sdwc_ctrl, probe_work);

Double space before '='.

> +	struct sdw_master_prop *prop;
> +	int ret;
> +
> +	prop = &ctrl->bus.prop;
> +	if (!prop->hw_disabled) {
> +		ret = amd_enable_sdw_pads(ctrl);
> +		if (ret)
> +			return;
> +		ret = amd_init_sdw_controller(ctrl);
> +		if (ret)
> +			return;
> +		amd_enable_sdw_interrupts(ctrl);
> +		ret = amd_enable_sdw_controller(ctrl);
> +		if (ret)
> +			return;
> +		ret = amd_sdwc_set_frameshape(ctrl, 50, 10);
> +		if (!ret)
> +			ctrl->startup_done = true;
> +	}
> +}
> +
> +static int amd_sdwc_probe(struct platform_device *pdev)
> +{
> +	const struct acp_sdw_pdata *pdata = pdev->dev.platform_data;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;

Same as in previous patch, you assign dev here, but keep using 
&pdev->dev below?

> +	struct sdw_master_prop *prop;
> +	struct sdw_bus_params *params;
> +	struct amd_sdwc_ctrl *ctrl;
> +	int ret;
> +
> +	if (!pdev->dev.platform_data) {
> +		dev_err(&pdev->dev, "platform_data not retrieved\n");
> +		return -ENODEV;
> +	}
> +	ctrl = devm_kzalloc(&pdev->dev, sizeof(struct amd_sdwc_ctrl), GFP_KERNEL);
> +	if (!ctrl)
> +		return -ENOMEM;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
> +		return -ENOMEM;
> +	}
> +	ctrl->mmio = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (IS_ERR(ctrl->mmio)) {
> +		dev_err(&pdev->dev, "mmio not found\n");
> +		return PTR_ERR(ctrl->mmio);
> +	}
> +	ctrl->instance = pdata->instance;
> +	ctrl->sdw_lock  = pdata->sdw_lock;

Double space before '='.

> +	ctrl->rows_index = sdw_find_row_index(50);
> +	ctrl->cols_index = sdw_find_col_index(10);
> +
> +	ctrl->dev = dev;
> +	dev_set_drvdata(&pdev->dev, ctrl);
> +
> +	ctrl->bus.ops = &amd_sdwc_ops;
> +	ctrl->bus.port_ops = &amd_sdwc_port_ops;
> +	ctrl->bus.compute_params = &amd_sdwc_compute_params;
> +	ctrl->bus.clk_stop_timeout = 1;
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		ctrl->num_dout_ports =  AMD_SDW0_MAX_TX_PORTS;

Double space after '='.

> +		ctrl->num_din_ports = AMD_SDW0_MAX_RX_PORTS;
> +		break;
> +	case ACP_SDW1:
> +		ctrl->num_dout_ports = AMD_SDW1_MAX_TX_PORTS;
> +		ctrl->num_din_ports = AMD_SDW1_MAX_RX_PORTS;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	params = &ctrl->bus.params;
> +	params->max_dr_freq = AMD_SDW_DEFAULT_CLK_FREQ * 2;
> +	params->curr_dr_freq = AMD_SDW_DEFAULT_CLK_FREQ * 2;
> +	params->col = 10;
> +	params->row = 50;
> +
> +	prop = &ctrl->bus.prop;
> +	prop->clk_freq = &amd_sdwc_freq_tbl[0];
> +	prop->mclk_freq = AMD_SDW_BUS_BASE_FREQ;
> +	ctrl->bus.link_id = ctrl->instance;
> +	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
> +	if (ret) {
> +		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
> +			ret);
> +		return ret;
> +	}
> +	INIT_WORK(&ctrl->probe_work, amd_sdwc_probe_work);
> +	schedule_work(&ctrl->probe_work);
> +	return 0;
> +}
> +
> +static int amd_sdwc_remove(struct platform_device *pdev)
> +{
> +	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
> +	int ret;
> +

You may need to cancel work if someone tries to unload driver before 
probe work completes. Something like

cancel_work_sync(&ctrl->probe_work);

should probably work here.

> +	amd_disable_sdw_interrupts(ctrl);
> +	sdw_bus_master_delete(&ctrl->bus);
> +	ret = amd_disable_sdw_controller(ctrl);
> +	return ret;
> +}
> +


