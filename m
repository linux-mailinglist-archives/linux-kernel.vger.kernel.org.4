Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D654615C9F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiKBHBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiKBHBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:01:43 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A1313FA6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:01:41 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667372500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qK9cMec3SZXP7HauTeFzO1OvN44kk4vAgerrnQ9ghzM=;
        b=J76RWrjG8aJ0pOKhcsDt0tyWvwuKmzBQu1s6PmjeGSv0jznSJJ89WAJ+03/HbFxlDYxg6m
        +p6Y3tmoTj79PQ5yVU/YF+m/23nILKCZqFRdXLry3sbtaEGTE31i9gUjOXRv9Hr8B4J0TY
        d01NGExkPZQYL0QlavW3xbuXM50jams=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH v2 9/9] mm/hugetlb: convert move_hugetlb_state() to folios
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221101223059.460937-10-sidhartha.kumar@oracle.com>
Date:   Wed, 2 Nov 2022 15:01:25 +0800
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
Message-Id: <C5D960FD-F2FB-407E-BB1F-5919066BA8C4@linux.dev>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
 <20221101223059.460937-10-sidhartha.kumar@oracle.com>
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
> Clean up unmap_and_move_huge_page() by converting move_hugetlb_state() =
to
> take in folios.
>=20
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

A nit below.

> ---
> include/linux/hugetlb.h |  6 +++---
> mm/hugetlb.c            | 22 ++++++++++++----------
> mm/migrate.c            |  4 ++--
> 3 files changed, 17 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index d81f139193aa..375cd57721d6 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -184,7 +184,7 @@ int get_hwpoison_huge_page(struct page *page, bool =
*hugetlb, bool unpoison);
> int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> bool *migratable_cleared);
> void putback_active_hugepage(struct page *page);
> -void move_hugetlb_state(struct page *oldpage, struct page *newpage, =
int reason);
> +void move_hugetlb_state(struct folio *old_folio, struct folio =
*new_folio, int reason);
> void free_huge_page(struct page *page);
> void hugetlb_fix_reserve_counts(struct inode *inode);
> extern struct mutex *hugetlb_fault_mutex_table;
> @@ -440,8 +440,8 @@ static inline void putback_active_hugepage(struct =
page *page)
> {
> }
>=20
> -static inline void move_hugetlb_state(struct page *oldpage,
> - struct page *newpage, int reason)
> +static inline void move_hugetlb_state(struct folio *old_folio,
> + struct folio *new_folio, int reason)
> {
> }
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 2ecc0a6cf883..2ab8f3b7132a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7289,15 +7289,15 @@ void putback_active_hugepage(struct page =
*page)
> put_page(page);
> }
>=20
> -void move_hugetlb_state(struct page *oldpage, struct page *newpage, =
int reason)
> +void move_hugetlb_state(struct folio *old_folio, struct folio =
*new_folio, int reason)
> {
> - struct hstate *h =3D page_hstate(oldpage);
> + struct hstate *h =3D folio_hstate(old_folio);
>=20
> - hugetlb_cgroup_migrate(page_folio(oldpage), page_folio(newpage));
> - set_page_owner_migrate_reason(newpage, reason);
> + hugetlb_cgroup_migrate(old_folio, new_folio);
> + set_page_owner_migrate_reason(&new_folio->page, reason);
>=20
> /*
> - * transfer temporary state of the new huge page. This is
> + * transfer temporary state of the new hugetlb folio. This is
> * reverse to other transitions because the newpage is going to
> * be final while the old one will be freed so it takes over
> * the temporary status.
> @@ -7306,12 +7306,14 @@ void move_hugetlb_state(struct page *oldpage, =
struct page *newpage, int reason)
> * here as well otherwise the global surplus count will not match
> * the per-node's.
> */
> - if (HPageTemporary(newpage)) {
> - int old_nid =3D page_to_nid(oldpage);
> - int new_nid =3D page_to_nid(newpage);
> + if (folio_test_hugetlb_temporary(new_folio)) {
> + int old_nid =3D folio_nid(old_folio);
> + int new_nid =3D folio_nid(new_folio);
> +
> +

Please remove this redundant blank line.

Thanks.

> + folio_set_hugetlb_temporary(old_folio);
> + folio_clear_hugetlb_temporary(new_folio);
>=20
> - SetHPageTemporary(oldpage);
> - ClearHPageTemporary(newpage);
>=20
> /*
> * There is no need to transfer the per-node surplus state
> diff --git a/mm/migrate.c b/mm/migrate.c
> index d7db4fd97d8e..81f9a36c754d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1278,7 +1278,7 @@ static int unmap_and_move_huge_page(new_page_t =
get_new_page,
> * folio_mapping() set, hugetlbfs specific move page routine will not
> * be called and we could leak usage counts for subpools.
> */
> - if (hugetlb_page_subpool(hpage) && !folio_mapping(src)) {
> + if (hugetlb_folio_subpool(src) && !folio_mapping(src)) {
> rc =3D -EBUSY;
> goto out_unlock;
> }
> @@ -1328,7 +1328,7 @@ static int unmap_and_move_huge_page(new_page_t =
get_new_page,
> put_anon_vma(anon_vma);
>=20
> if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
> - move_hugetlb_state(hpage, new_hpage, reason);
> + move_hugetlb_state(src, dst, reason);
> put_new_page =3D NULL;
> }
>=20
> --=20
> 2.31.1
>=20
>=20

