Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE096076D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJUMXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUMXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:23:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF7476950
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:23:16 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mv3Qq6Z18z15Lxs;
        Fri, 21 Oct 2022 20:18:27 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 20:23:14 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 20:23:12 +0800
Message-ID: <09d1c410-5690-7158-8982-48ceec8ab64e@huawei.com>
Date:   Fri, 21 Oct 2022 20:23:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v2 2/2] riscv: extable: add new extable type
 EX_TYPE_KACCESS_ERR_ZERO support
To:     Palmer Dabbelt <palmer@rivosinc.com>
CC:     <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <Conor.Dooley@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <guohanjun@huawei.com>
References: <mhng-b5608339-68e0-4706-9002-50ba006b4d05@palmer-ri-x1c9>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <mhng-b5608339-68e0-4706-9002-50ba006b4d05@palmer-ri-x1c9>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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



在 2022/9/22 4:25, Palmer Dabbelt 写道:
> On Sat, 27 Aug 2022 03:39:38 PDT (-0700), tongtiangen@huawei.com wrote:
>>
>>
>> 在 2022/8/26 16:16, Andrew Jones 写道:
>>> On Fri, Aug 26, 2022 at 02:44:48PM +0800, Tong Tiangen wrote:
>>>>
>>>>
>>>> 在 2022/8/25 19:06, Andrew Jones 写道:
>>>>> On Mon, Aug 15, 2022 at 03:20:25AM +0000, Tong Tiangen wrote:
>>>>>> Currently, The extable type EX_TYPE_UACCESS_ERR_ZERO is used by
>>>>>> __get/put_kernel_nofault(), but those helpers are not uaccess 
>>>>>> type, so we
>>>>>> add a new extable type EX_TYPE_KACCESS_ERR_ZERO which can be used by
>>>>>> __get/put_kernel_no_fault().
>>>>>>
>>>>>> Only refactor code without any functional changes.
>>>>>
>>>>> This isn't quite true. __get/put_kernel_nofault now sets a different
>>>>> extable type (as the commit message says). But, nothing special seems
>>>>> to be done with that, so there's effectively no functional change. Can
>>>>> you please elaborate on the motivation for this change? Where will the
>>>>> KACCESS type need to be distinguished from the UACCESS type?
>>>>
>>>> The introduction of EX_TYPE_KACCESS_ERR_ZERO does not change any 
>>>> function,
>>>> but makes a correct distinction in the actual type, indicating that 
>>>> there
>>>> are indeed some kaccess entries in extable. I think this 
>>>> optimization is
>>>> more clear and reasonable.
>>>
>>> Well, creating new types, just for new type sake, just bloats code.
>>>
>>>>
>>>> A few weeks ago, I did something similar on arm64[1]. I think this
>>>> optimization can also be used on riscv.
>>>>
>>>> We can do some features that are used on uaccss but not applicable on
>>>> kaccess in the future[2].
>>>>
>>>> [1]
>>>> https://lore.kernel.org/lkml/20220621072638.1273594-2-tongtiangen@huawei.com/ 
>>>>
>>>> [2]https://lore.kernel.org/lkml/20220812070557.1028499-4-tongtiangen@huawei.com/ 
>>>>
>>>>
>>>
>>> This is part of the information, but I had already found this. What's
>>> still missing to me are the riscv patches, or at least a riscv plan, for
>>> actually implementing something which requires kaccess and uaccess to 
>>> have
>>> distinct types.
>>>
>>> Thanks,
>>> drew
>>
>> At present, there is no such plan on riscv, because it is rely on
>> hardware support.
>> I think this patch can be merged as a small code optimization and
>> without any function change.
> 
> Generally we need some use of the code in the upstream kernel to justify 
> its existence.  In this case I don't really see that: it's just another 
> type that's exactly the same as the existing one, having some out of 
> tree code that depends on making these types do something different 
> isn't a sufficient justification.
> .
Hi palmer:

I agree with this point very much，many thanks.

Tong.
