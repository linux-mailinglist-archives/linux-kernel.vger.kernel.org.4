Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CB871F80F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjFBBgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjFBBgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:36:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA3B1B5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:36:15 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QXQXH4J8JzLmgm;
        Fri,  2 Jun 2023 09:34:23 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 09:36:00 +0800
Message-ID: <c222b26f-4671-85db-497b-7122a596870e@huawei.com>
Date:   Fri, 2 Jun 2023 09:36:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/3] genirq: Use hlist for managing resend handlers
To:     Thomas Gleixner <tglx@linutronix.de>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        Jason Sequeira <jsequeira@nvidia.com>
References: <20230519134902.1495562-1-sdonthineni@nvidia.com>
 <20230519134902.1495562-2-sdonthineni@nvidia.com>
 <6dc6642a-1e7c-f111-1fa2-be54826ecef6@huawei.com> <871qiylsc9.ffs@tglx>
 <56c6dc9a-a5a6-368a-abd4-cace43ceaec0@huawei.com> <87a5xmj9km.ffs@tglx>
From:   "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <87a5xmj9km.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/30 20:19, Thomas Gleixner 写道:
> On Tue, May 30 2023 at 09:59, Chang Liao wrote:
>> 在 2023/5/30 5:51, Thomas Gleixner 写道:
>>>> What is the benefit of using hlist here? If you want to enjoy the
>>>> low latency of querying elements by key, you must define a hlist table
>>>> with a reasonable number of buckets. Otherwise, I don't think the time
>>>> complexity of hlist is better than a regular double-linked list,
>>>> right?
>>>
>>> What's complex about hlist in this case? Please explain.
>>
>> Honestly, it is not about the complexity. Perhaps I do not understand the
>> usage of hlist very deeply. I have searched some codes in the kernel and
>> found that hlist is always used to speed up arbitrary querying, such as
>> searching a registered kprobe by address. Back to this patch, these resend
>> IRQs are organized in a sequence list actually, and traveled one by one to
>> handle. Further, by comparing the difference between hlist_empty, hlist_add_head,
>> hlist_del_init, and their counterparts in list, it looks like a regular linked
>> list is also good enough.
> 
> Sure that works too.
> 
> The main difference between regular linked lists and hlist is that the
> list head of hlist is half the size of a regular double linked list.
> 
> The only downside of hlist is that there is no back link in the list
> head to the tail. Searching for the tail is O(N) while on a double
> linked list it's O(1).
> 
> Nothing in this use case needs to access the tail. So what's your
> problem?

Oh, that is the point, your explanation made it all clear, my problem is solved,
Thanks!

> 
> Thanks,
> 
>         tglx

-- 
BR
Liao, Chang
