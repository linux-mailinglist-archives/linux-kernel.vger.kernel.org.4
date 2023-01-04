Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7012F65CE5B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjADIbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjADIbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:31:34 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE83D30B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:31:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmZGXyLdE/vE0cJpgSE3J23PgWbbuMCbm2iQZE2pakRcQb90dOtXF1J/hb9ogcNnY9Kfme4gTt4DyGn/KwuztftzjpOmCrFdlArN+krbJQeKm0cxn3WmuEDkSSIn/XHH1PqezgFoigIGzv1jpT1VWEUkwCunN9l6v3Kxgm4W4q4Hilnu+jsFUz+OynvoWcwh1wN/aCiNW+TblSm8mm5sW6m0ZZcreE3UOmnW2dKEYbl7EpFRA76XkjEPUyNTXGblsSxKK/w3aCjmPnExAg4fdTv55HLMFJsr8ZD4IpWDUa92XIj+DnSuyOnCT10wrIqFHQYMidFhNYGj+1gMkEZ1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgcEuqHs/J9sXb35G2Hu8XGW3K9cVYd/U1ZH+b+OM/A=;
 b=dSTVvySFmc2NQgAy+NPrBqKaUvymx27NA4nuk0zxpnZGYOJ5pqHtZp+5h52bDbmzKD17+GgBPBTWJ28CyW4kU6nnhE3QVEKTdR0NuNEI/XdHUwtQSBe4PzidD3hTdYchGenMAo5i7aXLMGBmHR+Sj6ZmjICWdJWmneOY7iXqPVjAFF1DynEqnMTl+G+IqfdcRepdYYwZ81aHo7HdkKd2T7m7NzeDqLpIZIeE07z0LxDm9JCvhU1LltKqAQT7jJl/All8b/tPnyg39DzM3fKgcfiCpd5pEURttIDvzUqiBUGD4TKNYNZW7gGQT48MqjXW04BwJ72yh2xbqoWzlbiJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgcEuqHs/J9sXb35G2Hu8XGW3K9cVYd/U1ZH+b+OM/A=;
 b=UQVRtnjvPh9hIwFde+d4pS2ojbH3cqE+oJP/l56ZE9OGANlCY17KmkzWGhRUXZyZ1lq7O8gh/diIffh3wgXVfo8gY143pJmiVOxXGy9AZCrd0DHGdbB3kDbjRqnGID9tPZASWeV32KSv6741v6UN9/hBYIfKCtGzZb5XUMiNQf2StqZTZ2RWMP7JJCW5ZJZxhW8fTWIololsPXEPyvV5QrL6Nb/UCDyv2nKs4rjK3EWT3j0EC+ER6D60suSZU8ktifG02tbtQNHwrRhpfnWnEyCIE7js5GuWl/acKpdSFM8uxxJZ5JJCVUzd3heErJF1Zc0pFcjzhLSXtnwO/jHU2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 08:31:30 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 08:31:30 +0000
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-8-ying.huang@intel.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 7/8] migrate_pages: share more code between _unmap and
 _move
