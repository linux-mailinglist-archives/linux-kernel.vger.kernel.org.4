Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA506412FA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiLCBUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiLCBUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:20:37 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA0CE464A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 17:20:34 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NPBj70dwHzqSc9;
        Sat,  3 Dec 2022 09:16:27 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 09:20:32 +0800
Subject: Re: [PATCH v2] x86/alternative: fix undefined reference to
 __ibt_endbr_seal[_end]
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
References: <20221011113803.956808-1-linmiaohe@huawei.com>
 <87y1rqow2f.ffs@tglx>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <26329195-584e-afe3-d0c2-4715a48128a6@huawei.com>
Date:   Sat, 3 Dec 2022 09:20:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87y1rqow2f.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/2 19:59, Thomas Gleixner wrote:
> On Tue, Oct 11 2022 at 19:38, Miaohe Lin wrote:
>> Due to the explicit 'noinline' GCC-7.3 is not able to optimize away the
>> argument setup of:
>>
>> 	apply_ibt_endbr(__ibt_endbr_seal, __ibt_enbr_seal_end);
>>
>> even when X86_KERNEL_IBT=n and the function is an empty stub which leads
>> to link errors due to missing __ibt_endbr_seal* symbols like below:
>>
>> ld: arch/x86/kernel/alternative.o: in function
>> `alternative_instructions':
>> alternative.c:(.init.text+0x15d): undefined reference to
>> `__ibt_endbr_seal_end'
>> ld: alternative.c:(.init.text+0x164): undefined reference to
>> `__ibt_endbr_seal'
> 
> This is incomplete because the noinline is only visible within
> alternative.c, but there is another caller in module.c
> 
> This needs an inline stub in the header to be correct.
> 

I see. I think I should update my gcc instead :) Thanks for your reply.

Thanks,
Miaohe Lin


