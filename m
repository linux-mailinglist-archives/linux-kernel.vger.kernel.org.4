Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261A4658A19
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiL2Hsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiL2HsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:48:17 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3768FB844
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:48:14 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NjL3v5GhHzkX1g;
        Thu, 29 Dec 2022 15:43:39 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 29 Dec 2022 15:48:12 +0800
Message-ID: <ffd9e2ef-8240-35db-f6ec-e1bfcd8e011d@huawei.com>
Date:   Thu, 29 Dec 2022 15:48:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   mawupeng <mawupeng1@huawei.com>
Subject: Re: [PATCH 1/4] mm/mlock: return EINVAL for illegal user memory range
 in mlock
To:     <akpm@linux-foundation.org>
CC:     <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>, <clameter@sgi.com>
References: <20221205034108.3365182-1-mawupeng1@huawei.com>
 <20221205034108.3365182-2-mawupeng1@huawei.com>
 <20221228141701.c64add46c4b09aa17f605baf@linux-foundation.org>
Content-Language: en-US
In-Reply-To: <20221228141701.c64add46c4b09aa17f605baf@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/29 6:17, Andrew Morton wrote:
> On Mon, 5 Dec 2022 11:41:05 +0800 Wupeng Ma <mawupeng1@huawei.com> wrote:
> 
>> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
>> The return value of mlock is zero. But nothing will be locked since the
>> len in do_mlock overflows to zero due to the following code in mlock:
>>
>>   len = PAGE_ALIGN(len + (offset_in_page(start)));
>>
>> The same problem happens in munlock.
>>
>> Since TASK_SIZE is the maximum user space address. The start or len of
>> mlock shouldn't be bigger than this. Function access_ok can be used to
>> check this issue, so return -EINVAL if bigger.
> 
> What happens if userspace uses a value somewhat smaller than ULONG_MAX?
> 
> 	mlock(addr, ULONG_MAX - 1000000);
> 
> ?
> 
> Because if the above works successfully and if it no longer works
> successfully with this patchset then that could be a
> backward-compatibility problem.

For mlock:

 mlock(addr, ULONG_MAX - 1000000) will ret -1 and the errno is EINVAL(22) due to
the following call trace.

do_mlock
  apply_vma_lock_flags
    end = start + len;
    if (end < start)
      return -EINVAL;

Just like you said, we need to keep backward-compatibility. Maybe we can only catch and fix
the overflowing scenarios since they are absolutely wrong. here is the diff:

diff --git a/mm/mlock.c b/mm/mlock.c
index 7032f6dd0ce1..fd5e857ab245 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -569,6 +569,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
        unsigned long locked;
        unsigned long lock_limit;
        int error = -ENOMEM;
+       size_t old_len = len;
 
        start = untagged_addr(start);
 
@@ -578,6 +579,9 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
        len = PAGE_ALIGN(len + (offset_in_page(start)));
        start &= PAGE_MASK;
 
+       if (old_len != 0 && len == 0)
+               return -EINVAL;
+
        lock_limit = rlimit(RLIMIT_MEMLOCK);
        lock_limit >>= PAGE_SHIFT;
        locked = len >> PAGE_SHIFT;


> 
