Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CE3708613
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjERQdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjERQdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BAEB3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5EBB650D0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502EDC4339B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684427615;
        bh=WcLiBzhFbhnqT4iTF0sRkM/Vim1CG6TRTNawjkcfL6Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gWYGBz03+1JvsYNxN/T6wLtrtDbtZAR5gXCydsklR7zhH/e9tcl7mPoVIrBZGrE7T
         UI2pAPLz7PeSEiW0/HcI4FfefJiXGgBOOdgZIkYtVr5kPLeckxUDMsnmMuKpuEGbGu
         1IB1fPx1tiwc5CNusDBD4hYTQSw6/QTuLOnGSyDUO/Xfo9E0Us1WGdJhiTyzTBGYBu
         6DzI7kkngwE6xY0jte314SoLQLcXGkrn+TS+ExsUxJQzx81GH0g+Sh5f7mxyRQbzHd
         FmL6tbz9LtyHGJ/FcBb0cz0kRSb43W2HDH4P+DOsLYADhTebSJPQwf8W7yx05BJsRj
         qNTVkRBtjwlmQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f27b65bbf9so2566828e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:33:35 -0700 (PDT)
X-Gm-Message-State: AC+VfDzkjsn83xZUtRwGjvtFASRX1nWAb0Q6a3V5H7ZDM5Qr95Dmojrj
        nPJ/vz7teZ8/qN+1/lgPszrYfnMT2HhTRWO/TRE=
X-Google-Smtp-Source: ACHHUZ52GC0BshUWnwslDjM4lCSENObwVMvDSQYPg8cSAvRRia2PtEIQI6fWg6BonMCxpJahZ/WXWxY6e/9fQPSxlRo=
X-Received: by 2002:ac2:44ca:0:b0:4f3:87d7:f7a4 with SMTP id
 d10-20020ac244ca000000b004f387d7f7a4mr1420356lfm.62.1684427613322; Thu, 18
 May 2023 09:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230308094106.227365-1-rppt@kernel.org> <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan> <20230518152354.GD4967@kernel.org>
In-Reply-To: <20230518152354.GD4967@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 18 May 2023 09:33:20 -0700
X-Gmail-Original-Message-ID: <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
Message-ID: <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
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

On Thu, May 18, 2023 at 8:24=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Wed, May 17, 2023 at 11:35:56PM -0400, Kent Overstreet wrote:
> > On Wed, Mar 08, 2023 at 11:41:02AM +0200, Mike Rapoport wrote:
> > > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > >
> > > When set_memory or set_direct_map APIs used to change attribute or
> > > permissions for chunks of several pages, the large PMD that maps thes=
e
> > > pages in the direct map must be split. Fragmenting the direct map in =
such
> > > manner causes TLB pressure and, eventually, performance degradation.
> > >
> > > To avoid excessive direct map fragmentation, add ability to allocate
> > > "unmapped" pages with __GFP_UNMAPPED flag that will cause removal of =
the
> > > allocated pages from the direct map and use a cache of the unmapped p=
ages.
> > >
> > > This cache is replenished with higher order pages with preference for
> > > PMD_SIZE pages when possible so that there will be fewer splits of la=
rge
> > > pages in the direct map.
> > >
> > > The cache is implemented as a buddy allocator, so it can serve high o=
rder
> > > allocations of unmapped pages.
> >
> > So I'm late to this discussion, I stumbled in because of my own run in
> > with executable memory allocation.
> >
> > I understand that post LSF this patchset seems to not be going anywhere=
,
> > but OTOH there's also been a desire for better executable memory
> > allocation; as noted by tglx and elsewhere, there _is_ a definite
> > performance impact on page size with kernel text - I've seen numbers in
> > the multiple single digit percentage range in the past.
> >
> > This patchset does seem to me to be roughly the right approach for that=
,
> > and coupled with the slab allocator for sub-page sized allocations it
> > seems there's the potential for getting a nice interface that spans the
> > full range of allocation sizes, from small bpf/trampoline allocations u=
p
> > to modules.
> >
> > Is this patchset worth reviving/continuing with? Was it really just the
> > needed module refactoring that was the blocker?
>
> As I see it, this patchset only one building block out of three? four?
> If we are to repurpose it for code allocations it should be something lik=
e
>
> 1) allocate 2M page to fill the cache
> 2) remove this page from the direct map
> 3) map the 2M page ROX in module address space (usually some part of
>    vmalloc address space)
> 4) allocate a smaller chunk of that page to the actual caller (bpf,
>    modules, whatever)
>
> Right now (3) and (4) won't work for modules because they mix code and da=
ta
> in a single allocation.

I am working on patches based on the discussion in [1]. I am planning to
send v1 for review in a week or so.

Thanks,
Song

[1] https://lore.kernel.org/linux-mm/20221107223921.3451913-1-song@kernel.o=
rg/

[...]
