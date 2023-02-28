Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BE96A57AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjB1LWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjB1LWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:22:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D6DD83FF;
        Tue, 28 Feb 2023 03:22:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E04CEC14;
        Tue, 28 Feb 2023 03:23:02 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EBDB3F881;
        Tue, 28 Feb 2023 03:22:17 -0800 (PST)
Message-ID: <89247650-2bff-cb94-eaed-f1d6c343035a@arm.com>
Date:   Tue, 28 Feb 2023 11:22:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/9] coresight-tpdm: Add reset node to TPDM node
Content-Language: en-US
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
 <1674114105-16651-5-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1674114105-16651-5-git-send-email-quic_taozha@quicinc.com>
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
> TPDM device need a node to reset the configurations and status of
> it. So as to avoid the previous configurations affecting the
> current use, the configurations need to be reset first. And in
> some scenarios, it may be necessary to reset the TPDM
> configurations to complete the verification of certain function.
> This change provides a node to reset the configurations and
> disable the TPDM if it has been enabled.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 32 ++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 6befc87..c29d667d 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -161,6 +161,37 @@ static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>   	}
>   }
>   
> +static ssize_t reset_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf,
> +					  size_t size)
> +{
> +	int ret = 0;
> +	unsigned long val;
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	ret = kstrtoul(buf, 0, &val);
> +	if (ret || (val != 1))
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	/* Reset all datasets to ZERO */
> +	if (drvdata->dsb != NULL)
> +		memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
> +
> +	/* Init the default data */

Code is self explanatory, don't need a comment here.

> +	tpdm_init_default_data(drvdata);

Could this be helper be renamed to

	tpdm_reset_dsb_data() ?

Because, that is what it does now.

> +
> +	spin_unlock(&drvdata->spinlock);
> +
> +	/* Disable tpdm if enabled */
> +	if (drvdata->enable)
> +		coresight_disable(drvdata->csdev);

Woh, where did that come from ? Don't you have a disable handle ?

> +
> +	return size;
> +}
> +static DEVICE_ATTR_WO(reset);
> +

This looks a bit pointless to me, given we have separate controls for 
all that is being achieved above.

Suzuki

>   /*
>    * value 1: 64 bits test data
>    * value 2: 32 bits test data
> @@ -201,6 +232,7 @@ static ssize_t integration_test_store(struct device *dev,
>   static DEVICE_ATTR_WO(integration_test);
>   
>   static struct attribute *tpdm_attrs[] = {
> +	&dev_attr_reset.attr,
>   	&dev_attr_integration_test.attr,
>   	NULL,
>   };

