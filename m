Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F5170DDBD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbjEWNmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbjEWNmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:42:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BA04121;
        Tue, 23 May 2023 06:42:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5433139F;
        Tue, 23 May 2023 06:42:54 -0700 (PDT)
Received: from [10.57.73.71] (unknown [10.57.73.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43E273F840;
        Tue, 23 May 2023 06:42:07 -0700 (PDT)
Message-ID: <db575b8f-12e9-dab5-c7f6-b524cbce64d9@arm.com>
Date:   Tue, 23 May 2023 14:42:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 03/11] coresight-tpdm: Initialize DSB subunit
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
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
 <1682586037-25973-4-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1682586037-25973-4-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 10:00, Tao Zhang wrote:
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
>   drivers/hwtracing/coresight/coresight-tpdm.c | 60 +++++++++++++++++++++++++---
>   drivers/hwtracing/coresight/coresight-tpdm.h | 17 ++++++++
>   2 files changed, 72 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index ba1867f..6f8a8ab 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -20,17 +20,51 @@
>   
>   DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>   
> +static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
> +{
> +	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
> +		memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
> +
> +		drvdata->dsb->trig_ts = true;
> +		drvdata->dsb->trig_type = false;
> +	}
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

Given this is not reused, we could simply inline it in the caller
to avoid creating a confusion, like other operations ?

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
> +		val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;,
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

minor nit: Please could you extend the existing comment than adding a
new multi-line comment ?

> + * dataset types. It covers Basic Counts(BC), Tenure Counts(TC),
> + * Continuous Multi-Bit(CMB), Multi-lane CMB(MCMB) and Discrete Single
> + * Bit(DSB). This function will initialize the configuration according
> + * to the dataset type supported by the TPDM.
> + */
>   static void __tpdm_enable(struct tpdm_drvdata *drvdata)
>   {
>   	CS_UNLOCK(drvdata->base);
> @@ -110,15 +144,24 @@ static const struct coresight_ops tpdm_cs_ops = {
>   	.source_ops	= &tpdm_source_ops,
>   };
>   
> -static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
> +static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
>   {
>   	u32 pidr;
>   
> -	CS_UNLOCK(drvdata->base);
>   	/*  Get the datasets present on the TPDM. */
>   	pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
>   	drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
> -	CS_LOCK(drvdata->base);

Why are we removing the CS_{UN,}LOCK here ?

Rest looks OK to me.

Suzuki

> +
> +	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
> +		if (!drvdata->dsb) {
> +			drvdata->dsb = devm_kzalloc(drvdata->dev,
> +						    sizeof(*drvdata->dsb), GFP_KERNEL);
> +			if (!drvdata->dsb)
> +				return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
>   }
>   
>   /*
> @@ -181,6 +224,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   	struct coresight_platform_data *pdata;
>   	struct tpdm_drvdata *drvdata;
>   	struct coresight_desc desc = { 0 };
> +	int ret;
>   
>   	pdata = coresight_get_platform_data(dev);
>   	if (IS_ERR(pdata))
> @@ -200,6 +244,12 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   
>   	drvdata->base = base;
>   
> +	ret = tpdm_datasets_setup(drvdata);
> +	if (ret)
> +		return ret;
> +
> +	tpdm_reset_datasets(drvdata);
> +
>   	/* Set up coresight component description */
>   	desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
>   	if (!desc.name)
> @@ -216,7 +266,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   		return PTR_ERR(drvdata->csdev);
>   
>   	spin_lock_init(&drvdata->spinlock);
> -	tpdm_init_default_data(drvdata);
> +
>   	/* Decrease pm refcount when probe is done.*/
>   	pm_runtime_put(&adev->dev);
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 5438540..68f33bd 100644
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
> +/* Enable bit for DSB subunit trigger type */
> +#define TPDM_DSB_CR_TRIG_TYPE		BIT(12)
> +/* Enable bit for DSB subunit trigger timestamp */
> +#define TPDM_DSB_TIER_XTRIG_TSENAB		BIT(1)
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

