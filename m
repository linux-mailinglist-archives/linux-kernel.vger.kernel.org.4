Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690D06C7064
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjCWSla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCWSl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:41:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B692B12076;
        Thu, 23 Mar 2023 11:41:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F0BD2F4;
        Thu, 23 Mar 2023 11:42:11 -0700 (PDT)
Received: from [10.57.53.151] (unknown [10.57.53.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0890C3F766;
        Thu, 23 Mar 2023 11:41:23 -0700 (PDT)
Message-ID: <859dac2a-8b6b-ba55-f30f-3ac668433a35@arm.com>
Date:   Thu, 23 Mar 2023 18:41:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v3 09/11] coresight-tpdm: Add nodes for timestamp request
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
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
 <1679551448-19160-10-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1679551448-19160-10-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 06:04, Tao Zhang wrote:
> Add nodes to configure the timestamp request based on input
> pattern match. Each TPDM that support DSB subunit has maximum of
> n(n<7) TPR registers to configure value for timestamp request
> based on input pattern match. Eight 32 bit registers providing
> DSB interface timestamp request  pattern match comparison. And
> each TPDM that support DSB subunit has maximum of m(m<7) TPMR
> registers to configure pattern mask for timestamp request. Eight
> 32 bit registers providing DSB interface timestamp request
> pattern match mask generation. Add nodes to enable/disable
> pattern timestamp and set pattern timestamp type.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  48 ++++++
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 172 +++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h       |  14 ++
>   3 files changed, 234 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index c06374f..60ff660 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -95,3 +95,51 @@ Description:
>   		Accepts the following two values.
>   		value 1: Index number of XPMR register
>   		value 2: The value need to be written
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt_val
> +Date:		March 2023
> +KernelVersion	6.3
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the pattern value of DSB tpdm. Read
> +		the pattern value of DSB tpdm.
> +
> +		Accepts the following two values.
> +		value 1: Index number of TPR register
> +		value 2: The value need to be written
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt_mask
> +Date:		March 2023
> +KernelVersion	6.3
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the pattern mask of DSB tpdm. Read
> +		the pattern mask of DSB tpdm.
> +
> +		Accepts the following two values.
> +		value 1: Index number of TPMR register
> +		value 2: The value need to be written
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt_ts
> +Date:		March 2023
> +KernelVersion	6.3
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the pattern timestamp of DSB tpdm. Read
> +		the pattern timestamp of DSB tpdm.
> +
> +		Accepts only one of the 2 values -  0 or 1.
> +		0 : Set the DSB pattern timestamp to false
> +		1 : Set the DSB pattern timestamp to true
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt_type
> +Date:		March 2023
> +KernelVersion	6.3
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the pattern type of DSB tpdm. Read
> +		the pattern type of DSB tpdm.
> +

Sounds a bit strange for "pattern type" to be bool. What does this do ?
Does it enable/disable something  ?

> +		Accepts only one of the 2 values -  0 or 1.
> +		0 : Set the DSB pattern type to false
> +		1 : Set the DSB pattern type to true
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index d6cc6b5..c740681 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -98,6 +98,13 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
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

Why not do all the pattern related writing in one shot, instead
of two loops ?

>   		writel_relaxed(drvdata->dsb->trig_patt_val[i],
>   			    drvdata->base + TPDM_DSB_XPR(i));
>   		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
> @@ -105,6 +112,16 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   	}
>   
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
> +	/* Set pattern timestamp type and enablement */
> +	if (drvdata->dsb->patt_ts) {
> +		val |= TPDM_DSB_TIER_PATT_TSENAB;
> +		if (drvdata->dsb->patt_type)
> +			val |= TPDM_DSB_TIER_PATT_TYPE;
> +		else
> +			val &= ~TPDM_DSB_TIER_PATT_TYPE;
> +	} else {
> +		val &= ~TPDM_DSB_TIER_PATT_TSENAB;
> +	}

set_dsb_pattern_ts() in line with the other helper functions ?
Rest looks fine to me.

Suzuki


