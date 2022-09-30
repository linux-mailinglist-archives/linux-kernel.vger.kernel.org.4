Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE695F04DE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiI3GhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiI3GhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:37:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B3710F71B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 23:37:09 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mf0ls3Q74zVhk6;
        Fri, 30 Sep 2022 14:32:57 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 14:37:05 +0800
Message-ID: <2afc52b8-3e4d-c61e-95ed-885520b95a17@huawei.com>
Date:   Fri, 30 Sep 2022 14:37:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] powerpc/mpic_msgr: fix cast removes address space
 of expression warnings
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "Julia.Lawall@inria.fr" <Julia.Lawall@inria.fr>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220901085416.204378-1-ruanjinjie@huawei.com>
 <4d3b7f83-498e-deb2-ce2a-c17d4b22a078@csgroup.eu>
Content-Language: en-US
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <4d3b7f83-498e-deb2-ce2a-c17d4b22a078@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/30 14:09, Christophe Leroy wrote:
> 
> 
> Le 01/09/2022 à 10:54, ruanjinjie a écrit :
>> [Vous ne recevez pas souvent de courriers de ruanjinjie@huawei.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>
>> When build Linux kernel, encounter the following warnings:
>>
>> ./arch/powerpc/sysdev/mpic_msgr.c:230:38: warning: cast removes address space '__iomem' of expression
>> ./arch/powerpc/sysdev/mpic_msgr.c:230:27: warning: incorrect type in assignment (different address spaces)
>>
>> The data type of msgr->mer and msgr->base are 'u32 __iomem *', but
>> converted to 'u32 *' and 'u8 *' directly and cause above warnings, now
>> recover their data types to fix these warnings.
> 
> I think the best would be to change MPIC_MSGR_MER_OFFSET to 0x40 and 
> then drop the casts completely:
> 
> 	msgr->mer = msgr->base + MPIC_MSGR_MER_OFFSET;
> 
I think this is good to solve the warning.

>>
>> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
>> ---
>>   arch/powerpc/sysdev/mpic_msgr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
>> index 698fefaaa6dd..cbb0d24f15ba 100644
>> --- a/arch/powerpc/sysdev/mpic_msgr.c
>> +++ b/arch/powerpc/sysdev/mpic_msgr.c
>> @@ -227,7 +227,7 @@ static int mpic_msgr_probe(struct platform_device *dev)
>>
>>                  reg_number = block_number * MPIC_MSGR_REGISTERS_PER_BLOCK + i;
>>                  msgr->base = msgr_block_addr + i * MPIC_MSGR_STRIDE;
>> -               msgr->mer = (u32 *)((u8 *)msgr->base + MPIC_MSGR_MER_OFFSET);
>> +               msgr->mer = (u32 __iomem *)((u8 __iomem *)msgr->base + MPIC_MSGR_MER_OFFSET);
>>                  msgr->in_use = MSGR_FREE;
>>                  msgr->num = i;
>>                  raw_spin_lock_init(&msgr->lock);
>> --
>> 2.25.1
