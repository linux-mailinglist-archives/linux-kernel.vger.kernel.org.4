Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE666D6AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbjAQHJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbjAQHJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:09:15 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4CA9016
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:09:13 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nx0ML0N1sznVfn;
        Tue, 17 Jan 2023 15:07:26 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 17 Jan 2023 15:09:08 +0800
Message-ID: <5c83fae3-8eae-6303-4656-8da40a2c12b1@huawei.com>
Date:   Tue, 17 Jan 2023 15:09:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   mawupeng <mawupeng1@huawei.com>
Subject: Re: [PATCH v2 1/4] mm/mlock: return EINVAL if len overflows for
 mlock/munlock
To:     <akpm@linux-foundation.org>
CC:     <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
References: <20230116115813.2956935-1-mawupeng1@huawei.com>
 <20230116115813.2956935-2-mawupeng1@huawei.com>
 <20230116125126.ed715ddf00ff4ffa2952ca29@linux-foundation.org>
Content-Language: en-US
In-Reply-To: <20230116125126.ed715ddf00ff4ffa2952ca29@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/17 4:51, Andrew Morton wrote:
> On Mon, 16 Jan 2023 19:58:10 +0800 Wupeng Ma <mawupeng1@huawei.com> wrote:
> 
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
>> The return value of mlock is zero. But nothing will be locked since the
>> len in do_mlock overflows to zero due to the following code in mlock:
>>
>>   len = PAGE_ALIGN(len + (offset_in_page(start)));
>>
>> The same problem happens in munlock.
>>
>> Add new check and return -EINVAL to fix this overflowing scenarios since
>> they are absolutely wrong.
>>
>> ...
>>
>> --- a/mm/mlock.c
>> +++ b/mm/mlock.c
>> @@ -569,6 +569,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>>  	unsigned long locked;
>>  	unsigned long lock_limit;
>>  	int error = -ENOMEM;
>> +	size_t old_len = len;
> 
> I'm not sure that "old_len" is a good identifier.  It reads to me like
> "the length of the old mlocked region" or something.
> 
> I really don't like it when functions modify the values of the incoming
> argument like this.  It would be better to leave `len' alone and create
> a new_len or something.

Thanks for your reviewing.

You do have a point in saying that.

> 
>>  	start = untagged_addr(start);
>>  
>> @@ -578,6 +579,9 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>>  	len = PAGE_ALIGN(len + (offset_in_page(start)));
>>  	start &= PAGE_MASK;
>>  
>> +	if (old_len != 0 && len == 0)
>> +		return -EINVAL;
> 
> It would be clearer to do this immediately after calculating the new
> value of `len'.  Before going on to play with `start'.
> 
> Can we do something like this?
> 
> --- a/mm/mlock.c~a
> +++ a/mm/mlock.c
> @@ -575,7 +575,12 @@ static __must_check int do_mlock(unsigne
>  	if (!can_do_mlock())
>  		return -EPERM;
>  
> -	len = PAGE_ALIGN(len + (offset_in_page(start)));
> +	if (len) {
> +		len = PAGE_ALIGN(len + (offset_in_page(start)));
> +		if (len == 0)	/* overflow */
> +			return -EINVAL;
> +	}
> +
>  	start &= PAGE_MASK;
>  
>  	lock_limit = rlimit(RLIMIT_MEMLOCK);
> _

It's really more appropriate to check like this, I will use this in the next patchset.

> 
> That depends on how we handle len==0.  afaict, mlock(len==0) will
> presently burn a bunch of cpu cycles (not that we want to optimize this
> case), do nothing then return 0?

We can add and a new check in if len == 0, since the similar check appears in
mbind, set_mempolicy_home_node, msync.

The origin len == 0 check for mlock/munlock can be found in apply_vma_lock_flags,
We can move this check to here to avoid burn a bunch of cpu cycles.

do_mlock
  apply_vma_lock_flags
	end = start + len;
	if (end == start)
	  return 0;

Can we do something like this?

diff --git a/mm/mlock.c b/mm/mlock.c
index 7032f6dd0ce1..50a33abc1a2e 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -478,8 +478,6 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
        end = start + len;
        if (end < start)
                return -EINVAL;
-       if (end == start)
-               return 0;
        vma = mas_walk(&mas);
        if (!vma)
                return -ENOMEM;
@@ -575,7 +573,12 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
        if (!can_do_mlock())
                return -EPERM;
 
+       if (!len)
+               return 0;
        len = PAGE_ALIGN(len + (offset_in_page(start)));
+       if (len == 0)
+               return -EINVAL;
+
        start &= PAGE_MASK;
 
        lock_limit = rlimit(RLIMIT_MEMLOCK);
@@ -632,10 +635,14 @@ SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
 SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
 {
        int ret;
-
        start = untagged_addr(start);
 
+       if (!len)
+               return 0;
        len = PAGE_ALIGN(len + (offset_in_page(start)));
+       if (len == 0)
+               return -EINVAL;
+
        start &= PAGE_MASK;
 
        if (mmap_write_lock_killable(current->mm))

> 
