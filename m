Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBAF646EDA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLHLq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHLqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C889C554FD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 03:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670499930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WvyhlB+TePEV+nt+nsHgaA3oBgy2T7adymKuPtzn+p0=;
        b=Jfbteb6iJS4f/tCFvz7PJc44JCGaaWXjGyApflUChjoj/SVZmO+w6h25Asd80l7MgK8OwC
        6PqZriaFD43tioBqcj1/P+QcRCJf/5gIbKNg+yWvALmP0SZE+ByXqf2g+3c8cGeL7JBCdL
        7aEhRYT7qS5BX39baq5bRKa31MKvx9s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-448-h5Fhpsw7PV6jRU5wD4p4kQ-1; Thu, 08 Dec 2022 06:45:28 -0500
X-MC-Unique: h5Fhpsw7PV6jRU5wD4p4kQ-1
Received: by mail-wm1-f71.google.com with SMTP id f1-20020a1cc901000000b003cf703a4f08so522409wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 03:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvyhlB+TePEV+nt+nsHgaA3oBgy2T7adymKuPtzn+p0=;
        b=0BQwQmh7MzCDHvdHV21XyMoasRY2y8GO7jhw/BgyqMqRNu41pe/SPdr/xsCXCqOhOr
         g4LaBXcCSGoI/BpIrFIcfSKuq2qanqTdv6A7CCq+u8WbP/psmqZKI2fZ6IvdOgxcHssV
         T9tzip1MHUNHQ+8RQY+2xmxfqhqLXOb14pIhoHcQIu/EDX+fwMVp8UwUYrQQKNOe+f8W
         kreZi37iHySIjHXJ33laHF7+jO4BKfU8napJdyfd988afT5eHM+ljYbX0T+ygtXqGFI6
         vC1omtIX9mAMps2rw9TSrXwFzGatMmNkpPwGJvGDFu5tuEtFg8GX3RC5dL09HKfDE/VK
         GQeA==
X-Gm-Message-State: ANoB5pkPvhLp9TfrGFsmWTzvn4lMg2woRVjhm8EpSZwkIcB9KSaJnuXk
        sN7ASDE6VCbib92LLyfKDwIk/N088HegRn7eMgyIDhxvmPbhu9clsnDb0hCmecTYs19nFHq5QZn
        Z16JlaLqapC4BWNQ29r8XpHinBkWF85/pB3aJcXtEoYBvhLSAsj4CUj3kJTtnVeXd+6qDacIg
X-Received: by 2002:a05:600c:554b:b0:3d0:88b4:9cda with SMTP id iz11-20020a05600c554b00b003d088b49cdamr18055690wmb.114.1670499927738;
        Thu, 08 Dec 2022 03:45:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5RtKn3V37BX8nYnuLESqHtB60503vSNmHoc+41TTHuFySKR2d9sU96hNBiyeYeWorvuqSGTg==
X-Received: by 2002:a05:600c:554b:b0:3d0:88b4:9cda with SMTP id iz11-20020a05600c554b00b003d088b49cdamr18055665wmb.114.1670499927359;
        Thu, 08 Dec 2022 03:45:27 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d66cf000000b00228d52b935asm21570694wrw.71.2022.12.08.03.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 03:45:26 -0800 (PST)
Message-ID: <83259ac7-1aa4-e186-43d9-2b280795e510@redhat.com>
Date:   Thu, 8 Dec 2022 12:45:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1] mm/userfaultfd: enable writenotify while
 userfaultfd-wp is enabled for a VMA
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Ives van Hoorne <ives@codesandbox.io>,
        Peter Xu <peterx@redhat.com>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hugh@veritas.com>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20221208114137.35035-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221208114137.35035-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.12.22 12:41, David Hildenbrand wrote:
> Currently, we don't enable writenotify when enabling userfaultfd-wp on
> a shared writable mapping (for now only shmem and hugetlb). The consequence
> is that vma->vm_page_prot will still include write permissions, to be set
> as default for all PTEs that get remapped (e.g., mprotect(), NUMA hinting,
> page migration, ...).
> 
> So far, vma->vm_page_prot is assumed to be a safe default, meaning that
> we only add permissions (e.g., mkwrite) but not remove permissions (e.g.,
> wrprotect). For example, when enabling softdirty tracking, we enable
> writenotify. With uffd-wp on shared mappings, that changed. More details
> on vma->vm_page_prot semantics were summarized in [1].
> 
> This is problematic for uffd-wp: we'd have to manually check for
> a uffd-wp PTEs/PMDs and manually write-protect PTEs/PMDs, which is error
> prone. Prone to such issues is any code that uses vma->vm_page_prot to set
> PTE permissions: primarily pte_modify() and mk_pte().
> 
> Instead, let's enable writenotify such that PTEs/PMDs/... will be mapped
> write-protected as default and we will only allow selected PTEs that are
> definitely safe to be mapped without write-protection (see
> can_change_pte_writable()) to be writable. In the future, we might want
> to enable write-bit recovery -- e.g., can_change_pte_writable() -- at
> more locations, for example, also when removing uffd-wp protection.
> 
> This fixes two known cases:
> 
> (a) remove_migration_pte() mapping uffd-wp'ed PTEs writable, resulting
>      in uffd-wp not triggering on write access.
> (b) do_numa_page() / do_huge_pmd_numa_page() mapping uffd-wp'ed PTEs/PMDs
>      writable, resulting in uffd-wp not triggering on write access.
> 
> Note that do_numa_page() / do_huge_pmd_numa_page() can be reached even
> without NUMA hinting (which currently doesn't seem to be applicable to
> shmem), for example, by using uffd-wp with a PROT_WRITE shmem VMA.
> On such a VMA, userfaultfd-wp is currently non-functional.
> 
> Note that when enabling userfaultfd-wp, there is no need to walk page
> tables to enforce the new default protection for the PTEs: we know that
> they cannot be uffd-wp'ed yet, because that can only happen after
> enabling uffd-wp for the VMA in general.
> 
> Also note that this makes mprotect() on ranges with uffd-wp'ed PTEs not
> accidentally set the write bit -- which would result in uffd-wp not
> triggering on later write access. This commit makes uffd-wp on shmem behave
> just like uffd-wp on anonymous memory (iow, less special) in that regard,
> even though, mixing mprotect with uffd-wp is controversial.
> 
> [1] https://lkml.kernel.org/r/92173bad-caa3-6b43-9d1e-9a471fdbc184@redhat.com
> 
> Reported-by: Ives van Hoorne <ives@codesandbox.io>
> Debugged-by: Peter Xu <peterx@redhat.com>
> Fixes: b1f9e876862d ("mm/uffd: enable write protection for shmem & hugetlbfs")
> Cc: stable@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hugh Dickins <hugh@veritas.com>

