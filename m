Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CED37406CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjF0XSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjF0XSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:18:12 -0400
Received: from out-50.mta1.migadu.com (out-50.mta1.migadu.com [95.215.58.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965A41BD3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:18:10 -0700 (PDT)
Date:   Wed, 28 Jun 2023 08:18:01 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687907888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LlAv/OEes3YgB3crC0K1uGYbzsL4k9IzLBsDd2qLoyU=;
        b=WG4YiY3EaXnCVdJHVatfVGf3Hk4HhGjeMbaXk01RKnTsMXKL46cJW34aSmnNC/vUWbpbuh
        ypeFf9xCN2aJlkKVzr2S2I1XddhvHWY0SgWP0MQRmT8SS22PJ8OA7olSwxrEQ6kS05r+FH
        WULX8Kcj46vhDGs3OvivrmGaLxEFuC0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memory-failure: remove unneeded 'inline' annotation
Message-ID: <20230627231801.GA992637@ik1-406-35019.vs.sakura.ne.jp>
References: <20230626114343.1846587-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230626114343.1846587-1-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 07:43:43PM +0800, Miaohe Lin wrote:
> Remove unneeded 'inline' annotation from num_poisoned_pages_inc() and
> num_poisoned_pages_sub(). No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Yes, num_poisoned_pages_{inc,sub} seem not to be inlined even if "inline"
keyword is given, maybe because they are not static functions.

Thank you for finding this.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

> ---
>  mm/memory-failure.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 66e7b3ceaf2d..aada6ac72fe5 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -75,13 +75,13 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>  
>  static bool hw_memory_failure __read_mostly = false;
>  
> -inline void num_poisoned_pages_inc(unsigned long pfn)
> +void num_poisoned_pages_inc(unsigned long pfn)
>  {
>  	atomic_long_inc(&num_poisoned_pages);
>  	memblk_nr_poison_inc(pfn);
>  }
>  
> -inline void num_poisoned_pages_sub(unsigned long pfn, long i)
> +void num_poisoned_pages_sub(unsigned long pfn, long i)
>  {
>  	atomic_long_sub(i, &num_poisoned_pages);
>  	if (pfn != -1UL)
> -- 
> 2.27.0
> 
> 
> 
