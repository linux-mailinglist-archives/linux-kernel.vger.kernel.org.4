Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9381A70D0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjEWBr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjEWBrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:47:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105B68E
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:47:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHCWqV+Tfs9wyeWCmSDyeNxotE29oEvHkt49QuKA+lmBDqQROnVOtTzH+up9nnpVWUc25C/adGeULn3E/waI0fSe/aeXZmFPppNXbsEEcTVc1Hc6PFub4DZ+A8Vz+Qnm3vChd7Vt4wi7V63Ld+LH4+qCX0hR9ZJ7GDgxTDO3YdIBaMP1FDUzUYoU/GmlxIxBNgnQbuJLnK0cibQjsOnv0Qu4fYZo/lzAGQDY2GN+fKWCwumSzBiadZmT+dU28bo5An97UrawLCIoOw17/dtmm8drI0qmANg5SgJ+FK9rzI7Wf9E7MPiKgR3AkhrX03PrCNLl/vHSF/mMBbMr0kNdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmyMVegQIpehAbs842BD5oJGFwKFTiWnEH3Qd7IKqik=;
 b=SZAjlQwXlMuEZ/yzSmFMVJPhcZNfywUeqNOZC5OKX5vPadwetg1f6mg2kRNIl7zibHDTsJOv+2fQ6kdMBtjcKj1jlRC75LM/HQR5vUMLx/lgHnw8Vy9WNUsqsUQ7duUuoAO/M238/jHHiHr/zwkX4sKWgOr/B+KCfsFnHdg7NzpVXlLzONe0PeydzYidsp4/+i64cbooxxK6KA9PjqxJMPVIl2yz/kCINURiMoPmWL2m3awW94lqB9/NwHgoAn07KsfPVycNnDNxuahvRhYmPkVa8XOfZYLzdha+rvS4XePD5joSjAdHxRXCYj2vzzds+pEB2BllJX3qTJC/VSnGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmyMVegQIpehAbs842BD5oJGFwKFTiWnEH3Qd7IKqik=;
 b=gcNVkQgX+QA8CUBvtPDN+7b//0wjHIpwRNjZO+oSXyJ/FhqZvA9fpURaWC7YyhquqHNuV7tnqwFXV6aGamL2Y/aHeaLR/mbrNAL15LxWKcOkDJI4xyFntLtVSKa7Q/n3tj6upv9kh8aJJPCcNwUWBuW79SQPFdWbbeVClAgAhCGY9PzLgquzKeeP/U4qa/P+ag7RiMB0slmcjQMjBPAidCT/XLXw6JCCwSNhtG/+uwDgReGYrytTRaxygPIdSy5S7xqWehHFY5hE0OpyWw4AHSmXzSoxaNRxx9VPJfAbCurdVaBl7YJpAS1QGYnmNHhxF7V0Y+MzM0NJ2aIriHzuHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 01:47:20 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f6e4:71a5:4998:e6b2]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f6e4:71a5:4998:e6b2%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 01:47:20 +0000
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <1659568-468a-6d36-c26-6a52a335ab59@google.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 02/31] mm/migrate: remove cruft from
 migration_entry_wait()s
