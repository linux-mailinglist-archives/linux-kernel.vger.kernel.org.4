Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2F05B9B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiIONK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiIONKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:10:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E272E9CC;
        Thu, 15 Sep 2022 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663247423; x=1694783423;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HoCpplRGmLa8NMZ/Auv5ElmwuTYU4eLsbnw+GC1f8LU=;
  b=GDMbYg/7ty3Pnn48jYjN0+yMkqkSwD7PinOogk+POn/HTD8unqr/uy6d
   GAj26ots8CjQuvk/PXCCy0czqaA5weVyeKQQzp3t5cdsbwLn7gEOL7lZ+
   wuH9ZCnmRXodRdP10T2buzXhaFzu7YRnBTlENk708uUVqxAGHuewLlfSM
   b1sF/sy0NZvwNSCkj0ttnmgk/Zfi4lARn83uWpIidpC2vGsr3vJhCym5/
   50M7OtmkhdycOtaG1DVsxEHjK6Vod0PgaiCVzPjxngUMS9fre3Q724LnU
   CJvHOVtYyEeIFKaGq1T50QkJIwQ/hOSOejAAN2IU/7KIzCqhIy1dgxtKx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="281737598"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="281737598"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 06:10:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="617269024"
Received: from bhomann-mobl.ger.corp.intel.com (HELO [10.252.61.7]) ([10.252.61.7])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 06:10:21 -0700
Message-ID: <3962348a-33b4-5941-4a0b-cb447a513a41@linux.intel.com>
Date:   Thu, 15 Sep 2022 15:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] soundwire: qcom: update status from device id 1
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220915124215.13703-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220915124215.13703-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/22 14:42, Srinivas Kandagatla wrote:
> By default autoenumeration is enabled on QCom SoundWire controller
> which means the core should not be dealing with device 0 w.r.t enumeration.
> Currently device 0 status is also shared with SoundWire core which confuses
> the core sometimes and we endup adding 0:0:0:0 slave device.

The change looks fine, but the description of the issue is surprising.

Whether autoenumeration is enabled or not is irrelevant, by spec the
device0 cannot be in ALERT status and throw in-band interrupts to the
host with this mechanism.

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index e21a3306bf01..871e4d8b32c7 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -428,7 +428,7 @@ static int qcom_swrm_get_alert_slave_dev_num(struct qcom_swrm_ctrl *ctrl)
>  
>  	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
>  
> -	for (dev_num = 0; dev_num <= SDW_MAX_DEVICES; dev_num++) {
> +	for (dev_num = 1; dev_num <= SDW_MAX_DEVICES; dev_num++) {
>  		status = (val >> (dev_num * SWRM_MCP_SLV_STATUS_SZ));
>  
>  		if ((status & SWRM_MCP_SLV_STATUS_MASK) == SDW_SLAVE_ALERT) {
> @@ -448,7 +448,7 @@ static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
>  	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
>  	ctrl->slave_status = val;
>  
> -	for (i = 0; i <= SDW_MAX_DEVICES; i++) {
> +	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
>  		u32 s;
>  
>  		s = (val >> (i * 2));
