Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F59D6E2BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 23:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDNVru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 17:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDNVrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 17:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DCD2108
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681508826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/JZtBnf+Q/vz66UT0GWX180v95wsOpJkHZixtsU6vGs=;
        b=VU+S350s/GdXbxzVnABsa/60TJ93M3NIwyT56+IHQNsx61dCTr+NKDAGxSNKGGZDzPVlIf
        8Qog8R0hS42bJs63dDKmfkAgRpFC4vOzWdXncZAfcHOFt7XVNbL1C/2wlZjpU4VL5kDo3j
        Isugl79WoeJoKhFoejB/nJxmI6+VXug=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-kLhygWg1NBWN3GBkq3Fr_Q-1; Fri, 14 Apr 2023 17:47:04 -0400
X-MC-Unique: kLhygWg1NBWN3GBkq3Fr_Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-5ef52d3474bso2606706d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681508824; x=1684100824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JZtBnf+Q/vz66UT0GWX180v95wsOpJkHZixtsU6vGs=;
        b=BsihKAdBcOZF3t9aWz3Ivt8BhuHRr0Y9fo2IJrzAXxfCZEi2lzoAK67botAmz0xYRI
         UKQJd+tZm8rLR9/n1a85HIGj0gdkYCTb3f4l2hLEqJK0Q9MRZ6p4znVFHneaeZDUJj43
         6l3plBTKfo3dyX/ZLdQyYi/Mcm4RneJuHP4c77xUl3xYlifPpb+loeF5VYjq9K5NZG/h
         alOwCD9V07obKohuIgM88bdUj8NY6s8EXtIspeLPM7zke6udev+2CcCFJxfivRZ8XC0w
         QHokw5+ByxggMeYYYUItyQTQ5bFdIXvYABZ6bbObXMxOIrmCg9Po3cVBE/2j2mjItcDc
         MEsw==
X-Gm-Message-State: AAQBX9chqFJ4ZcOCyMQy3W83qZ3vhI/a8MAxH9VuD+55/vXH8tBpKMTV
        JqoBMvfJ9xGPII6Saa2m4oejGK/T4ZFsiRgEup8UWoASeqhbQhztf+QMZNwycj9fWB4E+VCm6xH
        LDA//K75/cpd3ozmF5Y50Z9U6
X-Received: by 2002:a05:6214:518c:b0:5e9:2bad:c920 with SMTP id kl12-20020a056214518c00b005e92badc920mr5846912qvb.5.1681508824346;
        Fri, 14 Apr 2023 14:47:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zg9zm4iUKiGldo8x6g+huann62DVqlW+cmQWxx4tINf3p7pg3r1wJO2bKnEZRBgERyzW+SLA==
X-Received: by 2002:a05:6214:518c:b0:5e9:2bad:c920 with SMTP id kl12-20020a056214518c00b005e92badc920mr5846898qvb.5.1681508824097;
        Fri, 14 Apr 2023 14:47:04 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id mf10-20020a0562145d8a00b005dd8b9345d2sm1358694qvb.106.2023.04.14.14.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 14:47:03 -0700 (PDT)
Date:   Fri, 14 Apr 2023 17:47:01 -0400
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
Subject: Re: [PATCH 1/1] mm: do not increment pgfault stats when page fault
 handler retries
Message-ID: <ZDnJ1dOU2tpK6l68@x1n>
References: <20230414175444.1837474-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230414175444.1837474-1-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Suren,

On Fri, Apr 14, 2023 at 10:54:44AM -0700, Suren Baghdasaryan wrote:
> If the page fault handler requests a retry, we will count the fault
> multiple times.  This is a relatively harmless problem as the retry paths
> are not often requested, and the only user-visible problem is that the
> fault counter will be slightly higher than it should be.  Nevertheless,
> userspace only took one fault, and should not see the fact that the
> kernel had to retry the fault multiple times.
> 
> Fixes: 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking operations")
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

Here is the mm_account_fault() function taking care of some other
accountings.  Perhaps good to put things into it?

It also already ignores invalid faults:

	if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
		return;

I see that you may also want to account for sigbus, however I really don't
know why.  Explanations would be great when it would matter.  So far it
makes sense to me if we skip both RETRY or ERROR cases.

> +out:
> +	if (!(ret & VM_FAULT_RETRY)) {
> +		count_vm_event(PGFAULT);
> +		count_memcg_event_mm(vma->vm_mm, PGFAULT);

There is one thing worth noticing is here vma may or may not be valid
depending on the retval of the fault.

RETRY is exactly one of the cases that accessing vma may be unsafe due to
releasing of mmap read lock.  The other one is the recently added
VM_FAULT_COMPLETE.  So if we want to move this chunk (or any vma reference)
to be later we need to consider a valid vma / mm being there first, or
we're prone to accessing a vma that has already been released, I think.

> +	}
>  
>  	return ret;
>  }
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 
> 

Thanks,

-- 
Peter Xu

