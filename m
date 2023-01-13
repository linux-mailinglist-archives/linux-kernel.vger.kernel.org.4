Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC9B66A133
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjAMRxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjAMRwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:52:50 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C38C6A0E2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:45:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t5so17353254wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/kSqQ6YcRONQCtDyj+7ZKGaUqhU9y1G8JYQBRsHxA2k=;
        b=GikslCbEjXTgFKOq/ceYaBI1hlh2b4JYNmsvXY2vtIxgf70SqDGvcgGOuXmhvlrawT
         KQPeOqXtiyaYvDC4fftdI2rakWBcy0K9esV8juhwAuo6H5pY4n/IRb9eNZlWKnXDzwCU
         iTOmyXUxgtodFuqVgYwOoPB1/qzCGdGIzbXWaxAm2/nbmQZh2Ry5Q8KjwYz/rjaKp7CA
         Wr058av2NQh+ae5+Gyg9qXOOLPG/jChyS3lunHAKmOKnOzmc6oxO94AOxu2Q9IEfnt9d
         AnuIt79W856K2vCKALCJpRUiv9GryK4aP+XIh1z1L4Fb5m0M8++T8Y4VkY58f6KuHYNw
         D9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kSqQ6YcRONQCtDyj+7ZKGaUqhU9y1G8JYQBRsHxA2k=;
        b=tMm25U7CtoCbSLeh//DLeCZUuXO1XX1p5JHQi6KaKHXMIrb6Zqvcbt6iYVU5S/B/4k
         z7bEo4oonyTIZlCTV9UxVgOVETLkQZHanHJ4tglBPFJaQ1V99xtAJJ+BqL7/FOkmz4wK
         gT9WFL9DByzusBaO7bw/xS1DGFIpJ1WNuz2XlBn0h9pJ6u7Rsnw+nH7jXgC3WoikTUrA
         dK8zJqAvXaN4a7JpwxTyy3gC8vGZPcOZZnM11IE1xrQJKUlRL562q7RtKOoIfbtd0T25
         CEnwSLOhB89jtnui1t5/icstK84wj6cHtAtCZmB6hPwNa7WbCiS+07C+Qd095WhfCzx7
         CSXg==
X-Gm-Message-State: AFqh2ko5/skHy1cQYabSJrbkfGWcpvurRFubqfCpbY47LBeNW7vY8Jg4
        zJNo5yjP1oTEHN03IMjJUzC9pxzA9c3BtAgkGtM=
X-Google-Smtp-Source: AMrXdXslJ0jIot6r9qIiBIbLMk9qBLCXZfSFrbybfXJqUSDa2Eb7XqSMq/RF2Mui9k+87L40lmB59Q==
X-Received: by 2002:a5d:630d:0:b0:2ac:5b46:9c85 with SMTP id i13-20020a5d630d000000b002ac5b469c85mr21795422wru.68.1673631953771;
        Fri, 13 Jan 2023 09:45:53 -0800 (PST)
Received: from wychelm (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f3-20020adfdb43000000b00236883f2f5csm19788512wrj.94.2023.01.13.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:45:53 -0800 (PST)
Date:   Fri, 13 Jan 2023 17:45:51 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 5/7] mm: memory: convert wp_page_copy() to use
 folios
Message-ID: <Y8GYz4xIDJxC7sKS@wychelm>
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
 <20230112083006.163393-6-wangkefeng.wang@huawei.com>
 <CGME20230113130136eucas1p18a54a3812792e500a02079ee890e5ecb@eucas1p1.samsung.com>
 <32fefce6-e25d-106d-12ec-8fc612843cfb@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32fefce6-e25d-106d-12ec-8fc612843cfb@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 02:01:36PM +0100, Marek Szyprowski wrote:
> Hi
>
> On 12.01.2023 09:30, Kefeng Wang wrote:
> > The old_page/new_page are converted to old_folio/new_folio in
> > wp_page_copy(), then replaced related page functions to folio
> > functions.
> >
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>
> This patch, merged into today's linux-next as commit 9ebae00c8e30 ("mm:
> memory: convert wp_page_copy() to use folios"), causes serious stability
> issues on my ARM based test boards.

I'm seeing something very similar[1] and it bisected down to this patch.

