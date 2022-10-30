Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00212612C33
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJ3SU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ3SUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:20:54 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83DFB845
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 11:20:53 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id k4so3570441qkj.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 11:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nhjvm4CLfjf8sZh4i2SvI4bcfGTGarDkiioYf9j/q80=;
        b=fN3naw36QXCqqTVPHS+dkD5oxumRUFB/LNJ+o5y4bb9W32TVqB285knxQkX7u6XkmS
         Yn5BMZWYJT09H0YWWX9PvBHq4pL9ArHEIWnYEICha7ZVsiJKLEIJ2wqnI0zWXzpbxA1D
         5WSsG7eVfB/2HH+LnLuoxguol6B3WgeqRXu8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nhjvm4CLfjf8sZh4i2SvI4bcfGTGarDkiioYf9j/q80=;
        b=inPpIh+ifl6lRNKQ4xXbuvgKqqu56Yt/20OG7/n4GPKX5pgIuBGf+3RpMHLKfkJBu8
         U44NxrVBpb1v/t0YbqKKYrpmVrchXfDENKKbbHabzmDpc2LoAKFcW/as36TdaR3VBhn/
         zmyjscDL95THYH0ujFMZ8uiR35giL+f0M+8HrgCBorGqh/AtLGOi3wO2JEk3HX9OvdsR
         WLVBlq85PEEQp9PPDf+50+zd02QpEulBuB0ZALazJ3NMJFe6DWK6EAchOOzYnP15oXIa
         GGlmnb0h34nNDft3JWhtyqDzEqLzkodZtMGIqMSIl/E8bnbdYIZHnp/GhdT2jRV8PiXY
         YImw==
X-Gm-Message-State: ACrzQf2AkI4ieyyvwKipi49lt60ZwsvzQNJXtLxHFCOYMDLBZL6zn3/U
        i9d+MDkneihZKmPy+VajetrUgMo4CPUNoQ==
X-Google-Smtp-Source: AMsMyM7WMs7R0uC8iQaxeR4EotA08qYwQ86FQOQERpLMNBjq1vAJXDBbTElfxsuS2y1jXGikDJq9Pw==
X-Received: by 2002:a05:620a:408a:b0:6fa:b07:3552 with SMTP id f10-20020a05620a408a00b006fa0b073552mr6646197qko.377.1667153993962;
        Sun, 30 Oct 2022 11:19:53 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id t12-20020a37ea0c000000b006cfaee39ccesm3209970qkj.114.2022.10.30.11.19.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 11:19:53 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3704852322fso20075577b3.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 11:19:52 -0700 (PDT)
X-Received: by 2002:a0d:c246:0:b0:370:2d8c:81d6 with SMTP id
 e67-20020a0dc246000000b003702d8c81d6mr9315634ywd.112.1667153992578; Sun, 30
 Oct 2022 11:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net> <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net> <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net> <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com> <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com> <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com> <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com> <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com>
In-Reply-To: <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Oct 2022 11:19:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
Message-ID: <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
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
        jroedel@suse.de, ubizjak@gmail.com,
        Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 7:17 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> Running the PoC on Linux 6.0.6 with these patches caused the following splat
> on the following line:
>
>         WARN_ON_ONCE(!folio_test_locked(folio) && !folio_test_dirty(folio));

Yeah, this is a sign of that "folio_mkclean() serializes with
folio_mark_dirty using rmap and the page table lock".

And page_remove_rmap() could *almost* be called later, but it does
have code that also depends on the page table lock, although it looks
like realistically that's just because it "knows" that means that
preemption is disabled, so it uses non-atomic statistics update.

I say "knows" in quotes, because that's what the comment says, but it
turns out that __mod_node_page_state() has to deal with CONFIG_RT
anyway and does that

        preempt_disable_nested();
        ...
        preempt_enable_nested();

thing.

And then it wants to see the vma, although that's actually only to see
if it's 'mlock'ed, so we could just squirrel that away.

So we *could* move page_remove_rmap() later into the TLB flush region,
but then we would have lost the page table lock anyway, so then
folio_mkclean() can come in regardless.

So that doesn't even help.

End result: we do want to do the page_set_dirty() and the
remove_rmap() under the paeg table lock, because it's what serializes
folio_mkclean().

And we'd _like_ to do the TLB flush before the remove_rmap(), but we
*really* don't want to do that for every page.

So my current gut feel is that we should just say that if you do
"MADV_DONTNEED or do a munmap() (which includes the "re-mmap() over
the area", while some other thread is still writing to that memory
region, you may lose writes.

IOW, just accept the behavior that Nadav's test-program tries to show,
and say "look, you're doing insane things, we've never given you any
other semantics, it's your problem" to any user program that does
that.

If a user program does MADV_DONTNEED on an area that it is actively
using at the same time in another thread, that sounds really really
bogus. Same goes doubly for 'munmap()' or over-mapping.

              Linus
