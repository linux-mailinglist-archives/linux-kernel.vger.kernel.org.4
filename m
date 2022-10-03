Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9FA5F2CCD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiJCJH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiJCJHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:07:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DB19167C7;
        Mon,  3 Oct 2022 02:04:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70A861042;
        Mon,  3 Oct 2022 02:04:29 -0700 (PDT)
Received: from [192.168.4.86] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E27513F792;
        Mon,  3 Oct 2022 02:04:20 -0700 (PDT)
Message-ID: <65e70db9-9f85-7285-0602-f2d29887550a@arm.com>
Date:   Mon, 3 Oct 2022 10:04:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v3 03/13] coresight: stm: Update STM driver to use Trace
 ID API
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20220809223401.24599-1-mike.leach@linaro.org>
 <20220809223401.24599-4-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220809223401.24599-4-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2022 23:33, Mike Leach wrote:
> Updates the STM driver to use the trace ID allocation API.
> This uses the _system_id calls to allocate an ID on device poll,
> and release on device remove.
> 
> The sysfs access to the STMTRACEIDR register has been changed from RW
> to RO. Having this value as writable is not appropriate for the new
> Trace ID scheme - and had potential to cause errors in the previous
> scheme if values clashed with other sources.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-stm.c | 41 +++++++--------------
>   1 file changed, 14 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index bb14a3a8a921..9ef3e923a930 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -31,6 +31,7 @@
>   #include <linux/stm.h>
>   
>   #include "coresight-priv.h"
> +#include "coresight-trace-id.h"
>   
>   #define STMDMASTARTR			0xc04
>   #define STMDMASTOPR			0xc08
> @@ -615,24 +616,7 @@ static ssize_t traceid_show(struct device *dev,
>   	val = drvdata->traceid;
>   	return sprintf(buf, "%#lx\n", val);
>   }
> -
> -static ssize_t traceid_store(struct device *dev,
> -			     struct device_attribute *attr,
> -			     const char *buf, size_t size)
> -{
> -	int ret;
> -	unsigned long val;
> -	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -
> -	ret = kstrtoul(buf, 16, &val);
> -	if (ret)
> -		return ret;
> -
> -	/* traceid field is 7bit wide on STM32 */
> -	drvdata->traceid = val & 0x7f;
> -	return size;
> -}
> -static DEVICE_ATTR_RW(traceid);
> +static DEVICE_ATTR_RO(traceid);
>   
>   #define coresight_stm_reg(name, offset)	\
>   	coresight_simple_reg32(struct stm_drvdata, name, offset)
> @@ -819,14 +803,6 @@ static void stm_init_default_data(struct stm_drvdata *drvdata)
>   	 */
>   	drvdata->stmsper = ~0x0;
>   
> -	/*
> -	 * The trace ID value for *ETM* tracers start at CPU_ID * 2 + 0x10 and
> -	 * anything equal to or higher than 0x70 is reserved.  Since 0x00 is
> -	 * also reserved the STM trace ID needs to be higher than 0x00 and
> -	 * lowner than 0x10.
> -	 */
> -	drvdata->traceid = 0x1;
> -
>   	/* Set invariant transaction timing on all channels */
>   	bitmap_clear(drvdata->chs.guaranteed, 0, drvdata->numsp);
>   }
> @@ -854,7 +830,7 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
>   
>   static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>   {
> -	int ret;
> +	int ret, trace_id;
>   	void __iomem *base;
>   	struct device *dev = &adev->dev;
>   	struct coresight_platform_data *pdata = NULL;
> @@ -938,12 +914,22 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>   		goto stm_unregister;
>   	}
>   
> +	trace_id = coresight_trace_id_get_system_id();
> +	if (trace_id < 0) {

The above API returns "INVALID_ID" and not a negative error status.
I think it is better to fix the API to return:

   ret < 0  - If there is any error
            - Otherwise a positive integer
And the users should be kept unaware of which ID is valid or invalid.

Suzuki
