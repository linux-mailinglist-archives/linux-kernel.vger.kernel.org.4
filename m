Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A900D669824
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241244AbjAMNOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbjAMNNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:13:43 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C778287921
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:01:40 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230113130137euoutp01a0d0482306b8fa0616ce3b6eaf383b30~53_HRiBUX1250312503euoutp016
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:01:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230113130137euoutp01a0d0482306b8fa0616ce3b6eaf383b30~53_HRiBUX1250312503euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673614897;
        bh=XesuYYbvDne9sHwgZgBFCuRAu/NKPd+THoBcu+bZlO8=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=MwU4Bz5ijQ728lwzPKVncVGiMG0wvRljQduSrxeptzT5mdWSNGygBAHONAijGJpyh
         DSy/7cvhLHvjfeL/Jgbd5taHOdcpB+AnZbsDpNkKFj4SES0sBQmX1bTuiPlCSiKyGi
         QgDoF9wLb03vr/wjKKX7KD6eWVhm71qIxnSt+N+k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230113130137eucas1p1df12fcf2c2c3e5af9a02493acba4a917~53_HFo8LA1788117881eucas1p1a;
        Fri, 13 Jan 2023 13:01:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DE.15.43884.13651C36; Fri, 13
        Jan 2023 13:01:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230113130136eucas1p18a54a3812792e500a02079ee890e5ecb~53_GudjoW2323023230eucas1p1B;
        Fri, 13 Jan 2023 13:01:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230113130136eusmtrp1fd9d1a07fc2258d23541ae71d4cc5c05~53_Gt4zPd1697916979eusmtrp1_;
        Fri, 13 Jan 2023 13:01:36 +0000 (GMT)
X-AuditID: cbfec7f5-271ff7000000ab6c-a4-63c1563194c8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C4.DD.52424.03651C36; Fri, 13
        Jan 2023 13:01:36 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230113130136eusmtip1b5c32aeb93a6c87836412fc03e67a763~53_GUNQ6V0717107171eusmtip15;
        Fri, 13 Jan 2023 13:01:36 +0000 (GMT)
