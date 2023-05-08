Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6596FB99E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjEHV17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjEHV1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:27:53 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE0086B6
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:27:47 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3ef35d44612so55693111cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 14:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1683581266; x=1686173266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/5gK8M/80HK8akrc9oY1kCgNbVpDxReudipYj/RHew=;
        b=h9wTM9A3kRp296JOqWRdtFZsmFCLrV//rkDQ5mNp3/81MH/u/k3AbXvduaze1n0KOZ
         Fmcls8qNSK65RyrERO17Ikvy7XDqm0F2xprpI2fZzZtOMdX90Iswwrf3DSlWQ5CGZC6q
         q6l1CxpqXg7Fg8FednkfmBfslns/vSxKC5MdynBw9Vcb25CLiUaGxp8d4UPYHvSQk8mG
         b3Q8x2noIidSFm/NJRACxqSkr/E6hLNNDwMWB3K41EZW/Ebk7Ls1iuCft6EXyK6skt8H
         y0YD14ym9WKA8/Idt8TkJhi+uID38vPBPX6LLirbSdTgfF7n1Kk+KxzkNAZtIYcdV2Mk
         iykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581266; x=1686173266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/5gK8M/80HK8akrc9oY1kCgNbVpDxReudipYj/RHew=;
        b=j7ciwbmeiKtMQV+FHEhWJ9IrxTGATLyX42X7EyfNdP03/GRoQY/PBGCldi5A56gJNd
         +LNQhOwFS0u1ubAmzIt15URDcLNl4rrtzgvM4QMkvfgL2T2pqnFjf4ogqlXKIinIb529
         cVgySeQ3iA9WfQhe7XQeJBOAuuXz1vVxfext9T8rhb9+rX201JxwkQMr1Hc0a2q9G3K/
         FfMTowGhysFV6h7ZAqh1naSnL+WYadfupSb9SrBAOYPYzhBicCuPeBXbkLXKXNuo4LsM
         j4OumMNJwdifC/VP51l15nCHFOhtJa7wa9lCT1BUUXxj3KgHrp8gDdTJ1ZTcconro8z/
         S3lw==
X-Gm-Message-State: AC+VfDwjIN+zMvIGu4zPQrsINLybxb1wL1fpuS7zWQhttAAlE0DrfmdP
        0zDqOgB/Lz9j4qDoBOGjPR9zsxpAk/i5Eyw8WZWlcw==
X-Google-Smtp-Source: ACHHUZ7eJmXTKgNxS7TlldFQiPMEyTLJrp5S1je99UhtwyLP0ced9iIZHSU/DouaWZf/D7YzYuHfH940tUMV2iTdnys=
X-Received: by 2002:ac8:59c1:0:b0:3ec:490b:ce6e with SMTP id
 f1-20020ac859c1000000b003ec490bce6emr18145645qtf.48.1683581266624; Mon, 08
 May 2023 14:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000258e5e05fae79fc1@google.com> <20230507135844.1231056-1-lrh2000@pku.edu.cn>
In-Reply-To: <20230507135844.1231056-1-lrh2000@pku.edu.cn>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 8 May 2023 17:27:10 -0400
Message-ID: <CA+CK2bBe2YKYM3rUTCnZ0RF=NFUR9VqO-QYn3ygPsFJWLY1MUA@mail.gmail.com>
Subject: Re: usbdev_mmap causes type confusion in page_table_check
To:     Ruihan Li <lrh2000@pku.edu.cn>
Cc:     syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 7, 2023 at 9:58=E2=80=AFAM Ruihan Li <lrh2000@pku.edu.cn> wrote=
:
>
> Hi all,

Hi Ruihan,

Thank you for bisecting, and great analysis of the problem.

> Recently, syzbot reported [1] ("kernel BUG in page_table_check_clear"). A=
fter
> some bisection, I found out that when usbdev_mmap calls remap_pfn_range o=
n
> kmalloc'ed memory, it causes type confusion between struct folio and slab=
 in
> page_table_check. As I will explain below, it seems that both usb-side an=
d
> mm-side need some fixes. So I have cc'd linux-usb and linux-mm here, as w=
ell
> as their maintainers, to see whether there are any comments on the propos=
ed
> way to fix.
>
>  [1] https://lore.kernel.org/all/000000000000258e5e05fae79fc1@google.com/
>
> To handle mmap requests for /dev/bus/usb/XXX/YYY, usbdev_mmap first alloc=
ates
> memory by calling usb_alloc_coherent and then maps it into the user space
> using remap_pfn_range:
>
> static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
> {
>         // ...
>         mem =3D usb_alloc_coherent(ps->dev, size, GFP_USER | __GFP_NOWARN=
,
>                         &dma_handle);
>         // ...
>         if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
>                 if (remap_pfn_range(vma, vma->vm_start,
>                                     virt_to_phys(usbm->mem) >> PAGE_SHIFT=
,
>                                     size, vma->vm_page_prot) < 0) {
>                         // ...
>                 }
>         }
>         // ...
> }
>
> Note that in this case, we consider the DMA-unavailable scenario, which, =
to be
> honest, is rare in practice. However, syzbot emulates USB devices using a
> module named dummy_hcd, and since these devices are emulated, DMA is not
> available at all.
>
> Meanwhile, usb_alloc_coherent calls hcd_buffer_alloc, which uses kmalloc =
for
> memory allocation:
>
> void *hcd_buffer_alloc(
>         struct usb_bus          *bus,
>         size_t                  size,
>         gfp_t                   mem_flags,
>         dma_addr_t              *dma
> )
> {
>         // ...
>         if (!hcd_uses_dma(hcd)) {
>                 *dma =3D ~(dma_addr_t) 0;
>                 return kmalloc(size, mem_flags);
>         }
>         // ...
> }
>
> However, during the update of the page table to map the kmalloc'd page in=
to
> the user space, page_table_check_set attempts to determine whether the pa=
ge is
> anonymous using PageAnon:
>
> static void page_table_check_set(struct mm_struct *mm, unsigned long addr=
,
>                                  unsigned long pfn, unsigned long pgcnt,
>                                  bool rw)
> {
>         // ...
>         anon =3D PageAnon(page);
>         for (i =3D 0; i < pgcnt; i++) {
>                 // ...
>                 if (anon) {
>                         BUG_ON(atomic_read(&ptc->file_map_count));
>                         BUG_ON(atomic_inc_return(&ptc->anon_map_count) > =
1 && rw);
>                 } else {
>                         BUG_ON(atomic_read(&ptc->anon_map_count));
>                         BUG_ON(atomic_inc_return(&ptc->file_map_count) < =
0);
>                 }
>                 // ...
>         }
>         // ...
> }
>
> This call to PageAnon is invalid for slab pages because slab reuses the b=
its
> in struct page/folio to store its internal states, and the anonymity bit =
only
> exists in struct page/folio. As a result, the counters are incorrectly up=
dated
> and checked in page_table_check_set and page_table_check_clear, leading t=
o the
> bug being raised.

