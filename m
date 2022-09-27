Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F2B5EC351
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiI0MyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiI0MyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:54:03 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A0BCDCE3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:53:59 -0700 (PDT)
Date:   Tue, 27 Sep 2022 21:53:50 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664283238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlZJ/Kh6cvan+YPeLMPgG+E2Ues2lCHrz7rn9R03zos=;
        b=W1atcqI3NaWtFt0xWb+YaT32TTC/fiDYeOgL8A2SZV8DsySbiuZmRJAH16HMPoGeQpvoO1
        DcN2TfRZxSTK7eGB2kbbrB81YuGIqFGAMjSRZ0AYS7eoeR+sT7fuqDjTnbGKSsGZF6tQ3K
        +oi4mf6siSvuC2qneEMcYzgNWOWyXzQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hwpoison: fix build error without
 CONFIG_MEMORY_FAILURE
Message-ID: <20220927125350.GA500539@u2004.lan>
References: <20220927102946.98622-1-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220927102946.98622-1-tanghui20@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 06:29:46PM +0800, Hui Tang wrote:
> Building without CONFIG_MEMORY_FAILURE will fail:
> 
> mm/memory-failure.o: In function `action_result':
> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
> mm/memory-failure.o: In function `page_handle_poison':
> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
> mm/memory-failure.o: In function `__get_huge_page_for_hwpoison':
> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
> mm/memory-failure.o: In function `unpoison_memory':
> memory-failure.c: undefined reference to `memblk_nr_poison_sub'
> mm/memory-failure.o: In function `num_poisoned_pages_inc':
> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
> 
> Add CONFIG_MEMORY_FAILURE wrapper for invoking memblk_nr_poison_{inc|sub}.
> 
> Fixes: 69b496f03bb4 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
> Signed-off-by: Hui Tang <tanghui20@huawei.com>

Thank you for the patch.  I have a question.
If you disables CONFIG_MEMORY_FAILURE, mm/memory-failure.c should
not be compiled, so I wonder why you saw the compile error.
Could you share your .config file?

Acutally I saw the similar report a few days ago
https://lore.kernel.org/lkml/20220923095013.1151252-1-michael@walle.cc/
, where the build error happened in aarch64,  so I likely missed some arch
dependency.  I responded to the report by updating the patch by applying
"#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)"
to the definition of memblk_nr_poison_{inc,sub}.
https://lore.kernel.org/lkml/20220923141204.GA1484969@ik1-406-35019.vs.sakura.ne.jp/

I did not confirm that this fix is really right, because I can't reproduced
the build error in my environment.  So could you check that v5 patch fixes
the build error you're seeing?  (The current version in mm-unstable is v4,
so that should be replaced with v5.)

Thanks,
Naoya Horiguchi

> ---
>  mm/memory-failure.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 03479895086d..5bb9d2d20234 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -77,14 +77,18 @@ static bool hw_memory_failure __read_mostly = false;
>  void num_poisoned_pages_inc(unsigned long pfn)
>  {
>  	atomic_long_inc(&num_poisoned_pages);
> +#ifdef CONFIG_MEMORY_FAILURE
>  	memblk_nr_poison_inc(pfn);
> +#endif
>  }
>  
>  static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
>  {
>  	atomic_long_sub(i, &num_poisoned_pages);
> +#ifdef CONFIG_MEMORY_FAILURE
>  	if (pfn != -1UL)
>  		memblk_nr_poison_sub(pfn, i);
> +#endif
>  }
>  
>  /*
> -- 
> 2.17.1
> 
> 
> 
