Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166C660C3DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJYGgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJYGgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:36:43 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813A107CF0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:36:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666679800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNfH4Na6tLqevIRQ3qGFBgJgqk9m6+FNugR3w29RlFI=;
        b=RHocQ+N6kzm6Sqc1c01aNKayp9SthUiCoiPu94Y7yT5Y9aE9VP+8zrKxdyzRhdtVAKCHua
        U70Zy6xVWsNXZjyAB+nGUBq10aZHuMGmnQfJYhqSRkq5JVvHWsZc/N/USNSlf8L8qM3G7q
        gmv6ka3ep6rwZuYVH83Rrg8b9ajaig8=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH -next 1/1] mm: hugetlb_vmemmap: Fix WARN_ON in
 vmemmap_remap_pte
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221025014215.3466904-1-mawupeng1@huawei.com>
Date:   Tue, 25 Oct 2022 14:36:19 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, catalin.marinas@arm.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <614E3E83-1EAB-4C39-AF9C-83C0CCF26218@linux.dev>
References: <20221025014215.3466904-1-mawupeng1@huawei.com>
To:     Wupeng Ma <mawupeng1@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 25, 2022, at 09:42, Wupeng Ma <mawupeng1@huawei.com> wrote:
>=20
> From: Ma Wupeng <mawupeng1@huawei.com>
>=20
> Commit f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated =
with
> each HugeTLB page") add vmemmap_remap_pte to remap the tail pages as
> read-only to catch illegal write operation to the tail page.
>=20
> However this will lead to WARN_ON in arm64 in =
__check_racy_pte_update()

Thanks for your finding this issue.

> since this may lead to dirty state cleaned. This check is introduced =
by
> commit 2f4b829c625e ("arm64: Add support for hardware updates of the
> access and dirty pte bits") and the initial check is as follow:
>=20
>  BUG_ON(pte_write(*ptep) && !pte_dirty(pte));
>=20
> Since we do need to mark this pte as read-only to catch illegal write
> operation to the tail pages, use set_pte  to replace set_pte_at to =
bypass
> this check.

In theory, the waring does not affect anything since the tail vmemmap
pages are supposed to be read-only. So, skipping this check for vmemmap
pages seem feasible. But I am not sure whether it is general to use
set_pte here instead of set_pte_at, I didn=E2=80=99t see any users of =
set_pte
from the common code routines except the code from arch/xxx. And this
issue is specific for arm64, so I suggest fixing it in =
__check_racy_pte_update()
itself.

Something like (Just some thoughts from mine):

diff --git a/arch/arm64/include/asm/pgtable.h =
b/arch/arm64/include/asm/pgtable.h
index b5df82aa99e6..df7716965a93 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -292,7 +292,8 @@ extern void __sync_icache_dcache(pte_t pteval);
  *   PTE_DIRTY || (PTE_WRITE && !PTE_RDONLY)
  */

-static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t =
*ptep,
+static inline void __check_racy_pte_update(struct mm_struct *mm,
+                                          unsigned long addr, pte_t =
*ptep,
                                           pte_t pte)
 {
        pte_t old_pte;
@@ -307,6 +308,10 @@ static inline void __check_racy_pte_update(struct =
mm_struct *mm, pte_t *ptep,
        if (mm !=3D current->active_mm && atomic_read(&mm->mm_users) <=3D =
1)
                return;

+       if (IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP) &&
+           addr >=3D VMEMMAP_START && addr <=3D VMEMMAP_END)
+               return;
+
        /*
         * Check for potential race with hardware updates of the pte
         * (ptep_set_access_flags safely changes valid ptes without =
going

>=20
> The following shell command can be used to reproduce this WARN_ON in
> 6.1.0-rc1:
>=20
>  echo 1 > /proc/sys/vm/hugetlb_optimize_vmemmap
>  cat /proc/sys/vm/hugetlb_optimize_vmemmap
>=20
>  echo 1024 > /proc/sys/vm/nr_overcommit_hugepages
>  mkdir -p /root/hugetlb
>  mount none /root/hugetlb -t hugetlbfs
>  fallocate -l 2g /root/hugetlb/xx &
>=20
> Here is the detail WARN_ON log:
>=20
> ------------[ cut here ]------------
> __check_racy_pte_update: racy dirty state clearing: 0x0068000416899f03 =
-> 0x0060000416898f83
> WARNING: CPU: 3 PID: 394 at arch/arm64/include/asm/pgtable.h:318 =
vmemmap_remap_pte+0x118/0x120
> Modules linked in:
> CPU: 3 PID: 394 Comm: fallocate Not tainted 6.1.0-rc1 #224
> Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> Call trace:
> vmemmap_remap_pte+0x118/0x120
> vmemmap_remap_range+0x30c/0x560
> hugetlb_vmemmap_optimize+0x158/0x408
> __prep_new_huge_page+0x24/0x150
> prep_new_huge_page+0x30/0x60
> alloc_fresh_huge_page+0x1c4/0x1e0
> alloc_surplus_huge_page+0xa0/0x168
> alloc_huge_page+0x264/0x5b8
> hugetlbfs_fallocate+0x294/0x680
> vfs_fallocate+0x12c/0x568
> ksys_fallocate+0x50/0xa0
> __arm64_sys_fallocate+0x28/0x38
> invoke_syscall+0x4c/0x110
> el0_svc_common.constprop.0+0x68/0x128
> do_el0_svc+0x34/0xd0
> el0_svc+0x48/0xb8
> el0t_64_sync_handler+0xb8/0xc0
> el0t_64_sync+0x18c/0x190
> ---[ end trace 0000000000000000 ]---
>=20
> Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated =
with each HugeTLB page")

Actually, this commit does not pose the issue for arm64. I think the =
correct commit
which should be fixed is 1e63ac088f20f7a4425c430c31ecd3cf167fb3f2.

Thanks.

> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
> mm/hugetlb_vmemmap.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index ba2a2596fb4e..cb056265c31e 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -249,7 +249,7 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned =
long addr,
> struct page *page =3D pte_page(*pte);
>=20
> list_add_tail(&page->lru, walk->vmemmap_pages);
> - set_pte_at(&init_mm, addr, pte, entry);
> + set_pte(pte, entry);
> }
>=20
> /*
> --=20
> 2.25.1
>=20
>=20

