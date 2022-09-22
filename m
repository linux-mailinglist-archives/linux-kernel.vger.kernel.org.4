Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DFC5E5ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiIVFkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIVFkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:40:06 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E265A143
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:40:04 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663825203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94DEUSFr4kTu5Sug7viZtZYQ+w/g2uT/ObUqOKkJPsc=;
        b=u7z6QmrDptw811X7xanN1IDmgeRsqwCsj37KtmqMwBhTWxBxhsuXPvO1LpdAWaP9+C/2A2
        RF6PyrKpiJUZBrlWUOTMDLIwfn88KW5wBvFDdAJlFXI/qnqNtUfn+VM4uD/ydA5jDTiLrq
        NU7GxA5wIkot3vMeKSV/kgmbfhTiMY0=
MIME-Version: 1.0
Subject: Re: [PATCH v3] hugetlb: freeze allocated pages before creating
 hugetlb pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220921202702.106069-1-mike.kravetz@oracle.com>
Date:   Thu, 22 Sep 2022 13:39:55 +0800
Cc:     Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Vlastimil Babka <vbabka@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5248E364-6EA7-4CEA-AD16-9792424D5D5B@linux.dev>
References: <20220921202702.106069-1-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 22, 2022, at 04:27, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> When creating hugetlb pages, the hugetlb code must first allocate
> contiguous pages from a low level allocator such as buddy, cma or
> memblock.  The pages returned from these low level allocators are
> ref counted.  This creates potential issues with other code taking
> speculative references on these pages before they can be transformed =
to
> a hugetlb page.  This issue has been addressed with methods and code
> such as that provided in [1].
>=20
> Recent discussions about vmemmap freeing [2] have indicated that it
> would be beneficial to freeze all sub pages, including the head page
> of pages returned from low level allocators before converting to a
> hugetlb page.  This helps avoid races if we want to replace the page
> containing vmemmap for the head page.
>=20
> There have been proposals to change at least the buddy allocator to
> return frozen pages as described at [3].  If such a change is made, it
> can be employed by the hugetlb code.  However, as mentioned above
> hugetlb uses several low level allocators so each would need to be
> modified to return frozen pages.  For now, we can manually freeze the
> returned pages.  This is done in two places:
> 1) alloc_buddy_huge_page, only the returned head page is ref counted.
>   We freeze the head page, retrying once in the VERY rare case where
>   there may be an inflated ref count.
> 2) prep_compound_gigantic_page, for gigantic pages the current code
>   freezes all pages except the head page.  New code will simply freeze
>   the head page as well.
>=20
> In a few other places, code checks for inflated ref counts on newly
> allocated hugetlb pages.  With the modifications to freeze after
> allocating, this code can be removed.
>=20
> After hugetlb pages are freshly allocated, they are often added to the
> hugetlb free lists.  Since these pages were previously ref counted, =
this
> was done via put_page() which would end up calling the hugetlb
> destructor: free_huge_page.  With changes to freeze pages, we simply
> call free_huge_page directly to add the pages to the free list.
>=20
> In a few other places, freshly allocated hugetlb pages were =
immediately
> put into use, and the expectation was they were already ref counted.  =
In
> these cases, we must manually ref count the page.
>=20
> [1] =
https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@orac=
le.com/
> [2] =
https://lore.kernel.org/linux-mm/20220802180309.19340-1-joao.m.martins@ora=
cle.com/
> [3] =
https://lore.kernel.org/linux-mm/20220809171854.3725722-1-willy@infradead.=
org/
>=20
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks Mike.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>


