Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFF0612541
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 22:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJ2Ua4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 16:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2Uav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 16:30:51 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2E464D9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 13:30:51 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id j6so6180437qvn.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AmPkk/DwkArLkWG5uoQkbZX2DU9/t0yTo8MPrUCBXeE=;
        b=DTMdWthi0PzdcOxcA7HO6DkSTx4W8h7SUpNTilK0z2bhHHDm5W40mC8SedyFcIZa0m
         EWBya40YPPeIKchNdZ/NIjMjaH3d41HJTYxR9a0ReYdjqKJoxJsrOGHgbmBt1XgmrbAy
         D5vqQwwujljecpRMD04eiq0r/eTLg+xfKLqK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmPkk/DwkArLkWG5uoQkbZX2DU9/t0yTo8MPrUCBXeE=;
        b=duX91RyKYbSYTphTC90ZB9IcFhpolz+VyfU076/AESL9jbKZfKxhXYHyeM0EU5WMg5
         xQeZ8mjwKWaMUKBPuHGERg0dWCsBmDeemWsKlfyC4TGKW8ZWZhCUoufJGvuZX4bgA3pK
         ZYsfXvvN8s3r0VApUs722GBgCHsHkG1UnVqH6hKQ8P/3AdsPBEpcQ8cE/BkXxIMn89Z8
         SJv5iNywJA7SwzpRr0sVFfQ1ZOD8ETOZC8qxtyHYGNa+2RfX1vpy6hCrWUzyErb98Mah
         45/xO37GqjhZ0o6AzgbSIHgdTZVb4U4MvwnEo5lFMw1I8bPSZe2ean7nom1PuBO9sgeb
         30tg==
X-Gm-Message-State: ACrzQf2m5PJKt5hSebiXzi69AY7tUE+59iskNt8tIgV0xQcsNfd3BYU+
        aT5DRK5VJeQSvQRbN0fozdveIFnUZ0o5zw==
X-Google-Smtp-Source: AMsMyM5ZgZH/aZSno7RcVEc+6F8WZSn3n+MBugT0Gljj+6VlZUcYhZpxWxSx7cjYoyLLSffRz2uuqQ==
X-Received: by 2002:a0c:dd13:0:b0:4bb:664c:5aaa with SMTP id u19-20020a0cdd13000000b004bb664c5aaamr5008842qvk.121.1667075444827;
        Sat, 29 Oct 2022 13:30:44 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id z16-20020ac87cb0000000b0039a372fbaa5sm1258033qtv.69.2022.10.29.13.30.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 13:30:43 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id o70so9708798yba.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 13:30:43 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr5680132ybu.310.1667075442955; Sat, 29
 Oct 2022 13:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net> <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net> <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net> <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net> <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com> <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com> <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com> <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <3a57cfc5-5db4-bdc9-1ddf-5305a37ffa62@nvidia.com> <CAHk-=wj6EJvTtTeYQvkX3aOw6Q1SRYRV6xJP1+uHNvfAocO1hw@mail.gmail.com>
In-Reply-To: <CAHk-=wj6EJvTtTeYQvkX3aOw6Q1SRYRV6xJP1+uHNvfAocO1hw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Oct 2022 13:30:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2MFUfh0juVEeBkZ6hBjp=X_UC3jR5edmZ08mV5bztyg@mail.gmail.com>
Message-ID: <CAHk-=wj2MFUfh0juVEeBkZ6hBjp=X_UC3jR5edmZ08mV5bztyg@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, X86 ML <x86@kernel.org>,
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

On Sat, Oct 29, 2022 at 1:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I can think of three options:
>
>  (a) filesystems just deal with it
>
>  (b) we could move the "page_remove_rmap()" into the "flush-and-free" path too
>
>  (c) we could actually add a spinlock (hashed on the page?) for this
>
> I think (a) is basically our current expectation.

Side note: anybody doing gup + set_page_dirty() won't be fixed by b/c
anyway, so I think (a) is basically the only thing.

And that's true even if you do a page pinning gup, since the source of
the gup may be actively unmapped after the gup.

So a filesystem that thinks that only write, or a rmap-accessible mmap
can turn the page dirty really seems to be fundamentally broken.

And I think that has always been the case, it's just that filesystem
writers may not have been happy with it, and may not have had
test-cases for it.

It's not surprising that the filesystem people then try to blame users.

          Linus
