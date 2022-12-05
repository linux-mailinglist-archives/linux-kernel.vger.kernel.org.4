Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E7E6437F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiLEWXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLEWXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:23:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EC1E55
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670278911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xfuY/rftNe12LtQECmQkDZxRLOhvVmVx/6clwTxrx+Y=;
        b=Q047k2sRQDCjiVTkpa7iX9oE8AKMQBxb2bpfEwnKfVblzMmEbqJuH1C+QUCyhg0OAp0/cy
        PYQvwch3Z9rmm6A+V52ARax4HlVsm3FkjoivRBWZgtH0UwF7toY0dhke9YWU6iulOnElKR
        mggVq2vPNtiZya+jijJe1wPex4fO7X4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-2NGhGDFDO4KcSLSEbrS1CA-1; Mon, 05 Dec 2022 17:21:49 -0500
X-MC-Unique: 2NGhGDFDO4KcSLSEbrS1CA-1
Received: by mail-qk1-f199.google.com with SMTP id f13-20020a05620a408d00b006fc740f837eso19145226qko.20
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 14:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfuY/rftNe12LtQECmQkDZxRLOhvVmVx/6clwTxrx+Y=;
        b=VgcrUjDOk8JxQpiCID+2Sngn1tZUpGb5CmpGvN+y25zA5rrlzHbCiliOnzNPvR8Wem
         bus8oqpSZwSVlr98a61E+4kxKzI2bLFzDjBEJIQ9idUqaujc0HrO3KYIYu8ZKbT78DG+
         /12SE0NqDojUbi2i/xRjIqu9rXtcM2LrKfOSzR7kht2usGIsx43gk6TvjAeBcfzOVA4M
         kvgT8eKYp0R6UpfMFibtOUV9B79XRyhiZAJgDE0LWkWE1zUOnRtJSrkBM5XcfNGNtmG9
         XN6P2IithLwj54Qna6lGSYZdVDeXC4Z4WLvQ0eHdn+bzAnNkctNBWF2YUaD854xzYiSx
         jTFA==
X-Gm-Message-State: ANoB5pkC5nOQbzSw93Ht7Z6rNKQTLWyXlfR0Cs512VDGOjSt1bwI54J/
        pZh7TSoRTjJb3mLtJMqvjs6hbPrSCEzlyD9HsjEu10kCEnlQoLNbCsOXNWCFp+ddf8nv/ohAn9K
        B6u2HN6AkPTjgCgR0S7Cnrv1/
X-Received: by 2002:a05:6214:87:b0:4c6:9068:140c with SMTP id n7-20020a056214008700b004c69068140cmr19239844qvr.69.1670278909093;
        Mon, 05 Dec 2022 14:21:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4aKpyCwst6MnI3xhHA5hmk7opswlzxFx6usMu37ZCFLQnIOH3aQG7ORASOLZTPIok+Bgs/PA==
X-Received: by 2002:a05:6214:87:b0:4c6:9068:140c with SMTP id n7-20020a056214008700b004c69068140cmr19239829qvr.69.1670278908826;
        Mon, 05 Dec 2022 14:21:48 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id d16-20020a05620a241000b006fa43e139b5sm4991915qkn.59.2022.12.05.14.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:21:48 -0800 (PST)
Date:   Mon, 5 Dec 2022 17:21:47 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v1] mm/swap: fix SWP_PFN_BITS with
 CONFIG_PHYS_ADDR_T_64BIT on 32bit
