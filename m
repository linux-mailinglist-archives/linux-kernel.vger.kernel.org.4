Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86AF5B8AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiINOoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiINOoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:44:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD70670E56
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:43:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8F28ED1;
        Wed, 14 Sep 2022 07:44:02 -0700 (PDT)
Received: from [10.57.49.88] (unknown [10.57.49.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00A553F73D;
        Wed, 14 Sep 2022 07:43:54 -0700 (PDT)
Message-ID: <b6c2b3eb-a900-f94e-c472-39719faf65af@arm.com>
Date:   Wed, 14 Sep 2022 15:43:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2] coresight: etm4x: Fix crash observed on Qcom ETM parts
 with 'Low power override'
To:     Leo Yan <leo.yan@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220825052232.11013-1-bhupesh.sharma@linaro.org>
 <YyBg8JhNUnsaeKip@leoy-yangtze.lan>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <YyBg8JhNUnsaeKip@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 11:52, Leo Yan wrote:
> Hi Bhupesh,
> 
> On Thu, Aug 25, 2022 at 10:52:32AM +0530, Bhupesh Sharma wrote:
>> Some Qualcomm ETM implementations require skipping powering up
>> the trace unit, as the ETMs are in the same power domain as
>> their CPU cores.
>>
>> Via commit 5214b563588e ("coresight: etm4x: Add support for
>> sysreg only devices"), the setting of 'skip_power_up' flag was
>> moved after the 'etm4_init_arch_data' function is called, whereas
>> the flag value is itself used inside the function. This causes
>> a crash when ETM mode 'Low-power state behavior override' is set
>> on some Qualcomm parts.
>>
>> Fix the same.
>>
>> Fixes: 5214b563588e ("coresight: etm4x: Add support for sysreg only devices")
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>   - v1 can be seen here: https://lore.kernel.org/lkml/20220803191236.3037591-1-bhupesh.sharma@linaro.org/
>>   - Addressed the review comments from Suzuki.
>>   - Rebased on linux-next.
>>
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index d39660a3e50c..14c1c7869795 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -977,6 +977,16 @@ static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
>>   	if (!cpu_supports_sysreg_trace())
>>   		return false;
>>   
>> +	/*
>> +	 * Some Qualcomm implementations require skipping powering up the trace unit,
>> +	 * as the ETMs are in the same power domain as their CPU cores.
>> +	 *
>> +	 * Since the 'skip_power_up' flag is used inside 'etm4_init_arch_data' function,
>> +	 * initialize it before the function is called.
>> +	 */
>> +	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
>> +		drvdata->skip_power_up = true;
>> +
> 
> I personally think this sentence should be placed in the function
> etm4_probe(), you need to move it just before smp call
> etm4_init_arch_data(), this can allow DT property "qcom,skip-power-up"
> to be respected.

Or we could move this to init_iomem_access() and explicitly set the flag
to true in init_sysreg_access().

> 
>>   	/*
>>   	 * ETMs implementing sysreg access must implement TRCDEVARCH.
>>   	 */
>> @@ -1951,8 +1961,7 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>>   		return -EINVAL;
>>   
>>   	/* TRCPDCR is not accessible with system instructions. */
>> -	if (!desc.access.io_mem ||
>> -	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
>> +	if (!desc.access.io_mem)
>>   		drvdata->skip_power_up = true;
> 
> I prefer to move the condition checking for "desc.access.io_mem" to
> etm4_init_sysreg_access(), this can make sure the flag skip_power_up
> is set correctly based on property of system register access.

+1

> 
> A side topic, in the mainline kernel I found the value
> "desc.access.io_mem" is always zero (see the initialized value in
> etm4_probe() and etm4_init_sysreg_access()).  Should we initialize
> desc.access.io_mem to true in etm4_probe()?

Thats not true. It is initialised at :

etm4_init_iomem_access():

	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);

Where

#define CSDEV_ACCESS_IOMEM(_addr)               \
         ((struct csdev_access)  {               \
                 .io_mem         = true,         \
                 .base           = (_addr),      \
         })



Suzuki
