Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF6C706E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjEQQuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjEQQt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:49:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A779A40F7;
        Wed, 17 May 2023 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684342196; x=1715878196;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=1FDXaOvMiv/7nzig5qwdhuEpYL+zWHcV8CYwzpgWZu4=;
  b=FauTNvl8g65N5QwNNQrP2udX1mntjz+zn75Jg7fRptXF+FE5yGM2VXNK
   /I6C3HW7H89wsblJE4R2zpBM/YhKXMYWIE04oibOt5FLc8QPtvaI2fOfr
   IHcz8PWVJ3zAfQowW6QyxDRqmDwGs6f6oQMLXWb8DWDEJrzaz0R3/RFEa
   7Ab8SzuxEbxznBp3AajcfGJpB1+ettkFmlgAtzFf5Y1TLwIEUDsu067VC
   Ge7h6XtG7qV/kUFJZHfFGdKcePx0wAXYem4eRivApOLusOg2Pz2Fcpf9D
   v89Lygv4JHLCRb99QbA+pInjXzC0mgZFKp6SqfJtG/RBvMHqwRRXQLNO9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="350649356"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="350649356"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 09:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="734764317"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="734764317"
Received: from pgopdahl-mobl1.amr.corp.intel.com (HELO [10.209.16.196]) ([10.209.16.196])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 09:48:48 -0700
Message-ID: <7bcb1ee2-3950-5a43-14ee-5f16942b1eee@linux.intel.com>
Date:   Wed, 17 May 2023 11:47:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] soundwire: qcom: fix unbalanced pm_runtime_put()
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230517163750.997629-1-krzysztof.kozlowski@linaro.org>
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
> This reverts commit 57ed510b0547 ("soundwire: qcom: use
> pm_runtime_resume_and_get()") which introduced unbalanced
> pm_runtime_put(), when device did not have runtime PM enabled.
> 
> If pm_runtime_resume_and_get() failed with -EACCES, the driver continued
> execution and finally called pm_runtime_put_autosuspend().  Since
> pm_runtime_resume_and_get() drops the usage counter on every error, this
> lead to double decrement of that counter visible in certain debugfs
> actions on unattached devices (still in reset state):
> 
>   $ cat /sys/kernel/debug/soundwire/master-0-0/sdw:0:0217:f001:00:0/registers
>   qcom-soundwire 3210000.soundwire-controller: swrm_wait_for_wr_fifo_avail err write overflow
>   soundwire sdw-master-0: trf on Slave 1 failed:-5 read addr e36 count 1
>   soundwire sdw:0:0217:f001:00:0: Runtime PM usage count underflow!
> 
> Fixes: 57ed510b0547 ("soundwire: qcom: use pm_runtime_resume_and_get()")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Yes, this resume_and_get() added more problems indeed. One of those
well-intended changes that went sideways.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> ---
>  drivers/soundwire/qcom.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index aad5942e5980..f442280af9d3 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -614,11 +614,12 @@ static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
>  	struct qcom_swrm_ctrl *ctrl = dev_id;
>  	int ret;
>  
> -	ret = pm_runtime_resume_and_get(ctrl->dev);
> +	ret = pm_runtime_get_sync(ctrl->dev);
>  	if (ret < 0 && ret != -EACCES) {
>  		dev_err_ratelimited(ctrl->dev,
> -				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
> +				    "pm_runtime_get_sync failed in %s, ret %d\n",
>  				    __func__, ret);
> +		pm_runtime_put_noidle(ctrl->dev);
>  		return ret;
>  	}
>  
> @@ -1197,11 +1198,12 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
>  	struct snd_soc_dai *codec_dai;
>  	int ret, i;
>  
> -	ret = pm_runtime_resume_and_get(ctrl->dev);
> +	ret = pm_runtime_get_sync(ctrl->dev);
>  	if (ret < 0 && ret != -EACCES) {
>  		dev_err_ratelimited(ctrl->dev,
> -				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
> +				    "pm_runtime_get_sync failed in %s, ret %d\n",
>  				    __func__, ret);
> +		pm_runtime_put_noidle(ctrl->dev);
>  		return ret;
>  	}
>  
> @@ -1402,11 +1404,12 @@ static int swrm_reg_show(struct seq_file *s_file, void *data)
>  	struct qcom_swrm_ctrl *ctrl = s_file->private;
>  	int reg, reg_val, ret;
>  
> -	ret = pm_runtime_resume_and_get(ctrl->dev);
> +	ret = pm_runtime_get_sync(ctrl->dev);
>  	if (ret < 0 && ret != -EACCES) {
>  		dev_err_ratelimited(ctrl->dev,
> -				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
> +				    "pm_runtime_get_sync failed in %s, ret %d\n",
>  				    __func__, ret);
> +		pm_runtime_put_noidle(ctrl->dev);
>  		return ret;
>  	}
>  
