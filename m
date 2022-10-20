Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B3D606558
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiJTQEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiJTQEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:04:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7AF01BC16C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:03:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 381E823A;
        Thu, 20 Oct 2022 09:03:56 -0700 (PDT)
Received: from [10.57.68.12] (unknown [10.57.68.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA8A53F792;
        Thu, 20 Oct 2022 09:03:48 -0700 (PDT)
Message-ID: <07c9964b-e074-fe76-8ee1-9b0bdf5d364f@arm.com>
Date:   Thu, 20 Oct 2022 17:03:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [Question] Question about supporting sysreg only CoreSight
 ETMv4.4 on ACPI machines
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     yehaiyang2@hisilicon.com, wanghuiqiang <wanghuiqiang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, mark.rutland@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>
References: <6e85db13-a65f-d4c6-1b6b-660a94cb7060@huawei.com>
 <9fc5ab20-c7f0-a917-4938-403e3661109f@arm.com>
 <5c4d3a7f-0dcb-c0e9-0192-2a53d0338078@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <5c4d3a7f-0dcb-c0e9-0192-2a53d0338078@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 19/10/2022 03:04, Xiongfeng Wang wrote:
> Hi, Suzuki, Anshuman
> 
> On 2022/10/18 17:18, Suzuki Kuruppassery Poulose wrote:
>> Hi,
>>
>> Cc: Anshuman
>>
>> On 18/10/2022 03:04, Xiongfeng Wang wrote:
>>> Hi, Suzuki
>>>
>>>      We are testing CoreSight ETMv4.4 and TRBE recently. ETMv4.4 obsoletes memory
>>> mapped access to ETM and mandates the system registers. The following commit add
>>> driver for sysreg only devices, but it only support device tree.
>>>     commit 5214b563588e8414193bd7a174c52350256942a6
>>>     coresight: etm4x: Add support for sysreg only devices
>>>
>>> ACPI machine can use 'ARMHC500' to report a ETM4x device. But the corresponding
>>> driver is etm4x_amba_driver. It needs memory resouces and doesn't support sysreg
>>> only device.
>>
>> That is true. Unfortunately, supporting this requires us to move away from the
>> AMBA framework (at least) for ETM4x devices. This is currently
>> developed by Anshuman. We can share it as soon as this is complete.
> 
> Thanks a lot. Really appreciate !
> By the way, do we have plan to add ACPI support for TRBE driver? ACPI 6.5 add a

Yes, this is again in our pipeline. But, without the ETE support, TRBE
is literally unusable. So, this will follow the ETE/ETMv4 sysreg ACPI
support.


> field 'TRBE Interrupt' in GICC Structure. In the beginning, I plan to add a
> platform device when got this IRQ, just like what SPE does in the following commit
>    commit d24a0c7099b32b6981d7f126c45348e381718350
>    arm_pmu: acpi: spe: Add initial MADT/SPE probing



> But it seems that TRBE still needs _DSD method to report the links(input port
> and output port). Do you have some other advices? Thanks a lot.

TRBE doesn't need to specify the input/output ports. It is a per-CPU
sink and the TRBE driver registers it as such for each CPU that it
probes.

Suzuki

