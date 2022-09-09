Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30E95B3CEF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiIIQZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiIIQZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:25:22 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335271017CF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:25:20 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id t184so3453508yba.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=miU+viOw7qa7tyRJ4Or3oAz5OewEcwcrhnBCcmhlJME=;
        b=c1ixqNT2Wb/tj4p47082iOqXbPydTfDCRlcpOnTU4AJzbxK8Qtae/w4e4czAPV2SvK
         +6I+nnYA53fBK6dM4Z6T8Op2DAgoc7La8FTLRFbE7tahS+Jj+v+fPRn8bWYANC7cJSnc
         zwuMzJHWo/9ii2BElyg3HNv9L1YrpNYTz83RkonKXvvQXpUPIus8IRdbxcgyFHbI85xm
         HyIl5BlEIVYQx6rYt2HrwVLsTpmF8TMDAB20Am6za25Qy6nd0QH1gO+PAHsqFkWSRj4W
         gu83JTU963AgC40cDTWMymlAVMPH/3Y8qL+wvX3QxdPBwiUUSdUBphZcJwpnM0F/1CWs
         nSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=miU+viOw7qa7tyRJ4Or3oAz5OewEcwcrhnBCcmhlJME=;
        b=4wSciYBpzwRCmgyqXcUimDU/Za8dXtPNNMjqk7H+4N34ebhiG0+HMEdhvaOR8AE/UU
         qS/3M2nhBkJTjY93I++KPI5i41fee+Al9Jth5gdv0x4hblr77YtqhMXihbs38F7d6yQW
         EJBcdJExzLG5lqR+qSR+/12gBpWe0URQQLw3o7hzFj5K2JYBNGizIyPgzpfss0/TnJUF
         wjvCOXjNtyNYYOiMrFCvMpm3bwZw4vV/c31IhJVP1tUH/lr3lMrqKkPqXKV/t5Z7phNF
         kEZ+FGGenlKXZYUlLH2ei1K5SzXWaJrrv3uxG7G5rdRhFRltaZ2mdWagMRGXAD+yNx4n
         uQMA==
X-Gm-Message-State: ACgBeo1vOwSxIItS/Z3aDdk+ffrA+As06dNdzKATjbABpxaePYPfbIWy
        dgjvvJrFnUHXgjJFO93JrGTv+MzBmHg5GM3t04tZ6Q==
X-Google-Smtp-Source: AA6agR57llNlr+vc/ZVT6e21cf6KHtYpIX6piWQlP7J6Ta4z5TBzfSbQtMPHvfFUwcQ/ozpxKb9IwDD+Gqf8hXDfIC4=
X-Received: by 2002:a25:424a:0:b0:6a9:2954:87fd with SMTP id
 p71-20020a25424a000000b006a9295487fdmr12134434yba.340.1662740719262; Fri, 09
 Sep 2022 09:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-16-surenb@google.com>
 <83a36761-2045-3f46-3088-a751c5263b81@linux.ibm.com>
In-Reply-To: <83a36761-2045-3f46-3088-a751c5263b81@linux.ibm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Sep 2022 09:25:08 -0700
Message-ID: <CAJuCfpHoGFv=mRfjsXpFn6Ykwc_SubfL1333Cz-HHYaoiD_73w@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 15/28] mm/mmap: mark adjacent VMAs as locked if
 they can grow into unmapped area
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

On Fri, Sep 9, 2022 at 6:43 AM Laurent Dufour <ldufour@linux.ibm.com> wrote=
:
>
> Le 01/09/2022 =C3=A0 19:35, Suren Baghdasaryan a =C3=A9crit :
> > While unmapping VMAs, adjacent VMAs might be able to grow into the area
> > being unmapped. In such cases mark adjacent VMAs as locked to prevent
> > this growth.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/mmap.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index b0d78bdc0de0..b31cc97c2803 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2680,10 +2680,14 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm=
, struct vm_area_struct *vma,
> >        * VM_GROWSUP VMA. Such VMAs can change their size under
> >        * down_read(mmap_lock) and collide with the VMA we are about to =
unmap.
> >        */
> > -     if (vma && (vma->vm_flags & VM_GROWSDOWN))
> > +     if (vma && (vma->vm_flags & VM_GROWSDOWN)) {
> > +             vma_mark_locked(vma);
> >               return false;
> > -     if (prev && (prev->vm_flags & VM_GROWSUP))
> > +     }
> > +     if (prev && (prev->vm_flags & VM_GROWSUP)) {
> > +             vma_mark_locked(prev);
> >               return false;
> > +     }
> >       return true;
> >  }
> >
>
> That looks right to be.
>
> But, in addition to that, like the previous patch, all the VMAs to be
> detached from the tree in the loop above, should be marked locked just
> before calling vm_rb_erase().

The following call chain already locks the VMA being isolated:
vma_rb_erase->vma_rb_erase_ignore->__vma_rb_erase->vma_mark_locked
