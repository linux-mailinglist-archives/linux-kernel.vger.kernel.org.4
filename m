Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88EE70882B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjERTDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjERTDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:03:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E10ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8BF660B7C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 19:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2585AC433A4
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 19:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684436598;
        bh=34OAiZIPKDw+WhaknFtzgMGGRM/uM4kd2z9SISgsEqo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q9o775RjZoJw0WQin4BFUO3ZA5OnWpQgL1Qn8JGF4VaTWwMo4/agvV3GzFmNmdCED
         kGoBngLWXC0fRFbJGbZllNRgvY3oilqV3BHnUH+9zRXMdAbH2S/ZXRoQRm7JcTaWBh
         PX4BtGKTg8J3a0NEMfbS23q3bKcu4NaOMDQ6QlyfOms0NMjgAPr0KWa3ivz4pExqCu
         50eyJ9xXLD9v6V2322Cx3gtCQN3jajySQ9JQDJ2AeGo64Syg/FZa0kzwq39VkNVMT2
         qkdaZ0TFry0ar8aOTSYbxatuW92n2rtkeSwOqVudIkN+5j7nfE9hDYiF9+XjbxjvyE
         aqVW1nzg9FPUQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so2913312e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:03:18 -0700 (PDT)
X-Gm-Message-State: AC+VfDyoBJOBUn3s0NobfeznuoTCGo3vNMOmE60HQjW/bn3U+/LuKMlM
        F2C61n7ilmi3OaMkoQ4W4hcd4qzMUALFxq/CKrc=
X-Google-Smtp-Source: ACHHUZ7b0p7p/AkK558EZSzBH5ajI7jacbEjGMGiWiG+ep93ZOt+Cxs36e3TVpl/Kpn+kZoWAJzUBIM6K4QHTzToIrE=
X-Received: by 2002:a2e:9dca:0:b0:2a9:ee54:289f with SMTP id
 x10-20020a2e9dca000000b002a9ee54289fmr12043370ljj.13.1684436596130; Thu, 18
 May 2023 12:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230308094106.227365-1-rppt@kernel.org> <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan> <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZW0v3nRShO7r+Z@moria.home.lan> <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
 <ZGZfLHA8vuRJwa0f@moria.home.lan> <CAPhsuW6B3O_kWjWwr+UfYO3WRkznFqBNtcecFCSECBSiZBJDsA@mail.gmail.com>
In-Reply-To: <CAPhsuW6B3O_kWjWwr+UfYO3WRkznFqBNtcecFCSECBSiZBJDsA@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 18 May 2023 12:03:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4Mm8z4kbVo8-sPU=QL2B1Sb32ZO7teWT8qienGNuxaeQ@mail.gmail.com>
Message-ID: <CAPhsuW4Mm8z4kbVo8-sPU=QL2B1Sb32ZO7teWT8qienGNuxaeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
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

On Thu, May 18, 2023 at 11:47=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Thu, May 18, 2023 at 10:24=E2=80=AFAM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
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
> The vmap_area approach handles sub-page allocations. In 5/5 of set [2],
> we showed that multiple BPF programs share the same page with some
> kernel text (_etext).
>
> > Could you share your thoughts on your approach vs. Mike's? I'm newer to
> > this area of the code than you two so maybe there's an angle I've misse=
d
> > :)
>
> AFAICT, tree based solution (vmap_area) is more efficient than bitmap
> based solution.
>
> First, for 2MiB page with 64B chunk size, we need a bitmap of
>      2MiB / 64B =3D 32k bit =3D 4k bytes
> While the tree based solution can adapt to the number of allocations with=
in
> This 2MiB page. Also, searching a free range within 4kB of bitmap may
> actually be slower than searching in the tree.
>
> Second, bitmap based solution cannot handle > 2MiB allocation cleanly,
> while tree based solution can. For example, if a big driver uses 3MiB, th=
e
> tree based allocator can allocate 4MiB for it, and use the rest 1MiB for
> smaller allocations.

 Missed one:

Third, bitmap based solution requires a "size" parameter in free(). It is a=
n
overhead for the user. Tree based solution doesn't have this issue.

Thanks,
Song

>
> [2] https://lore.kernel.org/linux-mm/20221107223921.3451913-6-song@kernel=
.org/
