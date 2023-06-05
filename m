Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC0272235F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjFEKY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjFEKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:24:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EF38EA;
        Mon,  5 Jun 2023 03:24:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADABAD75;
        Mon,  5 Jun 2023 03:25:30 -0700 (PDT)
Received: from [10.57.25.141] (unknown [10.57.25.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7128E3F793;
        Mon,  5 Jun 2023 03:24:42 -0700 (PDT)
Message-ID: <08c9f926-53f2-2b2f-1acc-274643c7de00@arm.com>
Date:   Mon, 5 Jun 2023 11:24:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH v4 11/11] coresight-tpdm: Add nodes for dsb msr support
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
 <1682586037-25973-12-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1682586037-25973-12-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 10:00, Tao Zhang wrote:
> Add the nodes for DSB subunit MSR(mux select register) support.
> The TPDM MSR (mux select register) interface is an optional
> interface and associated bank of registers per TPDM subunit.
> The intent of mux select registers is to control muxing structures
> driving the TPDM’s’ various subunit interfaces.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 15 ++++++
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 53 ++++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h       |  3 ++
>   3 files changed, 71 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index 639b6fb8..f746f25 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -170,3 +170,18 @@ Description:
>   		Accepts only one of the 2 values -  0 or 1.
>   		0 : Set the DSB pattern type to value.
>   		1 : Set the DSB pattern type to toggle.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_msr
> +Date:		March 2023
> +KernelVersion	6.3
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the MSR(mux select register) of DSB tpdm. Read
> +		the MSR(mux select register) of DSB tpdm.
> +
> +		Expected format is the following:
> +		<integer1> <integer2>
> +
> +		Where:
> +		<integer1> : Index number of MSR register
> +		<integer2> : The value need to be written
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 627de36..5fe0bd5c 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -240,6 +240,14 @@ static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
>   			if (!drvdata->dsb)
>   				return -ENOMEM;
>   		}
> +		if (!of_property_read_u32(drvdata->dev->of_node,
> +			   "qcom,dsb_msr_num", &drvdata->dsb->msr_num)) {
> +			drvdata->dsb->msr = devm_kzalloc(drvdata->dev,
> +				   (drvdata->dsb->msr_num * sizeof(*drvdata->dsb->msr)),
> +				   GFP_KERNEL);
> +			if (!drvdata->dsb->msr)
> +				return -ENOMEM;
> +		}
>   	}
>   
>   	return 0;
> @@ -765,6 +773,50 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(dsb_trig_ts);
>   
> +static ssize_t dsb_msr_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned int i;
> +	ssize_t size = 0;
> +
> +	if (drvdata->dsb->msr_num == 0)
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {

Shouldn't this be  "i < drvdata->dsb->msr_num" ?


> +		size += sysfs_emit_at(buf, size,
> +				  "%u 0x%x\n", i, drvdata->dsb->msr[i]);
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +
> +	return size;
> +}
> +
> +static ssize_t dsb_msr_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf,
> +				  size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned int num, val;
> +	int nval;
> +
> +	if (drvdata->dsb->msr_num == 0)
> +		return -EINVAL;
> +
> +	nval = sscanf(buf, "%u %x", &num, &val);
> +	if ((nval != 2) || (num >= (drvdata->dsb->msr_num - 1)))

(num >= drvdata->dsb->msr_num) ?

> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	drvdata->dsb->msr[num] = val;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_msr);
> +
>   static struct attribute *tpdm_dsb_attrs[] = {
>   	&dev_attr_dsb_mode.attr,
>   	&dev_attr_dsb_edge_ctrl.attr,
> @@ -777,6 +829,7 @@ static struct attribute *tpdm_dsb_attrs[] = {
>   	&dev_attr_dsb_trig_patt_mask.attr,
>   	&dev_attr_dsb_trig_ts.attr,
>   	&dev_attr_dsb_trig_type.attr,
> +	&dev_attr_dsb_msr.attr,
>   	NULL,
>   };
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 9ad32a6..05e9f8e 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -18,6 +18,7 @@
>   #define TPDM_DSB_XPMR(n)	(0x7E8 + (n * 4))
>   #define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
>   #define TPDM_DSB_EDCMR(n)	(0x848 + (n * 4))
> +#define TPDM_DSB_MSR(n)		(0x980 + (n * 4))
>   
>   /* Enable bit for DSB subunit */
>   #define TPDM_DSB_CR_ENA		BIT(0)
> @@ -113,6 +114,8 @@ struct dsb_dataset {
>   	u32				trig_patt_mask[TPDM_DSB_MAX_PATT];
>   	bool			trig_ts;
>   	bool			trig_type;
> +	u32				msr_num;
> +	u32				*msr;
>   };
>   
>   /**


Where/when do we write to these registers in the DSB ?

Suzuki
