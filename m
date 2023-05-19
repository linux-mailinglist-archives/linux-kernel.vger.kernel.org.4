Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AC7709B82
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjESPm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjESPmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:42:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8271B4
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23ABF658CC
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C332C433AA
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684510972;
        bh=r6KNElAB9lNue2/Hd21GsrXEksf7jxTS8vfcJaqZy9Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W03aV4MidBBBiz6wuT/nE4J+uow5ECmz1loXa+08lTMgAi8VpQuaundC0ZjFK7WpS
         evwV/GDr0WeKUboUIcNB1G/AV6oIwDwZ/0C9PhcNpyLW0rUjznNI0QvOnkEJ1iHEMP
         8LNiAre/2wCMaicM8BkYD6r3MP3ffiWxwMPgUTxKeVPr4QaSvdrtRsJPin3u9TH5fJ
         vfPSXjZBn9408HM8vcU+9pydD5kc4ehDgLSa1GpHd8oqqMG44afoJE+LnFZ1+uO65N
         X3lZcjCTLHlmLM1turvJnnX85uTGJTDM1oRbLHQ7nbg86eXdhT2mBXqo6yrfaZmp2Y
         mqGCUuhzt2gGw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so3892257e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:42:52 -0700 (PDT)
X-Gm-Message-State: AC+VfDwj2FbETvY5pjB0OY+1zChid6DYaECtCq1X/Q+KQC3gWmen4sGN
        vTJqBHKrAEJsfGfAxwSy0L+2Ok2FEWKeMiDAT3o=
X-Google-Smtp-Source: ACHHUZ6jji5zztX+v78YYGws8fwDsVNnwkuvXzZcAzdclQJq6KKtQw6rbL+vMslnBDlqaubv73+qKbm170OWWKTXl2A=
X-Received: by 2002:a05:6512:908:b0:4f3:9136:9cd0 with SMTP id
 e8-20020a056512090800b004f391369cd0mr756798lft.44.1684510970433; Fri, 19 May
 2023 08:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230308094106.227365-1-rppt@kernel.org> <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan> <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZW0v3nRShO7r+Z@moria.home.lan> <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
 <ZGZfLHA8vuRJwa0f@moria.home.lan> <20230519082945.GE4967@kernel.org>
In-Reply-To: <20230519082945.GE4967@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 19 May 2023 08:42:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6xsHupB2EGGrgEdd+13ORSvPAymRgnrAfxG2U0Jfo4vQ@mail.gmail.com>
Message-ID: <CAPhsuW6xsHupB2EGGrgEdd+13ORSvPAymRgnrAfxG2U0Jfo4vQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 1:30=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Hi Kent,
>
> On Thu, May 18, 2023 at 01:23:56PM -0400, Kent Overstreet wrote:
> > On Thu, May 18, 2023 at 10:00:39AM -0700, Song Liu wrote:
> > > On Thu, May 18, 2023 at 9:48=E2=80=AFAM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > >
> > > > On Thu, May 18, 2023 at 09:33:20AM -0700, Song Liu wrote:
> > > > > I am working on patches based on the discussion in [1]. I am plan=
ning to
> > > > > send v1 for review in a week or so.
> > > >
> > > > Hey Song, I was reviewing that thread too,
> > > >
> > > > Are you taking a different approach based on Thomas's feedback? I t=
hink
> > > > he had some fair points in that thread.
> > >
> > > Yes, the API is based on Thomas's suggestion, like 90% from the discu=
ssions.
> > >
> > > >
> > > > My own feeling is that the buddy allocator is our tool for allocati=
ng
> > > > larger variable sized physically contiguous allocations, so I'd lik=
e to
> > > > see something based on that - I think we could do a hybrid buddy/sl=
ab
> > > > allocator approach, like we have for regular memory allocations.
> > >
> > > I am planning to implement the allocator based on this (reuse
> > > vmap_area logic):
> >
> > Ah, you're still doing vmap_area approach.
> >
> > Mike's approach looks like it'll be _much_ lighter weight and higher
> > performance, to me. vmalloc is known to be slow compared to the buddy
> > allocator, and with Mike's approach we're only modifying mappings once
> > per 2 MB chunk.
> >
> > I don't see anything in your code for sub-page sized allocations too, s=
o
> > perhaps I should keep going with my slab allocator.
>
> Your allocator implicitly relies on vmalloc because of module_alloc ;-)
>
> What I was thinking is that we can replace module_alloc() calls in your
> allocator with something based on my unmapped_alloc(). If we make the par=
t
> that refills the cache also take care of creating the mapping in the
> module address space, that should cover everything.

Here are what I found as I work more on the code:

1. It takes quite some work to create a clean interface and make sure
    all the users of module_alloc can use the new allocator on all archs.
    (archs with text poke need to work with ROX memory from the
    allocator; archs without text poke need to have a clean fall back
    mechanism, etc.). Most of this work is independent of the actual
    allocator, so we can do this part and plug in whatever allocator we
    want (buddy+slab or vmap-based or any other solutions).

2. vmap_area based solution will work. And it will be one solution for
    both < PAGE_SIZE and > PAGE_SIZE allocations. Given
    module_alloc is not in any hot path (AFAIK), I don't see any
    practical issues with this solution. It will be a little tricky to plac=
e
    and name the code, as it uses vmalloc logic, but it is technically a
    module allocator.

I will prioritize building the interface, and migrating users to it. If we
do this part right, changing the underlying allocator should be
straightforward.

Thanks,
Song
