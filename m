Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD17358F9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjFSN4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjFSN4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:56:12 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D9419C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:56:11 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-54fb3c168fcso2891075a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687182970; x=1689774970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4qVvgFOGP5lG2STwYbhhcifXhM7KwsnEag7M7GxbaU=;
        b=mqBC2bCHRGwRVWEnV4RRj7z2yEXrZ9c/s5jh971VamQHKXsP0jhqaODXkcNAWNzCh8
         6x/z8RtMdkGhLp++g5mP2aCYUacSBXWlbt+KyZC+Bh8mKxQ+xbWcL5g8Qf8M56rc+Tbm
         OJNW2BeHirQzRyW2tN7JkUuLInZ2bC71StUbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687182970; x=1689774970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4qVvgFOGP5lG2STwYbhhcifXhM7KwsnEag7M7GxbaU=;
        b=T5HDZue008YZnJU/NKpLrVBL+c5/FwFhazT976aR4ODXXgMdOoWrjvUvKtTVyQkRMh
         /zgd73UxJ5oqG3N1y5yB1YdP+8tH6WmPGQwqiSd7eOCaTXtNWAba/9w0Mds73ZAOxLom
         J9OmjbXZvSpbsOyuTLIj18/miJVbYO3DDJUjAS8B9GH/0FT0al2Biui4MbR8Gzo0bqg8
         ryhF33wfOeWhT173z323OBMXahU6fHYWhMHonb7rbxhyROzgny0hH8QMBF3kWttWnucS
         Lf0qw4GCSfeXq/PYsd+vT0zZjXnQCgsiXBRnnNHOo5h/dqO8bCazcR6oUnmna1FKfq54
         +tVA==
X-Gm-Message-State: AC+VfDzcZuCFFGtjwiuzjD/Ke+E1E7tuSekBXx06HKE3Hh0p5xidufCU
        XSpuiPeQM5csnvoOfIgrGQd7DpXwVX3a238OEZIsww==
X-Google-Smtp-Source: ACHHUZ7nNKwUY+sVJCe/t51WF3ftY3P14r1vQ/Bg6jEdoDr4w3Sjv/D3zod2phORxlfpRmbgSL3EeHgwx1G2veNxMOg=
X-Received: by 2002:a17:902:8c94:b0:1b1:a9e7:5d4b with SMTP id
 t20-20020a1709028c9400b001b1a9e75d4bmr9437925plo.22.1687182970381; Mon, 19
 Jun 2023 06:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230615145607.3469985-1-revest@chromium.org> <CABRcYm+C+tPwXAGnaDRR_U2hzyt+09fjkKBp3tPx6iKT4wBE2Q@mail.gmail.com>
 <fbd79f5f2b250ec913c78d91b94ca96fb96f67ee.camel@gmail.com> <CABRcYmLaummOg=Nf0qXVN2eci=25OqXLD0zpCUz4CgmTjvo9LA@mail.gmail.com>
In-Reply-To: <CABRcYmLaummOg=Nf0qXVN2eci=25OqXLD0zpCUz4CgmTjvo9LA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 19 Jun 2023 15:55:58 +0200
Message-ID: <CABRcYmKY_4_udQtsu7E9CVPruPphnejcgCvGnfHzzu-yc4Kshg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf/btf: Accept function names that contain dots
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, martin.lau@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 1:20=E2=80=AFPM Florent Revest <revest@chromium.org=
> wrote:
>
> On Thu, Jun 15, 2023 at 7:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Thu, 2023-06-15 at 17:44 +0200, Florent Revest wrote:
> > > An easy reproducer is:
> > >
> > > $ touch pwet.c
> > >
> > > $ clang -g -fsanitize=3Dkernel-address -c -o pwet.o pwet.c
> > > $ llvm-dwarfdump pwet.o | grep module_ctor
> > >
> > > $ clang -fno-integrated-as -g -fsanitize=3Dkernel-address -c -o pwet.=
o pwet.c
> > > $ llvm-dwarfdump pwet.o | grep module_ctor
> > >                 DW_AT_name      ("asan.module_ctor")
> >
> > Interestingly, I am unable to reproduce it using either
> > clang version 14.0.0-1ubuntu1 or clang main (bd66f4b1da30).
>
> Somehow, I didn't think of trying other clang versions! Thanks, that's
> a good point Eduard. :)
>
> I also can't reproduce it on a 14x build.
>
> However, I seem to be able to reproduce it on main:
>
>   git clone https://github.com/llvm/llvm-project.git
>   mkdir llvm-project/build
>   cd llvm-project/build
>   git checkout bd66f4b1da30
>   cmake -DLLVM_ENABLE_PROJECTS=3Dclang -DCMAKE_BUILD_TYPE=3DRelease -G
> "Unix Makefiles" ../llvm
>   make -j $(nproc)
>
>   bin/clang -fno-integrated-as -g -fsanitize=3Dkernel-address -c -o
> ~/pwet.o ~/pwet.c
>   bin/llvm-dwarfdump ~/pwet.o | grep module_ctor
>   # Shows module_ctor
>
> I started a bisection, hopefully that will point to something interesting

The bisection pointed to a LLVM patch from Nick in October 2022:
e3bb359aacdd ("[clang][Toolchains][Gnu] pass -g through to assembler")

Based on the context I have, that commit sounds fair enough. I don't
think LLVM does anything wrong here, it seems like BPF should be the
one dealing with dots in function debug info.
