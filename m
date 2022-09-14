Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89945B9084
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiINWfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiINWfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:35:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE137EFE6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67B1BB81CE0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 22:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F73C433C1;
        Wed, 14 Sep 2022 22:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663194943;
        bh=V3UnjH8r8/HZCf/bUXEv6LLNwHtF7DQP1lCGuLGnSdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BuIdCB2Dng/VZh/rE6kuH/hBzh9AoNuhbKvfiKDY76Tsl76mj9UVm+7dE7qLi0fqT
         X8WEcEkV5ma5YeYJP+ZkT+5+gAg7jodnZakuRY66tb/J2kAdVOSnvZafZJ1TKgy1qU
         0wU9+nOA78D4kzV6UZL6EgRZszStVxVumn2JCTnQ=
Date:   Wed, 14 Sep 2022 15:35:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     naoya.horiguchi@nec.com, linmiaohe@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cuibixuan@linux.alibaba.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] mm,hwpoison: check mm when killing accessing process
Message-Id: <20220914153542.285f870f728c6129a479a69d@linux-foundation.org>
In-Reply-To: <20220914064935.7851-1-xueshuai@linux.alibaba.com>
References: <20220914064935.7851-1-xueshuai@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 14:49:35 +0800 Shuai Xue <xueshuai@linux.alibaba.com> wrote:

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

Thanks.

When fixing a bug, please always describe the user-visible effects of
tha bug.  I'm thinking "null pointer deref crashes the kernel".

> Fixes: a3f5d80ea401 ("mm,hwpoison: send SIGBUS with error virutal address")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

I'll add cc:stable.

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

This is an unrelated change which doesn't appear to match the style in
memory-failure.c, so I'll drop this hunk.

