Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD01607A58
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiJUPSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJUPSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:18:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5EA23E94
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:17:59 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mv7Lr1JgvzJn3N;
        Fri, 21 Oct 2022 23:15:16 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 23:17:54 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 23:17:53 +0800
Message-ID: <41608bda-3c20-060e-a9b4-afa2fe615b41@huawei.com>
Date:   Fri, 21 Oct 2022 23:17:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] riscv: fix race when vmap stack overflow
To:     Guo Ren <guoren@kernel.org>
CC:     Andrea Parri <parri.andrea@gmail.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20221019154727.2395-1-jszhang@kernel.org>
 <Y1HZFcBo21SQzXVj@andrea>
 <CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com>
 <Y1JaE/ot91Z0KXuC@andrea> <ed7c4027-8e15-245f-cdda-0551063761e7@huawei.com>
 <Y1KdKATQx16Xl/iL@andrea> <f1eb4756-e1e1-1f12-e767-a69a891786d6@huawei.com>
 <CAJF2gTRdtcpccL5W48O8VEXCMvxNAyyrKJzhwNJkc8js+H2iJg@mail.gmail.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <CAJF2gTRdtcpccL5W48O8VEXCMvxNAyyrKJzhwNJkc8js+H2iJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/21 22:41, Guo Ren 写道:
> On Fri, Oct 21, 2022 at 9:46 PM Tong Tiangen <tongtiangen@huawei.com> wrote:
>>
>>
>>
>> 在 2022/10/21 21:22, Andrea Parri 写道:
>>> Hi Tong,
>>>
>>>>>> I use atomic_set_release here, because I need earlier memory
>>>>>> operations finished to make sure the sp is ready then set the spin
>>>>>> flag.
>>>
>>>>       Consider this implementation:)
>>>>
>>>>       smp_store_mb(&spin_shadow_stack, 0);
>>>
>>> smp_store_mb() has "WRITE_ONCE(); smp_mb()" semantics; so it doesn't
>>> guarantee that the store to spin_shadow_stack is ordered after program
>>> -order earlier memory accesses.
>>>
>>>     Andrea
>>> .
>>
>> Hi Andrea:
>>
>> IIUC, the earlier memory access amoswap.aqrl, here .aqrl guarantee it.
>> But anyway, consider we don't care about performance here, using
>> smp_store_release()(add barrier()) surely right.
> We use smp_store_release() is for:
>          //load per-cpu overflow stack
>          REG_L sp, -8(sp)

Oh, missing that, you're right. This guarantee the spin flag is set 
after the sp is used.

> 
> Not amoswap.
> 
> Actually, amoswap.aqrl guarantees nothing because all instructions
> depend on the sp register.
right.

Thanks,
Tong.

> 
>>
>> Thanks,
>> Tong.
> 
> 
> 
