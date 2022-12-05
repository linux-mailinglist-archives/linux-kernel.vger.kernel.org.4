Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34400642E7B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiLERQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiLERQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:16:28 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCCD1F9E7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:16:23 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id x12so5386548ilg.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 09:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U3UFUh5q87Ou1Qh+WcDXRhVAlXmjKtVcJY78a9iwE7A=;
        b=NM5lXNI5TlYkUhst7xWCL7i4IeqL4t8kt77ol3ggNf7ROUHSCGCesJ6IzCDQpPeV3e
         6RHsVQtBp0OXmKltpFYhSvTOMadYYOt885+LKZY1L0aHC/AfZhzg10bhzkufO3GqwSMg
         SeGQTeY5Vs8dlEwqTagmci08Br/83ToXuEIoXr4TPdfe191H8AxQKlupChXCupy7lHXp
         ZaXx6WFQmU9FCN9cKaFMMIvskCTRGGGGOEUXh3S/2Go75S029ZTNao2Q+xMs0FRBg4hJ
         EJFLbbCMIQeGDHwHZP43W1g6Fn1tWModPw1/F7sMVPN0Pq1Z0dlR479EBmLz0su1PzBW
         AE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3UFUh5q87Ou1Qh+WcDXRhVAlXmjKtVcJY78a9iwE7A=;
        b=osK5x0BLBoNY/VklOU6uDcmnVP0FfUWZ92GjMdjlJs5ZnMjzIZR2Bxw2zghdZETt0r
         j1mjlaSyOLNy7uZbg2wQpgT/tKMIAwbZlYUXSXRf9WrLlvbkVPP4F1s3l8MK9j1yTHQx
         00VOWq08qOAFZ/d7UUdluxKe7mD+0CNI0sxl3G+UWI+TrPhYSoc3yQjPpDNoihpkpQaV
         KY2fdjQVWiDUy4Rb54cCP3tXRlXJFwWeKpK1vNmDGt4oYJw8jtsdIq17eOhEjh5s2nEa
         szAE9wIU9cfQWIE0NsLk+iglQhWyLSp2NfNIogNSFIrAAgSTc7SWdKl6FcwVw6UUF4ni
         jwow==
X-Gm-Message-State: ANoB5pm+RxlgnAQ61DGOnfhR2Il8P3Of+tOTVQrD8eHqzT+6EJG4H9cm
        LwJCEc7gTAXXTWSufmwye1xl4cxykLmc1XQuujsmEueG688DwMCI
X-Google-Smtp-Source: AA0mqf7g5VM8+jwktvhUVEi5P7QLLT0WAiO/2rv33L4sKqt7D3FVzDILMc0f6cYAeH8P39me7OK4oDt7mJkrmls8hgg=
X-Received: by 2002:a92:6809:0:b0:2f9:4d92:5b2a with SMTP id
 d9-20020a926809000000b002f94d925b2amr28984422ilc.177.1670260583214; Mon, 05
 Dec 2022 09:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20221205165311.1799457-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221205165311.1799457-1-Liam.Howlett@oracle.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 5 Dec 2022 18:15:47 +0100
Message-ID: <CAG48ez2XrTRqvLBdfXuU=V9xbRxA4jiJgGvMb2xFy2tcjnhr_A@mail.gmail.com>
Subject: Re: [PATCH] mmap: Fix do_brk_flags() modifying obviously incorrect VMAs
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Jason Donenfeld <Jason@zx2c4.com>,
        Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 5:53 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> Add more sanity checks to the VMA that do_brk_flags() will expand.
> Ensure the VMA matches basic merge requirements within the function
> before calling can_vma_merge_after().
>
> Drop the duplicate checks from vm_brk_flags() since they will be
> enforced later.

Looks good to me, with one note:

> Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand existing VMA and add do_brk_munmap()")
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index a5eb2f175da0..41a2c42593e8 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2946,9 +2946,9 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
>          * Expand the existing vma if possible; Note that singular lists do not
>          * occur after forking, so the expand will only happen on new VMAs.
>          */
> -       if (vma &&
> -           (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
> -           ((vma->vm_flags & ~VM_SOFTDIRTY) == flags)) {
> +       if (vma && vma->vm_end == addr && !vma_policy(vma) && vma->anon_vma &&

Why the "vma->anon_vma" check here? The old code was checking that the
existing VMA is not attached to more than one anon_vma; but the new
code instead checks that the existing VMA is attached to at least one
anon_vma, and then is_mergeable_anon_vma() checks that the VMA is not
attached to more than one anon_vma, so in effect the VMA has to be
attached to exactly one anon_vma. Is that intentional?

If not, maybe delete the "vma->anon_vma &&" - can_vma_merge_after()
already does the equivalent check of the old "(!vma->anon_vma ||
list_is_singular(&vma->anon_vma_chain))".

> +           can_vma_merge_after(vma, flags, NULL, NULL,
> +                               addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
>                 mas_set_range(mas, vma->vm_start, addr + len - 1);
>                 if (mas_preallocate(mas, vma, GFP_KERNEL))
>                         return -ENOMEM;
> @@ -3035,11 +3035,6 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
>                 goto munmap_failed;
>
>         vma = mas_prev(&mas, 0);
> -       if (!vma || vma->vm_end != addr || vma_policy(vma) ||
> -           !can_vma_merge_after(vma, flags, NULL, NULL,
> -                                addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL))
> -               vma = NULL;
> -
>         ret = do_brk_flags(&mas, vma, addr, len, flags);
>         populate = ((mm->def_flags & VM_LOCKED) != 0);
>         mmap_write_unlock(mm);
> --
> 2.35.1
