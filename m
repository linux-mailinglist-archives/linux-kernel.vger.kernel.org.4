Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D2B699D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 20:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBPTgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 14:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjBPTgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 14:36:38 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E060D4CCBA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 11:36:36 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 145so1993856ybd.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 11:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kPbmP0HEcZpXUsWhibQteNAlMcCYqcrNbxA2g4JE/A=;
        b=ofef3CWOUeTxZZ+PIIwVk8SzvwcsVuW68YnGdTw0sJZfvvLZRwG1rTv+k9fTx+zmY0
         PE+VFGCtwaQeHc/Q7XMRjsyKtq5v6pfu2ev2sPQMb6UhIu61GUINkjK2pMfPtzeCkg5o
         6Gjn60EBkfD/UVWNXjrWJZQIdGTPM/jNXjLbXL+SInNkzvFVogdETkZAoteauf6LPlI8
         AgbAdlE0fAYulqZ1ET3yXlivnH8nosnvGQm5O+vqx8fc5mJNQMBxl19NpaII9TKyV+Lb
         0ghtuwgUVAq0SlQaFPa0ikdsi4vcic/WEKbLdudqbreIUAad8DgTKMEozeVtakIWzbDz
         Eq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kPbmP0HEcZpXUsWhibQteNAlMcCYqcrNbxA2g4JE/A=;
        b=0MucYSBsXKyiJnhC0KJdD9TJaBJkX5PpJDBjIWABe6uCPKspIrFlJF8T8E5PumuT4S
         lPoTDoM/UjXN9y5i5aXR17HBZ+Lc6GqOM729m686/blhoD3gf/OgVQtyyH4EHr/TS7ye
         m9ln6LB/EvRjxUcPA+Tx9/S05zT3w7oYpgIK0t7pBP7VXFfvE7RAR5ApUgkIWhCtdLcm
         WPmGDCYxBC9Z9SdocQeLG9/HPwPESvBhv0BzfyPWDzdn1Nxycn/z23ip/ESlMVLiW8CQ
         qTwA1gbWmG/dTHsx0r4dKJ/y+4NvfP0M8CRpcePLb0vr2ZgC5FPb8uUdERFJ9EP6Zmix
         WO3w==
X-Gm-Message-State: AO0yUKWAPZTsSvVtfvWHzuYRA2H0lI8xcb2x4fUaqhWYJU/LlYot1bKz
        Prde9RuA4SFHQQmZnNtjQ+f7DCOUsvm38IQ1bX+f5A==
X-Google-Smtp-Source: AK7set+RMcw3ZcSV3HGm+iFjEGJ0Lev4v85qKlq2LIi8Vsi9NpR/fhxseBWzeKpPsLOx+aOI+tOgrQwVizPu7Xy8HOQ=
X-Received: by 2002:a25:9941:0:b0:90c:de27:7f15 with SMTP id
 n1-20020a259941000000b0090cde277f15mr873659ybo.428.1676576195831; Thu, 16 Feb
 2023 11:36:35 -0800 (PST)
MIME-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com> <20230216051750.3125598-22-surenb@google.com>
 <20230216153405.zo4l2lqpnc2agdzg@revolver>
In-Reply-To: <20230216153405.zo4l2lqpnc2agdzg@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 16 Feb 2023 11:36:24 -0800
Message-ID: <CAJuCfpEkujbHNxNWcWr8bmrsMhXGcpDyraOfQaPAcOH=RQPv5A@mail.gmail.com>
Subject: Re: [PATCH v3 21/35] mm/mmap: write-lock adjacent VMAs if they can
 grow into unmapped area
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, peterz@infradead.org, ldufour@linux.ibm.com,
        paulmck@kernel.org, mingo@redhat.com, will@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
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

On Thu, Feb 16, 2023 at 7:34 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
>
> First, sorry I didn't see this before v3..

Feedback at any time is highly appreciated!

>
> * Suren Baghdasaryan <surenb@google.com> [230216 00:18]:
> > While unmapping VMAs, adjacent VMAs might be able to grow into the area
> > being unmapped. In such cases write-lock adjacent VMAs to prevent this
> > growth.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/mmap.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 118b2246bba9..00f8c5798936 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2399,11 +2399,13 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >        * down_read(mmap_lock) and collide with the VMA we are about to unmap.
> >        */
> >       if (downgrade) {
> > -             if (next && (next->vm_flags & VM_GROWSDOWN))
> > +             if (next && (next->vm_flags & VM_GROWSDOWN)) {
> > +                     vma_start_write(next);
> >                       downgrade = false;
>
> If the mmap write lock is insufficient to protect us from next/prev
> modifications then we need to move *most* of this block above the maple
> tree write operation, otherwise we have a race here.  When I say most, I
> mean everything besides the call to mmap_write_downgrade() needs to be
> moved.

Which prior maple tree write operation are you referring to? I see
__split_vma() and munmap_sidetree() which both already lock the VMAs
they operate on, so page faults can't happen in those VMAs.

>
> If the mmap write lock is sufficient to protect us from next/prev
> modifications then we don't need to write lock the vmas themselves.

mmap write lock is not sufficient because with per-VMA locks we do not
take mmap lock at all.

>
> I believe this is for expand_stack() protection, so I believe it's okay
> to not vma write lock these vmas.. I don't think there are other areas
> where we can modify the vmas without holding the mmap lock, but others
> on the CC list please chime in if I've forgotten something.
>
> So, if I am correct, then you shouldn't lock next/prev and allow the
> vma locking fault method on these vmas.  This will work because
> lock_vma_under_rcu() uses mas_walk() on the faulting address.  That is,
> your lock_vma_under_rcu() will fail to find anything that needs to be
> grown and go back to mmap lock protection.  As it is written today, the
> vma locking fault handler will fail and we will wait for the mmap lock
> to be released even when the vma isn't going to expand.

So, let's consider a case when the next VMA is not being removed (so
it was neither removed nor locked by munmap_sidetree()) and it is
found by lock_vma_under_rcu() in the page fault handling path. Page
fault handler can now expand it and push into the area we are
unmapping in unmap_region(). That is the race I'm trying to prevent
here by locking the next/prev VMAs which can be expanded before
unmap_region() unmaps them. Am I missing something?

>
>
> > -             else if (prev && (prev->vm_flags & VM_GROWSUP))
> > +             } else if (prev && (prev->vm_flags & VM_GROWSUP)) {
> > +                     vma_start_write(prev);
> >                       downgrade = false;
> > -             else
> > +             } else
> >                       mmap_write_downgrade(mm);
> >       }
> >
> > --
> > 2.39.1
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