>   	/* Set trigger timestamp */
>   	if (drvdata->dsb->trig_ts)
>   		val |= TPDM_DSB_TIER_XTRIG_TSENAB;
> @@ -455,6 +472,157 @@ static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
>   	return size;
>   }
>   static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
> +
> +static ssize_t dsb_patt_val_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	int i = 0;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		size += sysfs_emit_at(buf, size,
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
> +	if (index >= TPDM_DSB_MAX_PATT)
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
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		size += sysfs_emit_at(buf, size,
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
> +	if (index >= TPDM_DSB_MAX_PATT)
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
> +	return sysfs_emit(buf, "%u\n",
> +			 (unsigned int)drvdata->dsb->patt_ts);
> +}
> +
> +/*
> + * value 1: Enable/Disable DSB pattern timestamp
> + */

> +static ssize_t dsb_patt_ts_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf,
> +				      size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	if (val)
> +		drvdata->dsb->patt_ts = true;
> +	else
> +		drvdata->dsb->patt_ts = false;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_patt_ts);
> +
> +static ssize_t dsb_patt_type_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n",
> +			 (unsigned int)drvdata->dsb->patt_type);
> +}
> +
> +/*
> + * value 1: Set DSB pattern type


> + */ > +static ssize_t dsb_patt_type_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	if (val)
> +		drvdata->dsb->patt_type = true;
> +	else
> +		drvdata->dsb->patt_type = false;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_patt_type);
> +
>   static ssize_t dsb_trig_patt_val_show(struct device *dev,
>   					   struct device_attribute *attr,
>   					   char *buf)
> @@ -605,6 +773,10 @@ static struct attribute *tpdm_dsb_attrs[] = {
>   	&dev_attr_dsb_mode.attr,
>   	&dev_attr_dsb_edge_ctrl.attr,
>   	&dev_attr_dsb_edge_ctrl_mask.attr,
> +	&dev_attr_dsb_patt_val.attr,
> +	&dev_attr_dsb_patt_mask.attr,
> +	&dev_attr_dsb_patt_ts.attr,
> +	&dev_attr_dsb_patt_type.attr,
>   	&dev_attr_dsb_trig_patt_val.attr,
>   	&dev_attr_dsb_trig_patt_mask.attr,
>   	&dev_attr_dsb_trig_ts.attr,
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 2e8020e..f9d4dd9 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -12,6 +12,8 @@
>   /* DSB Subunit Registers */
>   #define TPDM_DSB_CR		(0x780)
>   #define TPDM_DSB_TIER		(0x784)
> +#define TPDM_DSB_TPR(n)		(0x788 + (n * 4))
> +#define TPDM_DSB_TPMR(n)	(0x7A8 + (n * 4))
>   #define TPDM_DSB_XPR(n)		(0x7C8 + (n * 4))
>   #define TPDM_DSB_XPMR(n)	(0x7E8 + (n * 4))
>   #define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
> @@ -24,8 +26,12 @@
>   /* Enable bit for DSB subunit trigger type */
>   #define TPDM_DSB_CR_TRIG_TYPE		BIT(12)
>   
> +/* Enable bit for DSB subunit pattern timestamp */
> +#define TPDM_DSB_TIER_PATT_TSENAB		BIT(0)
>   /* Enable bit for DSB subunit trigger timestamp */
>   #define TPDM_DSB_TIER_XTRIG_TSENAB		BIT(1)
> +/* Bit for DSB subunit pattern type */
> +#define TPDM_DSB_TIER_PATT_TYPE		BIT(2)
>   
>   /* DSB programming modes */
>   #define TPDM_DSB_MODE_CYCACC(val)	(val & GENMASK(2, 0))
> @@ -76,6 +82,10 @@
>    * @mode:             DSB programming mode
>    * @edge_ctrl:        Save value for edge control
>    * @edge_ctrl_mask:   Save value for edge control mask
> + * @patt_val:         Save value for pattern
> + * @patt_mask:        Save value for pattern mask
> + * @patt_ts:          Enable/Disable pattern timestamp
> + * @patt_type:        Set pattern type
>    * @trig_patt_val:    Save value for trigger pattern
>    * @trig_patt_mask:   Save value for trigger pattern mask
>    * @trig_ts:          Enable/Disable trigger timestamp.
> @@ -85,6 +95,10 @@ struct dsb_dataset {
>   	u32				mode;
>   	u32				edge_ctrl[TPDM_DSB_MAX_EDCR];
>   	u32				edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
> +	u32				patt_val[TPDM_DSB_MAX_PATT];
> +	u32				patt_mask[TPDM_DSB_MAX_PATT];
> +	bool			patt_ts;
> +	bool			patt_type;
>   	u32				trig_patt_val[TPDM_DSB_MAX_PATT];
>   	u32				trig_patt_mask[TPDM_DSB_MAX_PATT];
>   	bool			trig_ts;

