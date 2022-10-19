Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67008604093
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiJSKE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiJSKEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:04:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64EF13E1A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:42:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bk15so28124357wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwlo8R/0/8T2BaS4ED3Fbn++HGrzEIZnvt6eFx8y47Q=;
        b=P+zj9cFms3cMCo99+NjZF1XPSaSJ2uprXNWfxJt3tCEtDDyuY39tfX8fW+J3QfAxBj
         vNKvBRA1ulDEpO8gEKXW+Etmxqi4gvba42CfxQA69DoLZLYQHKwMlO4nK/tbSQVQLTWK
         6RRVHTup/B35MvSKkXotjzP28+6ganhteQmPodrgrwYI+nnU2Vh70bb+GUsTEXVEbOF4
         G+pL5Ll4lnmB7RV7uDhMr/4X9NUUwGR8dJ/agcOfrzPZm7KKqUJWbcP2rTjzds1oAyLQ
         FqQ55zNl3HQgPb4XglMiOLGMQ+KKff8Kyca4a9z1AxKvemsm3dLba/ya5jVgBMQsN0YN
         sHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwlo8R/0/8T2BaS4ED3Fbn++HGrzEIZnvt6eFx8y47Q=;
        b=fmKcsGIiDHNjSrQeRSCjD1SqLA8DVNZNDGNXbvqeM7XHCrvp7dKhWIQpYOjOX0K2Ts
         7+5zIoMm6RO71tDHbNDWG3sQouvwcxLLpdo3xq3P05Ufh48FTjPchPpbPs4uLw1h29ys
         94bLdyoykEKdptmSu/3ZY2ODF95/jN6PS28ZBYGHSluTB2AH9NCnuWxUNHStagjA46ib
         ohJuOcgqVMJEZm4P6yRZOFYhWVTpnvFKf2INoZ2fqE8XvKg3r+GRWVUQlgNLk52eeImu
         hlHBsQHY83I94+N+1e7Ml0SJQiGkvHpxSbAlCyQhzADSu+hl+84b37iHWGv3Jxvwv6Aa
         XuGg==
X-Gm-Message-State: ACrzQf2XPGJgNnk4uu0OQF2OQMcdCoDhYY5vYA7BMP0zaEnISyp61NAu
        Fzu2oO8eWucsuU7HO5rYWfwpNIFQ7JzHbIbRjtmNhmY0Y/8=
X-Google-Smtp-Source: AMsMyM6albaiTnFLdkNT2mRZ20TKyJq3hvbzHFXYG7354SevtR1e4OwHGVqzRzUW3ny5Dq0WDHOSIxfGqHW/bLFnwDM=
X-Received: by 2002:a05:651c:235:b0:26f:c0c7:a5da with SMTP id
 z21-20020a05651c023500b0026fc0c7a5damr2554519ljn.500.1666172009944; Wed, 19
 Oct 2022 02:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221012081526.73067-1-huangjie.albert@bytedance.com> <5f7ef6ee-6241-9912-f434-962be53272c@google.com>
In-Reply-To: <5f7ef6ee-6241-9912-f434-962be53272c@google.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Wed, 19 Oct 2022 17:33:17 +0800
Message-ID: <CABKxMyNEWVBd8hvZfOHqxgtLi7gts+X53pVvag-zEsvqYqRnhw@mail.gmail.com>
Subject: Re: [PATCH] mm: hugetlb: support get/set_policy for hugetlb_vm_ops
To:     Hugh Dickins <hughd@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hughd@google.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8813=E6=97=
=A5=E5=91=A8=E5=9B=9B 03:45=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 12 Oct 2022, Albert Huang wrote:
>
> > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> >
> > implement these two functions so that we can set the mempolicy to
> > the inode of the hugetlb file. This ensures that the mempolicy of
> > all processes sharing this huge page file is consistent.
> >
> > In some scenarios where huge pages are shared:
> > if we need to limit the memory usage of vm within node0, so I set qemu'=
s
> > mempilciy bind to node0, but if there is a process (such as virtiofsd)
> > shared memory with the vm, in this case. If the page fault is triggered
> > by virtiofsd, the allocated memory may go to node1 which  depends on
> > virtiofsd.
> >
> > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
>
> Aha!  Congratulations for noticing, after all this time.  hugetlbfs
> contains various little pieces of code that pretend to be supporting
> shared NUMA mempolicy, but in fact there was nothing connecting it up.
>
> It will be for Mike to decide, but personally I oppose adding
> shared NUMA mempolicy support to hugetlbfs, after eighteen years.
>
> The thing is, it will change the behaviour of NUMA on hugetlbfs:
> in ways that would have been sensible way back then, yes; but surely
> those who have invested in NUMA and hugetlbfs have developed other
> ways of administering it successfully, without shared NUMA mempolicy.
>
> At the least, I would expect some tests to break (I could easily be
> wrong), and there's a chance that some app or tool would break too.

Hi : Hugh

Can you share some issues here?

Thanks.

>
> I have carried the reverse of Albert's patch for a long time, stripping
> out the pretence of shared NUMA mempolicy support from hugetlbfs: I
> wanted that, so that I could work on modifying the tmpfs implementation,
> without having to worry about other users.
>
> Mike, if you would prefer to see my patch stripping out the pretence,
> let us know: it has never been a priority to send in, but I can update
> it to 6.1-rc1 if you'd like to see it.  (Once upon a time, it removed
> all need for struct hugetlbfs_inode_info, but nowadays that's still
> required for the memfd seals.)
>
> Whether Albert's patch is complete and correct, I haven't begun to think
> about: I am not saying it isn't, but shared NUMA mempolicy adds another
> dimension of complexity, and need for support, that I think hugetlbfs
> would be better off continuing to survive without.
>
> Hugh
>
> > ---
> >  mm/hugetlb.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 0ad53ad98e74..ed7599821655 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4678,6 +4678,24 @@ static vm_fault_t hugetlb_vm_op_fault(struct vm_=
fault *vmf)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_NUMA
> > +int hugetlb_vm_op_set_policy(struct vm_area_struct *vma, struct mempol=
icy *mpol)
> > +{
> > +     struct inode *inode =3D file_inode(vma->vm_file);
> > +
> > +     return mpol_set_shared_policy(&HUGETLBFS_I(inode)->policy, vma, m=
pol);
> > +}
> > +
> > +struct mempolicy *hugetlb_vm_op_get_policy(struct vm_area_struct *vma,=
 unsigned long addr)
> > +{
> > +     struct inode *inode =3D file_inode(vma->vm_file);
> > +     pgoff_t index;
> > +
> > +     index =3D ((addr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
> > +     return mpol_shared_policy_lookup(&HUGETLBFS_I(inode)->policy, ind=
ex);
> > +}
> > +#endif
> > +
> >  /*
> >   * When a new function is introduced to vm_operations_struct and added
> >   * to hugetlb_vm_ops, please consider adding the function to shm_vm_op=
s.
> > @@ -4691,6 +4709,10 @@ const struct vm_operations_struct hugetlb_vm_ops=
 =3D {
> >       .close =3D hugetlb_vm_op_close,
> >       .may_split =3D hugetlb_vm_op_split,
> >       .pagesize =3D hugetlb_vm_op_pagesize,
> > +#ifdef CONFIG_NUMA
> > +     .set_policy =3D hugetlb_vm_op_set_policy,
> > +     .get_policy =3D hugetlb_vm_op_get_policy,
> > +#endif
> >  };
> >
> >  static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *pa=
ge,
> > --
> > 2.31.1
