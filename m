Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E545B3CBB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiIIQMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIIQMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:12:30 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866DA10B00E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:12:29 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id c9so3382225ybf.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=4hh2G7MdxNZ+MNcmp102ZgutWolekJca53oozXb1sk4=;
        b=Qz+PTfYUZ79Xk4WnkdDqNZ4LLUCR8EFVYsF/0fY0lUuEsl2IZGJVTFFrd89L26Oz5t
         tviGlyIdWFrik28BaRuFfzuXznzHhsJl5HOMC66jw2DryGYXp1mIyshHHWoUXqpWPJN+
         /6x0NDeafG1PPSym6XJ8bPSiGtE2517SAMZZ9AnTxspCwwhQcdA6k843LDIw/8yFsNcZ
         a5Rnaiqj1Zbr1RtrNT1Mk2NmNRgK+ybLbCflE2Htc/OZZ1CtP2ZKVyOagC0vKUQgde1Z
         SYvIrJRQRBevTglXhJiI4YfodtdB1WWv2cIrSQpWLFxSnK/0hooiuIgLalhL8RZnZ6T5
         kXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4hh2G7MdxNZ+MNcmp102ZgutWolekJca53oozXb1sk4=;
        b=DFb1BSTjIyNungzQZ49dMfeiHqLYmdZF4AKjC1XlpnHYGjjftqSAL2Dhh9W1JJtyer
         U3EdiCmRnvyq14ezI0gMTINLZxUbovdYJ6+7carT+nStNJGPNXskz1apNReOzNJ2prFk
         kjOkm1JUerKkuzBSrmQ0+r8pkE3FiMR11yVRI/ahhoUC6lN85mnPV41k7GIsj0FIwfdJ
         EJcPwGgQammf2KLPqKQwRs4eHVelcg2r50j395bY4aD6HKcltOtWR5rSCJe6u6lLsufi
         J8vTUh2eUViXbVEpqgYR3Ve/IjqglxnH6YACXqM3fTB/+LB8UonWkOLTzeiVPnMUR4t8
         3DHQ==
X-Gm-Message-State: ACgBeo3u7R9RpVCcG6taj4X23ICjZ0k0U4QZIN1GTWlpJMp2hi2h4pLc
        bFChfgK0nwC3/utGGpgsvPQMWiC4PrUnMttTmjVabw==
X-Google-Smtp-Source: AA6agR6D9Q1KW4KNYp0SHpJ/6Fcy2IRN04G63Erd6aJSK5K6Qex+RENoU//CqGiMsVMEqkzoAOqqrGTYWrT4sPeb+8g=
X-Received: by 2002:a25:cc8d:0:b0:6a8:40cb:d730 with SMTP id
 l135-20020a25cc8d000000b006a840cbd730mr12492178ybf.119.1662739948562; Fri, 09
 Sep 2022 09:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-18-surenb@google.com>
 <70a7d9cd-e64b-db49-e418-b4de7fcf8692@linux.ibm.com>
In-Reply-To: <70a7d9cd-e64b-db49-e418-b4de7fcf8692@linux.ibm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Sep 2022 09:12:17 -0700
Message-ID: <CAJuCfpGAt3K51JfaEZxUtJc_h5c5Nj6XYQvdF4x+SbC6teFS0g@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 17/28] mm/mmap: prevent pagefault handler from
 racing with mmu_notifier registration
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 7:20 AM Laurent Dufour <ldufour@linux.ibm.com> wrote=
:
>
> Le 01/09/2022 =C3=A0 19:35, Suren Baghdasaryan a =C3=A9crit :
> > Pagefault handlers might need to fire MMU notifications while a new
> > notifier is being registered. Modify mm_take_all_locks to mark all VMAs
> > as locked and prevent this race with fault handlers that would hold VMA
> > locks.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/mmap.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index b31cc97c2803..1edfcd384f5e 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3538,6 +3538,7 @@ static void vm_lock_mapping(struct mm_struct *mm,=
 struct address_space *mapping)
> >   *     hugetlb mapping);
> >   *   - all i_mmap_rwsem locks;
> >   *   - all anon_vma->rwseml
> > + *   - all vmas marked locked
>
> IIRC, the anon_vma may be locked during the page fault handling, and this
> happens after the VMA is read lock. I think the same applies to
> i_mmap_rwsem lock.
>
> Thus, the VMA should be marked locked first.

I see. I'll double check and move the locking order. Thanks!

>
> >   *
> >   * We can take all locks within these types randomly because the VM co=
de
> >   * doesn't nest them and we protected from parallel mm_take_all_locks(=
) by
> > @@ -3579,6 +3580,7 @@ int mm_take_all_locks(struct mm_struct *mm)
> >               if (vma->anon_vma)
> >                       list_for_each_entry(avc, &vma->anon_vma_chain, sa=
me_vma)
> >                               vm_lock_anon_vma(mm, avc->anon_vma);
> > +             vma_mark_locked(vma);
> >       }
> >
> >       return 0;
> > @@ -3636,6 +3638,7 @@ void mm_drop_all_locks(struct mm_struct *mm)
> >       mmap_assert_write_locked(mm);
> >       BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
> >
> > +     vma_mark_unlocked_all(mm);
> >       for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
> >               if (vma->anon_vma)
> >                       list_for_each_entry(avc, &vma->anon_vma_chain, sa=
me_vma)
>
