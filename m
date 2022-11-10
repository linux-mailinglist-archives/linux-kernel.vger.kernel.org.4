Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6A623CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiKJHfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiKJHfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:35:08 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309ABFD17
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:35:06 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668065700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tNISy899ouI/LojBKvWhC6Wq5gqV0VP7rkPj0zdhC7I=;
        b=fO/bzuXPYGjjHnVPhFkdDnxqLD7/64l6n+u7apXTeN15xkbbBknatw3msOvNs273sacLnM
        CHiyeFPeT3AJ7RyBixfUYCuFzM+zKO0WsQfn0aV3ojro57q56UELrnJkMJiEKxMAIZfgBV
        9xcEuGJ/nPhv61sAeq4dNy9CBHhaC9Y=
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/9] mm/hugetlb_cgroup: convert set_hugetlb_cgroup*()
 to folios
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <34332121-488f-c0b9-13bc-08d6e06ad4a7@oracle.com>
Date:   Thu, 10 Nov 2022 15:34:42 +0800
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
Message-Id: <EF1E26AB-6DEB-4A66-9498-422A22FE2730@linux.dev>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
 <20221101223059.460937-4-sidhartha.kumar@oracle.com>
 <6935E6F8-9950-465F-8752-5CADF1C7D317@linux.dev>
 <34332121-488f-c0b9-13bc-08d6e06ad4a7@oracle.com>
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



