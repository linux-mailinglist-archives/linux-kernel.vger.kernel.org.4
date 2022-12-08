Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA80F64744E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiLHQaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLHQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:30:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CC72125A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670516943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pm9mT9pO7WE/9vLFhiA7g8rknybeYoY/tVPaAx1JEgs=;
        b=B2VWUQfe/kUOAGDbUqwsvmI+jehJZ0UO49Equt03j9X9COiMRDOvvAsvAfRx0IBeLNiWTq
        qraEIWbE2+1O0raMK2PfjOPDgy9zjXL5xDDrx8EvzVYu3oklcxF0zECpAmMt42E5mblq/x
        XgnlGJL6XX8FWvHbsS8qIDiFhdwcHx0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102-HXg8qDxSP--teAj8R8zLAA-1; Thu, 08 Dec 2022 11:29:02 -0500
X-MC-Unique: HXg8qDxSP--teAj8R8zLAA-1
Received: by mail-qv1-f71.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso1854737qvr.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pm9mT9pO7WE/9vLFhiA7g8rknybeYoY/tVPaAx1JEgs=;
        b=SSwt9H5T3qSvWkN2ag59rTRhyKeSSNlkjgGuALu30yWURKtRV1v51cp+scZ0cOz53V
         EUL/i7gKG9wkf9oEIme51Wit+jypnCoKrUzErnqiNbbvO71pGUFs3WN32pOho2IQQF+K
         in+xju/j1YoPbZrMtWlrIcIzlmbFdrJ/ZfmKUbbN8IQJt+8fiXVAWPHPhvC4mnKGxjgn
         NhkzXUnAISBVBV27/phCRQE6HKUuDv8ogW7G0WhGjGbWCCB2PmK7GC6OW0ySv3LoZjpk
         KlDgWV+vVyeIYf3gThg9wAw8O0K4hzJKld+6s+kTBIfRLP9LtgiolzgiTY0CQH1xtC7l
         tvMw==
X-Gm-Message-State: ANoB5pmGOku2AbnZJo/Ulzbxy0tb0mUKFZi0Qgc/ERsX3FGGkAfsYZRH
        Rzhn9RXEAk1w7LhSAWVFpgQzZKHKUtG6a3Sb59qRe1xqLQMSzIDgJncUpVzEBM7Zy7B4w7tECOw
        AhiqrtM4QPAkK3Bt8OSclcon2
X-Received: by 2002:ac8:5e91:0:b0:3a6:6f8c:5d78 with SMTP id r17-20020ac85e91000000b003a66f8c5d78mr3294379qtx.68.1670516942132;
        Thu, 08 Dec 2022 08:29:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7o0hEkxrts0nz45XYRAEI+ozjuWLKdORi42BIHdkcvHIUFj0SSffFLmQOUHMsjqI/UoDf+Ww==
X-Received: by 2002:ac8:5e91:0:b0:3a6:6f8c:5d78 with SMTP id r17-20020ac85e91000000b003a66f8c5d78mr3294353qtx.68.1670516941837;
        Thu, 08 Dec 2022 08:29:01 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id j11-20020ac8550b000000b003434d3b5938sm15597403qtq.2.2022.12.08.08.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:29:01 -0800 (PST)
Date:   Thu, 8 Dec 2022 11:29:00 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ives van Hoorne <ives@codesandbox.io>,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hugh@veritas.com>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v1] mm/userfaultfd: enable writenotify while
 userfaultfd-wp is enabled for a VMA
Message-ID: <Y5IQzJkBSYwPOtiP@x1n>
References: <20221208114137.35035-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221208114137.35035-1-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 12:41:37PM +0100, David Hildenbrand wrote:
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
>     in uffd-wp not triggering on write access.
> (b) do_numa_page() / do_huge_pmd_numa_page() mapping uffd-wp'ed PTEs/PMDs
>     writable, resulting in uffd-wp not triggering on write access.
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
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

One trivial nit.

> ---
> 
> As discussed in [2], this is supposed to replace the fix by Peter:
>   [PATCH v3 1/2] mm/migrate: Fix read-only page got writable when recover
>   pte
> 
> This survives vm/selftests and my reproducers:
> * migrating pages that are uffd-wp'ed using mbind() on a machine with 2
>   NUMA nodes
> * Using a PROT_WRITE mapping with uffd-wp
> * Using a PROT_READ|PROT_WRITE mapping with uffd-wp'ed pages and
>   mprotect()'ing it PROT_WRITE
> * Using a PROT_READ|PROT_WRITE mapping with uffd-wp'ed pages and
>   temporarily mprotect()'ing it PROT_READ
> 
> uffd-wp properly triggers in all cases. On v8.1-rc8, all mre reproducers
> fail.
> 
> It would be good to get some more testing feedback and review.
> 
> [2] https://lkml.kernel.org/r/20221202122748.113774-1-david@redhat.com
> 
> ---
>  fs/userfaultfd.c | 28 ++++++++++++++++++++++------
>  mm/mmap.c        |  4 ++++
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 98ac37e34e3d..fb0733f2e623 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -108,6 +108,21 @@ static bool userfaultfd_is_initialized(struct userfaultfd_ctx *ctx)
>  	return ctx->features & UFFD_FEATURE_INITIALIZED;
>  }
>  
> +static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
> +				     vm_flags_t flags)
> +{
> +	const bool uffd_wp = !!((vma->vm_flags | flags) & VM_UFFD_WP);

IIUC this can be "uffd_wp_changed" then switch "|" to "^".  But not a hot
path at all, so shouldn't matter a lot.

Thanks,

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

-- 
Peter Xu

