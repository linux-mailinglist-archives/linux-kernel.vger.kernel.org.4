Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79DD5FF4C8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiJNUoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJNUow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:44:52 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2237412D26
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:44:48 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j21so3258202qkk.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ok9hI7NWTIZgdhkAUpeBmH2n5gbA7izg6BGKrFBe8OQ=;
        b=W154eT/TZJ/Um3zPanjrRhXY2pLXsL9jKejRbUCB1J2vdK5oh1Isoe/nekoKT5unjV
         EbYVGH/jfqWTYYQK893YdbBgeRxM5qz5IOmuXWlNSJi9HjEpwYn8jgv2grGjq4ECS3od
         1CtpnizpM3wcmhKpwP02l/aRc2lllihNBu7Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ok9hI7NWTIZgdhkAUpeBmH2n5gbA7izg6BGKrFBe8OQ=;
        b=ocMYscf1jF3C6tE0w9IByYJGUaq1v6k572moSwX72rwAJBdXvSII4HuCaJgHhZW0SD
         HSEjQ+AGj+lGdMreLcy+QvgH/pBAgacn25j/rMvvIGnte6BQ/e7iBhZpgIbGGaxLEuef
         wJUUx8Iqi2zZHiHI5SyooAn/XHj+xjaMfuC9LE910AE541H94gPFfZgZbGv1gM4Hb4bt
         MNCpMtvNyW9SWvQlxtxiwOOiOlqbc0j2wABK2WghUrNvrJkr5+faRnXl31k6UfV6eQ7f
         52kQMJv/vUMQ6LknjNc46fChJ+7+BqIZ/nY/pjXnOBESnEehvF+pI2+Bbd79E+U+5PWf
         lLDA==
X-Gm-Message-State: ACrzQf1bAT9ofeddnQ1IGi5+RpXsXuv5RkaHBsQFNRcUJTl5/WJVKTuB
        FK9KMhVKMoJLsIJVPES0pBjoqhwea1YALw==
X-Google-Smtp-Source: AMsMyM6MOLtfWdcDGS1vuzP5Mch2f7QlYuIaIHZX7pGB2x/VAGkUsgX/8dGVCmDL8YqLujivRdPRgg==
X-Received: by 2002:a05:620a:b87:b0:6ea:d354:49b9 with SMTP id k7-20020a05620a0b8700b006ead35449b9mr5196217qkh.384.1665780286760;
        Fri, 14 Oct 2022 13:44:46 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a254800b006c479acd82fsm3376697qko.7.2022.10.14.13.44.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 13:44:43 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-360871745b0so57055297b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:44:43 -0700 (PDT)
X-Received: by 2002:a81:5843:0:b0:361:2d0:7d9 with SMTP id m64-20020a815843000000b0036102d007d9mr6405882ywb.58.1665780283206;
 Fri, 14 Oct 2022 13:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <YlvTNQGh+MfZFWKW@gondor.apana.org.au> <YlxATW56ZoNtmxlk@arm.com>
 <YtHo3Xu33jovwpFt@google.com> <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com> <YypfJQqj8PeOp8A4@google.com> <Yzc2UrX7ndWw1vKI@arm.com>
 <Y0b9SYI7v94ig5v8@google.com> <Y0hDdmD0yJ+PS2Kz@arm.com> <CAGETcx8SZ8XjyTveh2iWiHK09iOpU_fsOkFcBL_EG4Qp93A_wA@mail.gmail.com>
 <Y0mNek2pRpXexZxX@arm.com> <CAGETcx9zGaFFBqQ8d4kF-jz3nOjyShkbu3Z4YHpFY9_N+16g-w@mail.gmail.com>
In-Reply-To: <CAGETcx9zGaFFBqQ8d4kF-jz3nOjyShkbu3Z4YHpFY9_N+16g-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Oct 2022 13:44:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgaWEsObv2SO-xa6g6ncj53q8tPpM3cgJGr+wtWknVyA@mail.gmail.com>
Message-ID: <CAHk-=wjgaWEsObv2SO-xa6g6ncj53q8tPpM3cgJGr+wtWknVyA@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Saravana Kannan <saravanak@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Isaac Manjarres <isaacmanjarres@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, kernel-team@android.com
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

On Fri, Oct 14, 2022 at 1:24 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Agreed. Even allowing a 64-byte kmalloc cache on a system with a
> 64-byte cacheline size saves quite a bit of memory.

Well, the *really* trivial thing to do is to just say "if the platform
is DMA coherent, just allow any size kmalloc cache". And just
consciously leave the broken garbage behind.

Because it's not just 64-byte kmalloc. It's things like 'avtab_node'
that is 24 bytes, and that on my system currently uses about 3MB of
memory simply because there's a _lot_ of them.

I've got 1.8MB in "kmalloc-32" too, and about 1MB in "kamlloc-16", fwiw. That's

Yeah, yeah, this is on a 64GB machine and so none of that matters (and
some of these things are very much "scales with memory", but these
small allocations aren't actually all that unusual.

And yes, the above is obviously on my x86-64 machine.

My arm64 laptop doesn't have the small kmallocs, and as a result the
"kmalloc-128" has 633 _thousand_ entries, and takes up 77MB of RAM on
my 16GB laptop. I'm assuming (but have no proof) more than 50% of that
is just wasted memory.

I suspect that DMA is cache coherent on this thing, and that wasted
space is just *stupid* wasted space, but hey, I don't actually know. I
just use the Asahi people's patches.

               Linus
