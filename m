Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205767410C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjF1MLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjF1MLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:11:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0832D7F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:11:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51d9372f027so7947a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687954291; x=1690546291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNXTPDJB5CpnMgt6rGIwJeKZjT4x0Rxov8xUzzmlTws=;
        b=3vXJun2TzAVJGDc3ZC2wHDjauMG1r9bVv7htMs68scaEsIUaW4BCkmZPnCJ2vI8LZ2
         Pm/fGcpLEBHFQHnU5T71xCCmj8h86P6r/0blMj7eT96DSHxat3EdFiKmu8mGic+NecGi
         Ce4AWlxfTB8NzGYFr4+Jvo0Z19z4ILxNzmOfuRJv30iEBpxDBpq2B1DC0NJoxgI7W5qx
         powE+SYPOQeYAFhC9Kvi2SEg1dW49YEVli8ZJsZym6Jk9dPNEjFpDizbHqoAGspKZUIm
         O0QEwSiN2aZkKV644zYMZhuRVZ4BA+Vqh11IrCT2a8zpz1DFsq5MFM1v5JRTqgLljp6G
         TSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687954291; x=1690546291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNXTPDJB5CpnMgt6rGIwJeKZjT4x0Rxov8xUzzmlTws=;
        b=P2tAQemOrNpe4k2pmwpHcS1VryyvVMQ0EFYuUaTFZZ/iLBvAuU+m8/ksMDUXgAfP3+
         qCoUXnw006VJ8bJrB1WG9nUqQ3WJ3Q+nPRI2NqHdfAlOxTRM66pQqFN1WiYvcMI6xocc
         UxBpKvhFpxQ6D2hxBoBleDpezwepsiEuSYgDIRXWEBkSNYMzm7nMdlgcisqazBOq+hbS
         icTiUKKcbG0Xv4WZpStoWHpl1xhuV2YQ3qXOpSSQPDC4+d6iyHeWlOUUHlWfnFkt9tWa
         VUE2HTars3soHOflwbovFWHCZdbMOg5BhGTwAfxwdNexo+wgevyU2WdrmDVZ7SE9fKk8
         VX1g==
X-Gm-Message-State: AC+VfDy5E8nMjhR7KLiDU01Q6A/E6v3TOxLy8FNLqnPN/IEVEe2tD1HL
        O2VdpvG6aTiR3n3kyIaop3IqgQ8IdfP2KuA2/PB9IQ==
X-Google-Smtp-Source: ACHHUZ6gVMTgjtIoabwzoE1KE+hoRrErAg0blSPeruJW2jzhVVbS1x40psPJxeg4RmOQg7av9OAXNhYR1uSpwHt4pgY=
X-Received: by 2002:a50:c014:0:b0:51a:1ffd:10e with SMTP id
 r20-20020a50c014000000b0051a1ffd010emr45571edb.3.1687954289961; Wed, 28 Jun
 2023 05:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230628095426.1886064-1-usama.anjum@collabora.com> <20230628095426.1886064-3-usama.anjum@collabora.com>
