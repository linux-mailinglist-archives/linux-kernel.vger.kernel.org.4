Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB88F748A0B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjGERWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGERWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:22:40 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFFE183
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:22:39 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-c49777d6e7aso5846892276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688577758; x=1691169758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6Tk2ql2z3k8hI6gx082bWriam5zLDXexsywXgjVlB4=;
        b=Vwr0HKppn8I7Y48ogyG7iPT2wYGMyZgOMj2odgQD6TWHNk+4wNp0qzgiv4/AM1diks
         Ctnd+ZWxUYwa8Fy7wrhYYZq15ti771Mtd5owNQnjOutUFhf92TzjYyCc7oi8xbJcJiuv
         bAzvuvn66zIm+FCZ+7FU20Sdymyv0HtTX9gdnYqKpCnSe8IUw/0GK6AQQ+9gs3KW3xku
         XRdo9cbI5ljud3WQ6ITvbubiQVIeSL7BmyJ0sWrfPr9/rgFIXTiiUb1U2OfaaegxgXxV
         gnLyWSpPhIkKagpxNXBPQQobtrj3nqaZjDAQ/X8zPK0zqtWTxOvXZ+yqBbKHcGmbrV6u
         SGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577758; x=1691169758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6Tk2ql2z3k8hI6gx082bWriam5zLDXexsywXgjVlB4=;
        b=DhpKeZGAHloYi5ihVinxmRcZND52Hvi+m0dfPHN1/05/D6kVJTnClQMrNDzphtY15l
         Y53DlrG8FiLgUMcmnII3r8TV80gu8bOZIpN+lZQmIGB8D6KNXTIMLvegZOuR1qtgDTa9
         OuMxVYKIHAmI9mXHmV6ft5be9/5JLsMOX7Hc95Eao5eA60CoDgnjnguv2ibG/ojnLeyk
         l1Xp4oo1IunPVfXLhZhYNSVnbUiqbjC04Vzl5dYBNTi3Id0ZYXoWZ200JIBrkc+mgKHg
         K+LVR2Y4nUuzQnlGlzdwgQDjJJC56L8HOCR31PZ7Kb8pUEBYtiuU46aaPK6V2zrLYEy2
         WMIw==
X-Gm-Message-State: ABy/qLbQPhgfMViCu+V+XWyvF2RTN4oUtO5jYv1BzQbD9wm3MO/W72qx
        yvw93vSjsBNzapzbQQYpZe2kW8UscfKRgRApehvw4w==
X-Google-Smtp-Source: APBJJlEzexLn8Gnsj86NrWI8WO/vdjL9jBS1mJI+nuZ2OzXLXobm03US7gnI6v9c7ePfC7tBcWU3w5mlyqIWysOpxiw=
X-Received: by 2002:a25:d488:0:b0:c4c:dbee:4915 with SMTP id
 m130-20020a25d488000000b00c4cdbee4915mr13592561ybf.9.1688577758189; Wed, 05
 Jul 2023 10:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com> <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com>
In-Reply-To: <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 10:22:27 -0700
Message-ID: <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
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

On Wed, Jul 5, 2023 at 10:16=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 05.07.23 19:12, Suren Baghdasaryan wrote:
> > A memory corruption was reported in [1] with bisection pointing to the
> > patch [2] enabling per-VMA locks for x86.
> > Disable per-VMA locks config to prevent this issue while the problem is
> > being investigated. This is expected to be a temporary measure.
> >
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> > [2] https://lore.kernel.org/all/20230227173632.3292573-30-surenb@google=
.com
> >
> > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51=
b@kernel.org/
> > Reported-by: Jacob Young <jacobly.alt@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> > Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling fi=
rst")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >   mm/Kconfig | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 09130434e30d..0abc6c71dd89 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -1224,8 +1224,9 @@ config ARCH_SUPPORTS_PER_VMA_LOCK
> >          def_bool n
> >
> >   config PER_VMA_LOCK
> > -     def_bool y
> > +     bool "Enable per-vma locking during page fault handling."
> >       depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
> > +     depends on BROKEN
> >       help
> >         Allow per-vma locking during page fault handling.
> >
> Do we have any testing results (that don't reveal other issues :) ) for
> patch #1? Not sure if we really want to mark it broken if patch #1 fixes
> the issue.

I tested the fix using the only reproducer provided in the reports
plus kernel compilation and my fork stress test. All looked good and
stable but I don't know if other reports had the same issue or
something different.
I think the urgency to disable the feature stems from the timeline
being very close to when distributions will start using the 6.4 stable
kernel version.

>
> --
> Cheers,
>
> David / dhildenb
>
