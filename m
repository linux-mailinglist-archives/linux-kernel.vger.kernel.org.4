Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E1D743262
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 03:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF3Bvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 21:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjF3Bve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 21:51:34 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4219C2D52
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 18:51:33 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-401f4408955so86011cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 18:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688089892; x=1690681892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReJelaju0aoDb9wHBJOMrRL3RwmVio6acM2bFwwczSc=;
        b=jpctnlSkpJKJTWFXfWpQpjeHNbz1NDffy0XtWaM1WStlgni0XTMLdQy8U/GGYBxIVn
         qahrBC5Xea9x35QXceoubR6HQwpNoiZhzbekxBGcvSvag3+nM0Owo/UcHmS4qQo3pAbZ
         5aqMCZdr/bxOuxybzLqqc865Y82l8ZlNcfmEDWWARFmj3LExMt5fr44hZFm+DhIilJLB
         Uj+dIQUu8caEr4h8TNhvG71bH70ROVIC4psg9KpYsOBFMbT1h3XQcgLvJdYlUB7OYl5c
         d6/+KtnUFfd+YcaW1sQPpigh3w1iucc6NPlzaa3mfeagsdvi+pI6M3jYFgnJDWRhAO1f
         JHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688089892; x=1690681892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReJelaju0aoDb9wHBJOMrRL3RwmVio6acM2bFwwczSc=;
        b=d/pGy+WRHtJC1I9JoO49RcEXyrfq9qYPtLZrEUmYPxMS/GszZVX3tPrMEAyZaip2f6
         FTDvkh7WRTRL1kaMkMTyqLN8bE6ENxNMgDjgchwc02P2C0MLIDf1WtJo+nfE3IkN4N9l
         wU3KXm/94SCz/yeEuuiwtWCFZm4LyX+UVvOH7ELib2xQl2ZHyMn1HZrMYE1MubylkqFY
         01LHnKN9dj6QprX8jfzYtWKMkvt2hBlKDLDpLE2cc9Tx+7j9LNFq2OOuW/L1zNbVKUqh
         +0DCLHR8O15JREH/DKw5o61x3DXimOx7pOo0cIHMmZE/TyPs9GXuYoSGCom3BBaRUmUc
         6cLQ==
X-Gm-Message-State: AC+VfDw8ZQUoRqrlBq82hAb9hpJY8LFL1/o7wJgeGjQAxKTNHX5jHMA6
        zWqav2ydyaFhouJRkmXQ8KJuorGrm8ZgbgFYmgDc3A==
X-Google-Smtp-Source: ACHHUZ6hmFErQNQzWtOG6NXh3DrkAmCuI9UlIZ+Om4WUNnZW0VsV9MWGpYl2XvpPW7josv32svBXSMb6Q2N11IHLXMc=
X-Received: by 2002:a05:622a:285:b0:3f8:175a:4970 with SMTP id
 z5-20020a05622a028500b003f8175a4970mr648134qtw.18.1688089892215; Thu, 29 Jun
 2023 18:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230630013203.1955064-1-jhubbard@nvidia.com>
In-Reply-To: <20230630013203.1955064-1-jhubbard@nvidia.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 29 Jun 2023 21:50:55 -0400
Message-ID: <CADrL8HUwxLU-UvTLbzp-JM5EqQ2u-91UU4VfAhRrPiu7i3Jhkg@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb.c: fix a bug within a BUG(): inconsistent pte comparison
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
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
        Ryan Roberts <ryan.roberts@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 9:32=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> =
wrote:
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

Hi John,

Good catch, and thanks for the detailed explanation. It looks like
riscv and powerpc have equivalent problems in their huge_pte_alloc
implementations, perhaps it's worth taking a look at those. (riscv
looks like it has precisely the same problem except it's a WARN, but
powerpc looks more interesting.)

Either way,

Acked-by: James Houghton <jthoughton@google.com>
