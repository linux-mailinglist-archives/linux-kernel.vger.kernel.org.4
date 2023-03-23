Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE9D6C671C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjCWLwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCWLwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:52:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AC543524B;
        Thu, 23 Mar 2023 04:51:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCF564B3;
        Thu, 23 Mar 2023 04:52:40 -0700 (PDT)
Received: from [10.57.53.151] (unknown [10.57.53.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D9943F766;
        Thu, 23 Mar 2023 04:51:53 -0700 (PDT)
Message-ID: <e578790c-4794-5609-16e8-15d63082760e@arm.com>
Date:   Thu, 23 Mar 2023 11:51:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v3 02/11] coresight-tpda: Add DSB dataset support
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        James Clark <james.clark@arm.com>
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
 <1679551448-19160-3-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1679551448-19160-3-git-send-email-quic_taozha@quicinc.com>
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

On 23/03/2023 06:03, Tao Zhang wrote:
> Read the DSB element size from the device tree. Set the register
> bit that controls the DSB element size of the corresponding port.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpda.c | 58 ++++++++++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
>   2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index f712e11..8dcfc4a 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -21,6 +21,47 @@
>   
>   DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>   
> +/* Search and read element data size from the TPDM node in
> + * the devicetree. Each input port of TPDA is connected to
> + * a TPDM. Different TPDM supports different types of dataset,
> + * and some may support more than one type of dataset.
> + * Parameter "inport" is used to pass in the input port number
> + * of TPDA, and it is set to 0 in the recursize call.
> + * Parameter "parent" is used to pass in the original call.
> + */

I am still not clear why we need to do this recursively ?

> +static int tpda_set_element_size(struct tpda_drvdata *drvdata,
> +			   struct coresight_device *csdev, int inport, bool parent)

Please could we renamse csdev => tpda_dev

> +{
> +	static int nr_inport;
> +	int i;
> +	struct coresight_device *in_csdev;

similarly tpdm_dev ?

Could we not add a check here to see if the dsb_esize[inport] is already
set and then bail out, reading this over and over ?

> +
> +	if (inport > (TPDA_MAX_INPORTS - 1))
> +		return -EINVAL;
> +
> +	if (parent)
> +		nr_inport = inport;
> +
> +	for (i = 0; i < csdev->pdata->nr_inconns; i++) {
> +		in_csdev = csdev->pdata->in_conns[i].remote_dev;

Please note, the names of the structure field might change in the
next version of James' series

> +		if (!in_csdev)
> +			break;
> +
> +		if (parent)
> +			if (csdev->pdata->in_conns[i].port != inport)
> +				continue;
> +
> +		if (in_csdev && strstr(dev_name(&in_csdev->dev), "tpdm")) {

Isn't there a better way to distinguish a device to be TPDM ? May be we
could even add a source_sub_type - SOURCE_TPDM instead of using
SOURCE_OTHERS ? Do you expect other sources to be connected to TPDA?
e.g., STMs ?

> +			of_property_read_u32(in_csdev->dev.parent->of_node,
> +					"qcom,dsb-element-size", &drvdata->dsb_esize[nr_inport]);
> +			break;
> +		}
> +		tpda_set_element_size(drvdata, in_csdev, 0, false);

What is the point of this ? Is this for covering the a TPDA connected to
another TPDA ?

e.g., { TPDM0, TPDM1 } -> TPDA0 -> TPDA1 ?

And you want to figure out the DSB size of TPDM0 when you want to enable
TPDA1 ? How do you choose between that size of TPDM0 vs TPDM1 ?

Please add a proper documentation for this function ? If TPDA0 is in the
the path, it should have been enabled before you reach TPDA1. Thus,
the dsb_esize array must have been initialised for TPDA0 and thus, you
could simply read it from the dsb_esize[] of TPDA0.
You could always look at the device_type and sub_type to detect a
TPDA{0} connected into TPDA{1}



> +	}
> +
> +	return 0;
> +}
> +
>   /* Settings pre enabling port control register */
>   static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>   {
> @@ -37,6 +78,18 @@ static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
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
> +	else
> +		dev_err(drvdata->dev,
> +			"DSB data size input from port[%d] is invalid\n", port);

WARN_ON_ONCE() and abort the enable opration ? Or say, "fallback to 
32bit or 64bit" if one of them is a safer option ? Please don't
leave it unknown.

>   	/* Enable the port */
>   	val |= TPDA_Pn_CR_ENA;
>   	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
> @@ -57,6 +110,11 @@ static void __tpda_enable(struct tpda_drvdata *drvdata, int port)
>   static int tpda_enable(struct coresight_device *csdev, int inport, int outport)
>   {
>   	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	int ret;
> +
> +	ret = tpda_set_element_size(drvdata, csdev, inport, true);
> +	if (ret)
> +		return ret;
>   
>   	spin_lock(&drvdata->spinlock);
>   	if (atomic_read(&csdev->refcnt[inport]) == 0)
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
> index 0399678..9ec5870 100644
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
> + * @dsb_esize:   DSB element size

Please state, must be 32 or 64.

>    */
>   struct tpda_drvdata {
>   	void __iomem		*base;
> @@ -30,6 +33,7 @@ struct tpda_drvdata {
>   	struct coresight_device	*csdev;
>   	spinlock_t		spinlock;
>   	u8			atid;
> +	u32			dsb_esize[TPDA_MAX_INPORTS];

Couldn't this be u8 ?


Suzuki

>   };
>   
>   #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */

