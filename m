Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86FC632BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiKUSLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKUSLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:11:36 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869DAA3160
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:11:35 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 205so14518140ybe.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z2svw9m4hShuPYQWl2tT3FssDOjrSODKLzg/rFvOD00=;
        b=SIlkGVLLgwYG5rPEVqALwDpK5SHqK/y9LnUUK8sVNkLF7W6MirOINonE5mqsMMZQif
         g5SGQCRUK60Ighv3wVx2Kqdd2+0S3NyQvGxY6bqfeYPUW2BJH5WKhTLWYuZTpBiJ4jr0
         lNdLVN7MSFkhOk6So8zvSzcbk8wFneJ/KR8D4VMWR3VWUge/E3YBKtWMWE5MmflHpyV3
         aoCXeUdbOBxPu1+yON+q31shNMgTpakr2WN47D7nzc6lERREC08aW/g5R99banHTwu+Z
         Bs+2lv7CUsoIDxMKc4wnmDO0SWEG97ugzjjau8ws4Nyx+D2FsURDYQFgY+XY85ha2HEk
         kcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2svw9m4hShuPYQWl2tT3FssDOjrSODKLzg/rFvOD00=;
        b=CHgnRFIewyNbNEGi0rlcxKf/UYZvtkkn99FP1kIArDgf25AjOlWWw+Fjxj19+zYydQ
         2e547fyQHnDy5uRLudojPi1QSCdShGV1CfoxwtUmNKI44NAoyrqoAqFZaibehcOVqNc9
         e7RnEbOzKmmEMnXCaeiHiSe51Un/qIpqWKuUnM6icDATQzHsxkcXe5heKlZXeRxdrMzL
         9Lv++YB71Z+hHA0gxmnQ3AZNPEW3JMcvB3tDJnc3Qa+8+sgXKVCwUqUct0eJGdMgrTnJ
         zwLzjxOXhpcQdfDSY4xMp7kBgGaGHx/eGY5hFW4So/l8y/EqcRHaLaLOpoU9JRmvCdjX
         4ezw==
X-Gm-Message-State: ANoB5pmLJJxqdtc58zzRF+t0DsM+bNzswcU/rvWs5F+03wkvjHxYknls
        L0deSiDhhMgWvwmHwE9IqadvYWsr1ApUX60ORN6nTg==
X-Google-Smtp-Source: AA0mqf6jJTSFEBnWdyyc+zrbVA6aP5N4mXhWgR7xJU/W3GWjMUOKJWyofOBBOhyrTJaCSD7Cj4JLtGpi2ckHUaMkMME=
X-Received: by 2002:a05:6902:118e:b0:6e7:f54:b3d6 with SMTP id
 m14-20020a056902118e00b006e70f54b3d6mr2633115ybu.577.1669054294659; Mon, 21
 Nov 2022 10:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-6-jthoughton@google.com> <Y3UY+XXXwnjDLMPl@x1n>
In-Reply-To: <Y3UY+XXXwnjDLMPl@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Mon, 21 Nov 2022 10:11:23 -0800
Message-ID: <CADrL8HXzV2fF3OHf3pk6EJn8Z0=b8NHpRCD9GBcw9y1UTc5goA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/47] hugetlb: make hugetlb_vma_lock_alloc return
 its failure reason
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
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

On Wed, Nov 16, 2022 at 9:08 AM Peter Xu <peterx@redhat.com> wrote:
>
> No objection on the patch itself, but I am just wondering what guarantees
> thread-safety for this function to not leak vm_private_data when two
> threads try to allocate at the same time.
>
> I think it should be the write mmap lock.  I saw that in your latest code
> base there's:
>
>         /*
>          * We must hold the mmap lock for writing so that callers can rely on
>          * hugetlb_hgm_enabled returning a consistent result while holding
>          * the mmap lock for reading.
>          */
>         mmap_assert_write_locked(vma->vm_mm);
>
>         /* HugeTLB HGM requires the VMA lock to synchronize collapsing. */
>         ret = hugetlb_vma_data_alloc(vma);
>         if (ret)
>                 return ret;
>
> So that's covered there.  The rest places are hugetlb_vm_op_open() and
> hugetlb_reserve_pages() and they all seem fine too: hugetlb_vm_op_open() is
> during mmap(), the latter has vma==NULL so allocation will be skipped.
>
> I'm wondering whether it would make sense to move this assert to be inside
> of hugetlb_vma_data_alloc() after the !vma check, or just add the same
> assert too but for different reason.

I think leaving the assert here and adding a new assert inside
hugetlb_vma_data_alloc() makes sense. Thanks Peter.

- James

>
> >
> >       vma_lock = kmalloc(sizeof(*vma_lock), GFP_KERNEL);
> >       if (!vma_lock) {
> > @@ -7026,13 +7026,14 @@ static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
> >                * allocation failure.
> >                */
> >               pr_warn_once("HugeTLB: unable to allocate vma specific lock\n");
> > -             return;
> > +             return -ENOMEM;
> >       }
> >
> >       kref_init(&vma_lock->refs);
> >       init_rwsem(&vma_lock->rw_sema);
> >       vma_lock->vma = vma;
> >       vma->vm_private_data = vma_lock;
> > +     return 0;
> >  }
> >
> >  /*
> > @@ -7160,8 +7161,9 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
> >  {
> >  }
> >
> > -static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
> > +static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
> >  {
> > +     return 0;
> >  }
> >
> >  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
> > --
> > 2.38.0.135.g90850a2211-goog
> >
> >
>
> --
> Peter Xu
>
