Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A391E612E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 01:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJaAjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 20:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJaAjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 20:39:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C9B9FC9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 17:39:08 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N0vQy2NS1zHvSg
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:38:50 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 08:39:07 +0800
Received: from [10.67.111.195] (10.67.111.195) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 08:39:06 +0800
Message-ID: <d20431d9-93fc-e810-5734-ed49925bca33@huawei.com>
Date:   Mon, 31 Oct 2022 08:39:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 -next] genirq: Separate warning messages of enable of
 suspended irq
From:   chenlifu <chenlifu@huawei.com>
To:     <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>
References: <20220728102912.474772-1-chenlifu@huawei.com>
 <05645307-3daa-a36f-fa86-34a7e2e8ae26@huawei.com>
In-Reply-To: <05645307-3daa-a36f-fa86-34a7e2e8ae26@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.195]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

在 2022/9/20 14:42, chenlifu 写道:
> 在 2022/7/28 18:29, Chen Lifu 写道:
>> Both unbalanced enable for irq and enable of suspended irq
>> print same warning messages, such as:
>> ......
>> [20220314100142]------------[ cut here ]------------
>> [20220314100142]WARNING: CPU: 1 PID: 10332 at kernel/irq/manage.c:723 
>> __enable_irq+0x58/0xa4
>> [20220314100142]Unbalanced enable for IRQ 38
>> ......
>>
>> It's confusing. Separate the warning messages to make it clear.
>> No functional changes.
>>
>> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
>> ---
>>   kernel/irq/manage.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index 40fe7806cc8c..bf4f5f63b2d3 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -775,17 +775,19 @@ void disable_nmi_nosync(unsigned int irq)
>>   void __enable_irq(struct irq_desc *desc)
>>   {
>>       switch (desc->depth) {
>>       case 0:
>> - err_out:
>>           WARN(1, KERN_WARNING "Unbalanced enable for IRQ %d\n",
>>                irq_desc_get_irq(desc));
>>           break;
>>       case 1: {
>> -        if (desc->istate & IRQS_SUSPENDED)
>> -            goto err_out;
>> +        if (desc->istate & IRQS_SUSPENDED) {
>> +            WARN(1, KERN_WARNING "Enable of suspended IRQ %d\n",
>> +                 irq_desc_get_irq(desc));
>> +            break;
>> +        }
>>           /* Prevent probing on this irq: */
>>           irq_settings_set_noprobe(desc);
>>           /*
>>            * Call irq_startup() not irq_enable() here because the
>>            * interrupt might be marked NOAUTOEN. So irq_startup()
>>
> 
> Friendly ping ...
> 
> .

Friendly ping ...
