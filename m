Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AE6719E4B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjFANct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjFANce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:32:34 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BF61A2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:32:14 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-33b398f2ab8so138605ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685626333; x=1688218333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3KtCSrqEVqtyrflNCykZkj5UeocsByaRl8X7IPAFn8=;
        b=nEb7UmLMNlSokluULHqM3r9qwDnoeTuCxbhZyiHecz0usOSPC/uyqdsHZ7xd6QBUyR
         idkWN5F64EAtBjPj19+RTFg6iXWGBP25dJZ/WHKJSbI78Nf4B6FKQFfIZx5W/5QST0fZ
         jSi5W+oz4+pxH8RukzegUQ49sfyvxL8hY8S1I+HgSUT+fLqfWNHs8rfhFuGCycq2YTEj
         /BaEsJfjqqPeuuslkWBUjfkGO32PnKAsvZU64ZLopJ+ej2ZPg07X13JKU5z1UjszHkqe
         qWbHkQ3YufXGR4Y0zjyJFUrHwGjq1B+NSYDQtViYyV9Vj3OQjylmZh1M9WPLSLCrP5HB
         BULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685626333; x=1688218333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3KtCSrqEVqtyrflNCykZkj5UeocsByaRl8X7IPAFn8=;
        b=jwP/qbgTPpK/rK67MQjLXCczW//XqcKRyAwbc1uyL7S6fz7iBo6BaaCpOtjtxuT2n5
         MGq45xNutlsFVOsmsvi08PuP7/6VW0JuqPnJxonMinaHqUuWI+4W/mdNEdnSx2Wszpd9
         /4BGGb8O+rpjtejIL0zdSqTFqvw/104kI77G3OA7xl3M6NchFaehC4BBqpZjaHV92A1u
         tfyQP3uM7Megy8ThmZIFJAAdTDSF+fKoUongqDeoQkRRYP0GOhlRJbGeGMlznyG0BgMx
         Kz2JUFBR4kybmsCCkAJpycgoQZAESalzX5Cbu6HeveCXO07hbptsQ6LmP/3LztXKk7TT
         0GMA==
X-Gm-Message-State: AC+VfDzqZMLA067uApq7YlC7eMgq2EuCbjyaRuQiZqjAAEGI5wS9fHDg
        WPDI+auvLCp6iHmD+Iq3z1Q6NzFWhNT7QuIolUFcyQ==
X-Google-Smtp-Source: ACHHUZ4V/FtCLljGT1xoWt7C/8p0Y5SAaWQZYLw6rhFmZV3z+bByMi+y3Ckgjp10pBE5s1R58cJTrfBhSTUq11iJoX4=
X-Received: by 2002:a05:6e02:b2c:b0:32a:642d:2a13 with SMTP id
 e12-20020a056e020b2c00b0032a642d2a13mr216220ilu.6.1685626333553; Thu, 01 Jun
 2023 06:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <739964d-c535-4db4-90ec-2166285b4d47@google.com>
In-Reply-To: <739964d-c535-4db4-90ec-2166285b4d47@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Jun 2023 15:31:37 +0200
Message-ID: <CAG48ez26qh_ZYuKoOQt-ci6SHt2R=5+bPgHCaZrG_TBfbPHq8g@mail.gmail.com>
Subject: Re: [PATCH 08/12] mm/pgtable: add pte_free_defer() for pgtable as page
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
        Alistair Popple <apopple@nvidia.com>,
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 8:23=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
> Add the generic pte_free_defer(), to call pte_free() via call_rcu().
> pte_free_defer() will be called inside khugepaged's retract_page_tables()
> loop, where allocating extra memory cannot be relied upon.  This version
> suits all those architectures which use an unfragmented page for one page
> table (none of whose pte_free()s use the mm arg which was passed to it).

Pages that have been scheduled for deferred freeing can still be
locked, right? So struct page's members "ptl" and "rcu_head" can now
be in use at the same time? If that's intended, it would probably be a
good idea to add comments in the "/* Page table pages */" part of
struct page to point out that the first two members can be used by the
rcu_head while the page is still used as a page table in some
contexts, including use of the ptl.
