Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F32690D19
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjBIPfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjBIPf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:35:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30799643FE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675956905; x=1707492905;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QsleGwQt2tIddWytBaD5JbNmXTkOYJR8IEaq6F4sxO8=;
  b=EabfaEViGx3v0w8V7Ke2xEkptAdNsLZxnIOVtJPNwIPAok+3wWtgXLTs
   iYcroRSAar5sJ7nAR1stPqobqRvBpF4RwQeZdH6KTNbH4qAFkBJvt5EAs
   z4yDXp+MWZtTZjtuNyD7JvFuXtaHi4wFfHi+6E/d0P8277EhiBoEDD4GO
   SLvSXQa99rGCELLsfAMfgajHw+tYDs5cOSazGZzw98JZH2VkuK9miWiIx
   SJPlB33ZCEjCvZpT1SG0KYzrVbzmPn+F8h9uidh5ou7zQ5dnb6Naq21cu
   GOTjPaY7FffQxrY7mS+3bayHqeg2nH22G9TLoS+0Un8aXaJdNOuy1b/X3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="309782429"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="309782429"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 07:35:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776528830"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="776528830"
Received: from fpastor-mobl4.amr.corp.intel.com (HELO [10.212.74.130]) ([10.212.74.130])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 07:35:03 -0800
Message-ID: <92a2560a-74cd-aa13-fea6-7619e355b26e@linux.intel.com>
Date:   Thu, 9 Feb 2023 09:21:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 2/5] soundwire: qcom: enable runtime pm before controller
 is registered
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        johan+linaro@kernel.org, quic_bjorande@quicinc.com
References: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
 <20230209131336.18252-3-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230209131336.18252-3-srinivas.kandagatla@linaro.org>
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
> Registering controller even before pm runtime is enabled will result
> in pm runtime underflow warnings. Fix this by properly moving
> the runtime pm enable before registering controller.

That seems very odd. The Intel code configures the pm_runtime stuff
*after* the call to sdw_bus_master_add(), and we've not seen any
underflow warnings? We even configure pm_runtime after starting the bus.
Likewise for peripherals the pm_runtime part is enabled after the device
is initialized.

Not following the problem and suggested solution.

> Fixes: 74e79da9fd46 ("soundwire: qcom: add runtime pm support")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 9d8ae77bad0a..b2363839624c 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1417,6 +1417,12 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	pm_runtime_set_autosuspend_delay(dev, 3000);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
>  	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
>  	if (ret) {
>  		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
> @@ -1435,12 +1441,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  		 (ctrl->version >> 24) & 0xff, (ctrl->version >> 16) & 0xff,
>  		 ctrl->version & 0xffff);
>  
> -	pm_runtime_set_autosuspend_delay(dev, 3000);
> -	pm_runtime_use_autosuspend(dev);
> -	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_set_active(dev);
> -	pm_runtime_enable(dev);
> -
>  	/* Clk stop is not supported on WSA Soundwire masters */
>  	if (ctrl->version <= 0x01030000) {
>  		ctrl->clock_stop_not_supported = true;