Date:   Tue, 23 May 2023 11:45:44 +1000
In-reply-to: <1659568-468a-6d36-c26-6a52a335ab59@google.com>
Message-ID: <87bkib95uj.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::21) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH7PR12MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cbe4f4-07e1-4b19-9198-08db5b2fa55a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiHvgbxLapsf+NcfI6+SD2I05P8UIldmpbKbsy3h2146J6wDBhKj3i48W9nuEUiNsBp1pJhup5fm3GnAmIj+eXcot1d5Go7NMBvQqjzKWjbf8LeKH54G2nRKl0HQ3XiLUvPRcp2fEvUcNLkFF2r/ZZ+kvMBHuzRtB97uk6IxBsfPyAdN0ovvue8Zqf62744q0Aq3Q2ThsIDGtHMNpgtBn5n86hXkXthBSURO3u6wQ1M2+eUbv5o7cbo9SiQI88QS37w7sYKKAp+gufElVsYmbUQmK+J9PjdTeBjm/IBeZzBXxo40ql0AMvYKn5YrvHfxwkzRoaSDEsVfRL4QslGvns73zIdUqDW0i/DJBiuFKnJ9TUT7dsi/BEAXa+BgOmkGdCG9xBiGOGMAQdRZsbP94m28gto5jHHr4g/fkV+B+NUrc52AAHIJ84Z/CwmGPIh6Bqso0xpJ7bTwrxUoCWAV3tO4gyiIBvhDDQV1gzdkd+OyixftE2kLYXyYim6Us9IRiNteUS1Cmn8/IhK/FB3DFcGKvCsZ3Vv4aBd4utHCCATc6o7QNnLKCJcovSUcBKiv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199021)(54906003)(41300700001)(6486002)(478600001)(316002)(6916009)(4326008)(6666004)(66946007)(66556008)(66476007)(86362001)(5660300002)(8936002)(8676002)(38100700002)(26005)(2906002)(186003)(6506007)(6512007)(7406005)(7416002)(83380400001)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H5mKSe0ZQy11Lpir8nf3zP7kXS7jqATno+U2izPKObaop+vGaPsM111a8zXu?=
 =?us-ascii?Q?9FMG7Jz7/xXBoT7ukTVuB0zYPCc0pGlOJsjKOdI94cFQnO+Q+2p1Si6UsQCO?=
 =?us-ascii?Q?eBCcTA3w7LiYzxemHbxS+btkcn+ZCANE/TZr82r/xiVb2lvRej72/HYtDm5O?=
 =?us-ascii?Q?LA6arizLK2lNI2Dk+HuGFWloNSGByidLXpOj45W/o6beXPWeHAGrBZ1xOHF6?=
 =?us-ascii?Q?UIjmm265MSJDgzAm7dwEySkXxWfwHDJ0Ifj2QUjVzqZ/0HuPQC0Pbwwo4N7e?=
 =?us-ascii?Q?u0McbY7OocHzFM39y8bLRp0VX1pttJwOY5ZgLiGJy7SZ+Uo+d/le3+ToZTNz?=
 =?us-ascii?Q?xuCU/5krRJzWNuWNOgYaBMrllvhuHNtQe1w7UP4f6/JjB/7Waun1oGOGg/kH?=
 =?us-ascii?Q?sZsTb4P8sC+qBoXmmVY6+FPPMdchO9O+nssKrM81HvH9VntusK5qgWeIH+kr?=
 =?us-ascii?Q?tkxxc1/dm/eUZ2gwlRczOnx6HmMcUMiPhdQlLDlSimcU8a4tzoCWdhV0vV/y?=
 =?us-ascii?Q?RDhFADawuHF0YxU1103HjwPVH4qcWczRv1DJVlZOmerdSKEJqq/dcm0p64PV?=
 =?us-ascii?Q?BESB8P3c4zeMHh+ZyHUCqqzL4RRYZ6Xck3//sRhL1u0gZVgSUJgbh+KNbws7?=
 =?us-ascii?Q?hpAwn8ojMTZt/dJN0ErDcdye/h4bsra/GkrnAwezn8YgvfL25OmV4s/5HKSp?=
 =?us-ascii?Q?UZGu2G/dyRjSEVfGawGNeY4gFbOR1/sVbnt/sspThrMueLsIHD2kn6G8YrY8?=
 =?us-ascii?Q?CEBfwJYAL8eYK3VFEcRGSk1ulLZ40VseD+WG6JDB/M4Ibt09cAesVPNPbnoR?=
 =?us-ascii?Q?gsq0b/vdQLUT7UHG9d4Ng50TWNkZlD+NlDC1ygC/CJTri3zmnV7IlbmTWVfW?=
 =?us-ascii?Q?dzdFOxNLxO0UZO/GMjKLVoMIcdgiB0IBnldpYSFP7hsGgT6LkoDJLSiXTBxO?=
 =?us-ascii?Q?o511uYxFRnzvVzBpKgGdL0ZT41Eue2I5CpSFLCBThhGakhmeeycPd0LOGAfm?=
 =?us-ascii?Q?sNz7rScx0rPgqbK3UNqfgw9jab8pGlXCE6HgZTt7ZCbtiKGuK0bh2Wyo2xLW?=
 =?us-ascii?Q?1pfoa04euxWJQtWUb1ichr6SeacrO2yNpzvEePqJcOycCjGVBpJMRceG6jjp?=
 =?us-ascii?Q?EYV8j2TRg1HZa8IjRxCCHMvl7O52HFNUPTpRhPSEd2/4p1ZjYsiCgIfk7AR8?=
 =?us-ascii?Q?JsWRF7hXxaA9e4++KPMFZJp/YRV1QHWWzgF1JuHvCBqlMyqwFB9jk/kbl6iF?=
 =?us-ascii?Q?j0JsgWixOTRY/xc8XTbD7q0C57G4JKi0HKQbFVGVrM13gyz+gW0y3MxuYpGr?=
 =?us-ascii?Q?7dZ2QKzqxg4SsiVAb/XHYWXu9pGBSXyxZ1x2vKip4p4/iKQHUBsQl+PDgEuH?=
 =?us-ascii?Q?a40S+ckhlcDJ9ARf9ktww0dVDao2CsIVoW8KIzdmYvI7l7vU/eUcMk6I5nOL?=
 =?us-ascii?Q?PFkQEcdQU3j5q3T6Xd7bcV7aXaTXra7XzNZh8SugjWXj5Ll+afpYFvT3QN0H?=
 =?us-ascii?Q?G65FEmQYJZhOuB499jyVBbZVWnL1Gxs8S2P/0MGVUHlSsngnXFPcZMM8xC10?=
 =?us-ascii?Q?DN0W3NMF5O35WwcLjxK0cD6EZq5l+nVvpWeiNp5y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cbe4f4-07e1-4b19-9198-08db5b2fa55a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 01:47:20.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X48XPcBIdnxNWEAGs39IoPHp2fHKWl6KVDrZQ0k1TT7I+pfWMOIoY5mMjXS+KhdhCy3A61UEN/Kh7//TIm+oHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hugh Dickins <hughd@google.com> writes:

