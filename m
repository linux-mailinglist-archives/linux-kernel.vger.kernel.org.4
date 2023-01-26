Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BFB67D10C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjAZQMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjAZQMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:12:05 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711866DB1B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:11:40 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 123so2553578ybv.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=avupiuDAbLM3PyQGhRhg5PpJotruwpJ0ItNruSnPDto=;
        b=F4aRNUuVVxsDBeXKsHm0/n4bD8ec/RvsWf4QHiaPtWESGWCVcLcyLKe9Jd548b052h
         QcT6RtpE5UZKWO+YM6n5OvW4ARJ407Bh/66B49pzxrLWo0wLTwvYXksgxlAxJP0ioT2A
         Ualx0U2WcTfPugYJrqjVJj1hLBW/6lt2d5fTsCBLTpqMFd3n42vfTrLpt86ugZXy5nJt
         QY7vUCD1iSwt54l8qO7z+mpREsvijxTv+UkGBr5zHsEg/ZvnO6ENLfsmCjldantrjHKi
         izJKDDdVWgISSoDXUQEPobl6q3z+Qvi6Jzv0Ef01T3mTiN/xvpQhZNzm1GdzaOYEsUKe
         IgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avupiuDAbLM3PyQGhRhg5PpJotruwpJ0ItNruSnPDto=;
        b=PjhDIWinbX6iVHZdeSyTssBRmSOExAyuonQOSb9ap9WKF/nDKwuKKOxltHt2JRUsb8
         ol0++Q4MJDEj8Tfb9/jlMg9MNWGbjRWhX19VDRcU2uRrJ9O5XVIUdIy05x0aDuAv9obp
         CcVp6oYE1iKg3wmaQMLG9E+lSbYpWG5UF7saRGmXVYh4lORdj7uA1s1LrTDOMFGe3gTx
         00+J+XDKqjdEv5BLB1Qc7+7vF3fOPo21S2lO/MG+79DboZUVRWLIAvqw8pTmdbmIIk52
         xTu/pXELKtLOFnwZaSCgWu3SeCQLzxFxTrKnlsxn/kcz48jQ+U4w1iDqmQqU3aD+kg2Y
         sRrA==
X-Gm-Message-State: AO0yUKW1osABELTMjtDzasp9yQXXUCHI0/vUiXm3SVJ/k4u6xu9a//G3
        hQk8/JMVPsVcwzdCKwtxZeEmgI6ghGt9rCihUnaI0Q==
X-Google-Smtp-Source: AK7set9JejgaDEq/8tf/XX17cO+V0P18PwdgAGce26N1rqJGw+gXM9FumIvm5V3c8mJiZHRvPDjFNqGKBCO61IcUfSw=
X-Received: by 2002:a25:ad02:0:b0:80b:6fd3:84d3 with SMTP id
 y2-20020a25ad02000000b0080b6fd384d3mr1139572ybi.316.1674749499156; Thu, 26
 Jan 2023 08:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com> <20230125233554.153109-6-surenb@google.com>
 <20230126151923.4fu34ytwkpbbnvha@techsingularity.net>
In-Reply-To: <20230126151923.4fu34ytwkpbbnvha@techsingularity.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 26 Jan 2023 08:11:28 -0800
Message-ID: <CAJuCfpGyrxVJf1tuU=YUsjdhfPbPK4Bk4KmTO9OVRKfF-_XeEA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] mm: replace vma->vm_flags indirect modification in ksm_madvise
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Thu, Jan 26, 2023 at 7:19 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Jan 25, 2023 at 03:35:52PM -0800, Suren Baghdasaryan wrote:
> > Replace indirect modifications to vma->vm_flags with calls to modifier
> > functions to be able to track flag changes and to keep vma locking
> > correctness.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  arch/powerpc/kvm/book3s_hv_uvmem.c | 5 ++++-
> >  arch/s390/mm/gmap.c                | 5 ++++-
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
> > index 1d67baa5557a..325a7a47d348 100644
> > --- a/arch/powerpc/kvm/book3s_hv_uvmem.c
> > +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
> > @@ -393,6 +393,7 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
> >  {
> >       unsigned long gfn = memslot->base_gfn;
> >       unsigned long end, start = gfn_to_hva(kvm, gfn);
> > +     unsigned long vm_flags;
> >       int ret = 0;
> >       struct vm_area_struct *vma;
> >       int merge_flag = (merge) ? MADV_MERGEABLE : MADV_UNMERGEABLE;
> > @@ -409,12 +410,14 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
> >                       ret = H_STATE;
> >                       break;
> >               }
> > +             vm_flags = vma->vm_flags;
> >               ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
> > -                       merge_flag, &vma->vm_flags);
> > +                       merge_flag, &vm_flags);
> >               if (ret) {
> >                       ret = H_STATE;
> >                       break;
> >               }
> > +             reset_vm_flags(vma, vm_flags);
> >               start = vma->vm_end;
> >       } while (end > vma->vm_end);
>
> Add a comment on why the vm_flags are copied in case someone "optimises"
> this in the future? Something like
>
> /* Copy vm_flags to avoid any partial modifications in ksm_madvise. */

Ack.

>
> >
> > diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> > index 3a695b8a1e3c..d5eb47dcdacb 100644
> > --- a/arch/s390/mm/gmap.c
> > +++ b/arch/s390/mm/gmap.c
> > @@ -2587,14 +2587,17 @@ int gmap_mark_unmergeable(void)
> >  {
> >       struct mm_struct *mm = current->mm;
> >       struct vm_area_struct *vma;
> > +     unsigned long vm_flags;
> >       int ret;
> >       VMA_ITERATOR(vmi, mm, 0);
> >
> >       for_each_vma(vmi, vma) {
> > +             vm_flags = vma->vm_flags;
> >               ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
> > -                               MADV_UNMERGEABLE, &vma->vm_flags);
> > +                               MADV_UNMERGEABLE, &vm_flags);
> >               if (ret)
> >                       return ret;
> > +             reset_vm_flags(vma, vm_flags);
>
> Same.
>
> Not necessary as such as there are few users of ksm_madvise and I doubt
> it'll introduce new surprises.
>
> With or without the comment;
>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks!

>
> --
> Mel Gorman
> SUSE Labs