Message-ID: <32fefce6-e25d-106d-12ec-8fc612843cfb@samsung.com>
Date:   Fri, 13 Jan 2023 14:01:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH -next 5/7] mm: memory: convert wp_page_copy() to use
 folios
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230112083006.163393-6-wangkefeng.wang@huawei.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRDN192tW7S4FLQTMGhqIIJabDxSlaB41niiRhONYC0roLSYLfXA
        H2IgFhsMFQ1HrZGAWCIISUXERpFLq4AKJZzxDDUSsVWseEAFLevBvzdvZt6bmQyJCfSEP5mg
        SqYZlTxRxPXCqx7+eDpfsqtOsSDL5S01VpRxpe0WI1f6smyMkJ52vULSke9G7kpClt7oIGQ3
        S0Jl5s/Zk2SP8kZwmcscuI3Y4xUeSycmHKWZsIj9XvH60WriiHb98eqBISIVdS7VIR4J1CLo
        7ink6JAXKaBKEDgH33HZ4AuC16WlfzIuBGXmgd8BOd7iHNvO8iYEum/PuB4pATWI4HzePg/m
        UxFw7Xwlx4NxKgiMpkGM5X3gcb4d9+hMo2LB7D7qoX2pKDA33RuXwSgh9NqvjLf6UQw0n7Ug
        lp8Fwy/NhAdzKQnoHDquR4ZHRUKHXs2WzIS0W5cwz2hAtZAw+rWCw265Bl6MOAgW+8J7a+Uk
        Fs+A5guZONugRVAw8orDBnoEqe96EVu1HJ4/HR53w6gQqLCEsXQk1GYU4+xNvKHb4cMO4Q3Z
        VbkYS/Mh44yArQ4Gg7X8n21dqw3TI5FhwlEME7Y3TFjH8N+3AOHXkZDWqJVxtHqhij4mVsuV
        ao0qTqxIUprR76dpHrUOVaOS94PiesQhUT0CEhP58e8+uK8Q8GPlJ1JoJimG0STS6noUQOIi
        IT/v1hWFgIqTJ9OHafoIzfzNckiefypHGnixaVf6geQe8q1gqymiIdaonO64ZHoi6HfbN9aU
        h0R2tx1MwkSNP8SaFfHeDZOtP0++qTXmptx2pueszb+aFk7782rcq3PePtz0ZlWAVVsRNcdp
        t4lb+s+5tSk3B+ZHV60bazEpOI9F9JbGxJCi4sqWqcTipgTjxt2nd3RlW3oyNi8LFprEOw1+
        JvHtfvm9TGFl0N69QzeWBDRM8f0091TRx8aOQ3jtlDb70FTSr0e5GL72M6mmsODCIIVwdt3V
        YGkhXj3TpQ1vi7mzlnn2wRZqG9ZI3Ot5XcWb6L7OrfP6JIxIkR/R52zd8H00zdI+LUZ1OTqQ
        zkq2nSJO5otwdbxcEooxavkvSfoXcKMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7oGYQeTDRbPM7SYs34Nm8XlXXPY
        LO6t+c9q0fj5PqPF7x9z2BxYPVqOvGX12LxCy2PTp0nsHidm/Gbx+LxJLoA1Ss+mKL+0JFUh
        I7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jwr8drAXt7hU7Xn9l
        bWC8ZtnFyMEhIWAi8e5/UBcjF4eQwFJGidfz37F2MXICxWUkTk5rgLKFJf5c62KDKHrPKHGk
        +TFYglfATmLZxC1MIDaLgKrEnOUfmSHighInZz5hAbFFBVIkmp+fBKsXFgiU2HRqLxuIzSwg
        LnHryXywXhGBIokL52YwQcQVJH7d2wRWLyRQLrFjQQc7iM0mYCjR9RbkCA4OTgFHiasTiiHK
        zSS6tnYxQtjyEs1bZzNPYBSaheSKWUi2zULSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6
        yfm5mxiBsbXt2M8tOxhXvvqod4iRiYPxEKMEB7OSCO+eo/uThXhTEiurUovy44tKc1KLDzGa
        AoNiIrOUaHI+MLrzSuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqY
        3FVKC+VvJ7m7794WcdiKJWefrQ+7QtlSLuYM9uVPukUnJgs/7+gtaNMuXKvLnTnZ9+6uV74i
        2488zmG/LpC7W8NSXTfD/XSsR+7m7KRD4b5HXbMDdSY+KO4P/rF539qIXT8PT2dLD797/v3F
        aUlm4ouePvpse1zM6tzy2lc92t+t7ha1+3xZ8kdG7+wKi9LXBumnJ5f5fZyfXJGybY1J/6lI
        v7B5vpOj8pmcn0WoiB70uDHRXij6k8IShrJFT9eujdnDY7ifb0bhnVsT3y949ktRfkvXhXm9
        rnx/LxSkF02zYP2mek5FyKb3/I6K3LacyLVhfLZNgu1NMi37V37t0vYI8LB6u3Bz5X6GbyeU
        WIozEg21mIuKEwFVN1KxNgMAAA==
X-CMS-MailID: 20230113130136eucas1p18a54a3812792e500a02079ee890e5ecb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230113130136eucas1p18a54a3812792e500a02079ee890e5ecb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230113130136eucas1p18a54a3812792e500a02079ee890e5ecb
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
        <20230112083006.163393-6-wangkefeng.wang@huawei.com>
        <CGME20230113130136eucas1p18a54a3812792e500a02079ee890e5ecb@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 12.01.2023 09:30, Kefeng Wang wrote:
> The old_page/new_page are converted to old_folio/new_folio in
> wp_page_copy(), then replaced related page functions to folio
> functions.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

This patch, merged into today's linux-next as commit 9ebae00c8e30 ("mm: 
memory: convert wp_page_copy() to use folios"), causes serious stability 
issues on my ARM based test boards. Here is the example of such crash:

