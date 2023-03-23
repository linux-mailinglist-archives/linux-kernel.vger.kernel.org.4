Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69C76C6AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjCWOXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCWOXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:23:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C34561727;
        Thu, 23 Mar 2023 07:23:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8830C4B3;
        Thu, 23 Mar 2023 07:24:16 -0700 (PDT)
Received: from [10.57.53.151] (unknown [10.57.53.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 605463F6C4;
        Thu, 23 Mar 2023 07:23:29 -0700 (PDT)
Message-ID: <65bb7624-9d57-1056-61fd-ae840728ecd6@arm.com>
Date:   Thu, 23 Mar 2023 14:23:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v3 03/11] coresight-tpdm: Initialize DSB subunit
 configuration
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
 <1679551448-19160-4-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1679551448-19160-4-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 06:04, Tao Zhang wrote:
> DSB is used for monitoring “events”. Events are something that
> occurs at some point in time. It could be a state decode, the
> act of writing/reading a particular address, a FIFO being empty,
> etc. This decoding of the event desired is done outside TPDM.
> DSB subunit need to be configured in enablement and disablement.
> A struct that specifics associated to dsb dataset is needed. It
> saves the configuration and parameters of the dsb datasets. This
> change is to add this struct and initialize the configuration of
> DSB subunit.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 58 +++++++++++++++++++++++++---
>   drivers/hwtracing/coresight/coresight-tpdm.h | 17 ++++++++
>   2 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index f4854af..5e1e2ba 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -20,17 +20,59 @@
>   
>   DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>   
> +static int tpdm_init_datasets(struct tpdm_drvdata *drvdata)


> +{
> +	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
> +		if (!drvdata->dsb) {
> +			drvdata->dsb = devm_kzalloc(drvdata->dev,
> +						    sizeof(*drvdata->dsb), GFP_KERNEL);
> +			if (!drvdata->dsb)
> +				return -ENOMEM;

Please do not club init/allocation of datasets to "resetting" the
datasets. Why don't we move the allocation to tpmd_datasets_setup() ?
And this function could simply be called :

tpdm_reset_datasets()

and can be called from the tpdm_datasets_setup() too.


> +		} else
> +			memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
> +
> +		drvdata->dsb->trig_ts = true;
> +		drvdata->dsb->trig_type = false;
> +	}
> +
> +	return 0;
> +}
> +
> +static void set_trigger_type(struct tpdm_drvdata *drvdata, u32 *val)
> +{
> +	if (drvdata->dsb->trig_type)
> +		*val |= TPDM_DSB_CR_TRIG_TYPE;
> +	else
> +		*val &= ~TPDM_DSB_CR_TRIG_TYPE;
> +}
> +

Do we really need a function for this ? How is it different from trig_ts ?

>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
>   	u32 val;
>   
> -	/* Set the enable bit of DSB control register to 1 */
> +	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
> +	/* Set trigger timestamp */
> +	if (drvdata->dsb->trig_ts)
> +		val |= TPDM_DSB_TIER_XTRIG_TSENAB;
> +	else
> +		val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;
> +	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
> +
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> +	/* Set trigger type */
> +	set_trigger_type(drvdata, &val);
> +	/* Set the enable bit of DSB control register to 1 */
>   	val |= TPDM_DSB_CR_ENA;
>   	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>   }
>   
>   /* TPDM enable operations */
> +/* The TPDM or Monitor serves as data collection component for various
> + * dataset types. It covers Basic Counts(BC), Tenure Counts(TC),
> + * Continuous Multi-Bit(CMB), Multi-lane CMB(MCMB) and Discrete Single
> + * Bit(DSB). This function will initialize the configuration according
> + * to the dataset type supported by the TPDM.
> + */
>   static void __tpdm_enable(struct tpdm_drvdata *drvdata)
>   {
>   	CS_UNLOCK(drvdata->base);
> @@ -110,15 +152,13 @@ static const struct coresight_ops tpdm_cs_ops = {
>   	.source_ops	= &tpdm_source_ops,
>   };
>   
> -static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
> +static void tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
>   {
>   	u32 pidr;
>   
> -	CS_UNLOCK(drvdata->base);

Why is this removed ?

>   	/*  Get the datasets present on the TPDM. */
>   	pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
>   	drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
> -	CS_LOCK(drvdata->base);
>   }
>   
>   /*
> @@ -181,6 +221,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   	struct coresight_platform_data *pdata;
>   	struct tpdm_drvdata *drvdata;
>   	struct coresight_desc desc = { 0 };
> +	int ret;
>   
>   	pdata = coresight_get_platform_data(dev);
>   	if (IS_ERR(pdata))
> @@ -200,6 +241,8 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   
>   	drvdata->base = base;
>   
> +	tpdm_datasets_setup(drvdata);
> +
>   	/* Set up coresight component description */
>   	desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
>   	if (!desc.name)
> @@ -216,7 +259,12 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   		return PTR_ERR(drvdata->csdev);
>   
>   	spin_lock_init(&drvdata->spinlock);
> -	tpdm_init_default_data(drvdata);
> +	ret = tpdm_init_datasets(drvdata);

Couldn't this be done before the coresight_register() ? As such
I don't see any dependency on having a csdev ?

Suzuki
