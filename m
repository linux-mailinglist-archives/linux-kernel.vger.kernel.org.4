Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD8722348
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjFEKUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjFEKTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:19:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BD0999;
        Mon,  5 Jun 2023 03:19:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38DD3D75;
        Mon,  5 Jun 2023 03:20:37 -0700 (PDT)
Received: from [10.57.25.141] (unknown [10.57.25.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E174A3F793;
        Mon,  5 Jun 2023 03:19:48 -0700 (PDT)
Message-ID: <35b3facc-88bf-189b-513e-9666f4ee1de4@arm.com>
Date:   Mon, 5 Jun 2023 11:19:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH v4 09/11] coresight-tpdm: Add nodes for timestamp request
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
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
 <1682586037-25973-10-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1682586037-25973-10-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 10:00, Tao Zhang wrote:
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
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 182 ++++++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tpdm.h       |  14 ++
>   3 files changed, 239 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index c04c735..639b6fb8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -122,3 +122,51 @@ Description:
>   		Where:
>   		<integer1> : Index number of XPMR register,  the range is 0 to 7
>   		<integer2> : The value need to be written
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt_val
> +Date:		March 2023
> +KernelVersion	6.3

Similar to the previous comments, please update this.

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
> +		0 : Disable DSB pattern timestamp.
> +		1 : Enable DSB pattern timestamp.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt_type
> +Date:		March 2023
> +KernelVersion	6.3
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the pattern type of DSB tpdm. Read
> +		the pattern type of DSB tpdm.
> +
> +		Accepts only one of the 2 values -  0 or 1.
> +		0 : Set the DSB pattern type to value.
> +		1 : Set the DSB pattern type to toggle.
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 9387bdf..627de36 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -78,6 +78,27 @@ static void set_trigger_type(struct tpdm_drvdata *drvdata, u32 *val)
>   		*val &= ~TPDM_DSB_CR_TRIG_TYPE;
>   }
>   
> +static void set_dsb_tier(struct tpdm_drvdata *drvdata, u32 *val)
> +{
> +	/* Set pattern timestamp type and enablement */
> +	if (drvdata->dsb->patt_ts) {
> +		*val |= TPDM_DSB_TIER_PATT_TSENAB;
> +		if (drvdata->dsb->patt_type)
> +			*val |= TPDM_DSB_TIER_PATT_TYPE;
> +		else
> +			*val &= ~TPDM_DSB_TIER_PATT_TYPE;
> +	} else {
> +		*val &= ~TPDM_DSB_TIER_PATT_TSENAB;
> +	}
> +
> +	/* Set trigger timestamp */
> +	if (drvdata->dsb->trig_ts)
> +		*val |= TPDM_DSB_TIER_XTRIG_TSENAB;
> +	else
> +		*val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;
> +
> +}
> +
>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
>   	u32 val, i;
> @@ -90,6 +111,10 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   			   drvdata->base + TPDM_DSB_EDCMR(i));
>   
>   	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		writel_relaxed(drvdata->dsb->patt_val[i],
> +			    drvdata->base + TPDM_DSB_TPR(i));
> +		writel_relaxed(drvdata->dsb->patt_mask[i],
> +			    drvdata->base + TPDM_DSB_TPMR(i));
>   		writel_relaxed(drvdata->dsb->trig_patt_val[i],
>   			    drvdata->base + TPDM_DSB_XPR(i));
>   		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
> @@ -97,11 +122,7 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   	}
>   
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
> -	/* Set trigger timestamp */
> -	if (drvdata->dsb->trig_ts)
> -		val |= TPDM_DSB_TIER_XTRIG_TSENAB;
> -	else
> -		val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;
> +	set_dsb_tier(drvdata, &val);
>   	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>   
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> @@ -451,6 +472,153 @@ static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
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
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		size += sysfs_emit_at(buf, size,
> +				  "Index: 0x%x Value: 0x%x\n", i,
> +				  drvdata->dsb->patt_val[i]);
> +	}

Similarly here, please check for overflows and stop in case.

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

Same here

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

minor nit: alignment ?

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

minor nit: Alignmnet

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

ultra minor nit:

	drvdata->dsb->patt_ts = !!val;


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
> + */
> +static ssize_t dsb_patt_type_store(struct device *dev,
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
> +	drvdata->dsb->patt_type = val;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_patt_type);
> +
>   static ssize_t dsb_trig_patt_val_show(struct device *dev,
>   					   struct device_attribute *attr,
>   					   char *buf)
> @@ -601,6 +769,10 @@ static struct attribute *tpdm_dsb_attrs[] = {
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
> index 55c620f..9ad32a6 100644
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
>   /* Test mode control bit*/
> @@ -86,6 +92,10 @@
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
> @@ -95,6 +105,10 @@ struct dsb_dataset {
>   	u32				mode;
>   	u32				edge_ctrl[TPDM_DSB_MAX_EDCR];
>   	u32				edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
> +	u32				patt_val[TPDM_DSB_MAX_PATT];
> +	u32				patt_mask[TPDM_DSB_MAX_PATT];
> +	bool			patt_ts;
> +	bool			patt_type;

minor nit: Alignment of the bool fields ?

Also, it may be good to move the bool fields together, for better
packing of the structure.

>   	u32				trig_patt_val[TPDM_DSB_MAX_PATT];
>   	u32				trig_patt_mask[TPDM_DSB_MAX_PATT];
>   	bool			trig_ts;

Suzuki
