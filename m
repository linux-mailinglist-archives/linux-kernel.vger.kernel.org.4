Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA9B70D12D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjEWCZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjEWCZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:25:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0CACD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7pMU9RQC7tTM2th4Es5QUTKFESswpENYmP3aEK3ZAJ+0x4+oXMP0S6BeQM2ZHGxa5waHxJDcZdeqWTc/0LdsMRiSA0vnIn+KuYdZk/yWMrRaGGYn/tsRQLr+5tVx/lIGOyykGLVo7rf+Py8eQX7xBJi1HnW5FmThBrnH+kuIQq1FlmTJkL8d+PeC7dxzKs6pzB0JjwbGVmUSEkCHKsM49HgeRdiDQqnf3NEkZd3OgQ89PrivNX65Ly+vI3FUxYcheKMveUhh9lOl5TCuE5523ejniA2rINyKsf9n4VmgyTZ1qDEG7h+GfjtKieY0ksn2QYJcdF/tAwr4a6wg4+fVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jpr3Bj4jaTo64FjM3CDZju1Z9Ta+E5pOQYxslLEZ78g=;
 b=JywXZqReoX3rde4agZkdC+eD3y4pMW6c+ux8FZXcNp90UX/S96RnMWIw1b9p7hCLzh4S6S/JsHDx3fMdN4kbvs4F3g6k+Wz3iE5nun5m90efRPFS715bvxw6ev5D2PnYkRUOv/gJcKUChsBJivsqC3n7XyQeyiJ8IOTPpxE9lMEW54kVyL6X/wWMuW4eHtlkmWdWSx3+54ZIgEHJLVqFH/Zvv6kHb1rATdvIz6fgdthZv4lHvQVQMgs5U0HF5RTBL0BmhqKJU7C4vsxwNnFRgFNhrdERN+Nd4dOGVcGo8qjNm0++TSOkekVek9XULTivHAARW6lqhusemdGQQk25Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jpr3Bj4jaTo64FjM3CDZju1Z9Ta+E5pOQYxslLEZ78g=;
 b=AayYBgxh/WVqRXB4Fyg0XJ/qihMo9YLhEzUYL6T0mA3/nsRbDEeN6EkVr30OKy64aeP4rwAUwaSfU+fLNin3i++w+sn7i5hmunNRBaR/OzPsuq9a11f2A+R2ly5rKQRuzATWI6BYtQ0n5APLMUmTqSB6DZPkA2cS5k9ISrrM7bwon6Y0BOGYcHRa9K7fCV6zv6dSuC6oEQBZNh2GVlp/OBmuh7tCvrhNO3PJ2Y19NMag4uVGHN46fwJ1EVYZQuIBCmYDPt7E9NbcwAj7Ms1UZxnjoe8hbKtzZMrp9KIhooqE2yTYMnvwU+w6zZy2QSYNquOeivMaYUDBwUHfcQ/ILQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 02:24:59 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f6e4:71a5:4998:e6b2]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f6e4:71a5:4998:e6b2%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 02:24:58 +0000
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <ea51bb69-189c-229b-fc0-9d3e7be5d6b@google.com>
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
Subject: Re: [PATCH 24/31] mm/migrate_device: allow pte_offset_map_lock() to
 fail
