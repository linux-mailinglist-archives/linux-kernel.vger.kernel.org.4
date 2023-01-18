Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFA36710D3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjARCI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjARCIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:08:31 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78E653F86
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:08:01 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4d13cb4bbffso328945757b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IPntz93C+TLeiYuya3M1C/wd28MHaFTPeMLFazEhwmE=;
        b=E/NELfxMjFTBI1CmtbcqjwsiauENdaTqInach8c86SJR2c1/56WBUHAal3gIhTRUSb
         jv5FEJFY1G+j14AmMioNZe/bJvrtUa4pwIjIu906R7jCEXint9daeTioB7w/OdN0H1eo
         eJQ22mc9V/eYL4wCsWdZ1vcc44AiUDEtW1uHBGuQyk23DmBqSMDkwC2DgQVpl8YosT9e
         mRedZ/Kmq4J+N524TLxW75CBx6pTTLnnuzhjvwPqs4zhrByXdnUiCcoHjxOALgS+Toir
         JxLqPBv9lh1Hz0PKEROEOPoPjIho1oPrj/ub9qhqrValKsHTGtbIGxv2iJwSdawi2I4l
         OJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPntz93C+TLeiYuya3M1C/wd28MHaFTPeMLFazEhwmE=;
        b=bdqZx9IvVgo3auxfyPkjhBYS06c8mLj62x+zMZ5BviiedLfQRGrIXhTove9YQS3Def
         g/2riVr2OXqB9mByloQlezQjRq+ZCs/cLlvJZpPyFdAKzoA6KqGVoinqfWDPE3T2zPbn
         JvMdWwM+QDyBm8olLpdo6PZzm8z8B5b/X6+xcQHuzo0xaOzzoX4xsTCsBbLaKLcGhFm4
         6bHdM7V/8h3mJv+iDUjtLeukYncXCQzKoqAHMnYiM5nXIIuff04bEMh1aFB0PXFwLAhc
         V18bNDqKxPksRG/cDmWWKZ/zSXZGA4DTXqmBtssAcG/LoNcxf0ujUcLGE4xKj6F76SOY
         fFFg==
X-Gm-Message-State: AFqh2kopo1TSoSNT8WQRKU2y1GlD5Zmmzu6k09mwRflBkWpcvrp+PGPQ
        ue8db41HnKetMmgf84w9NnlRRM+HuIlz5KHHHx8Q2A==
X-Google-Smtp-Source: AMrXdXt6HN6HjCJ0KoPrl+Bw/cVoPlnqd1wGxDKFOs1p/ddQiqBkhapFdQZ4VL85ZMUAD+PRUyF839a3jZDZ94RZE64=
X-Received: by 2002:a81:784c:0:b0:4e1:5013:6da1 with SMTP id
 t73-20020a81784c000000b004e150136da1mr767604ywc.218.1674007680736; Tue, 17
 Jan 2023 18:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-14-surenb@google.com>
 <Y8a6DhA6o3jcZaM3@dhcp22.suse.cz> <Y8a7eJQ6upFyI6pf@dhcp22.suse.cz>
In-Reply-To: <Y8a7eJQ6upFyI6pf@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 18:07:49 -0800
Message-ID: <CAJuCfpFtMjuJS6-4FYR8gWwKJjRuX5Dd2DQLHLiGLUuij_YjMQ@mail.gmail.com>
Subject: Re: [PATCH 13/41] mm: introduce vma->vm_flags modifier functions
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

On Tue, Jan 17, 2023 at 7:15 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Tue 17-01-23 16:09:03, Michal Hocko wrote:
> > On Mon 09-01-23 12:53:08, Suren Baghdasaryan wrote:
> > > To keep vma locking correctness when vm_flags are modified, add modifier
> > > functions to be used whenever flags are updated.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  include/linux/mm.h       | 38 ++++++++++++++++++++++++++++++++++++++
> > >  include/linux/mm_types.h |  8 +++++++-
> > >  2 files changed, 45 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index ec2c4c227d51..35cf0a6cbcc2 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -702,6 +702,44 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
> > >     vma_init_lock(vma);
> > >  }
> > >
> > > +/* Use when VMA is not part of the VMA tree and needs no locking */
> > > +static inline
> > > +void init_vm_flags(struct vm_area_struct *vma, unsigned long flags)
> > > +{
> > > +   WRITE_ONCE(vma->vm_flags, flags);
> > > +}
> >
> > Why do we need WRITE_ONCE here? Isn't vma invisible during its
> > initialization?

Ack. Will change to a simple assignment.

> >
> > > +
> > > +/* Use when VMA is part of the VMA tree and needs appropriate locking */
> > > +static inline
> > > +void reset_vm_flags(struct vm_area_struct *vma, unsigned long flags)
> > > +{
> > > +   vma_write_lock(vma);
> > > +   init_vm_flags(vma, flags);
> > > +}
> > > +
> > > +static inline
> > > +void set_vm_flags(struct vm_area_struct *vma, unsigned long flags)
> > > +{
> > > +   vma_write_lock(vma);
> > > +   vma->vm_flags |= flags;
> > > +}
> > > +
> > > +static inline
> > > +void clear_vm_flags(struct vm_area_struct *vma, unsigned long flags)
> > > +{
> > > +   vma_write_lock(vma);
> > > +   vma->vm_flags &= ~flags;
> > > +}
> > > +
> > > +static inline
> > > +void mod_vm_flags(struct vm_area_struct *vma,
> > > +             unsigned long set, unsigned long clear)
> > > +{
> > > +   vma_write_lock(vma);
> > > +   vma->vm_flags |= set;
> > > +   vma->vm_flags &= ~clear;
> > > +}
> > > +
> >
> > This is rather unusual pattern. There is no note about locking involved
> > in the naming and also why is the locking part of this interface in the
> > first place? I can see reason for access functions to actually check for
> > lock asserts.
>
> OK, it took me a while but it is clear to me now. The confusion comes
> from the naming vma_write_lock is no a lock in its usual terms. It is
> more of a vma_mark_modified with side effects to read locking which is a
> real lock. With that it makes more sense to have this done in these
> helpers rather than requiring all users to keep this subtletly in mind.

If renaming vma-locking primitives the way Matthew suggested in
https://lore.kernel.org/all/Y8cZMt01Z1FvVFXh@casper.infradead.org/
makes it easier to read/understand, I'm all for it. Let's discuss the
naming in that email thread because that's where these functions are
introduced.

>
> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
