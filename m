Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BAB611EC1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 02:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiJ2AnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 20:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2Am7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 20:42:59 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A92180AF9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 17:42:58 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id z30so4527104qkz.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 17:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoT94j6DZH53rf5IYTyRvpqIs59NBO4pO7++wqZmn18=;
        b=Amx8rn61XHcImW4r+dJE2U388Yq/l/dtEA79H3HKWr5xbhx0X9uGz0UE8MpLuqr6/Q
         gugVpQEKbUBAOecxZ8iW8mOxtp9aryEcH6WPVLGziqEDtex20VtNM59PcChAf/TzITyd
         paEEPJ9rh5IQeIeQ+SBPrnAi2XUa2R69rbSaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoT94j6DZH53rf5IYTyRvpqIs59NBO4pO7++wqZmn18=;
        b=5PDlSNTBgFzj62q6fQtYvl4873lI726Q0RZJ1DAhzAnxonHIG4H8xKVoNaApUnUSfn
         IAMV1iqG8RbXWMV33w3x/sbrYO29alWjnnjIuSaAY5cupnwd4UyXLESNmaWks9dbVWEo
         YZJ2oH5XtTM7EnByK74tQJSgzQPkLFWHPP8JCOSCmvO0BqPXZa9uCMmR5OQxROCjAZ94
         zK9S98+VTTw3sPTNIOAr818gw+PES35cQbAmODISsQEmYUGKX4fmFB/k0/8I90NMw464
         ig8iGfqc67YtzBgRw2MJZcADEj2pa0Yejbsf72m+Yr+uk0QVbw0nK8ywa4inf5jbnbtv
         yBQw==
X-Gm-Message-State: ACrzQf2lDRuWSyZ39osdfR5p9rgOxhE7/Z1uSGSHvMKc4trBbdy97vUQ
        ycDwmZfhhDIutBueHC1kNrmtFCww0clyPA==
X-Google-Smtp-Source: AMsMyM4Pd+Y3/8LIGc8nQ2QRZjZJur7R02xYlIvYhZKYx+pCgsLlEbQK/VEecO6imwlmDJcfDAsxxQ==
X-Received: by 2002:a37:bd47:0:b0:6e1:be21:e6e1 with SMTP id n68-20020a37bd47000000b006e1be21e6e1mr1517645qkf.473.1667004177230;
        Fri, 28 Oct 2022 17:42:57 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id u10-20020a37ab0a000000b006ecb9dfdd15sm95063qke.92.2022.10.28.17.42.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 17:42:56 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-369426664f9so61150087b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 17:42:56 -0700 (PDT)
X-Received: by 2002:a81:1902:0:b0:36b:2578:f6e2 with SMTP id
 2-20020a811902000000b0036b2578f6e2mr2005164ywz.352.1667004175867; Fri, 28 Oct
 2022 17:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net> <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net> <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net> <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com> <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com> <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
In-Reply-To: <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2022 17:42:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
Message-ID: <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 4:57 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> The problem is in the following code of zap_pte_range():
>
>         if (!PageAnon(page)) {
>                 if (pte_dirty(ptent)) {
>                         force_flush =3D 1;
>                         set_page_dirty(page);
>                 }
>                 =E2=80=A6
>         }
>         page_remove_rmap(page, vma, false);
>
> Once we remove the rmap, rmap_walk() would not acquire the page-table loc=
k
> anymore. As a result, nothing prevents the kernel from performing writeba=
ck
> and cleaning the page-struct dirty-bit before the TLB is actually flushed=
.

Hah.

The original reason for force_flush there was similar, with a race wrt
page_mkclean() because this code doesn't take the page lock that would
normally serialize things, because the page lock is so painful and
ends up having nasty nasty interactions with slow IO operations.

So all the page-dirty handling really *wants* to use the page lock,
and for the IO side (writeback) that ends up being acceptable and
works well, but from that "serialize VM state" it's horrendous.

So instead the code intentionally serialized on the rmap data
structures which page_mkclean() also walks, and as you point out,
that's broken. It's not broken at the point where we do
set_page_dirty(), but it *comes* broken when we drop the rmap, and the
problem is exactly that "we still have the dirty bit hidden in the TLB
state" issue that you pinpoint.

I think the proper fix (or at least _a_ proper fix) would be to
actually carry the dirty bit along to the __tlb_remove_page() point,
and actually treat it exactly the same way as the page pointer itself
- set the page dirty after the TLB flush, the same way we can free the
page after the TLB flush.

We could easiy hide said dirty bit in the low bits of the
"batch->pages[]" array or something like that. We'd just have to add
the 'dirty' argument to __tlb_remove_page_size() and friends.

Hmm?

Your idea of "do the page_remove_rmap() late instead" would also work,
but the reason I think just squirrelling away the dirty bit is the
"proper" fix is that it would get rid of the whole need for
'force_flush' in this area entirely. So we'd not only fix that race
you noticed, we'd actually do so and reduce the number of TLB flushes
too.

I don't know. Maybe I'm missing something fundamental, and my idea is
just stupid.

               Linus
