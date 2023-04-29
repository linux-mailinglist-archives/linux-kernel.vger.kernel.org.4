Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B5A6F2351
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 08:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjD2GSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 02:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjD2GSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 02:18:46 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F6F2117
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 23:18:44 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54fc94476e2so9048267b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 23:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1682749123; x=1685341123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIfYcthJ+TPfJNRTmAdJqt9c2uvFhKicl3bxPihBf6I=;
        b=U9jCNyGFy05B877UsZG+7hPr4wnRYw9yuxowqjyjfIXXMmg9nvuDcf03eaCYc0Yk87
         hWKUlBxIdgRGeJlyht7hX3szJopjtFZXHZpT1IGnfdKM5Ngmhk+KkIqghTAJenUA/E5o
         o3vao44b9fvEvvrgCoa2ob5U8MM97hc0/Vhck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682749123; x=1685341123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIfYcthJ+TPfJNRTmAdJqt9c2uvFhKicl3bxPihBf6I=;
        b=cNZyv6ikQrjVhtfAzBeKXv7DSu0xGvaJDNkH+bEp8AMFf7T0BeMNRH2x3IyS3Vntu+
         /jyoK2hfRfJXwQgv5MV5eMEt6UhA1aLMmLJ2a1ROdCN9Z0PF7KPDyqKhPlRMXAP0PmEL
         KrbAtRODty9++QfkvlOCaJGP1Bo6U+Ik+rEbsp0fGsFw99cw49Ado6y4ppc03zhFxnCW
         hNA6I4uhCct0AJaXr+FTNMPudDhqUZMd1S8dpEepF8TrVueXcWrtZT4ANBBdPXLLaUwr
         h6P9Xd0mnr4osRH+kq9zriT8DggSeUewW1oOlJaNPxkzleIlz//jGXmgq11JdZq81VXn
         SoUg==
X-Gm-Message-State: AC+VfDwZmFMoJL/evXaZGcUzNNccp9AC++nysxYiHtUeh06zchPSIJ5o
        OpQtSxCm+sOdtVFTzhMQcrXId3U1fOBENNqTDJPtPQ==
X-Google-Smtp-Source: ACHHUZ5F+CbvRlgHnAOkwEAdJALwlrkCRZc0Z6GpZLDRmi4jzMJNVIo/lZCAdYw5NzYx3E6JKjm2rAN/BHqcPmmCzos=
X-Received: by 2002:a81:4854:0:b0:54f:9e38:81c7 with SMTP id
 v81-20020a814854000000b0054f9e3881c7mr6531424ywa.50.1682749123236; Fri, 28
 Apr 2023 23:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230414005309.GA2198310@google.com> <CAKwvOd=yQS+0oDC46Hc5D_V0JET8=xbQmAJrpBdg7c4i2EyqHg@mail.gmail.com>
 <CAKwvOdk+D6HuWwAH3EJtwDyPqoiP+2z62ek2hnmbhDV2CJwnbw@mail.gmail.com>
 <CALGbS4V+x1JkiPL2o59LgtbSQhzg_RKM5TYE7i7qZx0qz23y-g@mail.gmail.com> <CAFP8O3KQRbmgyvuyuxNOa6TZ7MawN7YoGHvpFQ=oibEo3aUfDQ@mail.gmail.com>
In-Reply-To: <CAFP8O3KQRbmgyvuyuxNOa6TZ7MawN7YoGHvpFQ=oibEo3aUfDQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 29 Apr 2023 02:18:32 -0400
Message-ID: <CAEXW_YRkkgx30Lo7NN=zyBCEAWaH8VSo+r=0ySA-D1iehUnoyA@mail.gmail.com>
Subject: Re: clangd cannot handle tree_nocb.h
To:     Fangrui Song <maskray@google.com>
Cc:     Florent Revest <revest@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        rcu@vger.kernel.org, nathan@kernel.org, trix@redhat.com,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, "revest@chromium.org" <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fangrui/Florent/David/All:

Sorry for the late reply, I got distracted.

