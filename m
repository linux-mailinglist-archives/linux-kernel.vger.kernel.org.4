Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DDD6CD7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjC2KxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjC2KxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:53:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89CA340D3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 03:53:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49C0E1FB;
        Wed, 29 Mar 2023 03:53:55 -0700 (PDT)
Received: from [10.57.56.187] (unknown [10.57.56.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B41E13F73F;
        Wed, 29 Mar 2023 03:53:09 -0700 (PDT)
Message-ID: <a418571c-d24d-7a88-148d-07d4b55f5de8@arm.com>
Date:   Wed, 29 Mar 2023 11:53:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] perf/arm-cmn: Fix and refactor device mapping resource
Content-Language: en-GB
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, ilkka@os.amperecomputing.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1676535470-120560-1-git-send-email-renyu.zj@linux.alibaba.com>
 <20230327140536.GB31752@willie-the-truck>
 <b90d3b99-a4d2-86f5-be9a-803b33d787b6@arm.com>
 <73eb9a5f-8e30-27b9-369e-053389d83f48@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <73eb9a5f-8e30-27b9-369e-053389d83f48@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-29 10:48, Jing Zhang wrote:
> 
> 
> 在 2023/3/27 下午10:27, Robin Murphy 写道:
>> On 2023-03-27 15:05, Will Deacon wrote:
>>> [+Robin and Ilkka, as they contribute most to this driver]
>>>
>>> On Thu, Feb 16, 2023 at 04:17:50PM +0800, Jing Zhang wrote:
>>>> The devm_platform_ioremap_resource() won't let the platform device
>>>> claim resource when the ACPI companion device has already claimed it.
>>>> If CMN-ANY except CMN600 is ACPI companion device, it will return
>>>> -EBUSY in devm_platform_ioremap_resource(), and the driver cannot be
>>>> successfully installed.
>>>>
>>>> So let ACPI companion device call arm_cmn_acpi_probe and not claim
>>>> resource again. In addition, the arm_cmn_acpi_probe() and
>>>> arm_cmn_of_probe() functions are refactored to make them compatible
>>>> with both CMN600 and CMN-ANY.
>>
>> No, the whole point of CMN-600 probing being a special case is that the ACPI and DT bindings for CMN-600 are special cases. In ACPI, only ARMHC600 has the two nested memory resources; all the other models should only have one memory resource because one is all that is meaningful. See table 16 the document[1] in where the description of ROOTNODEBASE says "This field is specific to the CMN-600 device object."
>>
>> Similarly in DT, "arm,root-node" is only required for "arm,cmn-600" - it didn't seem worth overcomplicating the schema to actively disallow it for other models, but that is supposed to be implied by its description as "not relevant for newer CMN/CI products".
>>
>> If you're hitting this because you've written your ACPI DSDT incorrectly, it's a sign that you should fix your DSDT.
>>
>> Thanks,
>> Robin.
>>
>> [1] https://developer.arm.com/documentation/den0093/latest/
>>
> 
> Hi Robin,
> 
> Yes, I know what you mean, but if a new CMN PMU device design two resources like CMN600, it will fail to load driver.

Future CMN models won't do that, though. And if some design way down the 
line does end up wanting multiple memory resources for some other 
reason, the CMN-600 probing code almost certainly won't be the right 
thing anyway. Besides, firmware bindings for new models will be defined 
as necessary when those new models are released, and the driver will be 
updated as necessary at that point to support them, so this is a non-issue.

> the specification doesn't explicitly forbid giving two ranges for CMN700

What do you think "specific to the CMN-600 device object" means, exactly?

> although the example shows just one.
> So in our SoC, CMN700 is designed with two resources similar to CMN600,

Why? Either the second resource is meaningless and the correct answer is 
to remove it from the DSDT, or you've actually modified the hardware 
design to move the CFG node somewhere else, in which case what you have 
is no longer an Arm CMN-700 and thus should not be claiming to be one.

  and the overlap of resource addresses makes
> the CMN driver unable to match my CMN700. The error log:
> 
> [  12.016837] arm-cmn ARMHC700:00: can't request region for resource [mem 0x40000000-0x4fffffff]
> [  12.028230] arm-cmn: probe of ARMHC700:00 failed with error -16
> [  12.036832] arm-cmn ARMHC700:01: can't request region for resource [mem 0x40040000000-0x4004fffffff]
> [  12.051289] arm-cmn: probe of ARMHC700:01 failed with error -16
> 
> So this patch can compatible devices which has two memory resources and one memory resource, why not do it?

The driver supports the standard firmware bindings, because if everyone 
ignored the standard firmware bindings and did their own thing, there 
could not be a standard driver. If we can tell that firmware hasn't 
followed the bindings because it's added random extra resources, how can 
we be sure that *any* of them will actually be the one we're looking for?

Please follow the standard firmware bindings and do not hack 
non-standard behaviours into the driver.

Thanks,
Robin.

> I  resend this patch before and add more information about it. This patch still needs to be perfected,
> I will improve it in the next version.
> Link: https://lore.kernel.org/all/1679587838-80000-1-git-send-email-renyu.zj@linux.alibaba.com/
> 
> Thanks,
> Jing
> 
> 
>>>> Fixes: 61ec1d875812 ("perf/arm-cmn: Demarcate CMN-600 specifics")
>>>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>>>> ---
>>>>    drivers/perf/arm-cmn.c | 57 ++++++++++++++++++++++++++++++++------------------
>>>>    1 file changed, 37 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>>>> index 1deb61b..beb3b37 100644
>>>> --- a/drivers/perf/arm-cmn.c
>>>> +++ b/drivers/perf/arm-cmn.c
>>>> @@ -2206,7 +2206,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>>>>        return 0;
>>>>    }
>>>>    -static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
>>>> +static int arm_cmn_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
>>>>    {
>>>>        struct resource *cfg, *root;
>>>>    @@ -2214,12 +2214,21 @@ static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *c
>>>>        if (!cfg)
>>>>            return -EINVAL;
>>>>    -    root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>>> -    if (!root)
>>>> -        return -EINVAL;
>>>> +    /* If ACPI defines more than one resource, such as cmn-600, then there may be
>>>> +     * a deviation between ROOTNODEBASE and PERIPHBASE, and ROOTNODEBASE can
>>>> +     * be obtained from the second resource. Otherwise, it can be considered that
>>>> +     * ROOT NODE BASE is PERIPHBASE. This is compatible with cmn-600 and cmn-any.
>>>> +     */
>>>> +    if (pdev->num_resources > 1) {
>>>> +        root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>>> +        if (!root)
>>>> +            return -EINVAL;
>>>>    -    if (!resource_contains(cfg, root))
>>>> -        swap(cfg, root);
>>>> +        if (!resource_contains(cfg, root))
>>>> +            swap(cfg, root);
>>>> +    } else {
>>>> +        root = cfg;
>>>> +    }
>>>>        /*
>>>>         * Note that devm_ioremap_resource() is dumb and won't let the platform
>>>>         * device claim cfg when the ACPI companion device has already claimed
>>>> @@ -2227,17 +2236,30 @@ static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *c
>>>>         * appropriate name, we don't really need to do it again here anyway.
>>>>         */
>>>>        cmn->base = devm_ioremap(cmn->dev, cfg->start, resource_size(cfg));
>>>> -    if (!cmn->base)
>>>> -        return -ENOMEM;
>>>> +    if (IS_ERR(cmn->base))
>>>> +        return PTR_ERR(cmn->base);
>>>>          return root->start - cfg->start;
>>>>    }
>>>>    -static int arm_cmn600_of_probe(struct device_node *np)
>>>> +static int arm_cmn_of_probe(struct platform_device *pdev, struct arm_cmn *cmn)
>>>>    {
>>>>        u32 rootnode;
>>>> +    int ret;
>>>> +
>>>> +    cmn->base = devm_platform_ioremap_resource(pdev, 0);
>>>> +    if (IS_ERR(cmn->base))
>>>> +        return PTR_ERR(cmn->base);
>>>>    -    return of_property_read_u32(np, "arm,root-node", &rootnode) ?: rootnode;
>>>> +    /* If of_property_read_u32() return EINVAL, it means that device tree has
>>>> +     * not define root-node, and root-node will return 0, which is compatible
>>>> +     * with cmn-600 and cmn-any.
>>>> +     */
>>>> +    ret = of_property_read_u32(pdev->dev.of_node, "arm,root-node", &rootnode);
>>>> +    if (ret == -EINVAL)
>>>> +        return 0;
>>>> +
>>>> +    return rootnode;
>>>>    }
>>>>      static int arm_cmn_probe(struct platform_device *pdev)
>>>> @@ -2255,16 +2277,11 @@ static int arm_cmn_probe(struct platform_device *pdev)
>>>>        cmn->model = (unsigned long)device_get_match_data(cmn->dev);
>>>>        platform_set_drvdata(pdev, cmn);
>>>>    -    if (cmn->model == CMN600 && has_acpi_companion(cmn->dev)) {
>>>> -        rootnode = arm_cmn600_acpi_probe(pdev, cmn);
>>>> -    } else {
>>>> -        rootnode = 0;
>>>> -        cmn->base = devm_platform_ioremap_resource(pdev, 0);
>>>> -        if (IS_ERR(cmn->base))
>>>> -            return PTR_ERR(cmn->base);
>>>> -        if (cmn->model == CMN600)
>>>> -            rootnode = arm_cmn600_of_probe(pdev->dev.of_node);
>>>> -    }
>>>> +    if (has_acpi_companion(cmn->dev))
>>>> +        rootnode = arm_cmn_acpi_probe(pdev, cmn);
>>>> +    else
>>>> +        rootnode = arm_cmn_of_probe(pdev, cmn);
>>>> +
>>>>        if (rootnode < 0)
>>>>            return rootnode;
>>>>    --
>>>> 1.8.3.1
>>>>
