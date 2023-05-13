Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73AB7012F7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 02:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbjEMA0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 20:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240657AbjEMA0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 20:26:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6651B5583
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1D1A6506F
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 00:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0BCC433EF;
        Sat, 13 May 2023 00:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683937579;
        bh=GO3UO5KJn9t64GdS1QfysnlIesFzZertc6nkP94v5WA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pb0v1wYdxfS63fntMjF2mCAybc9rQe6uwe1U+5ImJmcN/gPUljpz/TtjyJsH8dLcn
         HedrJfpRj7YG87SfuwGJxSuGzWsib1aaOBSNRUbVroAbA8FT7vfqSwMkOMKH1E50fz
         4dYEv2fKWj2UQrXAne/ciH4LlfwrfbIf+mIZzjc4=
Date:   Fri, 12 May 2023 17:26:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     luto@kernel.org, bigeasy@linutronix.de, tglx@linutronix.de,
        bristot@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fork: optimize memcg_charge_kernel_stack() a bit
Message-Id: <20230512172618.1120ab4c1e6d3026081c20d9@linux-foundation.org>
In-Reply-To: <20230508064458.32855-1-haifeng.xu@shopee.com>
References: <20230508064458.32855-1-haifeng.xu@shopee.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 May 2023 06:44:58 +0000 Haifeng Xu <haifeng.xu@shopee.com> wrote:

> Since commit f1c1a9ee00e4 ("fork: Move memcg_charge_kernel_stack()
> into CONFIG_VMAP_STACK"), memcg_charge_kernel_stack() has been moved
> into CONFIG_VMAP_STACK block, so the CONFIG_VMAP_STACK check can be
> removed.
> 
> Furthermore, memcg_charge_kernel_stack() is only invoked by
> alloc_thread_stack_node() instead of dup_task_struct(). If
> memcg_kmem_charge_page() fails, the uncharge process is handled in
> memcg_charge_kernel_stack() itself instead of free_thread_stack(),
> so remove the incorrect comments.
> 
> If memcg_charge_kernel_stack() fails to charge pages used by kernel
> stack, only charged pages need to be uncharged. It's unnecessary to
> uncharge those pages which memory cgroup pointer is NULL.
> 
> ...
>
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -250,23 +250,20 @@ static int memcg_charge_kernel_stack(struct vm_struct *vm)
>  {
>  	int i;
>  	int ret;
> +	int nr_charged = 0;
>  
> -	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 != 0);
> +	BUILD_BUG_ON(PAGE_SIZE % 1024 != 0);

This check now deserves some sort of award.  I'll remove it.

>  	BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
>  
>  	for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
>  		ret = memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL, 0);
>  		if (ret)
>  			goto err;
> +		nr_charged++;
>  	}
>  	return 0;
>  err:
> -	/*
> -	 * If memcg_kmem_charge_page() fails, page's memory cgroup pointer is
> -	 * NULL, and memcg_kmem_uncharge_page() in free_thread_stack() will
> -	 * ignore this page.
> -	 */
> -	for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> +	for (i = 0; i < nr_charged; i++)
>  		memcg_kmem_uncharge_page(vm->pages[i], 0);
>  	return ret;

We don't really need nr_charged - we could just do

	while (--i >= 0)

but nr_charged is straightforward, which is always a good choice.