Date:   Wed, 04 Jan 2023 18:12:09 +1100
In-reply-to: <20221227002859.27740-8-ying.huang@intel.com>
Message-ID: <87pmbur99h.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:10:31::14) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BL1PR12MB5030:EE_
X-MS-Office365-Filtering-Correlation-Id: e740bfb8-8403-481e-ab17-08daee2e1404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxVeeRkAmrOjwoCzIG6vYcwOJmSdsyzMEIU2NJR9wGThwTO8jVWL2BJKgEXt2jF57TAPw0D2+emoEVLfojCxjsxgNwWm+DFlwhqNd4IHZMf1ZEdfnmMFydASNwFzahsdT5OPsLNCA+pUk4iaGYbB9L+URL8xEVghsHGZxzTXWc031mh2lecn7Q2hrejahMDXvxcAmP+/6lbh3sgmyEbqt0idIOtioCx1FU+QATQKoNesGKwnhMaY+8XpuOKPEDPsH5XiXzyjmOoZZu9y+/5mKEAx4yzQ5aR2qp9R/KDwl9RoMom5hEwqUYsUPDUefHFKg5WkdSh30s5zHF62J99o4UxChXFz8CYfTN+TfekGotIAkErVEEJExHfEDOekRn2WsOttTzlUMDSmw4P+3fqN0teHeLdlOk0aDvJ9Uqned6JaRxg1uHaDpjNv626BIlXA1TmqGlfnDjhy3icPYZuPU3u3xAWV9DfitKhOtk6cUnAZKx7ZwH+V9VDTll9jN4OHzvZIR6t+SxrPKlv7m9YHy4ecFervsFs1xRjrSUO9JD7aX/xyCGQvdWcfCfhDawimhB4xhg4sHgDifgHWwvUr7y5SlnOqHsk8sH3v9xlP6rtNxipG/06JvLCFD0yrQhCiQcCwMZIUL8HIp20zSQdNXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199015)(6486002)(186003)(26005)(38100700002)(6512007)(36756003)(5660300002)(83380400001)(8936002)(8676002)(7416002)(66476007)(66556008)(4326008)(41300700001)(30864003)(86362001)(66946007)(54906003)(2906002)(2616005)(316002)(6916009)(6666004)(66899015)(478600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IWoLU2IonW106fclvPJ8BT0/3VMWSQkBBiqVuh1uw/XaUsR/S4bIqpQlsYE0?=
 =?us-ascii?Q?1GfBgwCi+sg9n9CumQ4/gi8gqXxtqPTPmTOJ5Eg7LMeNJMPnqk15kG5feSsw?=
 =?us-ascii?Q?/MMBezev7utuxvkvnKNpULtLJuGg+/hD6KF4ffHvhHcEpwVDA/t0DP5u8IJC?=
 =?us-ascii?Q?Y1p6Lf9ZV5N5fThf8qeJkNomi99di1NuR/UmZH3LRPI0N02Sky6iFDhzSjPJ?=
 =?us-ascii?Q?82zDIqgx0hviCX178wEYGC0ghRX+pxTDW3HZW2ZOplZN9ZQETbKpkttHyWIA?=
 =?us-ascii?Q?i+/n36+TowcttDmfBEYGwtuTJxoVzWmBdNGrrwEwfg0wv8GApg4UGKe7c1g7?=
 =?us-ascii?Q?I/r6PFF4ttq6Ow3Dc59KKC6VBM6YrfsCDKFIbxXo4siSorTza0jNHyC3GTTa?=
 =?us-ascii?Q?Aur8/FegbCLjFpWHykSoz5W/2ZlOBh+K/ldDV/17Jx5VckQ8iMPdkdL/jEf8?=
 =?us-ascii?Q?9hwpH/FKKFG/vDjfeOW47RlWerDlMPzs+Uioc+uv409JAjfp5Bi98S3c8qSD?=
 =?us-ascii?Q?AraeS8EUkrGg4+9GbS9ePAsuUyx0JrUPWlprhFkljIlFxptVmWkjItMrhbgO?=
 =?us-ascii?Q?r2ujgvjeKEoXeWQWKH/XlM9mxSfU4MLKWfNZgOlxLAelu1ZOLJ1N/x09EGoD?=
 =?us-ascii?Q?SuytnyBQxPNzjk+CADV3/FjmiM4nc1rKhxocNMYKLthLzMTOhoMdnaaztKEA?=
 =?us-ascii?Q?QUvTRDfD3ENa9qGH886LhCYAU0TO37uQqWvXdC6vQJ8NJNiuXuiSpA7fFWfk?=
 =?us-ascii?Q?enoGK+lo59RTb0//17VxZZQR0truDqo/7pVDxskQCXSdvMokzIs71etMBSGH?=
 =?us-ascii?Q?nPj1L4lo7XSuX3LDdsGA/Clf+eEAzYdPZsrwS78rxuzSIeDSNF/qNqMzad+1?=
 =?us-ascii?Q?bvi+guNlQyj1490P5BHBm9PJCG+Lj5VH4JDBDBztuRgWfpD82es83oBg+Sij?=
 =?us-ascii?Q?a973oF1tPklwmRBnSLtwCiTulen7cNl7+lX0LiaWx2n63y8LXCI4hVxVofMJ?=
 =?us-ascii?Q?WjJBrneE87x7WeNOEvgXPa73OnH03qcnhWVmHerjMoDzulZa10XaAByaT0rW?=
 =?us-ascii?Q?3TSHqUBfHEc23nvtDSfzzc7AFyAYBk6MAJuTmXnjkjx0YlbN9VmwZmXIIFTR?=
 =?us-ascii?Q?R0i9i3SUMnJIIhcarQcqwwAMMeBBTW2Ocw3T6Ki1+Y0th4cezDyH6Y35hNSf?=
 =?us-ascii?Q?MIYZhutXmEA3U3BuI/O5+hiCj12XdBS14ZpaSFpcwP5OH2BsFHx4wfWKOQi2?=
 =?us-ascii?Q?IpCWk5f6Ja415h4nF95cT7gp1J5JErT8RJ17JXSnPYTbd89WSSjFISpsk8qy?=
 =?us-ascii?Q?g21U6VwUUTxNeoWYC5nq7wqCgDw7KYNXXCOCqBKhB7zowySC1AAV/Rrwj/ZG?=
 =?us-ascii?Q?Lpg9r7Et0SNFPLIYgJpR9WvucXps1iF7ETGGkeeQhhiTKze0n5pP3wjuqrWL?=
 =?us-ascii?Q?wF7At+6XzOW8G/AyDGq5nFI5pscU1Rovx2N4cgWdGnZAlKhTZiZZx3bSfZ65?=
 =?us-ascii?Q?LaQ95rmQ6MtpvGIQxyPMHY/MiCNojAFhsC9jW/ipxv7cRjTWEpxjEaBCCL2m?=
 =?us-ascii?Q?U/2aJs+liP6pBQPepNilm42KeNaWUqKl8EQVglop?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e740bfb8-8403-481e-ab17-08daee2e1404
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 08:31:30.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJmzjohMIfVVwMesFKhbxr71UNJizF9s0RI6BnGQWSMnINE843IGPLY/yJ7Z5triluMeXt7tagHxqs0zhQBTXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Huang Ying <ying.huang@intel.com> writes:

> This is a code cleanup patch to reduce the duplicated code between the
> _unmap and _move stages of migrate_pages().  No functionality change
> is expected.
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
>  mm/migrate.c | 208 ++++++++++++++++++++-------------------------------
>  1 file changed, 82 insertions(+), 126 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 70b987391296..70a40b8fee1f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1030,21 +1030,26 @@ static void __migrate_folio_extract(struct folio *dst,
>  static void migrate_folio_undo_src(struct folio *src,
>  				   int page_was_mapped,
>  				   struct anon_vma *anon_vma,
> +				   bool locked,
>  				   struct list_head *ret)
>  {
>  	if (page_was_mapped)
>  		remove_migration_ptes(src, src, false);
>  	if (anon_vma)
>  		put_anon_vma(anon_vma);
> -	folio_unlock(src);
> -	list_move_tail(&src->lru, ret);
> +	if (locked)
> +		folio_unlock(src);
> +	if (ret)
> +		list_move_tail(&src->lru, ret);
>  }
>  
>  static void migrate_folio_undo_dst(struct folio *dst,
> +				   bool locked,
>  				   free_page_t put_new_page,
>  				   unsigned long private)
>  {
> -	folio_unlock(dst);
> +	if (locked)
> +		folio_unlock(dst);
>  	if (put_new_page)
>  		put_new_page(&dst->page, private);
>  	else
> @@ -1068,14 +1073,44 @@ static void migrate_folio_done(struct folio *src,
>  		folio_put(src);
>  }
>  
> -static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
> -				 int force, bool force_lock, enum migrate_mode mode)
> +/* Obtain the lock on page, remove all ptes. */
> +static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
> +			       unsigned long private, struct folio *src,
> +			       struct folio **dstp, int force, bool force_lock,
> +			       enum migrate_mode mode, enum migrate_reason reason,
> +			       struct list_head *ret)

Overall I think this should be refactored into some smaller, simpler
functions as the error handling and the giant switch statement in
migrate_pages_batch() is making my head hurt :-)

