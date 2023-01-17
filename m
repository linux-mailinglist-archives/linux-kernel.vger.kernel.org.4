Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B35966E70D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjAQTeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjAQTYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:24:22 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5622485A8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:33:59 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id b81so15221520vkf.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=27WlW4iebYEpp37p1l2V6Frv0TlUOFiXdW58IAriYVM=;
        b=NvzU4VWlAw329EaV4WmrknWoyZhqmU4sCrTZ1qb8Y/Isdl37ozdiJJnOSrcmerujxc
         6RIgGEiHXC5DfHG/0LrDZ6Wjg7lBg9nT6fV0VQpsFnKx355j0OTv/PWyd+0iw6p+7/ug
         o2Cpz64z1qNTKNXfXqwBHmG/cNxqgb1+WjNJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27WlW4iebYEpp37p1l2V6Frv0TlUOFiXdW58IAriYVM=;
        b=7yRaHsQtVQFH80wa57u3bU65NpGQn+7bvIjMc4HWzrYK3qo/642TGVehYtuORJ8r/j
         Ox36aZW4QT1Xwy6DtoYaX/9lXGt6s7Xe0tyMxKGeCzz43nnGAJDgUm4ckG1Rev7DgUfF
         K45HUNkeGXPdn1CznEFCFf99CjGHDhYId+44c986dO7LJlORsM5C08BgMClvd8yjdu5S
         BW0RTNVqQp8UsJudjhmWL7DXxjI3e1FQeyk1JWwQ5BZTNsZnrcxHSgMJrRVAUyvgBK3+
         qbuXVqEM4X5WqM1Xz7Sh1L6bbkLjpDFFlH6Z0XIRBw4awr3oEoOXq2NiQ9WvviWWav39
         4pLw==
X-Gm-Message-State: AFqh2koJwNvBoIugfRnJmAZzd7236vIRtmpAh2fHVzcXGE1yG4pXbe0N
        j3WNAXchnUACr6P8yJbvLGtj6y8njYinfI9s
X-Google-Smtp-Source: AMrXdXsqTGj0gB5oKbwnxHaf1RGBpHgUcCuid639vG/HVQmi5XwdQHCquM24hglDMs6Sc9AHOXt4XA==
X-Received: by 2002:a1f:aa01:0:b0:3af:2f59:88d5 with SMTP id t1-20020a1faa01000000b003af2f5988d5mr14248691vke.12.1673980438576;
        Tue, 17 Jan 2023 10:33:58 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a24cf00b007055dce4cecsm21061060qkn.97.2023.01.17.10.33.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 10:33:57 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id pa22so16597115qkn.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:33:57 -0800 (PST)
X-Received: by 2002:a05:620a:144a:b0:6ff:cbda:a128 with SMTP id
 i10-20020a05620a144a00b006ffcbdaa128mr197733qkl.697.1673980437301; Tue, 17
 Jan 2023 10:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-9-kirill.shutemov@linux.intel.com> <Y8adEg2CYUSVpwtk@hirez.programming.kicks-ass.net>
 <20230117135703.voaumisreld7crfb@box> <Y8a4bmCU9wsenvvF@hirez.programming.kicks-ass.net>
 <CAHk-=wiwiA7FdSww9fTg59r5S7G-DZHtzAcq9u5zBJKYXc1agQ@mail.gmail.com>
 <CAHk-=wj4HUBvCvfX3oZLZAZTzPc2vdwsObFqnOsQ-UZrdzm_rQ@mail.gmail.com> <CAKwvOdnCJmcGurUpHcdO44vVazz67jGDTXzug9LGv6C84xGmPw@mail.gmail.com>
In-Reply-To: <CAKwvOdnCJmcGurUpHcdO44vVazz67jGDTXzug9LGv6C84xGmPw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jan 2023 10:33:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjfmmYPw0wX1BW6gi_KAhdZi+81or024JFcRYHiQh-jpw@mail.gmail.com>
Message-ID: <CAHk-=wjfmmYPw0wX1BW6gi_KAhdZi+81or024JFcRYHiQh-jpw@mail.gmail.com>
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

On Tue, Jan 17, 2023 at 10:26 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jan 17, 2023 at 9:29 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Side note: that's not something new or unusual. It's been the case
> > since I started testing clang - we have several code-paths where we
> > use "unlikely()" to try to get very unlikely cases to be out-of-line,
> > and clang just mostly ignores it, or treats it as a very weak hint. I
> > think the only way to get clang to treat it as a *strong* hint is to
> > use PGO.
>
> I'd be surprised if that were intentional or by design.
>
> Do you guys have a bug report we could look at?

Heh. I actually sent you an example long ago. Let me go fish it out of
my mail archives and quote some of it below so that you can find it in
yours..

              Linus

[ Time passes. Found this email to you and Bill Wendling from Feb 16,
2020, Message-ID
CAHk-=wigVshsByCMjkUiZyQSR5N5zi2aAeQc+VJCzQV=nm8E7g@mail.gmail.com ]:

  Anyway, I'm looking at clang code generation, and comparing it with
  gcc on one of my "this has been optimized to hell and back" functions:
  __d_lookup_rcu().

  It looks like clang does frame pointers, and ignores our
  likely/unlikely annotations.

  So this code:

                if (unlikely(parent->d_flags & DCACHE_OP_COMPARE)) {
                        int tlen;
                        const char *tname;
                        ......

  doesn't actually jump out of line, but instead generates the unlikely
  case as the fallthrough:

        testb   $2, (%r12)
        je      .LBB50_9
        ... unlikely code goes here...

  and then the likely case ends up having unfortunate reloads inside the
  hot loop. Possibly because it has one fewer free registers than gcc
  because of the frame pointer.

  I didn't look into _why_ clang generates frame pointers but gcc
  doesn't. It may be just a compiler default, I think we don't end up
  explicitly asking either way.

[ And then Bill replied with this ]

  It's not a no-op. We add branch probabilities to the IR, whether
  they're honored or not depends on the transformation. But they
  *should* be honored when available. I've seen in the past that instead
  of moving unlikely blocks out of the way (like gcc, which moves them
  below the function's "ret" instruction), LLVM will do something like
  this:

    <normal code>
    <jmp to loop conditional test>
        <unlikely code>
        <more likely code>
    <loop conditional test>
    <...>

  I.e. the loop is rotated and the unlikely code is first and the hotter
  code is closer together but between the unlikely and conditional test.
  Could this be what's going on? Otherwise, maybe clang decided that
  it's not beneficial to move the code out-of-line because the benefit
  was minimal? (I'm guessing here.)
