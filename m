Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9682A615C8D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiKBG5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiKBG5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:57:11 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9353826AF3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 23:57:09 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667372228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIxI+9EdE71N9U8wkgda/gJcxSWf1ZLf+S0jdoHjU94=;
        b=C9YUghnftq/TfXN6bX7Qrxu+0o0Cb87r01qreIupnvLomHcUTtag/dkaEjED/fghkFTYP2
        XhkQz/7jNm31OG7DuaSn60TIY4rw8Mma4J7ME6TKaOCXh0WX0+cGy0KxOFxYafN4Y58Ssf
        +0eqjGzdW3TKGyyVK8dBE/eDa1mbWRE=
MIME-Version: 1.0
Subject: Re: [PATCH v2 7/9] mm/hugetlb_cgroup: convert
 hugetlb_cgroup_uncharge_page() to folios
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221101223059.460937-8-sidhartha.kumar@oracle.com>
Date:   Wed, 2 Nov 2022 14:56:48 +0800
Cc:     linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C406644F-2DDF-4404-9D00-41199DE033DB@linux.dev>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
 <20221101223059.460937-8-sidhartha.kumar@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 2, 2022, at 06:30, Sidhartha Kumar <sidhartha.kumar@oracle.com> =
wrote:
>=20
> Continue to use a folio inside free_huge_page() by converting
> hugetlb_cgroup_uncharge_page*() to folios.
>=20
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>


Reviewed-by: Muchun Song <songmuchun@bytedance.com>

A nit below.

