Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCF36A5866
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjB1LgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjB1Lfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:35:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0C1C1DB9C;
        Tue, 28 Feb 2023 03:35:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAD8DFEC;
        Tue, 28 Feb 2023 03:36:36 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 304F23F881;
        Tue, 28 Feb 2023 03:35:51 -0800 (PST)
Message-ID: <f4dcb4f8-c70b-3ca9-33fd-8889899d7481@arm.com>
Date:   Tue, 28 Feb 2023 11:35:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 6/9] coresight-tpdm: Add node to set dsb programming
 mode
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
 <1674114105-16651-7-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1674114105-16651-7-git-send-email-quic_taozha@quicinc.com>
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
> Add node to set and show programming mode for TPDM DSB subunit.
> Once the DSB programming mode is set, it will be written to the
> register DSB_CR. Bit[10:9] of the DSB_CR register is used to set
> the DSB test mode.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 45 +++++++++++++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tpdm.h | 12 ++++++++
>   2 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 1dbb6c4..9126a37 100644
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
> @@ -38,7 +39,7 @@ static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
>   
>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
> -	u32 val;
> +	u32 val, mode;
>   
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>   	/* Set trigger timestamp */
> @@ -58,6 +59,19 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   
>   	/* Set the enable bit of DSB control register to 1 */
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> +	/* Set the cycle accurate mode */
> +	mode = TPDM_DSB_MODE_CYCACC(drvdata->dsb->mode);
> +	val &= ~TPDM_DSB_TEST_MODE;
> +	val |= FIELD_PREP(TPDM_DSB_TEST_MODE, mode);
> +	/* Set the byte lane for high-performance mode */
> +	mode = TPDM_DSB_MODE_HPBYTESEL(drvdata->dsb->mode);
> +	val &= ~TPDM_DSB_HPSEL;
> +	val |= FIELD_PREP(TPDM_DSB_HPSEL, mode);
> +	/* Set the performance mode */
> +	if (drvdata->dsb->mode & TPDM_DSB_MODE_PERF)
> +		val |= TPDM_DSB_MODE;
> +	else
> +		val &= ~TPDM_DSB_MODE;

This looks a bit tricky to me. Please could you add documentation of
the values supported under Documentation/ABI/testing/sysfs-....-

Couldn't we provide separate handles for these "mode bits" ?

cycacc
perf
hpsel

Suzuki


>   	val |= TPDM_DSB_CR_ENA;
>   	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>   }
> @@ -257,6 +271,34 @@ static struct attribute_group tpdm_attr_grp = {
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
> @@ -327,6 +369,7 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(dsb_trig_ts);
>   static struct attribute *tpdm_dsb_attrs[] = {
> +	&dev_attr_dsb_mode.attr,
>   	&dev_attr_dsb_trig_ts.attr,
>   	&dev_attr_dsb_trig_type.attr,
>   	NULL,
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 3ad1be5..b3ecb9f 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -19,6 +19,16 @@
>   #define TPDM_DSB_XTRIG_TSENAB		BIT(1)
>   /* Enable bit for DSB subunit trigger type */
>   #define TPDM_DSB_TRIG_TYPE		BIT(12)
> +/* Enable bit for DSB subunit perfmance mode */
> +#define TPDM_DSB_MODE		BIT(1)
> +
> +/* DSB programming modes */
> +#define TPDM_DSB_MODE_CYCACC(val)	(val & GENMASK(2, 0))
> +#define TPDM_DSB_MODE_PERF		BIT(3)
> +#define TPDM_DSB_MODE_HPBYTESEL(val)	(val & GENMASK(8, 4))
> +#define TPDM_MODE_ALL			(0xFFFFFFF)
> +#define TPDM_DSB_TEST_MODE		GENMASK(11, 9)
> +#define TPDM_DSB_HPSEL		GENMASK(6, 2)
>   
>   /* TPDM integration test registers */
>   #define TPDM_ITATBCNTRL		(0xEF0)
> @@ -48,10 +58,12 @@
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

