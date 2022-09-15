Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510635B924C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIOBpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiIOBpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:45:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D6A75CDA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:45:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSfzX6mKjzNm7G;
        Thu, 15 Sep 2022 09:40:40 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 09:45:16 +0800
Subject: Re: [PATCH] mm,hwpoison: check mm when killing accessing process
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cuibixuan@linux.alibaba.com>, <baolin.wang@linux.alibaba.com>,
        <zhuo.song@linux.alibaba.com>, <naoya.horiguchi@nec.com>,
        <akpm@linux-foundation.org>
References: <20220914064935.7851-1-xueshuai@linux.alibaba.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <51eb9735-349e-db8b-fa1c-096a924ef520@huawei.com>
Date:   Thu, 15 Sep 2022 09:45:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220914064935.7851-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/14 14:49, Shuai Xue wrote:
> The GHES code calls memory_failure_queue() from IRQ context to queue work
> into workqueue and schedule it on the current CPU. Then the work is
> processed in memory_failure_work_func() by kworker and calls
> memory_failure().
> 
> When a page is already poisoned, commit a3f5d80ea401 ("mm,hwpoison: send
> SIGBUS with error virutal address") make memory_failure() call
> kill_accessing_process() that:
> 
>     - holds mmap locking of current->mm
>     - does pagetable walk to find the error virtual address
>     - and sends SIGBUS to the current process with error info.
> 
> However, the mm of kworker is not valid. Therefore, check mm when killing
> accessing process.
> 
> Fixes: a3f5d80ea401 ("mm,hwpoison: send SIGBUS with error virutal address")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks for fixing.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin


> ---
>  mm/memory-failure.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 14439806b5ef..7553917ce820 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -743,6 +743,9 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>  	};
>  	priv.tk.tsk = p;
>  
> +	if (!p->mm)
> +		return -EFAULT;
> +
>  	mmap_read_lock(p->mm);
>  	ret = walk_page_range(p->mm, 0, TASK_SIZE, &hwp_walk_ops,
>  			      (void *)&priv);
> @@ -751,6 +754,7 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>  	else
>  		ret = 0;
>  	mmap_read_unlock(p->mm);
> +
>  	return ret > 0 ? -EHWPOISON : -EFAULT;
>  }
>  
> 

