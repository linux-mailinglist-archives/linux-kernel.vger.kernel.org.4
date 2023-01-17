Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F03670C23
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjAQWvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjAQWuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:50:20 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60863B0C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:33:20 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4b718cab0e4so443879367b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l6Pu7+4aPnAnLv5bWCRJUVspIRgH9CCgCfRjxyIMzEU=;
        b=WXapkaaU4Iq6lFD3/jgzkfqjRX6r4ZbOdG53AqnSWkJqcj+NABq+nFQQ97h3/iDE4W
         Za0ialnTuq4r2yl1WpFAAX2CMaDZ9tJyVM1HDZmoCBeJpFIJUuVXTFCHRRFAc3POaO1X
         y1PPSFI4MOlhK4eGFhPMSua/cuf4D+PEZjgBkV413b3KBeTpOuLyAIsaZKslzIbmFUMe
         k7vQoybQvOGIqXEwEFhsURvnlRThGcGKTRI8uwhgN9T+niHiObTfbgU32joQ07OrF3k1
         kOpzjvFCBeIneShTfDzdhfIhRUdsEtGGvd2zanDGDf1gk/nIkJI9tGKmQ4HePeYjEUfm
         ACMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6Pu7+4aPnAnLv5bWCRJUVspIRgH9CCgCfRjxyIMzEU=;
        b=lQ3KTDgFn48WigQTbeu2aVJk2SM2p8r8aVoQeEjY7TJE1H78j0OG6atgOCZtafWPz4
         5F41IxOZAG00nrMeaHyz0h1fqh/TuRS1LqWXf6jnL7CAt1nox7Jsl50GXORoHOUhW1og
         CwooiJ0ovmHGpPQYfBNd+0Ru7V6OVZA5bSTiboL2Rfkwq1JDVee74qtyyldn45YpYl95
         KX7YjCJfyKR393K9Y97rNXtReWfDAvt+e/qODvkWKJCV9CPl2gJZW6SDijMkNLeiN5HI
         9pRmEz5tng4TRU4DHMKLi763TMLjuv6vmHh9/gaYz+gFAxjE+VIb4LRMqvDae2tazCKp
         DMQg==
X-Gm-Message-State: AFqh2krkG772yevhpnQoBA5sjN7003B2uFz3C78zSzeRuHBigY+sGdZW
        fQK8vzfv7bLBtAv2h2xvcIsev9ORPteP+Y2RutJG9A==
X-Google-Smtp-Source: AMrXdXtPEWGhfFtAZyaB6FCmy/ElQF0QS8mVbjf/1PWGddpXj66ZQtHOzMYnavA7o2Coxw4Jydy4LOOdnf1j6/Ecn7I=
X-Received: by 2002:a0d:d484:0:b0:4dc:4113:f224 with SMTP id
 w126-20020a0dd484000000b004dc4113f224mr688104ywd.455.1673994799864; Tue, 17
 Jan 2023 14:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-13-surenb@google.com>
 <Y8a4+bV1dYNAiUkD@dhcp22.suse.cz> <Y8a66gshQkkhC1cT@dhcp22.suse.cz>
 <CAJuCfpF2ciMbMFgqa4GqYqg8zjpnmBoNZDG23V0+w017LXeU3w@mail.gmail.com> <Y8cZMt01Z1FvVFXh@casper.infradead.org>
In-Reply-To: <Y8cZMt01Z1FvVFXh@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 14:33:08 -0800
Message-ID: <CAJuCfpEV_-=19KWqXvYO4-VgUDwgpkT2xDC4zTZ-XS4iaSH=Qw@mail.gmail.com>
Subject: Re: [PATCH 12/41] mm: add per-VMA lock and helper functions to
 control it
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
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

On Tue, Jan 17, 2023 at 1:54 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jan 17, 2023 at 01:21:47PM -0800, Suren Baghdasaryan wrote:
> > On Tue, Jan 17, 2023 at 7:12 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 17-01-23 16:04:26, Michal Hocko wrote:
> > > > On Mon 09-01-23 12:53:07, Suren Baghdasaryan wrote:
> > > > > Introduce a per-VMA rw_semaphore to be used during page fault handling
> > > > > instead of mmap_lock. Because there are cases when multiple VMAs need
> > > > > to be exclusively locked during VMA tree modifications, instead of the
> > > > > usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
> > > > > exclusively and setting vma->lock_seq to the current mm->lock_seq. When
> > > > > mmap_write_lock holder is done with all modifications and drops mmap_lock,
> > > > > it will increment mm->lock_seq, effectively unlocking all VMAs marked as
> > > > > locked.
> > > >
> > > > I have to say I was struggling a bit with the above and only understood
> > > > what you mean by reading the patch several times. I would phrase it like
> > > > this (feel free to use if you consider this to be an improvement).
> > > >
> > > > Introduce a per-VMA rw_semaphore. The lock implementation relies on a
> > > > per-vma and per-mm sequence counters to note exclusive locking:
> > > >         - read lock - (implemented by vma_read_trylock) requires the the
> > > >           vma (vm_lock_seq) and mm (mm_lock_seq) sequence counters to
> > > >           differ. If they match then there must be a vma exclusive lock
> > > >           held somewhere.
> > > >         - read unlock - (implemented by vma_read_unlock) is a trivial
> > > >           vma->lock unlock.
> > > >         - write lock - (vma_write_lock) requires the mmap_lock to be
> > > >           held exclusively and the current mm counter is noted to the vma
> > > >           side. This will allow multiple vmas to be locked under a single
> > > >           mmap_lock write lock (e.g. during vma merging). The vma counter
> > > >           is modified under exclusive vma lock.
> > >
> > > Didn't realize one more thing.
> > >             Unlike standard write lock this implementation allows to be
> > >             called multiple times under a single mmap_lock. In a sense
> > >             it is more of mark_vma_potentially_modified than a lock.
> >
> > In the RFC it was called vma_mark_locked() originally and renames were
> > discussed in the email thread ending here:
> > https://lore.kernel.org/all/621612d7-c537-3971-9520-a3dec7b43cb4@suse.cz/.
> > If other names are preferable I'm open to changing them.
>
> I don't want to bikeshed this, but rather than locking it seems to be
> more:
>
>         vma_start_read()
>         vma_end_read()
>         vma_start_write()
>         vma_end_write()
>         vma_downgrade_write()

Couple corrections, we would have to have vma_start_tryread() and
vma_end_write_all(). Also there is no vma_downgrade_write().
mmap_write_downgrade() simply does vma_end_write_all().

>
> ... and that these are _implemented_ with locks (in part) is an
> implementation detail?
>
> Would that reduce people's confusion?
>
> > >
> > > >         - write unlock - (vma_write_unlock_mm) is a batch release of all
> > > >           vma locks held. It doesn't pair with a specific
> > > >           vma_write_lock! It is done before exclusive mmap_lock is
> > > >           released by incrementing mm sequence counter (mm_lock_seq).
> > > >       - write downgrade - if the mmap_lock is downgraded to the read
> > > >         lock all vma write locks are released as well (effectivelly
> > > >         same as write unlock).
> > > --
> > > Michal Hocko
> > > SUSE Labs
