Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEB7656E28
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiL0TK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiL0TKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:10:50 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C8AD116
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:10:49 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id z12so11135039qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ala6gezAzOfA3A3+kxaw4LGN1hrXw5q3ThDReQX0bOs=;
        b=Aq+2ymtxux+AtiI6SM1Qao0amZsbwS0ltaNHroJ1yK+FXjtMBIs4FZ/ap33ecVvtop
         zLMLr3qZTfkf+X7A2HhvWFboTHPoyDfdayA+DKXHj8wMG8eeFJ0JpgFReEC98ZD8BAYu
         yyBev6KA6UgXGxdqumz7UzO+CDDcI10az/6YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ala6gezAzOfA3A3+kxaw4LGN1hrXw5q3ThDReQX0bOs=;
        b=ALuIcenPtRr5bA/lmX6yMvZW3i+0VZT7xUDWHvEXq4eS9svUbo1ZSBWge2xk/cZbtw
         PbwAB5oZWQLoyJHdyavA6oPKcjBCIhLh+HY78BKLNnrTYc8M6ZWQG7uB3Z2HESe/5u6b
         zlLWA82X4H4HiNPTnm2T9Vtmk8WtFg5eB877tW+PbPtXP4+rJXcYyFv3tAfZchFHq2So
         fBPeWmYNbhzKKYTo7Imr+xKpWHnegqqYelCtguBy9fhI0C1lOCodeAKtuxAQ+uaAaKCi
         48HCc7bDqud/EznU2RdCypmRBZfiGU4K4iDKSSxQX5qAO96YuWfifKf8ro6XZva5mEw+
         jRMw==
X-Gm-Message-State: AFqh2kpUzu7zNcBn3ErvtPh0Vch4yoWlx+k/ULnIenQZz3Gdspq+bStR
        AI3GkbPqpC2otHf3LJhqXa3Q5VosnyKD638R
X-Google-Smtp-Source: AMrXdXvt4wEJmrT0ockLXrnESnfio2J0BEA3fff+AardSIoW98CX77gsymk2P0gjAis+5x53Swto2Q==
X-Received: by 2002:a05:622a:4205:b0:3a5:3cb5:2485 with SMTP id cp5-20020a05622a420500b003a53cb52485mr29164636qtb.0.1672168248099;
        Tue, 27 Dec 2022 11:10:48 -0800 (PST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id l14-20020ac848ce000000b003a820f9fb70sm8723717qtr.36.2022.12.27.11.10.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 11:10:48 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id p17so8028829qvn.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:10:47 -0800 (PST)
X-Received: by 2002:a05:6214:1185:b0:4c6:608c:6b2c with SMTP id
 t5-20020a056214118500b004c6608c6b2cmr1025269qvv.130.1672168247410; Tue, 27
 Dec 2022 11:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20221227030829.12508-1-kirill.shutemov@linux.intel.com> <20221227030829.12508-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20221227030829.12508-6-kirill.shutemov@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Dec 2022 11:10:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgKTcOx1hhWAGJ-g9_9o7xiGJ9v9n2RskBSCkaUMBxDkw@mail.gmail.com>
Message-ID: <CAHk-=wgKTcOx1hhWAGJ-g9_9o7xiGJ9v9n2RskBSCkaUMBxDkw@mail.gmail.com>
Subject: Re: [PATCHv13 05/16] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
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
        linux-kernel@vger.kernel.org
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

On Mon, Dec 26, 2022 at 7:08 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -21,6 +22,37 @@ static inline bool pagefault_disabled(void);
>  # define WARN_ON_IN_IRQ()
>  #endif
>
> +#ifdef CONFIG_X86_64

I think this should be CONFIG_ADDRESS_MASKING or something like that.

This is not a "64 vs 32-bit feature". This is something else.

Even if you then were to select it unconditionally for 64-bit kernels
(but why would you?) it reads better if the #ifdef's make sense.

> +#define __untagged_addr(mm, addr)      ({                              \
> +       u64 __addr = (__force u64)(addr);                               \
> +       s64 sign = (s64)__addr >> 63;                                   \
> +       __addr &= READ_ONCE((mm)->context.untag_mask) | sign;           \

Now the READ_ONCE() doesn't make much sense. There shouldn't be any
data races on that thing.

Plus:

> +#define untagged_addr(addr) __untagged_addr(current->mm, addr)

I think this should at least allow caching it in 'current' without the
mm indirection.

In fact, it might be even better off as a per-cpu variable.

Because it is now in somewhat crititcal code sections:

> -#define get_user(x,ptr) ({ might_fault(); do_get_user_call(get_user,x,ptr); })
> +#define get_user(x,ptr)                                                        \
> +({                                                                     \
> +       might_fault();                                                  \
> +       do_get_user_call(get_user,x,untagged_ptr(ptr)); \
> +})

This is disgusting and wrong.

The whole reason we do do_get_user_call() as a function call is
because we *don't* want to do this kind of stuff at the call sites. We
used to inline it all, but with all the clac/stac and access_ok
checks, it all just ended up ballooning so much that it was much
better to make it a special function call with particular calling
conventions.

That untagged_ptr() should be done in that asm function, not in every call site.

Now, the sad part is that we got *rid* of all this kind of crap not
that long ago when Christoph cleaned up the old legacy set_fs() mess,
and we were able to make the task limit be a constant (ok, be _two_
constants, depending on LA57). So we'd have to re-introduce that nasty
"look up task size dynamically". See commit 47058bb54b57 ("x86: remove
address space overrides using set_fs()") for the removal that would
have to be re-instated.

But see above about "maybe it should be a per-cpu variable" - and
making that ALTERNATIVE th8ing even nastier.

Another alternative mght be to *only* test the sign bit in the
get_user/put_user functions, and just take the fault instead. Right
now we warn about non-canonical addresses because it implies somebody
might have missed an access_ok(), but we'd just mark those
get_user/put_user accesses special.

That would get this all entirely off the critical path. Most other
address masking is for relatively rare things (ie mmap/munmap), but
the user accesses are hot.

Hmm?

             Linus