VFS: Mounted root (ext4 filesystem) readonly on device 179:6.
devtmpfs: mounted
Freeing unused kernel image (initmem) memory: 1024K
Run /sbin/init as init process
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 
00000004 when read
[00000004] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: init Not tainted 6.2.0-rc3-00294-g9ebae00c8e30 #13254
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at do_wp_page+0x21c/0xd48
LR is at do_wp_page+0x1f8/0xd48
pc : [<c02aa518>]    lr : [<c02aa4f4>]    psr: 60000113
sp : f082de58  ip : 0006fff8  fp : 0000065f
r10: 00000000  r9 : 00000c73  r8 : c2b87318
r7 : c1d78000  r6 : b6ed9000  r5 : 00000000  r4 : f082dedc
r3 : c25d0000  r2 : 00000001  r1 : c0ee9568  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4363804a  DAC: 00000051
Register r0 information: NULL pointer
Register r1 information: non-slab/vmalloc memory
Register r2 information: non-paged memory
Register r3 information: slab mm_struct start c25d0000 pointer offset 0 
size 908
Register r4 information: 2-page vmalloc region starting at 0xf082c000 
allocated at kernel_clone+0x54/0x3e4
Register r5 information: NULL pointer
Register r6 information: non-paged memory
Register r7 information: slab task_struct start c1d78000 pointer offset 
0 size 4032
Register r8 information: slab vm_area_struct start c2b87318 pointer 
offset 0 size 68
Register r9 information: non-paged memory
Register r10 information: NULL pointer
Register r11 information: non-paged memory
Register r12 information: non-paged memory
Process init (pid: 1, stack limit = 0x(ptrval))
Stack: (0xf082de58 to 0xf082e000)
...
  do_wp_page from handle_mm_fault+0x938/0xda8
  handle_mm_fault from do_page_fault+0x154/0x408
  do_page_fault from do_DataAbort+0x3c/0xb0
  do_DataAbort from __dabt_usr+0x58/0x60
Exception stack(0xf082dfb0 to 0xf082dff8)
dfa0:                                     00000000 00000001 b6ed9060 
00000000
dfc0: 00000000 b6fea968 b6ed9060 00000000 b6cd4888 00000000 00000000 
00000000
dfe0: b6eda28c be8a9dd0 b6e6ff08 ffff0fcc 60000010 ffffffff
Code: e594a028 e58d301c e5983008 e58d3014 (e59a3004)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D 
6.2.0-rc3-00294-g9ebae00c8e30 #13254
Hardware name: Samsung Exynos (Flattened Device Tree)
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x58/0x70
  dump_stack_lvl from do_handle_IPI+0x348/0x374
  do_handle_IPI from ipi_handler+0x18/0x20
  ipi_handler from handle_percpu_devid_irq+0x9c/0x170
  handle_percpu_devid_irq from generic_handle_domain_irq+0x24/0x34
  generic_handle_domain_irq from gic_handle_irq+0x88/0xa8
  gic_handle_irq from generic_handle_arch_irq+0x58/0x78
  generic_handle_arch_irq from call_with_stack+0x18/0x20
  call_with_stack from __irq_svc+0x9c/0xd0
Exception stack(0xf08a9ee0 to 0xf08a9f28)
...
  __irq_svc from cpuidle_enter_state+0x318/0x3d0
  cpuidle_enter_state from cpuidle_enter_state_coupled+0x160/0x400
  cpuidle_enter_state_coupled from cpuidle_enter+0x3c/0x54
  cpuidle_enter from do_idle+0x1f0/0x2b0
  do_idle from cpu_startup_entry+0x18/0x1c
  cpu_startup_entry from secondary_start_kernel+0x1a0/0x230
  secondary_start_kernel from 0x40101a00
---[ end Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b ]---

Reverting it on top of linux-next 20220113 together with aaf3f7afbf10 
("mm: swap: remove unneeded cgroup_throttle_swaprate()") fixes the 
stability issues.


