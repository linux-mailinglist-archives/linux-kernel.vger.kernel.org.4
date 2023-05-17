Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD651706E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjEQQua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEQQuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:50:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C900344A3;
        Wed, 17 May 2023 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684342201; x=1715878201;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=1mSQXJWCQ9lX0x3tGFr7Nl/lmeL6e4hiAkMTL3TSDuM=;
  b=d5AsvZ27xNGMxQz+3DSNnC0Ug+21ZZGVek1URLjO40bYSNvAOEpYiYkR
   qVYGzlOVqqjkqWhAi8JktYvOBIAmEygDrA1HzWDRLnMnQHwXNnU78u5Ln
   RRkRdj2iQl96cdXldB23nObxhupx1XrSwUs1CAXcGJPlqoN64Oq8MfD6x
   4IuG4JhL+Il2cPfFO9qsYOOh6UXDZ7UuppRM7W82eWFnIeVd7S15/XV4L
   vdiGyl5srMlmDIlyojXwGXqOiXPAsQAibrRs8YDJJF1x2CNR4wY2l9cM6
   h22eLvHcvyTMFsE4gxhyMYNbcHm4Z1WpTlHNZQ3oPIFfZYyhJENpABoiB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="350649405"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="350649405"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 09:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="734764323"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="734764323"
Received: from pgopdahl-mobl1.amr.corp.intel.com (HELO [10.209.16.196]) ([10.209.16.196])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 09:48:50 -0700
Message-ID: <805a61d6-64eb-5805-b0bf-74fcc317fb98@linux.intel.com>
Date:   Wed, 17 May 2023 11:47:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] soundwire: debugfs: fix unbalanced pm_runtime_put()
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230517163750.997629-1-krzysztof.kozlowski@linaro.org>
 <20230517163750.997629-2-krzysztof.kozlowski@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230517163750.997629-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 11:37, Krzysztof Kozlowski wrote:
> If pm_runtime_resume_and_get() failed with -EACCES, the driver continued
> execution and finally called pm_runtime_put_autosuspend().  Since
> pm_runtime_resume_and_get() drops the usage counter on every error, this
> lead to double decrement of that counter.
> 
> Fixes: b275bf45ba1d ("soundwire: debugfs: Switch to sdw_read_no_pm")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/debugfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
> index dea782e0edc4..c3a1a359ee5c 100644
> --- a/drivers/soundwire/debugfs.c
> +++ b/drivers/soundwire/debugfs.c
> @@ -56,8 +56,9 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
>  	if (!buf)
>  		return -ENOMEM;
>  
> -	ret = pm_runtime_resume_and_get(&slave->dev);
> +	ret = pm_runtime_get_sync(&slave->dev);
>  	if (ret < 0 && ret != -EACCES) {
> +		pm_runtime_put_noidle(&slave->dev);
>  		kfree(buf);
>  		return ret;
>  	}
