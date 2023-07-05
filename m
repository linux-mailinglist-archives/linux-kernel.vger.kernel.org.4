Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCEA748F8B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjGEVJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjGEVJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:09:47 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1C1700
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:09:46 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-c581c758ad8so3543159276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 14:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688591385; x=1691183385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaGMTa0DbN3c8dwMUOQDzcTZPQ/M8amf44bbRz7BEX8=;
        b=UBG5+DvKOvH7qCjkiEDp6J4u/q3uj4JRG5ekSG6AlIb7zKH+lcIHdZemv8svEgfwsq
         QL2DFDTL5EYIS1YkvcISRvfWkCeJfhy45+8NBPenPJm7CWNNg3PhBCXFlpcSAn/jOXP4
         n9Cgp59YaiI8MgDIA6HnTpxQW/ggXhpyp1ohN9+CzWeWadofYwPRIMRlkm1x2Xm1VYG8
         ghtB9xIab0YgX3DLDz25CKz+nKAH4G6SPV9yDzieTA9YRIkd8nfRLz9mjNvjq60c7lkq
         rWVGWwiFrQGjFGgjSun32TBndFiuhJWJ1G3rCfc83ykWM1tMVDLHOP7INWALmvvJ6sso
         Anog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688591385; x=1691183385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaGMTa0DbN3c8dwMUOQDzcTZPQ/M8amf44bbRz7BEX8=;
        b=B/M7M+OUeEpkiw0TzoNHJfsalsXd0Lse40QR9ROxRoGR6ukXon9WBj+65vDyHCoUlL
         e2dhUjXpeOueplqk8fsbldnZ0/6MEHaG10DrUqktRPsRQzcR1K/BGcZGB09t3HMFb8dX
         O9V9Nbh9x3fXIEf61zixCFXv9vQG0gyohOh8NmjbeL1tns5CeyX5yc2h6CqbB4lyuGQQ
         avN+Yq9F306Hfd57e7XLjk5UCoIIf7a8Wy1I+RelhNqrWPW5Ql5xACOf3DYClwd1JKcS
         kj/pIys7HZRUSQcxAGj4qDv7LOmNxkJPgeVC+IXBrhyh3mHVEI/GtIwxQXXN8pRMnzL+
         b4Gw==
X-Gm-Message-State: ABy/qLZ/83P7OE/WaqWWhjy9OxoodUbRTs7dSi6W0QfyLuUexION2I73
        hveMpYxFNIfKRNlEiMuRBuBIFYBS+mC58+LvhSodgQ==
X-Google-Smtp-Source: APBJJlEMfph7t7wJWllYEpACDgeAzyYwh2jqlBg6bNRDARLEVdUNgL/soI72nwZ79kZeqNq7mcFxbIQLP+5i5Egiq3M=
X-Received: by 2002:a25:4ed6:0:b0:c63:5334:9d10 with SMTP id
 c205-20020a254ed6000000b00c6353349d10mr64531ybb.3.1688591385152; Wed, 05 Jul
 2023 14:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com> <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com> <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
 <ZKXRsQC8ufiebDGu@x1n> <d3245a2a-285b-6dfe-5dd3-05fdeb308e18@redhat.com>
In-Reply-To: <d3245a2a-285b-6dfe-5dd3-05fdeb308e18@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 14:09:33 -0700
Message-ID: <CAJuCfpGuLRzvmNdgYGBa=ZBBG65_kc-7byED8JYXFo0RBHLMZQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, akpm@linux-foundation.org,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 1:37=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.07.23 22:25, Peter Xu wrote:
> > On Wed, Jul 05, 2023 at 10:22:27AM -0700, Suren Baghdasaryan wrote:
> >> On Wed, Jul 5, 2023 at 10:16=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 05.07.23 19:12, Suren Baghdasaryan wrote:
> >>>> A memory corruption was reported in [1] with bisection pointing to t=
he
> >>>> patch [2] enabling per-VMA locks for x86.
> >>>> Disable per-VMA locks config to prevent this issue while the problem=
 is
> >>>> being investigated. This is expected to be a temporary measure.
> >>>>
> >>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> >>>> [2] https://lore.kernel.org/all/20230227173632.3292573-30-surenb@goo=
gle.com
> >>>>
> >>>> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> >>>> Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cd=
f51b@kernel.org/
> >>>> Reported-by: Jacob Young <jacobly.alt@gmail.com>
> >>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> >>>> Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling=
 first")
> >>>> Cc: stable@vger.kernel.org
> >>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>>> ---
> >>>>    mm/Kconfig | 3 ++-
> >>>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/mm/Kconfig b/mm/Kconfig
> >>>> index 09130434e30d..0abc6c71dd89 100644
> >>>> --- a/mm/Kconfig
> >>>> +++ b/mm/Kconfig
> >>>> @@ -1224,8 +1224,9 @@ config ARCH_SUPPORTS_PER_VMA_LOCK
> >>>>           def_bool n
> >>>>
> >>>>    config PER_VMA_LOCK
> >>>> -     def_bool y
> >>>> +     bool "Enable per-vma locking during page fault handling."
> >>>>        depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
> >>>> +     depends on BROKEN
> >>>>        help
> >>>>          Allow per-vma locking during page fault handling.
> >>>>
> >>> Do we have any testing results (that don't reveal other issues :) ) f=
or
> >>> patch #1? Not sure if we really want to mark it broken if patch #1 fi=
xes
> >>> the issue.
> >>
> >> I tested the fix using the only reproducer provided in the reports
> >> plus kernel compilation and my fork stress test. All looked good and
> >> stable but I don't know if other reports had the same issue or
> >> something different.
> >
> > The commit log seems slightly confusing.  It mostly says the bug was st=
ill
> > not solved, but I assume patch 1 is the current "fix", it's just not cl=
ear
> > whether there's any other potential issues?
> >
> > According to the stable tree rules:
> >
> >   - It must fix a problem that causes a build error (but not for things
> >     marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
> >     security issue, or some "oh, that's not good" issue.  In short, som=
ething
> >     critical.
> >
> > I think it means vma lock will never be fixed in 6.4, and it can't (bec=
ause
> > after this patch it'll be BROKEN, and this patch copies stable, and we
> > can't fix BROKEN things in stables).
> >
> > Totally no problem I see, just to make sure this is what you wanted..
> >
> > There'll still try to be a final fix, am I right?  As IIRC allowing pag=
e
> > faults during fork() is one of the major goals of vma lock.
>
> At least not that I am aware of (and people who care about that should
> really work on scalable fork() alternatives, like that io_uring fork()
> thingy).
>
> My understanding is that CONFIG_PER_VMA_LOCK wants to speed up page
> concurrent page faults *after* fork() [or rather, after new process
> creation], IOW, when we have a lot of mmap() activity going on while
> some threads of the new process are already active and don't actually
> touch what's getting newly mmaped.

Getting as much concurrency as we can is the goal. If we can allow
some page faults during fork, I would take that too. But for now let's
deploy the simplest and safest approach.

>
> --
> Cheers,
>
> David / dhildenb
>
