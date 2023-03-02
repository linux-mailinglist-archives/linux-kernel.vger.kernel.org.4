Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6406A7881
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 01:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCBAyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 19:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBAyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 19:54:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B491ACDD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 16:54:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so1095125pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 16:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1p7gLBnjTY2NzqqDfZ3+sK3ELM0whxNqoGWgGrbWZok=;
        b=dIuwnaIQ2bBUUz2optFpHImdgLTXLjc71Pyskqyty88uSV5WuiXl4EF6AzbQz/NvDA
         bnewBQ8MDcrZ3ZNu5L92lqAmIdJYxFkE39GdDnGIB1WAuljQTRNHcNkW6Ug1O76YUDIq
         ii9cc5JIQNsExXmUEy6NT3bGWAn0vrvp6IUyDQHQGe9STLpLDGrPNztuq+gJuPBVf1sW
         knhPQtyF1OhCU9vVlwi3oypfLyPDcxoNZW9OvJANM9vYeephCdst1w6i6OPbiK24p0Ye
         WpobOonjOm828sKMocXSeQ/i3h3VC8YHc62eF6VDSwVoPyhmf1FldFlcNVZEtveAyPgR
         b4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1p7gLBnjTY2NzqqDfZ3+sK3ELM0whxNqoGWgGrbWZok=;
        b=QJ/iMsHQ0GECY/CQd0iKQPljmLnH1owvixsUdH6WqytKFVJl79d610IBLyiZ5qUwnI
         vhZBpAs1v6jVqZy0UkOKQNRS9xAUQ7FvW9eOdkrhdusnfndlAtJn/qda7pNfWTNQ/O+r
         tMgcViuORtwYipTUGk6bNPErsCFpcJI/UTeGeExfA1Trg0BYZUQJVyUKS8qj2ID62b90
         c2o4si50UsH/5bgUGbW0VtuRaJ+PU95/gHC+Xp0x8qS78GvrEb6YzZ6QxjgMpmAvQ6gv
         93HtV5q1s6q1i1JoK/MbliL3E6uCMJARp8Ezs0i8zOOmfGGpgf2VVbokxk0wziJL6dE2
         1MCg==
X-Gm-Message-State: AO0yUKXE8tsmCZP5TCS3qncJNm5kdoZ7Q3pa4+BDAkHiJ0wNo4VLjHOF
        8EcuxIeZuBISS2MZcYvo/6k=
X-Google-Smtp-Source: AK7set9xYz9SPyOCt7tLgYDSF/C0yAQqSuW6dLV1Fq6uvubFXXpgs+hx2VuoCASTSYarsrrYwT4C/g==
X-Received: by 2002:a17:902:e886:b0:19a:ad2f:2df9 with SMTP id w6-20020a170902e88600b0019aad2f2df9mr10366596plg.55.1677718442825;
        Wed, 01 Mar 2023 16:54:02 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902900b00b0019a9637b2d3sm8999040plp.279.2023.03.01.16.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 16:54:01 -0800 (PST)
Date:   Thu, 2 Mar 2023 00:53:45 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 18/33] mm: write-lock VMAs before removing them from
 VMA tree
Message-ID: <Y//zmYeu6uexiyOY@localhost>
References: <20230227173632.3292573-1-surenb@google.com>
 <20230227173632.3292573-19-surenb@google.com>
 <Y/8CJQGNuMUTdLwP@localhost>
 <Y/8FNM9czzPHb5eG@localhost>
 <CAJuCfpHYT++MBC6T-p80n_m5hHWRRC4Y1bO9J-bFFZZDqNX-BQ@mail.gmail.com>
 <CAJuCfpFax8LSdcq1qiz3sp0XPLaNZnkFFky2tQekG2_Azvw9_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFax8LSdcq1qiz3sp0XPLaNZnkFFky2tQekG2_Azvw9_g@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 10:42:48AM -0800, Suren Baghdasaryan wrote:
> On Wed, Mar 1, 2023 at 10:34 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Tue, Feb 28, 2023 at 11:57 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> > >
> > > On Wed, Mar 01, 2023 at 07:43:33AM +0000, Hyeonggon Yoo wrote:
> > > > On Mon, Feb 27, 2023 at 09:36:17AM -0800, Suren Baghdasaryan wrote:
> > > > > Write-locking VMAs before isolating them ensures that page fault
> > > > > handlers don't operate on isolated VMAs.
> > > > >
> > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > ---
> > > > >  mm/mmap.c  | 1 +
> > > > >  mm/nommu.c | 5 +++++
> > > > >  2 files changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > index 1f42b9a52b9b..f7ed357056c4 100644
> > > > > --- a/mm/mmap.c
> > > > > +++ b/mm/mmap.c
> > > > > @@ -2255,6 +2255,7 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > > > >  static inline int munmap_sidetree(struct vm_area_struct *vma,
> > > > >                                struct ma_state *mas_detach)
> > > > >  {
> > > > > +   vma_start_write(vma);
> > > > >     mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
> > > >
> > > > I may be missing something, but have few questions:
> > > >
> > > >       1) Why does a writer need to both write-lock a VMA and mark the VMA detached
> > > >          when unmapping it, isn't it enough to just only write-lock a VMA?
> >
> > We need to mark the VMA detached to avoid handling page fault in a
> > detached VMA. The possible scenario is:
> >
> > lock_vma_under_rcu
> >   vma = mas_walk(&mas)
> >                                                         munmap_sidetree
> >                                                           vma_start_write(vma)
> >
> > mas_store_gfp() // remove VMA from the tree
> >                                                           vma_end_write_all()
> >   vma_start_read(vma)
> >   // we locked the VMA but it is not part of the tree anymore.
> >
> > So, marking the VMA locked before vma_end_write_all() and checking
> 
> Sorry, I should have said "marking the VMA *detached* before
> vma_end_write_all() and checking vma->detached after vma_start_read()
> helps us avoid handling faults in the detached VMA."
> 
> > vma->detached after vma_start_read() helps us avoid handling faults in
> > the detached VMA.

Thank you for explanation, that makes sense!

By the way, if there are no 32bit users of Per-VMA lock (are there?),
"detached" bool could be a VMA flag (i.e. making it depend on 64BIT
and selecting ARCH_USES_HIGH_VMA_FLAGS)

Thanks,
Hyeonggon