> ---
> include/linux/hugetlb_cgroup.h | 16 ++++++++--------
> mm/hugetlb.c                   | 15 +++++++++------
> mm/hugetlb_cgroup.c            | 21 ++++++++++-----------
> 3 files changed, 27 insertions(+), 25 deletions(-)
>=20
> diff --git a/include/linux/hugetlb_cgroup.h =
b/include/linux/hugetlb_cgroup.h
> index 789b6fef176d..c70f92fe493e 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -158,10 +158,10 @@ extern void hugetlb_cgroup_commit_charge(int =
idx, unsigned long nr_pages,
> extern void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long =
nr_pages,
>      struct hugetlb_cgroup *h_cg,
>      struct page *page);
> -extern void hugetlb_cgroup_uncharge_page(int idx, unsigned long =
nr_pages,
> - struct page *page);
> -extern void hugetlb_cgroup_uncharge_page_rsvd(int idx, unsigned long =
nr_pages,
> -      struct page *page);
> +extern void hugetlb_cgroup_uncharge_folio(int idx, unsigned long =
nr_pages,
> + struct folio *folio);
> +extern void hugetlb_cgroup_uncharge_folio_rsvd(int idx, unsigned long =
nr_pages,
> +      struct folio *folio);
>=20
> extern void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long =
nr_pages,
>   struct hugetlb_cgroup *h_cg);
> @@ -254,14 +254,14 @@ hugetlb_cgroup_commit_charge_rsvd(int idx, =
unsigned long nr_pages,
> {
> }
>=20
> -static inline void hugetlb_cgroup_uncharge_page(int idx, unsigned =
long nr_pages,
> - struct page *page)
> +static inline void hugetlb_cgroup_uncharge_folio(int idx, unsigned =
long nr_pages,
> + struct folio *folio)
> {
> }
>=20
> -static inline void hugetlb_cgroup_uncharge_page_rsvd(int idx,
> +static inline void hugetlb_cgroup_uncharge_folio_rsvd(int idx,
>     unsigned long nr_pages,
> -     struct page *page)
> +     struct folio *folio)
> {
> }
> static inline void hugetlb_cgroup_uncharge_cgroup(int idx,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 387b8d74107d..2ecc0a6cf883 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1726,10 +1726,10 @@ void free_huge_page(struct page *page)
>=20
> spin_lock_irqsave(&hugetlb_lock, flags);
> folio_clear_hugetlb_migratable(folio);
> - hugetlb_cgroup_uncharge_page(hstate_index(h),
> -     pages_per_huge_page(h), page);
> - hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
> -  pages_per_huge_page(h), page);
> + hugetlb_cgroup_uncharge_folio(hstate_index(h),
> +     pages_per_huge_page(h), folio);
> + hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
> +  pages_per_huge_page(h), folio);
> if (restore_reserve)
> h->resv_huge_pages++;
>=20
> @@ -2855,6 +2855,7 @@ struct page *alloc_huge_page(struct =
vm_area_struct *vma,
> struct hugepage_subpool *spool =3D subpool_vma(vma);
> struct hstate *h =3D hstate_vma(vma);
> struct page *page;
> + struct folio *folio;
> long map_chg, map_commit;
> long gbl_chg;
> int ret, idx;
> @@ -2918,6 +2919,7 @@ struct page *alloc_huge_page(struct =
vm_area_struct *vma,
> * a reservation exists for the allocation.
> */
> page =3D dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
> +

Redundant blank line.

> if (!page) {
> spin_unlock_irq(&hugetlb_lock);
> page =3D alloc_buddy_huge_page_with_mpol(h, vma, addr);
> @@ -2932,6 +2934,7 @@ struct page *alloc_huge_page(struct =
vm_area_struct *vma,
> set_page_refcounted(page);
> /* Fall through */
> }
> + folio =3D page_folio(page);
> hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
> /* If allocation is not consuming a reservation, also store the
> * hugetlb_cgroup pointer on the page.
> @@ -2961,8 +2964,8 @@ struct page *alloc_huge_page(struct =
vm_area_struct *vma,
> rsv_adjust =3D hugepage_subpool_put_pages(spool, 1);
> hugetlb_acct_memory(h, -rsv_adjust);
> if (deferred_reserve)
> - hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
> - pages_per_huge_page(h), page);
> + hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
> + pages_per_huge_page(h), folio);
> }
> return page;
>=20
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 351ffb40261c..7793401acc12 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -349,11 +349,10 @@ void hugetlb_cgroup_commit_charge_rsvd(int idx, =
unsigned long nr_pages,
> /*
>  * Should be called with hugetlb_lock held
>  */
> -static void __hugetlb_cgroup_uncharge_page(int idx, unsigned long =
nr_pages,
> -   struct page *page, bool rsvd)
> +static void __hugetlb_cgroup_uncharge_folio(int idx, unsigned long =
nr_pages,
> +   struct folio *folio, bool rsvd)
> {
> struct hugetlb_cgroup *h_cg;
> - struct folio *folio =3D page_folio(page);
>=20
> if (hugetlb_cgroup_disabled())
> return;
> @@ -371,27 +370,27 @@ static void __hugetlb_cgroup_uncharge_page(int =
idx, unsigned long nr_pages,
> css_put(&h_cg->css);
> else {
> unsigned long usage =3D
> - h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
> + h_cg->nodeinfo[folio_nid(folio)]->usage[idx];
> /*
> * This write is not atomic due to fetching usage and writing
> * to it, but that's fine because we call this with
> * hugetlb_lock held anyway.
> */
> - WRITE_ONCE(h_cg->nodeinfo[page_to_nid(page)]->usage[idx],
> + WRITE_ONCE(h_cg->nodeinfo[folio_nid(folio)]->usage[idx],
>   usage - nr_pages);
> }
> }
>=20
> -void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
> -  struct page *page)
> +void hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
> +  struct folio *folio)
> {
> - __hugetlb_cgroup_uncharge_page(idx, nr_pages, page, false);
> + __hugetlb_cgroup_uncharge_folio(idx, nr_pages, folio, false);
> }
>=20
> -void hugetlb_cgroup_uncharge_page_rsvd(int idx, unsigned long =
nr_pages,
> -       struct page *page)
> +void hugetlb_cgroup_uncharge_folio_rsvd(int idx, unsigned long =
nr_pages,
> +       struct folio *folio)
> {
> - __hugetlb_cgroup_uncharge_page(idx, nr_pages, page, true);
> + __hugetlb_cgroup_uncharge_folio(idx, nr_pages, folio, true);
> }
>=20
> static void __hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long =
nr_pages,
> --=20
> 2.31.1
>=20
>=20

