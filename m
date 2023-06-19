Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A242735B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjFSPZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjFSPYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:24:54 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664E2FA;
        Mon, 19 Jun 2023 08:24:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b46f5f4d79so21804781fa.1;
        Mon, 19 Jun 2023 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687188291; x=1689780291;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tvsv/WghBZtMVC+4mKl//bfuiXAwAB2g1EzwWwnS4WY=;
        b=hmTfkVb+5LmAraeoRlAOtQU14wJrr/lgzvR+pDJxJ7X2TCQxz9veq5BwYSt39JR1um
         fKJGbSp1IWE5aslsjXPVUho0EMDZ4bRE6wJkt768yw0v+lxdELB77ZDd9nAmmmZLEbVs
         D5VHK5W0jz9fPmJsuYlOrMqoaZsr1vOK50OzAz39gP4y7j64wNGVM9ekZSm1jDo7bCrc
         4tnCoZrgax2KIniW6LeEd1BtaYeYEgjtXZI2VS5n/n+3+R6XGkHtZKJiuNAVGUdP64Tp
         jnx6X0d68TpmsanR2eHuE4wuWo0Y9n4ZGdtl29klrSRgrKYxtDCQEt1lu0b/ZrmfwuxK
         5k7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687188291; x=1689780291;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tvsv/WghBZtMVC+4mKl//bfuiXAwAB2g1EzwWwnS4WY=;
        b=X/wCmEFUwOZ/+K0qwwxL1AgRoIdNjP8RFj69XJQSji7lvkcrwUFoDYFA6JK4aKvfbS
         d+mWpD3HmmuV0itMSDfFMgtYVJCKaEXWYfkEq6bNBCoV3p0WjBmgkV1z22taOqXiXbRq
         9GBPFqEqVZYuRLrw8PEzlnvrnm8gYVg/hEtXPlythFYzrbw1A4bYEnnoGil6ngjb006m
         Ae67xZZNeU4tXRuoEPHIRjKrQU7RWhRvnHKq2qcppwiP3Ko7ftd3/BBzuOOUvdYYIlAz
         bCe9DokyFeUp1sKZFp+z1HUNWaWU8Zf3HV45gyY0AiuX7Be7eeLd/25V6Y2IYFR+jwHw
         8aRA==
X-Gm-Message-State: AC+VfDxTPmiMHOp1z4Jn8I4ezXq5Yycnb0TdGowJmso3Wdz7Hli1l/nR
        ybd4cZu/IPRoC7UpBI8KwD8=
X-Google-Smtp-Source: ACHHUZ7A1W0yVDwzsTAdsr/IbmVvuV/7c1xvRqXSQlsbE31LJj2Z0Ti8MaZzcSuz6xpu+pZnnF0n4A==
X-Received: by 2002:a2e:b5cc:0:b0:2b4:7500:3094 with SMTP id g12-20020a2eb5cc000000b002b475003094mr1308798ljn.3.1687188291342;
        Mon, 19 Jun 2023 08:24:51 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id 15-20020a05651c008f00b002b47e824518sm388769ljq.76.2023.06.19.08.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:24:50 -0700 (PDT)
Message-ID: <478f608e3b8de1218798c792b34dca75fa91f6a9.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf/btf: Accept function names that contain dots
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, martin.lau@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        stable@vger.kernel.org
Date:   Mon, 19 Jun 2023 18:24:49 +0300
In-Reply-To: <CABRcYmKY_4_udQtsu7E9CVPruPphnejcgCvGnfHzzu-yc4Kshg@mail.gmail.com>
References: <20230615145607.3469985-1-revest@chromium.org>
         <CABRcYm+C+tPwXAGnaDRR_U2hzyt+09fjkKBp3tPx6iKT4wBE2Q@mail.gmail.com>
         <fbd79f5f2b250ec913c78d91b94ca96fb96f67ee.camel@gmail.com>
         <CABRcYmLaummOg=Nf0qXVN2eci=25OqXLD0zpCUz4CgmTjvo9LA@mail.gmail.com>
         <CABRcYmKY_4_udQtsu7E9CVPruPphnejcgCvGnfHzzu-yc4Kshg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-06-19 at 15:55 +0200, Florent Revest wrote:
> On Mon, Jun 19, 2023 at 1:20=E2=80=AFPM Florent Revest <revest@chromium.o=
rg> wrote:
> >=20
> > On Thu, Jun 15, 2023 at 7:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >=20
> > > On Thu, 2023-06-15 at 17:44 +0200, Florent Revest wrote:
> > > > An easy reproducer is:
> > > >=20
> > > > $ touch pwet.c
> > > >=20
> > > > $ clang -g -fsanitize=3Dkernel-address -c -o pwet.o pwet.c
> > > > $ llvm-dwarfdump pwet.o | grep module_ctor
> > > >=20
> > > > $ clang -fno-integrated-as -g -fsanitize=3Dkernel-address -c -o pwe=
t.o pwet.c
> > > > $ llvm-dwarfdump pwet.o | grep module_ctor
> > > >                 DW_AT_name      ("asan.module_ctor")
> > >=20
> > > Interestingly, I am unable to reproduce it using either
> > > clang version 14.0.0-1ubuntu1 or clang main (bd66f4b1da30).
> >=20
> > Somehow, I didn't think of trying other clang versions! Thanks, that's
> > a good point Eduard. :)
> >=20
> > I also can't reproduce it on a 14x build.
> >=20
> > However, I seem to be able to reproduce it on main:
> >=20
> >   git clone https://github.com/llvm/llvm-project.git
> >   mkdir llvm-project/build
> >   cd llvm-project/build
> >   git checkout bd66f4b1da30
> >   cmake -DLLVM_ENABLE_PROJECTS=3Dclang -DCMAKE_BUILD_TYPE=3DRelease -G
> > "Unix Makefiles" ../llvm
> >   make -j $(nproc)
> >=20
> >   bin/clang -fno-integrated-as -g -fsanitize=3Dkernel-address -c -o
> > ~/pwet.o ~/pwet.c
> >   bin/llvm-dwarfdump ~/pwet.o | grep module_ctor
> >   # Shows module_ctor
> >=20
> > I started a bisection, hopefully that will point to something interesti=
ng
>=20
> The bisection pointed to a LLVM patch from Nick in October 2022:
> e3bb359aacdd ("[clang][Toolchains][Gnu] pass -g through to assembler")
>=20
> Based on the context I have, that commit sounds fair enough. I don't
> think LLVM does anything wrong here, it seems like BPF should be the
> one dealing with dots in function debug info.

That explains why I could not reproduce the issue: I tried with gas 2.38.
Using gas 2.40 I see the same behavior as you.

If one tries to generate assembly file with '-fsanitize':

  $ clang -fno-integrated-as -g -fsanitize=3Dkernel-address -S -o pwet.s pw=
et.c
  $ cat pwet.s
  	.text
  	.file	"pwet.c"
  	.p2align	4, 0x90                         # -- Begin function asan.module=
_ctor
  	.type	asan.module_ctor,@function
  asan.module_ctor:                       # @asan.module_ctor
  .Lfunc_begin0:
      ...

And then compile it using Gnu assembler:

  $ as --64 -o pwet.o pwet.s -g -gdwarf-5

The behavior differs between 2.38 and 2.40, the older version does not
produce debug entry for 'asan.module_ctor', while newer does.

