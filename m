Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2776F66E6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjAQTar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjAQTTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:19:04 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C5F4391D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:31:58 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4a263c4ddbaso435496847b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hTLKMGXMSAT6MMmNyJi78XQQyP4rpea0yj1IeoSeHZk=;
        b=cYvU74tR9mP6Fn9b7plkY3/qUjiSWAQ8Nqo6zWa89Tvw3EfblIo+iwk47g313J50zD
         OI4yi6Ydglcj6heTHBV+OqDdwSJdnr4wqTbrPmLmh9mqThWV5UYKM05VFEyTkYkAXo3j
         QMlnnmbDe/lKf1GxHO5kvU0IsXr+gApsS4fTkOq58OZbDpcCBOXxdRO1KDTxZLEelrTC
         m1K0eNZmldk1GQtixeCW1w6HH+dj9szNi1qhHJcN/MOVBP2CYZjpyXxYNkaGlkAf0JZG
         TY6bU4vvOEanEihNcw0eqEUfw/p+tEb9UMV8eQ3gmuV1CSkeyLzVwMRJSYmZhbCyUoWj
         hjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTLKMGXMSAT6MMmNyJi78XQQyP4rpea0yj1IeoSeHZk=;
        b=oThYYxT6RQBiU9HqUr4s3KBH5Jh9vlc/AladuyPZqUr8SPIk1Ce4I7Cc3ZAXYL2JH0
         McBkZY1lt0oqZRi+eMIKbtgmpW3GUzg2JqrSFFvcJd6yreBXbXA52mCIKxTJwfs1jXGC
         CGGJbZl3ifcgMjeeXxp3/NzEVbRfKsDqe9z9gMpsYhtiOWle2MJfaoGnM/NtQiximafJ
         d6f7n5FI1VrIWWoqMDOkhYiBCwrwg+yh3o/2AQ+fpT1Ychv632DvElEKvEGdSvqSCoSx
         Nr0PBMZAHCnt5ccdc7HloDt9dyh5csomlEWNrZzOZQ9MC8EEOBB49ncp1a3Yh0hTknSs
         4Ztw==
X-Gm-Message-State: AFqh2kpKLT0GB4eQoEbSUlDhgj2rk7rs/+YmagRB3nqvGT6XzT0gXRWn
        G8MBwDNYuDx/9jVEY5aKuYSDIsRVhg4qhRrCdRbR2g==
X-Google-Smtp-Source: AMrXdXs6T2EsIuWbVNsgZ9FO4pipeSzz0cOT2UbbLv043lEgdSZy2eMw0rqySTLBWnP8z9Z1+X2S15P7ragQaUTzb4Q=
X-Received: by 2002:a81:1d2:0:b0:433:f1c0:3f1c with SMTP id
 201-20020a8101d2000000b00433f1c03f1cmr558134ywb.438.1673980317150; Tue, 17
 Jan 2023 10:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-42-surenb@google.com> <20230116140649.2012-1-hdanton@sina.com>
 <CAJuCfpHoHcZxQZgt4Ki1kiBu9O+sANZQambOa+1gSQu2brPoyA@mail.gmail.com>
 <20230117031632.2321-1-hdanton@sina.com> <CAJuCfpFq23m-KYKaDoCS2K2aM8rO7j8aPa0nVPs-_xP2Sf6GGg@mail.gmail.com>
 <20230117083355.2374-1-hdanton@sina.com> <CAJuCfpGU3c102mLZBY6UzkbW-DtfpYF77wLgzFpRWagBw8XfMQ@mail.gmail.com>
 <Y8bodcnhyMox+QjG@casper.infradead.org>
In-Reply-To: <Y8bodcnhyMox+QjG@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 10:31:46 -0800
Message-ID: <CAJuCfpHU2WPHU1-9m3mnS6i3Od_kVE+P23nqvWDo1+kkh00M8Q@mail.gmail.com>
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net,
        peterz@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Tue, Jan 17, 2023 at 10:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jan 17, 2023 at 10:21:28AM -0800, Suren Baghdasaryan wrote:
> > static inline bool vma_read_trylock(struct vm_area_struct *vma)
> > {
> >        int count, new;
> >
> >         /* Check before locking. A race might cause false locked result. */
> >        if (READ_ONCE(vma->vm_lock->lock_seq) ==
> >            READ_ONCE(vma->vm_mm->mm_lock_seq))
> >                 return false;
> >
> >         count = atomic_read(&vma->vm_lock->count);
> >         for (;;) {
> >               /*
> >                * Is VMA is write-locked? Overflow might produce false
> > locked result.
> >                * False unlocked result is impossible because we modify and check
> >                * vma->vm_lock_seq under vma->vm_lock protection and
> > mm->mm_lock_seq
> >                * modification invalidates all existing locks.
> >                */
> >               if (count < 0)
> >                         return false;
> >
> >              new = count + 1;
> >              /* If atomic_t overflows, fail to lock. */
> >              if (new < 0)
> >                         return false;
> >
> >              /*
> >               * Atomic RMW will provide implicit mb on success to pair
> > with smp_wmb in
> >               * vma_write_lock, on failure we retry.
> >               */
> >               new = atomic_cmpxchg(&vma->vm_lock->count, count, new);
> >                 if (new == count)
> >                         break;
> >                 count = new;
> >                 cpu_relax();
>
> The cpu_relax() is exactly the wrong thing to do here.  See this thread:
> https://lore.kernel.org/linux-fsdevel/20230113184447.1707316-1-mjguzik@gmail.com/

Thanks for the pointer, Matthew. I think we can safely remove
cpu_relax() since it's unlikely the count is constantly changing under
a reader.

>
