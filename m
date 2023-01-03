Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D573965C764
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjACTXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbjACTWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:22:44 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6536913F67
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:19:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgcAKNt0aasvKwzWYMW/jf6sfPJBp6OMoaZRv96Ozbk4Y1vhIYsxICJh0qfX/lN3JD74GYx0LBxt892BeOycwoPhxT61qdt9oc8exdosrryniYck7t6k6lmSy4+4b7u7kSVNX6Zkqz1Hx7tXQFIqguc70G5RV47u7vM4oXvC4ek+4YjNNMdblFeUKUrvtYzAZQTpqa1cGcTlCs6wLoVzsOGeDjOMeP+mvEtfaPd8UHQBTBbRidHUKXyd3ifp+1XcKw4/WXstN5IypZEivmpxGD6GnVJ8Dq3yb7uxs8qXYWY0/GPkppZkVszqQA/P09z/78N9/Tpv4ALxTn7oAbzrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKK69wQPfzzw8INee/l+V+Geo2GCya3OZoG1SfPKR6Q=;
 b=V0ANa5HuSVW0eBZbkjfS/M4L9JssddOSRkmKJnxR0suTD9j129gcRCo3lxJbT8ssMn4gqx9XlfbjFHrpkiG/N2VdAFs+1QiUSdU746Ykg4twJyABlKQLAUc5lAbZGlne95hiYlyIVc6EIoUso7r15Pgc66YWKWRRRfas26u8ReLnyzAp1eOYXbshvnUsHmROzziWRVxdSFXWYCXU115heLPZW6Ne/Y7YdNj8x+WRBzrmniYumVEN2vvKh2DB79CstdfzsAlmRBamUQmhyIammZOeazI1sMN0eg6G6IfLzcLwVZIL5XMyhEh5nl1KLhIDtVyq7FrGFKBYiV21MfBXjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKK69wQPfzzw8INee/l+V+Geo2GCya3OZoG1SfPKR6Q=;
 b=VvRvz+rzrq/+YEjbH4BV2F6baOQ0BDgMCYf46ySfW5XBRIfDfrTwPRiLwqVX1z/Fv/UZv1rcG2OCx2xQewU2dyOa0e/s3pKwlcbyi6numQnqLOCxd/+AEx6eTUPO7fpgLzDnKAPzVi5vEdDWA+P0erDqDhDVIPxvpe+GR7PtwtJJcI5tplRKfrmj+VIy62Nn1/MUOLW5TNZuOE9JceGT/B9WNfXcc+0cq3CWdBzEYefA8nKixlFnJen58Ti3GQkwCdub0YwNRjpbhb/jHSVcu8wfHZG0+b9arP7lOOoryW9mK5FJ6rNxQHmwCOjF7zl2DnlXtlTtvHJBIKaEt+v7sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Tue, 3 Jan
 2023 19:19:26 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:19:25 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 8/8] migrate_pages: batch flushing TLB
