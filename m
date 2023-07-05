Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5028B747B63
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 04:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGECH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 22:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGECH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 22:07:58 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF6310D9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 19:07:56 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-401f4408955so732631cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 19:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688522876; x=1691114876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0wAoKec+Pl35+rlh7VOhG01IZuhb1xkdl9OsSICnU4=;
        b=wAy8sTOX1/jVffTuSno5nLY/g6Nds9KsWTTtt48Hwl5iJXJ4rND6+wb2RtOdTvqHGp
         wG/qWRcWihcQE7ssyUJUElWA+btPAGilKqV/NqS/hKQVM9M2yyEHQy59r9v/gVNXXMNm
         nBoNR8MIemlYUjlT6WrURGCdLEKirmzXV4TLbO0mQ0bVShVKbAfYhTyRvdoVN5FR+GFl
         x5iKLVVzYVZxG6YBzzPpHY0GpOy47RTVF1xPmvx+rGvp3+3FNh5o1hTOzPiZ9XT3P5AG
         dwRixmPu39Y38zlflxmG6E51X/bsWGxECu33E2SiohKx/JgXLLBnp7o4WUleFn1zuQmM
         Ergw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688522876; x=1691114876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0wAoKec+Pl35+rlh7VOhG01IZuhb1xkdl9OsSICnU4=;
        b=FDj6DlyO2Z4Dj94kEi+4lohUrj+zzhrBSOMg57F5qe2p6+/30qMgjK+K5JN09PNcus
         gHqg6O5FMwRHGvdrTRCpahDa3gh8XnFb7pGEBAKTXGZJ49gzwQr2UaUE0MSzkhHTZdVI
         33zFsJfyNyzEP7gaNHLvaDrM2c6Y+Wk5RojWN3m1xel6D1sWw2kYpkEMnCYpFCcUgbno
         o9dPdau6b3FcTIylZTcE/DOSJUfNeN0ver7FVqH84hm9nP6ZZLJvvwZplWkBZNg8QTP0
         r/L2KhZWducOGtglOObpksIyjtvg3fvxLgeD0rUCdBvHMHMiMGNHLrVIFzVK6AwnlW/N
         6z+A==
X-Gm-Message-State: ABy/qLYDAe0Eio2yjxM783KRfUvWxPkkkiKbTzspbse2p+B9YyeRFvh+
        unr131CIjB9JOFuy9Bf2N8sfhvBARC7aIh9/fYGmlQ==
X-Google-Smtp-Source: APBJJlHtHWhqDwvFEDVpZ4G9KknXb3bW+OyzK+jOwsTwjjzc9ueG3UHDyD1AIbujZQYMnl5AcfvVcJcpxUv4tETsKPs=
X-Received: by 2002:ac8:5fd3:0:b0:3f9:ab2c:88b9 with SMTP id
 k19-20020ac85fd3000000b003f9ab2c88b9mr13116qta.25.1688522875892; Tue, 04 Jul
 2023 19:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-4-ryan.roberts@arm.com> <CAOUHufa_xFJvFFvmw1Tkdc9cXaZ1GPA1dVSauH+J9zGX-sO1UA@mail.gmail.com>
 <eea2b36d-9c6d-64ca-4e21-57cfd5a93d57@arm.com>
In-Reply-To: <eea2b36d-9c6d-64ca-4e21-57cfd5a93d57@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 4 Jul 2023 20:07:19 -0600
Message-ID: <CAOUHufZypv+kLFu3r8iPYbceBh0KSE=gus-_iC1Q35_QVQdnMQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: Default implementation of arch_wants_pte_order()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Tue, Jul 4, 2023 at 7:20=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 03/07/2023 20:50, Yu Zhao wrote:
> > On Mon, Jul 3, 2023 at 7:53=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> arch_wants_pte_order() can be overridden by the arch to return the
> >> preferred folio order for pte-mapped memory. This is useful as some
> >> architectures (e.g. arm64) can coalesce TLB entries when the physical
> >> memory is suitably contiguous.
> >>
> >> The first user for this hint will be FLEXIBLE_THP, which aims to
> >> allocate large folios for anonymous memory to reduce page faults and
> >> other per-page operation costs.
> >>
> >> Here we add the default implementation of the function, used when the
> >> architecture does not define it, which returns the order corresponding
> >> to 64K.
> >
> > I don't really mind a non-zero default value. But people would ask why
> > non-zero and why 64KB. Probably you could argue this is the large size
> > all known archs support if they have TLB coalescing. For x86, AMD CPUs
> > would want to override this. I'll leave it to Fengwei to decide
> > whether Intel wants a different default value.>
> > Also I don't like the vma parameter because it makes
> > arch_wants_pte_order() a mix of hw preference and vma policy. From my
> > POV, the function should be only about the former; the latter should
> > be decided by arch-independent MM code. However, I can live with it if
> > ARM MM people think this is really what you want. ATM, I'm skeptical
> > they do.
>
> Here's the big picture for what I'm tryng to achieve:
>
>  - In the common case, I'd like all programs to get a performance bump by
> automatically and transparently using large anon folios - so no explicit
> requirement on the process to opt-in.

We all agree on this :)

>  - On arm64, in the above case, I'd like the preferred folio size to be 6=
4K;
> from the (admittedly limitted) testing I've done that's about where the
> performance knee is and it doesn't appear to increase the memory wastage =
very
> much. It also has the benefits that for 4K base pages this is the contpte=
 size
> (order-4) so I can take full benefit of contpte mappings transparently to=
 the
> process. And for 16K this is the HPA size (order-2).

My highest priority is to get 16KB proven first because it would
benefit both client and server devices. So it may be different from
yours but I don't see any conflict.

>  - On arm64 when the process has marked the VMA for THP (or when
> transparent_hugepage=3Dalways) but the VMA does not meet the requirements=
 for a
> PMD-sized mapping (or we failed to allocate, ...) then I'd like to map us=
ing
> contpte. For 4K base pages this is 64K (order-4), for 16K this is 2M (ord=
er-7)
> and for 64K this is 2M (order-5). The 64K base page case is very importan=
t since
> the PMD size for that base page is 512MB which is almost impossible to al=
locate
> in practice.

Which case (server or client) are you focusing on here? For our client
devices, I can confidently say that 64KB has to be after 16KB, if it
happens at all. For servers in general, I don't know of any major
memory-intensive workloads that are not THP-aware, i.e., I don't think
"VMA does not meet the requirements" is a concern.
