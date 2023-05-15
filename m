Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A50702CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241847AbjEOMbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbjEOMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:31:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5A0010E5
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:31:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29BD04B3;
        Mon, 15 May 2023 05:32:22 -0700 (PDT)
Received: from [10.57.71.192] (unknown [10.57.71.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93D2D3F663;
        Mon, 15 May 2023 05:31:36 -0700 (PDT)
Message-ID: <2bbb5c99-1406-c940-1191-29cc6338c4d0@arm.com>
Date:   Mon, 15 May 2023 13:31:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] coresight: etm4x: Fix missing trctraceidr file in sysfs
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     leo.yan@linaro.org, hejunhao3@huawei.com
References: <20230512133054.235073-1-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230512133054.235073-1-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 14:30, Mike Leach wrote:
> The trace ID patchset adjusted the handling of the TRCTRACEIDR register
> sysfs to allocate on read.
> 
> Although this was initally correct, the final version of the patch series
> introduced an error which resulted in the mgmt/trctraceidr file in sysfs
> not being visible.
> 
> This patch fixes that issue.
> 
> Fixes: df4871204e5d ("coresight: etm4x: Update ETM4 driver to use Trace ID API")
> 
> Reported-by: Junhao He <hejunhao3@huawei.com>
> Link: https://lists.linaro.org/archives/list/coresight@lists.linaro.org/thread/KK3CVVMRHJWVUORKMFJRSXYCEDFKENQJ/
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   .../coresight/coresight-etm4x-sysfs.c         | 27 ++++++++++++-------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 5e62aa40ecd0..a9f19629f3f8 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -2411,7 +2411,6 @@ static ssize_t trctraceid_show(struct device *dev,
>   
>   	return sysfs_emit(buf, "0x%x\n", trace_id);
>   }
> -static DEVICE_ATTR_RO(trctraceid);
>   
>   struct etmv4_reg {
>   	struct coresight_device *csdev;
> @@ -2528,13 +2527,23 @@ coresight_etm4x_attr_reg_implemented(struct kobject *kobj,
>   	return 0;
>   }
>   
> -#define coresight_etm4x_reg(name, offset)				\
> -	&((struct dev_ext_attribute[]) {				\
> -	   {								\
> -		__ATTR(name, 0444, coresight_etm4x_reg_show, NULL),	\
> -		(void *)(unsigned long)offset				\
> -	   }								\
> -	})[0].attr.attr
> +/*
> + * Macro to set an RO ext attribute with offset and show function.
> + * Offset is used in mgmt group to ensure only correct registers for
> + * the ETM / ETE variant are visible.
> + */
> +#define coresight_etm4x_reg_showfn(name, offset, showfn) (	\
> +	&((struct dev_ext_attribute[]) {			\
> +	   {							\
> +		__ATTR(name, 0444, showfn, NULL),		\
> +		(void *)(unsigned long)offset			\
> +	   }							\
> +	})[0].attr.attr						\
> +	)
> +
> +/* macro using the default coresight_etm4x_reg_show function */
> +#define coresight_etm4x_reg(name, offset)	\
> +	coresight_etm4x_reg_showfn(name, offset, coresight_etm4x_reg_show)
>   
>   static struct attribute *coresight_etmv4_mgmt_attrs[] = {
>   	coresight_etm4x_reg(trcpdcr, TRCPDCR),
> @@ -2549,7 +2558,7 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
>   	coresight_etm4x_reg(trcpidr3, TRCPIDR3),
>   	coresight_etm4x_reg(trcoslsr, TRCOSLSR),
>   	coresight_etm4x_reg(trcconfig, TRCCONFIGR),
> -	&dev_attr_trctraceid.attr,
> +	coresight_etm4x_reg_showfn(trctraceid, TRCTRACEIDR, trctraceid_show),
>   	coresight_etm4x_reg(trcdevarch, TRCDEVARCH),
>   	NULL,
>   };


Looks good to me, Thanks for the fix. I will queue this.

Suzuki