Message-ID: <Y45u+0c4Hu2snEO2@x1n>
References: <20221205150857.167583-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221205150857.167583-1-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 04:08:57PM +0100, David Hildenbrand wrote:
> We use "unsigned long" to store a PFN in the kernel and phys_addr_t to
> store a physical address.
> 
> On a 64bit system, both are 64bit wide. However, on a 32bit system, the
> latter might be 64bit wide. This is, for example, the case on x86 with
> PAE: phys_addr_t and PTEs are 64bit wide, while "unsigned long" only
> spans 32bit.
> 
> The current definition of SWP_PFN_BITS without MAX_PHYSMEM_BITS misses
> that case, and assumes that the maximum PFN is limited by a 32bit
> phys_addr_t. This implies, that SWP_PFN_BITS will currently only be able to
> cover 4 GiB - 1 on any 32bit system, which is wrong. We can end up
> masking off valid PFN bits from the swap offset.
> 
> Ideally, we'd use something like "sizeof(phys_addr_t) * 8 - PAGE_SHIFT",
> however, we might exceed SWP_TYPE_SHIFT and make the BUILD_BUG_ON() in
> is_pfn_swap_entry() unhappy. Note that swp_entry_t is effectively an
> unsigned long.
> 
> Consequently, simply rely on SWP_TYPE_SHIFT in case we're on 32bit and
> CONFIG_PHYS_ADDR_T_64BIT is defined.
> 
> For example, on an 8 GiB x86 PAE system, we currently fail removing
> migration entries (remove_migration_ptes()) that target PFNs above
> 4 GiB, because mm/page_vma_mapped.c:check_pte() will fail to identify a
> PFN match as swp_offset_pfn() wrongly masks off valid PFN bits.
> 
> With THP, split_huge_page_to_list()->...->remap_page() will leave migration
> entries in place and continue to unlock the page, which is wrong. Later,
> when we stumble over these migration entries (e.g., via
> /proc/self/pagemap), pfn_swap_entry_to_page() will BUG_ON() because these
> migration entries shouldn't exist anymore and the page was unlocked.
> 
> [   33.067591] kernel BUG at include/linux/swapops.h:497!
> [   33.067597] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   33.067602] CPU: 3 PID: 742 Comm: cow Tainted: G            E      6.1.0-rc8+ #16
> [   33.067605] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
> [   33.067606] EIP: pagemap_pmd_range+0x644/0x650
> [   33.067612] Code: 00 00 00 00 66 90 89 ce b9 00 f0 ff ff e9 ff fb ...
> [   33.067615] EAX: ee394000 EBX: 00000002 ECX: ee394000 EDX: 00000000
> [   33.067617] ESI: c1b0ded4 EDI: 00024a00 EBP: c1b0ddb4 ESP: c1b0dd68
> [   33.067619] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
> [   33.067624] CR0: 80050033 CR2: b7a00000 CR3: 01bbbd20 CR4: 00350ef0
> [   33.067625] Call Trace:
> [   33.067628]  ? madvise_free_pte_range+0x720/0x720
> [   33.067632]  ? smaps_pte_range+0x4b0/0x4b0
> [   33.067634]  walk_pgd_range+0x325/0x720
> [   33.067637]  ? mt_find+0x1d6/0x3a0
> [   33.067641]  ? mt_find+0x1d6/0x3a0
> [   33.067643]  __walk_page_range+0x164/0x170
> [   33.067646]  walk_page_range+0xf9/0x170
> [   33.067648]  ? __kmem_cache_alloc_node+0x2a8/0x340
> [   33.067653]  pagemap_read+0x124/0x280
> [   33.067658]  ? default_llseek+0x101/0x160
> [   33.067662]  ? smaps_account+0x1d0/0x1d0
> [   33.067664]  vfs_read+0x90/0x290
> [   33.067667]  ? do_madvise.part.0+0x24b/0x390
> [   33.067669]  ? debug_smp_processor_id+0x12/0x20
> [   33.067673]  ksys_pread64+0x58/0x90
> [   33.067675]  __ia32_sys_ia32_pread64+0x1b/0x20
> [   33.067680]  __do_fast_syscall_32+0x4c/0xc0
> [   33.067683]  do_fast_syscall_32+0x29/0x60
> [   33.067686]  do_SYSENTER_32+0x15/0x20
> [   33.067689]  entry_SYSENTER_32+0x98/0xf1
> 
> Fixes: 0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Thanks for debugging this one.

> ---
> 
> This makes my x86 PAE case work as expected again. Only cross compiled
> on other architectures.

IIUC it's not about PAE but !SPARSEMEM, as PAE actually has it defined when
with sparsemem:

#ifdef CONFIG_X86_32
# ifdef CONFIG_X86_PAE
#  define SECTION_SIZE_BITS	29
#  define MAX_PHYSMEM_BITS	36
# else
#  define SECTION_SIZE_BITS	26
#  define MAX_PHYSMEM_BITS	32
# endif
#else /* CONFIG_X86_32 */
# define SECTION_SIZE_BITS	27 /* matt - 128 is convenient right now */
# define MAX_PHYSMEM_BITS	(pgtable_l5_enabled() ? 52 : 46)
#endif

One trivial comment below.

> 
> ---
>  include/linux/swapops.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 86b95ccb81bb..4bb7a20f3fa5 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -32,11 +32,13 @@
>   * store PFN, we only need SWP_PFN_BITS bits.  Each of the pfn swap entries
>   * can use the extra bits to store other information besides PFN.
>   */
> -#ifdef MAX_PHYSMEM_BITS
> +#if defined(MAX_PHYSMEM_BITS)
>  #define SWP_PFN_BITS			(MAX_PHYSMEM_BITS - PAGE_SHIFT)
> -#else  /* MAX_PHYSMEM_BITS */
> +#elif !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)
> +#define SWP_PFN_BITS			SWP_TYPE_SHIFT

Can we add a comment showing where SWP_TYPE_SHIFT comes from?  It should be
a min value comes from either the limitation of phys address width, or from
definition of swp_entry_t (which is unsigned long).

Or I'd rather make this then the code explains better on itself, and the
change should be smaller too:

 #ifdef MAX_PHYSMEM_BITS           
 #define SWP_PFN_BITS                   (MAX_PHYSMEM_BITS - PAGE_SHIFT)
 #else  /* MAX_PHYSMEM_BITS */
-#define SWP_PFN_BITS                   (BITS_PER_LONG - PAGE_SHIFT)
+#define SWP_PFN_BITS                   MIN((sizeof(phys_addr_t) * 8) - \
+                                           PAGE_SHIFT, SWP_TYPE_SHIFT)
 #endif /* MAX_PHYSMEM_BITS */  
 #define SWP_PFN_MASK                   (BIT(SWP_PFN_BITS) - 1)
                                 
What do you think?

> +#else
>  #define SWP_PFN_BITS			(BITS_PER_LONG - PAGE_SHIFT)
> -#endif	/* MAX_PHYSMEM_BITS */
> +#endif	/* defined(MAX_PHYSMEM_BITS) */
>  #define SWP_PFN_MASK			(BIT(SWP_PFN_BITS) - 1)
>  
>  /**
> 
> base-commit: 76dcd734eca23168cb008912c0f69ff408905235
> -- 
> 2.38.1
> 

-- 
Peter Xu

