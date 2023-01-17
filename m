Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB566E74E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjAQT56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbjAQTzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:55:42 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0D015544
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:49:49 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4d13cb4bbffso315303337b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iz0GQ7/w+mu6oDV5bKCsXpIO0gDrI/zJCZBxc6dizOg=;
        b=p5fs5mLSVpER0JzqnFPms6ksIHjMhLnm0fGre8E+U/jXlE/W8pYmcWl5PGr886PDTB
         CCtdYmfgkYM4JMRjESQanIWyjIXlWHd/PxJFHITaVdlfn58FQ+NW2Zko5H4cXnDNBWke
         B565WEhHRxl6a6x1P63VIIsrRmgO45GgxGY3ttWlZkSOOq/tHi+ZkQ7B774p7YBhqesy
         u9cHULCi5YYM0ERasMFJ406wprrlp7om3hAtpCSPuwVEYfi6fMljV2/XAdpKw5OWsFJm
         yhC71JdRdTRRBJm9wugmwnlk8Z9bibkosJiO3CiDBD5UQ4mwnK82JkF8Too4UeebtXG7
         Ckmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iz0GQ7/w+mu6oDV5bKCsXpIO0gDrI/zJCZBxc6dizOg=;
        b=VzdUKtMn4n8NVY7iUo74p1ewBvm2c1ks/ZzqeQi5eYUv7cxiIj/2kFMPfZtML9H3HY
         RylTEQdISrHvVHgHoVZLwWk5RoN7demvWkkYVNIIR2tIB0HySTr+9sQRD2Jc2iJVEwj9
         EUjGIjpXMPNXKSrjoV0BI6gBrtovuCXdyhLl+OAKS5FtNxLImhsmMLLkIyA+PR+unKFB
         kdVdQJCH12V1FCwitFAsZ5ARP9QvJl8n2XvLP7wT2djdqaI2r4Hzb7VTrBOJch1cj1cf
         NIfwz7IAKmLSOCfoEaQn7mfdM2OppIWKAbKphCdGYzcSaczq3TvdOhn0kcFDmB6PQUik
         8bAw==
X-Gm-Message-State: AFqh2kq788ayFDhV4thIQpnAfoV+t7Yn5j04dUIQby1htQOlVcFK0YxG
        wMlh19CyGvIshtsLLRfoXEomse5gi7qv9hoyJboRsQ==
X-Google-Smtp-Source: AMrXdXvI+MOkNBHOikckkXfQawDP5Ir9tQ5z55WvACj8+QlkWO3+VNjLWrjFnu2fznZ7jncOPRR0JlSu1xdrpp+UO5Y=
X-Received: by 2002:a81:784c:0:b0:4e1:5013:6da1 with SMTP id
 t73-20020a81784c000000b004e150136da1mr617572ywc.218.1673981388803; Tue, 17
 Jan 2023 10:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-42-surenb@google.com>
 <CAG48ez3ZNt+B3XvAMP1OaeEYuwpXJ1epmT9YtNonFLEJ6yANVQ@mail.gmail.com>
 <CAJuCfpFruHecz9NssGGFrG-RqbJFHCfRuZ7c6GbTBD4x4AU8aA@mail.gmail.com>
 <Y8bpfzYvWq/3ttr+@casper.infradead.org> <CAG48ez0ScQMc_5Ch-d63pX4vT6L7=peQjnpneooGcXfyddXc8A@mail.gmail.com>
In-Reply-To: <CAG48ez0ScQMc_5Ch-d63pX4vT6L7=peQjnpneooGcXfyddXc8A@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 10:49:37 -0800
Message-ID: <CAJuCfpF3R_cggziBkfsccmgSoQoF3mqppov67jpBhtpStyhyTQ@mail.gmail.com>
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
To:     Jann Horn <jannh@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, liam.howlett@oracle.com, peterz@infradead.org,
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

On Tue, Jan 17, 2023 at 10:36 AM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Jan 17, 2023 at 7:31 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Jan 17, 2023 at 10:26:32AM -0800, Suren Baghdasaryan wrote:
> > > On Tue, Jan 17, 2023 at 10:12 AM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > On Mon, Jan 9, 2023 at 9:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > rw_semaphore is a sizable structure of 40 bytes and consumes
> > > > > considerable space for each vm_area_struct. However vma_lock has
> > > > > two important specifics which can be used to replace rw_semaphore
> > > > > with a simpler structure:
> > > > [...]
> > > > >  static inline void vma_read_unlock(struct vm_area_struct *vma)
> > > > >  {
> > > > > -       up_read(&vma->vm_lock->lock);
> > > > > +       if (atomic_dec_and_test(&vma->vm_lock->count))
> > > > > +               wake_up(&vma->vm_mm->vma_writer_wait);
> > > > >  }
> > > >
> > > > I haven't properly reviewed this, but this bit looks like a
> > > > use-after-free because you're accessing the vma after dropping your
> > > > reference on it. You'd have to first look up the vma->vm_mm, then do
> > > > the atomic_dec_and_test(), and afterwards do the wake_up() without
> > > > touching the vma. Or alternatively wrap the whole thing in an RCU
> > > > read-side critical section if the VMA is freed with RCU delay.
> > >
> > > vm_lock->count does not control the lifetime of the VMA, it's a
> > > counter of how many readers took the lock or it's negative if the lock
> > > is write-locked.
> >
> > Yes, but ...
> >
> >         Task A:
> >         atomic_dec_and_test(&vma->vm_lock->count)
> >                         Task B:
> >                         munmap()
> >                         write lock
> >                         free VMA
> >                         synchronize_rcu()
> >                         VMA is really freed
> >         wake_up(&vma->vm_mm->vma_writer_wait);
> >
> > ... vma is freed.
> >
> > Now, I think this doesn't occur.  I'm pretty sure that every caller of
> > vma_read_unlock() is holding the RCU read lock.  But maybe we should
> > have that assertion?
>
> I don't see that. When do_user_addr_fault() is calling
> vma_read_unlock(), there's no RCU read lock held, right?

We free VMAs using call_rcu() after removing them from VMA tree. OTOH
page fault handlers are searching for VMAs from inside RCU read
section and calling vma_read_unlock() from there, see
https://lore.kernel.org/all/20230109205336.3665937-29-surenb@google.com/.
Once we take the VMA read-lock, it ensures that it can't be
write-locked and if someone is destroying or isolating the VMA, it
needs to write-lock it first.