> ---
>   mm/memory.c | 47 +++++++++++++++++++++++++----------------------
>   1 file changed, 25 insertions(+), 22 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index b66c425b4d7c..746f485366e8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3044,7 +3044,9 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct mm_struct *mm = vma->vm_mm;
>   	struct page *old_page = vmf->page;
> +	struct folio *old_folio = page_folio(old_page);
>   	struct page *new_page = NULL;
> +	struct folio *new_folio = NULL;
>   	pte_t entry;
>   	int page_copied = 0;
>   	struct mmu_notifier_range range;
> @@ -3060,12 +3062,13 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>   							      vmf->address);
>   		if (!new_page)
>   			goto oom;
> +		new_folio = page_folio(new_page);
>   	} else {
> -		new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
> -				vmf->address);
> -		if (!new_page)
> +		new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma,
> +					    vmf->address, false);
> +		if (!new_folio)
>   			goto oom;
> -
> +		new_page = &new_folio->page;
>   		ret = __wp_page_copy_user(new_page, old_page, vmf);
>   		if (ret) {
>   			/*
> @@ -3075,9 +3078,9 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>   			 * from the second attempt.
>   			 * The -EHWPOISON case will not be retried.
>   			 */
> -			put_page(new_page);
> -			if (old_page)
> -				put_page(old_page);
> +			folio_put(new_folio);
> +			if (old_folio)
> +				folio_put(old_folio);
>   
>   			delayacct_wpcopy_end();
>   			return ret == -EHWPOISON ? VM_FAULT_HWPOISON : 0;
> @@ -3085,11 +3088,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>   		kmsan_copy_page_meta(new_page, old_page);
>   	}
>   
> -	if (mem_cgroup_charge(page_folio(new_page), mm, GFP_KERNEL))
> +	if (mem_cgroup_charge(new_folio, mm, GFP_KERNEL))
>   		goto oom_free_new;
> -	cgroup_throttle_swaprate(new_page, GFP_KERNEL);
> +	folio_throttle_swaprate(new_folio, GFP_KERNEL);
>   
> -	__SetPageUptodate(new_page);
> +	__folio_mark_uptodate(new_folio);
>   
>   	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
>   				vmf->address & PAGE_MASK,
> @@ -3101,8 +3104,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>   	 */
>   	vmf->pte = pte_offset_map_lock(mm, vmf->pmd, vmf->address, &vmf->ptl);
>   	if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
> -		if (old_page) {
> -			if (!PageAnon(old_page)) {
> +		if (old_folio) {
> +			if (!folio_test_anon(old_folio)) {
>   				dec_mm_counter(mm, mm_counter_file(old_page));
>   				inc_mm_counter(mm, MM_ANONPAGES);
>   			}
> @@ -3130,7 +3133,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>   		 */
>   		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
>   		page_add_new_anon_rmap(new_page, vma, vmf->address);
> -		lru_cache_add_inactive_or_unevictable(new_page, vma);
> +		folio_add_lru_vma(new_folio, vma);
>   		/*
>   		 * We call the notify macro here because, when using secondary
>   		 * mmu page tables (such as kvm shadow page tables), we want the
> @@ -3139,7 +3142,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>   		BUG_ON(unshare && pte_write(entry));
>   		set_pte_at_notify(mm, vmf->address, vmf->pte, entry);
>   		update_mmu_cache(vma, vmf->address, vmf->pte);
> -		if (old_page) {
> +		if (old_folio) {
>   			/*
>   			 * Only after switching the pte to the new page may
>   			 * we remove the mapcount here. Otherwise another
> @@ -3166,14 +3169,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>   		}
>   
>   		/* Free the old page.. */
> -		new_page = old_page;
> +		new_folio = old_folio;
>   		page_copied = 1;
>   	} else {
>   		update_mmu_tlb(vma, vmf->address, vmf->pte);
>   	}
>   
> -	if (new_page)
> -		put_page(new_page);
> +	if (new_folio)
> +		folio_put(new_folio);
>   
>   	pte_unmap_unlock(vmf->pte, vmf->ptl);
>   	/*
> @@ -3181,19 +3184,19 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>   	 * the above ptep_clear_flush_notify() did already call it.
>   	 */
>   	mmu_notifier_invalidate_range_only_end(&range);
> -	if (old_page) {
> +	if (old_folio) {
>   		if (page_copied)
>   			free_swap_cache(old_page);
> -		put_page(old_page);
> +		folio_put(old_folio);
>   	}
>   
>   	delayacct_wpcopy_end();
>   	return 0;
>   oom_free_new:
> -	put_page(new_page);
> +	folio_put(new_folio);
>   oom:
> -	if (old_page)
> -		put_page(old_page);
> +	if (old_folio)
> +		folio_put(old_folio);
>   
>   	delayacct_wpcopy_end();
>   	return VM_FAULT_OOM;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

