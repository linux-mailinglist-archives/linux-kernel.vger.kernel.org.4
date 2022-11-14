Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F52D6284D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiKNQQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbiKNQQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:16:38 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D7564CA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668442597; x=1699978597;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=++d+b9y7C1ZlnSJ0+RBzklvGqhH0Chu/OZ0XeO1oXZ4=;
  b=V6a0+hDVrpCq4cQqx3vFJWjzEQAOl7FnNwAc8roiz6K+LbLJccIX2wuA
   Ow2eThHpKwhYKconc7EeRGb+5GG3pgXV3JcQ4XfvXL0E+nXu1N4B8NrJk
   tdUAWMW8LK8sb7gshVEON1Pa/qGG5RGOrHcBZ2PF5QmDCfCx0RNIRB4IO
   gD67UcJAzfGdg+CrEMXsi8dP7l8fGsNX0idNbJ5hVoO4BVgpbbeTF7553
   5WOrQNbdPw5Z33BRcZ2o4KWtM7Vx4eUzuPfRF8srRkH7KFzgpgopgBjDg
   k83NtMe4vP+ylWP7pru1cXBgY7GkbbxCmLtFADmOc6Wev/uLOzluv65oX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="295373414"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="295373414"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:16:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="638542498"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="638542498"
Received: from scewbso01.amr.corp.intel.com (HELO [10.212.76.77]) ([10.212.76.77])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:16:35 -0800
Message-ID: <9d701845-7ad1-046c-b7c2-dd2a131212c8@linux.intel.com>
Date:   Mon, 14 Nov 2022 10:04:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] soundwire: stream: Move remaining register accesses
 over to no_pm
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com
References: <20221114102956.914468-1-ckeepax@opensource.cirrus.com>
 <20221114102956.914468-5-ckeepax@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221114102956.914468-5-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/22 04:29, Charles Keepax wrote:
> There is no need to play with the runtime reference everytime a register
> is accessed. All the remaining "pm" style register accesses trace back
> to 4 functions:
> 
> sdw_prepare_stream
> sdw_deprepare_stream
> sdw_enable_stream
> sdw_disable_stream
> 
> Any sensible implementation will need to hold a runtime reference
> across all those functions, it makes no sense to be allowing the
> device/bus to suspend whilst streams are being prepared/enabled. And
> certainly in the case of the all existing users, they all call these
> functions from hw_params/prepare/trigger/hw_free callbacks in ALSA,
> which will have already runtime resumed all the audio devices
> associated during the open callback.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

