Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359C4648CA5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 04:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLJDJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 22:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLJDJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 22:09:52 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E6143860
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 19:09:50 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NTXsk0wyjzJqQB;
        Sat, 10 Dec 2022 11:08:58 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 10 Dec 2022 11:09:48 +0800
Message-ID: <cbda63de-6eb4-30e9-c19e-be58d5c325ec@huawei.com>
Date:   Sat, 10 Dec 2022 11:09:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
CC:     <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>, <clameter@sgi.com>
Subject: Re: [PATCH 1/4] mm/mlock: return EINVAL for illegal user memory range
 in mlock
Content-Language: en-US
To:     <akpm@linux-foundation.org>
References: <20221205034108.3365182-1-mawupeng1@huawei.com>
 <20221205034108.3365182-2-mawupeng1@huawei.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <20221205034108.3365182-2-mawupeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/5 11:41, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
> The return value of mlock is zero. But nothing will be locked since the
> len in do_mlock overflows to zero due to the following code in mlock:
> 
>   len = PAGE_ALIGN(len + (offset_in_page(start)));
> 
> The same problem happens in munlock.
> 
> Since TASK_SIZE is the maximum user space address. The start or len of
> mlock shouldn't be bigger than this. Function access_ok can be used to
> check this issue, so return -EINVAL if bigger.
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>  mm/mlock.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 7032f6dd0ce1..b9422a62a4cf 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -575,6 +575,9 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>  	if (!can_do_mlock())
>  		return -EPERM;
>  
> +	if (unlikely(!access_ok((void __user *)start, len)))
> +		return -EINVAL;

When we are runing ltp testcase, a error occurs on mlock[1]. It seems that
ENOMEN is expencted for this testcase.

In the manual of mlock[2]

       ENOMEM (mlock(), mlock2(), and munlock()) Some of the specified
              address range does not correspond to mapped pages in the
              address space of the process.

ENOMEM seem more appropriate for this situation?

[1] https://github.com/linux-test-project/ltp/blob/20220930/testcases/open_posix_testsuite/conformance/interfaces/mlock/8-1.c
[2] https://man7.org/linux/man-pages/man2/mlock.2.html

> +
>  	len = PAGE_ALIGN(len + (offset_in_page(start)));
>  	start &= PAGE_MASK;
>  
> @@ -635,6 +638,9 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
>  
>  	start = untagged_addr(start);
>  
> +	if (unlikely(!access_ok((void __user *)start, len)))
> +		return -EINVAL;
> +
>  	len = PAGE_ALIGN(len + (offset_in_page(start)));
>  	start &= PAGE_MASK;
>  
