Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B556A6C1058
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCTLJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCTLJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:09:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FC76E97
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:05:37 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PgBhM3wgTzrVMm;
        Mon, 20 Mar 2023 19:04:35 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 19:05:34 +0800
Message-ID: <35ff7e03-2f6f-7a15-aae2-ff1784cd5274@huawei.com>
Date:   Mon, 20 Mar 2023 19:05:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
CC:     <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v4 1/4] mm/mlock: return EINVAL if len overflows for
 mlock/munlock
Content-Language: en-US
To:     <david@redhat.com>, <akpm@linux-foundation.org>
References: <20230320024739.224850-1-mawupeng1@huawei.com>
 <20230320024739.224850-2-mawupeng1@huawei.com>
 <27b9cb5b-0118-f989-80c2-6a143a4232af@redhat.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <27b9cb5b-0118-f989-80c2-6a143a4232af@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/20 18:54, David Hildenbrand wrote:
> On 20.03.23 03:47, Wupeng Ma wrote:
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
>> The return value of mlock is zero. But nothing will be locked since the
>> len in do_mlock overflows to zero due to the following code in mlock:
>>
>>    len = PAGE_ALIGN(len + (offset_in_page(start)));
>>
>> The same problem happens in munlock.
>>
>> Add new check and return -EINVAL to fix this overflowing scenarios since
>> they are absolutely wrong.
> 
> Thinking again, wouldn't we reject mlock(0, ULONG_MAX) now as well?

Thanks for reviewing.

I will test this and resend & reply this.

> 
>>
>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>> ---
>>   mm/mlock.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/mm/mlock.c b/mm/mlock.c
>> index 617469fce96d..eb68476da497 100644
>> --- a/mm/mlock.c
>> +++ b/mm/mlock.c
>> @@ -568,6 +568,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>>       unsigned long locked;
>>       unsigned long lock_limit;
>>       int error = -ENOMEM;
>> +    size_t old_len = len;
>>         start = untagged_addr(start);
>>   @@ -577,6 +578,9 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>>       len = PAGE_ALIGN(len + (offset_in_page(start)));
>>       start &= PAGE_MASK;
>>   +    if (old_len != 0 && len == 0)
> 
> if (old_len && !len)
> 
>> +        return -EINVAL;
>> +
>>       lock_limit = rlimit(RLIMIT_MEMLOCK);
>>       lock_limit >>= PAGE_SHIFT;
>>       locked = len >> PAGE_SHIFT;
>> @@ -631,12 +635,16 @@ SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
>>   SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
>>   {
>>       int ret;
>> +    size_t old_len = len;
>>         start = untagged_addr(start);
>>         len = PAGE_ALIGN(len + (offset_in_page(start)));
>>       start &= PAGE_MASK;
>>   +    if (old_len != 0 && len == 0)
> 
> if (old_len && !len)

Sorry for wasting your time.

I send the wrong version of this patchset, this is the older version.

> 
>> +        return -EINVAL;
>> +
>>       if (mmap_write_lock_killable(current->mm))
>>           return -EINTR;
>>       ret = apply_vma_lock_flags(start, len, 0);
> 
