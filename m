Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62596A579A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjB1LQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjB1LQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:16:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7C921DB99;
        Tue, 28 Feb 2023 03:16:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 911A5C14;
        Tue, 28 Feb 2023 03:17:38 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C602D3F881;
        Tue, 28 Feb 2023 03:16:52 -0800 (PST)
Message-ID: <ba7dba61-9fa1-1b6f-c95e-2c23d8f9c2d4@arm.com>
Date:   Tue, 28 Feb 2023 11:16:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/9] coresight-tpdm: Initialize DSB subunit
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
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        Tao Zhang <taozha@qti.qualcomm.com>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
 <1674114105-16651-4-git-send-email-quic_taozha@quicinc.com>
Content-Language: en-US
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1674114105-16651-4-git-send-email-quic_taozha@quicinc.com>
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
> DSB subunit need to be configured in enablement and disablement.
> A struct that specifics associated to dsb dataset is needed. It
> saves the configuration and parameters of the dsb datasets. This
> change is to add this struct and initialize the configuration of
> DSB subunit.

Please could add a line about the type of things you can do with DSB.
e.g, Timestamp, trigger type etc ? The description seems to be 
describing the code, rather than the functionality of the code.

> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>

As pointed out on the previous response by someone else, please fix the
above to single.


> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 57 ++++++++++++++++++++++++++--
>   drivers/hwtracing/coresight/coresight-tpdm.h | 17 +++++++++
>   2 files changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index d85ca96..6befc87 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -24,13 +24,35 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
>   	u32 val;
>   
> +	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
> +	/* Set trigger timestamp */
> +	if (drvdata->dsb->trig_ts)
> +		val |= TPDM_DSB_XTRIG_TSENAB;
> +	else
> +		val &= ~TPDM_DSB_XTRIG_TSENAB;
> +	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
> +
> +	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> +	/* Set trigger type */
> +	if (drvdata->dsb->trig_type)
> +		val |= TPDM_DSB_TRIG_TYPE;
> +	else
> +		val &= ~TPDM_DSB_TRIG_TYPE;
> +	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
> +
>   	/* Set the enable bit of DSB control register to 1 */
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>   	val |= TPDM_DSB_CR_ENA;
>   	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);

Do they have to be written out separately ? Why not combine the value 
updates to the TPDM_DSB_CR ?


>   }
>   
> -/* TPDM enable operations */
> +/* TPDM enable operations

Minor nit: Comment style issues.


> + * The TPDM or Monitor serves as data collection component for various
> + * dataset types. It covers Basic Counts(BC), Tenure Counts(TC),
> + * Continuous Multi-Bit(CMB), Multi-lane CMB(MCMB) and Discrete Single
> + * Bit(DSB). This function will initialize the configuration according
> + * to the dataset type supported by the TPDM.
> + */
>   static void __tpdm_enable(struct tpdm_drvdata *drvdata)
>   {
>   	CS_UNLOCK(drvdata->base);
> @@ -110,15 +132,33 @@ static const struct coresight_ops tpdm_cs_ops = {
>   	.source_ops	= &tpdm_source_ops,
>   };
>   
> -static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
> +static void tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
>   {
>   	u32 pidr;
>   
> -	CS_UNLOCK(drvdata->base);
>   	/*  Get the datasets present on the TPDM. */
>   	pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
>   	drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
> -	CS_LOCK(drvdata->base);
> +}
> +
> +static int tpdm_datasets_alloc(struct tpdm_drvdata *drvdata)
> +{
> +	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
> +		drvdata->dsb = devm_kzalloc(drvdata->dev, sizeof(*drvdata->dsb),
> +					    GFP_KERNEL);
> +		if (!drvdata->dsb)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +

Couldn't this be moved into the init_default_data() ?

> +static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
> +{
> +	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
> +		drvdata->dsb->trig_ts = true;
> +		drvdata->dsb->trig_type = false;



> +	}
>   }

It looks a bit silly to move the initialisation to a separate function. 
Please could you fold this to tpdm_datasets_alloc() and may be even
rename that function to tpdm_init_datasets() ?

Suzuki

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
> @@ -216,7 +259,13 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   		return PTR_ERR(drvdata->csdev);
>   
>   	spin_lock_init(&drvdata->spinlock);
> +	ret = tpdm_datasets_alloc(drvdata);
> +	if (ret) {
> +		coresight_unregister(drvdata->csdev);
> +		return ret;
> +	}
>   	tpdm_init_default_data(drvdata);
> +
>   	/* Decrease pm refcount when probe is done.*/
>   	pm_runtime_put(&adev->dev);
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 5438540..3ad1be5 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -11,8 +11,14 @@
>   
>   /* DSB Subunit Registers */
>   #define TPDM_DSB_CR		(0x780)
> +#define TPDM_DSB_TIER		(0x784)
> +
>   /* Enable bit for DSB subunit */
>   #define TPDM_DSB_CR_ENA		BIT(0)
> +/* Enable bit for DSB subunit trigger timestamp */
> +#define TPDM_DSB_XTRIG_TSENAB		BIT(1)
> +/* Enable bit for DSB subunit trigger type */
> +#define TPDM_DSB_TRIG_TYPE		BIT(12)
>   
>   /* TPDM integration test registers */
>   #define TPDM_ITATBCNTRL		(0xEF0)
> @@ -41,6 +47,16 @@
>   #define TPDM_PIDR0_DS_DSB	BIT(1)
>   
>   /**
> + * struct dsb_dataset - specifics associated to dsb dataset
> + * @trig_ts:          Enable/Disable trigger timestamp.
> + * @trig_type:        Enable/Disable trigger type.
> + */
> +struct dsb_dataset {
> +	bool			trig_ts;
> +	bool			trig_type;
> +};
> +
> +/**
>    * struct tpdm_drvdata - specifics associated to an TPDM component
>    * @base:       memory mapped base address for this component.
>    * @dev:        The device entity associated to this component.
> @@ -57,6 +73,7 @@ struct tpdm_drvdata {
>   	spinlock_t		spinlock;
>   	bool			enable;
>   	unsigned long		datasets;
> +	struct dsb_dataset	*dsb;
>   };
>   
>   #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */

