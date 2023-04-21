Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705616EA09F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 02:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjDUAaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 20:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDUAah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 20:30:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971AA44AF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzwQMlF5XsXqL2U9m6ty6lYGQK5tkkAxRXgygK0iyOJZ+sv2yi3jTs/27eeh0DRI9OYQeFBpyUkCZtW4F7b7UvIQTryw96Q77lS4vZ3P5yRmjC5LtPRCm5aMZoCNSndbXKX02A+6vS4wGmRZ+wal186UmJCWsNNf8jI73eZZJe24putxzssr/RPYvViNUmluSrLYCtKewLinP+Yd11aQoNIIk1TQwhIFaoVJkwzjqShdaR6cdFI3xZdNYjDUXwOJDnhPqlj65hhuaduxQ5RQML/O2uSlxCiLS378D3TfgcDWQkVYF4jAtE6zlxYx+q2iwZr3FnIFk39xaMngQ2Q3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xIwN33R/138tRfU0eyeIZ+I7vDxnRU5NBEala8oVLk=;
 b=TPg3FEm7hteyeGqdp1TUzGkH5aNOBXN3LAGO9kigHY7lyzSItfjaQV/kriWWYW+uoI2fjO0KZzkP5oqt01t949L4xfvsLvaB5gj81JbSgkMAB9XCLIZaD+El2wfAY+j+KGOSy1F6GK8DEjcvo9jZkOlHsQZCE0SFgDtlBFjAXNXR0H+HRPlyTQtfO2qfPCJ0CCc+jP+gzXZEPWqfLK2jY9JBrAdKKqdiNFT+SvsMwL0eJ6NqDGADJZA5hgn+f+rzxW5yX6XZLYpeY1CxRZTMCVHnsWOPc5owIKEEX6P975W/x6DTrUdnPv3Z+g7H38ttgW9Gtd/b8zup477ZZVEwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xIwN33R/138tRfU0eyeIZ+I7vDxnRU5NBEala8oVLk=;
 b=Wlk3BPypFtaiY39PyWQWJiBANkGvS5ECUGL77Rs3LXyfIYZ/gJ14ReErSHWnqjTtZI+wscWeurqIZZmUytRgTxbTzWNfIC9wuGkVB17FN3L89aP7ykaP41NXJ3LnGthnO0cb1mvvMOIW2/ACqz+6F92AxuTD6rRF+Q2GTdCINuAGIwtVPHqm/rQlwWCWudfEq6jMrlEgbXzX2QpngEJBBoWbInoP8R5OXEQe3HzqBizoOAsoaQ0ClWLP9RXDzNe79T3/JKGtHWAHySsJMLgqqXnam7JOH5yTWPQjjKbK3rEvtrJ+wu8bp3AtW18xx4hepVZxGOFn9trmmi1gSNf5Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Fri, 21 Apr
 2023 00:30:33 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f9e4:206e:75c3:eaa7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f9e4:206e:75c3:eaa7%7]) with mapi id 15.20.6298.030; Fri, 21 Apr 2023
 00:30:27 +0000
References: <20230418142113.439494-1-david@redhat.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH mm-unstable v1] mm: don't check VMA write permissions if
 the PTE/PMD indicates write permissions
