Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0636C615C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKBGZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiKBGZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:25:35 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785F12613A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 23:25:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667370327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jntjwjspZNMefoaZvKhYfwiwboI0+WZJ1qiv+8t5jBU=;
        b=tqxPaB5HjVYpoKpLBQIpB+xRREDRbYHkG6Wa1wK6L1RC3f2MQT5AMIJH+st+2ZdkMjKANh
        kTnq+nrb970pPO+OD9Kbmw6z6zaAd0tLyQYuJSpWifDOAIBdhxBTuJkr4OUo46gXWUwSPA
        MpgboXURPUDBpxOuXLaDrvjNfgV09iY=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH v2 2/9] mm/hugetlb_cgroup: convert
 hugetlb_cgroup_from_page() to folios
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221101223059.460937-3-sidhartha.kumar@oracle.com>
Date:   Wed, 2 Nov 2022 14:25:13 +0800
Cc:     linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, minhquangbui99@gmail.com,
        aneesh.kumar@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A90972E2-85A3-49B2-8434-A2FBE9BCFBF4@linux.dev>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
 <20221101223059.460937-3-sidhartha.kumar@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 2, 2022, at 06:30, Sidhartha Kumar <sidhartha.kumar@oracle.com> =
wrote:
>=20
> Introduce folios in __remove_hugetlb_page() by converting
> hugetlb_cgroup_from_page() to use folios.
>=20
> Also gets rid of unsed hugetlb_cgroup_from_page_resv() function.
>=20
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

A nit below.

