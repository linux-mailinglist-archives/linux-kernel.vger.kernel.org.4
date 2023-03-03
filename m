Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96896A8ECA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCCBes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCCBeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:34:46 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C441556E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:34:45 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-536bbe5f888so15986637b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 17:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677807284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TciFh9FdyF3mrNIuO70cM61gX9uwhyReNw+Gw2pRUPA=;
        b=Fu9U55wxTCLtEXaKgOYnyEQH6o/knLUeIWIORmIAitVZwfQOux0uTJ7B66Lcq0ckLn
         DnaiYkrXI1vYlCgghAucupoHiJLokhAsINv3RZQOUyxdPAalX4v/jrQ0u6/kLfDotIq9
         fLpMNArb7teZwLpvE7yeMPSDWGi9TR9ae2CG3WWhAqSW7EINvX/f7irqODYobdS+zhBJ
         a7ooWCbNGLmh3/Gc2gFtAmGd5kUxNiekAbwj6joc0NC1oS5J6bD3OPBdhvO9gsTQ0ite
         jNjMWQ4waHcWsNugjOXd04kipv5Kdf3uEMBA3Jbr551AWQN/ktqXyvrMm6S4Ke4LZV0c
         2yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677807284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TciFh9FdyF3mrNIuO70cM61gX9uwhyReNw+Gw2pRUPA=;
        b=FFqyMHsyx7pD/voKlExEsd/+SsbHYZkpLszACkTgw1DP0TPCmQXUKYWG/MMwIRWDor
         33J4RbhyjZWfQ7X0XJp8SP3QuxvEXbREFT6Q7lPWOAgmXN76xRwUIrN+lLBlYnkQb3mf
         w2KR05sxLmWYDsWyDfVV8+a7zpQNLGE4/IAIXo5LigOdbg2uIeYGHIex48UIzRMwQOmV
         74s95fvR5Y8HB3wOO5QQZDGngcAIUGnafcMt9spLrrGC2jG/V1OclMMkelDyRsvokaPI
         CDd708ovhwrx+d13Zf+nx56+7FNHlypUFh45uYpScMKJ4GC8xYNt+WmbB+C/FvLcNRw4
         0JEw==
X-Gm-Message-State: AO0yUKVSB/8/zoRwh8IRpnk0CTovyeGn5VhYICTywpuVqTRt/nvbP8AA
        xv//k4ZJCz/MTIxKLTbOIj6DFXA8Vlr9alO1iL/DlA==
X-Google-Smtp-Source: AK7set8EWcUQluqN8WKHq8/XSmKUp/RVBAW+c+8SuNyz0OuOQxujuvEHXp6QWVS8hEOwj7mZluNQW9cmwuljgEcX14A=
X-Received: by 2002:a81:ac51:0:b0:53c:6fda:b469 with SMTP id
 z17-20020a81ac51000000b0053c6fdab469mr4635252ywj.0.1677807284013; Thu, 02 Mar
 2023 17:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20230301190457.1498985-1-surenb@google.com> <31a88065-063a-727e-52fd-9fbc7d17fb5c@redhat.com>
In-Reply-To: <31a88065-063a-727e-52fd-9fbc7d17fb5c@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 2 Mar 2023 17:34:33 -0800
Message-ID: <CAJuCfpGKK5SwxQr_BKrqnn0ZeaLVtX=n31MbKUwdnSSd4umB3A@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/nommu: remove unnecessary VMA locking
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, dhowells@redhat.com, hughd@google.com,
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
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
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

On Thu, Mar 2, 2023 at 1:41=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 01.03.23 20:04, Suren Baghdasaryan wrote:
> > Since CONFIG_PER_VMA_LOCK depends on CONFIG_MMU, the changes in nommu
> > are not needed. Remove them.
> >
> > Fixes: bad94decd6a4 ("mm: write-lock VMAs before removing them from VMA=
 tree")
> > Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Link: https://lore.kernel.org/all/Y%2F8CJQGNuMUTdLwP@localhost/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> > Fix cleanly applies over mm-unstable, SHA in "Fixes" is from that tree.
> >
> >   mm/nommu.c | 5 -----
> >   1 file changed, 5 deletions(-)
> >
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index 2ab162d773e2..57ba243c6a37 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -588,7 +588,6 @@ static int delete_vma_from_mm(struct vm_area_struct=
 *vma)
> >                      current->pid);
> >               return -ENOMEM;
> >       }
> > -     vma_start_write(vma);
> >       cleanup_vma_from_mm(vma);
> >
> >       /* remove from the MM's tree and list */
> > @@ -1520,10 +1519,6 @@ void exit_mmap(struct mm_struct *mm)
> >        */
> >       mmap_write_lock(mm);
> >       for_each_vma(vmi, vma) {
> > -             /*
> > -              * No need to lock VMA because this is the only mm user a=
nd no
> > -              * page fault handled can race with it.
> > -              */
> >               cleanup_vma_from_mm(vma);
> >               delete_vma(mm, vma);
> >               cond_resched();
>
> So, i assume this should be squashed.

Yes, that would be best.

>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks1

>
>
> Just a general comment: usually, if review of the original series is
> still going on, it makes a lot more sense to raise such things in the
> original series so the author can fixup while things are still in
> mm-unstable. Once the series is in mm-stable, it's a different story. In
> that case, it is usually good to have the mail subjects be something
> like  "[PATCH mm-stable 1/1] ...".

Ok... For my education, do you mean the title of this patch should
somehow reflect that it should be folded into the original patch? Just
trying to understand the actionable item here. How would you change
this patch when posting for mm-unstable and for mm-stable?
Thanks,
Suren.

>
> --
> Thanks,
>
> David / dhildenb
>
