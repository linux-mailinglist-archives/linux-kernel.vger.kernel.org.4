Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8442A64642C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiLGWgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGWge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:36:34 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED285661
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:36:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuGu/FE4Z2Vha5cUsWVtsk8FhDZqXumhkm2tPdsk/RuNRHW5k6ql1oWtSPREjvX2XKsE9mSZCqdyocE7HDP3nWtI0nvNIqa5ZjcbCaeHIQP0zAGdjke5fL1GtRZLNq/SCeG6sHaIOfIYNnYgW/HGg+lri02BTpReK8b8k1z6A2dbOGeAQZyOu41tgGSLT62xc7XegLfm0TWwXDXi8XTKF5H1/H7kefy2N7gjVnPBfP8ThurGY7jDroC+7SMrTeYDggz2sfH5RPI5XNFuBOSt4a7Uy5Jeo+PLzgfiEzm/cjogg6JTwDySV3ZbnWgcAdL+2UHaxnKFOcwR1CHDML/00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50iOb6hv9wIoF7sMNInAO9cqRqRPNam9puj+kdTplD8=;
 b=ZmII2evIEF0Vm5VELW4zwCh0BrEq/kclVnV6IL6ORJT1lx9MqDbF4ulf7qPxmjGEXJMoLhY0hyWg94gOM5oz/c2D9SI7TuqqDqbRUOa3WK/jbt6KZh/9zyXErRAPoLbB0eeSnk1kvfdIjNibfL2eOqqKY6mun796HjXyQa28lDCJeVUjvAl/MNwJDwtCI0lYH8Kzh5Bk2SP9zJJIzoKZ/XehLAZLeMUsgxTTg1gfecNiqwFvopOzo0FsS2eotXLPrdMa7/dG2NzPWlhCKXRqSuCGolfOyOieccHDOAypLCAy0308BxdZC6D9nquSZIcMyq/G6pX1NPunE65QSlCaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50iOb6hv9wIoF7sMNInAO9cqRqRPNam9puj+kdTplD8=;
 b=BGWk2YOVQYv8ZJGythLnYd2E8z5yfHa8XjMPJ6MwFaRgIiz37CWv6dMLxHkZ3uo22WANa8lnTfLBqPYrrKALSIVtwmbZzZsk8cg8XVgGi7P0zDrOFpz1OPbPnDMHfANS6xdsZNYALqSTJ4+qObqcqayHOaoIBmIQPxExF9ovVykHuEzf4JiwTZ+mQ45VHT4oeklPiHjY0kOcADnrfwHWV4asDuAPZm4OsDephKYwffKDHt0wkWd/o4xYuQl9Qjr+/CBQTJ18tJqyS53QnIatb35OmyiVAqeB0rG4j5bZgtW1UZ3ozTtANU3WHNVvmqDW8bu6U48D79g465O1T4OWbw==
