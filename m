Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4773E6E8249
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjDSUCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDSUCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:02:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FD0468C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:02:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a652700c36so232875ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681934534; x=1684526534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56W2W/X8fkj8VZX3/1DTAaK9+j9FvXQXuYPz0XAniuc=;
        b=Tm+PqrTiBoRJA04/Kl60G2CqwjByx5la8XcHF9okQZRzsClYBxiJTHt0YG5c7Ih8mT
         LqiugknROCpyehmf+fFE2yLXzkxa7RRDDerSCmGNO6gj8wHE1MUCc2qXLU1NwoxWHQTN
         PB/mAP8j6XUow6402YryLB5jYviHopAJ4iYiURfF9qoPqv16Riw+InNihTXtwAWmPte2
         WzvgnJ1CLUIbSsA3WkAuSE2s+YmMzyBgHqf77zkPrj56JYAOdVHMo01j2j2szEV7YTIA
         39nPjEODCVxQsypbfnaq1e0jji5goKJ9EUboMoqyesJEob+LeW9h6gbLFLLBA+vTiinI
         dJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681934534; x=1684526534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56W2W/X8fkj8VZX3/1DTAaK9+j9FvXQXuYPz0XAniuc=;
        b=SnldDf3qOyRO9HC80ZAbBXApkUaFeuaObHBYGawYdzD+WnwCT6LE0rjXxNu5Bigw/G
         ndtSZdGHPHSCbLpuT7xE9hYe/FqIoohJP7mT94HXVhGupdRcExE5gDt/Xhs2sd5JrCsF
         gjxFQyRFvTlljRwt/2PP07vYqTRxD3X3y10HNhNdTYYwoz1ca2qWSKG7ZMSTtE3/UZ9d
         hIc0PKSKakNrfJbd0JmIUYLA1z6MkikXZS8/nNlELJr9UBlEL4eQrkfuB3w9ARqSs81/
         EaRqI+ARVPRsRfqBjFKuqMkTU6B7LLtaxl9BmSdzWFZj776lulw+v75M46gd13zHffxh
         wiYQ==
X-Gm-Message-State: AAQBX9e8Kwq+WfVqAHsHdEz3FQ5FKWdYPPl0EVT8JBgIBeShmsjvyrM7
        Ggb9GK7e2yin9ANuddz6Qnzaf8eZNIUOFs+Sr7v/1vhzd0Vz079ozt7VyQ==
X-Google-Smtp-Source: AKy350bP2Be/0rsmuq+XyQQsawPtRMQK0eA/jETVaSN8vBy4wBas0Titboop37b7IKAN7OP4R+HvW5JzRwQ8J+LMRZI=
X-Received: by 2002:a17:903:228c:b0:198:af4f:de12 with SMTP id
 b12-20020a170903228c00b00198af4fde12mr49157plh.18.1681934534077; Wed, 19 Apr
 2023 13:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230414005309.GA2198310@google.com> <CAKwvOd=yQS+0oDC46Hc5D_V0JET8=xbQmAJrpBdg7c4i2EyqHg@mail.gmail.com>
 <CAKwvOdk+D6HuWwAH3EJtwDyPqoiP+2z62ek2hnmbhDV2CJwnbw@mail.gmail.com> <CALGbS4V+x1JkiPL2o59LgtbSQhzg_RKM5TYE7i7qZx0qz23y-g@mail.gmail.com>