> On Nov 10, 2022, at 08:20, Sidhartha Kumar =
<sidhartha.kumar@oracle.com> wrote:
>=20
>=20
> On 11/1/22 11:45 PM, Muchun Song wrote:
>>=20
>>> On Nov 2, 2022, at 06:30, Sidhartha Kumar =
<sidhartha.kumar@oracle.com> wrote:
>>>=20
>>> Allows __prep_new_huge_page() to operate on a folio by converting
>>> set_hugetlb_cgroup*() to take in a folio.
>>>=20
>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>> ---
>>> include/linux/hugetlb_cgroup.h | 12 ++++++------
>>> mm/hugetlb.c                   | 33 =
+++++++++++++++++++--------------
>>> mm/hugetlb_cgroup.c            | 11 ++++++-----
>>> 3 files changed, 31 insertions(+), 25 deletions(-)
>>>=20
>>> diff --git a/include/linux/hugetlb_cgroup.h =
b/include/linux/hugetlb_cgroup.h
>>> index feb2edafc8b6..a7e3540f7f38 100644
>>> --- a/include/linux/hugetlb_cgroup.h
>>> +++ b/include/linux/hugetlb_cgroup.h
>>> @@ -112,16 +112,16 @@ static inline void __set_hugetlb_cgroup(struct =
folio *folio,
>>> (unsigned long)h_cg);
>>> }
>>>=20
>>> -static inline void set_hugetlb_cgroup(struct page *page,
>>> +static inline void set_hugetlb_cgroup(struct folio *folio,
>>>     struct hugetlb_cgroup *h_cg)
>>> {
>>> - __set_hugetlb_cgroup(page_folio(page), h_cg, false);
>>> + __set_hugetlb_cgroup(folio, h_cg, false);
>>> }
>>>=20
>>> -static inline void set_hugetlb_cgroup_rsvd(struct page *page,
>>> +static inline void set_hugetlb_cgroup_rsvd(struct folio *folio,
>>>  struct hugetlb_cgroup *h_cg)
>>> {
>>> - __set_hugetlb_cgroup(page_folio(page), h_cg, true);
>>> + __set_hugetlb_cgroup(folio, h_cg, true);
>>> }
>>>=20
>>> static inline bool hugetlb_cgroup_disabled(void)
>>> @@ -199,12 +199,12 @@ hugetlb_cgroup_from_folio_rsvd(struct folio =
*folio)
>>> return NULL;
>>> }
>>>=20
>>> -static inline void set_hugetlb_cgroup(struct page *page,
>>> +static inline void set_hugetlb_cgroup(struct folio *folio,
>>>     struct hugetlb_cgroup *h_cg)
>>> {
>>> }
>>>=20
>>> -static inline void set_hugetlb_cgroup_rsvd(struct page *page,
>>> +static inline void set_hugetlb_cgroup_rsvd(struct folio *folio,
>>>  struct hugetlb_cgroup *h_cg)
>>> {
>>> }
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 27b87dc85c48..a6384fb0b57f 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -1758,19 +1758,21 @@ static void =
__prep_account_new_huge_page(struct hstate *h, int nid)
>>> h->nr_huge_pages_node[nid]++;
>>> }
>>>=20
>>> -static void __prep_new_huge_page(struct hstate *h, struct page =
*page)
>>> +static void __prep_new_hugetlb_folio(struct hstate *h, struct folio =
*folio)
>>> {
>>> - hugetlb_vmemmap_optimize(h, page);
>>> - INIT_LIST_HEAD(&page->lru);
>>> - set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
>>> - hugetlb_set_page_subpool(page, NULL);
>>> - set_hugetlb_cgroup(page, NULL);
>>> - set_hugetlb_cgroup_rsvd(page, NULL);
>>> + hugetlb_vmemmap_optimize(h, &folio->page);
>>> + INIT_LIST_HEAD(&folio->lru);
>>> + folio->_folio_dtor =3D HUGETLB_PAGE_DTOR;
>> Seems like a variant of set_compound_page_dtor() for folio is =
missing,
>> e.g. set_large_folio_dtor(). It's better to add it in this series.
>>=20
>> Thanks.
>=20
> Hi Muchun thanks for taking a look,
>=20
> Would it be ok to add this functionality in a separate patch series? =
Some of the earlier patches in this series were=20

I'm ok.

Thanks.

> modified by Hugh's series[1] so I'm not sure how a v3 of this series =
would look now. Let me know which approach you would prefer.
>=20
>=20
> Thanks,
>=20
> Sidhartha Kumar
>=20
> [1] =
https://lore.kernel.org/linux-mm/3818cc9a-9999-d064-d778-9c94c5911e6@googl=
e.com/
>=20
>>> + hugetlb_set_folio_subpool(folio, NULL);
>>> + set_hugetlb_cgroup(folio, NULL);
>>> + set_hugetlb_cgroup_rsvd(folio, NULL);
>>> }
>>>=20
>>> static void prep_new_huge_page(struct hstate *h, struct page *page, =
int nid)
>>> {
>>> - __prep_new_huge_page(h, page);
>>> + struct folio *folio =3D page_folio(page);
>>> +
>>> + __prep_new_hugetlb_folio(h, folio);
>>> spin_lock_irq(&hugetlb_lock);
>>> __prep_account_new_huge_page(h, nid);
>>> spin_unlock_irq(&hugetlb_lock);
>>> @@ -2731,8 +2733,10 @@ static int =
alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>>> struct list_head *list)
>>> {
>>> gfp_t gfp_mask =3D htlb_alloc_mask(h) | __GFP_THISNODE;
>>> - int nid =3D page_to_nid(old_page);
>>> + struct folio *old_folio =3D page_folio(old_page);
>>> + int nid =3D folio_nid(old_folio);
>>> struct page *new_page;
>>> + struct folio *new_folio;
>>> int ret =3D 0;
>>>=20
>>> /*
>>> @@ -2745,16 +2749,17 @@ static int =
alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>>> new_page =3D alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
>>> if (!new_page)
>>> return -ENOMEM;
>>> - __prep_new_huge_page(h, new_page);
>>> + new_folio =3D page_folio(new_page);
>>> + __prep_new_hugetlb_folio(h, new_folio);
>>>=20
>>> retry:
>>> spin_lock_irq(&hugetlb_lock);
>>> - if (!PageHuge(old_page)) {
>>> + if (!folio_test_hugetlb(old_folio)) {
>>> /*
>>> * Freed from under us. Drop new_page too.
>>> */
>>> goto free_new;
>>> - } else if (page_count(old_page)) {
>>> + } else if (folio_ref_count(old_folio)) {
>>> /*
>>> * Someone has grabbed the page, try to isolate it here.
>>> * Fail with -EBUSY if not possible.
>>> @@ -2763,7 +2768,7 @@ static int alloc_and_dissolve_huge_page(struct =
hstate *h, struct page *old_page,
>>> ret =3D isolate_hugetlb(old_page, list);
>>> spin_lock_irq(&hugetlb_lock);
>>> goto free_new;
>>> - } else if (!HPageFreed(old_page)) {
>>> + } else if (!folio_test_hugetlb_freed(old_folio)) {
>>> /*
>>> * Page's refcount is 0 but it has not been enqueued in the
>>> * freelist yet. Race window is small, so we can succeed here if
>>> @@ -2801,7 +2806,7 @@ static int alloc_and_dissolve_huge_page(struct =
hstate *h, struct page *old_page,
>>> free_new:
>>> spin_unlock_irq(&hugetlb_lock);
>>> /* Page has a zero ref count, but needs a ref to be freed */
>>> - set_page_refcounted(new_page);
>>> + folio_ref_unfreeze(new_folio, 1);
>>> update_and_free_page(h, new_page, false);
>>>=20
>>> return ret;
>>> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
>>> index 600c98560a0f..692b23b5d423 100644
>>> --- a/mm/hugetlb_cgroup.c
>>> +++ b/mm/hugetlb_cgroup.c
>>> @@ -212,7 +212,7 @@ static void hugetlb_cgroup_move_parent(int idx, =
struct hugetlb_cgroup *h_cg,
>>> /* Take the pages off the local counter */
>>> page_counter_cancel(counter, nr_pages);
>>>=20
>>> - set_hugetlb_cgroup(page, parent);
>>> + set_hugetlb_cgroup(folio, parent);
>>> out:
>>> return;
>>> }
>>> @@ -894,6 +894,7 @@ void hugetlb_cgroup_migrate(struct page =
*oldhpage, struct page *newhpage)
>>> struct hugetlb_cgroup *h_cg_rsvd;
>>> struct hstate *h =3D page_hstate(oldhpage);
>>> struct folio *old_folio =3D page_folio(oldhpage);
>>> + struct folio *new_folio =3D page_folio(newhpage);
>>>=20
>>> if (hugetlb_cgroup_disabled())
>>> return;
>>> @@ -901,12 +902,12 @@ void hugetlb_cgroup_migrate(struct page =
*oldhpage, struct page *newhpage)
>>> spin_lock_irq(&hugetlb_lock);
>>> h_cg =3D hugetlb_cgroup_from_folio(old_folio);
>>> h_cg_rsvd =3D hugetlb_cgroup_from_folio_rsvd(old_folio);
>>> - set_hugetlb_cgroup(oldhpage, NULL);
>>> - set_hugetlb_cgroup_rsvd(oldhpage, NULL);
>>> + set_hugetlb_cgroup(old_folio, NULL);
>>> + set_hugetlb_cgroup_rsvd(old_folio, NULL);
>>>=20
>>> /* move the h_cg details to new cgroup */
>>> - set_hugetlb_cgroup(newhpage, h_cg);
>>> - set_hugetlb_cgroup_rsvd(newhpage, h_cg_rsvd);
>>> + set_hugetlb_cgroup(new_folio, h_cg);
>>> + set_hugetlb_cgroup_rsvd(new_folio, h_cg_rsvd);
>>> list_move(&newhpage->lru, &h->hugepage_activelist);
>>> spin_unlock_irq(&hugetlb_lock);
>>> return;
>>> --=20
>>> 2.31.1
>>>=20
>>>=20
>>=20

