Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8936C6BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjCWO4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjCWO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:56:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20D371EFE7;
        Thu, 23 Mar 2023 07:55:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D87404B3;
        Thu, 23 Mar 2023 07:56:38 -0700 (PDT)
Received: from [10.57.53.151] (unknown [10.57.53.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33B53F6C4;
        Thu, 23 Mar 2023 07:55:51 -0700 (PDT)
Message-ID: <ab840019-a44c-3d72-1dd5-5ef3071f139a@arm.com>
Date:   Thu, 23 Mar 2023 14:55:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v3 06/11] coresight-tpdm: Add node to set dsb programming
 mode
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
 <1679551448-19160-7-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1679551448-19160-7-git-send-email-quic_taozha@quicinc.com>
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
> Add node to set and show programming mode for TPDM DSB subunit.
> Once the DSB programming mode is set, it will be written to the
> register DSB_CR. Bit[10:9] of the DSB_CR register is used to set
> the DSB test mode.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 10 ++++
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 62 ++++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h       | 13 +++++
>   3 files changed, 85 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index 27ce681..f13e282 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -35,3 +35,13 @@ Description:
>   		Accepts only one of the 2 values -  0 or 1.
>   		0 : Set the DSB trigger type to false
>   		1 : Set the DSB trigger type to true
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_mode
> +Date:		March 2023
> +KernelVersion	6.3
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the mode of DSB tpdm. Read the mode of DSB
> +		tpdm.
> +
> +		Accepts the value needs to be greater than 0.

Please could you document the values ?

> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index e28cf10..8cd822f 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <linux/amba/bus.h>
> +#include <linux/bitfield.h>
>   #include <linux/bitmap.h>
>   #include <linux/coresight.h>
>   #include <linux/coresight-pmu.h>
> @@ -51,6 +52,32 @@ static int tpdm_init_datasets(struct tpdm_drvdata *drvdata)
>   	return 0;
>   }
>   
> +static void set_dsb_cycacc_mode(struct tpdm_drvdata *drvdata, u32 *val)
> +{
> +	u32 mode;
> +
> +	mode = TPDM_DSB_MODE_CYCACC(drvdata->dsb->mode);
> +	*val &= ~TPDM_DSB_TEST_MODE;
> +	*val |= FIELD_PREP(TPDM_DSB_TEST_MODE, mode);
> +}
> +
> +static void set_dsb_hpsel_mode(struct tpdm_drvdata *drvdata, u32 *val)
> +{
> +	u32 mode;
> +
> +	mode = TPDM_DSB_MODE_HPBYTESEL(drvdata->dsb->mode);
> +	*val &= ~TPDM_DSB_HPSEL;
> +	*val |= FIELD_PREP(TPDM_DSB_HPSEL, mode);
> +}
> +
> +static void set_dsb_perf_mode(struct tpdm_drvdata *drvdata, u32 *val)
> +{
> +	if (drvdata->dsb->mode & TPDM_DSB_MODE_PERF)
> +		*val |= TPDM_DSB_CR_MODE;
> +	else
> +		*val &= ~TPDM_DSB_CR_MODE;
> +}
> +
>   static void set_trigger_type(struct tpdm_drvdata *drvdata, u32 *val)
>   {
>   	if (drvdata->dsb->trig_type)
> @@ -72,6 +99,12 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>   
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> +	/* Set the cycle accurate mode */
> +	set_dsb_cycacc_mode(drvdata, &val);
> +	/* Set the byte lane for high-performance mode */
> +	set_dsb_hpsel_mode(drvdata, &val);
> +	/* Set the performance mode */
> +	set_dsb_perf_mode(drvdata, &val);
>   	/* Set trigger type */
>   	set_trigger_type(drvdata, &val);
>   	/* Set the enable bit of DSB control register to 1 */
> @@ -250,6 +283,34 @@ static struct attribute_group tpdm_attr_grp = {
>   	.attrs = tpdm_attrs,
>   };
>   
> +static ssize_t dsb_mode_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%lx\n",
> +			 (unsigned long)drvdata->dsb->mode);
> +}
> +
> +static ssize_t dsb_mode_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf,
> +				   size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if ((kstrtoul(buf, 0, &val)) || val < 0)
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	drvdata->dsb->mode = val & TPDM_MODE_ALL;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_mode);
> +
>   static ssize_t dsb_trig_type_show(struct device *dev,
>   				     struct device_attribute *attr,
>   				     char *buf)
> @@ -321,6 +382,7 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
>   static DEVICE_ATTR_RW(dsb_trig_ts);
>   
>   static struct attribute *tpdm_dsb_attrs[] = {
> +	&dev_attr_dsb_mode.attr,
>   	&dev_attr_dsb_trig_ts.attr,
>   	&dev_attr_dsb_trig_type.attr,
>   	NULL,
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 68f33bd..8fee562 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -15,11 +15,22 @@
>   
>   /* Enable bit for DSB subunit */
>   #define TPDM_DSB_CR_ENA		BIT(0)
> +/* Enable bit for DSB subunit perfmance mode */
> +#define TPDM_DSB_CR_MODE		BIT(1)
>   /* Enable bit for DSB subunit trigger type */
>   #define TPDM_DSB_CR_TRIG_TYPE		BIT(12)
> +
>   /* Enable bit for DSB subunit trigger timestamp */
>   #define TPDM_DSB_TIER_XTRIG_TSENAB		BIT(1)
>   
> +/* DSB programming modes */
> +#define TPDM_DSB_MODE_CYCACC(val)	(val & GENMASK(2, 0))

What do the values for the CYCACC mode mean ?

> +#define TPDM_DSB_MODE_PERF		BIT(3)
> +#define TPDM_DSB_MODE_HPBYTESEL(val)	(val & GENMASK(8, 4))
> +#define TPDM_MODE_ALL			(0xFFFFFFF)
> +#define TPDM_DSB_TEST_MODE		GENMASK(11, 9)
> +#define TPDM_DSB_HPSEL		GENMASK(6, 2)

Again what do the values mean ? Even if the kernel doesn't use them
it would be good to document it.

Suzuki

> +
>   /* TPDM integration test registers */
>   #define TPDM_ITATBCNTRL		(0xEF0)
>   #define TPDM_ITCNTRL		(0xF00)
> @@ -48,10 +59,12 @@
>   
>   /**
>    * struct dsb_dataset - specifics associated to dsb dataset
> + * @mode:             DSB programming mode
>    * @trig_ts:          Enable/Disable trigger timestamp.
>    * @trig_type:        Enable/Disable trigger type.
>    */
>   struct dsb_dataset {
> +	u32				mode;
>   	bool			trig_ts;
>   	bool			trig_type;
>   };

