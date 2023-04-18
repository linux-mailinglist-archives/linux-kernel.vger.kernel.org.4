Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832A66E6981
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjDRQ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjDRQ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:28:17 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A561B744
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:28:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fw22-20020a17090b129600b00247255b2f40so35644pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681835295; x=1684427295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg7+zV4NSB6viBP2KzrSgH4qbGRSZleBqwHL94BVLGo=;
        b=0/6DsPiDHSSaXXKmGoAmwZreYEXCQE1lTa8DjLHyg3HFWkxsEkifdKCCokZcwclg8/
         Qidpfqh5qXZnVpJeRTCShVUqNq0WbDacEK1gZ3mI6K5OIqbRZpcWp0EhcvaTznNs9Hzx
         6f1eQdVJSxPNf0jIDMxjwbcswuuWGVs8C3aLHg23LpDFnEqUQXvNLGphtVNxy6qj0A29
         asKzBqb21uJZ/Fr55rOKReK1HLaHtIwG22gAL06h+Th4H3yVx7aZmPB+i1H3dl1m/Mfo
         /Z2J7ai/0e1zMpEV27sYhsWChJlinm+tTCD3m58np4ua8GiyG0k10HWcl8N5zqKBG4E7
         r4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835295; x=1684427295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gg7+zV4NSB6viBP2KzrSgH4qbGRSZleBqwHL94BVLGo=;
        b=OBv/P2O67d7lC1k+hEjT65Eg44xTD2ne7QLBK/fCEOydR0CZmScjo2WaBb5+eHik3i
         cu1aC+M0vOKq0ye4FqCM6iGfKDxHwrJeOQE2xEUkGRK8kPQHUr0j88bg8ogaMQPnQqwA
         BE4EtBpyJeJF7DtcDIiQ7XabRrXt5kcPpXFKZ38dInPriJnqgxCoWBi1pmPKt+yzvz+r
         i8zlJCBhjuGSBeFSIJ83ddq/bjHfFUGQJcDI0bKc8/b8onPb6iZnR9MNwSWU/o7ND+bM
         8WRaUPZHVilHrprymNz1Omy9WT494OYrSvvSQf9av6KWs/Jufwqg4PWwKZpn650msLF4
         cqEw==
X-Gm-Message-State: AAQBX9dfMkxhIKcJMBKDpichFJZNiN4GLIbBpQHh3usWiRQhY1hIvyBv
        m1xgyv8uIfhm65cTo2xKGJRWyHCvNfq4OZD4pJ9JXw==
X-Google-Smtp-Source: AKy350ads55xeGW5KbL/vPnE9RhcNLgCaUD41EkAnLuTjGQCbY8SQXdr2NjRO8xG0Po5dFCxf9tlLzRZN84isAOfw70=
X-Received: by 2002:a05:6a20:914c:b0:ee:2f91:206b with SMTP id
 x12-20020a056a20914c00b000ee2f91206bmr450137pzc.1.1681835295278; Tue, 18 Apr
 2023 09:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230414005309.GA2198310@google.com> <CAKwvOd=yQS+0oDC46Hc5D_V0JET8=xbQmAJrpBdg7c4i2EyqHg@mail.gmail.com>
In-Reply-To: <CAKwvOd=yQS+0oDC46Hc5D_V0JET8=xbQmAJrpBdg7c4i2EyqHg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Apr 2023 09:28:03 -0700
Message-ID: <CAKwvOdk+D6HuWwAH3EJtwDyPqoiP+2z62ek2hnmbhDV2CJwnbw@mail.gmail.com>
Subject: Re: clangd cannot handle tree_nocb.h
To:     Joel Fernandes <joel@joelfernandes.org>,
        Florent Revest <revest@google.com>
Cc:     rcu@vger.kernel.org, nathan@kernel.org, trix@redhat.com,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        paulmck@kernel.org
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

+ Florent

Joel, Florent is doing some cool stuff with clangd and kernels (check
out the demo at go/linux-kernel-vscode).  I'm pushing Florent to
publish some of the cool stuff he's been working on externally because
it is awesome. ;)

Florent, have you seen any such issues such as what Joel reported below?

