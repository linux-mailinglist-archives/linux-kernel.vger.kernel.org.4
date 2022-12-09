Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE9F64895F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 21:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLIUGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 15:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLIUGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 15:06:49 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A4B3C6FD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 12:06:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMThxdqBEbUcdWibQgf5GOkepyznhpe0DHo7DDodAoCDdliQOZdM5vedDcfHhbTlvZ4kYvc13r3/dbGvYqnmT8rwusaq9Z4WfxfXH6KVUW6zN2MuVd35lCZN2KJN88cFppCtQSxy6gE14WjhtCNHi/ITZn24JJAbDn4ttK68GfB4+u2pfmEOC9YgpmcpGLoOyCnwVeQt2KNGGdEdyyz213IfhMy5tUJLxM1miwrjvILmbbNFv2mbNrcJK4EsBuFrfSyzxdc5xuvhYxD3vh51tvA1/Z2QWySlJlsRTm1QRlyfusosAUEnEpx5A1/ffRmKrE+KoLl0qwXYeVLIvJlq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ks92mSMx1RGW/hxy0RHuctDZVUMlsXFmmdrjQmaoiM0=;
 b=dal0d4oYj9TPIpX0cw+valJXzgHuw6TJaEUhUmiau4jkxPTjnm+z12kuFKs6Idn6s9RVztW/FGnu01cNfBRYm/mIa5PTT4dYXFbBTybfgxW/+771PIasfiGWscDek2KmXn/hbo3V7T7FqI6mxH/IehvCgq0+zkE3/WIakDaOL1FxGt/bfEYTXCZ7jal5Dgj06mh4HDBg1mubM4iIB1mMOhjk/zUH3Rzjx1dGOooKKoFHLSuNp9oAJCYlTaEncPD6YFbJF0JbXTID8tWKx/1HWlxo9AxJ4GnI/TAQF3uAabn5F5wwlBBZWeKROq0aSXgtXtGVeg2om/6JN0NW+wlXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks92mSMx1RGW/hxy0RHuctDZVUMlsXFmmdrjQmaoiM0=;
 b=TIyShDf/SBZU+MXZZHZ/vj85Hnfja/mPzR9PORh28MNLJ+VabULfO3chn12/b2CA4Q/t+I08HuGYoRKUZ8cDIFb7MMT8yS5XAfcDkwAGmL7OYN8iOjAOMznooLepcUbuXLIxaBXv7rKJlg4oGFd7HZBkCc/8DurZ2OxPG8bmygweOqKhH0Ou4C/GvcpVnrT9T25hzD5k41JjHlx21NdKQOv8ZOlqtOyCHf0dKuA/NPm+kgR5iAhzc/1MMeANP/cWr2ykLkhjqD+JlHYjIlypXEzXvV0jKB0DEMUoUN4z+Wbx8ILY6uiyNIG8YlvkIF9B6ij49KR55vpJE9izrpwDpg==
