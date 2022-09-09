Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAFF5B3CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiIIQaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiIIQ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:29:57 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A7E19C05
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:29:54 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 130so3444239ybz.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=/FXE6KT3IEbyxLGcwK+3ue2mjXL44FHoYVt0dMcsy2k=;
        b=WFC+mmfLyYIjlJGVeXw314g1tcL5tJ4xqzIO2vLl/9rsbaCoGnBIPy0p853g4f7ctg
         8sPwQJXyO0UDB/KTe9E1ptVVFk01M9nrUJanKkaeE7/x8YMgQJdHf/BFgfI3HNW8rgRv
         6vobpUPxSYdYDFfdxIVAMxCj9HiA28eHAR4hUGCqxOsaz4OkiEsdJPiCQwV6GMlORkUI
         BXtJonrmNJppW9fC62mn2CBMHbx/j40w37N9WdzohE0jh06zgBKzULolHeam1yoUoSrH
         Hu4CD+yQ9nXFhR70qoHQP8/d8iHwqo7pk9Xvduf20IcOIKAE33Hdw4PWAhnGhJ63ogWo
         CIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/FXE6KT3IEbyxLGcwK+3ue2mjXL44FHoYVt0dMcsy2k=;
        b=F8RkeBiNTE3nzATnS9Kl0RE/Tq7/BWbmJIQR3Hd+CC01hXazCetG94Y6PRqQPLcpwl
         90mh/Ae7ZxJ1a9PN6N0CgnZdA/plE2KRjvlAEMZUEEo97WC8xHWCjsTtm3m7HzJqYnHW
         4UAxzrOXN4iy3txIOrsQhm9RQ3t9aEaVjNQfSFp5KGY+fVTjf0apD0tozgB92R2yGYSn
         EYXIGFS7HX+RWYbYovVDTSRY9dey0LTPXYDpI/bRn1G8IB3DpiiEKBc6Kj2ugNQ0Nlbi
         2u+eO+tySIyRog9gtSY5usEcbbOzz+t0LKTrymTtZOPdQQ6nzN3IDJWDr4Jp/CeRZurL
         ccGg==
X-Gm-Message-State: ACgBeo3kYjWH5gd9LH4qaH92pRPwIAfRJ7BjQVRAmicSggiwfSTUQROj
        V5Ui+okW0+BCzr7uZgsErn2lk8CZat9v7uiWiyAUPQ==
X-Google-Smtp-Source: AA6agR6gf0Uo8qO+GM5qYvgJUVDtfxBsoCtsc3hcZzYnaKBzzFaVOPRlFWPi3fYi14o77F1R3tazfKeOdbmbw81hzpM=
X-Received: by 2002:a25:abea:0:b0:6a8:1bd5:deef with SMTP id
 v97-20020a25abea000000b006a81bd5deefmr12701640ybi.431.1662740993786; Fri, 09
 Sep 2022 09:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-8-surenb@google.com>
 <a072fd10-ee7e-469f-c203-978cd7da566c@linux.ibm.com> <CAJuCfpFDFzCB7zuOGyd-gqovyhwvcQaUMOUS0E8+1QxLqD-Gdg@mail.gmail.com>
 <fa73db62-560f-87c4-2b0f-bbba57eed8a7@linux.ibm.com>
In-Reply-To: <fa73db62-560f-87c4-2b0f-bbba57eed8a7@linux.ibm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Sep 2022 09:29:42 -0700
Message-ID: <CAJuCfpFMRp_VuhL4sp5S3OLnNSKSancSQ5SdC3nEPq_5mLFksg@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 07/28] kernel/fork: mark VMAs as locked before
 copying pages during fork
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

On Fri, Sep 9, 2022 at 6:27 AM Laurent Dufour <ldufour@linux.ibm.com> wrote=
:
>
> Le 09/09/2022 =C3=A0 01:57, Suren Baghdasaryan a =C3=A9crit :
> > On Tue, Sep 6, 2022 at 7:38 AM Laurent Dufour <ldufour@linux.ibm.com> w=
rote:
> >>
> >> Le 01/09/2022 =C3=A0 19:34, Suren Baghdasaryan a =C3=A9crit :
> >>> Protect VMAs from concurrent page fault handler while performing
> >>> copy_page_range for VMAs having VM_WIPEONFORK flag set.
> >>
> >> I'm wondering why is that necessary.
> >> The copied mm is write locked, and the destination one is not reachabl=
e.
> >> If any other readers are using the VMA, this is only for page fault ha=
ndling.
> >
> > Correct, this is done to prevent page faulting in the VMA being
> > duplicated. I assume we want to prevent the pages in that VMA from
> > changing when we are calling copy_page_range(). Am I wrong?
>
> If a page is faulted while copy_page_range() is in progress, the page may
> not be backed on the child side (PTE lock should protect the copy, isn't =
it).
> Is that a real problem? It will be backed later if accessed on the child =
side.
> Maybe the per process pages accounting could be incorrect...

This feels to me like walking on the edge. Maybe we can discuss this
with more people at LPC before trying it?

>
> >
> >> I should have miss something because I can't see any need to mark the =
lock
> >> VMA here.
> >>
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> ---
> >>>  kernel/fork.c | 4 +++-
> >>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/fork.c b/kernel/fork.c
> >>> index bfab31ecd11e..1872ad549fed 100644
> >>> --- a/kernel/fork.c
> >>> +++ b/kernel/fork.c
> >>> @@ -709,8 +709,10 @@ static __latent_entropy int dup_mmap(struct mm_s=
truct *mm,
> >>>               rb_parent =3D &tmp->vm_rb;
> >>>
> >>>               mm->map_count++;
> >>> -             if (!(tmp->vm_flags & VM_WIPEONFORK))
> >>> +             if (!(tmp->vm_flags & VM_WIPEONFORK)) {
> >>> +                     vma_mark_locked(mpnt);
> >>>                       retval =3D copy_page_range(tmp, mpnt);
> >>> +             }
> >>>
> >>>               if (tmp->vm_ops && tmp->vm_ops->open)
> >>>                       tmp->vm_ops->open(tmp);
> >>
>
