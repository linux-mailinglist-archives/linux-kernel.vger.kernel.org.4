Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6440743296
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 04:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjF3COV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 22:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjF3COT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:14:19 -0400
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A9B30EC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 19:14:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688091255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c+Q6kGCsNOKoZaGl4/+CoNXY45hAC8Rmehd0ODubecA=;
        b=nBw5cd0UmlLTPBcRMaXJgc7YE0SMPKtdhLmuO73l3i6lmYUhxiOT/De7PvW9OIa2qAxDHg
        mA10/Pb7AmwhwRqeiQSmdiToCh59DsruaJ1F+7UnJqGswYO1K5cH8Ibxcf06gt+QMAuVpo
        iVNAWO95ztLaVLBd0bSJGpTZzQGqt8M=
MIME-Version: 1.0
Subject: Re: [PATCH] mm/hugetlb.c: fix a bug within a BUG(): inconsistent pte
 comparison
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230630013203.1955064-1-jhubbard@nvidia.com>
Date:   Fri, 30 Jun 2023 10:13:31 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
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
        Namhyung Kim <namhyung@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ryan Roberts <ryan.roberts@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Yu Zhao <yuzhao@google.com>
Content-Transfer-Encoding: 7bit
Message-Id: <070B191B-1D20-4E19-A9AB-961852FEC333@linux.dev>
References: <20230630013203.1955064-1-jhubbard@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 30, 2023, at 09:32, John Hubbard <jhubbard@nvidia.com> wrote:
> 
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
> <TASK>
> ? __die_body+0x63/0xb0
> ? die+0x9f/0xc0
> ? do_trap+0xab/0x180
> ? huge_pte_alloc+0x12c/0x1a0
> ? do_error_trap+0xc6/0x110
> ? huge_pte_alloc+0x12c/0x1a0
> ? handle_invalid_op+0x2c/0x40
> ? huge_pte_alloc+0x12c/0x1a0
> ? exc_invalid_op+0x33/0x50
> ? asm_exc_invalid_op+0x16/0x20
> ? __pfx_put_prev_task_idle+0x10/0x10
> ? huge_pte_alloc+0x12c/0x1a0
> hugetlb_fault+0x1a3/0x1120
> ? finish_task_switch+0xb3/0x2a0
> ? lock_is_held_type+0xdb/0x150
> handle_mm_fault+0xb8a/0xd40
> ? find_vma+0x5d/0xa0
> do_user_addr_fault+0x257/0x5d0
> exc_page_fault+0x7b/0x1f0
> asm_exc_page_fault+0x22/0x30
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

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

