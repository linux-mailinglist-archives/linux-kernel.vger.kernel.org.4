Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF4561250C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 21:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiJ2TOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 15:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJ2TOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 15:14:42 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC19E764C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 12:14:41 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o28so2813002qkl.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/HkzTpfg36PYCftvN9qg0a3la1IW0pkLjuTadw/ixKU=;
        b=BUfN3lBM1gukxgoBW7mYYYBvgXWGeBE0TBDeU6SZ0TSh9y73moySkjR/DdOvspkDQL
         0MFcKEQeA5u4IhDwS82sqYV8BpMiUTiDz/Rj/+iO4S+LvEKoye7SNXRig5jGxcLHNrds
         Q4mJJpKnfQd0JtRcyqS/xrwbiWrZxzyKeAfE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HkzTpfg36PYCftvN9qg0a3la1IW0pkLjuTadw/ixKU=;
        b=h7N2mtA4IjfPgQm70CNHY1wvKj2kigByD36/i/H1DgZYR1JhaHO5Ht6HJjUAwsi1aT
         dfECIZACCPzBDs3AtSQhXaUAkjUoK50V2wPy+6BpdajhKLn+BJufVaJ+W29hjq0/t0wz
         hfbbSz7itjuyATxHiE8xfsKflRDHeJC3d8sBtw78QVLA7QXjOR3XNCnLQNupoBHNlulJ
         Lj+kptm/h9539DtknqThcWmISLUvXU5IP3zaYm9TAlFaJAmMWIeqGR0E18uDQAxPtTFf
         G9zLmKgFcCplF39x3d3NliDgvFaQhznlK/gewb1eFy+3rz5SS0Z5PWUI0+P735nhcF1S
         ZHYg==
X-Gm-Message-State: ACrzQf1RHED9Y5cD3kPxLWYwSsNtNll97Ch2s1fZFGTGfdiZydxD9HNn
        vqSOJiZizk1mLHVKbY0zK4Eu/lVm1aNg4g==
X-Google-Smtp-Source: AMsMyM49MKP/jUnPy7+Zj9zNVsudYFaDDfSrnPOdHV10iBah3vnKvRrkEFL/prkAeVnsoJZcnY5VPA==
X-Received: by 2002:a05:620a:28cd:b0:6cf:93b3:a78 with SMTP id l13-20020a05620a28cd00b006cf93b30a78mr3926670qkp.11.1667070880676;
        Sat, 29 Oct 2022 12:14:40 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id bs30-20020a05620a471e00b006b5c061844fsm1570317qkb.49.2022.10.29.12.14.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 12:14:38 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id f205so9621858yba.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 12:14:38 -0700 (PDT)
X-Received: by 2002:a05:6902:702:b0:6ca:a588:2904 with SMTP id
 k2-20020a056902070200b006caa5882904mr4923591ybt.571.1667070877749; Sat, 29
 Oct 2022 12:14:37 -0700 (PDT)
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
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
In-Reply-To: <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Oct 2022 12:14:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiDa9Xy5rLMR_gvC-WVvdkxABgXXADbKhwswYof7ptdg@mail.gmail.com>
Message-ID: <CAHk-=wgiDa9Xy5rLMR_gvC-WVvdkxABgXXADbKhwswYof7ptdg@mail.gmail.com>
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

On Sat, Oct 29, 2022 at 11:58 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Still not tested in any way, shape, or form. I decided I wanted to
> send this one before booting into this and possibly blowing up ;^)

Well, it boots, and I see no difference with your PoC code.

It didn't fail for me before, it doesn't fail for me with those patches.

Again, the "it doesn't fail for me" is probably because I'm running it
incorrectly, although for all I know there can also be hardware
differences.

I'm testing on an older AMD threadripper, and as I'm sure you are very
aware, some AMD cores used to have special support for keeping the TLB
coherent with the actual page table contents in order to then avoid
TLB flushes entirely.

Those things ended up being buggy and disabled, but my point is that
hardware differences can obviously actively hide this issue by making
the TLB contents track page table changes.

So even if I were to run it the same way you do, I might not see the
failure due to just running it on different hardware with different
TLB and timing.

Anyway, the patches don't seem to cause any *obvious* problems. That's
not to say that they are correct, or that they fix anything, but it's
certainly a fairly simple and straightforward patch, and it "feels
right" to me.

Sadly, reality doesn't always agree with my feelings. Damn.

                Linus
