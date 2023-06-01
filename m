Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEFB719BC4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjFAMP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjFAMPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:15:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F26A71B7;
        Thu,  1 Jun 2023 05:14:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F5BD1063;
        Thu,  1 Jun 2023 05:14:52 -0700 (PDT)
Received: from [10.57.22.125] (unknown [10.57.22.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 740183F7D8;
        Thu,  1 Jun 2023 05:14:04 -0700 (PDT)
Message-ID: <606b8a25-0468-c310-ccff-1477e2b238b2@arm.com>
Date:   Thu, 1 Jun 2023 13:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH v4 07/11] coresight-tpdm: Add nodes for dsb edge control
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
 <1682586037-25973-8-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1682586037-25973-8-git-send-email-quic_taozha@quicinc.com>
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
> Add the nodes to set value for DSB edge control and DSB edge
> control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
> resgisters to configure edge control. DSB edge detection control
> 00: Rising edge detection
> 01: Falling edge detection
> 10: Rising and falling edge detection (toggle detection)
> And each DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
> configure mask. Eight 32 bit registers providing DSB interface
> edge detection mask control.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  32 +++++
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 135 ++++++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tpdm.h       |  21 ++++
>   3 files changed, 187 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index 348e167..a57f000 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -60,3 +60,35 @@ Description:
>   		Bit[3] : Set to 0 for low performance mode.
>   				 Set to 1 for high performance mode.
>   		Bit[4:8] : Select byte lane for high performance mode.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl
> +Date:		March 2023
> +KernelVersion	6.3
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		Read/Write a set of the edge control registers of the DSB
> +		in TPDM.
> +
> +		Expected format is the following:
> +		<integer1> <integer2> <integer3>
> +
> +		Where:
> +		<integer1> : Start EDCR register number
> +		<integer2> : End EDCR register number
> +		<integer3> : The value need to be written
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl_mask
> +Date:		March 2023
> +KernelVersion	6.3
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		Read/Write a set of the edge control mask registers of the
> +		DSB in TPDM.
> +
> +		Expected format is the following:
> +		<integer1> <integer2> <integer3>
> +
> +		Where:
> +		<integer1> : Start EDCMR register number
> +		<integer2> : End EDCMR register number
> +		<integer3> : The value need to be written
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 1bacaa5..a40e458 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -80,7 +80,14 @@ static void set_trigger_type(struct tpdm_drvdata *drvdata, u32 *val)
>   
>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
> -	u32 val;
> +	u32 val, i;
> +
> +	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
> +		writel_relaxed(drvdata->dsb->edge_ctrl[i],
> +			   drvdata->base + TPDM_DSB_EDCR(i));
> +	for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
> +		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
> +			   drvdata->base + TPDM_DSB_EDCMR(i));

Do all TPDM DSBs have MAX_EDCR registers ? Or some have less than that ?
If it is latter, do we need special care to avoid writing to inexistent
registers ?