Received: from BN0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:408:ee::21)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 20:06:45 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::a0) by BN0PR04CA0016.outlook.office365.com
 (2603:10b6:408:ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 20:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Fri, 9 Dec 2022 20:06:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 9 Dec 2022
 12:06:31 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 9 Dec 2022
 12:06:30 -0800
Message-ID: <a38065af-6668-d371-4016-670c71e1e722@nvidia.com>
Date:   Fri, 9 Dec 2022 12:06:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 9/9] mm/hugetlb: Introduce hugetlb_walk()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20221209170100.973970-1-peterx@redhat.com>
 <20221209170100.973970-10-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221209170100.973970-10-peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 600be6e2-b4ec-43b5-2aa4-08dada20e575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9C+EnAfeHd0jhLAVAQQ3TnMYbjXdYFIa0CkNj5WmrJzUsGNBMbTLB+xAFldtL4+RWDGs8PQuLfJTDUS9SzvMAjcBrvbkz3XoU8je/0NiAzgatrN2FgrruZQNvnS1GS0722GDT1y2n2Kx4qqthf/dURam99v4c4SIWO/Km96FUcMtgztLJO0wWovmYBJdY+dd0J2ec7lLDyvwIMjLCSTix5e6jGKLjINED+e5/tYwBkYo+jpUM8kO1Fjt7UOq3oC/S2O8f/dACws14UivUpeBr9Wz4A21a8dLdYfWnDbGU23Uo2t3DwTTOF1MYF07nVhVf2y86UHWbBN6cIyNVCwU1M2716Dj9gqIW/GPx+ZFldzkFvxwR8ZBwpJfNQWBmnNn+i1SuZ+5ogLf55nrbWFCH4LOKmNKXBCGrt63rubqFdX4TcDHadd5x3GV1dpPzK1R4qP87IADmboz2rE5jh2xabrikJ3W8iP24MY+ydghPx2dWzkMITJHQYb1EwZYaUjPcAh+LycDp2M3LZYQkRrExX1TONWziBtYPkazFjuthtcVRAOPD9P3vCeuaoufLaKBp8vVuPXpLNWRYJDypx6iE15TYIgWojvVVjLlarwx2a57vL1bsca6u28bNjnE2v0OhA+BJsuF3R9cKF4o388fqYl8NWoKm98t9NHODQsj5habpeG7+my427y4kWQKL+5kYI0J1zb2RnfbRTGBs5W+TOXH2oOLkqrRyWI6nBxpAKxODX0yJqDeGRvu+ymYF2s
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(336012)(2616005)(16526019)(5660300002)(36860700001)(30864003)(40460700003)(7416002)(82310400005)(8936002)(36756003)(47076005)(82740400003)(83380400001)(31686004)(2906002)(7636003)(426003)(356005)(40480700001)(54906003)(478600001)(4326008)(53546011)(41300700001)(16576012)(110136005)(8676002)(70586007)(316002)(70206006)(186003)(31696002)(86362001)(26005)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 20:06:44.7784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600be6e2-b4ec-43b5-2aa4-08dada20e575
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/22 09:01, Peter Xu wrote:
> huge_pte_offset() is the main walker function for hugetlb pgtables.  The
> name is not really representing what it does, though.
> 
> Instead of renaming it, introduce a wrapper function called hugetlb_walk()
> which will use huge_pte_offset() inside.  Assert on the locks when walking
> the pgtable.
> 
> Note, the vma lock assertion will be a no-op for private mappings.
> 
> Document the last special case in the page_vma_mapped_walk() path where we
> don't need any more lock to call hugetlb_walk().
> 
> Taking vma lock there is not needed because either: (1) potential callers
> of hugetlb pvmw holds i_mmap_rwsem already (from one rmap_walk()), or (2)
> the caller will not walk a hugetlb vma at all so the hugetlb code path not
> reachable (e.g. in ksm or uprobe paths).
> 
> It's slightly implicit for future page_vma_mapped_walk() callers on that
> lock requirement.  But anyway, when one day this rule breaks, one will get
> a straightforward warning in hugetlb_walk() with lockdep, then there'll be
> a way out.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   fs/hugetlbfs/inode.c    |  4 +---
>   fs/userfaultfd.c        |  6 ++----
>   include/linux/hugetlb.h | 39 +++++++++++++++++++++++++++++++++++++++
>   mm/hugetlb.c            | 32 +++++++++++++-------------------
>   mm/page_vma_mapped.c    |  9 ++++++---
>   mm/pagewalk.c           |  4 +---
>   6 files changed, 62 insertions(+), 32 deletions(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index fdb16246f46e..48f1a8ad2243 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -388,9 +388,7 @@ static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
>   {
>   	pte_t *ptep, pte;
>   
> -	ptep = huge_pte_offset(vma->vm_mm, addr,
> -			huge_page_size(hstate_vma(vma)));
> -
> +	ptep = hugetlb_walk(vma, addr, huge_page_size(hstate_vma(vma)));
>   	if (!ptep)
>   		return false;
>   
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 969f4be967c6..6a278941ec84 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -237,14 +237,12 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>   					 unsigned long flags,
>   					 unsigned long reason)
>   {
> -	struct mm_struct *mm = ctx->mm;
>   	pte_t *ptep, pte;
>   	bool ret = true;
>   
> -	mmap_assert_locked(mm);
> -
> -	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
> +	mmap_assert_locked(ctx->mm);
>   
> +	ptep = hugetlb_walk(vma, address, vma_mmu_pagesize(vma));
>   	if (!ptep)
>   		goto out;
>   
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index d755e2a7c0db..a5e87ec7fa6e 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -2,6 +2,7 @@
>   #ifndef _LINUX_HUGETLB_H
>   #define _LINUX_HUGETLB_H
>   
> +#include <linux/mm.h>
>   #include <linux/mm_types.h>
>   #include <linux/mmdebug.h>
>   #include <linux/fs.h>
> @@ -196,6 +197,11 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>    * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
>    * Returns the pte_t* if found, or NULL if the address is not mapped.
>    *
> + * IMPORTANT: we should normally not directly call this function, instead
> + * this is only a common interface to implement arch-specific
> + * walker. Please use hugetlb_walk() instead, because that will attempt to
> + * verify the locking for you.
> + *
>    * Since this function will walk all the pgtable pages (including not only
>    * high-level pgtable page, but also PUD entry that can be unshared
>    * concurrently for VM_SHARED), the caller of this function should be
> @@ -1229,4 +1235,37 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
>   #define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
>   #endif
>   
> +static inline bool
> +__vma_shareable_flags_pmd(struct vm_area_struct *vma)
> +{
> +	return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&
> +		vma->vm_private_data;
> +}
> +
> +/*
> + * Safe version of huge_pte_offset() to check the locks.  See comments
> + * above huge_pte_offset().
> + */
> +static inline pte_t *
> +hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
> +{
> +#if defined(CONFIG_HUGETLB_PAGE) && \
> +	defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
> +	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
> +
> +	/*
> +	 * If pmd sharing possible, locking needed to safely walk the
> +	 * hugetlb pgtables.  More information can be found at the comment
> +	 * above huge_pte_offset() in the same file.
> +	 *
> +	 * NOTE: lockdep_is_held() is only defined with CONFIG_LOCKDEP.
> +	 */
> +	if (__vma_shareable_flags_pmd(vma))
> +		WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
> +			     !lockdep_is_held(
> +				 &vma->vm_file->f_mapping->i_mmap_rwsem));
> +#endif
> +	return huge_pte_offset(vma->vm_mm, addr, sz);
> +}
> +
>   #endif /* _LINUX_HUGETLB_H */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9d8bb6508288..b20120d14a71 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4814,7 +4814,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   	} else {
>   		/*
>   		 * For shared mappings the vma lock must be held before
> -		 * calling huge_pte_offset in the src vma. Otherwise, the
> +		 * calling hugetlb_walk() in the src vma. Otherwise, the
>   		 * returned ptep could go away if part of a shared pmd and
>   		 * another thread calls huge_pmd_unshare.
>   		 */
> @@ -4824,7 +4824,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   	last_addr_mask = hugetlb_mask_last_page(h);
>   	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
>   		spinlock_t *src_ptl, *dst_ptl;
> -		src_pte = huge_pte_offset(src, addr, sz);
> +		src_pte = hugetlb_walk(src_vma, addr, sz);
>   		if (!src_pte) {
>   			addr |= last_addr_mask;
>   			continue;
> @@ -5028,7 +5028,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>   	hugetlb_vma_lock_write(vma);
>   	i_mmap_lock_write(mapping);
>   	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
> -		src_pte = huge_pte_offset(mm, old_addr, sz);
> +		src_pte = hugetlb_walk(vma, old_addr, sz);
>   		if (!src_pte) {
>   			old_addr |= last_addr_mask;
>   			new_addr |= last_addr_mask;
> @@ -5091,7 +5091,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
>   	last_addr_mask = hugetlb_mask_last_page(h);
>   	address = start;
>   	for (; address < end; address += sz) {
> -		ptep = huge_pte_offset(mm, address, sz);
> +		ptep = hugetlb_walk(vma, address, sz);
>   		if (!ptep) {
>   			address |= last_addr_mask;
>   			continue;
> @@ -5404,7 +5404,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   			mutex_lock(&hugetlb_fault_mutex_table[hash]);
>   			hugetlb_vma_lock_read(vma);
>   			spin_lock(ptl);
> -			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
> +			ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
>   			if (likely(ptep &&
>   				   pte_same(huge_ptep_get(ptep), pte)))
>   				goto retry_avoidcopy;
> @@ -5442,7 +5442,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   	 * before the page tables are altered
>   	 */
>   	spin_lock(ptl);
> -	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
> +	ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
>   	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
>   		/* Break COW or unshare */
>   		huge_ptep_clear_flush(vma, haddr, ptep);
> @@ -6228,7 +6228,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   		return NULL;
>   
>   	hugetlb_vma_lock_read(vma);
> -	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
> +	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
>   	if (!pte)
>   		goto out_unlock;
>   
> @@ -6293,8 +6293,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   		 *
>   		 * Note that page table lock is not held when pte is null.
>   		 */
> -		pte = huge_pte_offset(mm, vaddr & huge_page_mask(h),
> -				      huge_page_size(h));
> +		pte = hugetlb_walk(vma, vaddr & huge_page_mask(h),
> +				   huge_page_size(h));
>   		if (pte)
>   			ptl = huge_pte_lock(h, mm, pte);
>   		absent = !pte || huge_pte_none(huge_ptep_get(pte));
> @@ -6480,7 +6480,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>   	last_addr_mask = hugetlb_mask_last_page(h);
>   	for (; address < end; address += psize) {
>   		spinlock_t *ptl;
> -		ptep = huge_pte_offset(mm, address, psize);
> +		ptep = hugetlb_walk(vma, address, psize);
>   		if (!ptep) {
>   			address |= last_addr_mask;
>   			continue;
> @@ -6858,12 +6858,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>   		*end = ALIGN(*end, PUD_SIZE);
>   }
>   
> -static bool __vma_shareable_flags_pmd(struct vm_area_struct *vma)
> -{
> -	return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&
> -		vma->vm_private_data;
> -}
> -
>   void hugetlb_vma_lock_read(struct vm_area_struct *vma)
>   {
>   	if (__vma_shareable_flags_pmd(vma)) {
> @@ -7029,8 +7023,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>   
>   		saddr = page_table_shareable(svma, vma, addr, idx);
>   		if (saddr) {
> -			spte = huge_pte_offset(svma->vm_mm, saddr,
> -					       vma_mmu_pagesize(svma));
> +			spte = hugetlb_walk(svma, saddr,
> +					    vma_mmu_pagesize(svma));
>   			if (spte) {
>   				get_page(virt_to_page(spte));
>   				break;
> @@ -7388,7 +7382,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
>   	hugetlb_vma_lock_write(vma);
>   	i_mmap_lock_write(vma->vm_file->f_mapping);
>   	for (address = start; address < end; address += PUD_SIZE) {
> -		ptep = huge_pte_offset(mm, address, sz);
> +		ptep = hugetlb_walk(vma, address, sz);
>   		if (!ptep)
>   			continue;
>   		ptl = huge_pte_lock(h, mm, ptep);
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 93e13fc17d3c..f3729b23dd0e 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -168,9 +168,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   		/* The only possible mapping was handled on last iteration */
>   		if (pvmw->pte)
>   			return not_found(pvmw);
> -
> -		/* when pud is not present, pte will be NULL */
> -		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
> +		/*
> +                 * All callers that get here will already hold the
> +                 * i_mmap_rwsem.  Therefore, no additional locks need to be
> +                 * taken before calling hugetlb_walk().
> +		 */
> +		pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
>   		if (!pvmw->pte)
>   			return false;
>   
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index d98564a7be57..cb23f8a15c13 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -305,13 +305,11 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
>   	hugetlb_vma_lock_read(vma);
>   	do {
>   		next = hugetlb_entry_end(h, addr, end);
> -		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
> -
> +		pte = hugetlb_walk(vma, addr & hmask, sz);
>   		if (pte)
>   			err = ops->hugetlb_entry(pte, hmask, addr, next, walk);
>   		else if (ops->pte_hole)
>   			err = ops->pte_hole(addr, next, -1, walk);
> -
>   		if (err)
>   			break;
>   	} while (addr = next, addr != end);

