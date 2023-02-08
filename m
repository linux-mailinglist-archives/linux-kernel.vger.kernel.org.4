Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7409468F0CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBHO1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjBHO07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:26:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F0F84C0F3;
        Wed,  8 Feb 2023 06:26:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B4671042;
        Wed,  8 Feb 2023 06:27:06 -0800 (PST)
Received: from [10.57.75.176] (unknown [10.57.75.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23BBE3F8C6;
        Wed,  8 Feb 2023 06:26:22 -0800 (PST)
Message-ID: <3c105c79-f523-653e-5154-7ba641e51a96@arm.com>
Date:   Wed, 8 Feb 2023 14:26:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] coresight: core: Add coresight name support
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20230208110716.18321-1-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230208110716.18321-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 11:07, Mao Jinlong wrote:
> Apart from STM and ETM sources, there will be more sources added to
> coresight components. For example, there are over 10 TPDM sources.
> Add coresight name support for custom names which will be
> easy to identify the source.
> 

As we have previously discussed, please don't make this a generic
code change. If your device has a "specifici" name, use that for
allocating in the driver and leave the core code alone.

Suzuki


> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 34 +++++++++++---------
>   1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index d3bf82c0de1d..5e95d9c7f256 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1733,28 +1733,32 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
>   {
>   	int idx;
>   	char *name = NULL;
> +	const char *coresight_name = NULL;
>   	struct fwnode_handle **list;
> +	struct device_node *node = dev->of_node;
>   
>   	mutex_lock(&coresight_mutex);
>   
> -	idx = coresight_search_device_idx(dict, dev_fwnode(dev));
> -	if (idx < 0) {
> -		/* Make space for the new entry */
> -		idx = dict->nr_idx;
> -		list = krealloc_array(dict->fwnode_list,
> -				      idx + 1, sizeof(*dict->fwnode_list),
> -				      GFP_KERNEL);
> -		if (ZERO_OR_NULL_PTR(list)) {
> -			idx = -ENOMEM;
> -			goto done;
> +	if (!of_property_read_string(node, "coresight-name", &coresight_name))
> +		name = devm_kasprintf(dev, GFP_KERNEL, "%s", coresight_name);
> +	else {
> +		idx = coresight_search_device_idx(dict, dev_fwnode(dev));
> +		if (idx < 0) {
> +			/* Make space for the new entry */
> +			idx = dict->nr_idx;
> +			list = krealloc_array(dict->fwnode_list,
> +					      idx + 1, sizeof(*dict->fwnode_list),
> +					      GFP_KERNEL);
> +			if (ZERO_OR_NULL_PTR(list))
> +				goto done;
> +
> +			list[idx] = dev_fwnode(dev);
> +			dict->fwnode_list = list;
> +			dict->nr_idx = idx + 1;
>   		}
>   
> -		list[idx] = dev_fwnode(dev);
> -		dict->fwnode_list = list;
> -		dict->nr_idx = idx + 1;
> +		name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, idx);
>   	}
> -
> -	name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, idx);
>   done:
>   	mutex_unlock(&coresight_mutex);
>   	return name;

