Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D0C5BAF3A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiIPOZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiIPOYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:24:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5D043639;
        Fri, 16 Sep 2022 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663338291; x=1694874291;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gv+2/C8ClWBbHILgrFONJ9rBiBl5ZJdLRc3Bch3QP2M=;
  b=R18qGuU7zKdu44rDwjAVfQf5l5Q8CQXz5cs1IOgEcuKQW+RmF18Lz2GX
   WJxvR4RxdTRhorutyDmAMq31ywqcBs/of0mn68NUrgvuJFzaULEzbMyhY
   j1yuj6UiGXzeQ5XEb4zEe0oW8D+wHl6XhKOHAZ33oy5MzXRD2EWk3TyHB
   eBwn61q7nRnF31/tENYfgluVCVU6B+97x7D2hkG7PfYl/QC0w845YSfsT
   0nONUB/dk0blSSpbhjxcFwqJJRCX7bq9GPFLSZDmEeHLUYScLpCS3QZHe
   v/tZcM1ht7oRMid3dMsfYm+kXU+moFbFBuxaAgdsK0qTVtzdY/9W87Fxp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="300363093"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="300363093"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:24:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="650889189"
Received: from kchan21-mobl1.ger.corp.intel.com (HELO [10.252.61.56]) ([10.252.61.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:24:39 -0700
Message-ID: <ffb79f8b-7557-92eb-2c20-e8f5fd2afaee@linux.intel.com>
Date:   Fri, 16 Sep 2022 16:22:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] soundwire: qcom: update status from device id 1
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com, quic_srivasam@quicinc.com
References: <20220916135352.19114-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220916135352.19114-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/22 15:53, Srinivas Kandagatla wrote:
> By default autoenumeration is enabled on QCom SoundWire controller
> which means the core should not be dealing with device 0 w.r.t enumeration.
> 
> During Enumeration if SoundWire core sees status[0] as SDW_SLAVE_ATTACHED and
> start programming the device id, however reading DEVID registers return zeros
> which does not match to any of the slaves in the list and the core attempts
> to park this device to Group 13.  This results in adding SoundWire device
> with enumeration address 0:0:0:0
> 
> Fix this by not passing device 0 status to SoundWire core.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> Changes since v1:
> 	- updated change log and split patch in to two as suggested by Pierre
> 
>  drivers/soundwire/qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index e7f95c41eb70..d3ce580cdeaf 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -448,7 +448,7 @@ static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
>  	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
>  	ctrl->slave_status = val;
>  
> -	for (i = 0; i <= SDW_MAX_DEVICES; i++) {
> +	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
>  		u32 s;
>  
>  		s = (val >> (i * 2));
