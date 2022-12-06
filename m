Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9518F644E64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 23:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLFWNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 17:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLFWNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:13:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3A7442DF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 14:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670364740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LYBl+w0D7kkdE8z/hd0+r938230knOl6eFwESxQXZpE=;
        b=emzfN7cAtRrRO+8FouDQW1ubvU6gQiZ5l/suF64La7FrLI1d8o3ZThnVRCHzseeTk5FNvW
        UrvafhCqXAo8xHgFJDQMOBAk/6B3FJTePq4ak1hfrYqfSIZwLRhoH2LugYZBfmjbltEUFG
        EmaJUAYXZ6SViGwj2ketwICrd8fUMOY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-100-6rvNU3eaNPOQJoOFQQV-Rw-1; Tue, 06 Dec 2022 17:12:19 -0500
X-MC-Unique: 6rvNU3eaNPOQJoOFQQV-Rw-1
Received: by mail-qk1-f200.google.com with SMTP id bm39-20020a05620a19a700b006fca217dc54so22762533qkb.16
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 14:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYBl+w0D7kkdE8z/hd0+r938230knOl6eFwESxQXZpE=;
        b=s4wlObOiknjKj+YDFUssYUOV/pJjlXD8KwICzSJRHLgNYxCjYKs1x/9SH1Auim4XX9
         HFaIW4iFn9/dOpo+paBESsMEkVTAjMmMkUd5cgAmsUiCCyrAGBLLPW3iFUBfcYdLhvuU
         bWyFTo6KJQUGWy2y+XplAoQloL7D5DG/3P155BkRLq34HWlm2lLKRYTpP+mpJXXKrnqX
         MXk8/O/l6RsZjJqjlfddm+HgU30ou1UnMRikLcDENJSVSVEfrwDefd1M2QmcttKVAxaV
         +dsEOwJBNj4W/E9FZHCwtTUq1iocyOK7CBHv+E97i1XnJp2BvOLZb7ELY02aV04JetlJ
         EEag==
X-Gm-Message-State: ANoB5plIlws/l83WDblGUhkt6aI1noV3k4XjhqtBrzNV+lKJ0ql2Z9Zw
        mhF9KqE7dt1WOxIBwPCVI6TVm4hceyJ7sKvF7+oY4S7z3yrtTvbfzXUTCPLxTbTbQ3JLQ2O1MzM
        PL/K1NZuq56H01zb1u6iIG3qU
X-Received: by 2002:ac8:4d05:0:b0:39c:da1f:f812 with SMTP id w5-20020ac84d05000000b0039cda1ff812mr484655qtv.56.1670364738480;
        Tue, 06 Dec 2022 14:12:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4YlqYNltlMNtMzJevezuBR8bf31zik2A9gBfw4SW3XashyqOsHEckOuFStPSx5kxkkbMFy8w==
X-Received: by 2002:ac8:4d05:0:b0:39c:da1f:f812 with SMTP id w5-20020ac84d05000000b0039cda1ff812mr484647qtv.56.1670364738122;
        Tue, 06 Dec 2022 14:12:18 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id n16-20020ac86750000000b003a50248b89esm12196260qtp.26.2022.12.06.14.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 14:12:17 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:12:16 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v2] mm/swap: fix SWP_PFN_BITS with
 CONFIG_PHYS_ADDR_T_64BIT on 32bit
Message-ID: <Y4++QNzYx1CE1ayY@x1n>
References: <20221206105737.69478-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221206105737.69478-1-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 11:57:37AM +0100, David Hildenbrand wrote:
> We use "unsigned long" to store a PFN in the kernel and phys_addr_t to
> store a physical address.
> 
> On a 64bit system, both are 64bit wide. However, on a 32bit system, the
> latter might be 64bit wide. This is, for example, the case on x86 with
> PAE: phys_addr_t and PTEs are 64bit wide, while "unsigned long" only
> spans 32bit.
> 
> The current definition of SWP_PFN_BITS without MAX_PHYSMEM_BITS misses
> that case, and assumes that the maximum PFN is limited by an 32bit
> phys_addr_t. This implies, that SWP_PFN_BITS will currently only be able to
> cover 4 GiB - 1 on any 32bit system with 4k page size, which is wrong.
> 
> Let's rely on the number of bits in phys_addr_t instead, but make sure to
> not exceed the maximum swap offset, to not make the  BUILD_BUG_ON() in
> is_pfn_swap_entry() unhappy. Note that swp_entry_t is effectively an
> unsigned long and the maximum swap offset shares that value with the
> swap type.
> 
> For example, on an 8 GiB x86 PAE system with a kernel config based on
> Debian 11.5 (-> CONFIG_FLATMEM=y, CONFIG_X86_PAE=y), we will currently fail
> removing migration entries (remove_migration_ptes()), because
> mm/page_vma_mapped.c:check_pte() will fail to identify a PFN match as
> swp_offset_pfn() wrongly masks off PFN bits. For example,
> split_huge_page_to_list()->...->remap_page() will leave migration
> entries in place and continue to unlock the page.
> 
> Later, when we stumble over these migration entries (e.g., via
> /proc/self/pagemap), pfn_swap_entry_to_page() will BUG_ON() because
> these migration entries shouldn't exist anymore and the page was
> unlocked.
> 
> [   33.067591] kernel BUG at include/linux/swapops.h:497!
> [   33.067597] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   33.067602] CPU: 3 PID: 742 Comm: cow Tainted: G            E      6.1.0-rc8+ #16
> [   33.067605] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
> [   33.067606] EIP: pagemap_pmd_range+0x644/0x650
> [   33.067612] Code: 00 00 00 00 66 90 89 ce b9 00 f0 ff ff e9 ff fb ff ff 89 d8 31 db e8 48 c6 52 00 e9 23 fb ff ff e8 61 83 56 00 e9 b6 fe ff ff <0f> 0b bf 00 f0 ff ff e9 38 fa ff ff 3e 8d 74 26 00 55 89 e5 57 31
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
> Decrease the indentation level of SWP_PFN_BITS and SWP_PFN_MASK to keep
> it readable and consistent.
> 
> Fixes: 0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v1 -> v2:
> * Rely on sizeof(phys_addr_t) and min_t() instead.
> * Survives my various cross compilations and testing on x86 PAE.

Good to know it works, thanks a lot.

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

