Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A276231FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiKISDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiKISCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:02:21 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8E427CF5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:01:07 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id cg5so10772660qtb.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 10:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JRzIGvRnX1544Be7qGWYKxjG2G0UEG52dC2pZ/P5njY=;
        b=Q2jYdJ6BbKHuyhyzDPeRs1/ZAg/T1ka3/R6bWojOn+Omzgy5Dj4jKfPUPoXigYRz80
         U1uLTzqZSA0bShmbIh2qSyRbsyOr3g9pSkEB6QlT4emsVFcwnugFBjwDaP89EpUhOqYg
         XC/lT32oxBfKrKZtT6su0wEqn9DzOp1W7zPnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRzIGvRnX1544Be7qGWYKxjG2G0UEG52dC2pZ/P5njY=;
        b=Y8CQ0dJTPRvXPdPjnlLGd7PQZvixBzhAVfDzPYZsoGqw8SF98Rhhd6HSYnduGM6VcW
         TmLJ/26XbCvsnCy/MxaSSvcJTbzth8wIi/oLFDkWRCt2/+m0wZij4L1NgmIFRBWS20c/
         nkvpnOLYWjeJFijf2j4Ksb2I6vQLlQQDe9HmPE+ysYUmZu3kFz3fu8nJ3fSs5itSaPaU
         5qXbVo/XJaYPBn/ohzVvfNTqpMbgrf3jbsIcHiiijcjBmbFmlZCWVVzQpLRUXNz8IkH+
         9pVm+cqbvlUP7AFUiSHmKYFfRkZ+pg6Y4ZPnR9mLbx/FLBNCv1CygSubAwAVmo1ONruT
         l15Q==
X-Gm-Message-State: ANoB5pkzJOzK+qTPelr2uNU032gbnIj5PumYmn98LSjIGzZ9OAKAH9pZ
        bKzaTyZm8Cl1pIGuRGlmX6hUW9sk9fseRw==
X-Google-Smtp-Source: AA0mqf5e+s4FZs6WpAjXPz7lesydcqg/uePd0f7J1CwxC9UtQHQ4h5kpYzVkQo4kbP8pD5b7csUzYg==
X-Received: by 2002:ac8:5c07:0:b0:3a5:946e:8b7e with SMTP id i7-20020ac85c07000000b003a5946e8b7emr11261883qti.385.1668016865342;
        Wed, 09 Nov 2022 10:01:05 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id l5-20020ac848c5000000b003a5689134afsm10014203qtr.36.2022.11.09.10.01.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 10:01:03 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 129so21884952ybb.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 10:01:03 -0800 (PST)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr62350908ybu.310.1668016862980; Wed, 09
 Nov 2022 10:01:02 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
 <20221108194139.57604-1-torvalds@linux-foundation.org> <Y2tKixpO4RO6DgW5@tuxmaker.boeblingen.de.ibm.com>
In-Reply-To: <Y2tKixpO4RO6DgW5@tuxmaker.boeblingen.de.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Nov 2022 10:00:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqUpnAzD74H7wCvJ+L9jK+wY=H=8BiFFNkWP21r9uoUQ@mail.gmail.com>
Message-ID: <CAHk-=wiqUpnAzD74H7wCvJ+L9jK+wY=H=8BiFFNkWP21r9uoUQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: introduce 'encoded' page pointers with embedded
 extra bits
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Tue, Nov 8, 2022 at 10:38 PM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> On Tue, Nov 08, 2022 at 11:41:36AM -0800, Linus Torvalds wrote:
>
> > +static inline struct encoded_page *encode_page(struct page *page, unsigned long flags)
> > +{
>
> Any reaction in case ((flags & ~ENCODE_PAGE_BITS) != 0)?

Heh. I've actually had three different implementations for that during
the development series, and I think I even posted them all at one
point or another (although usually just as attachments). And none of
them are good.

Those three trivial versions are: (a) use VM_BUG_ON(), (b) just
silently mask the bits and (c) just silently add them.

And (c) is that least annoying option that this latest patch uses,
because both (a) and (b) are just nasty.

Basically, all users are locally trivial to verify statically, so
VM_BUG_ON() is just conceptually wrong and generates extra pointless
code. And the silent masking - if it makes any difference - is just
another version of "just silently add the bits": regardless of whether
it clears them or not, it does the wrong thing if the bits don't fit.

So there are three bad options, I've gone back and forth between them
all, and I chose the least offensive one that is "invisible", in that
it at least doesn't do any extra pointless work.

Now, there are two non-offensive options too, and I actually
considered, but never implemented them. They both fix the problem
properly, by making it a *buildtime* check, but they have other
issues.

There's two ways to just make it a build-time check, and it's
annoyingly _close_ to being usable, but not quite there.

One is simply to require that the flags argument is always a plain
constant, and simply using BUILD_BUG_ON().

I actually almost went down that path - one of the things I considered
was to not add a 'flags' argument to __tlb_remove_page() at all, but
instead just have separate __tlb_remove_page() and
__tlb_remove_page_dirty() functions.

That would have meant that the argument to __tlb_remove_page_size
would have always been a built-time constant, and then it would be
trivial to just have that BUILD_BUG_ON(). Problem solved.

But it turns out that it's just nasty, particularly with different
configurations wanting different rules for what the dirty bit is. So
forcing it to some constant value was really not acceptable.

The thing that I actually *wanted* to do, but didn't actually dare,
was to just say "I will trust the compiler to do the value range
tracking".

Because *technically* our BUILD_BUG_ON() doesn't need a compile-time
constant. Because our implementation of BUILD_BUG_ON() is not the
garbage that the compiler gives us in "_Static_assert()" that really
requires a syntactically pure integer constant expression.

So the kernel version of BUILD_BUG_ON() is actually something much
smarter: it depends on the compiler actually *optimizing* the
expression, and it's only that optimized value that needs to be
determined at compile-time to be either true or false. You can use
things like inline functions etc, just as long as the end result is
obvious enough that the compiler ends up saying "ok, that's never the
case".

And *if* the compiler does any kind of reasonable range analysis, then a

        BUILD_BUG_ON(flags > ENCODE_PAGE_BITS);

should actually work. In theory.

In practice? Not so much.

Because while the argument isn't constant (not even in the caller),
the compiler *should* be smart enough to see that in the use in
mm/memory.c, 'flags' is always that

        unsigned int delay_rmap;

which then gets initialized to

        delay_rmap = 0;

and conditionally set to '1' later. So it's not a *constant*, but the
compiler can see that the value of flags is clearly never larger than
ENCODE_PAGE_BITS.

But right now the compiler cannot track that over the non-inline
function in __tlb_remove_page_size().

Maybe if the 'encode_page()' was done in the caller, and
__tlb_remove_page_size() were to just take an encoded_page as the
argument, then the compiler would always only see this all through
inlined functions, and it would work.

But even if it were to work for me (I never tried), I'd have been much
too worried that some other compiler version, with some other config
options, on some other architecture, wouldn't make the required
optimizations.

We do require compiler optimizations to be on for 'BUILD_BUG_ON()' to
do anything at all:

   #ifdef __OPTIMIZE__
   # define __compiletime_assert(condition, msg, prefix, suffix)           \
   ..
   #else
   # define __compiletime_assert(condition, msg, prefix, suffix) do {
} while (0)
   #endif

and we have a lot of places that depend on BUILD_BUG_ON() to do basic
constant folding and other fairly simple optimizations.

But while I think a BUILD_BUG_ON() would be the right thing to do
here, I do not feel confident enough to really put that to the test.

              Linus
