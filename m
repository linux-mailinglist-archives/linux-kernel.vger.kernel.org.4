Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF1067106D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjARBxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjARBxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:53:13 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC9A4614E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:53:12 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id e202so13065725ybh.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ILbFWlZPwOXtbFXdBol6/JJ1NLyMRbPqRykuoOsUcaw=;
        b=S9f07Af/lU4+G+VMUbpgZblq8lSp89NNJk70aQ471CbMT/vlt7aN2JxyyA5gStbl73
         aXeNwMBG/dw/kxWw25tkzpI4AX6mo7X4hNZG3bANHhOypcVk/IOrijHxJuXWX2Bmiw0e
         PD1ZsIm7h5czVLywMPX3OimFR0B/7nHvePIMqQ/YFndiEgSIW6D/9fkr+k0Yx8Xxb3hc
         h4h+vIBsux9kUR61oAsVqczCnkCyPzYbZvz4ZbxZZEqKg1Vhp1uWZN7TEv7/40lWi0+n
         nRnqRKFWuzj6thZ+YRtwsNGrFNp9IxjZGzOdTL6toc2EncIaosruIioEJUTHDynIwSRR
         fmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILbFWlZPwOXtbFXdBol6/JJ1NLyMRbPqRykuoOsUcaw=;
        b=g78T7wnU52xLTvbKZkkKpKFyMLIls5lNGfCNdRXkLXW4CTInGvAHO3eaYiByTtWeTf
         lV4QsntzuTuNtgil4tqALNd4qsPGXm7dGqu1oqwaYuumCWKrCwqfXF7d1jxBsC7HwwPI
         cml93nEvWCk42sL3R8e/aCBEecL9Y5KtMdFzrm/CYfsP0Sedaohn7MD2926EiBwxGdOU
         LecF41qTl//yTmXwa9JyqGChweMNLiUo8Qd0us6k5BC6+ontd9YXdQ13vArUI3BvsOU5
         ovawZPMKvoonYYf85d/80QL9JglWwPisXE6JFZFoBNOJQZY3rIIfCBtJhSDiqUbILsmZ
         IJzw==
X-Gm-Message-State: AFqh2koOi9Lj1nNk9VxrN5eeliPOHkHgT06sZ/4Vmjt3I5yfJFAxFgDT
        lkgj7jcKET5P8jtvmJgJ0sSrettAe2oCJ25kGzN+Xg==
X-Google-Smtp-Source: AMrXdXv4O1UDY3yFBG9KhKaThCAzMgSaCQb59bBOMeFB9e7SkeMuHmfyRxlJ6Uq5Jl9JKGZR5HpABk6NXpFuXqNAazY=
X-Received: by 2002:a25:4cf:0:b0:7ec:2d81:a6f9 with SMTP id
 198-20020a2504cf000000b007ec2d81a6f9mr626656ybe.431.1674006791486; Tue, 17
 Jan 2023 17:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-27-surenb@google.com>
 <Y8bB3TFLQV2HJZQ+@dhcp22.suse.cz>
In-Reply-To: <Y8bB3TFLQV2HJZQ+@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 17:53:00 -0800
Message-ID: <CAJuCfpH8-wNiPXQcS=0j-Ex7iMqoBkUhjSN8QiAvq6FdXudRGQ@mail.gmail.com>
Subject: Re: [PATCH 26/41] kernel/fork: assert no VMA readers during its destruction
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
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

On Tue, Jan 17, 2023 at 7:42 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Mon 09-01-23 12:53:21, Suren Baghdasaryan wrote:
> > Assert there are no holders of VMA lock for reading when it is about to be
> > destroyed.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm.h | 8 ++++++++
> >  kernel/fork.c      | 2 ++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 594e835bad9c..c464fc8a514c 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -680,6 +680,13 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> >       VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
> >  }
> >
> > +static inline void vma_assert_no_reader(struct vm_area_struct *vma)
> > +{
> > +     VM_BUG_ON_VMA(rwsem_is_locked(&vma->lock) &&
> > +                   vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq),
> > +                   vma);
>
> Do we really need to check for vm_lock_seq? rwsem_is_locked should tell
> us something is wrong on its own, no? This could be somebody racing with
> the vma destruction and using the write lock. Unlikely but I do not see
> why to narrow debugging scope.

I wanted to ensure there are no page fault handlers (read-lockers)
when we are destroying the VMA and rwsem_is_locked(&vma->lock) alone
could trigger if someone is concurrently calling vma_write_lock(). But
I don't think we expect someone to be write-locking the VMA while we
are destroying it, so you are right, I'm overcomplicating things here.
I think I can get rid of vma_assert_no_reader() and add
VM_BUG_ON_VMA(rwsem_is_locked(&vma->lock)) directly in
__vm_area_free(). WDYT?


> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
