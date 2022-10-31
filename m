Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB77612E52
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 01:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJaAiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 20:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaAiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 20:38:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780D395BB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 17:38:15 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N0vJV4n64z15MDP
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:33:14 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 08:38:13 +0800
Received: from [10.67.111.195] (10.67.111.195) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 08:38:13 +0800
Message-ID: <ccef0ae5-d5b2-8f33-0372-4f0687738ecd@huawei.com>
Date:   Mon, 31 Oct 2022 08:38:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next] genirq: Add SPARSE_NR_IRQS Kconfig option
From:   chenlifu <chenlifu@huawei.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
References: <20220930085839.315461-1-chenlifu@huawei.com>
 <dbb07298-a474-f67c-dcd1-64fbf2aae91e@huawei.com>
In-Reply-To: <dbb07298-a474-f67c-dcd1-64fbf2aae91e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.195]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/10/18 9:22, chenlifu 写道:
> 在 2022/9/30 16:58, Chen Lifu 写道:
>> On a large-scale multi-core and NUMA platform, more than 1024 cores and
>> 16 NUMA nodes for example, even if SPASE_IRQ is selected to increase the
>> number of interrupt numbers by 8196 base on NR_IRQS, the interrupt 
>> numbers
>> requirement cannot be met. Therefore, make the number of sparse interrupt
>> numbers configurable.
>>
>> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
>> ---
>>   kernel/irq/Kconfig     | 8 ++++++++
>>   kernel/irq/internals.h | 2 +-
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
>> index db3d174c53d4..b517b820e329 100644
>> --- a/kernel/irq/Kconfig
>> +++ b/kernel/irq/Kconfig
>> @@ -123,10 +123,18 @@ config SPARSE_IRQ
>>         ( Sparse irqs can also be beneficial on NUMA boxes, as they 
>> spread
>>           out the interrupt descriptors in a more NUMA-friendly way. )
>>         If you don't know what to do here, say N.
>> +config SPARSE_NR_IRQS
>> +    int "Number of sparse interrupt numbers"
>> +    depends on SPARSE_IRQ
>> +    default 8196
>> +    help
>> +      This defines the maximum number of interrupt numbers
>> +      that can be dynamically expanded.
>> +
>>   config GENERIC_IRQ_DEBUGFS
>>       bool "Expose irq internals in debugfs"
>>       depends on DEBUG_FS
>>       select GENERIC_IRQ_INJECTION
>>       default n
>> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
>> index f09c60393e55..ab8ac93c60e6 100644
>> --- a/kernel/irq/internals.h
>> +++ b/kernel/irq/internals.h
>> @@ -10,11 +10,11 @@
>>   #include <linux/kernel_stat.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/sched/clock.h>
>>   #ifdef CONFIG_SPARSE_IRQ
>> -# define IRQ_BITMAP_BITS    (NR_IRQS + 8196)
>> +# define IRQ_BITMAP_BITS    (NR_IRQS + CONFIG_SPARSE_NR_IRQS)
>>   #else
>>   # define IRQ_BITMAP_BITS    NR_IRQS
>>   #endif
>>   #define istate core_internal_state__do_not_mess_with_it
> 
> Friendly ping ...

Friendly ping ...
