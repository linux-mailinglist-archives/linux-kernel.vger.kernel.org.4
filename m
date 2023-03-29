Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A00B6CD925
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjC2MIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjC2MIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:08:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CE6C19A9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:08:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C3191FB;
        Wed, 29 Mar 2023 05:09:30 -0700 (PDT)
Received: from [10.57.56.187] (unknown [10.57.56.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E48F13F6C4;
        Wed, 29 Mar 2023 05:08:44 -0700 (PDT)
Message-ID: <fddb619c-ab2a-da4f-6882-8c2382cef688@arm.com>
Date:   Wed, 29 Mar 2023 13:08:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] perf/arm-cmn: Fix and refactor device mapping resource
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        ilkka@os.amperecomputing.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1676535470-120560-1-git-send-email-renyu.zj@linux.alibaba.com>
 <20230327140536.GB31752@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230327140536.GB31752@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-27 15:05, Will Deacon wrote:
> [+Robin and Ilkka, as they contribute most to this driver]
> 
> On Thu, Feb 16, 2023 at 04:17:50PM +0800, Jing Zhang wrote:
>> The devm_platform_ioremap_resource() won't let the platform device
>> claim resource when the ACPI companion device has already claimed it.
>> If CMN-ANY except CMN600 is ACPI companion device, it will return
>> -EBUSY in devm_platform_ioremap_resource(), and the driver cannot be
>> successfully installed.
>>
>> So let ACPI companion device call arm_cmn_acpi_probe and not claim
>> resource again. In addition, the arm_cmn_acpi_probe() and
>> arm_cmn_of_probe() functions are refactored to make them compatible
>> with both CMN600 and CMN-ANY.
>>
>> Fixes: 61ec1d875812 ("perf/arm-cmn: Demarcate CMN-600 specifics")
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> ---
>>   drivers/perf/arm-cmn.c | 57 ++++++++++++++++++++++++++++++++------------------
>>   1 file changed, 37 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index 1deb61b..beb3b37 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -2206,7 +2206,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>>   	return 0;
>>   }
>>   
>> -static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
>> +static int arm_cmn_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
>>   {
>>   	struct resource *cfg, *root;
>>   
>> @@ -2214,12 +2214,21 @@ static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *c
>>   	if (!cfg)
>>   		return -EINVAL;
>>   
>> -	root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> -	if (!root)
>> -		return -EINVAL;
>> +	/* If ACPI defines more than one resource, such as cmn-600, then there may be
>> +	 * a deviation between ROOTNODEBASE and PERIPHBASE, and ROOTNODEBASE can
>> +	 * be obtained from the second resource. Otherwise, it can be considered that
>> +	 * ROOT NODE BASE is PERIPHBASE. This is compatible with cmn-600 and cmn-any.
>> +	 */
>> +	if (pdev->num_resources > 1) {
>> +		root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +		if (!root)
>> +			return -EINVAL;
>>   
>> -	if (!resource_contains(cfg, root))
>> -		swap(cfg, root);
>> +		if (!resource_contains(cfg, root))
>> +			swap(cfg, root);
>> +	} else {
>> +		root = cfg;
>> +	}
>>   	/*
>>   	 * Note that devm_ioremap_resource() is dumb and won't let the platform
>>   	 * device claim cfg when the ACPI companion device has already claimed
>> @@ -2227,17 +2236,30 @@ static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *c
>>   	 * appropriate name, we don't really need to do it again here anyway.
>>   	 */
>>   	cmn->base = devm_ioremap(cmn->dev, cfg->start, resource_size(cfg));
>> -	if (!cmn->base)
>> -		return -ENOMEM;
>> +	if (IS_ERR(cmn->base))
>> +		return PTR_ERR(cmn->base);
>>   
>>   	return root->start - cfg->start;
>>   }
>>   
>> -static int arm_cmn600_of_probe(struct device_node *np)
>> +static int arm_cmn_of_probe(struct platform_device *pdev, struct arm_cmn *cmn)
>>   {
>>   	u32 rootnode;
>> +	int ret;
>> +
>> +	cmn->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(cmn->base))
>> +		return PTR_ERR(cmn->base);
>>   
>> -	return of_property_read_u32(np, "arm,root-node", &rootnode) ?: rootnode;
>> +	/* If of_property_read_u32() return EINVAL, it means that device tree has
>> +	 * not define root-node, and root-node will return 0, which is compatible
>> +	 * with cmn-600 and cmn-any.
>> +	 */
>> +	ret = of_property_read_u32(pdev->dev.of_node, "arm,root-node", &rootnode);
>> +	if (ret == -EINVAL)
>> +		return 0;

Also NAK to this because it's plain wrong. CMN-600 should fail to probe 
if the property is missing, because assuming an offset of 0 is not correct.

Thanks,
Robin.

>> +
>> +	return rootnode;
>>   }
>>   
>>   static int arm_cmn_probe(struct platform_device *pdev)
>> @@ -2255,16 +2277,11 @@ static int arm_cmn_probe(struct platform_device *pdev)
>>   	cmn->model = (unsigned long)device_get_match_data(cmn->dev);
>>   	platform_set_drvdata(pdev, cmn);
>>   
>> -	if (cmn->model == CMN600 && has_acpi_companion(cmn->dev)) {
>> -		rootnode = arm_cmn600_acpi_probe(pdev, cmn);
>> -	} else {
>> -		rootnode = 0;
>> -		cmn->base = devm_platform_ioremap_resource(pdev, 0);
>> -		if (IS_ERR(cmn->base))
>> -			return PTR_ERR(cmn->base);
>> -		if (cmn->model == CMN600)
>> -			rootnode = arm_cmn600_of_probe(pdev->dev.of_node);
>> -	}
>> +	if (has_acpi_companion(cmn->dev))
>> +		rootnode = arm_cmn_acpi_probe(pdev, cmn);
>> +	else
>> +		rootnode = arm_cmn_of_probe(pdev, cmn);
>> +
>>   	if (rootnode < 0)
>>   		return rootnode;
>>   
>> -- 
>> 1.8.3.1
>>
