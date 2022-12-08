Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014096465B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiLHAMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLHAMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:12:49 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DED643847
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 16:12:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L44qczrF8wBMfCpAC8+4g/LZSb6/IxSwp6SjD+D3UrLN04cqqueHBpmDoeZpJ7RIKfD30KRxQMUkYXNYynRixX0D/lcr+MJtyXpbEsKQl7X4nladZryRZCte/2qF/S9N2S3McIfi/Nk6PMG/lshY0yMbONF8Z8PaGSV47IyQGVwHJvnoQuoYmu1BzrEb/ZIGZ1yfU6KxENPqZ1b2dNG6qcAuDzsk7Xrf9e1YY/76KNpYE8mdjQ811HXfb1q/94TDmJSNZNZTsaZeGuxvU6waF0UT58cgHJa53NA2cLWHRwibF7vnWuHtmRlh4FaIWJln4ngJhZVObitm/O48qWFN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DAAyeQuGKAiLRFLRG9I2zNIiHy2RZW7r4kRC1ezqaM=;
 b=KDQAxw7rxtIib+XIkwNHLUbyeAKHVuXaXV9AuCcomSaGFPMDYEd9uoz33IlyXrk3oPb5JTuk1XidxSKVoPuPs79ylkr3h6E/NQK0esaUcaFQe5LfK1Az4Ys5LvSDguXyNAjYrtPTlzCcxznMnYhtoqambTJ+k2DdKMxZ57YinJfOOEG1tZ2rglKlZDSs7axkr5vaMcZtERw3WURSNSdYQ0DxOS9aJen/dMmxaCzFvjpeoh+vmLYfHsEFFnQTGOeDQJbsHRDMrOw1ogElTAGEEkk1gZcWEmyiKPiKHy+GP25K/4KuYm/HOzUJnP6aLJg8KW0xsQ5PORVy3+GhkG4bKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DAAyeQuGKAiLRFLRG9I2zNIiHy2RZW7r4kRC1ezqaM=;
 b=Eu6jE7E6iXA0TMh0BTkv+e86tUW54JumfVyWcxEAUe5ek2gjsCo6KfgnEgVbBuM3aKtFOE52BvTEtbruRooeRZizfrLfN+u+i1PglxDB+fmLRp0l0h0NNOjtuRFiJTreCfnXVWpcjge8BiLYNO5QBDiDQl+OTyYfvmmRq0Fpna31THglTHdbSIzmGiJUX/WyEv95WgTVnib7FSG8nflKYOoVaOINf+e8VHOGbCHQjATcmbIXoPq226U49nRU4czXLHsWR6dec+VN97+xkCzihGcDquBL1ks5e2XozkQAj0t0r9IBdKaq5//KjF9+8lDeP0qBWLd0tVBk+Np05m15Bg==
