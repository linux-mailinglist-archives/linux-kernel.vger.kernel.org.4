Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26915B3CB0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiIIQKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiIIQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:10:22 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311196B8FA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:10:20 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id k80so3351500ybk.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=f+8N/y8y23UZcEEw+aQnyU3DKfX0ieX6O82IRCC4HdM=;
        b=BiyE3pbFzAwYEbflQaZphZUwAl6tFqEKoxOSeraxpHXAycNAP3ER6hKVN7zFxfnZYI
         dmbHBcE6XaXCDmJB0eURxyjOS/LYAdTSVJQQgbSxedvGxksEGEwo8bnxbUL8mqNSiS0I
         HQyjMm7qR28Cy5F5ljGna6zDh1IiUsm0e6MqXa3HuxfjplJN7dSZ/Qs1dLgbietr0qPm
         aaeYBKFqiZMof8mnns8VIkOIM2RsE/1SOEkhSnGyg23sOandSiJu5QHwmXR0GZ62ahYH
         XGvfGR0+GC7EgWkb3KjP0ya0ZAmSu88fnl+kiUpJwLjqxUD63YfqwYHj3h/U+xX2yvGr
         3QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=f+8N/y8y23UZcEEw+aQnyU3DKfX0ieX6O82IRCC4HdM=;
        b=MY0fQXUHTtXGJiZjVxMtKabfMocZC9l0xeY4zbGAd73k6G35IYV/CZ51i9zgP//U4+
         D9VYhNIxyuz1SfEfXkErtkm2NBuM1VmyYPpOknem77Og0MKQsWryPp++T/yp9o8K8xza
         Ec0Vto0vBzRKEhBYw5FIJqDmA0aA0b0p87610W6BXGzoz9XeQTO+3YHKzHMnHv/f6rK6
         X0cEHeypb2RaKwhwWN3a07E3zCkWE7ju7nlvnV0LyGgJ13bIhmrzmbafVkriQZYbBoaK
         KOuGFgA1TCbU0VbIZGiQCMqVdYCbIOwPxZGabAHlLj8fOg2S1YyZE8XROkT49xgUt5Uz
         Qu1g==
X-Gm-Message-State: ACgBeo1cggnBbfYajY1h51NgtYhtCzbE8C+tQ30AEWtANIyxpF1ZbiXb
        71VpW3korIHuR9oSdGNAEpFMBubQDvaClMR9Brf19g==
X-Google-Smtp-Source: AA6agR5mnVSQ1qQ+aIdXXXGAhOTMvHt8B37xrRYeRcCRdY1CnsLY6FiKvNQ4vPY3G6eYgyMHbEmwJurPorP8bkXzM8s=
X-Received: by 2002:a25:424a:0:b0:6a9:2954:87fd with SMTP id
 p71-20020a25424a000000b006a9295487fdmr12075530yba.340.1662739819203; Fri, 09
 Sep 2022 09:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-22-surenb@google.com>
 <630714df-dec1-4a41-6af3-380181d11669@linux.ibm.com>
In-Reply-To: <630714df-dec1-4a41-6af3-380181d11669@linux.ibm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Sep 2022 09:10:08 -0700
Message-ID: <CAJuCfpFtsP6s+pgus4RjFdwasg69hQ-LOSOL8XV4zUMey0zS9g@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 21/28] mm: introduce find_and_lock_anon_vma to
 be used from arch-specific code
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

On Fri, Sep 9, 2022 at 7:38 AM Laurent Dufour <ldufour@linux.ibm.com> wrote=
:
>
> Le 01/09/2022 =C3=A0 19:35, Suren Baghdasaryan a =C3=A9crit :
> > Introduce find_and_lock_anon_vma function to lookup and lock an anonymo=
us
> > VMA during page fault handling. When VMA is not found, can't be locked
> > or changes after being locked, the function returns NULL. The lookup is
> > performed under RCU protection to prevent the found VMA from being
> > destroyed before the VMA lock is acquired. VMA lock statistics are
> > updated according to the results.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm.h |  3 +++
> >  mm/memory.c        | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 48 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 7c3190eaabd7..a3cbaa7b9119 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -684,6 +684,9 @@ static inline void vma_assert_no_reader(struct vm_a=
rea_struct *vma)
> >                     vma);
> >  }
> >
> > +struct vm_area_struct *find_and_lock_anon_vma(struct mm_struct *mm,
> > +                                           unsigned long address);
> > +
> >  #else /* CONFIG_PER_VMA_LOCK */
> >
> >  static inline void vma_init_lock(struct vm_area_struct *vma) {}
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 29d2f49f922a..bf557f7056de 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5183,6 +5183,51 @@ vm_fault_t handle_mm_fault(struct vm_area_struct=
 *vma, unsigned long address,
> >  }
> >  EXPORT_SYMBOL_GPL(handle_mm_fault);
> >
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +static inline struct vm_area_struct *find_vma_under_rcu(struct mm_stru=
ct *mm,
> > +                                                     unsigned long add=
ress)
> > +{
> > +     struct vm_area_struct *vma =3D __find_vma(mm, address);
> > +
> > +     if (!vma || vma->vm_start > address)
> > +             return NULL;
> > +
> > +     if (!vma_is_anonymous(vma))
> > +             return NULL;
> > +
>
> It looks to me more natural to first check that the VMA is part of the RB
> tree before try read locking it.

I think we want to check that the VMA is still part of the mm _after_
we locked it. Otherwise we might pass the check, then some other
thread does (lock->isolate->unlock) and then we lock the VMA. We would
end up with a VMA that is not part of mm anymore but we assume it is.

>
> > +     if (!vma_read_trylock(vma)) {
> > +             count_vm_vma_lock_event(VMA_LOCK_ABORT);
> > +             return NULL;
> > +     }
> > +
> > +     /* Check if the VMA got isolated after we found it */
> > +     if (RB_EMPTY_NODE(&vma->vm_rb)) {
> > +             vma_read_unlock(vma);
> > +             count_vm_vma_lock_event(VMA_LOCK_MISS);
> > +             return NULL;
> > +     }
> > +
> > +     return vma;
> > +}
> > +
> > +/*
> > + * Lookup and lock and anonymous VMA. Returned VMA is guaranteed to be=
 stable
> > + * and not isolated. If the VMA is not found of is being modified the =
function
> > + * returns NULL.
> > + */
> > +struct vm_area_struct *find_and_lock_anon_vma(struct mm_struct *mm,
> > +                                           unsigned long address)
> > +{
> > +     struct vm_area_struct *vma;
> > +
> > +     rcu_read_lock();
> > +     vma =3D find_vma_under_rcu(mm, address);
> > +     rcu_read_unlock();
> > +
> > +     return vma;
> > +}
> > +#endif /* CONFIG_PER_VMA_LOCK */
> > +
> >  #ifndef __PAGETABLE_P4D_FOLDED
> >  /*
> >   * Allocate p4d page table.
>