No idea how a wrong mail address from Hugh sneaked in 2 (I assume, 
copy-paste issue from de1ccfb64824). Let's properly cc him and keep the 
full patch.

> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> As discussed in [2], this is supposed to replace the fix by Peter:
>    [PATCH v3 1/2] mm/migrate: Fix read-only page got writable when recover
>    pte
> 
> This survives vm/selftests and my reproducers:
> * migrating pages that are uffd-wp'ed using mbind() on a machine with 2
>    NUMA nodes
> * Using a PROT_WRITE mapping with uffd-wp
> * Using a PROT_READ|PROT_WRITE mapping with uffd-wp'ed pages and
>    mprotect()'ing it PROT_WRITE
> * Using a PROT_READ|PROT_WRITE mapping with uffd-wp'ed pages and
>    temporarily mprotect()'ing it PROT_READ
> 
> uffd-wp properly triggers in all cases. On v8.1-rc8, all mre reproducers
> fail.
> 
> It would be good to get some more testing feedback and review.
> 
> [2] https://lkml.kernel.org/r/20221202122748.113774-1-david@redhat.com
> 
> ---
>   fs/userfaultfd.c | 28 ++++++++++++++++++++++------
>   mm/mmap.c        |  4 ++++
>   2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 98ac37e34e3d..fb0733f2e623 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -108,6 +108,21 @@ static bool userfaultfd_is_initialized(struct userfaultfd_ctx *ctx)
>   	return ctx->features & UFFD_FEATURE_INITIALIZED;
>   }
>   
> +static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
> +				     vm_flags_t flags)
> +{
> +	const bool uffd_wp = !!((vma->vm_flags | flags) & VM_UFFD_WP);
> +
> +	vma->vm_flags = flags;
> +	/*
> +	 * For shared mappings, we want to enable writenotify while
> +	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
> +	 * recalculate vma->vm_page_prot whenever userfaultfd-wp is involved.
> +	 */
> +	if ((vma->vm_flags & VM_SHARED) && uffd_wp)
> +		vma_set_page_prot(vma);
> +}
> +
>   static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
>   				     int wake_flags, void *key)
>   {
> @@ -618,7 +633,8 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
>   		for_each_vma(vmi, vma) {
>   			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
>   				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> -				vma->vm_flags &= ~__VM_UFFD_FLAGS;
> +				userfaultfd_set_vm_flags(vma,
> +							 vma->vm_flags & ~__VM_UFFD_FLAGS);
>   			}
>   		}
>   		mmap_write_unlock(mm);
> @@ -652,7 +668,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
>   	octx = vma->vm_userfaultfd_ctx.ctx;
>   	if (!octx || !(octx->features & UFFD_FEATURE_EVENT_FORK)) {
>   		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> -		vma->vm_flags &= ~__VM_UFFD_FLAGS;
> +		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
>   		return 0;
>   	}
>   
> @@ -733,7 +749,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
>   	} else {
>   		/* Drop uffd context if remap feature not enabled */
>   		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> -		vma->vm_flags &= ~__VM_UFFD_FLAGS;
> +		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
>   	}
>   }
>   
> @@ -895,7 +911,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
>   			prev = vma;
>   		}
>   
> -		vma->vm_flags = new_flags;
> +		userfaultfd_set_vm_flags(vma, new_flags);
>   		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
>   	}
>   	mmap_write_unlock(mm);
> @@ -1463,7 +1479,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>   		 * the next vma was merged into the current one and
>   		 * the current one has not been updated yet.
>   		 */
> -		vma->vm_flags = new_flags;
> +		userfaultfd_set_vm_flags(vma, new_flags);
>   		vma->vm_userfaultfd_ctx.ctx = ctx;
>   
>   		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
> @@ -1651,7 +1667,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>   		 * the next vma was merged into the current one and
>   		 * the current one has not been updated yet.
>   		 */
> -		vma->vm_flags = new_flags;
> +		userfaultfd_set_vm_flags(vma, new_flags);
>   		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
>   
>   	skip:
> diff --git a/mm/mmap.c b/mm/mmap.c
> index a5eb2f175da0..6033d20198b0 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1525,6 +1525,10 @@ int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
>   	if (vma_soft_dirty_enabled(vma) && !is_vm_hugetlb_page(vma))
>   		return 1;
>   
> +	/* Do we need write faults for uffd-wp tracking? */
> +	if (userfaultfd_wp(vma))
> +		return 1;
> +
>   	/* Specialty mapping? */
>   	if (vm_flags & VM_PFNMAP)
>   		return 0;
> 
> base-commit: 8ed710da2873c2aeb3bb805864a699affaf1d03b

-- 
Thanks,

David / dhildenb

