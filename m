Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E316037DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJSCFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJSCFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:05:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3414A4CA1E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 19:04:55 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MsYp362NLzVhvP;
        Wed, 19 Oct 2022 09:59:55 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 10:04:32 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 10:04:31 +0800
Subject: Re: [Question] Question about supporting sysreg only CoreSight
 ETMv4.4 on ACPI machines
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
CC:     <yehaiyang2@hisilicon.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>
References: <6e85db13-a65f-d4c6-1b6b-660a94cb7060@huawei.com>
 <9fc5ab20-c7f0-a917-4938-403e3661109f@arm.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <5c4d3a7f-0dcb-c0e9-0192-2a53d0338078@huawei.com>
Date:   Wed, 19 Oct 2022 10:04:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9fc5ab20-c7f0-a917-4938-403e3661109f@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Suzuki, Anshuman

On 2022/10/18 17:18, Suzuki Kuruppassery Poulose wrote:
> Hi,
> 
> Cc: Anshuman
> 
> On 18/10/2022 03:04, Xiongfeng Wang wrote:
>> Hi, Suzuki
>>
>>     We are testing CoreSight ETMv4.4 and TRBE recently. ETMv4.4 obsoletes memory
>> mapped access to ETM and mandates the system registers. The following commit add
>> driver for sysreg only devices, but it only support device tree.
>>    commit 5214b563588e8414193bd7a174c52350256942a6
>>    coresight: etm4x: Add support for sysreg only devices
>>
>> ACPI machine can use 'ARMHC500' to report a ETM4x device. But the corresponding
>> driver is etm4x_amba_driver. It needs memory resouces and doesn't support sysreg
>> only device.
> 
> That is true. Unfortunately, supporting this requires us to move away from the
> AMBA framework (at least) for ETM4x devices. This is currently
> developed by Anshuman. We can share it as soon as this is complete.

Thanks a lot. Really appreciate !
By the way, do we have plan to add ACPI support for TRBE driver? ACPI 6.5 add a
field 'TRBE Interrupt' in GICC Structure. In the beginning, I plan to add a
platform device when got this IRQ, just like what SPE does in the following commit
  commit d24a0c7099b32b6981d7f126c45348e381718350
  arm_pmu: acpi: spe: Add initial MADT/SPE probing
But it seems that TRBE still needs _DSD method to report the links(input port
and output port). Do you have some other advices? Thanks a lot.

Thanks
Xiongfeng

> 
> Thanks
> Suzuki
> 
>>
>> Do we have some other way to use CoreSight ETMv4.4 on ACPI machines. Thanks a
>> lot.
>>
>> Thanks,
>> Xiongfeng
> 
> 
> .
