Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ABE65D3ED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbjADNOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbjADNNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:13:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A7A03B911;
        Wed,  4 Jan 2023 05:11:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD30D1063;
        Wed,  4 Jan 2023 05:11:58 -0800 (PST)
Received: from [10.57.42.13] (unknown [10.57.42.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B8B53F587;
        Wed,  4 Jan 2023 05:11:14 -0800 (PST)
Message-ID: <9a86f7cd-2dce-f27a-af21-d64318ca3ef7@arm.com>
Date:   Wed, 4 Jan 2023 13:11:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] coresight: cti: Add PM runtime call in enable_store
Content-Language: en-US
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tingwei <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20221224141700.20891-1-quic_jinlmao@quicinc.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20221224141700.20891-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/12/2022 14:17, Mao Jinlong wrote:
> In commit 6746eae4bbad ("coresight: cti: Fix hang in cti_disable_hw()")
> PM runtime calls are removed from cti_enable_hw/cti_disable_hw. When
> enabling CTI by writing enable sysfs node, clock for accessing CTI
> register won't be enabled. Device will crash due to register access
> issue. Add PM runtime call in enable_store to fix this issue.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  drivers/hwtracing/coresight/coresight-cti-sysfs.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index 6d59c815ecf5..b1ed424ae043 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -108,10 +108,17 @@ static ssize_t enable_store(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	if (val)
> +	if (val) {
> +		ret = pm_runtime_resume_and_get(dev->parent);
> +		if (ret)
> +			return ret;
>  		ret = cti_enable(drvdata->csdev);
> -	else
> +		if (ret)
> +			pm_runtime_put(dev->parent);
> +	} else {
>  		ret = cti_disable(drvdata->csdev);
> +		pm_runtime_put(dev->parent);

Hi Jinlong,

This new pm_runtime_put() causes this when writing 0 to enable:

  [  483.253814] coresight-cti 23020000.cti: Runtime PM usage count
underflow!

Maybe we can modify cti_disable_hw() to return a value to indicate that
the disable actually happened, and only then call pm_runtime_put().

I suppose you could also check in the store function if it was already
enabled first, but then I don't know what kind of locking that would
need? cti_disable_hw() already seems to have a couple of locks, so maybe
the return value solution is easiest.

Thanks
James

