Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC6673BE9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjFWSxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjFWSw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:52:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D471BD2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:52:57 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b477e9d396so16069401fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687546375; x=1690138375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CMWwB5zzoupqeze3ME9YKWWoAX1dTedhi9arjRqeau8=;
        b=fan6tNSJM/Q8QaNRAQZqNGAYyzDhbXARufMEhDRg5ZCHet5r3gGFTxCRpEgoLJT6M5
         vavjXNiHRHhQka4M7JN2fWSO2jYSygtrF3jztlJQ0VHXBIJJBRc+DIIjQVFoScO1Z6bA
         Q6KGRX3LlrIjd2DB+T1rMcSzpQNNfnxYngJTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687546375; x=1690138375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMWwB5zzoupqeze3ME9YKWWoAX1dTedhi9arjRqeau8=;
        b=HB7g0YVhB7PPFAN+kqmJdOPdNVALeVC3HE/zmhb1BCcamdq3rbuwSl81xAA0L1uHi7
         kdn7aQsDQc5LbXYzlmnKasgdrxKHJIabWT9tTaEZZCLbBx1qoF1cpD/UI8Uzgx5uMpBm
         WE6Vxi/iujp4f3zp7EuPC+hbNxici/flWNYPmpQnXp32jyoNE6sCUl+N2PlG4vr8S/PN
         aFJQlqxO0CgCkANm7YZMmIaY8RVx+RwukTDE5IyF7bVpYGdvUM/QMV2IocZox0kMcquo
         2zrpt3iu5xjuCkQTjSxftdxP+TjjDLKxqqtfFh/STJk9FnUa8tdLgxQkJbGrlqSDxpax
         Gw6w==
X-Gm-Message-State: AC+VfDzJwQB5BxmtrOWgu2J5imnlsmmuRp8klg/LGdou8fuE1C0GywLv
        +apVZIJB22sHWeDFLLi/tG+ezy8dCFZ3RFMKugfAiAGV
X-Google-Smtp-Source: ACHHUZ7SR61lIBoCdtZlQRDdSX0BWNRGxOZ+2WxwxYyhHq6kN5+v84EW+61w3V9EoNg9JC+wpRIPcA==
X-Received: by 2002:a2e:3816:0:b0:2b5:68ad:2921 with SMTP id f22-20020a2e3816000000b002b568ad2921mr10200757lja.28.1687546375090;
        Fri, 23 Jun 2023 11:52:55 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id u22-20020aa7d996000000b0051bfb7de166sm777188eds.39.2023.06.23.11.52.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 11:52:54 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51be61663c8so1001596a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:52:54 -0700 (PDT)
X-Received: by 2002:aa7:db89:0:b0:51a:265a:8fca with SMTP id
 u9-20020aa7db89000000b0051a265a8fcamr13544034edt.27.1687546374192; Fri, 23
 Jun 2023 11:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
 <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
In-Reply-To: <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 11:52:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9p+oJtzC0582vke8whcWPNSC9eq0Z6kdnSqWMEpah7g@mail.gmail.com>
Message-ID: <CAHk-=wg9p+oJtzC0582vke8whcWPNSC9eq0Z6kdnSqWMEpah7g@mail.gmail.com>
Subject: Re: arm32 build warnings in workqueue.c
To:     Dave Airlie <airlied@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding clang people. See this for background:

    https://lore.kernel.org/all/CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com/

  where that patch not only cleans things up, but seems to make a
difference to clang ]

On Fri, 23 Jun 2023 at 11:24, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I really think that code needs fixing, and the gcc warning was very valid.
>
> Maybe something like the attached. Does this fix the gcc warning?
> Tejun, comments?

Whee. Inexplicably, that patch also improves code generation with
clang, with things like this:

-       movabsq $137438953440, %rcx             # imm = 0x1FFFFFFFE0
-       andq    %rax, %rcx
-       movabsq $68719476704, %rdx              # imm = 0xFFFFFFFE0
-       cmpq    %rdx, %rcx
+       shrq    $5, %rax
+       cmpl    $2147483647, %eax               # imm = 0x7FFFFFFF

in several places.

Or, even more amusingly, this:

-       movabsq $68719476704, %rax              # imm = 0xFFFFFFFE0
-       orq     $1, %rax
+       movabsq $68719476705, %rax              # imm = 0xFFFFFFFE1

where the old code was some truly crazy stuff.

I have *no* idea what drugs clang is on, but clearly clang does some
really really bad things with large enums, and doesn't simplify things
correctly.

That "I can't even do a constant 'or' at compile time when it involves
an enum" is all kinds of odd.

Does this matter in the big picture? No. But I think the take-away
here should be that you really shouldn't use enums for random things.
Compilers know enums are used as small enumerated constants, and get
pissy and confused when you use them as some kind of generic storage
pool for values.

My guess is that clang keeps an enum as an enum as long as possible -
including past some (really) simple simplification phases of the
optimizer.

With gcc, code generation didn't change from that patch with my
defconfig on x86-64 (apart from line numbers changing).

Now, clang improving code generation with that patch is obviously a
good thing for the patch, but it does mean that clang really messed up
before.

               Linus
