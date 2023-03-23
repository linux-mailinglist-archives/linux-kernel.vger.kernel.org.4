Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D0A6C6E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCWRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjCWRIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:08:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7C0EF8C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:08:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j24so12492821wrd.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679591302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p47XQPQvFte3iGIB9opW7jQR1slmuLWQ99gE5p50XPQ=;
        b=Zn2FUBj4Op8194h4XZzllO7iXDJqFyZlu4C2wn3r/uOybRY9viI+FL9W3WKo+1JN19
         N/ZO0DVjII/gbEfKfQ0LwCHh+qZuPCJarB+v+xwms37Q/rGq9AGgrOvUnn5hxapj/jx4
         YZIyEnrv2GlemuPdB7Z2LU+tiSqq99uGAAPrZ3uFTfmhdXQ1Azd2jsqOUwL+nwR8WXFy
         vMWauFTJ4w8UmGHyrWxM6QQIihJuB3Z2r3DsztDz3LOl/Kz7SK3w1l0D3BWXsO3RIey2
         DGfKm1yJIjIkg1rWxLblNYCldKToXEdOw87ozbAN/yT/KxY9Ek33b+hX3G094v3PREHm
         qR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679591302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p47XQPQvFte3iGIB9opW7jQR1slmuLWQ99gE5p50XPQ=;
        b=609UOjpBK/3iN7E3ODn9iuO/I1KlAGXfFD3Q2bmD20yLOeUHAXLJW0VOJ+3AAnGW1b
         Icw70OGjfIATrZIzQLiMCT0tSYy3Y5JmBjRZRN0ZQBjdjhn9KBbyN0bivvgHOyOhd1yk
         7AkHiT0vy51exiTLZ/niZmWsc7ULyzY1x/dkUHQHJQlPVXkzrgV+jIsbN7Q4y0BvpS95
         g/7eAjLliLa9USwMNjazFLmkyc4W429FARnRVdQXxGxAqTQLuwKD5LC7BxxRu5wQkBkK
         uXJl1XEcYyaOVtLB0opNhg/c6s3KSUHXL3DTEzme9mBcfDN3tpFoV3FONtRdRxX5zeYv
         0WUA==
X-Gm-Message-State: AAQBX9eplXspqH0YPagsEaul2wXJUWY9mx4MlFGIFGEaUGWcvml4Jmsd
        FTkFPYf5RsspXD85EH2zoUk=
X-Google-Smtp-Source: AKy350ZhyAO9ZpOeJod3keJfbIobAwhXpkNqYCgkiMAj8yuljl/0aw787pdSWkewT1aTj0GwaWkxnQ==
X-Received: by 2002:adf:d091:0:b0:2d7:452f:79ec with SMTP id y17-20020adfd091000000b002d7452f79ecmr3254675wrh.7.1679591301616;
        Thu, 23 Mar 2023 10:08:21 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id n12-20020adfe34c000000b002da75c5e143sm4182657wrj.29.2023.03.23.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:08:20 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:08:19 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: Re: [PATCH v2 3/4] mm/mmap/vma_merge: extend invariants, avoid
 invalid res, vma
Message-ID: <5f88b7f9-d9f9-44ef-9a74-b338d0ba9895@lucifer.local>
References: <cover.1679431180.git.lstoakes@gmail.com>
 <17b6fc3edc46c4b33aa93b9ef17a63a3a76f4b5f.1679431180.git.lstoakes@gmail.com>
 <CGME20230323170046eucas1p2483ab0fcc3d6bc56d4b6d09143bbadda@eucas1p2.samsung.com>
 <a5d567b6-a067-c3e2-e500-e459cf47851f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5d567b6-a067-c3e2-e500-e459cf47851f@samsung.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 06:00:45PM +0100, Marek Szyprowski wrote:
> On 21.03.2023 21:45, Lorenzo Stoakes wrote:
> > Previously, vma was an uninitialised variable which was only definitely
> > assigned as a result of the logic covering all possible input cases - for
> > it to have remained uninitialised, prev would have to be NULL, and next
> > would _have_ to be mergeable.
> >
> > We now reuse vma to assign curr and next, so to be absolutely explicit,
> > ensure this variable is _always_ assigned, and while we're at it remove the
> > redundant assignment of both res and vma (if prev is NULL then we simply
> > assign to NULL).
> >
> > In addition, we absolutely do rely on addr == curr->vm_start should curr
> > exist, so assert as much.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
> This patch has been merged into today's linux next-20230323 as commit
> 6426bbcc76be ("mm/mmap/vma_merge: extend invariants, avoid invalid res,
> vma").
>
> Unfortunately it breaks booting of some ARM 32bit machines, like Samsung
> Exynos5422-based Odroid XU3 board. This shortened log shows the issue:

I'm very sorry about this. This was due to a bug with uninitiased
state. This was fixed in v3 of this series, which is now at v5 [1]. This
has already been taken to mm-unstable in Andrew's repo, hopefully it will
be taken to -next soon!

I have made sure to reply quickly whenever this is raised to ensure people
are aware, and I will also buy anybody affected a pint if I meet them in
person :)

