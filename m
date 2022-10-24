Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FE060B3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiJXROa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiJXRN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:13:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49533E22C6;
        Mon, 24 Oct 2022 08:49:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98487152B;
        Mon, 24 Oct 2022 08:47:50 -0700 (PDT)
Received: from [10.57.68.77] (unknown [10.57.68.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4B4D3F792;
        Mon, 24 Oct 2022 08:47:41 -0700 (PDT)
Message-ID: <9d25a87e-4973-417c-edaf-c82aa34dc232@arm.com>
Date:   Mon, 24 Oct 2022 16:47:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 7/9] coresight-tpdm: Add nodes for dsb element creation
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
 <1662626705-13097-8-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1662626705-13097-8-git-send-email-quic_taozha@quicinc.com>
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
> Add the nodes to set value for DSB edge control and DSB edge
> control mask. Each DSB subunit TPDM has n(n<16) EDCR resgisters
> to configure edge control. And each DSB subunit TPDM has m(m<8)
> ECDMR registers to configure edge control mask.
> 

Please could you describe what these values represent ? Size of
the "value". Without the specs, it is really difficult to comprehend
the code.

Please add comments

> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 130 ++++++++++++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tpdm.h |  11 +++
>   2 files changed, 140 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 7265793..14bcf2b 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -22,7 +22,14 @@ DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>   
>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
> -	u32 val, mode;
> +	u32 val, mode, i;
> +
> +	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
> +		writel_relaxed(drvdata->dsb->edge_ctrl[i],
> +			   drvdata->base + TPDM_DSB_EDCR(i));
> +	for (i = 0; i < TPDM_DSB_MAX_EDCR / 2; i++)

Please use "TPDM_DSB_MAX_EDMCR" for consistency and ease of following
the code.

> +		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
> +			   drvdata->base + TPDM_DSB_EDCMR(i));
>   
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>   	/* Set trigger timestamp */
> @@ -278,6 +285,125 @@ static ssize_t dsb_mode_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(dsb_mode);
>   
> +static ssize_t dsb_edge_ctrl_show(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	int i;
> +
> +	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
> +		return -EPERM;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++) {
> +		size += scnprintf(buf + size, PAGE_SIZE - size,
> +				  "Index:0x%x Val:0x%x\n", i,
> +				  drvdata->dsb->edge_ctrl[i]);
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +
> +/*
> + * value 1: Start EDCR register number
> + * value 2: End EDCR register number
> + * value 3: The value need to be written

What are the constraints on these inputs ? Please add
a comment here. And may be also add a user scenario if possible to
describe the values and its effects on the unit ?

> + */
> +static ssize_t dsb_edge_ctrl_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf,
> +					size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long start, end, edge_ctrl;
> +	uint32_t val;
> +	int i, bit, reg;
> +
> +	if (sscanf(buf, "%lx %lx %lx", &start, &end, &edge_ctrl) != 3)
> +		return -EINVAL;
> +	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB) ||
> +	    (start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES) ||
> +	    edge_ctrl > 0x2)
> +		return -EPERM;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = start; i <= end; i++) {
> +		reg = i / (NUM_OF_BITS / 2);
> +		bit = i % (NUM_OF_BITS / 2);

NUM_OF_BITS in what ? That is too generic.

> +		bit = bit * 2;

minor nit: Name "bit" is confusing here. s/bit/{index or even field}?

> +
> +		val = drvdata->dsb->edge_ctrl[reg];
> +		val = val & ~GENMASK((bit + 1), bit);
> +		val = val | (edge_ctrl << bit);
> +		drvdata->dsb->edge_ctrl[reg] = val;
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_edge_ctrl);
> +
> +static ssize_t dsb_edge_ctrl_mask_show(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	int i;
> +
> +	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
> +		return -EPERM;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_EDCR / 2; i++) {
> +		size += scnprintf(buf + size, PAGE_SIZE - size,
> +				  "Index:0x%x Val:0x%x\n", i,
> +				  drvdata->dsb->edge_ctrl_mask[i]);
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +
> +/*
> + * value 1: Start EDCMR register number
> + * value 2: End EDCMR register number
> + * value 3: The value need to be written
> + */
> +static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf,
> +					     size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long start, end, val;
> +	u32 set;
> +	int i, bit, reg;
> +
> +	if (sscanf(buf, "%lx %lx %lx", &start, &end, &val) != 3)
> +		return -EINVAL;
> +	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB) ||

