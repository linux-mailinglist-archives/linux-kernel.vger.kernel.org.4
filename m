Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C969D7223D4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjFEKtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjFEKtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:49:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6BD110D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:49:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C8A2D75;
        Mon,  5 Jun 2023 03:50:23 -0700 (PDT)
Received: from [10.57.85.135] (unknown [10.57.85.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 791263F587;
        Mon,  5 Jun 2023 03:49:36 -0700 (PDT)
Message-ID: <c8c2c7dd-ace1-709b-883b-0b774275f5ef@arm.com>
Date:   Mon, 5 Jun 2023 11:49:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 4/4] perf/arm_cspmu: Decouple APMT dependency
Content-Language: en-GB
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        bwicaksono@nvidia.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1685619571.git.robin.murphy@arm.com>
 <3509b299b19b8bf89700c77c2bb695c740926ae7.1685619571.git.robin.murphy@arm.com>
 <be916ba8-1d2a-89dd-7374-b07618fa9b29@os.amperecomputing.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <be916ba8-1d2a-89dd-7374-b07618fa9b29@os.amperecomputing.com>
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

On 2023-06-05 08:12, Ilkka Koskinen wrote:
> 
> Hi Robin,
> 
> I have a couple of comments below
> 
> On Thu, 1 Jun 2023, Robin Murphy wrote:
>> The functional paths of the driver need not care about ACPI, so abstract
>> the property of atomic doubleword access as its own flag (repacking the
>> structure for a better fit). We also do not need to go poking directly
>> at the APMT for standard resources which the ACPI layer has already
>> dealt with, so deal with the optional MMIO page and interrupt in the
>> normal firmware-agnostic manner. The few remaining portions of probing
>> that *are* APMT-specific can still easily retrieve the APMT pointer as
>> needed without us having to carry a duplicate copy around everywhere.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>> drivers/perf/arm_cspmu/arm_cspmu.c | 45 ++++++++----------------------
>> drivers/perf/arm_cspmu/arm_cspmu.h |  4 +--
>> 2 files changed, 13 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c 
>> b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index 3b91115c376d..f8daf252a488 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> 
> ...
> 
>> @@ -319,7 +309,7 @@ static const char *arm_cspmu_get_name(const struct 
>> arm_cspmu *cspmu)
>>     static atomic_t pmu_idx[ACPI_APMT_NODE_TYPE_COUNT] = { 0 };
>>
>>     dev = cspmu->dev;
>> -    apmt_node = cspmu->apmt_node;
>> +    apmt_node = dev_get_platdata(dev);
> 
> Was platdata changed too? If not, I think this should be
> 
>      apmt_node = *(struct acpi_apmt_node **) dev_get_platdata(dev);

Oof, indeed it looks like I got the wrong thing into my head at the 
critical moment :(

Clearly this deserves a nice helpful wrapper so we only have to think 
about the nasty casting once...

>>     pmu_type = apmt_node->type;
>>
>>     if (pmu_type >= ACPI_APMT_NODE_TYPE_COUNT) {
>> @@ -396,8 +386,8 @@ static const struct impl_match impl_match[] = {
>> static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
>> {
>>     int ret;
>> -    struct acpi_apmt_node *apmt_node = cspmu->apmt_node;
>>     struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
>> +    struct acpi_apmt_node *apmt_node = dev_get_platdata(cspmu->dev);
> 
> Ditto
> 
>>     const struct impl_match *match = impl_match;
>>
>>     /*
> 
> ...
> 
>> @@ -910,24 +900,18 @@ static struct arm_cspmu *arm_cspmu_alloc(struct 
>> platform_device *pdev)
>> {
>>     struct acpi_apmt_node *apmt_node;
>>     struct arm_cspmu *cspmu;
>> -    struct device *dev;
>> -
>> -    dev = &pdev->dev;
>> -    apmt_node = *(struct acpi_apmt_node **)dev_get_platdata(dev);
>> -    if (!apmt_node) {
>> -        dev_err(dev, "failed to get APMT node\n");
>> -        return NULL;
>> -    }
>> +    struct device *dev = &pdev->dev;
>>
>>     cspmu = devm_kzalloc(dev, sizeof(*cspmu), GFP_KERNEL);
>>     if (!cspmu)
>>         return NULL;
>>
>>     cspmu->dev = dev;
>> -    cspmu->apmt_node = apmt_node;
>> -
>>     platform_set_drvdata(pdev, cspmu);
>>
>> +    apmt_node = dev_get_platdata(dev);
> 
> Ditto
> 
>> +    cspmu->has_atomic_dword = apmt_node->flags & ACPI_APMT_FLAGS_ATOMIC;
>> +
>>     return cspmu;
>> }
> 
> ...
> 
>> @@ -1047,19 +1029,14 @@ static int arm_cspmu_request_irq(struct 
>> arm_cspmu *cspmu)
>>     int irq, ret;
>>     struct device *dev;
>>     struct platform_device *pdev;
>> -    struct acpi_apmt_node *apmt_node;
>>
>>     dev = cspmu->dev;
>>     pdev = to_platform_device(dev);
>> -    apmt_node = cspmu->apmt_node;
>>
>>     /* Skip IRQ request if the PMU does not support overflow 
>> interrupt. */
>> -    if (apmt_node->ovflw_irq == 0)
>> -        return 0;
>> -
>> -    irq = platform_get_irq(pdev, 0);
>> +    irq = platform_get_irq_optional(pdev, 0);
>>     if (irq < 0)
>> -        return irq;
>> +        return irq == -ENXIO ? 0 : irq;
>>
>>     ret = devm_request_irq(dev, irq, arm_cspmu_handle_irq,
>>                    IRQF_NOBALANCING | IRQF_NO_THREAD, dev_name(dev),
>> @@ -1109,7 +1086,7 @@ static int arm_cspmu_acpi_get_cpus(struct 
>> arm_cspmu *cspmu)
>>     int cpu;
>>
>>     dev = cspmu->pmu.dev;
> 
> You didn't touch this one but shouldn't this be
> 
>      dev = cspmu->dev;

Good catch - attributing the error message to the wrong device doesn't 
matter too much currently, but this change does then need it to be 
right. Will fix that too.

Thanks!
Robin.

> 
>> -    apmt_node = cspmu->apmt_node;
>> +    apmt_node = dev_get_platdata(dev);
> 
> Ditto
> 
>>     affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
> 
> 
> Otherwise the patch looks good to me.
> 
> Cheers, Ilkka