Received: from DM6PR01CA0013.prod.exchangelabs.com (2603:10b6:5:296::18) by
 CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 22:36:31 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::2e) by DM6PR01CA0013.outlook.office365.com
 (2603:10b6:5:296::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Wed, 7 Dec 2022 22:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 22:36:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 14:36:22 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 14:36:21 -0800
Message-ID: <326789a5-85ba-f13c-389e-fd21d673e3ae@nvidia.com>
Date:   Wed, 7 Dec 2022 14:36:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 04/10] mm/hugetlb: Move swap entry handling into vma
 lock when faulted
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203034.650899-5-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221207203034.650899-5-peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 4471203b-2670-4504-3b84-08dad8a37ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mmH8Tx+cN/7FlNrUvNKSBggKXQbHGSiVo40XjCQ8CVwkKUjLqQ7xH9/Yx6Ii/T3DeANd3OpFz8CcItkEQIAkWWylrvNZ1XKCLw3YnL/tS/B32V3msBQtBS8IECHn7vi/kELs7QjPQl8qIlk5LD8I2N2WR3elaDi+XNCfWqlK89aA+y5igT411TIsGEzIBJomYlyyuo4aGSQUCHFFLVFm1CH/1zyuU9w9Vz1I8u2TRctGqLRWpGtdTSsxxWUbKMY3PuNMb9xYFv1fsxn6s4KDQMrSOX0oc1XiuzsWtnc2RtCg0o8MJ2w2mSZiMxlcv0so25tU9adi6A9NzN1Mf40zVdWIyKbsiGQWWfQbP9sp+lDIUquzBVHDJxyCKSIvg5NJWZXZQgP2U3tEix6GhnAj/0k60PNynJAs6beDseNXJqUN6hzQ3oQhrZovRCwFUFD5Sn+LMijFxZupIOlJD+N+1wry44JcHqaQF8LFJexE6QMqnuEtFdKfGSuMLEtty2LZ2osCdyCJy17IyV91Je+GIlC6fsZqm2ZqU9oY87P1nmlhl748Dj/OYzKuj6dnD9kyvH+jpiKeY4+gwW0eFDSTlU/DiApT67Cpy3OnYS8WHCObZ21Y41fS3q4nLYiFFjamH4+ToUikQIFxGO0cn/i+J96x/N8WsMEUzE50ykf660iA0RFHcSh3vN4NoEmMiMgquDCiu80OOYKd7ib+ZroUr0QTA2CoXRVNdlczofBtFmikys2kAsRlLAKC/CfpEXCV
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(66899015)(36756003)(7636003)(31696002)(8936002)(86362001)(356005)(40460700003)(41300700001)(4326008)(5660300002)(2906002)(7416002)(36860700001)(83380400001)(82740400003)(31686004)(54906003)(316002)(16576012)(110136005)(70586007)(8676002)(2616005)(82310400005)(40480700001)(186003)(16526019)(478600001)(70206006)(53546011)(47076005)(26005)(336012)(426003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 22:36:31.0316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4471203b-2670-4504-3b84-08dad8a37ce2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 12:30, Peter Xu wrote:
> In hugetlb_fault(), there used to have a special path to handle swap entry
> at the entrance using huge_pte_offset().  That's unsafe because
> huge_pte_offset() for a pmd sharable range can access freed pgtables if
> without any lock to protect the pgtable from being freed after pmd unshare.
> 
> Here the simplest solution to make it safe is to move the swap handling to
> be after the vma lock being held.  We may need to take the fault mutex on
> either migration or hwpoison entries now (also the vma lock, but that's
> really needed), however neither of them is hot path.
> 
> Note that the vma lock cannot be released in hugetlb_fault() when the
> migration entry is detected, because in migration_entry_wait_huge() the
> pgtable page will be used again (by taking the pgtable lock), so that also
> need to be protected by the vma lock.  Modify migration_entry_wait_huge()
> so that it must be called with vma read lock held, and properly release the
> lock in __migration_entry_wait_huge().
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/swapops.h |  6 ++++--
>   mm/hugetlb.c            | 36 +++++++++++++++---------------------
>   mm/migrate.c            | 25 +++++++++++++++++++++----
>   3 files changed, 40 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index a70b5c3a68d7..b134c5eb75cb 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -337,7 +337,8 @@ extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>   extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>   					unsigned long address);
>   #ifdef CONFIG_HUGETLB_PAGE
> -extern void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl);
> +extern void __migration_entry_wait_huge(struct vm_area_struct *vma,
> +					pte_t *ptep, spinlock_t *ptl);
>   extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
>   #endif	/* CONFIG_HUGETLB_PAGE */
>   #else  /* CONFIG_MIGRATION */
> @@ -366,7 +367,8 @@ static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>   static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>   					 unsigned long address) { }
>   #ifdef CONFIG_HUGETLB_PAGE
> -static inline void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl) { }
> +static inline void __migration_entry_wait_huge(struct vm_area_struct *vma,
> +					       pte_t *ptep, spinlock_t *ptl) { }
>   static inline void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte) { }
>   #endif	/* CONFIG_HUGETLB_PAGE */
>   static inline int is_writable_migration_entry(swp_entry_t entry)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c8a6673fe5b4..49f73677a418 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5824,22 +5824,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   	int need_wait_lock = 0;
>   	unsigned long haddr = address & huge_page_mask(h);
>   
> -	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
> -	if (ptep) {
> -		/*
> -		 * Since we hold no locks, ptep could be stale.  That is
> -		 * OK as we are only making decisions based on content and
> -		 * not actually modifying content here.
> -		 */
> -		entry = huge_ptep_get(ptep);
> -		if (unlikely(is_hugetlb_entry_migration(entry))) {
> -			migration_entry_wait_huge(vma, ptep);
> -			return 0;
> -		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
> -			return VM_FAULT_HWPOISON_LARGE |
> -				VM_FAULT_SET_HINDEX(hstate_index(h));
> -	}
> -
>   	/*
>   	 * Serialize hugepage allocation and instantiation, so that we don't
>   	 * get spurious allocation failures if two CPUs race to instantiate
> @@ -5854,10 +5838,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   	 * Acquire vma lock before calling huge_pte_alloc and hold
>   	 * until finished with ptep.  This prevents huge_pmd_unshare from
>   	 * being called elsewhere and making the ptep no longer valid.
> -	 *
> -	 * ptep could have already be assigned via huge_pte_offset.  That
> -	 * is OK, as huge_pte_alloc will return the same value unless
> -	 * something has changed.
>   	 */
>   	hugetlb_vma_lock_read(vma);
>   	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
> @@ -5886,8 +5866,22 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   	 * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will
>   	 * properly handle it.
>   	 */
> -	if (!pte_present(entry))
> +	if (!pte_present(entry)) {
> +		if (unlikely(is_hugetlb_entry_migration(entry))) {
> +			/*
> +			 * Release fault lock first because the vma lock is
> +			 * needed to guard the huge_pte_lockptr() later in
> +			 * migration_entry_wait_huge().  The vma lock will
> +			 * be released there.
> +			 */
> +			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +			migration_entry_wait_huge(vma, ptep);
> +			return 0;

Oh, but now (and also one other, pre-existing case, above)
hugetlb_fault() is returning with the vma lock held. This is in contrast
with most of the rest of the function, which takes great care to release
locks before returning.

Which makes this new case really quite irregular and makes the overall
locking harder to follow. It would be ideal to avoid doing this! But at
the very least, there should be a little note above hugetlb_fault(),
explaining this deviation and how it fits in with the locking rules.

Do we really have to structure it this way, though?

thanks,
-- 
John Hubbard
NVIDIA

> +		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
> +			ret = VM_FAULT_HWPOISON_LARGE |
> +			    VM_FAULT_SET_HINDEX(hstate_index(h));
>   		goto out_mutex;
> +	}
>   
>   	/*
>   	 * If we are going to COW/unshare the mapping later, we examine the
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 48584b032ea9..d14f1f3ab073 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -333,24 +333,41 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>   }
>   
>   #ifdef CONFIG_HUGETLB_PAGE
> -void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl)
> +void __migration_entry_wait_huge(struct vm_area_struct *vma,
> +				 pte_t *ptep, spinlock_t *ptl)
>   {
>   	pte_t pte;
>   
> +	/*
> +	 * The vma read lock must be taken, which will be released before
> +	 * the function returns.  It makes sure the pgtable page (along
> +	 * with its spin lock) not be freed in parallel.
> +	 */
> +	hugetlb_vma_assert_locked(vma);
> +
>   	spin_lock(ptl);
>   	pte = huge_ptep_get(ptep);
>   
> -	if (unlikely(!is_hugetlb_entry_migration(pte)))
> +	if (unlikely(!is_hugetlb_entry_migration(pte))) {
>   		spin_unlock(ptl);
> -	else
> +		hugetlb_vma_unlock_read(vma);
> +	} else {
> +		/*
> +		 * If migration entry existed, safe to release vma lock
> +		 * here because the pgtable page won't be freed without the
> +		 * pgtable lock released.  See comment right above pgtable
> +		 * lock release in migration_entry_wait_on_locked().
> +		 */
> +		hugetlb_vma_unlock_read(vma);
>   		migration_entry_wait_on_locked(pte_to_swp_entry(pte), NULL, ptl);
> +	}
>   }
>   
>   void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte)
>   {
>   	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, pte);
>   
> -	__migration_entry_wait_huge(pte, ptl);
> +	__migration_entry_wait_huge(vma, pte, ptl);
>   }
>   #endif
>   

