Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581BA60C968
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiJYKHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJYKGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:06:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B14518BE31;
        Tue, 25 Oct 2022 03:00:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93264D6E;
        Tue, 25 Oct 2022 03:00:43 -0700 (PDT)
Received: from [10.57.68.77] (unknown [10.57.68.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D70BE3F792;
        Tue, 25 Oct 2022 03:00:34 -0700 (PDT)
Message-ID: <08201626-9998-6327-b5f7-e49ad279fd0f@arm.com>
Date:   Tue, 25 Oct 2022 11:00:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 9/9] coresight-tpdm: Add nodes for timestamp request
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org
References: <1662626705-13097-1-git-send-email-quic_taozha@quicinc.com>
 <1662626705-13097-10-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1662626705-13097-10-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 09:45, Tao Zhang wrote:
> Add nodes to configure the timestamp request based on input
> pattern match. Each TPDM that support DSB subunit has n(0-7) TPR
> registers to configure value for timestamp request based on input
> pattern match, and has m(0-7) TPMR registers to configure pattern
> mask for timestamp request.
> Add nodes to enable/disable pattern timestamp and set pattern
> timestamp type.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 189 +++++++++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h |  14 ++
>   2 files changed, 203 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 648bbe6..4212ff4 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -32,6 +32,13 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   			   drvdata->base + TPDM_DSB_EDCMR(i));
>   
>   	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		writel_relaxed(drvdata->dsb->patt_val[i],
> +			    drvdata->base + TPDM_DSB_TPR(i));
> +		writel_relaxed(drvdata->dsb->patt_mask[i],
> +			    drvdata->base + TPDM_DSB_TPMR(i));
> +	}
> +
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
>   		writel_relaxed(drvdata->dsb->trig_patt_val[i],
>   			    drvdata->base + TPDM_DSB_XPR(i));
>   		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
> @@ -39,6 +46,16 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   	}
>   
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
> +	/* Set pattern timestamp type and enablement */
> +	if (drvdata->dsb->patt_ts) {
> +		val |= TPDM_DSB_PATT_TSENAB;
> +		if (drvdata->dsb->patt_type)
> +			val |= TPDM_DSB_PATT_TYPE;
> +		else
> +			val &= ~TPDM_DSB_PATT_TYPE;
> +	} else {
> +		val &= ~TPDM_DSB_PATT_TSENAB;
> +	}
>   	/* Set trigger timestamp */
>   	if (drvdata->dsb->trig_ts)
>   		val |= TPDM_DSB_XTRIG_TSENAB;
> @@ -411,6 +428,174 @@ static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
>   
> +static ssize_t dsb_patt_val_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	int i = 0;
> +
> +	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
> +		return -EPERM;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		size += scnprintf(buf + size, PAGE_SIZE - size,
> +				  "Index: 0x%x Value: 0x%x\n", i,
> +				  drvdata->dsb->patt_val[i]);
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +
> +/*
> + * value 1: Index of TPR register
> + * value 2: Value need to be written
> + */
> +static ssize_t dsb_patt_val_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf,
> +				       size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long index, val;
> +
> +	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
> +		return -EINVAL;
> +	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB) ||
> +	    index >= TPDM_DSB_MAX_PATT)
> +		return -EPERM;
> +
> +	spin_lock(&drvdata->spinlock);
> +	drvdata->dsb->patt_val[index] = val;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_patt_val);
> +
> +static ssize_t dsb_patt_mask_show(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	int i = 0;
> +
> +	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
> +		return -EPERM;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		size += scnprintf(buf + size, PAGE_SIZE - size,
> +				  "Index: 0x%x Value: 0x%x\n", i,
> +				  drvdata->dsb->patt_mask[i]);
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +
> +/*
> + * value 1: Index of TPMR register
> + * value 2: Value need to be written
> + */
> +static ssize_t dsb_patt_mask_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf,
> +					size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long index, val;
> +
> +	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
> +		return -EINVAL;
> +	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB) ||
> +	    index >= TPDM_DSB_MAX_PATT)
> +		return -EPERM;
> +
> +	spin_lock(&drvdata->spinlock);
> +	drvdata->dsb->patt_mask[index] = val;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_patt_mask);
> +
> +static ssize_t dsb_patt_ts_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
> +		return -EPERM;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +			 (unsigned int)drvdata->dsb->patt_ts);

Please use sysfs_emit() everywhere (in the previous patches too)
for such operations.

I have finished reviewing this series.

Suzuki
