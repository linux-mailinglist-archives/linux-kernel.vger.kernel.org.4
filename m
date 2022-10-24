Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CD460BB72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiJXVAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiJXU7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:59:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECB8B171CF6;
        Mon, 24 Oct 2022 12:05:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F17A1042;
        Mon, 24 Oct 2022 07:49:55 -0700 (PDT)
Received: from [10.57.68.77] (unknown [10.57.68.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EC7B3F792;
        Mon, 24 Oct 2022 07:49:46 -0700 (PDT)
Message-ID: <7302924e-21f9-8748-3d9e-854f4898d078@arm.com>
Date:   Mon, 24 Oct 2022 15:49:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 6/9] coresight-tpdm: Add node to set dsb programming mode
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
 <1662626705-13097-7-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1662626705-13097-7-git-send-email-quic_taozha@quicinc.com>
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
> Add node to set and show programming mode for TPDM DSB subunit.
> Once the DSB programming mode is set, it will be written to the
> register DSB_CR. Bit[10:9] of the DSB_CR register is used to set
> the DSB test mode.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 49 +++++++++++++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tpdm.h | 10 ++++++
>   2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index fae9963..7265793 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -22,7 +22,7 @@ DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>   
>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
> -	u32 val;
> +	u32 val, mode;
>   
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>   	/* Set trigger timestamp */
> @@ -42,6 +42,19 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   
>   	/* Set the enable bit of DSB control register to 1 */
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> +	/* Set the cycle accurate mode */
> +	mode = TPDM_DSB_MODE_CYCACC(drvdata->dsb->mode);
> +	val = val & ~(0x7 << 9);
> +	val = val | (mode << 9);

Please do not hard code numbers like that above. Please could
you define proper masks for the fields in DSB_CR and use
FIELD_GET, FIELD_PREP for setting the values.

> +	/* Set the byte lane for high-performance mode */
> +	mode = TPDM_DSB_MODE_HPBYTESEL(drvdata->dsb->mode);
> +	val = val & ~(0x1F << 2);
> +	val = val | (mode << 2);
> +	/* Set the performance mode */

Same as above.

> +	if (drvdata->dsb->mode & TPDM_DSB_MODE_PERF)
> +		val |= TPDM_DSB_MODE;
> +	else
> +		val &= ~TPDM_DSB_MODE;
>   	val |= TPDM_DSB_CR_ENA;
>   	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>   }
> @@ -232,6 +245,39 @@ static struct attribute_group tpdm_attr_grp = {
>   	.attrs = tpdm_attrs,
>   };
>   
> +static ssize_t dsb_mode_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
> +		return -EPERM;

As mentioned earlier, use is_visble() instead of hard coding this
in every function.

> +
> +	return scnprintf(buf, PAGE_SIZE, "%lx\n",
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
> +	if ((kstrtoul(buf, 16, &val)) || val < 0 || val > 3)

Why not leave kstrtoul to detect the base instead of always forcing
16 ? Some other code had forced to base of 10. Please be flexible
and avoid the inconsistencies.

> +		return -EINVAL;
> +	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
> +		return -EPERM;
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
> @@ -312,6 +358,7 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(dsb_trig_ts);
>   static struct attribute *tpdm_dsb_attrs[] = {
> +	&dev_attr_dsb_mode.attr,
>   	&dev_attr_dsb_trig_ts.attr,
>   	&dev_attr_dsb_trig_type.attr,
>   	NULL,
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index dd4a013..4d57488 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -19,6 +19,14 @@
>   #define TPDM_DSB_XTRIG_TSENAB		BIT(1)
>   /* Enable bit for DSB subunit trigger type */
>   #define TPDM_DSB_TRIG_TYPE		BIT(12)
> +/* Enable bit for DSB subunit perfmance mode */
> +#define TPDM_DSB_MODE		BIT(1)
> +
> +/* DSB programming modes */
> +#define TPDM_DSB_MODE_CYCACC(val)	BMVAL(val, 0, 2)
> +#define TPDM_DSB_MODE_PERF		BIT(3)
> +#define TPDM_DSB_MODE_HPBYTESEL(val)	BMVAL(val, 4, 8)

Please could we use GENMASK to define the masks and
use FIELD_GET/FILED_PREP macros for the dealing with
the fields ?

Similarly for the DSB_CR register please.

Suzuki
