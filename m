Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042CF68DC1B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjBGOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBGOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:52:35 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2737EC2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:52:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCNLk7LSQxWEVhd26nnG/gGB5KaaHE/mSH4WmV3PQ8sB97D2wmG/4mvyW6ferIRzl6f70SCrZMIb7Sl2Sc0FxSLzznbawpPhjJsWU6VWN4vc9nFTEkwGQpjbvEzW/MDmuve1jE3UJ+D1T6hFxN72u7oE35C7vSGqByOCfgd3htAT3flHLsRQ5dv2CiiqspOm/yIXi9Vt6I9JrrtyO9Z84cccM05HPignzz/A8oHY/fHDvU0CJZEP2Aod/4K0SRvMUOJIuTwyycrENQHocJvdlYifVl3yat+IT9/dmGo8XuPi7IRW2+rQmUCnCMfuiNBUfMBw7xxo8OyQ20mbQ24wKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNArdYVwpKkeQwoz5CgHLIvsRmCqTFjE3u5YWNPm8mI=;
 b=n9Ob3mWdoyO3ZXlbbH4S6crsKqwJ14B/K3ps2jPrAW8tdZcDO+ehfQK6ZzTVWp9MFRiGHJHW9jllakTyhyPEm9ozHXBgfSWHV254+220AdHnJO5UZKEZjp7qp7k0xQElaAfOS+4D5M2U7jv+WDU7klqpZyjIkitWY+EizW/lwwxxBhKgtSlrqjcYenARxyuj6k8zo63lwX5Gi/M4zQuwrX3vSLQ7b8A/gYzqLHAqL7rKsMNWicBwFYL6O2GDWE6A7OHTPO9saJ4EaNhn9oD0uLdeJebVlO+w4VIu/ZtVcPloWMGV6ZnNeere9LGZo5OTtFZz2UjcrAs265CglLrlbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNArdYVwpKkeQwoz5CgHLIvsRmCqTFjE3u5YWNPm8mI=;
 b=FtoKN8gwfkCuq+RHgNNmYQ6majcHiNeosVzwJlZqEo8euMcEUK4x+bk70pQngi5MYvZyZi4B/eHocyb+UkR9dajo9AcwfJ3u0fbPew/Nb9rv9Z8QqkPHWWXqH5PgKJlhUYWKWvo1GnTkGrxDc2lcMERecx1+tqv7jLjy9FBooEQO7o40q/f68xxxAHtHSsE9Rhd8guCa4bbYs3wNer4pkLzsAAi+AWKhiF78MkRZgLYDvw9M5mIEiaz+PYQFs7sXcJv6PhqKYu7ZKXd/804ZHzRrr1HAi9ho6KbWsTWG3avG1CLSirz1ts5hPebIWEqezxGbG31/dPUxdBsDSvmbPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Tue, 7 Feb 2023 14:52:31 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23%9]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 14:52:31 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH -v4 8/9] migrate_pages: batch flushing TLB