Please use is_visible() hook.

> +	    (start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES))
> +		return -EPERM;

No constraints on "val"? 0 or 1 ?

> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = start; i <= end; i++) {
> +		reg = i / NUM_OF_BITS;
> +		bit = (i % NUM_OF_BITS);
> +
> +		set = drvdata->dsb->edge_ctrl_mask[reg];
> +		if (val)
> +			set = set | BIT(bit);

minor nit:
			set |= ..

> +		else
> +			set = set & ~BIT(bit);

			set &= .. ?

> +		drvdata->dsb->edge_ctrl_mask[reg] = set;
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
> +
>   static ssize_t dsb_trig_type_show(struct device *dev,
>   				     struct device_attribute *attr,
>   				     char *buf)
> @@ -359,6 +485,8 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
>   static DEVICE_ATTR_RW(dsb_trig_ts);
>   static struct attribute *tpdm_dsb_attrs[] = {
>   	&dev_attr_dsb_mode.attr,
> +	&dev_attr_dsb_edge_ctrl.attr,
> +	&dev_attr_dsb_edge_ctrl_mask.attr,
>   	&dev_attr_dsb_trig_ts.attr,
>   	&dev_attr_dsb_trig_type.attr,
>   	NULL,
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 4d57488..ed03c68 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -12,6 +12,8 @@
>   /* DSB Subunit Registers */
>   #define TPDM_DSB_CR		(0x780)
>   #define TPDM_DSB_TIER		(0x784)
> +#define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
> +#define TPDM_DSB_EDCMR(n)	(0x848 + (n * 4))
>   
>   /* Enable bit for DSB subunit */
>   #define TPDM_DSB_CR_ENA		BIT(0)
> @@ -28,6 +30,8 @@
>   #define TPDM_DSB_MODE_HPBYTESEL(val)	BMVAL(val, 4, 8)
>   #define TPDM_MODE_ALL			(0xFFFFFFF)
>   
> +#define NUM_OF_BITS		32
> +
>   /* TPDM integration test registers */
>   #define TPDM_ITATBCNTRL		(0xEF0)
>   #define TPDM_ITCNTRL		(0xF00)
> @@ -54,14 +58,21 @@
>   #define TPDM_PIDR0_DS_IMPDEF	BIT(0)
>   #define TPDM_PIDR0_DS_DSB	BIT(1)
>   
> +#define TPDM_DSB_MAX_EDCR	16 > +#define TPDM_DSB_MAX_LINES	256

A comment here would help :
e.g, EDCR has 2 bits for each lines. Thus we can
support upto (16 * 32) / 2 lines.

May be, even use that math above instead of hard coding 256 ?
And explain what each bits would do ?

> +
>   /**
>    * struct dsb_dataset - specifics associated to dsb dataset
>    * @mode:             DSB programming mode
> + * @edge_ctrl:        Save value for edge control
> + * @edge_ctrl_mask:   Save value for edge control mask
>    * @trig_ts:          Enable/Disable trigger timestamp.
>    * @trig_type:        Enable/Disable trigger type.
>    */
>   struct dsb_dataset {
>   	u32				mode;
> +	u32				edge_ctrl[TPDM_DSB_MAX_EDCR];
> +	u32				edge_ctrl_mask[TPDM_DSB_MAX_EDCR / 2];

Please use TPDM_DSB_MAX_EDCMR instead.

Suzuki

>   	bool			trig_ts;
>   	bool			trig_type;
>   };