[1]:https://lore.kernel.org/all/over.1679516210.git.lstoakes@gmail.com/

>
> Run /sbin/init as init process
>    with arguments:
>      /sbin/init
>    with environment:
>      HOME=/
>      TERM=linux
> 8<--- cut here ---
> Unhandled fault: page domain fault (0x01b) at 0xb6f03010
> [b6f03010] *pgd=b5e84835
> Internal error: : 1b [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 2 PID: 1 Comm: init Not tainted 6.3.0-rc1-00296-g6426bbcc76be #6445
> Hardware name: Samsung Exynos (Flattened Device Tree)
> PC is at vma_merge+0xa0/0x728
> LR is at vma_merge+0x294/0x728
> pc : [<c02b08a8>]    lr : [<c02b0a9c>]    psr: a0000013
> ...
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 4f11406a  DAC: 00000051
> ...
> Process init (pid: 1, stack limit = 0x5219a5c7)
> Stack: (0xf0835e30 to 0xf0836000)
> ...
>   vma_merge from mprotect_fixup+0xc8/0x290
>   mprotect_fixup from do_mprotect_pkey.constprop.0+0x210/0x338
>   do_mprotect_pkey.constprop.0 from ret_fast_syscall+0x0/0x1c
> Exception stack(0xf0835fa8 to 0xf0835ff0)
> ...
> ---[ end trace 0000000000000000 ]---
> note: init[1] exited with irqs disabled
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>
> Reverting it on top of linux-next, together with 183b2bced4c9
> ("mm/mmap/vma_merge: init cleanup, be explicit about the non-mergeable
> case"), which depends on this patch, fixes the boot issue.
>
>
> > ---
> >   mm/mmap.c | 19 ++++++++++++++-----
> >   1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 6361baf75601..7aec49c3bc74 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -911,7 +911,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >   {
> >   	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> >   	pgoff_t vma_pgoff;
> > -	struct vm_area_struct *curr, *next, *res = NULL;
> > +	struct vm_area_struct *curr, *next, *res;
> >   	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> >   	int err = -1;
> >   	bool merge_prev = false;
> > @@ -940,14 +940,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >   		/* Is there a VMA next to a hole (case 1 - 3) or prev (4)? */
> >   		next = vma_lookup(mm, end);
> >
> > -	/* verify some invariant that must be enforced by the caller */
> > +	/*
> > +	 * By default, we return prev. Cases 3, 4, 8 will instead return next
> > +	 * and cases 3, 8 will also update vma to point at next.
> > +	 */
> > +	res = vma = prev;
> > +
> > +	/* Verify some invariant that must be enforced by the caller. */
> >   	VM_WARN_ON(prev && addr <= prev->vm_start);
> > -	VM_WARN_ON(curr && end > curr->vm_end);
> > +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> >   	VM_WARN_ON(addr >= end);
> >
> >   	if (prev) {
> > -		res = prev;
> > -		vma = prev;
> >   		vma_start = prev->vm_start;
> >   		vma_pgoff = prev->vm_pgoff;
> >   		/* Can we merge the predecessor? */
> > @@ -958,6 +962,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >   			vma_prev(vmi);
> >   		}
> >   	}
> > +
> >   	/* Can we merge the successor? */
> >   	if (next && mpol_equal(policy, vma_policy(next)) &&
> >   	    can_vma_merge_before(next, vm_flags,
> > @@ -998,6 +1003,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >   			adj_start = -(prev->vm_end - addr);
> >   			err = dup_anon_vma(next, prev);
> >   		} else {
> > +			/*
> > +			 * Note that cases 3 and 8 are the ONLY ones where prev
> > +			 * is permitted to be (but is not necessarily) NULL.
> > +			 */
> >   			vma = next;			/* case 3 */
> >   			vma_start = addr;
> >   			vma_end = next->vm_end;
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