>   
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>   	/* Set trigger timestamp */
> @@ -313,6 +320,130 @@ static ssize_t dsb_mode_store(struct device *dev,
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
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++) {
> +		size += sysfs_emit_at(buf, size,
> +				  "Index:0x%x Val:0x%x\n", i,
> +				  drvdata->dsb->edge_ctrl[i]);

It may be safe, but please add a check to make sure that we don't
overflow. At least bail out when we hit a return of 0, indicating
reached the end of buffer.

> +	}
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +
> +/*
> + * value 1: Start EDCR register number
> + * value 2: End EDCR register number
> + * value 3: The value need to be written
> + * The EDCR registers can include up to 16 32-bit registers, and each
> + * one can be configured to control up to 16 edge detections(2 bits
> + * control one edge detection). So a total 256 edge detections can be
> + * configured. So the starting number(value 1) and ending number(value 2)
> + * cannot be greater than 256, and value 1 should be less than value 2.
> + * The following values are the rage of value 3.
> + * 0 - Rising edge detection
> + * 1 - Falling edge detection
> + * 2 - Rising and falling edge detection (toggle detection)
> + */
> +static ssize_t dsb_edge_ctrl_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf,
> +					size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val, mask, start, end, edge_ctrl, edge_ctrl_shift;
> +	int i, reg;
> +
> +	if (sscanf(buf, "%lx %lx %lx", &start, &end, &edge_ctrl) != 3)
> +		return -EINVAL;
> +	if ((start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES) ||
> +	    (start > end) || (edge_ctrl > 0x2))
> +		return -EPERM;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = start; i <= end; i++) {
> +		/*
> +		 * There are 2 bit per DSB Edge Control line.
> +		 * Thus we have 16 lines in a 32bit word.
> +		 */
> +		reg = EDCR_TO_WORD_IDX(i);
> +		mask = EDCR_TO_WORD_MASK(i);
> +		val = drvdata->dsb->edge_ctrl[reg];

> +		edge_ctrl_shift = EDCR_TO_WORD_VAL(edge_ctrl, i);
> +		bitmap_replace(&val, &val, &edge_ctrl_shift, &mask, 32);

Could we simply do :

		reg &= ~mask;
		reg |= FIELD_PREP(mask, edge_ctrl);


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
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++) {
> +		size += sysfs_emit_at(buf, size,
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
> +	int i, reg;
> +
> +	if (sscanf(buf, "%lx %lx %lx", &start, &end, &val) != 3)
> +		return -EINVAL;
> +	if ((start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES)
> +		|| (start > end) || (val & ~1UL))
> +		return -EPERM;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = start; i <= end; i++) {
> +		/*
> +		 * There is 1 bit per DSB Edge Control Mark line.
> +		 * Thus we have 32 lines in a 32bit word.
> +		 */
> +		reg = EDCMR_TO_WORD_IDX(i);
> +		set = drvdata->dsb->edge_ctrl_mask[reg];
> +		if (val)
> +			set |= BIT(EDCR_TO_WORD_SHIFT(i));
> +		else
> +			set &= ~BIT(EDCR_TO_WORD_SHIFT(i));
> +		drvdata->dsb->edge_ctrl_mask[reg] = set;
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
> +
>   static ssize_t dsb_trig_type_show(struct device *dev,
>   				     struct device_attribute *attr, char *buf)
>   {
> @@ -385,6 +516,8 @@ static DEVICE_ATTR_RW(dsb_trig_ts);
>   
>   static struct attribute *tpdm_dsb_attrs[] = {
>   	&dev_attr_dsb_mode.attr,
> +	&dev_attr_dsb_edge_ctrl.attr,
> +	&dev_attr_dsb_edge_ctrl_mask.attr,
>   	&dev_attr_dsb_trig_ts.attr,
>   	&dev_attr_dsb_trig_type.attr,
>   	NULL,
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 79df07e..f25dcdec 100644
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
> @@ -34,6 +36,15 @@
>   #define TPDM_DSB_TEST_MODE		GENMASK(10, 9)
>   #define TPDM_DSB_HPSEL		GENMASK(6, 2)
>   
> +#define EDCRS_PER_WORD				16
> +#define EDCR_TO_WORD_IDX(r)			((r) / EDCRS_PER_WORD)
> +#define EDCR_TO_WORD_SHIFT(r)		((r % EDCRS_PER_WORD) * 2)
> +#define EDCR_TO_WORD_VAL(val, r)	(val << EDCR_TO_WORD_SHIFT(r))
> +#define EDCR_TO_WORD_MASK(r)		EDCR_TO_WORD_VAL(0x3, r)

minor nit: add a new line here please

> +#define EDCMRS_PER_WORD				32
> +#define EDCMR_TO_WORD_IDX(r)		((r) / EDCMRS_PER_WORD)
> +#define EDCMR_TO_WORD_SHIFT(r)		((r) % EDCMRS_PER_WORD)
> +
>   /* TPDM integration test registers */
>   #define TPDM_ITATBCNTRL		(0xEF0)
>   #define TPDM_ITCNTRL		(0xF00)
> @@ -60,14 +71,24 @@
>   #define TPDM_PIDR0_DS_IMPDEF	BIT(0)
>   #define TPDM_PIDR0_DS_DSB	BIT(1)
>   
> +#define TPDM_DSB_MAX_LINES	256
> +/* MAX number of EDCR registers */
> +#define TPDM_DSB_MAX_EDCR	16
> +/* MAX number of EDCMR registers */
> +#define TPDM_DSB_MAX_EDCMR	8
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
> +	u32				edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];

minor nit: Please align it with the fields below.

>   	bool			trig_ts;
>   	bool			trig_type;
>   };

Suzuki
