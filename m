Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5BD6378BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiKXMWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXMWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:22:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06D17442F2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:22:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CE0F23A;
        Thu, 24 Nov 2022 04:22:50 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 513963F73B;
        Thu, 24 Nov 2022 04:22:41 -0800 (PST)
Message-ID: <db88206c-2de3-3309-7671-55fdb2268a81@arm.com>
Date:   Thu, 24 Nov 2022 17:52:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] coresight: trbe: remove cpuhp instance node before remove
 cpuhp state
Content-Language: en-US
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>,
        Yang Shen <shenyang39@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org
References: <20221122090355.23533-1-shenyang39@huawei.com>
 <a7eb525a-3c96-7477-d5eb-7f93a1b49cb8@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <a7eb525a-3c96-7477-d5eb-7f93a1b49cb8@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/22 17:00, Suzuki Kuruppassery Poulose wrote:
> On 22/11/2022 09:03, Yang Shen wrote:
>> cpuhp_state_add_instance() and cpuhp_state_remove_instance() should
>> be used in pairs. Or there will lead to the warn on
>> cpuhp_remove_multi_state() since the cpuhp_step list is not empty.
>>
>> The following is the error log with 'rmmod coresight-trbe':
>> Error: Removing state 215 which has instances left.
>> Call trace:
>>    __cpuhp_remove_state_cpuslocked+0x144/0x160
>>    __cpuhp_remove_state+0xac/0x100
>>    arm_trbe_device_remove+0x2c/0x60 [coresight_trbe]
>>    platform_remove+0x34/0x70
>>    device_remove+0x54/0x90
>>    device_release_driver_internal+0x1e4/0x250
>>    driver_detach+0x5c/0xb0
>>    bus_remove_driver+0x64/0xc0
>>    driver_unregister+0x3c/0x70
>>    platform_driver_unregister+0x20/0x30
>>    arm_trbe_exit+0x1c/0x658 [coresight_trbe]
>>    __arm64_sys_delete_module+0x1ac/0x24c
>>    invoke_syscall+0x50/0x120
>>    el0_svc_common.constprop.0+0x58/0x1a0
>>    do_el0_svc+0x38/0xd0
>>    el0_svc+0x2c/0xc0
>>    el0t_64_sync_handler+0x1ac/0x1b0
>>    el0t_64_sync+0x19c/0x1a0
>>   ---[ end trace 0000000000000000 ]---
>>
>> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
>> Signed-off-by: Yang Shen <shenyang39@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

>> ---
>>   drivers/hwtracing/coresight/coresight-trbe.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index 2b386bb848f8..1fc4fd79a1c6 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -1434,6 +1434,7 @@ static int arm_trbe_probe_cpuhp(struct trbe_drvdata *drvdata)
>>
>>   static void arm_trbe_remove_cpuhp(struct trbe_drvdata *drvdata)
>>   {
>> +    cpuhp_state_remove_instance(drvdata->trbe_online, &drvdata->hotplug_node);
>>       cpuhp_remove_multi_state(drvdata->trbe_online);
>>   }
>>
> 
> Applied to coresight next.
> 
> https://git.kernel.org/coresight/c/5fefef85b0d3

Hi Suzuki,

Could you please add the above tag for the patch. Thank you.

- Anshuman