On Wed, Apr 19, 2023 at 4:02=E2=80=AFPM Fangrui Song <maskray@google.com> w=
rote:
>
> On Wed, Apr 19, 2023 at 6:00=E2=80=AFAM Florent Revest <revest@google.com=
> wrote:
> >
> > On Tue, Apr 18, 2023 at 6:28=E2=80=AFPM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > + Florent
> >
> > Hi there!
> >
> > > Joel, Florent is doing some cool stuff with clangd and kernels (check
> > > out the demo at go/linux-kernel-vscode).  I'm pushing Florent to
> >
> > Apologies for folks outside Google, this is an internal link to a
> > kernel dev setup I originally created for myself, then for my team and
> > apparently more and more people are starting to use it internally. :)
> > If there's enough appetite for it externally too, I'll try to
> > open-source it someday. Anyway, in the context of this conversation,
> > it's just something that uses clangd. :)
> >
> > > publish some of the cool stuff he's been working on externally becaus=
e
> > > it is awesome. ;)
> > >
> > > Florent, have you seen any such issues such as what Joel reported bel=
ow?
> >
> > Yes, I've seen this problem a bunch of times. Afaiu, Clangd operates
> > under the assumption that every source file is a valid compilation
> > unit. My understanding is that it's generally a good practice to keep
> > things that way and I wouldn't be surprised if the userspace Chrome
> > code-base Joel saw enforces this (iirc, it's a rule for
> > Google-internal C++ too, all headers must be interpretable
> > independently).
> >
> > However, from the perspective of the C spec, anything can be included
> > anywhere and a C file can only make sense if it's included
> > after/before certain other things are defined/included. Spontaneously,
> > I would call these ".inc" rather than ".h" or ".c" because I would
> > expect a source file to be always valid and this suffix makes it
> > clearer they depend on their context, but as a matter of fact source
> > files that don't compile when interpreted individually are quite
> > common in the kernel tree. Other examples that have been reported to
> > me include a lot of kernel/sched/*, since many of these files
> > (including .c files) are included from kernel/sched/build_policy.c in
> > a specific order to form one big compilation unit.
> >
> > Unfortunately, I don't know of any solution. :( This feels like a
> > limit of C or compile_commands.json to me. "compile commands" can not
> > be enough to interpret any file, clangd would need a way to express
> > "interpret this file as if it were included in that spot of that
> > compilation unit" and maybe even need a bunch of heuristics to choose
> > one such include spot.
> >
> > I don't know if clangd has any plan to address this and so far I've
> > just lived with these error squiggles.
> >
>
> Some information about Clang based language servers
>
> It's good practice to ensure that a header file is self-contained. If
> not, for example, if a.c includes a.h, which is not self-contained,
> a.h is generally compiled on its own (as if using clang [options] a.h)
> to confine diagnostics/completion results to a.h and not to other
> headers included by a.c.
>
> However, this design choice may cause language servers to emit
> diagnostics that you don't see when building the project.
>
> For my tool ccls, the index file for an included file (e.g. a.h) is
> computed when compiling the main source file (a.c). Therefore, if the
> project builds successfully, the index is always accurate.
>
> Language servers usually have the limitation that only one
> configuration of a main source file is recorded, e.g., you only get
> index data for either clang -DA=3D1 a.c or clang -DA=3D2 a.c, not both.
> This limitation exists due to technical challenges and practicality.
> If a main source file has 10 configurations, when you edit the file,
> do you compile it 10 times to get all indexes?

Indeed regarding the 10 configs points you brought up. The .h not
being 1:1 with compilation units makes it a similar problem.

For example, if I edit a.h and a.h is included in both b.c and c.c.
Then, in order to know if edits I am making to a.h really will not
lead to build errors, clangd has to compile both b.c and c.c
separately. Why?

Because a.h's inclusion in b.c may build successfully, but in c.c may
not! This generalizes to any number of source files.

However, I was thinking of a scheme such as the following:

Have a file class Clangd.yaml in the source directory of a .h. In this
file, clearly state how to build the .h. For the above example, for
changes to a.h -- the YAML will say include a.h and then b.c , and
then build the combined thing.  Then a script like the one building
compile_commands.json can use the YAML to generate something useful
for the .h  That may not work for every usecase such as the one David
pointed out, but at least it will be somewhat useful for most use
cases -- versus what we currently do for the issue (nothing).

But even if you edit the .h, the compiler errors typically end up
showing up in the .c files. So even clangd says, there is a build
error in the combined result -- can it really pinpoint where in the .h
is the issue? My observation is clangd will point errors within the
thing that is being compiled (i.e. the .c file) and not the include
file.

Other Thoughts?  On the process side of things, is there a place I can
file a bug report where some of this may be interesting to a team
working on this?

 - Joel
