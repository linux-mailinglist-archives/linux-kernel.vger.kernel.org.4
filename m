Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C3609EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiJXKMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiJXKLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:11:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FC025143C;
        Mon, 24 Oct 2022 03:11:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C911DED1;
        Mon, 24 Oct 2022 03:10:58 -0700 (PDT)
Received: from [10.57.68.77] (unknown [10.57.68.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACD103F7B4;
        Mon, 24 Oct 2022 03:10:49 -0700 (PDT)
Message-ID: <cbe5813e-337b-6c77-8571-cf400d4abc41@arm.com>
Date:   Mon, 24 Oct 2022 11:10:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 4/9] coresight-tpdm: Add reset node to TPDM node
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
 <1662626705-13097-5-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1662626705-13097-5-git-send-email-quic_taozha@quicinc.com>
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
> TPDM device need a node to reset the configurations and status of
> it. This change provides a node to reset the configurations and
> disable the TPDM if it has been enabled.

It is not clear to me *why* this is needed. Please could you
elaborate on the use case of this ? See my questions below.

> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 32 ++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 69ea453..74cc653 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -152,6 +152,37 @@ static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>   	}
>   }
>   
> +static ssize_t reset_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf,
> +					  size_t size)

minor nit: Alignment

> +{
> +	int ret = 0;
> +	unsigned long val;
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	ret = kstrtoul(buf, 10, &val);

So, any integer value written to the sysfs knob triggers the rest ?
It may be better to restrict this to "1".


> +	if (ret)
> +		return ret;
> +
> +	spin_lock(&drvdata->spinlock);
> +	/* Reset all datasets to ZERO */
> +	if (drvdata->dsb != NULL)
> +		memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
> +
> +	/* Init the default data */
> +	tpdm_init_default_data(drvdata);

Why is this needed ? Does the DSB device configuration change
on the fly ?

> +
> +	spin_unlock(&drvdata->spinlock);
> +
> +	/* Disable tpdm if enabled */
> +	if (drvdata->enable)
> +		coresight_disable(drvdata->csdev);

Why is this needed ? Isn't this supposed to be triggered from the "path"
when the trace session is complete ?


Suzuki

> +
> +	return size;
> +}
> +static DEVICE_ATTR_WO(reset);
> +
>   /*
>    * value 1: 64 bits test data
>    * value 2: 32 bits test data
> @@ -192,6 +223,7 @@ static ssize_t integration_test_store(struct device *dev,
>   static DEVICE_ATTR_WO(integration_test);
>   
>   static struct attribute *tpdm_attrs[] = {
> +	&dev_attr_reset.attr,
>   	&dev_attr_integration_test.attr,
>   	NULL,
>   };