In-Reply-To: <CALGbS4V+x1JkiPL2o59LgtbSQhzg_RKM5TYE7i7qZx0qz23y-g@mail.gmail.com>
From:   Fangrui Song <maskray@google.com>
Date:   Wed, 19 Apr 2023 13:02:02 -0700
Message-ID: <CAFP8O3KQRbmgyvuyuxNOa6TZ7MawN7YoGHvpFQ=oibEo3aUfDQ@mail.gmail.com>
Subject: Re: clangd cannot handle tree_nocb.h
To:     Florent Revest <revest@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        nathan@kernel.org, trix@redhat.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        "revest@chromium.org" <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 6:00=E2=80=AFAM Florent Revest <revest@google.com> =
wrote:
>
> On Tue, Apr 18, 2023 at 6:28=E2=80=AFPM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > + Florent
>
> Hi there!
>
> > Joel, Florent is doing some cool stuff with clangd and kernels (check
> > out the demo at go/linux-kernel-vscode).  I'm pushing Florent to
>
> Apologies for folks outside Google, this is an internal link to a
> kernel dev setup I originally created for myself, then for my team and
> apparently more and more people are starting to use it internally. :)
> If there's enough appetite for it externally too, I'll try to
> open-source it someday. Anyway, in the context of this conversation,
> it's just something that uses clangd. :)
>
> > publish some of the cool stuff he's been working on externally because
> > it is awesome. ;)
> >
> > Florent, have you seen any such issues such as what Joel reported below=
?
>
> Yes, I've seen this problem a bunch of times. Afaiu, Clangd operates
> under the assumption that every source file is a valid compilation
> unit. My understanding is that it's generally a good practice to keep
> things that way and I wouldn't be surprised if the userspace Chrome
> code-base Joel saw enforces this (iirc, it's a rule for
> Google-internal C++ too, all headers must be interpretable
> independently).
>
> However, from the perspective of the C spec, anything can be included
> anywhere and a C file can only make sense if it's included
> after/before certain other things are defined/included. Spontaneously,
> I would call these ".inc" rather than ".h" or ".c" because I would
> expect a source file to be always valid and this suffix makes it
> clearer they depend on their context, but as a matter of fact source
> files that don't compile when interpreted individually are quite
> common in the kernel tree. Other examples that have been reported to
> me include a lot of kernel/sched/*, since many of these files
> (including .c files) are included from kernel/sched/build_policy.c in
> a specific order to form one big compilation unit.
>
> Unfortunately, I don't know of any solution. :( This feels like a
> limit of C or compile_commands.json to me. "compile commands" can not
> be enough to interpret any file, clangd would need a way to express
> "interpret this file as if it were included in that spot of that
> compilation unit" and maybe even need a bunch of heuristics to choose
> one such include spot.
>
> I don't know if clangd has any plan to address this and so far I've
> just lived with these error squiggles.
>

Some information about Clang based language servers

It's good practice to ensure that a header file is self-contained. If
not, for example, if a.c includes a.h, which is not self-contained,
a.h is generally compiled on its own (as if using clang [options] a.h)
to confine diagnostics/completion results to a.h and not to other
headers included by a.c.

However, this design choice may cause language servers to emit
diagnostics that you don't see when building the project.

For my tool ccls, the index file for an included file (e.g. a.h) is
computed when compiling the main source file (a.c). Therefore, if the
project builds successfully, the index is always accurate.

Language servers usually have the limitation that only one
configuration of a main source file is recorded, e.g., you only get
index data for either clang -DA=3D1 a.c or clang -DA=3D2 a.c, not both.
This limitation exists due to technical challenges and practicality.
If a main source file has 10 configurations, when you edit the file,
do you compile it 10 times to get all indexes?

---

My setup is like this. I have been doing it since about 2019, though I
rarely read Linux kernel code :(

Ensure you have the following Clang and LLVM tools. If you build them
by yourself, create a llvm-project build directory, say, /tmp/Rel
```
ninja -C /tmp/Rel clang lld
llvm-{ar,nm,objcopy,objdump,ranlib,readelf,strings,strip}
```

In a Linux kernel source directory,
(https://github.com/MaskRay/ccls/wiki/Example-Projects)
```
PATH=3D/tmp/Rel/bin:$PATH make O=3D/tmp/out/x86_64 ARCH=3Dx86_64 LLVM=3D1 d=
efconfig
PATH=3D/tmp/Rel/bin:$PATH make O=3D/tmp/out/x86_64 ARCH=3Dx86_64 LLVM=3D1 -=
k
bzImage modules  # generate .<target>.cmd files

scripts/clang-tools/gen_compile_commands.py -d /tmp/out/x86_64
```

emacs -nw fs/binfmt_elf.c   # check out lsp-mode and eglot

For neovim, use https://github.com/neoclide/coc.nvim or the built-in
client. I prefer coc.nvim.


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
