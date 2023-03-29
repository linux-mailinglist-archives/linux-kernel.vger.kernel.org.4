Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DA96CD88A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjC2LfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjC2LfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:35:01 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C04740E4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:35:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VewpjER_1680089695;
Received: from 30.221.149.47(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VewpjER_1680089695)
          by smtp.aliyun-inc.com;
          Wed, 29 Mar 2023 19:34:57 +0800
Message-ID: <92d5b3e1-e149-e6f2-fc37-5f9834c629ac@linux.alibaba.com>
Date:   Wed, 29 Mar 2023 19:34:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] perf/arm-cmn: Fix and refactor device mapping resource
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        ilkka@os.amperecomputing.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1676535470-120560-1-git-send-email-renyu.zj@linux.alibaba.com>
 <20230327140536.GB31752@willie-the-truck>
 <b90d3b99-a4d2-86f5-be9a-803b33d787b6@arm.com>
 <73eb9a5f-8e30-27b9-369e-053389d83f48@linux.alibaba.com>
 <a418571c-d24d-7a88-148d-07d4b55f5de8@arm.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <a418571c-d24d-7a88-148d-07d4b55f5de8@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/29 下午6:53, Robin Murphy 写道:
> On 2023-03-29 10:48, Jing Zhang wrote:
>>
>>
>> 在 2023/3/27 下午10:27, Robin Murphy 写道:
>>> On 2023-03-27 15:05, Will Deacon wrote:
>>>> [+Robin and Ilkka, as they contribute most to this driver]
>>>>
>>>> On Thu, Feb 16, 2023 at 04:17:50PM +0800, Jing Zhang wrote:
>>>>> The devm_platform_ioremap_resource() won't let the platform device
>>>>> claim resource when the ACPI companion device has already claimed it.
>>>>> If CMN-ANY except CMN600 is ACPI companion device, it will return
>>>>> -EBUSY in devm_platform_ioremap_resource(), and the driver cannot be
>>>>> successfully installed.
>>>>>
>>>>> So let ACPI companion device call arm_cmn_acpi_probe and not claim
>>>>> resource again. In addition, the arm_cmn_acpi_probe() and
>>>>> arm_cmn_of_probe() functions are refactored to make them compatible
>>>>> with both CMN600 and CMN-ANY.
>>>
>>> No, the whole point of CMN-600 probing being a special case is that the ACPI and DT bindings for CMN-600 are special cases. In ACPI, only ARMHC600 has the two nested memory resources; all the other models should only have one memory resource because one is all that is meaningful. See table 16 the document[1] in where the description of ROOTNODEBASE says "This field is specific to the CMN-600 device object."
>>>
>>> Similarly in DT, "arm,root-node" is only required for "arm,cmn-600" - it didn't seem worth overcomplicating the schema to actively disallow it for other models, but that is supposed to be implied by its description as "not relevant for newer CMN/CI products".
>>>
>>> If you're hitting this because you've written your ACPI DSDT incorrectly, it's a sign that you should fix your DSDT.
>>>
>>> Thanks,
>>> Robin.
>>>
>>> [1] https://developer.arm.com/documentation/den0093/latest/
>>>
>>
>> Hi Robin,
>>
>> Yes, I know what you mean, but if a new CMN PMU device design two resources like CMN600, it will fail to load driver.
> 
> Future CMN models won't do that, though. And if some design way down the line does end up wanting multiple memory resources for some other reason, the CMN-600 probing code almost certainly won't be the right thing anyway. Besides, firmware bindings for new models will be defined as necessary when those new models are released, and the driver will be updated as necessary at that point to support them, so this is a non-issue.
> 
>> the specification doesn't explicitly forbid giving two ranges for CMN700
> 
> What do you think "specific to the CMN-600 device object" means, exactly?
> 
>> although the example shows just one.
>> So in our SoC, CMN700 is designed with two resources similar to CMN600,
> 
> Why? Either the second resource is meaningless and the correct answer is to remove it from the DSDT, or you've actually modified the hardware design to move the CFG node somewhere else, in which case what you have is no longer an Arm CMN-700 and thus should not be claiming to be one.
> 
>  and the overlap of resource addresses makes
>> the CMN driver unable to match my CMN700. The error log:
>>
>> [  12.016837] arm-cmn ARMHC700:00: can't request region for resource [mem 0x40000000-0x4fffffff]
>> [  12.028230] arm-cmn: probe of ARMHC700:00 failed with error -16
>> [  12.036832] arm-cmn ARMHC700:01: can't request region for resource [mem 0x40040000000-0x4004fffffff]
>> [  12.051289] arm-cmn: probe of ARMHC700:01 failed with error -16
>>
>> So this patch can compatible devices which has two memory resources and one memory resource, why not do it?
> 
> The driver supports the standard firmware bindings, because if everyone ignored the standard firmware bindings and did their own thing, there could not be a standard driver. If we can tell that firmware hasn't followed the bindings because it's added random extra resources, how can we be sure that *any* of them will actually be the one we're looking for?
> 
> Please follow the standard firmware bindings and do not hack non-standard behaviours into the driver.
> 

Ok, I think I should remove second resource from my ACPI DSDT. Thank you.