Date:   Tue, 23 May 2023 12:23:31 +1000
In-reply-to: <ea51bb69-189c-229b-fc0-9d3e7be5d6b@google.com>
Message-ID: <877csz943s.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::20) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: c735cdb0-0727-427f-9237-08db5b34e7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SNMZvFbbJrMpyW4Za3GxDXXZ51YWksnUzu34lmBTLuNVg0BH6erb59sm4t+d04rrMJ8yK/w7MzOXrTlvcyXzNXxe2a8mcjWbR5rz0i+xGVQFCP7LZNbI3X0IRZoSdI3KUjVpR8tgSyoVBqu+tCuds5XZkTnBjvAIvwxaNj+Rv9Q9S9ifpIRbfcXxIRAYUtd4zn/9CrG3Jh+gJt8bL1DCsgePt1wsn0vI4uV1tP2YKeSV3SVUsmRTutfcElm7Yt16tM+/pJg0thkIBxdFdA4NEIt7kbmfYPKN2bkKmCegcIttPxl6jLzq6JPUNRgdpTr57mQU/n0b8yGl/tCDaEeJKU4TN3LBw/6KRK85MnH1/mPY9rYw2O5arwuKtJ+UdWZl1TTf/iVbhkwfo5pgeULpnAMZyearn/eX9GifMtzAm+iSXLhWXSI25dy/D/xz/6IetNiABHI2EmkTisAj40KE1CtjImlN8wPECdws6Kr7AQHwUeVc5sl+UpVdRgYdT78YelrbBepbHCFKyK8OJROCpf2qyHBMQMYKNM6vtkwYeOYUvP6t/pFzgnQnitdN0YMS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(2616005)(83380400001)(186003)(2906002)(36756003)(38100700002)(86362001)(7406005)(5660300002)(8936002)(8676002)(7416002)(54906003)(6916009)(4326008)(66556008)(66476007)(66946007)(6486002)(6666004)(41300700001)(478600001)(316002)(6512007)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?awDqFDtmQ/gb3kBZ+ybc/cBzCMtiYjnlvwnR2wpsI6z9wUkLB7/WhhjtSp5b?=
 =?us-ascii?Q?Xaxd93CMqOfgXtv80NKqLoWARuGfnB/Yg+LylDXdPW6CtuU0KXRLEkJMWdLE?=
 =?us-ascii?Q?Ae8Csz7XF+mGn4Y1HNReiEh14PS7TzewiFenoJ0GSbj/1q2+gRIt3zp72NsM?=
 =?us-ascii?Q?HObtnkqxq/llIHIxaehZiv4I3u+/6gtktMPQmKVJ6LXU91xzhu21mdMXN9wX?=
 =?us-ascii?Q?R3uJ7TTR6uSvelSVdkdJT4pNGreasKVnMUhGr1VYx/ohjNPWx6pU3s0rKZpq?=
 =?us-ascii?Q?88b/e7Ofd04Af6Q9FKrYoGI6qeU0AAnW45hQtdXVcHrBG4fYEN7Uc2XZA+9z?=
 =?us-ascii?Q?Z6jzYMnB4tjH4O5+Q4/3aX7/JWtz9HwEVto4RATnnR4SJYdvgz5Mx6sEX4rk?=
 =?us-ascii?Q?MPqw6UAVg/i+qTxNGHiQGio106H0t87J4y4Q04asnadR4GGxXHfswmbGRw3/?=
 =?us-ascii?Q?5rlwJS3h/Gu+ncwRtsy+oVBFahXz8DyT7Z0DxUK5eM6+Z8Qa2+s2k3MbppEZ?=
 =?us-ascii?Q?lrEGewwjW30m2jCO5AsAzEJvDp6rc4CB05bvja7OjL6/4a4DzXVBr5rICzpo?=
 =?us-ascii?Q?9o0ZG2LJGncQEeiOeJHW8tRi570feIPM5bFp/3Q+zmX9gqiK0uhX8r0xEL78?=
 =?us-ascii?Q?6K+x3MOHmcvknPZJgbtl6ASoBHUuFQbl7vI7FrRxURe+xEfYovMl1pH0JEWl?=
 =?us-ascii?Q?ZcZWmZFVSjw6HNUddix9+u/SjDlvh3V+yssrKNXnY/68tmaFaqyNJxRDF0QE?=
 =?us-ascii?Q?2HY/72k6lJLHCD4q4ZpnIIhz3u2/UnwPgTkuJDMUreqT4Au8RIoeClQtKcnN?=
 =?us-ascii?Q?XaSiWRIBA26K7sHGJUWEHu90SB9diFk4x6OGgKNMtupZtWPvgmGguIuloFaZ?=
 =?us-ascii?Q?Km5W4CP0DwMxxqZP1h5IWvzV56rA8QnS4D1IiT/+RTvVJyQJ3KkgfqjTQaXW?=
 =?us-ascii?Q?zFES29xCwPMmyDMqQU/b9YOZxMUkR0HGHPVCu/FsBumLLpjvS6RFJnvoGXdU?=
 =?us-ascii?Q?Bi/+k0rbMq2MlYRuKTOM1kNpGLGDNaRWcxo8rU55kMzSEKwz7GVBf7MJKctr?=
 =?us-ascii?Q?4y66TmSGfHpNRYuNKooaA/aM4PiO5kM5dMXIRhsyKPXbuMEIOKGgqtoKOJ9K?=
 =?us-ascii?Q?ASh3X67/RQ1z3p+7rycTI9xBOrjrjAq+stfYhLfiO6bNJPl/+U+LlyHrxu9J?=
 =?us-ascii?Q?aHtizrLj84lVdBhCHB62NAa+Unrd9yP7P5BzAbfhVmRjE4E9BMTEuw4Ts9g5?=
 =?us-ascii?Q?p4qEKXg/xt6LMoMNY/ZtEj5dJoA3YXkwAfoMBufyn5KkQpTzOqWOY2YZw2xs?=
 =?us-ascii?Q?MI2vOIPiCh5++KkkxYQMY14B/yw3tbERoiVzygrkDnv0WePplF22u94LpiOy?=
 =?us-ascii?Q?MS9fqImzX3XiAYNnPf9J4cxtxzZG27eBOKAjJNPGsQtuw9dPo+guA0QA1MMt?=
 =?us-ascii?Q?L41sog06FU9aCcVcETx5HR3sBXweE1cuABeuzgzEL2fCYFiSxKxCcpUCq720?=
 =?us-ascii?Q?QQbGbU0LRgc8Xjo926+JuMr8X5A9mtlDSu/I9MJPa80fWrg9QqqWc6EOZZjl?=
 =?us-ascii?Q?F612/2Bc7QpqeWpdx0ZIYzQl+5RCVecZY9uHr1J5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c735cdb0-0727-427f-9237-08db5b34e7b5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 02:24:58.9096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxCGbIqrwykjZXAgEryaopa9Asq+5d/4HXj1ezQpXlix8pS/fIxV1DrF5CtXxftNyjfunUJ4cYNI9wIt5UVIaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
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

