Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE65864652A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiLGXdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLGXdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:33:18 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836AB8AADB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:33:17 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id c184so18787704vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 15:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=caY2y1N7oh+MBX7izGyMu3kfxeaNRPF/jLWflWGryAM=;
        b=kqUYXBzX+skKXY7nzHLrrxPYWEiatGlDBHGqfHsfDp7FKPbLxZVFWOIPvt7cgKI2/I
         oCeZnQp3fXb8ghN/WUDkylq1yXXC5mMHeSdw1EFA2W+pkzEwkF8LkZREvswlEOdFs5GH
         p5EPgP5hZ7pdSME82EkoVYvu8t7Hrysp9+cmhbh0SkB+nAwjOZc0RTCfSIDP0g7ArJly
         7ku+k4QXSGnuYSKHVnfDvJ1t4Za44gjLTJtZswkbOrPwJ8JiKvBwCXBeROcV42fMAr/I
         qF3ZRFH8mWq1xkboOb45cUyPQfpQdamtUmAiaHcIC0w8YPN87PoUlVVgZeHYK9xtJ+QN
         Zh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caY2y1N7oh+MBX7izGyMu3kfxeaNRPF/jLWflWGryAM=;
        b=70ZUNkJNXyr1aPu1lvRJlP+pw0ZAJRnkz6oPLphktfcVBsXcfcyL+sz4kqZR/xtm/q
         F4G+fJB8Y3MVxX08d008xOdqGle5kJ6CSxOrwkmAWmAexF8sePGvncSWmGoRLDTJ0cJn
         7NTbEaPMtMEuZiD/P29J1Lns3NlSyEArQG/2VPeLwNFlQ9RbC9+019eXmWeTAUUQ1ob5
         QnjSysj+8GuW9vizgu5kux8HSb4jrcPxFuyIjcO2stG5iVkBrtdAeY/yZQtrMmpMmirW
         ZvtTCOPZQmWXftymSdFV3gw7C4/nUJjCf1ImNrdXCzT8A/sVHk1HCaZEwW7ogG7ShzVN
         MNWg==
X-Gm-Message-State: ANoB5pmqGLXsG/lQ9jrDOW5GoJVh2sU2stTLHWL4X4DJgPcWoJaY0LqE
        x5LDwr6zY/wwI5W919XqSGDQGi443t9NQTvixvpR0g==
X-Google-Smtp-Source: AA0mqf51KTJYvFXfsMEAWxTurpzRQ07SVU7sXAGwErCZLvJuMb5Wta+VnWolg7vn3zq1ceyvgNWCvTUiFnlja87W+nA=
X-Received: by 2002:a67:ea04:0:b0:3a7:d7bc:c2e9 with SMTP id
 g4-20020a67ea04000000b003a7d7bcc2e9mr42495328vso.61.1670455996352; Wed, 07
 Dec 2022 15:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com> <20221021163703.3218176-6-jthoughton@google.com>
In-Reply-To: <20221021163703.3218176-6-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 7 Dec 2022 15:33:05 -0800
Message-ID: <CAHS8izPg2W394+kNMGN1oWu1KQpcQGEw5xHR95wE=-zPeQmySA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/47] hugetlb: make hugetlb_vma_lock_alloc return
 its failure reason
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Fri, Oct 21, 2022 at 9:37 AM James Houghton <jthoughton@google.com> wrote:
>
> Currently hugetlb_vma_lock_alloc doesn't return anything, as there is no
> need: if it fails, PMD sharing won't be enabled. However, HGM requires
> that the VMA lock exists, so we need to verify that
> hugetlb_vma_lock_alloc actually succeeded. If hugetlb_vma_lock_alloc
> fails, then we can pass that up to the caller that is attempting to
> enable HGM.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 52cec5b0789e..dc82256b89dd 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -92,7 +92,7 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
>  /* Forward declaration */
>  static int hugetlb_acct_memory(struct hstate *h, long delta);
>  static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
> -static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
> +static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
>  static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
>
>  static inline bool subpool_is_free(struct hugepage_subpool *spool)
> @@ -7001,17 +7001,17 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
>         }
>  }
>
> -static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
> +static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
>  {
>         struct hugetlb_vma_lock *vma_lock;
>
>         /* Only establish in (flags) sharable vmas */
>         if (!vma || !(vma->vm_flags & VM_MAYSHARE))
> -               return;
> +               return -EINVAL;
>
> -       /* Should never get here with non-NULL vm_private_data */
> +       /* We've already allocated the lock. */
>         if (vma->vm_private_data)
> -               return;
> +               return 0;

I would have expected -EEXIST here.

Also even if the patch looks generally fine it's hard to provide
Acked-by now. I need to look at the call site which is in another
patch in the series. If there is an opportunity to squash changes to
helpers and their call sites please do.

>
>         vma_lock = kmalloc(sizeof(*vma_lock), GFP_KERNEL);
>         if (!vma_lock) {
> @@ -7026,13 +7026,14 @@ static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
>                  * allocation failure.
>                  */
>                 pr_warn_once("HugeTLB: unable to allocate vma specific lock\n");
> -               return;
> +               return -ENOMEM;
>         }
>
>         kref_init(&vma_lock->refs);
>         init_rwsem(&vma_lock->rw_sema);
>         vma_lock->vma = vma;
>         vma->vm_private_data = vma_lock;
> +       return 0;
>  }
>
>  /*
> @@ -7160,8 +7161,9 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
>  {
>  }
>
> -static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
> +static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
>  {
> +       return 0;
>  }
>
>  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
> --
> 2.38.0.135.g90850a2211-goog
>
