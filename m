Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC85F748B40
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjGESJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjGESJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:09:46 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137D5173F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 11:09:45 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-579de633419so54429107b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 11:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688580584; x=1691172584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqtIzGaVFOpXMYPUl5WSw8mMx6YorPxKDA1JIgHkc1I=;
        b=zyh3IZqQ+kfBulotXhA2VdnvqrskivIdQ7QCn4ZFrxXXlOeDI/LF1j8gqy3p5TeZH8
         amVPkyTLjx4TE3D2aIff9NNayDZ2X6TILonhNNrkvpPxcQ5HQeiJ8crGhMe6uM7cmTyq
         k0q/ezzj9IPqghkFyP6e6Ji4waAMrcUUn/JIXWITL/Y3hV+PHuIziquhrJr0FZ2XQN+/
         oh4Bpc4rx71Kr2SvPNdPDZGqBaufGk5YdVmh074qBK8Kqrqqap4AdCW/qV7iqZYQPZEY
         DontwsPK+JEmHy5XeYj48Rwc/EZUDmow9CCed4swbtxyGuXtStCkgnuixUV2qDnWUgAY
         9uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688580584; x=1691172584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqtIzGaVFOpXMYPUl5WSw8mMx6YorPxKDA1JIgHkc1I=;
        b=Ntjf+jFqRGdXekSLfIS9KwdFIoLEbdjZDA//3Wu7iKhW/ZU2Q1FawXPzdX0NQk1SS2
         DPuIAj34OQwShISyOYvuvMje9u1C7FtZ/FJEqohQts31Z4yWpzwc9CxNsiyAvMOPJhmQ
         U3XXk961B7Cis6squSf6IvhxcmePTWJ0YKzYFahpVaI9usD3FKj5PZ79NIiWdpqkaCMh
         KH2YTmGflbGNCRA57fKjAX5b25iE+H0WQLvrzEi3qPZl+fYKSmcThqKEU3YOi5YZSty+
         Zo4eQWpuYKUvuKFqXinYCKZh00cMx+Lu8Z0NoXyIa1fYT3wHZobG9dw2g9d6wN7yWlCv
         JbLw==
X-Gm-Message-State: ABy/qLYMXNUZtlqIxRQtZ2h9FfANOAZ6nAtXm4QcH4H9Wm0oe2fHcH8M
        58E2I4V4GfjY1G7B4XPe6/YUY+gi9JHkuRI/OpRgUA==
X-Google-Smtp-Source: APBJJlG9oqJDpPwWw/Z1xXQvA1VxDd0mdwRL341XkKBoNONj9tMIWiDmDQv5f61Uo93QwDdmjgkM/uJxbAdHXfuP6xs=
X-Received: by 2002:a25:e714:0:b0:c61:e9b6:82a5 with SMTP id
 e20-20020a25e714000000b00c61e9b682a5mr2592409ybh.39.1688580583893; Wed, 05
 Jul 2023 11:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com> <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com> <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
 <e4f64aa8-93f5-e731-5d6f-e37ae373c006@redhat.com>
In-Reply-To: <e4f64aa8-93f5-e731-5d6f-e37ae373c006@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 11:09:32 -0700
Message-ID: <CAJuCfpGSt-P6NzTDa8HG6tBKac4Y4Rhkiwcz+80x6aTmVCNS1Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, jirislaby@kernel.org,
        jacobly.alt@gmail.com, holger@applied-asynchrony.com,
        hdegoede@redhat.com, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
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

On Wed, Jul 5, 2023 at 10:24=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 05.07.23 19:22, Suren Baghdasaryan wrote:
> > On Wed, Jul 5, 2023 at 10:16=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 05.07.23 19:12, Suren Baghdasaryan wrote:
> >>> A memory corruption was reported in [1] with bisection pointing to th=
e
> >>> patch [2] enabling per-VMA locks for x86.
> >>> Disable per-VMA locks config to prevent this issue while the problem =
is
> >>> being investigated. This is expected to be a temporary measure.
> >>>
> >>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> >>> [2] https://lore.kernel.org/all/20230227173632.3292573-30-surenb@goog=
le.com
> >>>
> >>> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> >>> Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf=
51b@kernel.org/
> >>> Reported-by: Jacob Young <jacobly.alt@gmail.com>
> >>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> >>> Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling =
first")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> ---
> >>>    mm/Kconfig | 3 ++-
> >>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/mm/Kconfig b/mm/Kconfig
> >>> index 09130434e30d..0abc6c71dd89 100644
> >>> --- a/mm/Kconfig
> >>> +++ b/mm/Kconfig
> >>> @@ -1224,8 +1224,9 @@ config ARCH_SUPPORTS_PER_VMA_LOCK
> >>>           def_bool n
> >>>
> >>>    config PER_VMA_LOCK
> >>> -     def_bool y
> >>> +     bool "Enable per-vma locking during page fault handling."
> >>>        depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
> >>> +     depends on BROKEN
> >>>        help
> >>>          Allow per-vma locking during page fault handling.
> >>>
> >> Do we have any testing results (that don't reveal other issues :) ) fo=
r
> >> patch #1? Not sure if we really want to mark it broken if patch #1 fix=
es
> >> the issue.
> >
> > I tested the fix using the only reproducer provided in the reports
> > plus kernel compilation and my fork stress test. All looked good and
> > stable but I don't know if other reports had the same issue or
> > something different.
>
> Can you point me at the other reports, so I can quickly scan them?

by Jacob Young: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
by Jiri Slaby: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cd=
f51b@kernel.org/
by Holger Hoffst=C3=A4tte:
https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec2a34c@applied-as=
ynchrony.com/
only saying that Firefox started crashing after upgrading to 6.4.1

>
> --
> Cheers,
>
> David / dhildenb
>