FWIW it reproduces for me using an ARCH=arm64 defconfig kernel and
with the following QEMU invocation:

    qemu-system-aarch64 \
        -M virt -cpu cortex-a57 -nographic \
        -kernel arch/arm64/boot/Image -initrd rootfs.cpio.gz

The rootfs I used for reproduction is here:
https://fileserver.linaro.org/s/AKcrKWB2Jtyzo6g


Daniel.


[1]:
[    1.740416] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
[    1.740898] Mem abort info:
[    1.741067]   ESR = 0x0000000096000006
[    1.741291]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.741557]   SET = 0, FnV = 0
[    1.741734]   EA = 0, S1PTW = 0
[    1.741910]   FSC = 0x06: level 2 translation fault
[    1.742161] Data abort info:
[    1.742328]   ISV = 0, ISS = 0x00000006
[    1.742533]   CM = 0, WnR = 0
[    1.742729] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000447ff000
[    1.743041] [0000000000000008] pgd=0800000044819003, p4d=0800000044819003, pud=080000004481a003, pmd=0000000000000000
[    1.743819] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[    1.744118] Modules linked in:
[    1.744353] CPU: 0 PID: 44 Comm: modprobe Not tainted 6.2.0-rc3-00294-g9ebae00c8e30 #244
[    1.744617] Hardware name: linux,dummy-virt (DT)
[    1.744848] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.745045] pc : do_wp_page+0x2c4/0xd40
[    1.745218] lr : do_wp_page+0x2bc/0xd40
[    1.745318] sp : ffff80000822bc10
[    1.745415] x29: ffff80000822bc10 x28: ffff60710459b100 x27: 0000000000000002
[    1.745633] x26: ffff80000822bd28 x25: ffff607103b18000 x24: 0000000200100073
[    1.745815] x23: ffff607104811ff0 x22: ffffc6250d418000 x21: 0000000000000000
[    1.745986] x20: ffff607104810360 x19: ffff607104810360 x18: 0000000000000001
[    1.746171] x17: ffff9a4bfa8fa000 x16: ffff800008004000 x15: 0000000000000000
[    1.746363] x14: 000000000000a8a9 x13: 0000000000000004 x12: 0000000000000026
[    1.746548] x11: 0000000000000001 x10: 0000000000000000 x9 : ffffc6250e9e7000
[    1.746756] x8 : ffff60710459b100 x7 : 00000000412a6223 x6 : 0000000000000000
[    1.746928] x5 : 0000000000042cc5 x4 : 0000ffff9acb8000 x3 : ffff80000822bbe4
[    1.747095] x2 : ffff9a4bfa8fa000 x1 : ffff60710459b100 x0 : 0000000100000000
[    1.747341] Call trace:
[    1.747431]  do_wp_page+0x2c4/0xd40
[    1.747547]  __handle_mm_fault+0x704/0x1124
[    1.747649]  handle_mm_fault+0xe4/0x25c
[    1.747736]  do_page_fault+0x1e8/0x4c0
[    1.747834]  do_mem_abort+0x44/0x9c
[    1.747934]  el0_da+0x60/0xd4
[    1.748020]  el0t_64_sync_handler+0xac/0x120
[    1.748134]  el0t_64_sync+0x190/0x194
[    1.748388] Code: f9403340 943cc31e f9402b55 f9400354 (f94006b6)
[    1.748767] ---[ end trace 0000000000000000 ]---


