Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACB86A5876
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjB1Ll0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjB1LlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:41:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFD332DE79;
        Tue, 28 Feb 2023 03:41:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F394C14;
        Tue, 28 Feb 2023 03:30:22 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D4BE3F881;
        Tue, 28 Feb 2023 03:29:36 -0800 (PST)
Message-ID: <299199d6-458b-fa54-cde1-dc6730ac1c3d@arm.com>
Date:   Tue, 28 Feb 2023 11:29:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/9] coresight-tpdm: Add nodes to set trigger timestamp
 and type
Content-Language: en-US
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        Tao Zhang <taozha@qti.qualcomm.com>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
 <1674114105-16651-6-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1674114105-16651-6-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 07:41, Tao Zhang wrote:
> The nodes are needed to set or show the trigger timestamp and
> trigger type. This change is to add these nodes to achieve these
> function.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 97 ++++++++++++++++++++++++++++
>   1 file changed, 97 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index c29d667d..1dbb6c4 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -20,6 +20,22 @@
>   
>   DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>   
> +static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
> +							struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (drvdata) {
> +		if (drvdata->datasets & TPDM_PIDR0_DS_DSB)
> +			return attr->mode;
> +		else
> +			return 0;
> +	}

	if (drvdata && drvdata->dsb)
		return attr->mode;

	return 0;

?


> +
> +	return 0;
> +}
> +
>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
>   	u32 val;
> @@ -241,8 +257,89 @@ static struct attribute_group tpdm_attr_grp = {
>   	.attrs = tpdm_attrs,
>   };
>   
> +static ssize_t dsb_trig_type_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n",
> +			 (unsigned int)drvdata->dsb->trig_type);
> +}
> +
> +/*
> + * value 0: set trigger type as enablement
> + * value 1: set trigger type as disablement
> + */
> +static ssize_t dsb_trig_type_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf,
> +				      size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if ((kstrtoul(buf, 0, &val)) || val < 0 || val > 1)

val < 0 check here doesn't help on an unsigned variable.

may be (val & ~1UL) ?

> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	if (val)
> +		drvdata->dsb->trig_type = true;
> +	else
> +		drvdata->dsb->trig_type = false;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_trig_type);
> +
> +static ssize_t dsb_trig_ts_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n",
> +			 (unsigned int)drvdata->dsb->trig_ts);
> +}
> +
> +/*
> + * value 0: set trigger timestamp as enablement
> + * value 1: set trigger timestamp as disablement
> + */
> +static ssize_t dsb_trig_ts_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf,
> +				      size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if ((kstrtoul(buf, 0, &val)) || val < 0 || val > 1)

same here.

> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	if (val)
> +		drvdata->dsb->trig_ts = true;
> +	else
> +		drvdata->dsb->trig_ts = false;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_trig_ts);
> +static struct attribute *tpdm_dsb_attrs[] = {
> +	&dev_attr_dsb_trig_ts.attr,
> +	&dev_attr_dsb_trig_type.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group tpdm_dsb_attr_grp = {
> +	.attrs = tpdm_dsb_attrs,
> +	.is_visible = tpdm_dsb_is_visible,
> +};
> +
>   static const struct attribute_group *tpdm_attr_grps[] = {
>   	&tpdm_attr_grp,
> +	&tpdm_dsb_attr_grp,
>   	NULL,
>   };
> 

Suzuki

