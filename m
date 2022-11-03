Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CD36189AB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKCUjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCUjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:39:37 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC97DFFB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:39:36 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w4so2043976qts.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 13:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LyVB93e4kr6HW490iz0JjvkzkF10jJfiYRfzQXQPofc=;
        b=ZfICdQ57uGJHF4OYcToaJcO61Joxd+rQUqggVs6a4vRPpvw5Vg54PJ58xxIdXvxuR7
         zlTLX3eFjDabEVsc4tJElGaQSKA4jjYcEmtdv287OJpRHbf4noPP9LpSbndleJQO4hwl
         65BMPDDrdnF7ZtDk3UTn91+OJFiO1xFMmPe5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyVB93e4kr6HW490iz0JjvkzkF10jJfiYRfzQXQPofc=;
        b=6nsRctY3P3dAmg1iFwOKJNG7H2Ain3rIjF0jCmN0QbjWdVu+MSaWiid44QMjRJ47Oi
         EOUjJtCfj8MqqWW3cZqJhZ5Te/QdPV+nI17oPtm3SpG1mmNQSgKBNo37JID5LPDRnaDX
         GBc9dPJXfJukfOhe+esL4TNwU5J/cttPmTcOA1iGnAP+MOXmcFjqCC+o9ARUNtzZyvhP
         UO/DcCdykqHa8gCm4QiHWFpTte2DPG8ksblASezV/Sx5372hezNe+bx8O7Kj/UC0qJU+
         dT5a55yDddwnuUt7A84JsHHvyqckYuTp3SAXKBHqM/x5KP4RqHflHQ8dY1z/JIKGr01H
         /a7A==
X-Gm-Message-State: ACrzQf2f+iJbKoWQUKmWggEo+sSfADS2QRcbJm3NuFRt54vkcgHelMoZ
        6vUNeSnPvarZ9ltlftrHvEAzU1vlZ6QEsA==
X-Google-Smtp-Source: AMsMyM7ve9J2m3AaesgOx+zGQZpWf7tWkZqOGZmI5EnXYULszMPXT+jZf8LJ1k9qUVKOSwmpJBrixg==
X-Received: by 2002:a05:622a:3cf:b0:3a5:d1d:a258 with SMTP id k15-20020a05622a03cf00b003a50d1da258mr26466620qtx.109.1667507975448;
        Thu, 03 Nov 2022 13:39:35 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id z13-20020ac86b8d000000b0039a55f78792sm1088743qts.89.2022.11.03.13.39.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 13:39:33 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id b16so3665161yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 13:39:33 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr32776102ybu.310.1667507973048; Thu, 03
 Nov 2022 13:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114425.168036718@infradead.org>
 <Y2QR/BRHjjYUNszh@dev-arch.thelio-3990X> <CAFULd4bkn3i0ds1ywhxAZBQH+1O-zbPWscUqjoEcv4xvnxOnSw@mail.gmail.com>
 <Y2QYHZsZNs33NXZB@dev-arch.thelio-3990X>
In-Reply-To: <Y2QYHZsZNs33NXZB@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Nov 2022 13:39:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCBOwSWec+=h08q3Gbr4UjSfX46GrQjzHZLFokziS7nA@mail.gmail.com>
Message-ID: <CAHk-=wjCBOwSWec+=h08q3Gbr4UjSfX46GrQjzHZLFokziS7nA@mail.gmail.com>
Subject: Re: [PATCH 11/13] x86_64: Remove pointless set_64bit() usage
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de
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

On Thu, Nov 3, 2022 at 12:36 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Thanks, I also realized that only a couple minutes after I sent my
> initial message. I just got done testing the following diff, which
> resolves my issue.

That looks obviously correct.

Except in this case "obviously correct patch" is to some very
non-obvious code, and I think the whole code around it is very very
questionable.

I had to actually go check that this code can only be enabled on
x86-64 (because "IRQ_REMAP" has a "depends on X86_64" on it), because
it also uses cmpxchg_double and that now exists on x86-32 too (but
only does 64 bits, not 128 bits, of course).

Now, to make things even more confusing, I think that

    #if defined(CONFIG_HAVE_CMPXCHG_DOUBLE)

has *never* made sense, since it's always enabled for x86.

HOWEVER - there were actually early AMD x86-64 machines that didn't
have CMPXCHG16B. So the conditional kind of makes sense, but doing it
based on CONFIG_HAVE_CMPXCHG_DOUBLE does not.

It turns out that we do do this all correctly, except we do it at boot
time, with a test for boot_cpu_has(X86_FEATURE_CX16):

        /*
         * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
         * XT, GAM also requires GA mode. Therefore, we need to
         * check cmpxchg16b support before enabling them.
         */
        if (!boot_cpu_has(X86_FEATURE_CX16) ||
              ...

but that #ifdef has apparenrly never been valid (I didn't go back and
see if we at some point had a config entry for those old CPUs).

And even after I checked *that*, I then checked the 'struct irte' to
check that it's actually properly defined, and it isn't. Considering
that this all requires 16-byte alignment to work, I think that type
should also be marked as being 16-byte aligned.

In fact, I wonder if we should aim to actually force compile-time
checking, because right now we have

        VM_BUG_ON((unsigned long)(p1) % (2 * sizeof(long)));
        VM_BUG_ON((unsigned long)((p1) + 1) != (unsigned long)(p2));

in our x86-64 __cmpxchg_double() macro, and honestly, that first one
might be better as a compile time check of __alignof__, and the second
one shouldn't exisrt at all because our interface shouldn't be using
two different pointers when the only possible use is for one single
aligned value.

If somebody actually wants the old m68k type of "DCAS" that did a
cmpxchg on two actually *different* pointers, we should call it
somethign else (and that's not what any current architecture does).

So honestly, just looking at this trivially correct patch, I got into
a rats nest of horribly wrong code. Nasty.

               Linus
