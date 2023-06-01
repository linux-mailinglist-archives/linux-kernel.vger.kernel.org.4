Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9A9719E21
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjFAN3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjFAN3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:29:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EA0E1B8;
        Thu,  1 Jun 2023 06:28:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2643AC14;
        Thu,  1 Jun 2023 06:29:14 -0700 (PDT)
Received: from [10.57.22.125] (unknown [10.57.22.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22A703F7D8;
        Thu,  1 Jun 2023 06:28:26 -0700 (PDT)
Message-ID: <6be47f1a-16ca-76ca-b133-ee453c261c21@arm.com>
Date:   Thu, 1 Jun 2023 14:28:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH v4 08/11] coresight-tpdm: Add nodes to configure pattern
 match output
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
 <1682586037-25973-9-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1682586037-25973-9-git-send-email-quic_taozha@quicinc.com>
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
> Add nodes to configure trigger pattern and trigger pattern mask.
> Each DSB subunit TPDM has maximum of n(n<7) XPR registers to
> configure trigger pattern match output. Eight 32 bit registers
> providing DSB interface trigger output pattern match comparison.
> And each DSB subunit TPDM has maximum of m(m<7) XPMR registers to
> configure trigger pattern mask match output. Eight 32 bit
> registers providing DSB interface trigger output pattern match
> mask.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 30 ++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 85 ++++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h       |  8 ++
>   3 files changed, 123 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index a57f000..c04c735 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -92,3 +92,33 @@ Description:
>   		<integer1> : Start EDCMR register number
>   		<integer2> : End EDCMR register number
>   		<integer3> : The value need to be written
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt_val
> +Date:		March 2023
> +KernelVersion	6.3
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the trigger pattern value of DSB tpdm.
> +		Read the trigger pattern value of DSB tpdm.
> +
> +		Expected format is the following:
> +		<integer1> <integer2>
> +
> +		Where:
> +		<integer1> : Index number of XPR register, the range is 0 to 7
> +		<integer2> : The value need to be written

I assume the values written to the registers are not special and doesn't
have meaning and thus need not be documented ?

> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt_mask
> +Date:		March 2023
> +KernelVersion	6.3

Same as the previous one, 6.5 please

> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the trigger pattern mask of DSB tpdm.
> +		Read the trigger pattern mask of DSB tpdm.
> +
> +		Expected format is the following:
> +		<integer1> <integer2>
> +
> +		Where:
> +		<integer1> : Index number of XPMR register,  the range is 0 to 7
> +		<integer2> : The value need to be written
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index a40e458..9387bdf 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -89,6 +89,13 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
>   			   drvdata->base + TPDM_DSB_EDCMR(i));
>   
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {

Same as the previous, can we safely assume that write to these
registers won't trigger an Error if not impelemented ?

> +		writel_relaxed(drvdata->dsb->trig_patt_val[i],
> +			    drvdata->base + TPDM_DSB_XPR(i));
> +		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
> +			    drvdata->base + TPDM_DSB_XPMR(i));
> +	}
> +
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>   	/* Set trigger timestamp */
>   	if (drvdata->dsb->trig_ts)
> @@ -444,6 +451,82 @@ static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
>   
> +static ssize_t dsb_trig_patt_val_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	int i = 0;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		size += sysfs_emit_at(buf, size,
> +				  "Index: 0x%x Value: 0x%x\n", i,
> +				  drvdata->dsb->trig_patt_val[i]);

Please detect the return of 0 and break. Same below.


> +	}
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +
> +static ssize_t dsb_trig_patt_val_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf,
> +					    size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long index, val;
> +
> +	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
> +		return -EINVAL;
> +	if (index >= TPDM_DSB_MAX_PATT)
> +		return -EPERM;
> +
> +	spin_lock(&drvdata->spinlock);
> +	drvdata->dsb->trig_patt_val[index] = val;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_trig_patt_val);
> +
> +static ssize_t dsb_trig_patt_mask_show(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	int i = 0;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		size += sysfs_emit_at(buf, size,
> +				  "Index: 0x%x Value: 0x%x\n", i,
> +				  drvdata->dsb->trig_patt_mask[i]);
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +	return size;

Suzuki

