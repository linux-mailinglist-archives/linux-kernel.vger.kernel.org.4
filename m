Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC2D6A28FB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 11:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBYKWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 05:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBYKWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 05:22:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D842012051;
        Sat, 25 Feb 2023 02:22:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B19160ABF;
        Sat, 25 Feb 2023 10:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29B8C4339B;
        Sat, 25 Feb 2023 10:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677320548;
        bh=fir4MyA39fIdu3mUdWlmNHF/xsctMupr8qWqbsYQ4bg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cJ7YJVFKfeDFvrxrzMnmgkOF/9roKOnHlRUgdIlfhCbxBCpCcQBSnK+IIylhGo+J+
         cOusKjk8jOXPtt2XNl2ZGUY2WCGknSP4doJJkMw5C0lD7Hhu2urLVHjddQKZy+w1ta
         kBfBOPFaA2e+/po2RHcyoXSZJHY2Iy9n5wh6KyQBuZSzgBBxygD6LpxSBIRt6aS3NJ
         1QUEbyqgObw28m6EuowGXK2ehSj5ap35wgqq6KLTZAnRvL4Sb87Bdq1YNiCB9x7fH/
         L+mB/KOwjFfY8A3FVLdnh8wNzDQ+3O9gKD/m06JChxIZCiWfMUGT1VNBykuf/66BbK
         GlCAfpNHBglSA==
Received: by mail-ot1-f54.google.com with SMTP id cc12-20020a05683061cc00b00693daa9016fso1016736otb.2;
        Sat, 25 Feb 2023 02:22:28 -0800 (PST)
X-Gm-Message-State: AO0yUKUjEFnLoaf3KoPENTclM0HT2lHT+sjN0MJwGeCr2+0yIfkoz5FT
        vJ8VQsx05UVwWgXqfqHkwHaff//H+v2r3WMUl1M=
X-Google-Smtp-Source: AK7set/QChlc19+yIC07qjidvdK3A5gePT+alO3/lbgde0H9A/XhOLiD/1cFxzyX0I8LYXDUFilz6lJ0bf01r4Rf5pI=
X-Received: by 2002:a05:6830:26c2:b0:68b:df73:951e with SMTP id
 m2-20020a05683026c200b0068bdf73951emr2689413otu.1.1677320548005; Sat, 25 Feb
 2023 02:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20230223001607.95523-1-andrealmeid@igalia.com>
 <CAK7LNAQbzWQs3WzsdyLsCyFD_2Kgz8sqjqk+nFXkEXQFrYobRA@mail.gmail.com> <cadf9320-366c-da33-5fb4-30575533b04e@igalia.com>
In-Reply-To: <cadf9320-366c-da33-5fb4-30575533b04e@igalia.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 25 Feb 2023 19:21:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNATkBnkD3-=Y3V5QRqX0tKwVCO_DAq_NUH0qwis63dVwEQ@mail.gmail.com>
Message-ID: <CAK7LNATkBnkD3-=Y3V5QRqX0tKwVCO_DAq_NUH0qwis63dVwEQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: modinst: Enable multithread xz compression
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kernel-dev@igalia.com, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 9:13 PM Andr=C3=A9 Almeida <andrealmeid@igalia.com>=
 wrote:
>
> Hi Masahiro,
>
> Em 24/02/2023 02:38, Masahiro Yamada escreveu:
> > On Thu, Feb 23, 2023 at 9:17 AM Andr=C3=A9 Almeida <andrealmeid@igalia.=
com> wrote:
> >>
> >> As it's done for zstd compression, enable multithread compression for
> >> xz to speed up module installation.
> >>
> >> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >> ---
> >>
> >> On my setup xz is a bottleneck during module installation. Here are th=
e
> >> numbers to install it in a local directory, before and after this patc=
h:
> >>
> >> $ time make INSTALL_MOD_PATH=3D/home/tonyk/codes/.kernel_deploy/ modul=
es_install -j16
> >> Executed in  100.08 secs
> >>
> >> $ time make INSTALL_MOD_PATH=3D/home/tonyk/codes/.kernel_deploy/ modul=
es_install -j16
> >> Executed in   28.60 secs
> >
> >
> > Heh, this is an interesting benchmark.
> >
> > Without this patch, you ran 16 processes of 'xz' in parallel
> > since you gave -j16.
> >
> > You created multi-threads in each xz process, then you got 3x faster.
> > What made it happen?
> >
> >
>
> During the modules installation in my setup, the build system would
> spend most of it's time compressing big modules (such as the 350M
> amdgpu.ko) in a single thread, with 15 idles threads. Enabling
> multithread allowed amdgpu to be compressed really fast.

It is a corner case, isn't it?
amdgpu.ko appears early in modules.order.
In most use-cases, other *.ko will fill the idle threads.


xz(1) says
  Setting threads to a special value 0 makes xz use up to as many threads
  as the processor(s) on the system support.


So, 'make -j$(nproc) modules_install'
will have (nproc * nproc) threads at maximum.

Of course, this is a theoretical calculation.
The actual number of spawned threads will be much less,
but spawning too many threads may not be nice.
For your case, Nathan's suggestion will do.




>
> The real performance improvement during modules compression is not
> compressing as many small modules as possible in parallel, but
> compressing the big ones in multithread, that proved to be the
> bottleneck in my setup.
>
>  > How many threads can your system run?
>
> $ nproc
> 16
>
> >
> > I did not get such an improvement in my testing.
> > In my machine $(nproc) is 24.
> >
> >
> > [Without this patch]
> >
> > $ time make INSTALL_MOD_PATH=3D/tmp/inst1  modules_install -j$(nproc)
> >
> > real 0m33.965s
> > user 10m6.118s
> > sys 0m37.231s
> >
> > [With this patch]
> >
> > $ time make INSTALL_MOD_PATH=3D/tmp/inst1  modules_install -j$(nproc)
> >
> > real 0m32.568s
> > user 10m4.472s
> > sys 0m39.132s
> >
> >
>
> I can see that my patch did not introduce performance regressions to
> your setup, at least.
>
> >
> > Given that GNU Make provides the parallel execution environment,
> > you can control the number of processes of 'xz'.
> >
> > There is no point in forcing multi-threading, which the user
> > did not ask or ever want.
> >
> >
>
> Should we drop -T0 from zstd then? Is currently forcing multi-threading.


I think yes.



--
Best Regards
Masahiro Yamada
