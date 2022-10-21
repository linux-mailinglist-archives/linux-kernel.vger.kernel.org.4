Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E8A6076B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJUMJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJUMJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:09:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE38186FD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:09:11 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mv36Z431NzmVC9;
        Fri, 21 Oct 2022 20:04:22 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 20:08:37 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 20:08:36 +0800
Message-ID: <ed7c4027-8e15-245f-cdda-0551063761e7@huawei.com>
Date:   Fri, 21 Oct 2022 20:08:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] riscv: fix race when vmap stack overflow
To:     Andrea Parri <parri.andrea@gmail.com>, Guo Ren <guoren@kernel.org>
CC:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20221019154727.2395-1-jszhang@kernel.org>
 <Y1HZFcBo21SQzXVj@andrea>
 <CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com>
 <Y1JaE/ot91Z0KXuC@andrea>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Y1JaE/ot91Z0KXuC@andrea>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/21 16:36, Andrea Parri 写道:
>>>> +     atomic_set_release(&spin_shadow_stack, 0);
>>>
>>> Have not really looked the details: should there be a matching acquire?
>>
>> I use atomic_set_release here, because I need earlier memory
>> operations finished to make sure the sp is ready then set the spin
>> flag.
>>
>> The following memory operations order is not important, because we
>> just care about sp value.
>>
>> Also, we use relax amoswap before, because sp has naturelly
>> dependency. But giving them RCsc is okay here, because we don't care
>> about performance here.
> 
> Thanks for the clarification.
> 
> I'm not really suggesting to add unneeded synchronization, even more
> so in local/private constructs as in this case.  It just felt odd to
> see the release without a pairing acquire, so I asked.  ;-)
> 
> Thanks,
>    Andrea
> 
> 
>> eg:
>>   handle_kernel_stack_overflow:
>> +1:     la sp, spin_shadow_stack
>> +       amoswap.w.aqrl sp, sp, (sp)
>> +       bnez sp, 1b
>> +
>> ....
>> +     smp_store_release(&spin_shadow_stack, 0);
>> +     smp_mb();
> 

Hi Andrea, Zhang, Guo:
	Consider this implementation:)

	smp_store_mb(&spin_shadow_stack, 0);

Thanks,
Tong.
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> .
