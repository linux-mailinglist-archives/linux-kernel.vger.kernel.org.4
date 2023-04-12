Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5562A6E00C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDLVWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDLVWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A7F618F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5726763701
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E298C433D2;
        Wed, 12 Apr 2023 21:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681334557;
        bh=WN6B+Av8pEy1O+KhHO/dvyN2eS48kNg9+OyF/O1E9/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YPt4R3mLLZD3RbAUT9snWiFqH+yXsyKbg8vcMNGGraLoQEYqKm48sBWi3NELbakCp
         H39V0qlunc5h73qj5o2EqOM6erqeuf6X4/fFThQp/NEsmW5A4cNqwe6C3MU/NmSqCN
         vcEilj6aVThQLFth+atvKFoeTiDWRHV9LWtJ7fcU=
Date:   Wed, 12 Apr 2023 14:22:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "buddy.zhang" <buddy.zhang@biscuitos.cn>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Venkatesh Pallipadi <venki@google.com>,
        Suresh Siddha <sbsiddha@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>
Subject: Re: [PATCH] mm: Keep memory type same on DEVMEM Page-Fault
Message-Id: <20230412142236.407d6d0e6d90232da004980e@linux-foundation.org>
In-Reply-To: <20230319033750.475200-1-buddy.zhang@biscuitos.cn>
References: <20230319033750.475200-1-buddy.zhang@biscuitos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2023 11:37:50 +0800 "buddy.zhang" <buddy.zhang@biscuitos.cn> wrote:

> On X86 architecture, supports memory type on Page-table, such as
> PTE is PAT/PCD/PWD, which can setup up Memory Type as WC/WB/WT/UC etc.
> Then, Virtual address from userspace or kernel space can map to
> same physical page, if each page table has different memory type,
> then it's confused to have more memory type for same physical page.

Thanks.  Nobody has worked on this code for a long time.  I'll cc a few
folks who may be able to comment.


> On DEVMEM, the 'remap_pfn_range()' keep memory type same on different
> mapping. But if it happen on Page-Fault route, such as code:
> 
>  19 static vm_fault_t vm_fault(struct vm_fault *vmf)
>  20 {
>  21         struct vm_area_struct *vma = vmf->vma;
>  22         unsigned long address = vmf->address;
>  23         struct page *fault_page;
>  24         unsigned long pfn;
>  25         int r;
>  26
>  27         /* Allocate Page as DEVMEM */
>  28         fault_page = alloc_page(GFP_KERNEL);
>  29         if (!fault_page) {
>  30                 printk("ERROR: NO Free Memory from DEVMEM.\n");
>  31                 r = -ENOMEM;
>  32                 goto err_alloc;
>  33         }
>  34         pfn = page_to_pfn(fault_page);
>  35
>  36         /* Clear PAT Attribute */
>  37         pgprot_val(vma->vm_page_prot) &= ~(_PAGE_PCD | _PAGE_PWT | _PAGE_PAT);
>  38
>  39         /* Change Memory Type for Direct-Mapping Area */
>  40         arch_io_reserve_memtype_wc(PFN_PHYS(pfn), PAGE_SIZE);
>  41         pgprot_val(vma->vm_page_prot) |= cachemode2protval(_PAGE_CACHE_MODE_WT);
>  42
>  43         /* Establish pte and INC _mapcount for page */
>  44         vm_flags_set(vma, VM_MIXEDMAP);
>  45         if (vm_insert_page(vma, address, fault_page))
>  46                 return -EAGAIN;
>  47
>  48         /* Add refcount for page */
>  49         atomic_inc(&fault_page->_refcount);
>  50         /* bind fault page */
>  51         vmf->page = fault_page;
>  52
>  53         return 0;
>  54
>  55 err_alloc:
>  56         return r;
>  57 }
>  58
>  59 static const struct vm_operations_struct BiscuitOS_vm_ops = {
>  60         .fault  = vm_fault,
>  61 };
>  62
>  63 static int BiscuitOS_mmap(struct file *filp, struct vm_area_struct *vma)
>  64 {
>  65         /* setup vm_ops */
>  66         vma->vm_ops = &BiscuitOS_vm_ops;
>  67
>  68         return 0;
>  69 }
> 
> If invoke arch_io_reserve_memtype_wc() on Line-40, and modify memory type
> as WC for Direct-Mapping area, and then setup meory type as WT on Line-41,
> then invoke 'vm_insert_page()' to create mapping, so you can see:
> 
>     | <----- Usespace -----> | <- Kernel space -> |
> ----+------+---+-------------+---+---+------------+--
>     |      |   |             |   |   |            |
> ----+------+---+-------------+---+---+------------+--
>            WT|                     |WC
>              o-------o    o--------o
>                    WT|    |WC
>                      V    V
> -------------------+--------+------------------------
>                    | DEVMEM |
> -------------------+--------+------------------------
> Physical Address Space
> 
> For this case, OS should check memory type before mapping on 'vm_insert_page()',
> and keep memory type same, so add check on function:
> 
> 07 int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
> 08                         struct page *page)
> 09 {
> 10         if (addr < vma->vm_start || addr >= vma->vm_end)
> 11                 return -EFAULT;
> 12         if (!page_count(page))
> 13                 return -EINVAL;
> 14         if (!(vma->vm_flags & VM_MIXEDMAP)) {
> 15                 BUG_ON(mmap_read_trylock(vma->vm_mm));
> 16                 BUG_ON(vma->vm_flags & VM_PFNMAP);
> 17                 vm_flags_set(vma, VM_MIXEDMAP);
> 18         }
> 19         if (track_pfn_remap(vma, &vma->vm_page_prot,
> 20                         page_to_pfn(page), addr, PAGE_SIZE))
> 21                 return -EINVAL;
> 22         return insert_page(vma, addr, page, vma->vm_page_prot);
> 23 }
> 
> And line 19 to 21, when mapping different memory type on this route, the
> 'track_pfn_remap()' will notify error and change request as current, e.g.
> 
> x86/PAT: APP:88 map pfn RAM range req write-through for [mem 0x025c1000-0x025c1fff], got write-combining
> 
> And then, we can keep memory type same on Page-fault route for DEVMEM, the end:
> 
>     | <----- Usespace -----> | <- Kernel space -> |
> ----+------+---+-------------+---+---+------------+--
>     |      |   |             |   |   |            |
> ----+------+---+-------------+---+---+------------+--
>            WT|                     |WC
>              o---(X)----o----------o
>                         |WC
>                         V
> -------------------+--------+------------------------
>                    | DEVMEM |
> -------------------+--------+------------------------
> 
> Signed-off-by: buddy.zhang@biscuitos.cn
> ---
>  mm/memory.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index f456f3b5049c..ed3d09f513f1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1989,6 +1989,9 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
>  		BUG_ON(vma->vm_flags & VM_PFNMAP);
>  		vm_flags_set(vma, VM_MIXEDMAP);
>  	}
> +	if (track_pfn_remap(vma, &vma->vm_page_prot,
> +			page_to_pfn(page), addr, PAGE_SIZE))
> +		return -EINVAL;
>  	return insert_page(vma, addr, page, vma->vm_page_prot);
>  }
>  EXPORT_SYMBOL(vm_insert_page);
> -- 
> 2.25.1
> 