> migrate_vma_collect_pmd(): remove the pmd_trans_unstable() handling after
> splitting huge zero pmd, and the pmd_none() handling after successfully
> splitting huge page: those are now managed inside pte_offset_map_lock(),
> and by "goto again" when it fails.
>
> But the skip after unsuccessful split_huge_page() must stay: it avoids an
> endless loop.  The skip when pmd_bad()?  Remove that: it will be treated
> as a hole rather than a skip once cleared by pte_offset_map_lock(), but
> with different timing that would be so anyway; and it's arguably best to
> leave the pmd_bad() handling centralized there.

So for a pmd_bad() the sequence would be:

1. pte_offset_map_lock() would return NULL and clear the PMD.
2. goto again marks the page as a migrating hole,
3. In migrate_vma_insert_page() a new PMD is created by pmd_alloc().
4. This leads to a new zero page getting mapped for the previously
   pmd_bad() mapping.

I'm not entirely sure what the pmd_bad() case is used for but is that
ok? I understand that previously it was all a matter of timing, but I
wouldn't rely on the previous code being correct in this regard either.

> migrate_vma_insert_page(): remove comment on the old pte_offset_map()
> and old locking limitations; remove the pmd_trans_unstable() check and
> just proceed to pte_offset_map_lock(), aborting when it fails (page has
> now been charged to memcg, but that's so in other cases, and presumably
> uncharged later).

Correct, the non-migrating page will be freed later via put_page() which
will uncharge the page.

> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/migrate_device.c | 31 ++++---------------------------
>  1 file changed, 4 insertions(+), 27 deletions(-)
>
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index d30c9de60b0d..a14af6b12b04 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -83,9 +83,6 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  		if (is_huge_zero_page(page)) {
>  			spin_unlock(ptl);
>  			split_huge_pmd(vma, pmdp, addr);
> -			if (pmd_trans_unstable(pmdp))
> -				return migrate_vma_collect_skip(start, end,
> -								walk);
>  		} else {
>  			int ret;
>  
> @@ -100,16 +97,12 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			if (ret)
>  				return migrate_vma_collect_skip(start, end,
>  								walk);
> -			if (pmd_none(*pmdp))
> -				return migrate_vma_collect_hole(start, end, -1,
> -								walk);
>  		}
>  	}
>  
> -	if (unlikely(pmd_bad(*pmdp)))
> -		return migrate_vma_collect_skip(start, end, walk);
> -
>  	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> +	if (!ptep)
> +		goto again;
>  	arch_enter_lazy_mmu_mode();
>  
>  	for (; addr < end; addr += PAGE_SIZE, ptep++) {
> @@ -595,27 +588,10 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
>  	pmdp = pmd_alloc(mm, pudp, addr);
>  	if (!pmdp)
>  		goto abort;
> -
>  	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
>  		goto abort;
> -
> -	/*
> -	 * Use pte_alloc() instead of pte_alloc_map().  We can't run
> -	 * pte_offset_map() on pmds where a huge pmd might be created
> -	 * from a different thread.
> -	 *
> -	 * pte_alloc_map() is safe to use under mmap_write_lock(mm) or when
> -	 * parallel threads are excluded by other means.
> -	 *
> -	 * Here we only have mmap_read_lock(mm).
> -	 */
>  	if (pte_alloc(mm, pmdp))
>  		goto abort;
> -
> -	/* See the comment in pte_alloc_one_map() */
> -	if (unlikely(pmd_trans_unstable(pmdp)))
> -		goto abort;
> -
>  	if (unlikely(anon_vma_prepare(vma)))
>  		goto abort;
>  	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
> @@ -650,7 +626,8 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
>  	}
>  
>  	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> -
> +	if (!ptep)
> +		goto abort;
>  	if (check_stable_address_space(mm))
>  		goto unlock_abort;