Received: from BN9PR03CA0706.namprd03.prod.outlook.com (2603:10b6:408:ef::21)
 by BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 00:12:45 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::81) by BN9PR03CA0706.outlook.office365.com
 (2603:10b6:408:ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 00:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 00:12:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 16:12:33 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 16:12:32 -0800
Message-ID: <3b5579e8-8e51-a2e2-4c93-6709f8833723@nvidia.com>
Date:   Wed, 7 Dec 2022 16:12:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 09/10] mm/hugetlb: Introduce hugetlb_walk()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203156.651077-1-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221207203156.651077-1-peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT061:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 74625c16-6b1e-4f3e-53c6-08dad8b0ee9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQEPCqBPSqWdUzte/mDMzTUq5+Pk61SAMC6JYidm+TeQb6M/PcEcVYU485PCYGtFyDvuYyy107CZs/Lmfp8IWw5bAY7PfcEgW/xZTxKbv2+Esjz68mSqfCGv7k1Y0c5E9LTwx9yrRRAByBN8KkRPfA/26tZGWTo0ToCdGbgvfC6ibSFb1b6BdWdG+q8xVIfZgItNrCOoyV4IlwrUBbvQvR7WMElnhAjubxgsepqTCGoKPQ0k7rP8K6wew6msBEPvsQPDdjca0bcttfBtjKfIX+nvFaEiX4ERervpYCi7UBs7/f9LdLcS2iBqpG2iR6RMTISds6PVCaWbvicZ7F9aol6JDPJ9ksIuwNvLpQx7zEiKR40EiQtY3PuTViFZqq75ur0fTBWTHHPZomjgqfIOLF73mG9hdNqINH0CDkIZ7v5AbR5QvcMW9xPtzZAwOlE08PVC/rED1OSS1x8PEBer08IpdGa6h0psnkxqQCH5ttcSYJEaTfnDEiXWr9KCcw8/NP5RMoua7mPgzyahQV8R63K6GZcuoVrMrCPSYj+LxXR+fibaPVUT/cVvzMi7LMQRYzEScnPsy1fR9Ko7Tjl5hhJj6Ybqw01qlXVA0RmfgvJyRI2133AO+MuNT3LSSEqlh32XBPnzrbVSoEzUPm5uTbaA+euCJzoOJjoDnK4Hsmshlcnyck+oTR2/9XeDyxR5GgbofkirAOdyBeqDnW9pLMAc+QE2FZR2W8cCzYAfBD40Xm925rJIBtFiv9Duvgxu
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(478600001)(36860700001)(83380400001)(30864003)(8936002)(86362001)(70586007)(356005)(31696002)(2906002)(5660300002)(40460700003)(4326008)(7416002)(40480700001)(70206006)(41300700001)(82310400005)(8676002)(47076005)(53546011)(26005)(336012)(16526019)(186003)(426003)(2616005)(110136005)(316002)(16576012)(82740400003)(31686004)(7636003)(54906003)(36756003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 00:12:45.3381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74625c16-6b1e-4f3e-53c6-08dad8b0ee9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 12:31, Peter Xu wrote:
> huge_pte_offset() is the main walker function for hugetlb pgtables.  The
> name is not really representing what it does, though.
> 
> Instead of renaming it, introduce a wrapper function called hugetlb_walk()
> which will use huge_pte_offset() inside.  Assert on the locks when walking
> the pgtable.
> 
> Note, the vma lock assertion will be a no-op for private mappings.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   fs/hugetlbfs/inode.c    |  4 +---
>   fs/userfaultfd.c        |  6 ++----
>   include/linux/hugetlb.h | 39 +++++++++++++++++++++++++++++++++++++++
>   mm/hugetlb.c            | 32 +++++++++++++-------------------
>   mm/page_vma_mapped.c    |  2 +-
>   mm/pagewalk.c           |  4 +---
>   6 files changed, 57 insertions(+), 30 deletions(-)
> 
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
> index a602f008dde5..f31fe1a9f4c5 100644
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
> index 81efd9b9baa2..1c20cbbf3d22 100644
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
> + * this is only a common interface to implement arch-specific walker.
> + * Please consider using the hugetlb_walk() helper to make sure of the
> + * correct locking is satisfied.

Or:

"Please use hugetlb_walk() instead, because that will attempt to verify
the locking for you."

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

It is odd to say that functionA() is a safe version of functionB(), if the
names are completely different.

At this point, it is very clear that huge_pte_offset() should be renamed.
I'd suggest something like one of these:

     __hugetlb_walk()
     hugetlb_walk_raw()

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

Let's please not slice up C functions with ifdefs. Instead, stick to the
standard approach of

#ifdef X
functionC()
{
	...implementation
}
#else
functionC()
{
	...simpler or shorter or stub implementation
}

> +
>   #endif /* _LINUX_HUGETLB_H */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f42399522805..e3500c087893 100644
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
> @@ -6227,7 +6227,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>   		return NULL;
>   
>   	hugetlb_vma_lock_read(vma);
> -	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
> +	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
>   	if (!pte)
>   		goto out_unlock;
>   
> @@ -6292,8 +6292,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
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
> @@ -6479,7 +6479,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>   	last_addr_mask = hugetlb_mask_last_page(h);
>   	for (; address < end; address += psize) {
>   		spinlock_t *ptl;
> -		ptep = huge_pte_offset(mm, address, psize);
> +		ptep = hugetlb_walk(vma, address, psize);
>   		if (!ptep) {
>   			address |= last_addr_mask;
>   			continue;
> @@ -6857,12 +6857,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
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
> @@ -7028,8 +7022,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
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
> @@ -7387,7 +7381,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
>   	hugetlb_vma_lock_write(vma);
>   	i_mmap_lock_write(vma->vm_file->f_mapping);
>   	for (address = start; address < end; address += PUD_SIZE) {
> -		ptep = huge_pte_offset(mm, address, sz);
> +		ptep = hugetlb_walk(vma, address, sz);
>   		if (!ptep)
>   			continue;
>   		ptl = huge_pte_lock(h, mm, ptep);
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 93e13fc17d3c..e97b2e23bd28 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -170,7 +170,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   			return not_found(pvmw);
>   
>   		/* when pud is not present, pte will be NULL */
> -		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
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


