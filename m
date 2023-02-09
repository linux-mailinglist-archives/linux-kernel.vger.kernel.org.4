Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FA8690D1B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjBIPfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjBIPft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:35:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DD8611EB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675956926; x=1707492926;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lBCEUSoK05IPzjUXn4+2V8MmciXUhTpk+OYzlHyef5M=;
  b=lE+S4DCqMIJM4o5Mxn93rwpToIsbkLz6mWj9hhW20vBOozcaUkwn6Xsh
   52D0j8sL1e2d1DrBL7w3RRGDBBI+ugZ0kwggeE5Ir3SH/5+G+HLB7+xOv
   ZNCEm7hhGvFLGR9KFUpD0LhQbOIhqQpL9gMqm6XayZ/1ZGTCmNtBAOKXw
   afV3gNLy7gBBLjaT5xqg4v75ev6HR6TG2k/m7T/AGCGaS9i/ju1I0Di+H
   t+Yht60kjBk63u+6pNTb4ZStp6ksMQ1PlvA2217yM8ef8l6Pjr9SsxS6G
   v+j4iIroc4BzwxTHh3Dg6q7JpOUMad6bJArRXlBwlpSmM2e1V79xK7VyJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="309782446"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="309782446"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 07:35:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776528834"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="776528834"
Received: from fpastor-mobl4.amr.corp.intel.com (HELO [10.212.74.130]) ([10.212.74.130])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 07:35:05 -0800
Message-ID: <2680bb04-0a58-1914-44a4-a51d5aebb8f1@linux.intel.com>
Date:   Thu, 9 Feb 2023 09:33:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 5/5] soundwire: qcom: set clk stop need reset flag at
 runtime
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        johan+linaro@kernel.org, quic_bjorande@quicinc.com
References: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
 <20230209131336.18252-6-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230209131336.18252-6-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/23 07:13, Srinivas Kandagatla wrote:
> WSA Soundwire controller needs an full reset if clock stop support
> is not available in slave devices. WSA881x does not support clock stop
> however WSA883x supports clock stop.
> 
> Make setting this flag at runtime to address above issue.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 74e38c0d651b..0224a5a866de 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -536,10 +536,14 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
>  
>  		sdw_extract_slave_id(bus, addr, &id);
>  		found = false;
> +		ctrl->clock_stop_not_supported = false;
>  		/* Now compare with entries */
>  		list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
>  			if (sdw_compare_devid(slave, id) == 0) {
>  				qcom_swrm_set_slave_dev_num(bus, slave, i);
> +				if (!slave->prop.simple_clk_stop_capable)
> +					ctrl->clock_stop_not_supported = true;

IIRC the 'simple_clk_stop_capable' for a peripheral refers to the
Simplified_SCSP_SM

see Figure 35 "Slave Clock Stop Prepare State Machine (SCSP_SM)"

In addition, there's a requirement that all peripherals shall support
ClockStopMode0. Only ClockStopMode1 is optional, and that case is
handled with a different property:

 * @clk_stop_mode1: Clock-Stop Mode 1 is supported

I think you overloaded one concept with another, or used the wrong property?

> +
>  				found = true;
>  				break;
>  			}
> @@ -1500,15 +1504,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  		 (ctrl->version >> 24) & 0xff, (ctrl->version >> 16) & 0xff,
>  		 ctrl->version & 0xffff);
>  
> -	/* Clk stop is not supported on WSA Soundwire masters */
> -	if (ctrl->version <= 0x01030000) {
> -		ctrl->clock_stop_not_supported = true;
> -	} else {
> -		ctrl->reg_read(ctrl, SWRM_COMP_MASTER_ID, &val);
> -		if (val == MASTER_ID_WSA)
> -			ctrl->clock_stop_not_supported = true;
> -	}
> -
>  #ifdef CONFIG_DEBUG_FS
>  	ctrl->debugfs = debugfs_create_dir("qualcomm-sdw", ctrl->bus.debugfs);
>  	debugfs_create_file("qualcomm-registers", 0400, ctrl->debugfs, ctrl,