On Fri, Apr 14, 2023 at 3:47=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Apr 13, 2023 at 5:53=E2=80=AFPM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> >
> > Hello!
> >
> > I have been trying to get clangd working properly with tree_nocb.h. cla=
ngd
> > trips quite badly when trying to build tree_nocb.h to generate ASTs.
>
> Hi Joel,
> Thanks for the report.  What are you using clangd for? I'll bet
> something interesting.
>
> I've never used it myself, so I don't know where to even begin with
> how to reproduce the issue.
>
> It might be worth filing a bug upstream at
> https://github.com/llvm/llvm-project/issues
> or internally under the component
> Language Platforms > C++ > Clang > Tools > Clangd
> with detailed steps to reproduce (and what the observed error actually
> is). Feel free to cc me, though I don't know the first thing about
> clangd.
>
> >
> > I get something like this in the clangd logs showing it 'infers' how to=
 build
> > tree_nocb.h because it could not find a command in compile_commands.jso=
n:
> >
> > ASTWorker building file [..]/tree_nocb.h version 9 with command inferre=
d from
> > [..]/kernel/rcu/tree.c
> >
> > This leads to all hell breaking lose with complaints about missing rcu_=
data
> > struct definition and so forth.
> >
> > So far I came up with a workaround as follows, but is there a better wa=
y?
> >
> > 1. Open compile_commands.json and add a new entry as follows, with a
> > definition "-DNOCB_H_CLANGD_PARSE". Otherwise the entry is indentical t=
o how
> > tree.c is built.
> >
> >   {
> >     "arguments": [
> >       "/usr/bin/clang",
> >       "-Wp,-MMD,kernel/rcu/.treenocb.o.d",
> >       "-nostdinc",
> >       "-I./arch/x86/include",
> >       "-I./arch/x86/include/generated",
> >       "-I./include",
> >       "-I./arch/x86/include/uapi",
> > [...]
> >       "-Wformat-zero-length",
> >       "-Wnonnull",
> >       "-Wformat-insufficient-args",
> >       "-Wno-sign-compare",
> >       "-Wno-pointer-to-enum-cast",
> >       "-Wno-tautological-constant-out-of-range-compare",
> >       "-Wno-unaligned-access",
> >       "-DKBUILD_MODFILE=3D\"kernel/rcu/tree\"",
> >       "-DKBUILD_BASENAME=3D\"tree\"",
> >       "-DKBUILD_MODNAME=3D\"tree\"",
> >       "-D__KBUILD_MODNAME=3Dkmod_tree",
> >       "-DNOCB_H_CLANGD_PARSE",
> >       "-c",
> >       "-I",
> >       "/s/",
> >       "-I",
> >       "/s/",
> >       "-o",
> >       "kernel/rcu/tree_nocb.h.o",
> >       "kernel/rcu/tree_nocb.h"
> >     ],
> >     "directory": "/usr/local/google/home/joelaf/repo/linux-master",
> >     "file": "/usr/local/google/home/joelaf/repo/linux-master/kernel/rcu=
/tree_nocb.h",
> >     "output": "/usr/local/google/home/joelaf/repo/linux-master/kernel/r=
cu/tree_nocb.h.o"
> >   },
> >
> > 2.
> > Then in kernel/tree/tree_nocb.h, I do the following right in the beginn=
ing.
> > (Thanks to paulmck@ for this idea).
> >
> > #ifdef NOCB_H_CLANGD_PARSE
> > #include "tree.c"
> > #endif
> >
> > 3. To prevent the above inclusion of tree.c from recursively including
> > tree_nocb.h, I do the following at the end of tree.c
> >
> > +#ifndef NOCB_H_CLANGD_PARSE
> >  #include "tree_nocb.h"
> > -#include "tree_plugin.h"
> > +#endif
> > +#include "tree_plugin.h"
> >
> > With that it works, but if I ever generate compile_commands.json again,=
 then
> > I'll have to again modify compile_commands.json manually to make my edi=
tor
> > work again with clangd.
> >
> > So I guess my questions are:
> >
> > 1. Is there a 'standard' procedure to solve something like this?
> >
> > 2. How do we fix this the right way?
> >    One way would be for scripts/clang-tools/gen_compile_commands.py to =
parse
> >    header files and generate suitable compile_commands.json based on
> >    meta-data in the header file.
> >
> > 3. How do we fix this for other header files in general? Do we have to =
make hacks like
> >    above (sad face) or can we come up with a standard way to make it wo=
rk for kernel
> >    sources?
> >
> > Thank you!
> >
> >  - Joel
> >
> >
> >
> >
> >
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
