Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B814370864C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjERRBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjERRA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:00:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38714121
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:00:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C99E0650DF
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C42C433A1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684429254;
        bh=sCSVMW5kMTxYSaFkH40XHeC5n90U6Hx/eg/xMtGfKDo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i1juZWv46pB3m27CQOX0N7Bw8qKT7bUAmyk8Kmr8u9NJyCwjm/iH0dyJrK01uHy7u
         EGisgfrv7Bt1pqQCSSpis5nHZ74oA8hzkE8oEvFvrcnRiUKbAk1QtNcZ5ntXKwJyCG
         F6fK9TCC59OjOlsRuiSWeii2ZNC18FceEfUzNjmzmgYmmZI3Bm5/bJ3au7tlb8KIHK
         yzrNf4FiM/MmzOW/RhqeAfFNIFEJkNER3WG4R4PuMyvS8Ekl6KyHWoMYdMF8ftc7fw
         /DVaK9vGrioLNvretdjUk4JTFKx6Xo7bM+XFrdk2tagqodI3S+0+MO7I7CjMOHwDxM
         XpyribiI6QHxA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4eed764a10cso2740243e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:00:54 -0700 (PDT)
X-Gm-Message-State: AC+VfDzBz3e6uEPPhIJazoRjFyIm/Qoo/bfwCrnEWProsukQoXa7cS8s
        RqHfl+JGxVWbBRZX5eLKKpTkgs8D103Ls/nq+y4=
X-Google-Smtp-Source: ACHHUZ675aHp+CW+nkRJVt7JHNZZHL2+M+LrcNBRb35yggvsg9ZQbp5WjjCRKHHtBlMjWzQlYXwTCFAS5Bpua6P4HF4=
X-Received: by 2002:ac2:4575:0:b0:4e8:5576:98f4 with SMTP id
 k21-20020ac24575000000b004e8557698f4mr1296585lfm.45.1684429252015; Thu, 18
 May 2023 10:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230308094106.227365-1-rppt@kernel.org> <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan> <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com> <ZGZW0v3nRShO7r+Z@moria.home.lan>
In-Reply-To: <ZGZW0v3nRShO7r+Z@moria.home.lan>
From:   Song Liu <song@kernel.org>
Date:   Thu, 18 May 2023 10:00:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
Message-ID: <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
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

On Thu, May 18, 2023 at 9:48=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, May 18, 2023 at 09:33:20AM -0700, Song Liu wrote:
> > I am working on patches based on the discussion in [1]. I am planning t=
o
> > send v1 for review in a week or so.
>
> Hey Song, I was reviewing that thread too,
>
> Are you taking a different approach based on Thomas's feedback? I think
> he had some fair points in that thread.

Yes, the API is based on Thomas's suggestion, like 90% from the discussions=
.

>
> My own feeling is that the buddy allocator is our tool for allocating
> larger variable sized physically contiguous allocations, so I'd like to
> see something based on that - I think we could do a hybrid buddy/slab
> allocator approach, like we have for regular memory allocations.

I am planning to implement the allocator based on this (reuse
vmap_area logic):

https://lore.kernel.org/linux-mm/20221107223921.3451913-2-song@kernel.org/

Thanks,
Song

>
> I started on a slab allocator for executable memory allocations the
> other day (very minimal, but tested it for bcachefs and it works).
>
> But I'd love to hear more about your current approach as well.
>
> Cheers,
> Kent