We should change anon boolean to be:

anon =3D !PageSlab(page) && PageAnon(page);

This way, we will have a correct way to determine anon pages, and the
rest will fall into file_map_count. The file (non-anon) PTEs are OK to
be double mapped, so there won't be any problems from page_table_check
point of view even if it is a slab page.

> Intuitively, I don't think it's reasonable to call remap_pfn_range to map
> kmalloc'd pages into the user space. In the past, kmalloc'd pages might h=
ave
> had alignment issues when certain memory debugging options were enabled.
> Although this has been fixed in commit 59bb47985c1d ("mm, sl[aou]b: guara=
ntee
> natural alignment for kmalloc(power-of-two)"), it has been shown that
> performing such mapping is still buggy, as demonstrated by the type confu=
sion
> in page_table_check. Therefore, I propose adding a new function,
> hcd_buffer_alloc_pages, to guarantee the page requirements (i.e., no
> intermediate allocators, such as slab/slub). Below is a diff as a quick
> example:
>
> diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
> index fbb087b72..514bdc949 100644
> --- a/drivers/usb/core/buffer.c
> +++ b/drivers/usb/core/buffer.c
> @@ -112,7 +112,7 @@ void hcd_buffer_destroy(struct usb_hcd *hcd)
>   * better sharing and to leverage mm/slab.c intelligence.
>   */
>
> -void *hcd_buffer_alloc(
> +void *hcd_buffer_alloc_pages(
>         struct usb_bus          *bus,
>         size_t                  size,
>         gfp_t                   mem_flags,
> @@ -126,12 +126,13 @@ void *hcd_buffer_alloc(
>                 return NULL;
>
>         if (hcd->localmem_pool)
> -               return gen_pool_dma_alloc(hcd->localmem_pool, size, dma);
> +               return gen_pool_dma_alloc_align(hcd->localmem_pool, size,
> +                                               dma, PAGE_SIZE);
>
>         /* some USB hosts just use PIO */
>         if (!hcd_uses_dma(hcd)) {
>                 *dma =3D ~(dma_addr_t) 0;
> -               return kmalloc(size, mem_flags);
> +               return (void *)__get_free_pages(mem_flags, get_order(size=
));
>         }
>
>         for (i =3D 0; i < HCD_BUFFER_POOLS; i++) {
>
> (There appears to be another issue. In cases where hcd->localmem_pool is
> non-null, I suspect that remap_pfn_range should not be used. This is a DM=
A
> scenario, and the DMA handle is properly returned, so dma_mmap_coherent s=
hould
> be used instead. Am I correct?)
>
> This does not actually fix the type confusion bug in page_table_check_*. =
It
> should be noted that by leveraging /dev/mem, users can map arbitrary phys=
ical
> memory regions into the user space, which is also achieved through
> remap_pfn_range. I'm not 100% certain whether a fix is necessary, as one =
may
> argue that using page table checks (a kernel hardening technique, which m=
eans
> security is important) and /dev/mem (clearly insecure and potentially

Yes, /dev/mem device is a security problem, and would not work with a
hardern kernel.

> exploitable) together is completely unreasonable.
>
> If a fix is deemed necessary, I think taking the flag VM_PFNMAP into
> consideration is a reasonable solution, that said, in page_table_check_*,
>  * when the VM_PFNMAP flag is set, all operations and checks on
>    file_map_count and anon_map_count counters should be bypassed;
>  * when the VM_PFNMAP flag is not set, an additionally check to ensure
>    folio_test_slab evaluates to false should be performed.
>
> The implementation should be straightforward. However, I noticed that the
> page_table_check_* hooks are called in arch/* instead of mm/*, which not =
only
> limits its supported architectures (currently x86_64, arm64, and risc-v) =
but
> also makes it difficult to get the struct vm_area_struct as a parameter, =
since
> the struct vm_area_struct is not passed from mm/* to arch/* when mapping =
or
> unmapping pages. I have looked at d283d422c6c4 ("x86: mm: add x86_64 supp=
ort
> for page table check"), but I don't see a valid reason. Perhaps Pasha can
> provide some explanation about this implementation choice?

We specifically decided not to use VMA information in order to avoid
relying on MM state (except for limited "struct page" info). The
page_table_check is a separate from Linux-MM state machine that
verifies that the user accessible pages are not falsely shared.

Pasha
