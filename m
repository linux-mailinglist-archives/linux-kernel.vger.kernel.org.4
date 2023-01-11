Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C81A66607E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjAKQan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbjAKQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:29:49 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1635C4A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:29:01 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4a2f8ad29d5so201728137b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Lr8tSm6MqUPgF/LWfHDA9iNzXlwa0xD0GVdK5cZd9g=;
        b=Yzh3gZKn1mLa2Za1k9SYRxbcKca9L17S5JQFl3qF9blmNHMcuOBgj4kMQW7wplK6Lx
         e8zBR6KI/RCHR++bGrQjGNn9B4FFj/zDTtccI3A0ugVo6eZmh4MPBQ2aGoOno0fhGxHl
         XjSlsW50U1m7j2YKUXjIDerEEAjp1e6UR8rEeqNUlp5Y5hg5hABLOUW+1+WYMuW+wjLD
         P6i3bApuhlQn2xaOuXEWwh7+Hr3Bhk7riQ8Ggwa18xpE6h0rgfqlX7mjzO50d0PlgXLA
         xih+3oKx3c2hbNzmL+L4GpJpGcz1WIyS/pKI84+Dlxo53T9P+/2BNhkVLDIOei55vmrr
         Vozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Lr8tSm6MqUPgF/LWfHDA9iNzXlwa0xD0GVdK5cZd9g=;
        b=co8FyctxYlUoH/C/xPnQT8xDCS0HPoiFZoQp1pPhB2fYNa7ldDpYF5olZPSvPYH/zu
         HM+FJWyP8ZaQ1zegJ4dgLrrFbp48KGWkxhoFdXxD0MVOFftNMoENsimBofoyz0iGnIrZ
         9YyA2ItPaChElqZChG7N3/SvcxcSotvdsU9AQP+xmvAdDxXr5py7goJQKF3dDxGEV6ld
         722zUlyIkXX5YrDv78e+aRNxp/GSzXWXZKOTdOWsr1U6gzrgguh/uuctXu7INAaXSwHq
         w8MEOI7Dhzv3QpSshXLM2V31IO6Wa5TI4HfOg7B/hUlj+iGOYsWBXpFExD48DSV+WsEC
         nfZA==
X-Gm-Message-State: AFqh2kquh6whfWOF1FGal2ZIQSLR9nOPCO/kHPZiJgNfgs35XuvMzp2d
        8o6Q0IuLBbceTapxa+NDMNPh8OlAbi/lweOanhkwRA==
X-Google-Smtp-Source: AMrXdXvLgK6W7lAuuCYwgiArrtAg97gzYPQSMPDbpaiV/C+O44LDuwgcKcWpyW8gYaBkcIY/p7HDYgSic7XqJ1wpyfU=
X-Received: by 2002:a81:190a:0:b0:3dc:fd91:ef89 with SMTP id
 10-20020a81190a000000b003dcfd91ef89mr2162583ywz.347.1673454540467; Wed, 11
 Jan 2023 08:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-9-surenb@google.com>
 <20230111001331.cxdeh52vvta6ok2p@offworld> <CAJuCfpEv--awCY0=R3h5Fez8x74U1EZCzNkq4_7deCYqej5sSA@mail.gmail.com>
 <Y75x5fGPcJ63pBIp@dhcp22.suse.cz> <Y76HTfIeEt8ZOIH3@gmail.com> <6be809f5554a4faaa22c287ba4224bd0@AcuMS.aculab.com>