Date:   Tue, 03 Jan 2023 14:19:23 -0500
X-Mailer: MailMate (1.14r5933)
Message-ID: <D8F02562-AA7E-4868-BE58-F1144728A352@nvidia.com>
In-Reply-To: <20221227002859.27740-9-ying.huang@intel.com>
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-9-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_DAC7ECC1-5441-47C2-A18B-0B75A3DCF71A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BN9P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::24) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f957f7d-c5a2-4ede-4847-08daedbf6d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4aSPn2nzhnhMNJf3uQGus4fEiiiejRPeN6HSF5pireNoIePF50sA0Qn+K3XV5PRa/QD68FhELTbkMiU+EAQeHmlzc+p/a8HP/XBw2d9SXyvKpcdExwYF9rWc+J0S0NFe/hVgY1Ld1xzpXYIoLZLfV4sdJU0YmIkIi6n9ms9AjaM2gf7BS3dQ607YEymuDS29UhNj05nYpGLoAS6wxo36DJIYlBldU8l3Lhheymnuu90EHYCmuzXQsfOC6491j+Jp1VPRlx/xD2ZqP4+7RgJthQ6nTk+sCMU4uUvi1rpOO0LEA+/4ZmZuTaBgFXCOajSLF/SiHJ7RzmqWOwQq3ADLE48iEc4yW2Hdgm3s7QKFtTKerI/fFqvkgyhpS1kxMJqJtjsTex06KUHlxxHlvZMJuQdN1akaYxe0JYVKDNAPnYyWmjUv0TJ4jLgb5g63IExAGuR0+V/DI6cFEar3V8imDj9rWnmgQWYnZGjQj0YFSI/QxBxkR2hoy/LDas8z45lC9VTOzRoUodARSz54UDiLKR9eKyWwbVCf66shZ8B6kMbAh6YWBYADVbLWeExYKBXq5jb9jTgJ/3+e20Kg3KaxnUgA6fUn8zMHdsAyn9W6LqZA0Gmbq9bkjmI922mYq3WkuINwt8tJdtXBCzPp2kgnJqE76uWK0Pw0G8nbVGn6bO6XH/q/qumg0winT81sf8eLiBlXSG3Dfekpbox5Ge9+2RlIn9V0IH+Uk1fkwGBoanFVpv5L1Rz9DkxhJvwDR6VT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199015)(83380400001)(53546011)(66946007)(478600001)(6486002)(6506007)(36756003)(86362001)(38100700002)(26005)(2616005)(33656002)(6512007)(186003)(8676002)(235185007)(7416002)(4326008)(5660300002)(66556008)(66476007)(8936002)(2906002)(6916009)(41300700001)(316002)(54906003)(22166006)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UnBFvg4P5eZnsnuh6uCNoKGdlhyXao0p5wwOfxX8+0c4f1s43h8x5ahoFPkc?=
 =?us-ascii?Q?sg+1BgmG2jqsHRZ/o/xPQwCojrxk1mYWz+1YF1ITzpCCoB+SMhvA2KZ8ncc9?=
 =?us-ascii?Q?DSKSFSI8GAfjJsUpQtHwvTATKwyvXuSjb/x1G33rJnVOSZ1mpnx2JxbioIHA?=
 =?us-ascii?Q?85x3gGo1juaRBwI9X4oBTQTbPncN5akX6PMRLD9FCgvujyxBxcQ7UlneVYxg?=
 =?us-ascii?Q?OSX2dFGZreN7sJyQdjFiNaPQNOQ1EH9ThtbUEWNOh/iwy1YE5kHEFsMrvcgI?=
 =?us-ascii?Q?KjNAxfLFTPbBtEm4lwst7aJcPEusTgmRktq6zio0qE+FfliJFL2EWfd5UVvM?=
 =?us-ascii?Q?mQNH22Y4vTDz4SxKZPb0jXT0QtkbLmD/XOaeNoWRTLKH1d9/TCYFDpQ9PRud?=
 =?us-ascii?Q?rkjSsqsD0IUULHhcB3TAgRoP2aU40q1ROh51JuyO/kGInzoJPWF3UgjH90J2?=
 =?us-ascii?Q?w2xBqMclEiuKNRhCCu+qdOyA33kzq6yzROesQNlJZR92g/f+mfzXObQhrO1B?=
 =?us-ascii?Q?+4C5pXMrjFHIMnZkLUFvqinG6lS6QOLjK5torrJQiMG5o0nWnhzbQFK5brGd?=
 =?us-ascii?Q?1vpEc3UFuu1CVLAifoyxs732wLhuGV8vTVEk/8H0uOPvA7+03TNY4nluOTCc?=
 =?us-ascii?Q?2IGlII1obOzXX5r1fRWAg6uN0pVbIxjOszXkSKKINSVY/6eqtWNK33IrkLZO?=
 =?us-ascii?Q?NjsyDEWUEEh+LOp8mWpGwytmo9Mp1ZBQ2rmTCZjoW2W9AoiunE2TQZUsfURY?=
 =?us-ascii?Q?lnS+JzdrCfVJwfksI7CMEE0QrMNFCiwuHOts8yVSF6HjBwIzo2mrLbOIwVly?=
 =?us-ascii?Q?o+0P+p1itCglfhbbiUpyO3EXm9XYcwjBDwP+XoloO731N1ZoxYuUEuuy2VEB?=
 =?us-ascii?Q?dF64bZ5/KCCFcY+wnwrY3MdXFxa6LPV4R5uYyk9oR6G5sMCPNkDJFqzsw9Qg?=
 =?us-ascii?Q?axfk1X2LxvSunlB/SEYf7lggXu1gKLcAUwMQNkNSIWpmTT5TyS2QH50G1GPt?=
 =?us-ascii?Q?6cERYsUKwBPGwxxT4cGIq3vb8vU4Ja4VQ83woDQiuPjs4oyha3pGcHgflBYb?=
 =?us-ascii?Q?ZgzEoP5LDcaPOB3v3LtiSTWDw9X941CQyDHKnU1RkB9+l4+ORf0XRoNn6M87?=
 =?us-ascii?Q?uxsvCvrKAMVSGnY6JSUc9ImmcNeg/wDMWRKnMbfILMohYnxpb6fpGyYletJE?=
 =?us-ascii?Q?HI0uMB0w3jTUtw9219Kg6Wd/fiFs1gBrJL2K7cpXIggEx+zFoJ1AJDJ/GG20?=
 =?us-ascii?Q?cniB9YkK3s/iKNnLTwxLMfZ4IvYT6fOAymD6/OEjL0gbuJPq9QEdoF3Nt9Li?=
 =?us-ascii?Q?gLiv97691uW3jSA41mxICX7linkk6QE+WyUGdVUC0zNFYsh5EgqjaCFTf+lh?=
 =?us-ascii?Q?/l0+ST6LTFJqnK3PZY1adsxzlr28QQwaGnrKKSBYCWxu7UgaxPV8La3QuceZ?=
 =?us-ascii?Q?zsyEka5HrHjSNCLmXS70vXSflSoK8955RWRul6kj36EPWQHHz9miKmQ64LtK?=
 =?us-ascii?Q?NBbCHF1NsXDFArlbKSymBXx0ezjZWOr2aQccHSjwmOhG+qIolHUhXhS3xu2d?=
 =?us-ascii?Q?a6Zvo/B7dVNELTmv5w0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f957f7d-c5a2-4ede-4847-08daedbf6d60
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:19:25.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIG4JMkyAme9JuEMDsrrQYc9utcvmT4gdq7T04Oo4NYhJpLA3entmdijm4DeIN6r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_DAC7ECC1-5441-47C2-A18B-0B75A3DCF71A_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Dec 2022, at 19:28, Huang Ying wrote:

> The TLB flushing will cost quite some CPU cycles during the folio
> migration in some situations.  For example, when migrate a folio of a
> process with multiple active threads that run on multiple CPUs.  After
> batching the _unmap and _move in migrate_pages(), the TLB flushing can
> be batched easily with the existing TLB flush batching mechanism.
> This patch implements that.
>
> We use the following test case to test the patch.
>
> On a 2-socket Intel server,
>
> - Run pmbench memory accessing benchmark
>
> - Run `migratepages` to migrate pages of pmbench between node 0 and
>   node 1 back and forth.
>
> With the patch, the TLB flushing IPI reduces 99.1% during the test and
> the number of pages migrated successfully per second increases 291.7%.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: haoxin <xhao@linux.alibaba.com>
> ---
>  mm/migrate.c |  4 +++-
>  mm/rmap.c    | 20 +++++++++++++++++---
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 70a40b8fee1f..d7413164e748 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1215,7 +1215,7 @@ static int migrate_folio_unmap(new_page_t get_new=
_page, free_page_t put_new_page
>  		/* Establish migration ptes */
>  		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
>  			       !folio_test_ksm(src) && !anon_vma, src);
> -		try_to_migrate(src, 0);
> +		try_to_migrate(src, TTU_BATCH_FLUSH);
>  		page_was_mapped =3D 1;
>  	}
>
> @@ -1732,6 +1732,8 @@ static int migrate_pages_batch(struct list_head *=
from, new_page_t get_new_page,
>  	stats->nr_thp_failed +=3D thp_retry;
>  	stats->nr_failed_pages +=3D nr_retry_pages;
>  move:
> +	try_to_unmap_flush();
> +
>  	retry =3D 1;
>  	for (pass =3D 0; pass < 10 && (retry || large_retry); pass++) {
>  		retry =3D 0;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index b616870a09be..2e125f3e462e 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1976,7 +1976,21 @@ static bool try_to_migrate_one(struct folio *fol=
io, struct vm_area_struct *vma,
>  		} else {
>  			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
>  			/* Nuke the page table entry. */
> -			pteval =3D ptep_clear_flush(vma, address, pvmw.pte);
> +			if (should_defer_flush(mm, flags)) {
> +				/*
> +				 * We clear the PTE but do not flush so potentially
> +				 * a remote CPU could still be writing to the folio.
> +				 * If the entry was previously clean then the
> +				 * architecture must guarantee that a clear->dirty
> +				 * transition on a cached TLB entry is written through
> +				 * and traps if the PTE is unmapped.
> +				 */
> +				pteval =3D ptep_get_and_clear(mm, address, pvmw.pte);
> +
> +				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
> +			} else {
> +				pteval =3D ptep_clear_flush(vma, address, pvmw.pte);
> +			}
>  		}
>

This is only for PTE mapped pages, right? We also need something similar
in set_pmd_migration_entry() in mm/huge_memory.c for PMD-mapped THPs.
Oh, since you limit NR_MAX_BATCHED_MIGRATION to HPAGE_PMD_NR and count
nr_pages with folio_nr_pages(), THPs will only be migrated one by one.
This is not obvious from the cover letter.

Are you planning to support batched THP migration? If not, it might be
better to update cover letter to be explicit about it and add comments
in migrate_pages(). It would be nice to also note that we need to
increase NR_MAX_BATCHED_MIGRATION beyond HPAGE_PMD_NR and make similar
changes in set_pmd_migration_entry() to get batched THP migration support=
=2E

>  		/* Set the dirty flag on the folio now the pte is gone. */
> @@ -2148,10 +2162,10 @@ void try_to_migrate(struct folio *folio, enum t=
tu_flags flags)
>
>  	/*
>  	 * Migration always ignores mlock and only supports TTU_RMAP_LOCKED a=
nd
> -	 * TTU_SPLIT_HUGE_PMD and TTU_SYNC flags.
> +	 * TTU_SPLIT_HUGE_PMD, TTU_SYNC, and TTU_BATCH_FLUSH flags.
>  	 */
>  	if (WARN_ON_ONCE(flags & ~(TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
> -					TTU_SYNC)))
> +					TTU_SYNC | TTU_BATCH_FLUSH)))
>  		return;
>
>  	if (folio_is_zone_device(folio) &&
> -- =

> 2.35.1


--
Best Regards,
Yan, Zi

--=_MailMate_DAC7ECC1-5441-47C2-A18B-0B75A3DCF71A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmO0f7sPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUfBoQAIoPNPOReO3y4EFXLbUrsQNYlqwwxnvRNNXZ
9kQVuWs3aRu2OkuK7IUk+Li5ji2jc2DlyZQNfY9nmc8OuPXfrrz6SDXNPt2CfSlI
C/kLZGw08pxareN6M7mSynQipMESpHcq78g2n1HxjT2k7E4vcM3qOkvVJ+QMs+tS
fu2m/lXie2/njGQ+/InRmXJTKYeh4OJGYstmMQ5qfAhQSjs9AfaggmIxRSqQAtj+
klBTnZWS8lKWNdPKR3RZ3fc0fhAkGZZjf3RI/D4/xse3ZAYDq/LkbIfNT84KyrfO
77eshVgb8gSTcaEV1pJ9tcuXwI6BLajq0y9dAC/pIRLq7FgBQ3Px3nfoVhnLtP5X
Yi4ePOygo4s2SiNfILOohO7YwZNqZuyvzg7VROGrHnl6dznD7h8lTeXeAhaJXxKs
8NrbDLuZ6T3J5Mxy1ZfPlKgQh/KEw3cPmhlZU8fTEXzeF0eEYV0n1h7vaY6jcQRb
+Bl6gNjqLBLQGmeVr11Gvo/1ohX10uMgepy17eX+BSh5LGHX94hIH5S6qgp5npzK
m9pcZWlM4/Hi6S9xktJNqJCrIV2q2c5ASOHGzwxY6LmIzDkMpbDI7uPpVuHLub/9
NWLW319lE5t8MjhY85ekfMoqMriSRWxQ71GnhGLN8eVA/r9F1+sheK/8Qsex8ktO
oXyqp4Uv
=WOgm
-----END PGP SIGNATURE-----

--=_MailMate_DAC7ECC1-5441-47C2-A18B-0B75A3DCF71A_=--
