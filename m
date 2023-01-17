Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968396705CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjAQV7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjAQV5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:57:47 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBBE4F873
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:36:42 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id b127so7440618iof.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gzv/PjbkvkttZs2lXK771JGFBCi9Hf6ZZVadDKoWVOE=;
        b=QpAHNbvKrocr/gd9vGeih5qNlPxQR4MEXcSF4KR6pVa+PSdw28fgbVUFIbunf7ZNMp
         Bz+X/7R7YhZTp8QcKnf0rUNp4dHWFtDOn/C2E4pP8Kpox0pG02f+bk7RVlPsuaaQhpeE
         rR6AvvWD4qsJO0fGm/eLsQBDRj0Za8beePU4FZpa45+qQAtII1R2/dAg+bbznUkadb8m
         WpMTk5odBTayNIx9c/yS0gJXB6st0uuvpfPLzoL+u+QKqVr4iigyIBml9XmSh6isdaMz
         QufOUvjdWx/iu+V+o7iSeOPWNnygir8efcpoGOyVnh+WRc4LAfLaTOOuRgiv9PC/HVzz
         ctzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzv/PjbkvkttZs2lXK771JGFBCi9Hf6ZZVadDKoWVOE=;
        b=Bzy4QK8WeGeV5FQNQhgFDJ7lNI7Vtr7kFxploF2Zue7cIOY/3VM796kHco75XW7RRA
         MCTvuJ/Zkt9dlAVrSlpp56/esmJJIPiHW3MxeH2P5QGn1GiJ+6/8xDydT3Xn0S3DEn80
         XthvVf5p1HXhiBAo/hSFL/me2zYpNwWLNfZRDw/iUI4jSzeTv+6O90g8GFA/Xll3nZ5J
         0OFSOPQyAUybjRzhcfd6ZQO8YwWEqoWrksTY9v6s6jmt6xF6VTPuloCpSzkrn63JfN8b
         JneXnRoPddLYYhHeurSKdYZ7ArqQ5EGVlRBuz2ym3SK7Py5Eq6P0cCVukJ7UbjQswUPY
         CJsA==
X-Gm-Message-State: AFqh2kpzTc9dZUwP8EEXYreo/YCpWSvrMLSpWYW4KPRB233v6DfMjzNp
        1x4pJzbzeTaknbdw1fglvUohwlgUUtIRzQwLRVjTYg==
X-Google-Smtp-Source: AMrXdXusAVEO39vkcFBYo1YaXglysvZb5hIpl6B/Ane5TCpjdEQi3a24j+bOu8/GXvC7NmQ4pthv5BDs12Jhfzy67zo=
X-Received: by 2002:a02:2a4b:0:b0:38c:886a:219a with SMTP id
 w72-20020a022a4b000000b0038c886a219amr490143jaw.133.1673987801346; Tue, 17
 Jan 2023 12:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-33-surenb@google.com>
 <CAG48ez0Z-wnBLzCNDHgTviV0Ws+s4grX-sFRZ-43dxhJg+GzfA@mail.gmail.com>
In-Reply-To: <CAG48ez0Z-wnBLzCNDHgTviV0Ws+s4grX-sFRZ-43dxhJg+GzfA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 17 Jan 2023 21:36:05 +0100
Message-ID: <CAG48ez1J2YC=_wu82p1BCgR+igd3aF_rwi5WmLJX9MjYM-BUsw@mail.gmail.com>
Subject: Re: [PATCH 32/41] mm: prevent userfaults to be handled under per-vma lock
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
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

On Tue, Jan 17, 2023 at 8:51 PM Jann Horn <jannh@google.com> wrote:
> On Mon, Jan 9, 2023 at 9:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > Due to the possibility of handle_userfault dropping mmap_lock, avoid fault
> > handling under VMA lock and retry holding mmap_lock. This can be handled
> > more gracefully in the future.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Suggested-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/memory.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 20806bc8b4eb..12508f4d845a 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5273,6 +5273,13 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> >         if (!vma->anon_vma)
> >                 goto inval;
> >
> > +       /*
> > +        * Due to the possibility of userfault handler dropping mmap_lock, avoid
> > +        * it for now and fall back to page fault handling under mmap_lock.
> > +        */
> > +       if (userfaultfd_armed(vma))
> > +               goto inval;
>
> This looks racy wrt concurrent userfaultfd_register(). I think you'll
> want to do the userfaultfd_armed(vma) check _after_ locking the VMA,

I still think this change is needed...

> and ensure that the userfaultfd code write-locks the VMA before
> changing the __VM_UFFD_FLAGS in vma->vm_flags.

Ah, but now I see you already took care of this half of the issue with
the reset_vm_flags() change in
https://lore.kernel.org/linux-mm/20230109205336.3665937-16-surenb@google.com/
.


> >         if (!vma_read_trylock(vma))
> >                 goto inval;
> >
> > --
> > 2.39.0
> >
