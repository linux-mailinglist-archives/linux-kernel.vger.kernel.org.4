Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A8269E556
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjBUQ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjBUQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:58:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBA1222E1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676998734; x=1708534734;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GmFG1YKCb0Q/ommkmUjwup7T9MZg39/d3oY0mhMCpc0=;
  b=VSAesB1QOEt1bk26BdAhuWxTi93l80KxZ8QwAPejiM5T99pXBfZMv1UU
   Ti2Z1FtDNWw2/k1W1UwLnmN6ob6F3MiPKCjIUvh6y2teOKWo4cKKcsHcB
   rmhm/Sd2LgOIhWKf3dH689sZwb/t7Ls/jLQzFaDRCxmnI0OMS9Fd7XOLd
   WtPa64A7NU8cgWBezYapCbVyRucPuMflV1gXHVhje2XKBrAFowtOIzuxb
   2QWZkwGYA3/tOZ+wGs9Qt4W4GpAP7UpXfztd+NSJKISFW3MIaXs3LM3LW
   RMmI4M/GJOZgUe+PAsnmwu+eG7Tlh2AAMQNAohrAtCofz8mObFrsZuXxZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334884692"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="334884692"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="814569114"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="814569114"
Received: from taevough-mobl.amr.corp.intel.com (HELO [10.209.174.213]) ([10.209.174.213])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:39 -0800
Message-ID: <72b601b9-93bf-b9f5-c898-c63ad46e5167@linux.intel.com>
Date:   Tue, 21 Feb 2023 11:10:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V3 6/8] soundwire: amd: add runtime pm ops for AMD
 SoundWire manager driver
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, amadeuszx.slawinski@linux.intel.com,
        Mario.Limonciello@amd.com, Sunil-kumar.Dommati@amd.com,
        Basavaraj.Hiregoudar@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
 <20230220100418.76754-7-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230220100418.76754-7-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int amd_deinit_sdw_manager(struct amd_sdw_manager *amd_manager)
> +{
> +	int ret;
> +
> +	amd_disable_sdw_interrupts(amd_manager);
> +	ret = amd_disable_sdw_manager(amd_manager);
> +	return ret;

return amd_disable_sdw_manager(amd_manager); ?

> +}

> +static int amd_sdw_clock_stop(struct amd_sdw_manager *amd_manager)
> +{
> +	u32 val;
> +	u32 retry_count = 0;
> +	int ret;
> +
> +	ret = sdw_bus_prep_clk_stop(&amd_manager->bus);
> +	if (ret < 0 && ret != -ENODATA) {
> +		dev_err(amd_manager->dev, "prepare clock stop failed %d", ret);
> +		return 0;
> +	}
> +	ret = sdw_bus_clk_stop(&amd_manager->bus);
> +	if (ret < 0 && ret != -ENODATA) {
> +		dev_err(amd_manager->dev, "bus clock stop failed %d", ret);
> +		return 0;
> +	}
> +
> +	do {
> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);

don't you need a minimal usleep_range to avoid re-reading the same
register over and over?

This is tied to the frame duration, isn't it? this is 20us typically.

> +		if (val & AMD_SDW_CLK_STOP_DONE) {
> +			amd_manager->clk_stopped = true;
> +			break;
> +		}
> +	} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
> +
> +	if (!amd_manager->clk_stopped) {
> +		dev_err(amd_manager->dev, "SDW%x clock stop failed\n", amd_manager->instance);
> +		return 0;
> +	}
> +
> +	if (amd_manager->wake_en_mask)
> +		acp_reg_writel(0x01, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
> +
> +	dev_dbg(amd_manager->dev, "SDW%x clock stop successful\n", amd_manager->instance);
> +	return 0;
> +}
> +
> +static int amd_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
> +{
> +	int ret;
> +	u32 val;
> +	u32 retry_count = 0;
> +
> +	if (amd_manager->clk_stopped) {
> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
> +		val |= AMD_SDW_CLK_RESUME_REQ;
> +		acp_reg_writel(val, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
> +		do {
> +			val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
> +			if (val & AMD_SDW_CLK_RESUME_DONE)
> +				break;
> +			usleep_range(10, 100);

that's 10x range for sleep, that sounds a vague and suspicious, no?

> +		} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
> +		if (val & AMD_SDW_CLK_RESUME_DONE) {
> +			acp_reg_writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
> +			ret = sdw_bus_exit_clk_stop(&amd_manager->bus);
> +			if (ret < 0)
> +				dev_err(amd_manager->dev, "bus failed to exit clock stop %d\n",
> +					ret);
> +			amd_manager->clk_stopped = false;
> +		}
> +	}
> +	if (amd_manager->clk_stopped) {
> +		dev_err(amd_manager->dev, "SDW%x clock stop exit failed\n", amd_manager->instance);
> +		return 0;
> +	}
> +	dev_dbg(amd_manager->dev, "SDW%x clock stop exit successful\n", amd_manager->instance);
> +	return 0;

