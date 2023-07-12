Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29317500AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjGLIEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjGLIE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:04:29 -0400
Received: from out-3.mta1.migadu.com (out-3.mta1.migadu.com [95.215.58.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293E8173A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:04:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689149066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kQGtHc+N0kBzheMdTFEuRcExKmasAznpDZbENi8pLk=;
        b=h+DR9B2FISyzDGCFrq/K/NU6zpYWWVYhJgPEvBQCkSLqHUchXRPV5dvh81F5Hdkp6mVqoq
        mP/bwmQWfPEHqkySzty5kKM8gG5qRRYhgkXuqh74BgJf63KBhO2lKDeijzxBP6b0gIEDaK
        KWikBffTqmCQxjje3bOwzeZUP4af+Ns=
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] hugetlb: Do not clear hugetlb dtor until allocating
 vmemmap
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230711220942.43706-2-mike.kravetz@oracle.com>
Date:   Wed, 12 Jul 2023 16:03:42 +0800
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4469DCBD-59B4-41F2-A097-E5F01DD9E967@linux.dev>
References: <20230711220942.43706-1-mike.kravetz@oracle.com>
 <20230711220942.43706-2-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2023, at 06:09, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> Freeing a hugetlb page and releasing base pages back to the underlying
> allocator such as buddy or cma is performed in two steps:
> - remove_hugetlb_folio() is called to remove the folio from hugetlb
>  lists, get a ref on the page and remove hugetlb destructor.  This
>  all must be done under the hugetlb lock.  After this call, the page
>  can be treated as a normal compound page or a collection of base
>  size pages.
> - update_and_free_hugetlb_folio() is called to allocate vmemmap if
>  needed and the free routine of the underlying allocator is called
>  on the resulting page.  We can not hold the hugetlb lock here.
>=20
> One issue with this scheme is that a memory error could occur between
> these two steps.  In this case, the memory error handling code treats
> the old hugetlb page as a normal compound page or collection of base
> pages.  It will then try to SetPageHWPoison(page) on the page with an
> error.  If the page with error is a tail page without vmemmap, a write
> error will occur when trying to set the flag.
>=20
> Address this issue by modifying remove_hugetlb_folio() and
> update_and_free_hugetlb_folio() such that the hugetlb destructor is =
not
> cleared until after allocating vmemmap.  Since clearing the destructor
> requires holding the hugetlb lock, the clearing is done in
> remove_hugetlb_folio() if the vmemmap is present.  This saves a
> lock/unlock cycle.  Otherwise, destructor is cleared in
> update_and_free_hugetlb_folio() after allocating vmemmap.
>=20
> Note that this will leave hugetlb pages in a state where they are =
marked
> free (by hugetlb specific page flag) and have a ref count.  This is =
not
> a normal state.  The only code that would notice is the memory error
> code, and it is set up to retry in such a case.
>=20
> A subsequent patch will create a routine to do bulk processing of
> vmemmap allocation.  This will eliminate a lock/unlock cycle for each
> hugetlb page in the case where we are freeing a large number of pages.
>=20
> Fixes: ad2fa3717b74 ("mm: hugetlb: alloc the vmemmap pages associated =
with each HugeTLB page")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Hi Mike,

I have seen an issue proposed by Jiaqi Yan in [1]. I didn't see any
resolution for it. Am I missing something with this fix?

[1] =
https://lore.kernel.org/linux-mm/CACw3F53iPiLrJt4pyaX2aaZ5BVg9tj8x_k6-v7=3D=
9Xn1nrh=3DUCw@mail.gmail.com/

Thanks.=
