Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193136A46E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjB0QV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjB0QVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:21:53 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2F9222DB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677514912; x=1709050912;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/H5jajqIkZJ9qNlrUca1p6fHslxzGwbu0vaBkTnfrYU=;
  b=fx/ilB1dTeg4gIA3b1adLJFHPAD6hhGUUUL5vg/czcDRyBq9m1BuCaZI
   orZpKVhEDwBblH8D06gcCFlyu0zcCQ8KoJjw3VOXDnqr6yhSm2YLKli4C
   zamhqV4S0vi00Wn5FBlD0qjwY9qs6Wa8pI3K+KPtNKsE1JseDg+OOvZ6D
   QTD547Fj5RMGX2DWyfqTqbSPVtThIehn6FvcLnlMEf9GVUReIAE1EiSw9
   Iz0GE0j20/48uuC/vAsvI21WT06lA/aVk+vL5SGS5nomW+BjqoKbE5/Zm
   pNB17Y3m4ACf76InxLwkj1cRCf8WD66ZrhTxZDK5DC7bMfPM/R+skAYWl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="396451414"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="396451414"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 08:21:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="673790527"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="673790527"
Received: from jaidenno-mobl.amr.corp.intel.com (HELO [10.212.85.4]) ([10.212.85.4])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 08:21:50 -0800
Message-ID: <189e24e1-682f-2df9-c54e-7c72a904c7e6@linux.intel.com>
Date:   Mon, 27 Feb 2023 10:27:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH] soundwire: bus: Fix unbalanced pm_runtime_put() causing
 usage count underflow
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230227112933.1593997-1-rf@opensource.cirrus.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230227112933.1593997-1-rf@opensource.cirrus.com>
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



On 2/27/23 06:29, Richard Fitzgerald wrote:
> This reverts commit
> 443a98e649b4 ("soundwire: bus: use pm_runtime_resume_and_get()")
> 
> Change calls to pm_runtime_resume_and_get() back to pm_runtime_get_sync().
> This fixes a usage count underrun caused by doing a pm_runtime_put() even
> though pm_runtime_resume_and_get() returned an error.
> 
> The three affected functions ignore -EACCES error from trying to get
> pm_runtime, and carry on, including a put at the end of the function.
> But pm_runtime_resume_and_get() does not increment the usage count if it
> returns an error. So in the -EACCES case you must not call
> pm_runtime_put().
> 
> The documentation for pm_runtime_get_sync() says:
>  "Consider using pm_runtime_resume_and_get() ...  as this is likely to
>  result in cleaner code."
> 
> In this case I don't think it results in cleaner code because the
> pm_runtime_put() at the end of the function would have to be conditional on
> the return value from pm_runtime_resume_and_get() at the top of the
> function.
> 
> pm_runtime_get_sync() doesn't have this problem because it always
> increments the count, so always needs a put. The code can just flow through
> and do the pm_runtime_put() unconditionally.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Agreed, in hindsight the move to use pm_runtime_resume_and_get() mostly
added issues left and right with limited benefits - just too hard to
review and figure out what cases work and which ones don't.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>



> ---
>  drivers/soundwire/bus.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 76515c33e639..4fd221d0cc81 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -571,9 +571,11 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>  {
>  	int ret;
>  
> -	ret = pm_runtime_resume_and_get(&slave->dev);
> -	if (ret < 0 && ret != -EACCES)
> +	ret = pm_runtime_get_sync(&slave->dev);
> +	if (ret < 0 && ret != -EACCES) {
> +		pm_runtime_put_noidle(&slave->dev);
>  		return ret;
> +	}
>  
>  	ret = sdw_nread_no_pm(slave, addr, count, val);
>  
> @@ -595,9 +597,11 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
>  {
>  	int ret;
>  
> -	ret = pm_runtime_resume_and_get(&slave->dev);
> -	if (ret < 0 && ret != -EACCES)
> +	ret = pm_runtime_get_sync(&slave->dev);
> +	if (ret < 0 && ret != -EACCES) {
> +		pm_runtime_put_noidle(&slave->dev);
>  		return ret;
> +	}
>  
>  	ret = sdw_nwrite_no_pm(slave, addr, count, val);
>  
> @@ -1565,9 +1569,10 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  
>  	sdw_modify_slave_status(slave, SDW_SLAVE_ALERT);
>  
> -	ret = pm_runtime_resume_and_get(&slave->dev);
> +	ret = pm_runtime_get_sync(&slave->dev);
>  	if (ret < 0 && ret != -EACCES) {
>  		dev_err(&slave->dev, "Failed to resume device: %d\n", ret);
> +		pm_runtime_put_noidle(&slave->dev);
>  		return ret;
>  	}
>  
