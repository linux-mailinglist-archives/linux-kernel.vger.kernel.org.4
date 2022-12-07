Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9AD6452EE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 05:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiLGEMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 23:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLGEMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 23:12:21 -0500
X-Greylist: delayed 2246 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Dec 2022 20:12:16 PST
Received: from out-208.mta0.migadu.com (out-208.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A2756D46
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 20:12:16 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670386334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qBCf47qb2aY6gmVjpcghrroquCbPHnH9YppUjL507oU=;
        b=HtYv1s16mEhjj3qnzjCxjDd6CcVPRj+6pLmKnf96fLJDtU/PnoPHcSQUWx1Ak7Jt+nmOoA
        vGqcC2NFicFK1essqXHL1/GwPzQUUSBw1wjHsAPfAi4ZGlKd0/M/2Ye1i4J51UUtZU1/r+
        xGpkgPWqUOZ9Rs/Gt/XmVxMJ2hkrsx0=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH mm-unstable v5 01/10] mm: add folio dtor and order setter
 functions
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <Y5ALigw0kUO/B3z2@monkey>
Date:   Wed, 7 Dec 2022 12:11:56 +0800
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com,
        David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4161AF1A-9508-4DF8-B756-FEB476EB32B5@linux.dev>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-2-sidhartha.kumar@oracle.com>
 <BAD34D59-187B-4BB3-B139-7983A8B62648@linux.dev> <Y5ALigw0kUO/B3z2@monkey>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 7, 2022, at 11:42, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> On 12/07/22 11:34, Muchun Song wrote:
>>=20
>>=20
>>> On Nov 30, 2022, at 06:50, Sidhartha Kumar =
<sidhartha.kumar@oracle.com> wrote:
>>>=20
>>> Add folio equivalents for set_compound_order() and =
set_compound_page_dtor().
>>>=20
>>> Also remove extra new-lines introduced by mm/hugetlb: convert
>>> move_hugetlb_state() to folios and mm/hugetlb_cgroup: convert
>>> hugetlb_cgroup_uncharge_page() to folios.
>>>=20
>>> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> Suggested-by: Muchun Song <songmuchun@bytedance.com>
>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>> ---
>>> include/linux/mm.h | 16 ++++++++++++++++
>>> mm/hugetlb.c       |  4 +---
>>> 2 files changed, 17 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index a48c5ad16a5e..2bdef8a5298a 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -972,6 +972,13 @@ static inline void =
set_compound_page_dtor(struct page *page,
>>> page[1].compound_dtor =3D compound_dtor;
>>> }
>>>=20
>>> +static inline void folio_set_compound_dtor(struct folio *folio,
>>> + enum compound_dtor_id compound_dtor)
>>> +{
>>> + VM_BUG_ON_FOLIO(compound_dtor >=3D NR_COMPOUND_DTORS, folio);
>>> + folio->_folio_dtor =3D compound_dtor;
>>> +}
>>> +
>>> void destroy_large_folio(struct folio *folio);
>>>=20
>>> static inline int head_compound_pincount(struct page *head)
>>> @@ -987,6 +994,15 @@ static inline void set_compound_order(struct =
page *page, unsigned int order)
>>> #endif
>>> }
>>>=20
>>> +static inline void folio_set_compound_order(struct folio *folio,
>>> + unsigned int order)
>>> +{
>>> + folio->_folio_order =3D order;
>>> +#ifdef CONFIG_64BIT
>>> + folio->_folio_nr_pages =3D order ? 1U << order : 0;
>>=20
>> It seems that you think the user could pass 0 to order. However,
>> ->_folio_nr_pages and ->_folio_order fields are invalid for order-0 =
pages.
>> You should not touch it. So this should be:
>>=20
>> static inline void folio_set_compound_order(struct folio *folio,
>>     unsigned int order)
>> {
>> 	if (!folio_test_large(folio))
>> 		return;
>>=20
>> 	folio->_folio_order =3D order;
>> #ifdef CONFIG_64BIT
>> 	folio->_folio_nr_pages =3D 1U << order;
>> #endif
>> }
>=20
> I believe this was changed to accommodate the code in
> __destroy_compound_gigantic_page().  It is used in a subsequent patch.
> Here is the v6.0 version of the routine.

Thanks for your clarification.

>=20
> static void __destroy_compound_gigantic_page(struct page *page,
> unsigned int order, bool demote)
> {
> 	int i;
> 	int nr_pages =3D 1 << order;
> 	struct page *p =3D page + 1;
>=20
> 	atomic_set(compound_mapcount_ptr(page), 0);
> 	atomic_set(compound_pincount_ptr(page), 0);
>=20
> 	for (i =3D 1; i < nr_pages; i++, p =3D mem_map_next(p, page, i)) =
{
> 		p->mapping =3D NULL;
> 		clear_compound_head(p);
> 		if (!demote)
> 			set_page_refcounted(p);
> 	}
>=20
> 	set_compound_order(page, 0);
> #ifdef CONFIG_64BIT
> 	page[1].compound_nr =3D 0;
> #endif
> 	__ClearPageHead(page);
> }
>=20
>=20
> Might have been better to change this set_compound_order call to
> folio_set_compound_order in this patch.
>=20

Agree. It has confused me a lot. I suggest changing the code to the
followings. The folio_test_large() check is still to avoid unexpected
users for OOB.

static inline void folio_set_compound_order(struct folio *folio,
					    unsigned int order)
{
	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
	// or
	// if (!folio_test_large(folio))
	// 	return;

	folio->_folio_order =3D order;
#ifdef CONFIG_64BIT
	folio->_folio_nr_pages =3D order ? 1U << order : 0;
#endif
}

Thanks.


