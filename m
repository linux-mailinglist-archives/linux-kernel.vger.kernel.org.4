Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A225B3CF6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiIIQ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiIIQ20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:28:26 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D5F13CB13
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:28:26 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 202so3409106ybe.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=BtrcDF/wsi4Mz50C9AtmB+94fMD35zW5o5lMMRnL+ts=;
        b=cYytpVKXeuoA9XTPipx92LXKUuqKLMkrk5Aj4EsXo3m6xCDrmFCV96avGVoJSwKUyI
         IJ+8XyfbhH2xCVoEfmvWp2hmz7qVLqJdi/h9AG/ziv6PiNLTxkPqPIEl1TKgn1Sjnu7V
         HJC/79fqa6qt3xs+aYFVN8Fi6Jr3++m+jsUPGfbrrlmhm1dnwdm6q+tTo+2vypqDgQ4p
         SDtTcwo3wuwldJxt/nUGS8qS7+xPZCEA8kmSQ8jh+W2uU3Iix1LhCJQKhtjvM2Rg7zmR
         C5XH6ocqrK/bPxfVvegO5VJmRFOTFlbDw/quPQFAEBZ/2zG/u+ha7UILuQML8c0Ui/zR
         5D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BtrcDF/wsi4Mz50C9AtmB+94fMD35zW5o5lMMRnL+ts=;
        b=GZOZsbklrQQpAn8sohd2cC9mZpoU5WGtijALp2lWx4bYDhPUfSGmnxG7Efp/LZM2+A
         6pAgqUce0uxAlLbsBPO2Jv+i8AUX8WZa5vIVwKdNFHuQLMjG2pcjRE0byNmMnGCMOrur
         tPBjLCeMgWPig+QQAsIIIhcMcwnNpQ/K+2K5rWBAmMWckLbkfU3AYlHQZzOGQHBkA95e
         kQSBnUE/Y7YzlRgDfuZb0Vam8JLPxpp9gWkQ9pX6mvp91aX8TGuKerCUSKRkcKje6f6b
         SrMwaICIrqA6gUh1kDrWFRGHmpB6ExTIQUdfc2Z45LvCCxe7OVnxlUI6aSzmb6WZ6eo8
         WIxw==
X-Gm-Message-State: ACgBeo19mY8/XH4WAxgGb0uGNm+wwSJM8NsifLiwyUVb8w7Pomwi4bW1
        uOWqSBwj6waje1JDtgXMFXRxTEmTG9Kfrn1MgJInbw==
X-Google-Smtp-Source: AA6agR6VwZjHnx3/k4MmEwX2PHQzkWitOBKlKZUri6A+36oevF8WeczM6CeLc2fJXgQcdWaTJpN0N4HZQQ/3z0n9XqU=
X-Received: by 2002:a25:d209:0:b0:6a8:e5f1:f179 with SMTP id
 j9-20020a25d209000000b006a8e5f1f179mr11954900ybg.380.1662740904957; Fri, 09
 Sep 2022 09:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-15-surenb@google.com>
 <7fcc871c-fcc2-e993-fe88-f0da49ff227a@linux.ibm.com>
In-Reply-To: <7fcc871c-fcc2-e993-fe88-f0da49ff227a@linux.ibm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Sep 2022 09:28:13 -0700
Message-ID: <CAJuCfpH-YQYCQtzWdR9rGfXBD53ZSawXnj-FbuEGqTSd4Y1zmg@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 14/28] mm: mark VMAs as locked before isolating them
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

On Fri, Sep 9, 2022 at 6:35 AM Laurent Dufour <ldufour@linux.ibm.com> wrote=
:
>
> Le 01/09/2022 =C3=A0 19:35, Suren Baghdasaryan a =C3=A9crit :
> > Mark VMAs as locked before isolating them and clear their tree node so
> > that isolated VMAs are easily identifiable. In the later patches page
> > fault handlers will try locking the found VMA and will check whether
> > the VMA was isolated. Locking VMAs before isolating them ensures that
> > page fault handlers don't operate on isolated VMAs.
>
> Found another place where the VMA should probably mark locked:
> *** drivers/gpu/drm/drm_vma_manager.c:
> drm_vma_node_revoke[338]       rb_erase(&entry->vm_rb, &node->vm_files);

Thanks! I'll add the necessary locking.

>
> There are 2 others entries in nommu.c but I guess this is not supported,
> isn't it?

Yes, PER_VMA_LOCK config depends on MMU but for completeness we could
add locking there as well (it will be compiled out).

>
>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/mmap.c  | 2 ++
> >  mm/nommu.c | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 094678b4434b..b0d78bdc0de0 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -421,12 +421,14 @@ static inline void vma_rb_insert(struct vm_area_s=
truct *vma,
> >
> >  static void __vma_rb_erase(struct vm_area_struct *vma, struct rb_root =
*root)
> >  {
> > +     vma_mark_locked(vma);
> >       /*
> >        * Note rb_erase_augmented is a fairly large inline function,
> >        * so make sure we instantiate it only once with our desired
> >        * augmented rbtree callbacks.
> >        */
> >       rb_erase_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
> > +     RB_CLEAR_NODE(&vma->vm_rb);
> >  }
> >
> >  static __always_inline void vma_rb_erase_ignore(struct vm_area_struct =
*vma,
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index e819cbc21b39..ff9933e57501 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -622,6 +622,7 @@ static void delete_vma_from_mm(struct vm_area_struc=
t *vma)
> >       struct mm_struct *mm =3D vma->vm_mm;
> >       struct task_struct *curr =3D current;
> >
> > +     vma_mark_locked(vma);
> >       mm->map_count--;
> >       for (i =3D 0; i < VMACACHE_SIZE; i++) {
> >               /* if the vma is cached, invalidate the entire cache */
> > @@ -644,6 +645,7 @@ static void delete_vma_from_mm(struct vm_area_struc=
t *vma)
> >
> >       /* remove from the MM's tree and list */
> >       rb_erase(&vma->vm_rb, &mm->mm_rb);
> > +     RB_CLEAR_NODE(&vma->vm_rb);
> >
> >       __vma_unlink_list(mm, vma);
> >  }
>
