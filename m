Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455415B9897
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiIOKO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiIOKOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:14:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D164183070;
        Thu, 15 Sep 2022 03:14:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C99431692;
        Thu, 15 Sep 2022 03:14:28 -0700 (PDT)
Received: from [10.57.48.93] (unknown [10.57.48.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DECA23F73B;
        Thu, 15 Sep 2022 03:14:19 -0700 (PDT)
Message-ID: <c39b704a-ceae-9db8-7f4f-81d9cfee8495@arm.com>
Date:   Thu, 15 Sep 2022 11:14:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 2/9] coresight-tpda: Add DSB dataset support
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
 <1662626705-13097-3-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1662626705-13097-3-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao

On 08/09/2022 09:44, Tao Zhang wrote:
> Read the DSB element size from the device tree. Set the register
> bit that controls the DSB element size of the corresponding port.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpda.c | 62 ++++++++++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
>   2 files changed, 66 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index c8bbc75..76636a1 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -37,6 +37,15 @@ static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>   	u32 val;
>   
>   	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
> +	/*
> +	 * Configure aggregator port n DSB data set element size
> +	 * Set the bit to 0 if the size is 32
> +	 * Set the bit to 1 if the size is 64
> +	 */
> +	if (drvdata->dsb_esize[port] == 32)
> +		val &= ~TPDA_Pn_CR_DSBSIZE;
> +	else if (drvdata->dsb_esize[port] == 64)
> +		val |= TPDA_Pn_CR_DSBSIZE;
>   	/* Enable the port */
>   	val |= TPDA_Pn_CR_ENA;
>   	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
> @@ -105,6 +114,55 @@ static const struct coresight_ops tpda_cs_ops = {
>   	.link_ops	= &tpda_link_ops,
>   };
>   
> +static int tpda_parse_dsb(struct tpda_drvdata *drvdata)
> +{
> +	int len, port, i;
> +	const __be32 *prop;
> +	struct device_node *node = drvdata->dev->of_node;
> +
> +	/* Read the size of DSB element */
> +	prop = of_get_property(node, "qcom,dsb-elem-size", &len);
> +	if (prop) {
> +		len /= sizeof(__be32);
> +		/*
> +		 * The read set of data is port and size, so the number of data
> +		 * is a multiple of two. And the number of data will not exceed
> +		 * two times that of the TPDA inpurts number.
> +		 */
> +		if (len < 2 || len >= (2 * TPDA_MAX_INPORTS) || len % 2 != 0) {
> +			dev_err(drvdata->dev,
> +				"Dataset DSB width entries are wrong\n");
> +			return -EINVAL;
> +		}
> +
> +		for (i = 0; i < len; i++) {

Please could we be explicit here that we are dealing with 2 entries
in an iteration. i.e,

		for (i = 0; i < len; i += 2) {
> +			port = be32_to_cpu(prop[i++]);

			port = be32_to_cpu(prop[i]);

> +			if (port >= TPDA_MAX_INPORTS) {
> +				dev_err(drvdata->dev,
> +					"Wrong port specified for DSB\n");
> +				return -EINVAL;
> +			}
> +			/* Set DSB element size for corresponding port to dsb_esize*/
> +			drvdata->dsb_esize[port] = be32_to_cpu(prop[i]);

		drvdata->dsb_esize[port] = be32_to_cpu(prop[i + 1]);

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int tpda_parse_of_data(struct tpda_drvdata *drvdata)
> +{
> +	int ret;
> +
> +	ret = tpda_parse_dsb(drvdata);
> +	if (ret) {
> +		dev_err(drvdata->dev, "Fail to get DSB data set element size\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   static int tpda_init_default_data(struct tpda_drvdata *drvdata)
>   {
>   	int atid;
> @@ -148,6 +206,10 @@ static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
>   
>   	spin_lock_init(&drvdata->spinlock);
>   
> +	ret = tpda_parse_of_data(drvdata);
> +	if (ret)
> +		return ret;
> +
>   	ret = tpda_init_default_data(drvdata);
>   	if (ret)
>   		return ret;
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
> index 4beb332..ecc7869 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.h
> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
> @@ -10,6 +10,8 @@
>   #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
>   /* Aggregator port enable bit */
>   #define TPDA_Pn_CR_ENA		BIT(0)
> +/* Aggregator port DSB data set element size bit */
> +#define TPDA_Pn_CR_DSBSIZE		BIT(8)
>   
>   #define TPDA_MAX_INPORTS	32
>   
> @@ -23,6 +25,7 @@
>    * @csdev:      component vitals needed by the framework.
>    * @spinlock:   lock for the drvdata value.
>    * @enable:     enable status of the component.
> + * @dsb_esize   DSB element size

super minor nit: Missing ":", consistent with the other fields.

>    */
>   struct tpda_drvdata {
>   	void __iomem		*base;
> @@ -30,6 +33,7 @@ struct tpda_drvdata {
>   	struct coresight_device	*csdev;
>   	spinlock_t		spinlock;
>   	u8			atid;
> +	u32			dsb_esize[TPDA_MAX_INPORTS];
>   };
>   
>   #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */

Suzuki
