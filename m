Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE2C6E511D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDQTl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjDQTlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1240D2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681760438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QD7Mgv4uX8Hx1T0et0GtT03NFYK1sdUeat222CePNVI=;
        b=HZVuLtBFumSxnJ8TL5B11fvEhD3E2DVm4mn6GC8m67sNW/nKjiLFHBLKDPHTEIJQKU5I77
        AFTyTWv3H9pMrnSGVsKhd0joS+iTIw/yynSrX3O7TlJipeov8FJbSw0a0YF7YFcPXTzyj8
        mDS92jIxW34dLPfXirJNdqfxneqD7uw=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-Uy0kGtn3M-6yeIfwiluwog-1; Mon, 17 Apr 2023 15:40:37 -0400
X-MC-Unique: Uy0kGtn3M-6yeIfwiluwog-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-b9266754251so59192276.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681760436; x=1684352436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QD7Mgv4uX8Hx1T0et0GtT03NFYK1sdUeat222CePNVI=;
        b=ir5sWxgNjf5pWYhHkulCFE9SlCCjw2AgbOVX5PUB0WwlQXub6OfJC70C0Ns1ak4m/G
         fxeem4bf9NcLXmz2SRfkDPDhLJw4yN+8eOpGWP4Y67FYT/iJKIyvjnGgx3bG4bGSzebX
         pEcSAEi+HrIjSWFJ59Cb59/lTERDf7nBdPLtMgKOj2ETJTEka/BasGpDXSXBlphtidpx
         VDXazg2Bpa/OibLpqhMho8gr2K5SgUfQd1QHLNP0UvB0t8UQD5Xh3ZHoTz1DyTOtFVmt
         ohDbDN3T6uOGOHeKoLT4vKeX6X11pyYxXiOij5FARRr+nv40FQJkhq5Y4VnX+CSQtTtP
         S4SA==
X-Gm-Message-State: AAQBX9fDz9bPnBEYJ1qysuvX+c897F6kJM1O18NOZzVwgKLNhYsIy8vq
        3zXr0azgPTeZ8k1WNNmr+ObZytqtdtobqM11kqIwWw8JrdA0xYkhtO+rtmxVeDlws41Mp9V0jXp
        xdqZQIjUJwDf/m9zhbtyX7HJx
X-Received: by 2002:a81:583:0:b0:54f:e32a:deff with SMTP id 125-20020a810583000000b0054fe32adeffmr10434449ywf.3.1681760436396;
        Mon, 17 Apr 2023 12:40:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350YD6q5vvoHKqDTd7K6KiDA4ROcON8C6ZRoJdO4XZzX7qGWk2mPo31E07XvG1yaycpLtT59qiw==
X-Received: by 2002:a81:583:0:b0:54f:e32a:deff with SMTP id 125-20020a810583000000b0054fe32adeffmr10434432ywf.3.1681760435990;
        Mon, 17 Apr 2023 12:40:35 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id b10-20020a81bd0a000000b0054bfc94a10dsm3296416ywi.47.2023.04.17.12.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:40:35 -0700 (PDT)
Date:   Mon, 17 Apr 2023 15:40:33 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZD2gsbN2K66oXT69@x1n>
References: <20230415000818.1955007-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230415000818.1955007-1-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 05:08:18PM -0700, Suren Baghdasaryan wrote:
> If the page fault handler requests a retry, we will count the fault
> multiple times. This is a relatively harmless problem as the retry paths
> are not often requested, and the only user-visible problem is that the
> fault counter will be slightly higher than it should be.  Nevertheless,
> userspace only took one fault, and should not see the fact that the
> kernel had to retry the fault multiple times.
> Move page fault accounting into mm_account_fault() and skip incomplete
> faults which will be accounted upon completion.
> 
> Fixes: d065bd810b6d ("mm: retry page fault when blocking on disk transfer")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/memory.c | 45 ++++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 01a23ad48a04..c3b709ceeed7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5080,24 +5080,30 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>   * updates.  However, note that the handling of PERF_COUNT_SW_PAGE_FAULTS should
>   * still be in per-arch page fault handlers at the entry of page fault.
>   */
> -static inline void mm_account_fault(struct pt_regs *regs,
> +static inline void mm_account_fault(struct mm_struct *mm, struct pt_regs *regs,
>  				    unsigned long address, unsigned int flags,
>  				    vm_fault_t ret)
>  {
>  	bool major;
>  
>  	/*
> -	 * We don't do accounting for some specific faults:
> -	 *
> -	 * - Unsuccessful faults (e.g. when the address wasn't valid).  That
> -	 *   includes arch_vma_access_permitted() failing before reaching here.
> -	 *   So this is not a "this many hardware page faults" counter.  We
> -	 *   should use the hw profiling for that.
> -	 *
> -	 * - Incomplete faults (VM_FAULT_RETRY).  They will only be counted
> -	 *   once they're completed.
> +	 * Do not account for incomplete faults (VM_FAULT_RETRY). They will be
> +	 * counted upon completion.
>  	 */
> -	if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> +	if (ret & VM_FAULT_RETRY)
> +		return;
> +
> +	/* Register both successful and failed faults in PGFAULT counters. */
> +	count_vm_event(PGFAULT);
> +	count_memcg_event_mm(mm, PGFAULT);

Is there reason on why vm events accountings need to be explicitly
different from perf events right below on handling ERROR?

I get the point if this is to make sure ERROR accountings untouched for
these two vm events after this patch. IOW probably the only concern right
now is having RETRY counted much more than before (perhaps worse with vma
locking applied).

But since we're on this, I'm wondering whether we should also align the two
events (vm, perf) so they represent in an aligned manner if we'll change it
anyway.  Any future reader will be confused on why they account
differently, IMHO, so if we need to differenciate we'd better add a comment
on why.

I'm wildly guessing the error faults are indeed very rare and probably not
matter much at all.  I just think the code can be slightly cleaner if
vm/perf accountings match and easier if we treat everything the same. E.g.,
we can also drop the below "goto out"s too.  What do you think?

Thanks,

> +
> +	/*
> +	 * Do not account for unsuccessful faults (e.g. when the address wasn't
> +	 * valid).  That includes arch_vma_access_permitted() failing before
> +	 * reaching here. So this is not a "this many hardware page faults"
> +	 * counter.  We should use the hw profiling for that.
> +	 */
> +	if (ret & VM_FAULT_ERROR)
>  		return;
>  
>  	/*
> @@ -5180,21 +5186,22 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
>  vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  			   unsigned int flags, struct pt_regs *regs)
>  {
> +	/* Copy vma->vm_mm in case mmap_lock is dropped and vma becomes unstable. */
> +	struct mm_struct *mm = vma->vm_mm;
>  	vm_fault_t ret;
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
> @@ -5223,8 +5230,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  		if (task_in_memcg_oom(current) && !(ret & VM_FAULT_OOM))
>  			mem_cgroup_oom_synchronize(false);
>  	}
> -
> -	mm_account_fault(regs, address, flags, ret);
> +out:
> +	mm_account_fault(mm, regs, address, flags, ret);
>  
>  	return ret;
>  }
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 
> 

-- 
Peter Xu

