Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B526E29D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjDNSMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNSMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:12:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D26A8A53
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 11:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vZqhG6c9njRhZ7EHyEhLnr2bzHk82i0mvo2aafzvJ6I=; b=qzri7bds+FjHec184/+U/iYi/E
        zme+Blem6PjCSZfpjAkCFdYzJ0ywDqOOwq4tgOmk6cHvy2Y23vTeAvxMZEx79MrOud2wE6ZCFGM02
        0Q+DTD6kDI/Xyil3mOdOi1DI8egCUKOO/hKeAeDjC/ZGAx1wcYK8zf+fwfsS+nzJVJLuodZr/wcV7
        N3GMIDW02u94Y2dcGwuYuPslNsQgfPkHhHXaEBedx3z5qYYcGFr+tddCr5zWOIT3kbmFFxxkLcHH8
        ejYBLsyLBnsHn50kZ2EIZJ09raVi2fAIihE6/3tQdV9Y9C5x1ENA2tM3cifXIK2rfieLNYUhQkBwR
        PQ6Nh+cQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnNtf-008xzE-Pa; Fri, 14 Apr 2023 18:11:43 +0000
Date:   Fri, 14 Apr 2023 19:11:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: do not increment pgfault stats when page fault
 handler retries
Message-ID: <ZDmXX82ly2OhfJ1D@casper.infradead.org>
References: <20230414175444.1837474-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414175444.1837474-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 10:54:44AM -0700, Suren Baghdasaryan wrote:
> If the page fault handler requests a retry, we will count the fault
> multiple times.  This is a relatively harmless problem as the retry paths
> are not often requested, and the only user-visible problem is that the
> fault counter will be slightly higher than it should be.  Nevertheless,
> userspace only took one fault, and should not see the fact that the
> kernel had to retry the fault multiple times.
> 
> Fixes: 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking operations")

I know I suggested this fixes line, but I think it's actually been
here much longer, perhaps since

Fixes: d065bd810b6d ("mm: retry page fault when blocking on disk transfer")

Michel, what do you think?

> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> Patch applies cleanly over linux-next and mm-unstable
> 
>  mm/memory.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 1c5b231fe6e3..d88f370eacd1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5212,17 +5212,16 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  
>  	__set_current_state(TASK_RUNNING);
>  
> -	count_vm_event(PGFAULT);
> -	count_memcg_event_mm(vma->vm_mm, PGFAULT);
> -
>  	ret = sanitize_fault_flags(vma, &flags);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
>  					    flags & FAULT_FLAG_INSTRUCTION,
> -					    flags & FAULT_FLAG_REMOTE))
> -		return VM_FAULT_SIGSEGV;
> +					    flags & FAULT_FLAG_REMOTE)) {
> +		ret = VM_FAULT_SIGSEGV;
> +		goto out;
> +	}
>  
>  	/*
>  	 * Enable the memcg OOM handling for faults triggered in user
> @@ -5253,6 +5252,11 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  	}
>  
>  	mm_account_fault(regs, address, flags, ret);
> +out:
> +	if (!(ret & VM_FAULT_RETRY)) {
> +		count_vm_event(PGFAULT);
> +		count_memcg_event_mm(vma->vm_mm, PGFAULT);
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 