Date:   Fri, 21 Apr 2023 10:30:42 +1000
In-reply-to: <20230418142113.439494-1-david@redhat.com>
Message-ID: <87v8hqdqlb.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:254::32) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 428d867d-dd60-41e4-fef8-08db41ff9ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnUSLteTHnqg7fi9c3bPVoUw+ytBlppUacOFnUmmhCdGqNu23fM1dQnyiwXZd6+BBcw37/jhmAtx7zVUafvuUemojZ2RlqGCwN3jmYdzoI11a3IENMKVSpkIhFlPEqJMcIodJ3//kauwRPlrx5RgYRyDL56WAGOxJcMFjfTAptpOWLZ1UQD9FhNj5pq6/JJLNx7siv3xc5PSTXGWw8XhIWQVBBEz1L2vlXPXpMO4yia6AljVvygSvTSNkL+xLXiIhcoHDPm6q9wUdUzmQXutD+KYWWEy+RiJzJEzowW9Cv1xg5f+3LYO3mm8uiSYK2vDNylL12UWtjipQ8SuJE6m+4YkkoJBLkDjQWFAsK4uRa/9ZGD7M3NaaBG9OVGxkX8R2xiux+uY7B3oSsVhEq8+pCsPo0hMG22JEyOD/MBPkq1cnfOmWvNf0qmKqxQAGwF2Ex3n9ZZZBJFF8C7B6GwRRBXPeK5h+3D1zhwu1sfauW9fxz53U9mMvxPknQsIYIxx4yjTtLQzPronrVfCdEpg8byviXmfGIwXty/hA5b8bYx58M+rI3cbIOPTB7KqFjUhPUJD4+l9G2UDTA349GCLrFxN7ydrF+FpQ2R2g0Z1KRepGXl7AjmNA+4AvGi3VFY0SZKwYRh1r3Fj5Txqqok2fA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(8676002)(38100700002)(8936002)(5660300002)(2906002)(36756003)(86362001)(478600001)(6486002)(6666004)(54906003)(2616005)(966005)(186003)(6506007)(66946007)(66476007)(6512007)(26005)(316002)(83380400001)(4326008)(6916009)(41300700001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4QNuJ7MQSammzvZm09tUADk5tsed5f7XSnqGBYUqhKgqxCk4sSt4Nl8WRM8f?=
 =?us-ascii?Q?o+oQAKPUqKYWZk3IV2wTXewu0y1rEHj5fJxdDKLSGCOGp6oQCJE9AxVyY6xF?=
 =?us-ascii?Q?Ni0SPoUJBcB0NJDILQh/ANzkwL9B0uZisAqDfsYgwc4zpOIsPla1UzvgdHID?=
 =?us-ascii?Q?I5soexuOEowoAg0XMEuP62mbdiCwbVdbopYpcjvoRNAInOlj8ZR3VVzlkJ3A?=
 =?us-ascii?Q?u5rQkzY7frc6O2evdObwaGT0Cwj2P2W6G6HlHEKEWvyDzYsquvog9lhLyeaG?=
 =?us-ascii?Q?ThGK20b972y4JG+12PUfFMrfiJFGvSAS5l8TRYZ7aFQ9FBfYCL/z9VUConAb?=
 =?us-ascii?Q?3I51L8sQvBn79OdULrIuLU+3tKwEMKkg9k8/u+fnDHg0R2RbVnT2XFx0XNPx?=
 =?us-ascii?Q?arY6GoJkyZTKUs0wqv5tTSAHB+mQmr5AE+ftBtNfVUVR/0j5QpVKBHtx38Ek?=
 =?us-ascii?Q?qI8rZl/YS6O8bVErY3eAlO8bRCjXKlypLreIYcIs0FgZeWgHQ+LTcNw4BQ8b?=
 =?us-ascii?Q?5A6QZ9MRdly527wGuxQ73mwYynnPRH58hudUNtzlGUfbfMVlP0JZetF8AoQN?=
 =?us-ascii?Q?viLvyEuYkxTYKvdkX1fmE13hdDl+lPQhqpp6LAuusKpFryQlKpgNOz719zI4?=
 =?us-ascii?Q?my87GtUnqqXs5st3zCqwK6pFCQnVySkNDg0E3nLDc3mRFCALRyp8Ro7NGwVD?=
 =?us-ascii?Q?NvnilfEOPV4QwZXPmMxsXDnVvOSEWrNUlpZqCXC6Xq0/2hwkxSIgY9l+ODxD?=
 =?us-ascii?Q?NTwrIsPV1/n3xoZ9DmD0jAMVeBOe48CjJ0PZVHO/EMC7Kn50GLX7VxdFXVj4?=
 =?us-ascii?Q?2MpGkMmaFPMTL8XEF07jqhGNIuzbLXfFFrU0+a7um6TMWKqzFuFaRR0e67lo?=
 =?us-ascii?Q?JiVIQW5lm6UfBgXOZK4vNt3HjwaNMH4QHdBVCKLZKqjjfuTvf+Fta7JkDOga?=
 =?us-ascii?Q?5kJzRiZmN2Lv3jcqeVGYdD96ietSWLTb5MX0rB9zt5HsGMfyABIML07kWfb8?=
 =?us-ascii?Q?Lbclx4lLGfVKaZd8+rvVhtQFw88Ei5MvgJPKkjyeiXLJ61V8IxXtOb3jgce+?=
 =?us-ascii?Q?Cz6hoI97g8OzBgj4rFr9DlC5DgTenrGarSSxIs+NwWmnF1wvSNmoOXHfF7Il?=
 =?us-ascii?Q?+sip3vGps2YguKTTEdYrgNB5xeUT6HsNDp8k66VpCVQCadHLJezxLzT8doZO?=
 =?us-ascii?Q?gfX6q1KCJukU4NVhAWqSTLWIevPXGtjeMp5uxrhw2CnBJBvWWxTRuRsJX945?=
 =?us-ascii?Q?+L2/H8q0HGYm3ZE/+qH2Rz3Q3Q9q4IsbCpfEd2boEr07Pq7I8PEhbT8N9vs2?=
 =?us-ascii?Q?Lhm8LgxR0R7DJfPeOICbPFcJawUKFO3JtxvwW7JXiL3Z7u9VTH84zBGIEwF6?=
 =?us-ascii?Q?1K2+wQ6jqx6jrreYoG12Hp3JyvEiSafpCAkPmD0JlVjYqYhkr/luGbtDSYb/?=
 =?us-ascii?Q?qGc04oIqkNMu33jJeoK2rRyo7NypFrKyeXU34VDzQ8edF9fBz7XQDi+DtYwP?=
 =?us-ascii?Q?9Ao81tpObGvavRPIjAQe0wZIuOKeoa6GxXU4QHoD83sRpKcj1cGvYhptvXS2?=
 =?us-ascii?Q?2yLoDOJf83LajorARsC5REyEsMqAm6jrSNZ7xU6N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428d867d-dd60-41e4-fef8-08db41ff9ad6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 00:30:27.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZHcOKLCWrCFAB9GzRd1GMI+YznfbuAewEGLA5NWZh/gvCjsEROk4GNGNe+aT8UHEjlblYbnomt2rc9NKzIFSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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


