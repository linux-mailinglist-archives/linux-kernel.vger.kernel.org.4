Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23FB720D89
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 05:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjFCDJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 23:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjFCDJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 23:09:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDD3BD;
        Fri,  2 Jun 2023 20:09:28 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QY4bB1QYrzTl19;
        Sat,  3 Jun 2023 11:09:10 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 3 Jun 2023 11:09:24 +0800
Subject: Re: [PATCH] net: skbuff: fix missing a __noreturn annotation warning
To:     Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20230527110409.497408-1-linmiaohe@huawei.com>
 <20230527040038.6783-1-kuniyu@amazon.com>
 <0ab4f3ea2bd97c7067ed332c0128829f4a7ea596.camel@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <89ec1a82-7f1d-21f9-4ece-e321b261e9a5@huawei.com>
Date:   Sat, 3 Jun 2023 11:09:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0ab4f3ea2bd97c7067ed332c0128829f4a7ea596.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2023/5/30 18:28, Paolo Abeni wrote:
> On Fri, 2023-05-26 at 21:00 -0700, Kuniyuki Iwashima wrote:
>> From: Miaohe Lin <linmiaohe@huawei.com>
>> Date: Sat, 27 May 2023 19:04:09 +0800
>>> Add __noreturn annotation to fix the warning:
>>>  net/core/skbuff.o: warning: objtool: skb_push+0x3c: skb_panic() is missing a __noreturn annotation
>>>  net/core/skbuff.o: warning: objtool: skb_put+0x4e: skb_panic() is missing a __noreturn annotation
>>
>> What arch are you using ?
>>
>> IIUC, BUG() should have an annotation for objtool, for
>> example, __builtin_unreachable() for x86.
>>
>> Maybe the arch is missing such an annotation ?
>>
>> Also I'm curious why objtool complains about only skb_push(),
>> there should be more non-inline functions that has BUG().
> 
> AFAICS, the BUG() macro implementation should already carry the
> __noreturn annotation, via panic() or other arch-specific way.
> 
> This looks like the old toolchain not being able to
> successfully/correctly propagate the annotation???

I tend to agree with you. Will drop it. Thanks for your comment.

> 
> I think we can drop this patch.
> 
> Cheers,
> 
> Paolo
> 
> .
> 