> ---
> include/linux/hugetlb_cgroup.h | 39 +++++++++++++++++-----------------
> mm/hugetlb.c                   |  5 +++--
> mm/hugetlb_cgroup.c            | 13 +++++++-----
> 3 files changed, 31 insertions(+), 26 deletions(-)
>=20
> diff --git a/include/linux/hugetlb_cgroup.h =
b/include/linux/hugetlb_cgroup.h
> index 7576e9ed8afe..feb2edafc8b6 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -67,27 +67,34 @@ struct hugetlb_cgroup {
> };
>=20
> static inline struct hugetlb_cgroup *
> -__hugetlb_cgroup_from_page(struct page *page, bool rsvd)
> +__hugetlb_cgroup_from_folio(struct folio *folio, bool rsvd)
> {
> - VM_BUG_ON_PAGE(!PageHuge(page), page);
> + struct page *tail;
>=20
> - if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
> + VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
> + if (folio_order(folio) < HUGETLB_CGROUP_MIN_ORDER)
> return NULL;
> - if (rsvd)
> - return (void *)page_private(page + SUBPAGE_INDEX_CGROUP_RSVD);
> - else
> - return (void *)page_private(page + SUBPAGE_INDEX_CGROUP);
> +
> + if (rsvd) {
> + tail =3D folio_page(folio, SUBPAGE_INDEX_CGROUP_RSVD);
> + return (void *)page_private(tail);
> + }
> +
> + else {
> + tail =3D folio_page(folio, SUBPAGE_INDEX_CGROUP);
> + return (void *)page_private(tail);
> + }

I suggest reworking the code here to the following (Looks simple for =
me).

int i =3D rsvd ? SUBPAGE_INDEX_CGROUP_RSVD : SUBPAGE_INDEX_CGROUP;

return (void *)page_private(folio_page(folio, i));

> }
>=20
> -static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct =
page *page)
> +static inline struct hugetlb_cgroup *hugetlb_cgroup_from_folio(struct =
folio *folio)
> {
> - return __hugetlb_cgroup_from_page(page, false);
> + return __hugetlb_cgroup_from_folio(folio, false);
> }
>=20
> static inline struct hugetlb_cgroup *
> -hugetlb_cgroup_from_page_rsvd(struct page *page)
> +hugetlb_cgroup_from_folio_rsvd(struct folio *folio)
> {
> - return __hugetlb_cgroup_from_page(page, true);
> + return __hugetlb_cgroup_from_folio(folio, true);
> }
>=20
> static inline void __set_hugetlb_cgroup(struct folio *folio,
> @@ -181,19 +188,13 @@ static inline void =
hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
> {
> }
>=20
> -static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct =
page *page)
> -{
> - return NULL;
> -}
> -
> -static inline struct hugetlb_cgroup *
> -hugetlb_cgroup_from_page_resv(struct page *page)
> +static inline struct hugetlb_cgroup *hugetlb_cgroup_from_folio(struct =
folio *folio)
> {
> return NULL;
> }
>=20
> static inline struct hugetlb_cgroup *
> -hugetlb_cgroup_from_page_rsvd(struct page *page)
> +hugetlb_cgroup_from_folio_rsvd(struct folio *folio)
> {
> return NULL;
> }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 518dfd0a7dbe..27b87dc85c48 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1434,9 +1434,10 @@ static void __remove_hugetlb_page(struct hstate =
*h, struct page *page,
> bool demote)
> {
> int nid =3D page_to_nid(page);
> + struct folio *folio =3D page_folio(page);
>=20
> - VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> - VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> + VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio(folio), folio);
> + VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
>=20
> lockdep_assert_held(&hugetlb_lock);
> if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 81675f8f44e9..600c98560a0f 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -191,8 +191,9 @@ static void hugetlb_cgroup_move_parent(int idx, =
struct hugetlb_cgroup *h_cg,
> struct page_counter *counter;
> struct hugetlb_cgroup *page_hcg;
> struct hugetlb_cgroup *parent =3D parent_hugetlb_cgroup(h_cg);
> + struct folio *folio =3D page_folio(page);
>=20
> - page_hcg =3D hugetlb_cgroup_from_page(page);
> + page_hcg =3D hugetlb_cgroup_from_folio(folio);
> /*
> * We can have pages in active list without any cgroup
> * ie, hugepage with less than 3 pages. We can safely
> @@ -352,14 +353,15 @@ static void __hugetlb_cgroup_uncharge_page(int =
idx, unsigned long nr_pages,
>   struct page *page, bool rsvd)
> {
> struct hugetlb_cgroup *h_cg;
> + struct folio *folio =3D page_folio(page);
>=20
> if (hugetlb_cgroup_disabled())
> return;
> lockdep_assert_held(&hugetlb_lock);
> - h_cg =3D __hugetlb_cgroup_from_page(page, rsvd);
> + h_cg =3D __hugetlb_cgroup_from_folio(folio, rsvd);
> if (unlikely(!h_cg))
> return;
> - __set_hugetlb_cgroup(page_folio(page), NULL, rsvd);
> + __set_hugetlb_cgroup(folio, NULL, rsvd);
>=20
> page_counter_uncharge(__hugetlb_cgroup_counter_from_cgroup(h_cg, idx,
>   rsvd),
> @@ -891,13 +893,14 @@ void hugetlb_cgroup_migrate(struct page =
*oldhpage, struct page *newhpage)
> struct hugetlb_cgroup *h_cg;
> struct hugetlb_cgroup *h_cg_rsvd;
> struct hstate *h =3D page_hstate(oldhpage);
> + struct folio *old_folio =3D page_folio(oldhpage);
>=20
> if (hugetlb_cgroup_disabled())
> return;
>=20
> spin_lock_irq(&hugetlb_lock);
> - h_cg =3D hugetlb_cgroup_from_page(oldhpage);
> - h_cg_rsvd =3D hugetlb_cgroup_from_page_rsvd(oldhpage);
> + h_cg =3D hugetlb_cgroup_from_folio(old_folio);
> + h_cg_rsvd =3D hugetlb_cgroup_from_folio_rsvd(old_folio);
> set_hugetlb_cgroup(oldhpage, NULL);
> set_hugetlb_cgroup_rsvd(oldhpage, NULL);
>=20
> --=20
> 2.31.1
>=20
>=20

