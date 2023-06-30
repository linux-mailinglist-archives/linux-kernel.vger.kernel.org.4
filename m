Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DAB7438FC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjF3KIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjF3KIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:08:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 676453AB9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:08:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CD04D75;
        Fri, 30 Jun 2023 03:08:47 -0700 (PDT)
Received: from [10.57.76.103] (unknown [10.57.76.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA1053F663;
        Fri, 30 Jun 2023 03:07:58 -0700 (PDT)
Message-ID: <05ea6668-3dca-23ed-56c8-bbf8079d93cd@arm.com>
Date:   Fri, 30 Jun 2023 11:07:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/hugetlb.c: fix a bug within a BUG(): inconsistent pte
 comparison
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ian Rogers <irogers@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jiri Olsa <jolsa@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Namhyung Kim <namhyung@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        SeongJae Park <sj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Yu Zhao <yuzhao@google.com>
References: <20230630013203.1955064-1-jhubbard@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230630013203.1955064-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 02:32, John Hubbard wrote:
> The following crash happens for me when running the -mm selftests
> (below). Specifically, it happens while running the uffd-stress
> subtests:
> 
> kernel BUG at mm/hugetlb.c:7249!
> invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 0 PID: 3238 Comm: uffd-stress Not tainted 6.4.0-hubbard-github+ #109
> Hardware name: ASUS X299-A/PRIME X299-A, BIOS 1503 08/03/2018
> RIP: 0010:huge_pte_alloc+0x12c/0x1a0
> ...
> Call Trace:
>  <TASK>
>  ? __die_body+0x63/0xb0
>  ? die+0x9f/0xc0
>  ? do_trap+0xab/0x180
>  ? huge_pte_alloc+0x12c/0x1a0
>  ? do_error_trap+0xc6/0x110
>  ? huge_pte_alloc+0x12c/0x1a0
>  ? handle_invalid_op+0x2c/0x40
>  ? huge_pte_alloc+0x12c/0x1a0
>  ? exc_invalid_op+0x33/0x50
>  ? asm_exc_invalid_op+0x16/0x20
>  ? __pfx_put_prev_task_idle+0x10/0x10
>  ? huge_pte_alloc+0x12c/0x1a0
>  hugetlb_fault+0x1a3/0x1120
>  ? finish_task_switch+0xb3/0x2a0
>  ? lock_is_held_type+0xdb/0x150
>  handle_mm_fault+0xb8a/0xd40
>  ? find_vma+0x5d/0xa0
>  do_user_addr_fault+0x257/0x5d0
>  exc_page_fault+0x7b/0x1f0
>  asm_exc_page_fault+0x22/0x30
> 
> That happens because a BUG() statement in huge_pte_alloc() attempts to
> check that a pte, if present, is a hugetlb pte, but it does so in a
> non-lockless-safe manner that leads to a false BUG() report.
> 
> We got here due to a couple of bugs, each of which by itself was not
> quite enough to cause a problem:
> 
> First of all, before commit c33c794828f2("mm: ptep_get() conversion"),
> the BUG() statement in huge_pte_alloc() was itself fragile: it relied
> upon compiler behavior to only read the pte once, despite using it twice
> in the same conditional.
> 
> Next, commit c33c794828f2 ("mm: ptep_get() conversion") broke that
> delicate situation, by causing all direct pte reads to be done via
> READ_ONCE(). And so READ_ONCE() got called twice within the same BUG()
> conditional, leading to comparing (potentially, occasionally) different
> versions of the pte, and thus to false BUG() reports.

Thanks for finding and fixing this - sorry for the issue. FWIW, I've re-reviewed
the whole ptep_get conversion patch looking for other instances of this pattern
- I didn't spot any other issues.

> 
> Fix this by taking a single snapshot of the pte before using it in the
> BUG conditional.
> 
> Now, that commit is only partially to blame here but, people doing
> bisections will invariably land there, so this will help them find a fix
> for a real crash. And also, the previous behavior was unlikely to ever
> expose this bug--it was fragile, yet not actually broken.
> 
> So that's why I chose this commit for the Fixes tag, rather than the
> commit that created the original BUG() statement.
> 
> Fixes: c33c794828f2 ("mm: ptep_get() conversion")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/hugetlb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bce28cca73a1..73fbeb8f979f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7246,7 +7246,12 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  				pte = (pte_t *)pmd_alloc(mm, pud, addr);
>  		}
>  	}
> -	BUG_ON(pte && pte_present(ptep_get(pte)) && !pte_huge(ptep_get(pte)));
> +
> +	if (pte) {
> +		pte_t pteval = ptep_get(pte);

Given the PTL is not held here, I think this should technically be
ptep_get_lockless()?

Thanks,
Ryan


> +
> +		BUG_ON(pte_present(pteval) && !pte_huge(pteval));
> +	}
>  
>  	return pte;
>  }
> 
> base-commit: bf1fa6f15553df04f2bdd06190ccd5f388ab0777

