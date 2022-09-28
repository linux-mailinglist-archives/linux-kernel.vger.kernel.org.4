Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35FD5ED30A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiI1C3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiI1C24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:28:56 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9618910AB30
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:28:54 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-346cd4c3d7aso117605697b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Z0+bMELpdKdE8Q7V1g1xJPLf4JnpkgWuSB4HVsFpACw=;
        b=r3bKcW8YDyjLKKVV2T2nu9EK+l6skZKjuSXHqw1h7QSsCWuzjJLZSSPbPLqCkYLzuE
         srxL4E7bdabGQ54uivxtXo6aVslalhWzKnRB3ME9ODMXpkyi1jEarxBh3NdA34ePCygI
         1Lr3QhYYbCrQxYg+RD5l5rVH3u4LZRTUbQOjBHMe6Udu2afMMcUdFBQFGDW0FxigAg8O
         XPKvUjM4Q/CEzJnptfAVyGJG2I2t7f4KgpKYO65hCzHnmx7eNrxdV39FhGX4toQIRrGb
         38ZkEbv55Ye2BtH0b1tKVQ30lEB+ClAg4hKd3nwJkVNLlBsG6At6ipXEoz4LKLfj6HTS
         GbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Z0+bMELpdKdE8Q7V1g1xJPLf4JnpkgWuSB4HVsFpACw=;
        b=v1SKovyr82Fc2rSo74pXYLZvT2n3rp6VVk/3jj58tXCZxyY8bCIY0rOfYgoknZ6PPN
         hqE7QzBpTGuGtxAT5rStQBukz4Vantw9t/brRIvlxEzBma68QUroycVP89bw/wACuS0h
         QQNUD2hJUfk+0GnBsGguSPuY4+gT+IhCaGgbj/Q40kn8IB1rFV/WoG1AZ7qLo3Ts/Ghz
         kfwDpqtBt6gela/U+Sa1xNxJy4Fn8k1MhoEPPd9/msGbOXtGcKO30OJtOoRnuRs+AVn6
         w64p8VvgxpkX+7LmcMyr6Ow0jFfwJFnu11chG4kQ6w+R2kXFx0elT9xlj09f5eJ26PIg
         kObw==
X-Gm-Message-State: ACrzQf0DnpNKgqW9men2TDEY0DN3453ulqzSCOyLZuCJGsEOPYPVgcDl
        +BETFJJBydKmekp7TY/l9qu6mOj4bkqj5ecR0IuJ4Q==
X-Google-Smtp-Source: AMsMyM7cKmM6s5Wj2EGqGts0HQF0PxKwiB/suSdXFthaiHYdD52M0dUUPdTaFJmVGmtRhNHzLoZ6tTNAnTCaRpIdjiM=
X-Received: by 2002:a0d:ef84:0:b0:352:9e0d:a596 with SMTP id
 y126-20020a0def84000000b003529e0da596mr3923448ywe.347.1664332133583; Tue, 27
 Sep 2022 19:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901205819.emxnnschszqv4ahy@moria.home.lan>
 <CAJuCfpGNcZovncozo+Uxfhjwqh3BtGXsws+4QeT6Zy1mcQRJbQ@mail.gmail.com> <b5db3353-8aae-22d8-9598-eaa5eeb77cfc@suse.cz>
In-Reply-To: <b5db3353-8aae-22d8-9598-eaa5eeb77cfc@suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Sep 2022 19:28:42 -0700
Message-ID: <CAJuCfpEcTv5crNumhMTCf2yAJ5+86ph78-B+eyk_N84Ce=nr5w@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 00/28] per-VMA locks proposal
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Jerome Glisse <jglisse@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, dhowells@redhat.com,
        Hugh Dickins <hughd@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Minchan Kim <minchan@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
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

On Sun, Sep 11, 2022 at 2:35 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 9/2/22 01:26, Suren Baghdasaryan wrote:
> > On Thu, Sep 1, 2022 at 1:58 PM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> >>
> >> On Thu, Sep 01, 2022 at 10:34:48AM -0700, Suren Baghdasaryan wrote:
> >> > Resending to fix the issue with the In-Reply-To tag in the original
> >> > submission at [4].
> >> >
> >> > This is a proof of concept for per-vma locks idea that was discussed
> >> > during SPF [1] discussion at LSF/MM this year [2], which concluded w=
ith
> >> > suggestion that =E2=80=9Ca reader/writer semaphore could be put into=
 the VMA
> >> > itself; that would have the effect of using the VMA as a sort of ran=
ge
> >> > lock. There would still be contention at the VMA level, but it would=
 be an
> >> > improvement.=E2=80=9D This patchset implements this suggested approa=
ch.
> >> >
> >> > When handling page faults we lookup the VMA that contains the faulti=
ng
> >> > page under RCU protection and try to acquire its lock. If that fails=
 we
> >> > fall back to using mmap_lock, similar to how SPF handled this situat=
ion.
> >> >
> >> > One notable way the implementation deviates from the proposal is the=
 way
> >> > VMAs are marked as locked. Because during some of mm updates multipl=
e
> >> > VMAs need to be locked until the end of the update (e.g. vma_merge,
> >> > split_vma, etc). Tracking all the locked VMAs, avoiding recursive lo=
cks
> >> > and other complications would make the code more complex. Therefore =
we
> >> > provide a way to "mark" VMAs as locked and then unmark all locked VM=
As
> >> > all at once. This is done using two sequence numbers - one in the
> >> > vm_area_struct and one in the mm_struct. VMA is considered locked wh=
en
> >> > these sequence numbers are equal. To mark a VMA as locked we set the
> >> > sequence number in vm_area_struct to be equal to the sequence number
> >> > in mm_struct. To unlock all VMAs we increment mm_struct's seq number=
.
> >> > This allows for an efficient way to track locked VMAs and to drop th=
e
> >> > locks on all VMAs at the end of the update.
> >>
> >> I like it - the sequence numbers are a stroke of genuius. For what it'=
s doing
> >> the patchset seems almost small.
> >
> > Thanks for reviewing it!
> >
> >>
> >> Two complaints so far:
> >>  - I don't like the vma_mark_locked() name. To me it says that the cal=
ler
> >>    already took or is taking the lock and this function is just markin=
g that
> >>    we're holding the lock, but it's really taking a different type of =
lock. But
> >>    this function can block, it really is taking a lock, so it should s=
ay that.
> >>
> >>    This is AFAIK a new concept, not sure I'm going to have anything go=
od either,
> >>    but perhaps vma_lock_multiple()?
> >
> > I'm open to name suggestions but vma_lock_multiple() is a bit
> > confusing to me. Will wait for more suggestions.
>
> Well, it does act like a vma_write_lock(), no? So why not that name. The
> checking function for it is even called vma_assert_write_locked().
>
> We just don't provide a single vma_write_unlock(), but a
> vma_mark_unlocked_all(), that could be instead named e.g.
> vma_write_unlock_all().
> But it's called on a mm, so maybe e.g. mm_vma_write_unlock_all()?

Thank you for your suggestions, Vlastimil! vma_write_lock() sounds
good to me. For vma_mark_unlocked_all() replacement, I would prefer
vma_write_unlock_all() which keeps the vma_write_XXX naming pattern to
indicate that these are operating on the same locks. If the fact that
it accepts mm_struct as a parameter is an issue then maybe
vma_write_unlock_mm() ?

>
>