I tend to agree with this one, and if this ever fails that would point
to a miss at a higher-level we'd need to address.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/bus.c    |  2 +-
>  drivers/soundwire/stream.c | 30 +++++++++++++++---------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index ef4878258afad..d87a188fcce1e 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -1214,7 +1214,7 @@ int sdw_configure_dpn_intr(struct sdw_slave *slave,
>  		val &= ~SDW_DPN_INT_PORT_READY;
>  	}
>  
> -	ret = sdw_update(slave, addr, (mask | SDW_DPN_INT_PORT_READY), val);
> +	ret = sdw_update_no_pm(slave, addr, (mask | SDW_DPN_INT_PORT_READY), val);
>  	if (ret < 0)
>  		dev_err(&slave->dev,
>  			"SDW_DPN_INTMASK write failed:%d\n", val);
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index bd502368339e5..df3b36670df4c 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -81,14 +81,14 @@ static int _sdw_program_slave_port_params(struct sdw_bus *bus,
>  	}
>  
>  	/* Program DPN_OffsetCtrl2 registers */
> -	ret = sdw_write(slave, addr1, t_params->offset2);
> +	ret = sdw_write_no_pm(slave, addr1, t_params->offset2);
>  	if (ret < 0) {
>  		dev_err(bus->dev, "DPN_OffsetCtrl2 register write failed\n");
>  		return ret;
>  	}
>  
>  	/* Program DPN_BlockCtrl3 register */
> -	ret = sdw_write(slave, addr2, t_params->blk_pkg_mode);
> +	ret = sdw_write_no_pm(slave, addr2, t_params->blk_pkg_mode);
>  	if (ret < 0) {
>  		dev_err(bus->dev, "DPN_BlockCtrl3 register write failed\n");
>  		return ret;
> @@ -105,7 +105,7 @@ static int _sdw_program_slave_port_params(struct sdw_bus *bus,
>  	/* Program DPN_SampleCtrl2 register */
>  	wbuf = FIELD_GET(SDW_DPN_SAMPLECTRL_HIGH, t_params->sample_interval - 1);
>  
> -	ret = sdw_write(slave, addr3, wbuf);
> +	ret = sdw_write_no_pm(slave, addr3, wbuf);
>  	if (ret < 0) {
>  		dev_err(bus->dev, "DPN_SampleCtrl2 register write failed\n");
>  		return ret;
> @@ -115,7 +115,7 @@ static int _sdw_program_slave_port_params(struct sdw_bus *bus,
>  	wbuf = FIELD_PREP(SDW_DPN_HCTRL_HSTART, t_params->hstart);
>  	wbuf |= FIELD_PREP(SDW_DPN_HCTRL_HSTOP, t_params->hstop);
>  
> -	ret = sdw_write(slave, addr4, wbuf);
> +	ret = sdw_write_no_pm(slave, addr4, wbuf);
>  	if (ret < 0)
>  		dev_err(bus->dev, "DPN_HCtrl register write failed\n");
>  
> @@ -163,7 +163,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
>  	wbuf = FIELD_PREP(SDW_DPN_PORTCTRL_DATAMODE, p_params->data_mode);
>  	wbuf |= FIELD_PREP(SDW_DPN_PORTCTRL_FLOWMODE, p_params->flow_mode);
>  
> -	ret = sdw_update(s_rt->slave, addr1, 0xF, wbuf);
> +	ret = sdw_update_no_pm(s_rt->slave, addr1, 0xF, wbuf);
>  	if (ret < 0) {
>  		dev_err(&s_rt->slave->dev,
>  			"DPN_PortCtrl register write failed for port %d\n",
> @@ -173,7 +173,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
>  
>  	if (!dpn_prop->read_only_wordlength) {
>  		/* Program DPN_BlockCtrl1 register */
> -		ret = sdw_write(s_rt->slave, addr2, (p_params->bps - 1));
> +		ret = sdw_write_no_pm(s_rt->slave, addr2, (p_params->bps - 1));
>  		if (ret < 0) {
>  			dev_err(&s_rt->slave->dev,
>  				"DPN_BlockCtrl1 register write failed for port %d\n",
> @@ -184,7 +184,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
>  
>  	/* Program DPN_SampleCtrl1 register */
>  	wbuf = (t_params->sample_interval - 1) & SDW_DPN_SAMPLECTRL_LOW;
> -	ret = sdw_write(s_rt->slave, addr3, wbuf);
> +	ret = sdw_write_no_pm(s_rt->slave, addr3, wbuf);
>  	if (ret < 0) {
>  		dev_err(&s_rt->slave->dev,
>  			"DPN_SampleCtrl1 register write failed for port %d\n",
> @@ -193,7 +193,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
>  	}
>  
>  	/* Program DPN_OffsetCtrl1 registers */
> -	ret = sdw_write(s_rt->slave, addr4, t_params->offset1);
> +	ret = sdw_write_no_pm(s_rt->slave, addr4, t_params->offset1);
>  	if (ret < 0) {
>  		dev_err(&s_rt->slave->dev,
>  			"DPN_OffsetCtrl1 register write failed for port %d\n",
> @@ -203,7 +203,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
>  
>  	/* Program DPN_BlockCtrl2 register*/
>  	if (t_params->blk_grp_ctrl_valid) {
> -		ret = sdw_write(s_rt->slave, addr5, t_params->blk_grp_ctrl);
> +		ret = sdw_write_no_pm(s_rt->slave, addr5, t_params->blk_grp_ctrl);
>  		if (ret < 0) {
>  			dev_err(&s_rt->slave->dev,
>  				"DPN_BlockCtrl2 reg write failed for port %d\n",
> @@ -214,7 +214,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
>  
>  	/* program DPN_LaneCtrl register */
>  	if (slave_prop->lane_control_support) {
> -		ret = sdw_write(s_rt->slave, addr6, t_params->lane_ctrl);
> +		ret = sdw_write_no_pm(s_rt->slave, addr6, t_params->lane_ctrl);
>  		if (ret < 0) {
>  			dev_err(&s_rt->slave->dev,
>  				"DPN_LaneCtrl register write failed for port %d\n",
> @@ -319,9 +319,9 @@ static int sdw_enable_disable_slave_ports(struct sdw_bus *bus,
>  	 * it is safe to reset this register
>  	 */
>  	if (en)
> -		ret = sdw_write(s_rt->slave, addr, p_rt->ch_mask);
> +		ret = sdw_write_no_pm(s_rt->slave, addr, p_rt->ch_mask);
>  	else
> -		ret = sdw_write(s_rt->slave, addr, 0x0);
> +		ret = sdw_write_no_pm(s_rt->slave, addr, 0x0);
>  
>  	if (ret < 0)
>  		dev_err(&s_rt->slave->dev,
> @@ -476,9 +476,9 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
>  		addr = SDW_DPN_PREPARECTRL(p_rt->num);
>  
>  		if (prep)
> -			ret = sdw_write(s_rt->slave, addr, p_rt->ch_mask);
> +			ret = sdw_write_no_pm(s_rt->slave, addr, p_rt->ch_mask);
>  		else
> -			ret = sdw_write(s_rt->slave, addr, 0x0);
> +			ret = sdw_write_no_pm(s_rt->slave, addr, 0x0);
>  
>  		if (ret < 0) {
>  			dev_err(&s_rt->slave->dev,
> @@ -491,7 +491,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
>  		wait_for_completion_timeout(port_ready,
>  			msecs_to_jiffies(dpn_prop->ch_prep_timeout));
>  
> -		val = sdw_read(s_rt->slave, SDW_DPN_PREPARESTATUS(p_rt->num));
> +		val = sdw_read_no_pm(s_rt->slave, SDW_DPN_PREPARESTATUS(p_rt->num));
>  		if ((val < 0) || (val & p_rt->ch_mask)) {
>  			ret = (val < 0) ? val : -ETIMEDOUT;
>  			dev_err(&s_rt->slave->dev,