>
> VFS: Mounted root (ext4 filesystem) readonly on device 179:6.
> devtmpfs: mounted
> Freeing unused kernel image (initmem) memory: 1024K
> Run /sbin/init as init process
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000004 when read
> [00000004] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: init Not tainted 6.2.0-rc3-00294-g9ebae00c8e30 #13254
> Hardware name: Samsung Exynos (Flattened Device Tree)
> PC is at do_wp_page+0x21c/0xd48
> LR is at do_wp_page+0x1f8/0xd48
> pc : [<c02aa518>]    lr : [<c02aa4f4>]    psr: 60000113
> sp : f082de58  ip : 0006fff8  fp : 0000065f
> r10: 00000000  r9 : 00000c73  r8 : c2b87318
> r7 : c1d78000  r6 : b6ed9000  r5 : 00000000  r4 : f082dedc
> r3 : c25d0000  r2 : 00000001  r1 : c0ee9568  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 4363804a  DAC: 00000051
> Register r0 information: NULL pointer
> Register r1 information: non-slab/vmalloc memory
> Register r2 information: non-paged memory
> Register r3 information: slab mm_struct start c25d0000 pointer offset 0
> size 908
> Register r4 information: 2-page vmalloc region starting at 0xf082c000
> allocated at kernel_clone+0x54/0x3e4
> Register r5 information: NULL pointer
> Register r6 information: non-paged memory
> Register r7 information: slab task_struct start c1d78000 pointer offset
> 0 size 4032
> Register r8 information: slab vm_area_struct start c2b87318 pointer
> offset 0 size 68
> Register r9 information: non-paged memory
> Register r10 information: NULL pointer
> Register r11 information: non-paged memory
> Register r12 information: non-paged memory
> Process init (pid: 1, stack limit = 0x(ptrval))
> Stack: (0xf082de58 to 0xf082e000)
> ...
>   do_wp_page from handle_mm_fault+0x938/0xda8
>   handle_mm_fault from do_page_fault+0x154/0x408
>   do_page_fault from do_DataAbort+0x3c/0xb0
>   do_DataAbort from __dabt_usr+0x58/0x60
> Exception stack(0xf082dfb0 to 0xf082dff8)
> dfa0:                                     00000000 00000001 b6ed9060
> 00000000
> dfc0: 00000000 b6fea968 b6ed9060 00000000 b6cd4888 00000000 00000000
> 00000000
> dfe0: b6eda28c be8a9dd0 b6e6ff08 ffff0fcc 60000010 ffffffff
> Code: e594a028 e58d301c e5983008 e58d3014 (e59a3004)
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> CPU1: stopping
> CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D
> 6.2.0-rc3-00294-g9ebae00c8e30 #13254
> Hardware name: Samsung Exynos (Flattened Device Tree)
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x58/0x70
>   dump_stack_lvl from do_handle_IPI+0x348/0x374
>   do_handle_IPI from ipi_handler+0x18/0x20
>   ipi_handler from handle_percpu_devid_irq+0x9c/0x170
>   handle_percpu_devid_irq from generic_handle_domain_irq+0x24/0x34
>   generic_handle_domain_irq from gic_handle_irq+0x88/0xa8
>   gic_handle_irq from generic_handle_arch_irq+0x58/0x78
>   generic_handle_arch_irq from call_with_stack+0x18/0x20
>   call_with_stack from __irq_svc+0x9c/0xd0
> Exception stack(0xf08a9ee0 to 0xf08a9f28)
> ...
>   __irq_svc from cpuidle_enter_state+0x318/0x3d0
>   cpuidle_enter_state from cpuidle_enter_state_coupled+0x160/0x400
>   cpuidle_enter_state_coupled from cpuidle_enter+0x3c/0x54
>   cpuidle_enter from do_idle+0x1f0/0x2b0
>   do_idle from cpu_startup_entry+0x18/0x1c
>   cpu_startup_entry from secondary_start_kernel+0x1a0/0x230
>   secondary_start_kernel from 0x40101a00
> ---[ end Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b ]---
>
> Reverting it on top of linux-next 20220113 together with aaf3f7afbf10
> ("mm: swap: remove unneeded cgroup_throttle_swaprate()") fixes the
> stability issues.
>
>
> > ---
> >   mm/memory.c | 47 +++++++++++++++++++++++++----------------------
> >   1 file changed, 25 insertions(+), 22 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index b66c425b4d7c..746f485366e8 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3044,7 +3044,9 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >   	struct vm_area_struct *vma = vmf->vma;
> >   	struct mm_struct *mm = vma->vm_mm;
> >   	struct page *old_page = vmf->page;
> > +	struct folio *old_folio = page_folio(old_page);
> >   	struct page *new_page = NULL;
> > +	struct folio *new_folio = NULL;
> >   	pte_t entry;
> >   	int page_copied = 0;
> >   	struct mmu_notifier_range range;
> > @@ -3060,12 +3062,13 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >   							      vmf->address);
> >   		if (!new_page)
> >   			goto oom;
> > +		new_folio = page_folio(new_page);
> >   	} else {
> > -		new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
> > -				vmf->address);
> > -		if (!new_page)
> > +		new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma,
> > +					    vmf->address, false);
> > +		if (!new_folio)
> >   			goto oom;
> > -
> > +		new_page = &new_folio->page;
> >   		ret = __wp_page_copy_user(new_page, old_page, vmf);
> >   		if (ret) {
> >   			/*
> > @@ -3075,9 +3078,9 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >   			 * from the second attempt.
> >   			 * The -EHWPOISON case will not be retried.
> >   			 */
> > -			put_page(new_page);
> > -			if (old_page)
> > -				put_page(old_page);
> > +			folio_put(new_folio);
> > +			if (old_folio)
> > +				folio_put(old_folio);
> >
> >   			delayacct_wpcopy_end();
> >   			return ret == -EHWPOISON ? VM_FAULT_HWPOISON : 0;
> > @@ -3085,11 +3088,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >   		kmsan_copy_page_meta(new_page, old_page);
> >   	}
> >
> > -	if (mem_cgroup_charge(page_folio(new_page), mm, GFP_KERNEL))
> > +	if (mem_cgroup_charge(new_folio, mm, GFP_KERNEL))
> >   		goto oom_free_new;
> > -	cgroup_throttle_swaprate(new_page, GFP_KERNEL);
> > +	folio_throttle_swaprate(new_folio, GFP_KERNEL);
> >
> > -	__SetPageUptodate(new_page);
> > +	__folio_mark_uptodate(new_folio);
> >
> >   	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
> >   				vmf->address & PAGE_MASK,
> > @@ -3101,8 +3104,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >   	 */
> >   	vmf->pte = pte_offset_map_lock(mm, vmf->pmd, vmf->address, &vmf->ptl);
> >   	if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
> > -		if (old_page) {
> > -			if (!PageAnon(old_page)) {
> > +		if (old_folio) {
> > +			if (!folio_test_anon(old_folio)) {
> >   				dec_mm_counter(mm, mm_counter_file(old_page));
> >   				inc_mm_counter(mm, MM_ANONPAGES);
> >   			}
> > @@ -3130,7 +3133,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >   		 */
> >   		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
> >   		page_add_new_anon_rmap(new_page, vma, vmf->address);
> > -		lru_cache_add_inactive_or_unevictable(new_page, vma);
> > +		folio_add_lru_vma(new_folio, vma);
> >   		/*
> >   		 * We call the notify macro here because, when using secondary
> >   		 * mmu page tables (such as kvm shadow page tables), we want the
> > @@ -3139,7 +3142,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >   		BUG_ON(unshare && pte_write(entry));
> >   		set_pte_at_notify(mm, vmf->address, vmf->pte, entry);
> >   		update_mmu_cache(vma, vmf->address, vmf->pte);
> > -		if (old_page) {
> > +		if (old_folio) {
> >   			/*
> >   			 * Only after switching the pte to the new page may
> >   			 * we remove the mapcount here. Otherwise another
> > @@ -3166,14 +3169,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >   		}
> >
> >   		/* Free the old page.. */
> > -		new_page = old_page;
> > +		new_folio = old_folio;
> >   		page_copied = 1;
> >   	} else {
> >   		update_mmu_tlb(vma, vmf->address, vmf->pte);
> >   	}
> >
> > -	if (new_page)
> > -		put_page(new_page);
> > +	if (new_folio)
> > +		folio_put(new_folio);
> >
> >   	pte_unmap_unlock(vmf->pte, vmf->ptl);
> >   	/*
> > @@ -3181,19 +3184,19 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >   	 * the above ptep_clear_flush_notify() did already call it.
> >   	 */
> >   	mmu_notifier_invalidate_range_only_end(&range);
> > -	if (old_page) {
> > +	if (old_folio) {
> >   		if (page_copied)
> >   			free_swap_cache(old_page);
> > -		put_page(old_page);
> > +		folio_put(old_folio);
> >   	}
> >
> >   	delayacct_wpcopy_end();
> >   	return 0;
> >   oom_free_new:
> > -	put_page(new_page);
> > +	folio_put(new_folio);
> >   oom:
> > -	if (old_page)
> > -		put_page(old_page);
> > +	if (old_folio)
> > +		folio_put(old_folio);
> >
> >   	delayacct_wpcopy_end();
> >   	return VM_FAULT_OOM;
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
