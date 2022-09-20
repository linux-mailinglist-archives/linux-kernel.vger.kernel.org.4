Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFF15BE716
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiITN3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiITN3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:29:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F2A4B497
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:29:00 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MX2M51rYYzMnDn;
        Tue, 20 Sep 2022 21:24:17 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 21:28:58 +0800
Subject: Re: [PATCH] mm/secretmem: remove reduntant return value
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Binyi Han <dantengknight@gmail.com>
References: <20220920012205.246217-1-xiujianfeng@huawei.com>
 <3196b824-bcee-0c44-bfd3-f6cd8a1e6719@redhat.com>
 <c4e99ea3-302d-b173-27f1-92c38ddaca8c@huawei.com>
 <7f1cfee4-c6de-ea59-0aa9-9bd55054fb22@redhat.com>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <0761fca9-b9f0-f3d7-0bf2-e73089db9d84@huawei.com>
Date:   Tue, 20 Sep 2022 21:28:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <7f1cfee4-c6de-ea59-0aa9-9bd55054fb22@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/9/20 21:22, David Hildenbrand 写道:
> On 20.09.22 14:35, xiujianfeng wrote:
>> Hi,
>>
>> 在 2022/9/20 20:10, David Hildenbrand 写道:
>>> On 20.09.22 03:22, Xiu Jianfeng wrote:
>>>> The return value @ret is always 0, so remove it and return 0 directly.
>>>>
>>>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>>>> ---
>>>>    mm/secretmem.c | 6 ++----
>>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/mm/secretmem.c b/mm/secretmem.c
>>>> index 6a44efb673b2..04c3ac9448a1 100644
>>>> --- a/mm/secretmem.c
>>>> +++ b/mm/secretmem.c
>>>> @@ -278,10 +278,8 @@ static struct file_system_type secretmem_fs = {
>>>>    static int __init secretmem_init(void)
>>>>    {
>>>> -    int ret = 0;
>>>> -
>>>>        if (!secretmem_enable)
>>>> -        return ret;
>>>> +        return 0;
>>>>        secretmem_mnt = kern_mount(&secretmem_fs);
>>>>        if (IS_ERR(secretmem_mnt))
>>>
>>> On top of which tree is that?
>>>
>>> 6.0-rc6 has here:
>>>
>>> if (IS_ERR(secretmem_mnt))
>>>       ret = PTR_ERR(secretmem_mnt);
>>>
>> Sorry, it's on linux-next tree, I should have used [PATCH -next]:)
>>
> 
> Maybe this change should be squashed into the patch from Binyi directly:
> 

Looks good to me, thanks.

> 
> commit 4eb5bbde3ccb710d3b85bfb13466612e56393369 (mm/mm-hotfixes-stable)
> Author: Binyi Han <dantengknight@gmail.com>
> Date:   Sun Sep 4 00:46:47 2022 -0700
> 
>     mm: fix dereferencing possible ERR_PTR
>     Smatch checker complains that 'secretmem_mnt' dereferencing possible
>     ERR_PTR().  Let the function return if 'secretmem_mnt' is ERR_PTR, to
>     avoid deferencing it.
>     Link: https://lkml.kernel.org/r/20220904074647.GA64291@cloud-MacBookPro
>     Fixes: 1507f51255c9f ("mm: introduce memfd_secret system call to 
> create "secret" memory areas")
>     Signed-off-by: Binyi Han <dantengknight@gmail.com>
>     Reviewed-by: Andrew Morton <akpm@linux-foudation.org>
>     Cc: Mike Rapoport <rppt@kernel.org>
>     Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>     Cc: Hagen Paul Pfeifer <hagen@jauu.net>
>     Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
>     Cc: <stable@vger.kernel.org>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> 