In-Reply-To: <6be809f5554a4faaa22c287ba4224bd0@AcuMS.aculab.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 11 Jan 2023 08:28:49 -0800
Message-ID: <CAJuCfpH_VZq99=vGQGJ+evVg5wMPKGsjyawgHnOeoKhtEiAi6w@mail.gmail.com>
Subject: Re: [PATCH 08/41] mm: introduce CONFIG_PER_VMA_LOCK
To:     David Laight <David.Laight@aculab.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        "michel@lespinasse.org" <michel@lespinasse.org>,
        "joelaf@google.com" <joelaf@google.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "leewalsh@google.com" <leewalsh@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "jglisse@google.com" <jglisse@google.com>,
        "punit.agrawal@bytedance.com" <punit.agrawal@bytedance.com>,
        "arjunroy@google.com" <arjunroy@google.com>,
        "minchan@google.com" <minchan@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "gurua@google.com" <gurua@google.com>,
        "laurent.dufour@fr.ibm.com" <laurent.dufour@fr.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "soheil@google.com" <soheil@google.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "gthelen@google.com" <gthelen@google.com>,
        "ldufour@linux.ibm.com" <ldufour@linux.ibm.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "posk@google.com" <posk@google.com>,
        "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "peterjung1337@gmail.com" <peterjung1337@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
        "hughlynch@google.com" <hughlynch@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tatashin@google.com" <tatashin@google.com>
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

On Wed, Jan 11, 2023 at 2:03 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Ingo Molnar
> > Sent: 11 January 2023 09:54
> >
> > * Michal Hocko <mhocko@suse.com> wrote:
> >
> > > On Tue 10-01-23 16:44:42, Suren Baghdasaryan wrote:
> > > > On Tue, Jan 10, 2023 at 4:39 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
> > > > >
> > > > > On Mon, 09 Jan 2023, Suren Baghdasaryan wrote:
> > > > >
> > > > > >This configuration variable will be used to build the support for VMA
> > > > > >locking during page fault handling.
> > > > > >
> > > > > >This is enabled by default on supported architectures with SMP and MMU
> > > > > >set.
> > > > > >
> > > > > >The architecture support is needed since the page fault handler is called
> > > > > >from the architecture's page faulting code which needs modifications to
> > > > > >handle faults under VMA lock.
> > > > >
> > > > > I don't think that per-vma locking should be something that is user-configurable.
> > > > > It should just be depdendant on the arch. So maybe just remove CONFIG_PER_VMA_LOCK?
> > > >
> > > > Thanks for the suggestion! I would be happy to make that change if
> > > > there are no objections. I think the only pushback might have been the
> > > > vma size increase but with the latest optimization in the last patch
> > > > maybe that's less of an issue?
> > >
> > > Has vma size ever been a real problem? Sure there might be a lot of those
> > > but your patch increases it by rwsem (without the last patch) which is
> > > something like 40B on top of 136B vma so we are talking about 400B in
> > > total which even with wild mapcount limits shouldn't really be
> > > prohibitive. With a default map count limit we are talking about 2M
> > > increase at most (per address space).
> > >
> > > Or are you aware of any specific usecases where vma size is a real
> > > problem?

Well, when fixing the cacheline bouncing problem in the initial design
I was adding 44 bytes to 152-byte vm_area_struct (CONFIG_NUMA enabled)
and pushing it just above 192 bytes while allocating these structures
from cache-aligned slab (keeping the lock in a separate cacheline to
prevent cacheline bouncing). That would use the whole 256 bytes per
VMA and it did make me nervous. The current design with no need to
cache-align vm_area_structs and with 44-byte overhead trimmed down to
16 bytes seems much more palatable.

> >
> > 40 bytes for the rwsem, plus the patch also adds a 32-bit sequence counter:
> >
> >   + int vm_lock_seq;
> >   + struct rw_semaphore lock;
> >
> > So it's +44 bytes.

Correct.

>
> Depend in whether vm_lock_seq goes into a padding hole or not
> it will be 40 or 48 bytes.
>
> But if these structures are allocated individually (not an array)
> then it depends on how may items kmalloc() fits into a page (or 2,4).

Yep. Depends on how we arrange the fields.

Anyhow. Sounds like the overhead of the current design is small enough
to remove CONFIG_PER_VMA_LOCK and let it depend only on architecture
support?
Thanks,
Suren.

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
