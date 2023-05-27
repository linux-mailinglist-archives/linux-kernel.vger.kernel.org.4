Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB07133A2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjE0JWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjE0JWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:22:12 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A619C;
        Sat, 27 May 2023 02:22:06 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QSx5R132Vz18LbG;
        Sat, 27 May 2023 17:17:31 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 17:22:03 +0800
Subject: Re: [PATCH] net: skbuff: fix missing a __noreturn annotation warning
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>
References: <20230527110409.497408-1-linmiaohe@huawei.com>
 <20230527040038.6783-1-kuniyu@amazon.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <251633c6-7cbc-a574-5631-9db43a76683b@huawei.com>
Date:   Sat, 27 May 2023 17:22:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230527040038.6783-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/27 12:00, Kuniyuki Iwashima wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> Date: Sat, 27 May 2023 19:04:09 +0800
>> Add __noreturn annotation to fix the warning:
>>  net/core/skbuff.o: warning: objtool: skb_push+0x3c: skb_panic() is missing a __noreturn annotation
>>  net/core/skbuff.o: warning: objtool: skb_put+0x4e: skb_panic() is missing a __noreturn annotation
> 
> What arch are you using ?
> 
> IIUC, BUG() should have an annotation for objtool, for
> example, __builtin_unreachable() for x86.
> 
> Maybe the arch is missing such an annotation ?
> 
> Also I'm curious why objtool complains about only skb_push(),
> there should be more non-inline functions that has BUG().

I'm not really sure. I was just compiling the kernel using my old gcc (GCC) 7.3.0 and saw this warning.
Maybe this warning is just false positive.

Thanks.

> 
> Thanks,
> Kuniyuki
> 
> 
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  net/core/skbuff.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 6724a84ebb09..12b525aa4783 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -181,8 +181,8 @@ EXPORT_SYMBOL_GPL(drop_reasons_unregister_subsys);
>>   *	Keep out of line to prevent kernel bloat.
>>   *	__builtin_return_address is not used because it is not always reliable.
>>   */
>> -static void skb_panic(struct sk_buff *skb, unsigned int sz, void *addr,
>> -		      const char msg[])
>> +static void __noreturn skb_panic(struct sk_buff *skb, unsigned int sz, void *addr,
>> +				 const char msg[])
>>  {
>>  	pr_emerg("%s: text:%px len:%d put:%d head:%px data:%px tail:%#lx end:%#lx dev:%s\n",
>>  		 msg, addr, skb->len, sz, skb->head, skb->data,
>> -- 
>> 2.27.0
> .
> 

