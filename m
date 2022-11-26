Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD7B639585
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 11:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKZKqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 05:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiKZKqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 05:46:15 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F2E14D38
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 02:46:12 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NK7fz2yCFzHw6Z;
        Sat, 26 Nov 2022 18:45:31 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 18:46:10 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 18:46:10 +0800
Subject: Re: [PATCH] kernfs: fix potential null-ptr-deref in
 kernfs_path_from_node_locked()
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20221123020419.1867-1-thunder.leizhen@huawei.com>
 <Y35Qgw4Q8XYD5Did@slm.duckdns.org>
 <ba083b44-93d5-37c4-380c-8e0249b2333c@huawei.com>
 <ba46adff-3604-9ccf-b1c5-83411f6652d9@huawei.com>
 <55041efe-7443-d576-287b-49d1221fced2@huawei.com>
 <164f759d-23b8-0a68-e68e-2f0a46318e94@huawei.com>
Message-ID: <06b68b24-63f3-79d2-2d1e-d61516a84bfb@huawei.com>
Date:   Sat, 26 Nov 2022 18:46:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <164f759d-23b8-0a68-e68e-2f0a46318e94@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/26 17:49, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/11/24 10:52, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2022/11/24 10:28, Leizhen (ThunderTown) wrote:
>>>
>>>
>>> On 2022/11/24 10:24, Leizhen (ThunderTown) wrote:
>>>>
>>>>
>>>> On 2022/11/24 0:55, Tejun Heo wrote:
>>>>> On Wed, Nov 23, 2022 at 10:04:19AM +0800, Zhen Lei wrote:
>>>>>> Ensure that the 'buf' is not empty before strlcpy() uses it.
>>>>>>
>>>>>> Commit bbe70e4e4211 ("fs: kernfs: Fix possible null-pointer dereferences
>>>>>> in kernfs_path_from_node_locked()") first noticed this, but it didn't
>>>>>> fix it completely.
>>>>>>
>>>>>> Fixes: 9f6df573a404 ("kernfs: Add API to generate relative kernfs path")
>>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>>
>>>>> I think the right thing to do is removing that if. It makes no sense to call
>>>>> that function with NULL buf and the fact that nobody reported crashes on
>>>>> NULL buf indicates that we in fact never do.
> 
> kernfs_path_from_node
>     -->kernfs_path_from_node_locked
> 
> EXPORT_SYMBOL_GPL(kernfs_path_from_node)
> 
> I've rethought it. The export APIs need to do null pointer check, right?

Sorry，I looked at some of the other functions and they didn't check either.

> 
>>>>
>>>> OK.
>>>>
>>>> How about I remove "buf[0] = '\0';" too? It seems to be a useless operation.
>>>> When 'kn_from' and 'kn_to' have a common ancestor, there must be a path from
>>>> 'kn_from' to 'kn_to', and strlcpy() always fills in the terminator correctly,
>>>> even if the buf is too small to save the first path node.
>>>
>>> Sorry, I misanalyzed. The length used by "len < buflen ? buflen - len : 0" may
>>> be zero.
>>
>> Ah, my brain is unstable today. The initial value of len is 0. So "buf[0] = '\0';"
>> can still be safely removed.
>>
>>>
>>>>
>>>> static void test(void)
>>>> {
>>>>         char buf[4];
>>>>         int i, n, buflen;
>>>>
>>>>         buflen = 1;
>>>>         n = strlcpy(buf, "string", buflen);
>>>>         for (i = 0; i < buflen; i++)
>>>>                 printk("%d: %02x\n", i, buf[i]);
>>>>         printk("n=%d\n\n", n);
>>>>
>>>>         buflen = sizeof(buf);
>>>>         n = strlcpy(buf, "string", buflen);
>>>>         for (i = 0; i < buflen; i++)
>>>>                 printk("%d: %02x\n", i, buf[i]);
>>>>         printk("n=%d\n", n);
>>>> }
>>>>
>>>> Output:
>>>> [   33.691497] 0: 00
>>>> [   33.691569] n=6
>>>>
>>>> [   33.691595] 0: 73
>>>> [   33.691622] 1: 74
>>>> [   33.691630] 2: 72
>>>> [   33.691637] 3: 00
>>>> [   33.691650] n=6
>>>>
>>>>>
>>>>> Thanks.
>>>>>
>>>>
>>>
>>
> 

-- 
Regards,
  Zhen Lei