In-Reply-To: <20230628095426.1886064-3-usama.anjum@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 28 Jun 2023 14:11:18 +0200
Message-ID: <CABb0KFFDCZ9E3sTukmdk3jViOJmP33xOoVNg37ACoynD97ZpwA@mail.gmail.com>
Subject: Re: [PATCH v22 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muhammad,

I'd really like to reduce the number of conditionals in this code by a
third. I believe it is possible if we agree to rework the API a bit
(making it always a GET operation with optional WP) and relax some of
the restrictions on the input values.

Also please include *all* changes you make in a patch in the changelog
- I just noticed e.g. a `mmu_notifier` code that I haven't seen before
in the review.

A general request from me would be to move all the page classification
code to one place. That would mean replacing:

> +               bitmap =3D PM_SCAN_FLAGS(is_written, false,
> +                                      pmd_present(*pmd), is_swap_pmd(*pm=
d),
> +                                      pmd_present(*pmd) && is_zero_pfn(p=
md_pfn(*pmd)));

With:

       category_flags =3D pmd_page_category_flags(*pmd);

... and adding a pmd_page_category_flags() and pte/hugepage versions
together at the top. The idea here is to separate concerns: split
classification of pages from the code acting on the classification
results and be able to easily understand (and review for correctness)
how corresponding classes are derived from PTE and PMD values.

I'd prefer the naming of the functions and variables to follow that it
is a classification result, not a generic "bitmap" or "flags", so that
it's harder to confuse them with page flags as used elsewhere in the
kernel.

(inline review follows)

BTW, thanks for doing this!

On Wed, 28 Jun 2023 at 12:00, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
[...]
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 507cd4e59d07..be747fb89827 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
[...]
> +#define PM_SCAN_REQUIRE_UFFD   (1ULL << 63)
> +
> +#define PM_SCAN_FOUND_MAX_PAGES        (1)
> +#define PM_SCAN_END_WALK       (-256)
[...]
> +static int pagemap_scan_test_walk(unsigned long start, unsigned long end=
,
> +                                 struct mm_walk *walk)
> +{
> +       struct pagemap_scan_private *p =3D walk->private;
> +       struct vm_area_struct *vma =3D walk->vma;
> +
> +       if ((p->flags & PM_SCAN_REQUIRE_UFFD) && (!userfaultfd_wp_async(v=
ma) ||
> +           !userfaultfd_wp_use_markers(vma)))
> +               return -EPERM;

p->vma_can_wp =3D userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(v=
ma);

And then use that in classification functions and for skipping WP for
pages not prepared for that. The PM_SCAN_REQUIRE_UFFD won't be needed
then.

> +
> +       if (vma->vm_flags & VM_PFNMAP)
> +               return 1;

Why do we skip VM_PFNMAP vmas? This will skip over at least VDSO and
VVAR pages. Those two are not that big a problem, but it should be at
least documented what ranges are skipped and why.

> +
> +       return 0;
> +}
> +
> +static int pagemap_scan_output(unsigned long bitmap,
> +                              struct pagemap_scan_private *p,
> +                              unsigned long addr, unsigned int n_pages)
> +{
> +       struct page_region *cur_buf =3D &p->cur_buf;
> +
> +       if (!n_pages)
> +               return -EINVAL;

How can this happen?

> +       bitmap &=3D p->return_mask;
> +
> +       if (cur_buf->flags =3D=3D bitmap &&
> +           cur_buf->start + cur_buf->len * PAGE_SIZE =3D=3D addr) {

BTW, maybe the ranges returned to the user could also use start .. end
form, and then this would be simplified to `cur->flags =3D=3D
categories_to_report && cur->end =3D=3D addr`.

> +               cur_buf->len +=3D n_pages;
> +               p->found_pages +=3D n_pages;
> +       } else {
> +               if (cur_buf->len) {
> +                       if (p->vec_buf_index >=3D p->vec_buf_len)
> +                               return PM_SCAN_END_WALK;
> +
> +                       memcpy(&p->vec_buf[p->vec_buf_index], cur_buf,
> +                              sizeof(*p->vec_buf));
> +                       p->vec_buf_index++;
> +               }
> +
> +               cur_buf->start =3D addr;
> +               cur_buf->len =3D n_pages;
> +               cur_buf->flags =3D bitmap;
> +               p->found_pages +=3D n_pages;
> +       }
> +
> +       if (p->found_pages =3D=3D p->max_pages)
> +               return PM_SCAN_FOUND_MAX_PAGES;

Since we now return the address the walk ended at, what is the
difference for PM_SCAN_END_WALK and PM_SCAN_FOUND_MAX_PAGES, and do we
still need any of those instead of -ENOSPC or `n_pages !=3D
scan_output(...)` check?

> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> +                                 unsigned long end, struct mm_walk *walk=
)
> +{
> +       bool is_written, flush =3D false, interesting =3D true;
> +       struct pagemap_scan_private *p =3D walk->private;
> +       struct vm_area_struct *vma =3D walk->vma;
> +       unsigned long bitmap, addr =3D end;
> +       pte_t *pte, *orig_pte, ptent;
> +       spinlock_t *ptl;
> +       int ret =3D 0;
> +
> +       arch_enter_lazy_mmu_mode();
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       ptl =3D pmd_trans_huge_lock(pmd, vma);
> +       if (ptl) {
> +               unsigned long n_pages =3D (end - start)/PAGE_SIZE;
> +
> +               if (n_pages > p->max_pages - p->found_pages)
> +                       n_pages =3D p->max_pages - p->found_pages;
> +
> +               is_written =3D !is_pmd_uffd_wp(*pmd);
> +
> +               bitmap =3D PM_SCAN_FLAGS(is_written, false,
> +                                      pmd_present(*pmd), is_swap_pmd(*pm=
d),
> +                                      pmd_present(*pmd) && is_zero_pfn(p=
md_pfn(*pmd)));
> +
> +               if (IS_PM_SCAN_GET(p->flags))
> +                       interesting =3D pagemap_scan_is_interesting_page(=
bitmap, p);
> +
> +               if (interesting) {
> +                       /*
> +                        * Break huge page into small pages if the WP ope=
ration
> +                        * need to be performed is on a portion of the hu=
ge page.
> +                        */
> +                       if (is_written && IS_PM_SCAN_WP(p->flags) &&
> +                           n_pages < HPAGE_SIZE/PAGE_SIZE) {
> +                               spin_unlock(ptl);
> +
> +                               split_huge_pmd(vma, pmd, start);
> +                               goto process_smaller_pages;
> +                       }
> +
> +                       if (IS_PM_SCAN_GET(p->flags))
> +                               ret =3D pagemap_scan_output(bitmap, p, st=
art, n_pages);
> +
> +                       if (IS_PM_SCAN_WP(p->flags) && is_written && ret =
>=3D 0) {
> +                               make_uffd_wp_pmd(vma, start, pmd);
> +                               flush_tlb_range(vma, start, end);
> +                       }
> +               }
> +
> +               spin_unlock(ptl);
> +               arch_leave_lazy_mmu_mode();
> +
> +               return ret;
> +       }

Could you split the THP code and use it here like:

enter_lazy_mmu();

ret =3D scan_thp(...);
if (ret !=3D -ENOTTY) {
  leave_lazy_mmu();
  return ret;
}

To avoid having #ifdef here, it can be moved to the scan_thp() only
(either in the body or having a dummy `return -ENOTTY;` version in an
#else block).

BTW, there's no `cond_resched()` in the THP case - is that intentional?

> +
> +process_smaller_pages:
> +#endif
> +
> +       orig_pte =3D pte =3D pte_offset_map_lock(vma->vm_mm, pmd, start, =
&ptl);
> +       if (!pte) {
> +               walk->action =3D ACTION_AGAIN;
> +               return 0;
> +       }
> +
> +       for (addr =3D start; addr < end && !ret; pte++, addr +=3D PAGE_SI=
ZE) {
> +               ptent =3D ptep_get(pte);
> +               is_written =3D !is_pte_uffd_wp(ptent);
> +
> +               bitmap =3D PM_SCAN_FLAGS(is_written, pagemap_scan_is_file=
(vma, ptent, addr),
> +                                      pte_present(ptent), is_swap_pte(pt=
ent),
> +                                      pte_present(ptent) && is_zero_pfn(=
pte_pfn(ptent)));
> +
> +               if (IS_PM_SCAN_GET(p->flags)) {
> +                       interesting =3D pagemap_scan_is_interesting_page(=
bitmap, p);

If we consider GET as always done, this can be:

if (!is_interesting) continue;

And that would simplify the code greatly.

> +                       if (interesting)
> +                               ret =3D pagemap_scan_output(bitmap, p, ad=
dr, 1);
> +               }
> +
> +               if (IS_PM_SCAN_WP(p->flags) && is_written && interesting =
&&
> +                   ret >=3D 0) {
> +                       make_uffd_wp_pte(vma, addr, pte);
> +                       flush =3D true;
> +               }
> +       }
> +
> +       if (flush)
> +               flush_tlb_range(vma, start, addr);

Would optimizing the TLB flush range be beneficial here? If yes, the
loop above could do:

flush_start =3D end;
flush_end =3D end;
...
for (...) {
  if (mark_wp) {
    make_wp();
    if (flush_start > addr)
      flush_start =3D addr;
    flush_end =3D addr;
  }
}

to reduce the flushed range.

> +
> +       pte_unmap_unlock(orig_pte, ptl);
> +       arch_leave_lazy_mmu_mode();
> +
> +       cond_resched();
> +       return ret;
> +}
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
> +                                     unsigned long start, unsigned long =
end,
> +                                     struct mm_walk *walk)
> +{
> +       unsigned long n_pages =3D (end - start)/PAGE_SIZE;
> +       struct pagemap_scan_private *p =3D walk->private;
> +       struct vm_area_struct *vma =3D walk->vma;
> +       bool is_written, interesting =3D true;
> +       struct hstate *h =3D hstate_vma(vma);
> +       unsigned long bitmap;
> +       spinlock_t *ptl;
> +       int ret =3D 0;
> +       pte_t ptent;
> +
> +       if (IS_PM_SCAN_WP(p->flags) && n_pages < HPAGE_SIZE/PAGE_SIZE)
> +               return -EINVAL;

Shouldn't this be checked after the `n_pages` is reduced? BTW, maybe
check it only if the page `is_written` to avoid the conditional for
all walks where WP is not used?

> +
> +       if (n_pages > p->max_pages - p->found_pages)
> +               n_pages =3D p->max_pages - p->found_pages;
[...]

Proposing the relaxed API (and, while at it, less generic constant and
field names) below.

> +static int pagemap_scan_args_valid(struct pm_scan_arg *arg, unsigned lon=
g start,
> +                                  unsigned long end, struct page_region =
__user *vec)
> +{
> +       /* Detect illegal size, flags, len and masks */
> +       if (arg->size !=3D sizeof(struct pm_scan_arg))
> +               return -EINVAL;

> +       if (!arg->flags)
> +               return -EINVAL;
> +       if (arg->flags & ~PM_SCAN_OPS)
> +               return -EINVAL;

if (arg->flags & ~PM_SCAN_FLAGS)
  return -EINVAL;

> +       if (!(end - start))
> +               return -EINVAL;

Remove. Nothing bad will happen when trying to scan an empty range.

> +       if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask |
> +            arg->return_mask) & ~PM_SCAN_BITS_ALL)
> +               return -EINVAL;

if ((...) & ~PM_SCAN_PAGE_CATEGORIES)
  return -EINVAL;

> +       if (!arg->required_mask && !arg->anyof_mask &&
> +           !arg->excluded_mask)
> +               return -EINVAL;

Remove. Will inspect all pages then.

> +       if (!arg->return_mask)
> +               return -EINVAL;

Remove. Will not return any ranges then. (But will WP, if requested.)

> +       /* Validate memory range */
> +       if (!IS_ALIGNED(start, PAGE_SIZE))
> +               return -EINVAL;
> +       if (!access_ok((void __user *)start, end - start))
> +               return -EFAULT;

> +       if (IS_PM_SCAN_GET(arg->flags)) {

Remove. Do GET always.

> +               if (arg->vec_len =3D=3D 0)
> +                       return -EINVAL;

Remove. Will end the walk at the first matching page (and return its
address in `start`).

> +               if (!vec)
> +                       return -EINVAL;
> +               if (!access_ok((void __user *)vec,
> +                              arg->vec_len * sizeof(struct page_region))=
)
> +                       return -EFAULT;

Check only if vec_len !=3D 0. BTW, return EFAULT for `!vec`.

> +       }
> +
> +       if (IS_PM_SCAN_WP(arg->flags) && !IS_PM_SCAN_GET(arg->flags) &&
> +           arg->max_pages)
> +               return -EINVAL;

With return_mask =3D=3D 0, arg->max_pages will be ignored anyway. We can
just document that this limits the pages reported in the output
vector. (And from that follows that if not returning anything, the
value doesn't make a difference.)

[...]
> +       p.max_pages =3D (arg.max_pages) ? arg.max_pages : ULONG_MAX;
> +       p.found_pages =3D 0;
> +       p.required_mask =3D arg.required_mask;
> +       p.anyof_mask =3D arg.anyof_mask;
> +       p.excluded_mask =3D arg.excluded_mask;
> +       p.return_mask =3D arg.return_mask;
> +       p.flags =3D arg.flags;
> +       p.flags |=3D ((p.required_mask | p.anyof_mask | p.excluded_mask) =
&
> +                   PAGE_IS_WRITTEN) ? PM_SCAN_REQUIRE_UFFD : 0;
> +       p.cur_buf.start =3D p.cur_buf.len =3D p.cur_buf.flags =3D 0;
> +       p.vec_buf =3D NULL;
> +       p.vec_buf_len =3D PAGEMAP_WALK_SIZE >> PAGE_SHIFT;

This needs to be less by 1 to account for the entry in p.cur_buf.

> +       /*
> +        * Allocate smaller buffer to get output from inside the page wal=
k
> +        * functions and walk page range in PAGEMAP_WALK_SIZE size chunks=
. As
> +        * we want to return output to user in compact form where no two
> +        * consecutive regions should be continuous and have the same fla=
gs.
> +        * So store the latest element in p.cur_buf between different wal=
ks and
> +        * store the p.cur_buf at the end of the walk to the user buffer.
> +        */
> +       if (IS_PM_SCAN_GET(p.flags)) {

if (p.vec_len !=3D 0)

> +               p.vec_buf =3D kmalloc_array(p.vec_buf_len, sizeof(*p.vec_=
buf),
> +                                         GFP_KERNEL);
> +               if (!p.vec_buf)
> +                       return -ENOMEM;
> +       }
> +
> +       if (IS_PM_SCAN_WP(p.flags)) {
> +               mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA=
, 0,
> +                                       mm, start, end);
> +               mmu_notifier_invalidate_range_start(&range);
> +       }

Please add a comment why this is needed.

> +       walk_start =3D walk_end =3D start;
> +       while (walk_end < end && !ret) {
> +               if (IS_PM_SCAN_GET(p.flags)) {

if (p.vec_len)

> +                       p.vec_buf_index =3D 0;
> +
> +                       /*
> +                        * All data is copied to cur_buf first. When more=
 data
> +                        * is found, we push cur_buf to vec_buf and copy =
new
> +                        * data to cur_buf. Subtract 1 from length as the
> +                        * index of cur_buf isn't counted in length.
> +                        */
> +                       empty_slots =3D arg.vec_len - vec_index;
> +                       p.vec_buf_len =3D min(p.vec_buf_len, empty_slots =
- 1);
> +               }
> +
> +               ret =3D mmap_read_lock_killable(mm);
> +               if (ret)
> +                       goto return_status;

This could be _interruptible() now as we can return early overwriting
`start` so that userspace can detect that the walk was interrupted by
a signal (start !=3D end).

> +               walk_end =3D min((walk_start + PAGEMAP_WALK_SIZE) & PAGEM=
AP_WALK_MASK, end);
> +
> +               ret =3D walk_page_range(mm, walk_start, walk_end,
> +                                     &pagemap_scan_ops, &p);
> +               mmap_read_unlock(mm);
> +
> +               if (ret && ret !=3D PM_SCAN_FOUND_MAX_PAGES &&
> +                   ret !=3D PM_SCAN_END_WALK)
> +                       goto return_status;

So now there is no difference in the two special error values.

> +               walk_start =3D walk_end;
> +               if (IS_PM_SCAN_GET(p.flags) && p.vec_buf_index) {

`if (p.vec_buf_index)` should be enough, as if not reporting the
ranges, the index will never increase.

> +                       if (copy_to_user(&vec[vec_index], p.vec_buf,
> +                                        p.vec_buf_index * sizeof(*p.vec_=
buf))) {
> +                               /*
> +                                * Return error even though the OP succee=
ded
> +                                */
> +                               ret =3D -EFAULT;
> +                               goto return_status;
> +                       }
> +                       vec_index +=3D p.vec_buf_index;

p.vec_buf_index =3D 0;

... so that there is no need to do that at every start of the loop iteratio=
n.

> +               }
> +       }
> +
> +       if (p.cur_buf.len) {
> +               if (copy_to_user(&vec[vec_index], &p.cur_buf, sizeof(p.cu=
r_buf))) {
> +                       ret =3D -EFAULT;
> +                       goto return_status;
> +               }
> +               vec_index++;
> +       }
> +
> +       ret =3D vec_index;
> +
> +return_status:

The label name looks too narrowing, considering what is being done
here now. Maybe just 'out', as there is no other non-trivial exit path
from the function?

> +       arg.start =3D (unsigned long)walk_end;
> +       if (copy_to_user(&uarg->start, &arg.start, sizeof(arg.start)))
> +               ret =3D -EFAULT;
> +
> +       if (IS_PM_SCAN_WP(p.flags))
> +               mmu_notifier_invalidate_range_end(&range);

With removal of the OP_GET, there is only a single flag left. I don't
think it is useful then to hide it behind a macro. It should be
readable as `p.flags & PM_SCAN_DO_WP`.

[...]
> +/* Bits are set in flags of the page_region and masks in pm_scan_args */
> +#define PAGE_IS_WRITTEN                (1 << 0)
> +#define PAGE_IS_FILE           (1 << 1)
> +#define PAGE_IS_PRESENT                (1 << 2)
> +#define PAGE_IS_SWAPPED                (1 << 3)
> +#define PAGE_IS_PFNZERO                (1 << 4)

Please add PAGE_IS_UFFD_WP_ENABLED (or a shorter name) - this would be
populated from `p->vma_can_wp` in the `test_walk` implementation
above.

Best Regards
Micha=C5=82 Miros=C5=82aw
