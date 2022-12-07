Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76104645292
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 04:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiLGDez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 22:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLGDex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 22:34:53 -0500
Received: from out-101.mta0.migadu.com (out-101.mta0.migadu.com [91.218.175.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700F2554F7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 19:34:52 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670384088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4i3NqzvNgLLOzXJhJCK2qX1KHILXyG9rywWTvTCb8A=;
        b=qmC7lv40Mfq0jF+qtrceU5586th75q2MNlPTDgNdm5fv2HRn2tnhdUydqq8G1i+CeYZi6a
        la3cDX/xZpfr2/19O7J8R9oeHZaC68qZqbslAs5LMxEKPV4da1hUMdLdApDVrqNDHcQqb1
        q8H95CIbNRn7XGWZ30pkXa2JF5ZQbPU=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH mm-unstable v5 01/10] mm: add folio dtor and order setter
 functions
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221129225039.82257-2-sidhartha.kumar@oracle.com>
Date:   Wed, 7 Dec 2022 11:34:31 +0800
Cc:     linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com,
        David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BAD34D59-187B-4BB3-B139-7983A8B62648@linux.dev>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-2-sidhartha.kumar@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 30, 2022, at 06:50, Sidhartha Kumar =
<sidhartha.kumar@oracle.com> wrote:
>=20
> Add folio equivalents for set_compound_order() and =
set_compound_page_dtor().
>=20
> Also remove extra new-lines introduced by mm/hugetlb: convert
> move_hugetlb_state() to folios and mm/hugetlb_cgroup: convert
> hugetlb_cgroup_uncharge_page() to folios.
>=20
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Suggested-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
> include/linux/mm.h | 16 ++++++++++++++++
> mm/hugetlb.c       |  4 +---
> 2 files changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a48c5ad16a5e..2bdef8a5298a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -972,6 +972,13 @@ static inline void set_compound_page_dtor(struct =
page *page,
> page[1].compound_dtor =3D compound_dtor;
> }
>=20
> +static inline void folio_set_compound_dtor(struct folio *folio,
> + enum compound_dtor_id compound_dtor)
> +{
> + VM_BUG_ON_FOLIO(compound_dtor >=3D NR_COMPOUND_DTORS, folio);
> + folio->_folio_dtor =3D compound_dtor;
> +}
> +
> void destroy_large_folio(struct folio *folio);
>=20
> static inline int head_compound_pincount(struct page *head)
> @@ -987,6 +994,15 @@ static inline void set_compound_order(struct page =
*page, unsigned int order)
> #endif
> }
>=20
> +static inline void folio_set_compound_order(struct folio *folio,
> + unsigned int order)
> +{
> + folio->_folio_order =3D order;
> +#ifdef CONFIG_64BIT
> + folio->_folio_nr_pages =3D order ? 1U << order : 0;

It seems that you think the user could pass 0 to order. However,
->_folio_nr_pages and ->_folio_order fields are invalid for order-0 =
pages.
You should not touch it. So this should be:

static inline void folio_set_compound_order(struct folio *folio,
					    unsigned int order)
{
	if (!folio_test_large(folio))
		return;

	folio->_folio_order =3D order;
#ifdef CONFIG_64BIT
	folio->_folio_nr_pages =3D 1U << order;
#endif
}

If we can make sure all the users of folio_set_compound_order() should =
pass
a non-order-0 page (it is true for now), then I suggest adding a =
VM_BUG_ON()
here to catch unexpected users.

static inline void folio_set_compound_order(struct folio *folio,
					    unsigned int order)
{
	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);

	folio->_folio_order =3D order;
#ifdef CONFIG_64BIT
	folio->_folio_nr_pages =3D 1U << order;
#endif
}

Thanks.

> +#endif
> +}
> +