>  {
> -	int rc = -EAGAIN;
> +	struct folio *dst;
> +	int rc = MIGRATEPAGE_UNMAP;
> +	struct page *newpage = NULL;
>  	int page_was_mapped = 0;
>  	struct anon_vma *anon_vma = NULL;
>  	bool is_lru = !__PageMovable(&src->page);
> +	bool locked = false;
> +	bool dst_locked = false;
> +
> +	if (!thp_migration_supported() && folio_test_transhuge(src))
> +		return -ENOSYS;

This would be easier to follow if it was just moved to the caller and
the -ENOSYS switch case removed.

> +	if (folio_ref_count(src) == 1) {
> +		/* Folio was freed from under us. So we are done. */
> +		folio_clear_active(src);
> +		folio_clear_unevictable(src);
> +		/* free_pages_prepare() will clear PG_isolated. */
> +		list_del(&src->lru);
> +		migrate_folio_done(src, reason);
> +		return MIGRATEPAGE_SUCCESS;
> +	}

This is the only case that returns MIGRATEPAGE_SUCCESS so would also be
clearer if moved to the caller eliminating another switch case.

> +
> +	newpage = get_new_page(&src->page, private);
> +	if (!newpage)
> +		return -ENOMEM;
> +	dst = page_folio(newpage);
> +	*dstp = dst;
> +
> +	dst->private = NULL;

This could be moved until after the folio_test_writeback(), which might
make the split I suggest below easier.

>  
> +	rc = -EAGAIN;

We can just initialise rc to -EAGAIN.

>  	if (!folio_trylock(src)) {
>  		if (!force || mode == MIGRATE_ASYNC)
>  			goto out;
> @@ -1103,6 +1138,7 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>  
>  		folio_lock(src);
>  	}
> +	locked = true;

A seperate helper for locking the folio would be better IMHO.

>  
>  	if (folio_test_writeback(src)) {
>  		/*
> @@ -1117,10 +1153,10 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>  			break;
>  		default:
>  			rc = -EBUSY;
> -			goto out_unlock;
> +			goto out;
>  		}
>  		if (!force)
> -			goto out_unlock;
> +			goto out;
>  		folio_wait_writeback(src);
>  	}

This is the only path that return -EBUSY, so could be integrated into
the helper suggested above for locking the folio.
  
> @@ -1150,7 +1186,8 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>  	 * This is much like races on refcount of oldpage: just don't BUG().
>  	 */
>  	if (unlikely(!folio_trylock(dst)))
> -		goto out_unlock;
> +		goto out;
> +	dst_locked = true;

So how about splitting migrate_folio_unmap() into two functions:

/*
 * Prepare a folio for migration by locking the source, ensuring
 * writeback is complete and allocating and locking a new destination
 * page.
 */
migrate_folio_prepare(new_page_t get_new_page, free_page_t put_new_page,
                      unsigned long private, struct folio *src,
	              struct folio **dstp, int force, bool force_lock)

migrate_folio_unmap(struct folio *src, struct folio *dst,
                    enum migrate_mode mode, enum migrate_reason reason)

Obviously we still have the various failure scenarios to deal with, but
I think it would be more readable if these were limited to undoing the
migrate_folio_prepare() step in the caller. I think the list
manipulation would also be more obvious if left to the caller.

>  	if (unlikely(!is_lru)) {
>  		__migrate_folio_record(dst, page_was_mapped, anon_vma);
> @@ -1172,7 +1209,7 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>  	if (!src->mapping) {
>  		if (folio_test_private(src)) {
>  			try_to_free_buffers(src);
> -			goto out_unlock_both;
> +			goto out;
>  		}
>  	} else if (folio_mapped(src)) {
>  		/* Establish migration ptes */
> @@ -1187,75 +1224,27 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>  		return MIGRATEPAGE_UNMAP;

I reaslise this is pre-existing but the mixing of setting rc or
returning codes directly is a bit hard to follow.

>  	}
>  
> -
> -	if (page_was_mapped)
> -		remove_migration_ptes(src, src, false);
> -
> -out_unlock_both:
> -	folio_unlock(dst);
> -out_unlock:
> -	/* Drop an anon_vma reference if we took one */
> -	if (anon_vma)
> -		put_anon_vma(anon_vma);
> -	folio_unlock(src);
>  out:
> -
> -	return rc;
> -}
> -
> -/* Obtain the lock on page, remove all ptes. */
> -static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
> -			       unsigned long private, struct folio *src,
> -			       struct folio **dstp, int force, bool force_lock,
> -			       enum migrate_mode mode, enum migrate_reason reason,
> -			       struct list_head *ret)
> -{
> -	struct folio *dst;
> -	int rc = MIGRATEPAGE_UNMAP;
> -	struct page *newpage = NULL;
> -
> -	if (!thp_migration_supported() && folio_test_transhuge(src))
> -		return -ENOSYS;
> -
> -	if (folio_ref_count(src) == 1) {
> -		/* Folio was freed from under us. So we are done. */
> -		folio_clear_active(src);
> -		folio_clear_unevictable(src);
> -		/* free_pages_prepare() will clear PG_isolated. */
> -		list_del(&src->lru);
> -		migrate_folio_done(src, reason);
> -		return MIGRATEPAGE_SUCCESS;
> -	}
> -
> -	newpage = get_new_page(&src->page, private);
> -	if (!newpage)
> -		return -ENOMEM;
> -	dst = page_folio(newpage);
> -	*dstp = dst;
> -
> -	dst->private = NULL;
> -	rc = __migrate_folio_unmap(src, dst, force, force_lock, mode);
> -	if (rc == MIGRATEPAGE_UNMAP)
> -		return rc;
> -
>  	/*
>  	 * A page that has not been migrated will have kept its
>  	 * references and be restored.
>  	 */
>  	/* restore the folio to right list. */
> -	if (rc != -EAGAIN && rc != -EDEADLOCK)
> -		list_move_tail(&src->lru, ret);
> +	if (rc == -EAGAIN || rc == -EDEADLOCK)
> +		ret = NULL;
>  
> -	if (put_new_page)
> -		put_new_page(&dst->page, private);
> -	else
> -		folio_put(dst);
> +	migrate_folio_undo_src(src, page_was_mapped, anon_vma, locked, ret);
> +	if (dst)
> +		migrate_folio_undo_dst(dst, dst_locked, put_new_page, private);
>  
>  	return rc;
>  }
>  
> -static int __migrate_folio_move(struct folio *src, struct folio *dst,
> -				enum migrate_mode mode)
> +/* Migrate the folio to the newly allocated folio in dst. */
> +static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
> +			      struct folio *src, struct folio *dst,
> +			      enum migrate_mode mode, enum migrate_reason reason,
> +			      struct list_head *ret)
>  {
>  	int rc;
>  	int page_was_mapped = 0;
> @@ -1264,9 +1253,10 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
>  	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>  
>  	rc = move_to_new_folio(dst, src, mode);
> +	if (rc)
> +		goto out;
>  
> -	if (rc != -EAGAIN)
> -		list_del(&dst->lru);
> +	list_del(&dst->lru);
>  	/*
>  	 * When successful, push dst to LRU immediately: so that if it
>  	 * turns out to be an mlocked page, remove_migration_ptes() will
> @@ -1276,74 +1266,40 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
>  	 * unsuccessful, and other cases when a page has been temporarily
>  	 * isolated from the unevictable LRU: but this case is the easiest.
>  	 */
> -	if (rc == MIGRATEPAGE_SUCCESS) {
> -		folio_add_lru(dst);
> -		if (page_was_mapped)
> -			lru_add_drain();
> -	}
> -
> -	if (rc == -EAGAIN) {
> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
> -		return rc;
> -	}
> -
> +	folio_add_lru(dst);
>  	if (page_was_mapped)
> -		remove_migration_ptes(src,
> -			rc == MIGRATEPAGE_SUCCESS ? dst : src, false);
> +		lru_add_drain();
>  
> +	if (page_was_mapped)
> +		remove_migration_ptes(src, dst, false);
>  	folio_unlock(dst);
> -	/* Drop an anon_vma reference if we took one */
> -	if (anon_vma)
> -		put_anon_vma(anon_vma);
> -	folio_unlock(src);
> +	set_page_owner_migrate_reason(&dst->page, reason);
>  	/*
>  	 * If migration is successful, decrease refcount of dst,
>  	 * which will not free the page because new page owner increased
>  	 * refcounter.
>  	 */
> -	if (rc == MIGRATEPAGE_SUCCESS)
> -		folio_put(dst);
> -
> -	return rc;
> -}
> -
> -/* Migrate the folio to the newly allocated folio in dst. */
> -static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
> -			      struct folio *src, struct folio *dst,
> -			      enum migrate_mode mode, enum migrate_reason reason,
> -			      struct list_head *ret)
> -{
> -	int rc;
> -
> -	rc = __migrate_folio_move(src, dst, mode);
> -	if (rc == MIGRATEPAGE_SUCCESS)
> -		set_page_owner_migrate_reason(&dst->page, reason);
> -
> -	if (rc != -EAGAIN) {
> -		/*
> -		 * A folio that has been migrated has all references
> -		 * removed and will be freed. A folio that has not been
> -		 * migrated will have kept its references and be restored.
> -		 */
> -		list_del(&src->lru);
> -	}
> +	folio_put(dst);
>  
>  	/*
> -	 * If migration is successful, releases reference grabbed during
> -	 * isolation. Otherwise, restore the folio to right list unless
> -	 * we want to retry.
> +	 * A page that has been migrated has all references removed
> +	 * and will be freed.
>  	 */
> -	if (rc == MIGRATEPAGE_SUCCESS) {
> -		migrate_folio_done(src, reason);
> -	} else if (rc != -EAGAIN) {
> -		list_add_tail(&src->lru, ret);
> +	list_del(&src->lru);
> +	migrate_folio_undo_src(src, 0, anon_vma, true, NULL);
> +	migrate_folio_done(src, reason);
>  
> -		if (put_new_page)
> -			put_new_page(&dst->page, private);
> -		else
> -			folio_put(dst);
> +	return rc;
> +out:
> +	if (rc == -EAGAIN) {
> +		__migrate_folio_record(dst, page_was_mapped, anon_vma);
> +		return rc;
>  	}
>  
> +	migrate_folio_undo_src(src, page_was_mapped, anon_vma, true, ret);
> +	list_del(&dst->lru);
> +	migrate_folio_undo_dst(dst, true, put_new_page, private);
> +
>  	return rc;
>  }
>  
> @@ -1849,9 +1805,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  
>  		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>  		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
> -				       ret_folios);
> +				       true, ret_folios);
>  		list_del(&dst->lru);
> -		migrate_folio_undo_dst(dst, put_new_page, private);
> +		migrate_folio_undo_dst(dst, true, put_new_page, private);
>  		dst = dst2;
>  		dst2 = list_next_entry(dst, lru);
>  	}

