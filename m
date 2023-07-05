Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB08A748EF8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjGEUdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjGEUdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:33:39 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31DD1990
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:33:38 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so1939619276.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688589218; x=1691181218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1q7IeGvTepjJgfM/Bv0KzPttJZyBwk32UoGcJKZEp8=;
        b=E/oyqVJwy2MtpXYa7LrtYGSoRRZLuREVvN8UHHavBb7S3BzfCTIcQKWYpTe0q0DCE5
         jX++6+Jf7oYAfYMMxftW3i8trzP6LfWQyvQgud93bdJMZwZnkAY+WSqJ1dHzIQWje5XT
         O3kCqd7YVKtdYpwSrj5X5BzbqEIehHYoll8Jec5au/2nTDcem86kp/WBcIrzH226ltdH
         OF01kdAzwDPER5Dr6qXxADIEBvcU7TO/riyFa0Ho9ZJ6pSRl+F1uSy6NyjNX8RkMPURZ
         PY6FAKS6Ys4B4kzQzKFSbFefKr6SP41jEiOc/3TyBmT7XCNyd7imP4KclVGhcvZPcwl4
         8YGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688589218; x=1691181218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1q7IeGvTepjJgfM/Bv0KzPttJZyBwk32UoGcJKZEp8=;
        b=Q2u4FYajDHyDA3w8bC2Y92Z4/iBgEal92fgGPvCEEZxNsRy6g8fNq22NHVle2GOPZj
         biQhX+Se0+syNUEGQngAGvU5+B0VkzXP92xKEUgZNw90e2AfOmeVILfc0DUfPeDV0W66
         WD91eCMBwNUQJm1Av19eMbTUhe2XV8/tzK/XtWbLn/DtZ33EcG4kMXEz+WgyVn7QCoAh
         +ICUPBp2H+x6iuvtOZNFidYys54n+niXzf2RuEJacQGPNWK7xbP/4ocT01oEARXGIuuN
         cMwP9tullqTiXnfSohCGRTir6Jv+7OsiV1WSNcBQdZK3P+p6l8oYQ8p6CYhe5AI63N6H
         z4vQ==
X-Gm-Message-State: ABy/qLbALybkEaprwTV4zESJF1Zq371LUqrqS6GUDAWCsukft7rC1cqi
        x8UeIQnsrP3HBmWkk61/z8yNqwnpuWu6PPw+TE/YgQ==
X-Google-Smtp-Source: APBJJlE6sN0xw+eRSL45rhK9sGYnnWa9JpLUCJ1CIXXlH4fJqUPUds1Zo2PYpjstXASQSiP9Wgb2C7djZ194TlVSod4=
X-Received: by 2002:a5b:8c6:0:b0:c17:60ec:67a3 with SMTP id
 w6-20020a5b08c6000000b00c1760ec67a3mr16181196ybq.43.1688589217601; Wed, 05
 Jul 2023 13:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com> <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com> <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
 <ZKXRsQC8ufiebDGu@x1n>
In-Reply-To: <ZKXRsQC8ufiebDGu@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 13:33:26 -0700
Message-ID: <CAJuCfpGHRfK1ZC3YmF1caKHiR7hD73goOXLKQubFLuOgzCr0dg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 1:25=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jul 05, 2023 at 10:22:27AM -0700, Suren Baghdasaryan wrote:
> > On Wed, Jul 5, 2023 at 10:16=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> > >
> > > On 05.07.23 19:12, Suren Baghdasaryan wrote:
> > > > A memory corruption was reported in [1] with bisection pointing to =
the
> > > > patch [2] enabling per-VMA locks for x86.
> > > > Disable per-VMA locks config to prevent this issue while the proble=
m is
> > > > being investigated. This is expected to be a temporary measure.
> > > >
> > > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> > > > [2] https://lore.kernel.org/all/20230227173632.3292573-30-surenb@go=
ogle.com
> > > >
> > > > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > > > Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3c=
df51b@kernel.org/
> > > > Reported-by: Jacob Young <jacobly.alt@gmail.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> > > > Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handlin=
g first")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >   mm/Kconfig | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > > index 09130434e30d..0abc6c71dd89 100644
> > > > --- a/mm/Kconfig
> > > > +++ b/mm/Kconfig
> > > > @@ -1224,8 +1224,9 @@ config ARCH_SUPPORTS_PER_VMA_LOCK
> > > >          def_bool n
> > > >
> > > >   config PER_VMA_LOCK
> > > > -     def_bool y
> > > > +     bool "Enable per-vma locking during page fault handling."
> > > >       depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
> > > > +     depends on BROKEN
> > > >       help
> > > >         Allow per-vma locking during page fault handling.
> > > >
> > > Do we have any testing results (that don't reveal other issues :) ) f=
or
> > > patch #1? Not sure if we really want to mark it broken if patch #1 fi=
xes
> > > the issue.
> >
> > I tested the fix using the only reproducer provided in the reports
> > plus kernel compilation and my fork stress test. All looked good and
> > stable but I don't know if other reports had the same issue or
> > something different.
>
> The commit log seems slightly confusing.  It mostly says the bug was stil=
l
> not solved, but I assume patch 1 is the current "fix", it's just not clea=
r
> whether there's any other potential issues?
>
> According to the stable tree rules:
>
>  - It must fix a problem that causes a build error (but not for things
>    marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
>    security issue, or some "oh, that's not good" issue.  In short, someth=
ing
>    critical.
>
> I think it means vma lock will never be fixed in 6.4, and it can't (becau=
se
> after this patch it'll be BROKEN, and this patch copies stable, and we
> can't fix BROKEN things in stables).

I was hoping we could re-enable VMA locks in 6.4 once we get more
confirmations that the problem is gone. Is that not possible once the
BROKEN dependency is merged?

>
> Totally no problem I see, just to make sure this is what you wanted..
>
> There'll still try to be a final fix, am I right?  As IIRC allowing page
> faults during fork() is one of the major goals of vma lock.

I think we can further optimize the locking rules here (see discussion
in https://lore.kernel.org/all/20230703182150.2193578-1-surenb@google.com/)
but for now we want the most effective and simple way to fix the
memory corruption problem.
Thanks,
Suren.

>
> Thanks,
>
> --
> Peter Xu
>
