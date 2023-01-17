Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C633E66E4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjAQR2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjAQRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:25:58 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D59442C5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:25:56 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d16so14798204qtw.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6HSheNmlAClWC6vMTM9BSa0fSEOlMS/5u5Jz6BQdsnk=;
        b=D2K9yYaITqvsffWwjNqR0hHtUrPyIVa/JmS5mqTqRIG9kbwWP5A46y9Xv5sEnUZONg
         f+9iudv6g8t1ikG4S0IXghWrgbgxfC+RQpkzFmOAKmPZx5gUmxRHRC1YgZP5I6pOM7y8
         n2lnDlUYraU6+0Kdnn4Pb0QLSlOo5EQAHG46s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HSheNmlAClWC6vMTM9BSa0fSEOlMS/5u5Jz6BQdsnk=;
        b=xPLWgZP3mZmbOlvOGxcrQUdC70uGRhrYXF4lSmQxtmgYtl+NM5mLkhRyk9S0b/Tq7a
         WxOqlk6A7ZCdluweNof8bU8BipSQKdYd4gHx8f+GEfrafLGCoF6+g9YlX1TQ7y9pBQPc
         q2kepwrssTp0v2R9fmirkNMqs9veRvTBm4fCrNmiealXF7AjI2WEOzWuLSOh2kKJ/f8D
         N7TUA9MRi2Tt2HEd+mDuqN1W7+iMwNkjxPO3LnCQC/q+6joGQ3gGI5TZU+cSXP7mh/sO
         3lGpLRZWMaUTCnAVS5QWyVqqgZeEVOxYbJT8HpOXBCYB674jODL+vDiK2RN8BfFGXWpk
         aPPA==
X-Gm-Message-State: AFqh2korrGvtLa1EIIt3GMNS2XqtjZ91W7tK60fB6L2W2gpBPOauvfEV
        RcpE84qFFvuGWYDoTGOwSIIqTV2mhuW+yj3T
X-Google-Smtp-Source: AMrXdXsSd65GGgbaLV98SBPkQle70CgLUFCvF1vYxLN6rkUOhEq98K+9unqcam5bZXtHMOncYjYmag==
X-Received: by 2002:ac8:65cb:0:b0:3b6:2e8b:3363 with SMTP id t11-20020ac865cb000000b003b62e8b3363mr4673346qto.52.1673976355661;
        Tue, 17 Jan 2023 09:25:55 -0800 (PST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id g6-20020ac84b66000000b003b63d181cd3sm1184458qts.70.2023.01.17.09.25.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 09:25:55 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id d13so7821704qkk.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:25:55 -0800 (PST)
X-Received: by 2002:a37:6387:0:b0:706:92f4:125 with SMTP id
 x129-20020a376387000000b0070692f40125mr201159qkb.72.1673975898327; Tue, 17
 Jan 2023 09:18:18 -0800 (PST)
MIME-Version: 1.0
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-9-kirill.shutemov@linux.intel.com> <Y8adEg2CYUSVpwtk@hirez.programming.kicks-ass.net>
 <20230117135703.voaumisreld7crfb@box> <Y8a4bmCU9wsenvvF@hirez.programming.kicks-ass.net>
In-Reply-To: <Y8a4bmCU9wsenvvF@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jan 2023 09:18:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiwiA7FdSww9fTg59r5S7G-DZHtzAcq9u5zBJKYXc1agQ@mail.gmail.com>
Message-ID: <CAHk-=wiwiA7FdSww9fTg59r5S7G-DZHtzAcq9u5zBJKYXc1agQ@mail.gmail.com>
Subject: Re: [PATCHv14 08/17] x86/mm: Reduce untagged_addr() overhead until
 the first LAM user
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        ndesaulniers@google.com, joao@overdrivepizza.com
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

On Tue, Jan 17, 2023 at 7:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 17, 2023 at 04:57:03PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Jan 17, 2023 at 02:05:22PM +0100, Peter Zijlstra wrote:
> > > On Wed, Jan 11, 2023 at 03:37:27PM +0300, Kirill A. Shutemov wrote:
> > >
> > > >  #define __untagged_addr(untag_mask, addr)
> > > >   u64 __addr = (__force u64)(addr);                               \
> > > > - s64 sign = (s64)__addr >> 63;                                   \
> > > > - __addr &= untag_mask | sign;                                    \
> > > > + if (static_branch_likely(&tagged_addr_key)) {                   \
> > > > +         s64 sign = (s64)__addr >> 63;                           \
> > > > +         __addr &= untag_mask | sign;                            \
> > > > + }                                                               \
> > > >   (__force __typeof__(addr))__addr;                               \
> > > >  })
> > > >
> > > > #define untagged_addr(addr) __untagged_addr(current_untag_mask(), addr)
> > >
> > > Is the compiler clever enough to put the memop inside the branch?
> >
> > Hm. You mean current_untag_mask() inside static_branch_likely()?
> >
> > But it is preprocessor who does this, not compiler. So, yes, the memop is
> > inside the branch.
> >
> > Or I didn't understand your question.
>
> Nah, call it a pre-lunch dip, I overlooked the whole CPP angle -- d'0h.
>
> That said, I did just put it through a compiler to see wth it did and it
> is pretty gross:

Yeah, I think the static branch likely just makes things worse.

And if we really want to make the "no untag mask exists" case better,
I think the code should probably use static_branch_unlikely() rather
than *_likely(). That should make it jump to the masking code, and
leave the unmasked code as a fallthrough, no?

The reason clang seems to generate saner code is that clang seems to
largely ignore the whole "__builtin_expect()", at least not to the
point where it tries to make the unlikely case be out-of-line.

But on the whole, I think we'd be better off without this whole static branch.

The cost of "untagged_addr()" generally shouldn't be worth this. There
are few performance-crticial users - the most common case is, I think,
just mmap() and friends, and the single load is going to be a
non-issue there.

Looking around, I think the only situation where we may care is
strnlen_user() and strncpy_from_user(). Those *can* be
performance-critical. They're used for paths and for execve() strings,
and can be a bit hot.

And both of those cases actually just use it because of the whole
"maximum address" calculation to avoid traversing into kernel
addresses, so I wonder if we could use alternatives there, kind of
like the get_user/put_user cases did. Except it's generic code, so ..

But maybe even those aren't worth worrying about. At least they do the
unmasking outside the loop - although then in the case of execve(),
the string copies themselves are obviously done in a loop anyway.

Kirill, do you have clear numbers for that static key being a noticeable win?

                 Linus
