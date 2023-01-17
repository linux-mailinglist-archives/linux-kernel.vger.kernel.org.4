Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3E2670B69
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjAQWLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAQWKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:10:24 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B844447EE5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:44:16 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h21so28115461qta.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/8VAQBZJw6HVtjrG/2YG/pHlRsdBpU1CtimfojJQFw4=;
        b=NaF0mTKXGLsZlvV/feMeBjnEe9X4ZZaaFt+H7wStvQtVHCvNlMtjziUMrcwGR9AmK8
         pOwV+xNrzbgIGpeuNzcyXz848TXcUjB4OQIjHdRXltt1EInK8pSBvoPmwJj/cBJJ9DNt
         RUi2v4qmFvsl54XqffZV2GuqwTRlO8ybzrZbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8VAQBZJw6HVtjrG/2YG/pHlRsdBpU1CtimfojJQFw4=;
        b=MXSwkfbQYzLRdBAAl31yIvEFEcoZGGxmk5+gPjU3309A27uyRlsFskoFH0sYIfi5Nh
         KPgealDRDIzwLitjq3hJG+WsjbO8dLJo2Fl/p4iOFj7oQlfpuQ1tDMqeYQ0oUOMuYs43
         4wz/4m3wIWJoCmteJAINmtFwrxR4Rap2l567o5fuuHOetcZPfWQc41N2fJSXaGopdsqc
         8PqCXzZQGUjSoZ8ahjeCXQuebFq1xsA531UkZ2kAZQwCHOE/yQsz6IpbmuToiHb22s5d
         90JguNj/4FZaXX2jU1V8uq/AGFwlwmcJ16KiKWodGdgkVT2WpZYizKMwtgp7xtwaufDs
         R/5w==
X-Gm-Message-State: AFqh2krYBwwmbRGU3Efke8rZWb4xNy51U+zGo8kV1KFLuQ9yL0Ita30u
        q+BhFL/lu2MCdv9I7FzkxoJ/JsWbvbxIJpck
X-Google-Smtp-Source: AMrXdXvpq/s3DxfeUBnABRrMVdnqZEuR7uaX1ungYHTGUsH7eKy7dDv9FAuoldTNPdYN590XEb9yNw==
X-Received: by 2002:a05:622a:1dc4:b0:3a8:efd:2ef0 with SMTP id bn4-20020a05622a1dc400b003a80efd2ef0mr4680202qtb.60.1673988255424;
        Tue, 17 Jan 2023 12:44:15 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id bz25-20020a05622a1e9900b003a591194221sm1285773qtb.7.2023.01.17.12.44.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 12:44:14 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id u20so6132084qvq.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:44:13 -0800 (PST)
X-Received: by 2002:ad4:50a9:0:b0:532:31b0:b4fa with SMTP id
 d9-20020ad450a9000000b0053231b0b4famr295229qvq.129.1673988253652; Tue, 17 Jan
 2023 12:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-9-kirill.shutemov@linux.intel.com> <Y8adEg2CYUSVpwtk@hirez.programming.kicks-ass.net>
 <20230117135703.voaumisreld7crfb@box> <Y8a4bmCU9wsenvvF@hirez.programming.kicks-ass.net>
 <CAHk-=wiwiA7FdSww9fTg59r5S7G-DZHtzAcq9u5zBJKYXc1agQ@mail.gmail.com>
 <CAHk-=wj4HUBvCvfX3oZLZAZTzPc2vdwsObFqnOsQ-UZrdzm_rQ@mail.gmail.com>
 <CAKwvOdnCJmcGurUpHcdO44vVazz67jGDTXzug9LGv6C84xGmPw@mail.gmail.com>
 <CAHk-=wjfmmYPw0wX1BW6gi_KAhdZi+81or024JFcRYHiQh-jpw@mail.gmail.com>
 <CAKwvOd=fcF=y-mBtPZ9QcVe++__jo11St4=+roPKrGh5D6FH_g@mail.gmail.com> <CAHk-=wggKAKq1k0Z+EdWR0W9ULM7x9MhEbd_LmU2XPLM9WcjkQ@mail.gmail.com>
In-Reply-To: <CAHk-=wggKAKq1k0Z+EdWR0W9ULM7x9MhEbd_LmU2XPLM9WcjkQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jan 2023 12:43:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wieCWumOHyPkhjJPUMpFr=OLSv2-dYvQV63GAT5zGnN5g@mail.gmail.com>
Message-ID: <CAHk-=wieCWumOHyPkhjJPUMpFr=OLSv2-dYvQV63GAT5zGnN5g@mail.gmail.com>
Subject: Re: [PATCHv14 08/17] x86/mm: Reduce untagged_addr() overhead until
 the first LAM user
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        joao@overdrivepizza.com
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

On Tue, Jan 17, 2023 at 12:10 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said, clang still generates more register pressure than gcc,
> causing the function prologue and epilogue to be rather bigger
> (pushing and popping six registers, as opposed to gcc that only needs
> three)

.. and at least part of that is the same thing with the bad byte mask
generation (see that "clang *still* messes up" link for details).

Basically, the byte mask is computed by

        mask = bytemask_from_count(tcount);

where we have

   #define bytemask_from_count(cnt)       (~(~0ul << (cnt)*8))

and clang tries very very hard to avoid that "multiply by 8", so
instead it keeps a shadow copy of that "(cnt)*8" value in the loop.

That is wrong for a couple of reasons:

 (a) it adds register pressure for no good reason

 (b) when you shift left by that value, only the low 6 bits of that
value matters

And guess how that "tcount" is updated? It's this:

                tcount -= sizeof(unsigned long);

in the loop, and thus the update of that shadow value of "(cnt)*8" is done as

        addl    $-64, %ecx

inside that loop.

This is truly stupid and wasted work, because the low 6 bits of the
value - remember, the only part that matters - DOES NOT CHANGE when
you do that.

So clang has decided that it needs to

 (a) avoid the "expensive" multiply-by-8 at the end by turning it into
a repeated "add $-64" inside the loop

 (b) added register pressure and one extra instruction inside the loop

 (c) not realized that that extra instruction doesn't actually *do*
anything, because it only affects the bits that don't actually matter
in the end.

which is all kind of silly, wouldn't you agree. Every single step
there was pointless.

But with my other simplifications, the fact that clang does these
extra things is no longer all that noticeable. It *used* to be a
horrible disaster because the extra register pressure ended up meaning
that you had spills and all kinds of nastiness. Now the function is
simple enough that even with the extra register pressure, there's no
need for spills.

.. until you look at the 32-bit version, which still needs spills. Gcc
does too, but clang just makes it worse by having the extra pointless
shadow variable.

If I cared about 32-bit, I might write up a bugzilla entry. As it is,
it's just "clang tries to be clever, and in the process is actually
being stupid".

              Linus
