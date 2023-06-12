Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFD672D348
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjFLV2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjFLV1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:27:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808E51B8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16D3262277
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE59C433D2;
        Mon, 12 Jun 2023 21:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686605247;
        bh=7LfNjfS4Zf4U5lMlQ2I09BVw2IXRjySt/jv0/P+rlX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dacuBPoSFVDZwmysWY0+sJX2kCpLfzlOADMPWlPI1SXhY5oymB/CjE1k3GxRDWEvy
         +K68RJCTIWgm2AXWaHWcUrZeQzQSnCsu+OTNcTTgAHVbgq63G39+XV47Am+tCO4Y0Y
         xc9hxFjwncmMg/Twg/IsjTGVO87I/4PrZUqrl48TttOWMtN2d6vRlZoskBNffkVCJZ
         Z1GZRN5dZffADCi0q8aVKxHHhkX5HLiwjCbIGku1nIoQLs2+lxofK9jefoj0jetdPt
         twTY2rj6QVhglYyTNio8xUlTVQDpyJHbHRIi5Jb7iiTi/LUeoY3c/7Mk+b5X/cfkQS
         IAWgPT5j0O17Q==
From:   SeongJae Park <sj@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     "SeongJae Park" <sj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Mike Rapoport" <rppt@kernel.org>, "Yu Zhao" <yuzhao@google.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Dimitri Sivanich" <dimitri.sivanich@hpe.com>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "Muchun Song" <muchun.song@linux.dev>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Ian Rogers" <irogers@google.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        "Alexander Potapenko" <glider@google.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Shakeel Butt" <shakeelb@google.com>,
        "Naoya Horiguchi" <naoya.horiguchi@nec.com>,
        "Miaohe Lin" <linmiaohe@huawei.com>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lorenzo Stoakes" <lstoakes@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 3/3] mm: ptep_get() conversion
Date:   Mon, 12 Jun 2023 21:27:23 +0000
Message-Id: <20230612212723.196693-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230612151545.3317766-4-ryan.roberts@arm.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 16:15:45 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> Convert all instances of direct pte_t* dereferencing to instead use
> ptep_get() helper. This means that by default, the accesses change from
> a C dereference to a READ_ONCE(). This is technically the correct thing
> to do since where pgtables are modified by HW (for access/dirty) they
> are volatile and therefore we should always ensure READ_ONCE()
> semantics.
> 
> But more importantly, by always using the helper, it can be overridden
> by the architecture to fully encapsulate the contents of the pte. Arch
> code is deliberately not converted, as the arch code knows best. It is
> intended that arch code (arm64) will override the default with its own
> implementation that can (e.g.) hide certain bits from the core code, or
> determine young/dirty status by mixing in state from another source.
> 
> Conversion was done using Coccinelle:
> 
> ----
> 
> // $ make coccicheck \
> //          COCCI=ptepget.cocci \
> //          SPFLAGS="--include-headers" \
> //          MODE=patch
> 
> virtual patch
> 
> @ depends on patch @
> pte_t *v;
> @@
> 
> - *v
> + ptep_get(v)
> 
> ----
> 
> Then reviewed and hand-edited to avoid multiple unnecessary calls to
> ptep_get(), instead opting to store the result of a single call in a
> variable, where it is correct to do so. This aims to negate any cost of
> READ_ONCE() and will benefit arch-overrides that may be more complex.
> 
> Included is a fix for an issue in an earlier version of this patch that
> was pointed out by kernel test robot. The issue arose because config
> MMU=n elides definition of the ptep helper functions, including
> ptep_get(). HUGETLB_PAGE=n configs still define a simple
> huge_ptep_clear_flush() for linking purposes, which dereferences the
> ptep. So when both configs are disabled, this caused a build error
> because ptep_get() is not defined. Fix by continuing to do a direct
> dereference when MMU=n. This is safe because for this config the arch
> code cannot be trying to virtualize the ptes because none of the ptep
> helpers are defined.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202305120142.yXsNEo6H-lkp@intel.com/
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  .../drm/i915/gem/selftests/i915_gem_mman.c    |   8 +-
>  drivers/misc/sgi-gru/grufault.c               |   2 +-
>  drivers/vfio/vfio_iommu_type1.c               |   7 +-
>  drivers/xen/privcmd.c                         |   2 +-
>  fs/proc/task_mmu.c                            |  33 +++---
>  fs/userfaultfd.c                              |   6 +-
>  include/linux/hugetlb.h                       |   4 +
>  include/linux/mm_inline.h                     |   2 +-
>  include/linux/pgtable.h                       |   6 +-
>  kernel/events/uprobes.c                       |   2 +-
>  mm/damon/ops-common.c                         |   2 +-
>  mm/damon/paddr.c                              |   2 +-
>  mm/damon/vaddr.c                              |  10 +-
[...]
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index d4ab81229136..e940802a15a4 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -39,7 +39,7 @@ struct folio *damon_get_folio(unsigned long pfn)
>  
>  void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
>  {
> -	struct folio *folio = damon_get_folio(pte_pfn(*pte));
> +	struct folio *folio = damon_get_folio(pte_pfn(ptep_get(pte)));
>  
>  	if (!folio)
>  		return;
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5b3a3463d078..40801e38fcf0 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -89,7 +89,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
>  	while (page_vma_mapped_walk(&pvmw)) {
>  		addr = pvmw.address;
>  		if (pvmw.pte) {
> -			*accessed = pte_young(*pvmw.pte) ||
> +			*accessed = pte_young(ptep_get(pvmw.pte)) ||
>  				!folio_test_idle(folio) ||
>  				mmu_notifier_test_young(vma->vm_mm, addr);
>  		} else {
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index e814f66dfc2e..2fcc9731528a 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -323,7 +323,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
>  		walk->action = ACTION_AGAIN;
>  		return 0;
>  	}
> -	if (!pte_present(*pte))
> +	if (!pte_present(ptep_get(pte)))
>  		goto out;
>  	damon_ptep_mkold(pte, walk->vma, addr);
>  out:
> @@ -433,6 +433,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>  		unsigned long next, struct mm_walk *walk)
>  {
>  	pte_t *pte;
> +	pte_t ptent;
>  	spinlock_t *ptl;
>  	struct folio *folio;
>  	struct damon_young_walk_private *priv = walk->private;
> @@ -471,12 +472,13 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>  		walk->action = ACTION_AGAIN;
>  		return 0;
>  	}
> -	if (!pte_present(*pte))
> +	ptent = ptep_get(pte);
> +	if (!pte_present(ptent))
>  		goto out;
> -	folio = damon_get_folio(pte_pfn(*pte));
> +	folio = damon_get_folio(pte_pfn(ptent));
>  	if (!folio)
>  		goto out;
> -	if (pte_young(*pte) || !folio_test_idle(folio) ||
> +	if (pte_young(ptent) || !folio_test_idle(folio) ||
>  			mmu_notifier_test_young(walk->mm, addr))
>  		priv->young = true;
>  	*priv->folio_sz = folio_size(folio);

For above DAMON part,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