> migration_entry_wait_on_locked() does not need to take a mapped pte
> pointer, its callers can do the unmap first.  Annotate it with
> __releases(ptl) to reduce sparse warnings.

Thanks Hugh, I debated doing something similar when I reworked this to
not take a pageref. However I was unsure if the pte unmap/unlock
ordering mattered as this reverses the order of operations (from unlock
then unmap to unmap then unlock).

I never found any reason why that would be a problem though so please
add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Fold __migration_entry_wait_huge() into migration_entry_wait_huge().
> Fold __migration_entry_wait() into migration_entry_wait(), preferring
> the tighter pte_offset_map_lock() to pte_offset_map() and pte_lockptr().
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  include/linux/migrate.h |  4 ++--
>  include/linux/swapops.h | 17 +++--------------
>  mm/filemap.c            | 13 ++++---------
>  mm/migrate.c            | 37 +++++++++++++------------------------
>  4 files changed, 22 insertions(+), 49 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 6241a1596a75..affea3063473 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -75,8 +75,8 @@ bool isolate_movable_page(struct page *page, isolate_mode_t mode);
>  
>  int migrate_huge_page_move_mapping(struct address_space *mapping,
>  		struct folio *dst, struct folio *src);
> -void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
> -				spinlock_t *ptl);
> +void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
> +		__releases(ptl);
>  void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
>  void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
>  int folio_migrate_mapping(struct address_space *mapping,
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 3a451b7afcb3..4c932cb45e0b 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -332,15 +332,9 @@ static inline bool is_migration_entry_dirty(swp_entry_t entry)
>  	return false;
>  }
>  
> -extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
> -					spinlock_t *ptl);
>  extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  					unsigned long address);
> -#ifdef CONFIG_HUGETLB_PAGE
> -extern void __migration_entry_wait_huge(struct vm_area_struct *vma,
> -					pte_t *ptep, spinlock_t *ptl);
>  extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
> -#endif	/* CONFIG_HUGETLB_PAGE */
>  #else  /* CONFIG_MIGRATION */
>  static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
>  {
> @@ -362,15 +356,10 @@ static inline int is_migration_entry(swp_entry_t swp)
>  	return 0;
>  }
>  
> -static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
> -					spinlock_t *ptl) { }
>  static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
> -					 unsigned long address) { }
> -#ifdef CONFIG_HUGETLB_PAGE
> -static inline void __migration_entry_wait_huge(struct vm_area_struct *vma,
> -					       pte_t *ptep, spinlock_t *ptl) { }
> -static inline void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte) { }
> -#endif	/* CONFIG_HUGETLB_PAGE */
> +					unsigned long address) { }
> +static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
> +					pte_t *pte) { }
>  static inline int is_writable_migration_entry(swp_entry_t entry)
>  {
>  	return 0;
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b4c9bd368b7e..28b42ee848a4 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1359,8 +1359,6 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>  /**
>   * migration_entry_wait_on_locked - Wait for a migration entry to be removed
>   * @entry: migration swap entry.
> - * @ptep: mapped pte pointer. Will return with the ptep unmapped. Only required
> - *        for pte entries, pass NULL for pmd entries.
>   * @ptl: already locked ptl. This function will drop the lock.
>   *
>   * Wait for a migration entry referencing the given page to be removed. This is
> @@ -1369,13 +1367,13 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>   * should be called while holding the ptl for the migration entry referencing
>   * the page.
>   *
> - * Returns after unmapping and unlocking the pte/ptl with pte_unmap_unlock().
> + * Returns after unlocking the ptl.
>   *
>   * This follows the same logic as folio_wait_bit_common() so see the comments
>   * there.
>   */
> -void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
> -				spinlock_t *ptl)
> +void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
> +	__releases(ptl)
>  {
>  	struct wait_page_queue wait_page;
>  	wait_queue_entry_t *wait = &wait_page.wait;
> @@ -1409,10 +1407,7 @@ void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
>  	 * a valid reference to the page, and it must take the ptl to remove the
>  	 * migration entry. So the page is valid until the ptl is dropped.
>  	 */
> -	if (ptep)
> -		pte_unmap_unlock(ptep, ptl);
> -	else
> -		spin_unlock(ptl);
> +	spin_unlock(ptl);
>  
>  	for (;;) {
>  		unsigned int flags;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 01cac26a3127..3ecb7a40075f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -296,14 +296,18 @@ void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked)
>   * get to the page and wait until migration is finished.
>   * When we return from this function the fault will be retried.
>   */
> -void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
> -				spinlock_t *ptl)
> +void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
> +			  unsigned long address)
>  {
> +	spinlock_t *ptl;
> +	pte_t *ptep;
>  	pte_t pte;
>  	swp_entry_t entry;
>  
> -	spin_lock(ptl);
> +	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
>  	pte = *ptep;
> +	pte_unmap(ptep);
> +
>  	if (!is_swap_pte(pte))
>  		goto out;
>  
> @@ -311,18 +315,10 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>  	if (!is_migration_entry(entry))
>  		goto out;
>  
> -	migration_entry_wait_on_locked(entry, ptep, ptl);
> +	migration_entry_wait_on_locked(entry, ptl);
>  	return;
>  out:
> -	pte_unmap_unlock(ptep, ptl);
> -}
> -
> -void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
> -				unsigned long address)
> -{
> -	spinlock_t *ptl = pte_lockptr(mm, pmd);
> -	pte_t *ptep = pte_offset_map(pmd, address);
> -	__migration_entry_wait(mm, ptep, ptl);
> +	spin_unlock(ptl);
>  }
>  
>  #ifdef CONFIG_HUGETLB_PAGE
> @@ -332,9 +328,9 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>   *
>   * This function will release the vma lock before returning.
>   */
> -void __migration_entry_wait_huge(struct vm_area_struct *vma,
> -				 pte_t *ptep, spinlock_t *ptl)
> +void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *ptep)
>  {
> +	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, ptep);
>  	pte_t pte;
>  
>  	hugetlb_vma_assert_locked(vma);
> @@ -352,16 +348,9 @@ void __migration_entry_wait_huge(struct vm_area_struct *vma,
>  		 * lock release in migration_entry_wait_on_locked().
>  		 */
>  		hugetlb_vma_unlock_read(vma);
> -		migration_entry_wait_on_locked(pte_to_swp_entry(pte), NULL, ptl);
> +		migration_entry_wait_on_locked(pte_to_swp_entry(pte), ptl);
>  	}
>  }
> -
> -void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte)
> -{
> -	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, pte);
> -
> -	__migration_entry_wait_huge(vma, pte, ptl);
> -}
>  #endif
>  
>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> @@ -372,7 +361,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
>  	ptl = pmd_lock(mm, pmd);
>  	if (!is_pmd_migration_entry(*pmd))
>  		goto unlock;
> -	migration_entry_wait_on_locked(pmd_to_swp_entry(*pmd), NULL, ptl);
> +	migration_entry_wait_on_locked(pmd_to_swp_entry(*pmd), ptl);
>  	return;
>  unlock:
>  	spin_unlock(ptl);

