Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428046A7380
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCASfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCASfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:35:01 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4983B865
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:35:00 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id n18so1304329ybm.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 10:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677695700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sf6UrJ/lIWn1fjlxCohn27ZSd8Q0TfJriVXXcU5qWAE=;
        b=sMqxKmMPWADCyZTd0B+sCUFvSsU0xwpbUR9hz5KDANoBtXhUgELy2PB9S6CmdcPdLB
         9DuY263Lca20XWKvkKm/VeE8UXAxbFZ7UbMDjj/GdF33ace4U+qR3SuprdJIyGlg0kh4
         8ZY6tqKyRCrC4qSvVBH79BPeROQDCdXsUZHeJsRV9J+lzs8QF19Sft8unbL3LhV+NyMQ
         rULPzaHubsvYpBIvwRVqUZqOtQrYMTbpInxvEOTwI44gseylO/JwJ1XsAHZVMuGFZ8ce
         lLm3lv4Ir2Kuf2SdE943w0lXUD4jHslpCCCCxHMHmN15vxuLPQ0RJvPoRPshybRhAX6v
         429Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677695700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sf6UrJ/lIWn1fjlxCohn27ZSd8Q0TfJriVXXcU5qWAE=;
        b=k5oTSoAZbtJHf3lCfkxH9fMjfnMXmdo7vO8xX5iIivhPPVQqrk+T43qo0rwqS/xqyb
         6kSukBlgLbhe6hWf0ihLXCFEpAnV+PoxMXubw1PAlkrkUWSUW/auR0wHc3ojsSGHS9Ck
         1QNfhJKp3KbZDCxirTA5wjrjwHUFFphcPnLdpyGtiDREvHi2Ma5izQu0f2idoXI6hZw0
         +WXkgTeYz6a9V+0xAfD7q2jPmqa7VtGefFGwHAh2LR0ySTYgIbXyreaekWtZdjXUXtjt
         dEZwzPoFb+8k1Ew41jqWWhIqZ2rXtWCjDNXfHgvrj3xJY1FVW9wtVjIyP2qtptN4fy13
         LNSw==
X-Gm-Message-State: AO0yUKULwzo9vwTCyKNoMs/J4doncLEr0J+0ndS1N+AcRZd8to6uQEB/
        JZ7dZU7E4Ii1/72xEy4plYBPs0JU+8kniyH0RAKT1Q==
X-Google-Smtp-Source: AK7set/vwIRLhIQIPE3GkkxKkfmhP1CRU34HRxLzx1/Rma4BTfbR6X5PIRaaOJxNUaM1YhGtm7HsF2b9hYcFbnNAeaU=
X-Received: by 2002:a25:9704:0:b0:a30:38fb:a2e4 with SMTP id
 d4-20020a259704000000b00a3038fba2e4mr3269439ybo.6.1677695699906; Wed, 01 Mar
 2023 10:34:59 -0800 (PST)
MIME-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com> <20230227173632.3292573-19-surenb@google.com>
 <Y/8CJQGNuMUTdLwP@localhost> <Y/8FNM9czzPHb5eG@localhost>
In-Reply-To: <Y/8FNM9czzPHb5eG@localhost>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 1 Mar 2023 10:34:48 -0800
Message-ID: <CAJuCfpHYT++MBC6T-p80n_m5hHWRRC4Y1bO9J-bFFZZDqNX-BQ@mail.gmail.com>
Subject: Re: [PATCH v4 18/33] mm: write-lock VMAs before removing them from
 VMA tree
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Feb 28, 2023 at 11:57=E2=80=AFPM Hyeonggon Yoo <42.hyeyoo@gmail.com=
> wrote:
>
> On Wed, Mar 01, 2023 at 07:43:33AM +0000, Hyeonggon Yoo wrote:
> > On Mon, Feb 27, 2023 at 09:36:17AM -0800, Suren Baghdasaryan wrote:
> > > Write-locking VMAs before isolating them ensures that page fault
> > > handlers don't operate on isolated VMAs.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  mm/mmap.c  | 1 +
> > >  mm/nommu.c | 5 +++++
> > >  2 files changed, 6 insertions(+)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 1f42b9a52b9b..f7ed357056c4 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2255,6 +2255,7 @@ int split_vma(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
> > >  static inline int munmap_sidetree(struct vm_area_struct *vma,
> > >                                struct ma_state *mas_detach)
> > >  {
> > > +   vma_start_write(vma);
> > >     mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
> >
> > I may be missing something, but have few questions:
> >
> >       1) Why does a writer need to both write-lock a VMA and mark the V=
MA detached
> >          when unmapping it, isn't it enough to just only write-lock a V=
MA?

We need to mark the VMA detached to avoid handling page fault in a
detached VMA. The possible scenario is:

lock_vma_under_rcu
  vma =3D mas_walk(&mas)
                                                        munmap_sidetree
                                                          vma_start_write(v=
ma)

mas_store_gfp() // remove VMA from the tree
                                                          vma_end_write_all=
()
  vma_start_read(vma)
  // we locked the VMA but it is not part of the tree anymore.

So, marking the VMA locked before vma_end_write_all() and checking
vma->detached after vma_start_read() helps us avoid handling faults in
the detached VMA.


> >
> >       2) as VMAs that are going to be removed are already locked in vma=
_prepare(),
> >          so I think this hunk could be dropped?
>
> After sending this just realized that I did not consider simple munmap ca=
se :)
> But I still think 1) and 3) are valid question.
>
> >
> > >     if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
> > >             return -ENOMEM;
> > > diff --git a/mm/nommu.c b/mm/nommu.c
> > > index 57ba243c6a37..2ab162d773e2 100644
> > > --- a/mm/nommu.c
> > > +++ b/mm/nommu.c
> > > @@ -588,6 +588,7 @@ static int delete_vma_from_mm(struct vm_area_stru=
ct *vma)
> > >                    current->pid);
> > >             return -ENOMEM;
> > >     }
> > > +   vma_start_write(vma);
> > >     cleanup_vma_from_mm(vma);
> >
> >       3) I think this hunk could be dropped as Per-VMA lock depends on =
MMU anyway.

Ah, yes, you are right. We can safely remove the changes in nommu.c
Andrew, should I post a fixup or you can make the removal directly in
mm-unstable?
Thanks,
Suren.

> >
> > Thanks,
> > Hyeonggon
> >
> > >
> > >     /* remove from the MM's tree and list */
> > > @@ -1519,6 +1520,10 @@ void exit_mmap(struct mm_struct *mm)
> > >      */
> > >     mmap_write_lock(mm);
> > >     for_each_vma(vmi, vma) {
> > > +           /*
> > > +            * No need to lock VMA because this is the only mm user a=
nd no
> > > +            * page fault handled can race with it.
> > > +            */
> > >             cleanup_vma_from_mm(vma);
> > >             delete_vma(mm, vma);
> > >             cond_resched();
> > > --
> > > 2.39.2.722.g9855ee24e9-goog
> > >
> > >
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