Date:   Tue, 07 Feb 2023 09:52:28 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <E6CE5A79-E1B0-4FCB-94A5-EE268C160410@nvidia.com>
In-Reply-To: <20230206063313.635011-9-ying.huang@intel.com>
References: <20230206063313.635011-1-ying.huang@intel.com>
 <20230206063313.635011-9-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2696EDC7-7B4A-45D6-A749-E4523F28BB1D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR16CA0034.namprd16.prod.outlook.com
 (2603:10b6:208:134::47) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 6128455e-725b-41d8-b510-08db091af08a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGJgKQHA1HxZyattZz3ccY9F17fdU7LNg/fA1K8doLfTpl0Ru1TtDX6qWGJIcs7NYdWw0e9b0Y3CgkxdO/OUwX3OHQ+6U0wLS3TsItRh5GbDrM+oPFy/VHk3DoIqnK4HqstesiFxRK6ODeWATbPKif4r5PwNRvEpXsQfC4rOI+JdDmoP5a4y+o/6e1/Nca/KNdEvPNOfLDJjb7hHJIGgzSYFn6dslMUeHR5d/hxB4aH6GVQ/xkuRBjIdQ9/TgdtKCBAHxbPB3WI9rlw2i+ud83/8nHVzpW8unRt0PjpK64aPlJjAsrLHbMPsY0l3HXg0GCz74xc+J6Jc4B6xR7E5TBDo7Ordhw7Srw3UsoE1o1nbZ8gAtABhbXhGmgZTiAb6pWzIi5DFeUHVOKtEjJcOD8Zo6Pf/49ZXVMrPZr76FdRb9TFyzJVGUEVvrNXHZC/bZWHpPRCTSGhW8WvFRV2aByACIAFMT8EdEZPeVQWtreT9ur575kfj45ikm4wzKpf+mS4IxZB9FgB1o58uJ6LrkgpZDAPPhCEQAaYsBAJ3phxek2yZr6QJHGNrgT01jvfKQyCPRLinB+ShVDD2ktaD89m+mkHrauszkUD7YJQNIIU1LfJ/+sGaIRENmyeF/Sgd13oa7obtxwMVrO2YQu6/DbJqRjGXnMbCXu6SXCM+9hxVM0HtDDGVEcSESpeds8Y9X0Xtyq9L/s3PS/5narZdOR/lYDQ++GnZy5cqUVBNHbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199018)(38100700002)(36756003)(66556008)(186003)(4326008)(66476007)(235185007)(66946007)(8676002)(316002)(54906003)(26005)(6666004)(6512007)(6506007)(53546011)(5660300002)(6486002)(86362001)(7416002)(83380400001)(2616005)(6916009)(41300700001)(33656002)(478600001)(8936002)(2906002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yiyfLYYm8HxMUFI3PfZ8Do2L+PNHrj+a+ta2zPs8DQzGzY7TZSIk1o7Q4MQu?=
 =?us-ascii?Q?WyOxbupyGQE0FQBYzASTpi++LDdc9KzELAUFl+KQrILQ4vvFEFBKdiyZlDEW?=
 =?us-ascii?Q?e6JO/GiQHge7UX1OfUgFUt+axWH96W0wCon156FJJ8RFgK4Qw8U1VrAGy3rW?=
 =?us-ascii?Q?S6SeRodbEvHPPW8x4L6P+j2UDJTpDazMp2bQVs1dhs2SDjHqgEh+LqT4x1XC?=
 =?us-ascii?Q?UQrQMXYmDVhhuO1JJvMlrqvSz1kxXdP0k2VdK2sReTdwiHsW2CEcNbfr9Ygp?=
 =?us-ascii?Q?IuKYb5CZajsz8QvQI75FODoSB0DYrrOdaFP7NTgFLpm5F8tsGMa+BQFDxX1I?=
 =?us-ascii?Q?NsdAYWWeaxUk058h8VkrVNpmNpidoHJY4Q85lfAnMvoyADYqg5QgfqCWIrOW?=
 =?us-ascii?Q?fErotIFwogDRxC9LN3veFhYyDA6yWb+xZ+awBSZ4QA8AUuLdqKMRZWCHnnzs?=
 =?us-ascii?Q?sqGMm8hy3Pd8wq3bvM/st4Jpb3gtXPNWa07ogPGfDg5eihr12Ni33afBXyW8?=
 =?us-ascii?Q?nf/bki1HwnC4GRzT6O18pPRZB4VJw9baCv1XW8Y5mLR9Rv12nfdAZWgVMZvR?=
 =?us-ascii?Q?cKJuMiymIXNC01UQfXDNrPUFsC96HHI4CaApDVE3ZJaMUg1wtm4uqLLxlJoE?=
 =?us-ascii?Q?LCP/2AFs+DKqpdQtcHtRdDOrWP7JZp125bzV65Zcz7FnS9IcWDyxsRBenzH3?=
 =?us-ascii?Q?y/9xQ7GKMZyD8hoph2MzEu3DwBxkMYcwspPW9Ldy9cOsi64Tx/5wjQnMST01?=
 =?us-ascii?Q?G5Wt9lKUOePCb+m7orOYwygzzw0NvmbVrOUdN9niQAB8atuH0cnxn/U2CFAh?=
 =?us-ascii?Q?5BEVGZsbomVl3p3FPvMC1iEOg6KiGcPjaMCrxyBdCuOrCFGDwyzw6EZyH05S?=
 =?us-ascii?Q?Keo5fQhven6wRjf8iBrUQC6FPWE2Uinz+GLw7ksQJo7xOprTzgsCoySBXpSJ?=
 =?us-ascii?Q?ZedOq03Ul44AHTWqD+2Vwc4CnBJNuAk00gO1o6iYbUUy7zzhsi+HAvC4z8vY?=
 =?us-ascii?Q?4a5PhjFV7iTNSSLJ98/YhXKw56EuxhuHIOdnG9AQFazAOT04peMbvZ3ABsDo?=
 =?us-ascii?Q?ovITgYtS8r0up/NBuHtm5HwHtsTe4FMHXV69xzpGm2ZuwOgWmP72HdaWOMwj?=
 =?us-ascii?Q?pW8axCdhWbrfhzaNfam6noM+cjmammYvCU8S0Srh/6WRe3WQKntIh5c1kpbV?=
 =?us-ascii?Q?lXWRInvSGy1cvMiROVHlJKgxAFI56xejDrzfY28NigvsN/epJRWVoJk1/D95?=
 =?us-ascii?Q?fxuMl2TcIOgj+L8JFQ3nwOidSfS+88HineV0G3fs4nL8lcXcdHvsrr4LySxQ?=
 =?us-ascii?Q?bPdUP0kYapmgRZi4YJcbCo6QQoJ9qvMNfhXlHGpY8WufgscqqQSON69OFrvg?=
 =?us-ascii?Q?5rNcPQpZyNf+jHO41a6V4bGx4NuBZNG9Y+873DGihnXCYtwaB2v2NmbuhBpF?=
 =?us-ascii?Q?JMg6E0Id1Z0+mp7r8gnEq88UMe7LNrRBAsAdJCJWM1gKI4GJpfAEsqDEn981?=
 =?us-ascii?Q?HE4ZRXCAo3j2fhd4cfIS0WrwCNxq2BLTyPcQaJeKlPbxe6WDjbLIyQstwM2O?=
 =?us-ascii?Q?BNobx37++8xJkbjumWXiKYUNs63rYCNQf+GPPC3p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6128455e-725b-41d8-b510-08db091af08a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 14:52:31.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TM2O0pd7e8ss2MO1At/XkSwFUhK+Nd5IgQHEzIybPFSVEZC/Yv7plU4FTZGhPyF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2696EDC7-7B4A-45D6-A749-E4523F28BB1D_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 6 Feb 2023, at 1:33, Huang Ying wrote:

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
> NOTE: TLB flushing is batched only for normal folios, not for THP
> folios.  Because the overhead of TLB flushing for THP folios is much
> lower than that for normal folios (about 1/512 on x86 platform).
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
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/migrate.c |  4 +++-
>  mm/rmap.c    | 20 +++++++++++++++++---
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 9378fa2ad4a5..ca6e2ff02a09 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1230,7 +1230,7 @@ static int migrate_folio_unmap(new_page_t get_new=
_page, free_page_t put_new_page
>  		/* Establish migration ptes */
>  		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
>  			       !folio_test_ksm(src) && !anon_vma, src);
> -		try_to_migrate(src, 0);
> +		try_to_migrate(src, TTU_BATCH_FLUSH);
>  		page_was_mapped =3D 1;
>  	}
>
> @@ -1781,6 +1781,8 @@ static int migrate_pages_batch(struct list_head *=
from, new_page_t get_new_page,
>  	stats->nr_thp_failed +=3D thp_retry;
>  	stats->nr_failed_pages +=3D nr_retry_pages;
>  move:

Maybe a comment:
/* Flush TLBs for all the unmapped pages */

> +	try_to_unmap_flush();
> +
>  	retry =3D 1;
>  	for (pass =3D 0;
>  	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
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

Everything else looks good to me. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_2696EDC7-7B4A-45D6-A749-E4523F28BB1D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmPiZawPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUvNoP/jMa2VjNrAkoZ/A/IDg90OhXLRs/MhlayyHa
e90KUnWescpmtqRSJYvpGAD6gVzApiPGLElfnKVB7mc9BJxfA2cOSUvmoGdHmozR
JZr5fBLJA5ayLL6uliRdkjUWWLGm5DMho9FiMYXswHB6x8w2ZKaYkEVopWthwgu2
YjFJbYVVUMxyHBUlInCSz5bztQ/QQjDskIumsomgKw7TOVxCLdIkC/yfA8De3yWR
ckhjQsbLAEwlOODhcUAf1AAjcnqvClVnuERoGJHTkeSe16y4eAnieunPqH6sOFqy
UUUJXrg4B0nAmfSp/6SgH8TIg3Dv2qB6zkoBcPL3+dS/KZS/3KPvJQf4vs72P1ub
n+Uwe0r4up++hM0E/2h9+uHSOXQWUfyqFZkp32HedH6MJW7hbelLDl+bkw0TWQFG
DC8il2gciMBfqQ8BEAUWKbkifoAqisfd+IygSD4IuE5APBcQLIqN/xhaGJepJwrv
O77sMQJ566wBH+zNRJvZHtdLSq8TgRWfPEhT/xRcHgxdVUFrrLJNtN63Sn79fmiW
+t6np0kmlJHyBWF3+GSLvWmrevWWYwKXA7JatlO88IrRznna2N4aSd5r2glCj3kX
CZA5NTNnDxsMQ0SFUtuLiL2HwC5ednQksx/N2jUtxqXJtjollii6kRSI0tHU1nUo
mYKlDRoc
=cRX8
-----END PGP SIGNATURE-----

--=_MailMate_2696EDC7-7B4A-45D6-A749-E4523F28BB1D_=--