David Hildenbrand <david@redhat.com> writes:

> Staring at the comment "Recheck VMA as permissions can change since
> migration started" in remove_migration_pte() can result in confusion,
> because if the source PTE/PMD indicates write permissions, then there
> should be no need to check VMA write permissions when restoring migration
> entries or PTE-mapping a PMD.

Thanks David, I have oft wondered about that but not stared at it to the
point of confusion. The change looks correct to me so feel free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

For the mm/migrate.c parts. Also presumably if mprotect(PROT_READ) was a
problem then mprotect(PROT_NONE) would also need some kind of special
handling which I don't see.

> Commit d3cb8bf6081b ("mm: migrate: Close race between migration completion
> and mprotect") introduced the maybe_mkwrite() handling in
> remove_migration_pte() in 2014, stating that a race between mprotect() and
> migration finishing would be possible, and that we could end up with
> a writable PTE that should be readable.
>
> However, mprotect() code first updates vma->vm_flags / vma->vm_page_prot
> and then walks the page tables to (a) set all present writable PTEs to
> read-only and (b) convert all writable migration entries to readable
> migration entries. While walking the page tables and modifying the
> entries, migration code has to grab the PT locks to synchronize against
> concurrent page table modifications.
>
> Assuming migration would find a writable migration entry (while holding
> the PT lock) and replace it with a writable present PTE, surely mprotect()
> code didn't stumble over the writable migration entry yet (converting it
> into a readable migration entry) and would instead wait for the PT lock to
> convert the now present writable PTE into a read-only PTE. As mprotect()
> didn't finish yet, the behavior is just like migration didn't happen: a
> writable PTE will be converted to a read-only PTE.
>
> So it's fine to rely on the writability information in the source
> PTE/PMD and not recheck against the VMA as long as we're holding the PT
> lock to synchronize with anyone who concurrently wants to downgrade write
> permissions (like mprotect()) by first adjusting vma->vm_flags /
> vma->vm_page_prot to then walk over the page tables to adjust the page
> table entries.
>
> Running test cases that should reveal such races -- mprotect(PROT_READ)
> racing with page migration or THP splitting -- for multiple hours did
> not reveal an issue with this cleanup.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>
> This is a follow-up cleanup to [1]:
> 	[PATCH v1 RESEND 0/6] mm: (pte|pmd)_mkdirty() should not
> 	unconditionally allow for write access
>
> I wanted to be a bit careful and write some test cases to convince myself
> that I am not missing something important. Of course, there is still the
> possibility that my test cases are buggy ;)
>
> Test cases I'm running:
> 	https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/test_mprotect_migration.c
> 	https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/test_mprotect_thp_split.c
>
>
> [1] https://lkml.kernel.org/r/20230411142512.438404-1-david@redhat.com
>
> ---
>  mm/huge_memory.c | 4 ++--
>  mm/migrate.c     | 5 +----
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c23fa39dec92..624671aaa60d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2234,7 +2234,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		} else {
>  			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
>  			if (write)
> -				entry = maybe_mkwrite(entry, vma);
> +				entry = pte_mkwrite(entry);
>  			if (anon_exclusive)
>  				SetPageAnonExclusive(page + i);
>  			if (!young)
> @@ -3271,7 +3271,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>  	if (pmd_swp_soft_dirty(*pvmw->pmd))
>  		pmde = pmd_mksoft_dirty(pmde);
>  	if (is_writable_migration_entry(entry))
> -		pmde = maybe_pmd_mkwrite(pmde, vma);
> +		pmde = pmd_mkwrite(pmde);
>  	if (pmd_swp_uffd_wp(*pvmw->pmd))
>  		pmde = pmd_mkuffd_wp(pmde);
>  	if (!is_migration_entry_young(entry))
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5d95e09b1618..02cace7955d4 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -213,16 +213,13 @@ static bool remove_migration_pte(struct folio *folio,
>  		if (pte_swp_soft_dirty(*pvmw.pte))
>  			pte = pte_mksoft_dirty(pte);
>  
> -		/*
> -		 * Recheck VMA as permissions can change since migration started
> -		 */
>  		entry = pte_to_swp_entry(*pvmw.pte);
>  		if (!is_migration_entry_young(entry))
>  			pte = pte_mkold(pte);
>  		if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
>  			pte = pte_mkdirty(pte);
>  		if (is_writable_migration_entry(entry))
> -			pte = maybe_mkwrite(pte, vma);
> +			pte = pte_mkwrite(pte);
>  		else if (pte_swp_uffd_wp(*pvmw.pte))
>  			pte = pte_mkuffd_wp(pte);

