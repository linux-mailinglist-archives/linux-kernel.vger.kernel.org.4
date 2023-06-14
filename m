Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C277E73016D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245464AbjFNOOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245465AbjFNOOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:14:01 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682631715
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:13:58 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-43f40006c48so565701137.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686752037; x=1689344037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/lhBcL8PdmZexLMneyEv/Gn9hUSFm3VXCVDLTnVzqY=;
        b=IE2ZBrX/096j0CEQLIUIkj3jA66V9mddB6v8ac6SRJ9TDJEXg7/0cQmnIEqOFunHWn
         YYVCbiHUrFhwgKp46bkmEWuuZcnIsMFn3tPA4Cyd075PySjZNDPX01+m/q0UL/2iB7TG
         WfoHOpurwygr5aORfI68aEgIjBaor+tSvzCjHFkCPQDvxlHpYjObNZtCbYXRheLxV7AV
         E4d9hQkf5Dg/fmqpNi//WVo9ZIYvcLr0u619woIIZBzdkbOKASL8TOWrqDPKNVk3RoFA
         9RrambwMSpx49ohSPluuUpPJfK5KAwVwk2hZEUF4bOUEsj7DJKqcRdr2hBMvmaxvVbLX
         VRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686752037; x=1689344037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/lhBcL8PdmZexLMneyEv/Gn9hUSFm3VXCVDLTnVzqY=;
        b=BkKTRmKwL6fisaP399phmtFm7qn8jKOyDtNnvXYcpHLrtHGY7JYjeCdNTwtkt96DPT
         oroUbiOVPtoYwaVWC9dFEtmYKbZW6r5lW5UIIq1zTWc0N9qlnwZV5imjV/NJwGWf36aV
         Wq4O9/lfw82ynrgQU2UFdjw+omF9zkP+g+U/M35CQNiY/IUBGbGkMXh5Po0aGWy0Yf7f
         hXkRiiFgst0vg6a9oyGZLxMOZwJS5GksYcsdSV6E21qpE+G84EdGkR71RhY1ReiRZJlY
         bT3Se005jRfO1mpj2+f4+DY2pkuaBXra/6WhTbLAn+T1NNkSw9INAFve9yY8DhEzVWYf
         0rOA==
X-Gm-Message-State: AC+VfDwr84+BkaXooLR6wtHJpIXrwEkPZbWA7tzQhG1eogV5ZF9xwZRF
        9WV2t1zCr12owgAx8frvjQXRXJiwmrCcJjPQQdoQPw==
X-Google-Smtp-Source: ACHHUZ7IgTjMs3w5UlStqcOEigI5kidG9B+ujD++WFwvUgi7uH9u3I5/+rh/wkwAF23Cmkcs9+Ru7SL6kUdvrr0HtsA=
X-Received: by 2002:a05:6102:3da:b0:43f:37d6:22a7 with SMTP id
 n26-20020a05610203da00b0043f37d622a7mr2443149vsq.13.1686752037313; Wed, 14
 Jun 2023 07:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsJq0sPC+q6vLNKUgBqCGmmjDrfeP4R1-95Eu28FJRY_A@mail.gmail.com>
 <20230612185424.GA2891387@dev-arch.thelio-3990X> <CA+G9fYtX6YNqmz9vxJxa5cA5Uf2rr=RNM0nkoTzRpg79Azp2tA@mail.gmail.com>
In-Reply-To: <CA+G9fYtX6YNqmz9vxJxa5cA5Uf2rr=RNM0nkoTzRpg79Azp2tA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 14 Jun 2023 19:43:45 +0530
Message-ID: <CA+G9fYvmqz3nQ=Cgs=7J6vtRj=OhbNzgkLPmxxN+vOBTU=9zVA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_clang=3A_Powerpc=3A_clang=2Dnightly=2Dmaple=5Fdefconfig_?=
        =?UTF-8?Q?=E2=80=94_FAIL?=
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
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

Hi Nathan,

On Tue, 13 Jun 2023 at 09:57, Naresh Kamboju <naresh.kamboju@linaro.org> wr=
ote:
>
> Hi Nathan,
>
> On Tue, 13 Jun 2023 at 00:24, Nathan Chancellor <nathan@kernel.org> wrote=
:
> >
> > Hi Naresh,
> >
> > On Tue, Jun 13, 2023 at 12:10:30AM +0530, Naresh Kamboju wrote:
> > > [Please ignore if it is already reported]
> > >
> > > Following two builds failed on stable-rc 6.1.34-rc1.
> > >
> > >   - Powerpc: clang-nightly-maple_defconfig =E2=80=94 FAIL
> > >   - Powerpc: clang-nightly-cell_defconfig =E2=80=94 FAIL
> > >

> > As always, thanks for the report. This is an LLVM regression/change in
> > behavior caused by [1], which can break as-option and as-instr on
> > releases prior to commit d5c8d6e0fa61 ("kbuild: Update assembler calls
> > to use proper flags and language target"), as unsupported flags for the
> > current target ('-x') may be present (KBUILD_CFLAGS is used for these
> > tests instead of KBUILD_AFLAGS). Inside try-run, the macro behind
> > as-instr and as-option, I see
> >
> >   clang-17: error: unsupported option '-mno-prefixed' for target 'power=
pc64le-linux-gnu'
> >   clang-17: error: unsupported option '-mno-pcrel' for target 'powerpc6=
4le-linux-gnu'
> >   clang-17: error: unsupported option '-mno-altivec' for target 'powerp=
c64le-linux-gnu'
> >   clang-17: error: unsupported option '-mno-vsx' for target 'powerpc64l=
e-linux-gnu'
> >   clang-17: error: unsupported option '-mno-mma' for target 'powerpc64l=
e-linux-gnu'
> >   clang-17: error: unsupported option '-mno-spe' for target 'powerpc64l=
e-linux-gnu'
> >
> > This has come up recently elsewhere in PowerPC, see
> > commit 2b694fc96fe3 ("powerpc/boot: Disable power10 features after
> > BOOTAFLAGS assignment"). While I think it is dubious that clang errors
> > on these flags for the assembler target, this is already fixed on the
> > Linux side by using KBUILD_AFLAGS for these make macros.
> >
> > I am preparing a series of d5c8d6e0fa61 and its dependencies for 6.1 bu=
t
> > I want to do sufficient build testing first, which is currently running
> > for me. Would you be able to point your matrix to [2] to make sure
> > everything works properly with both GCC and LLVM? It is a work in
> > progress as the second patch in the stack needs a proper commit message
> > but it is the diff I expect to ship so that it all that matters.
>
> We'll start building [2] with GCC and LLVM by using tuxplans and
> get back to you.

LKFT has been configured to run GCC and LLVM in total 205 builds
and all the builds have passed on your tree / branch [2]. You can find
the list of builds including kselftest, perf, rcutorture, kunit, kmemleak
and many more combinations and architectures.

I request you to review the list of builds results and test results on
projects page [3] [4]. I do not find any regressions compared with
mainline master as sanity testing.

Do you think LKFT should build your tree / branch often ?
We are happy to test anytime.

Thanks Daniel and Anders for your work.

build_names: that got tested and all have passed.

  - clang-16-allnoconfig
  - clang-16-at91_dt_defconfig
  - clang-16-axm55xx_defconfig
  - clang-16-bcm2835_defconfig
  - clang-16-cell_defconfig
  - clang-16-clps711x_defconfig
  - clang-16-davinci_all_defconfig
  - clang-16-defconfig
  - clang-16-defconfig-40bc7ee5
  - clang-16-exynos_defconfig
  - clang-16-footbridge_defconfig
  - clang-16-imx_v4_v5_defconfig
  - clang-16-imx_v6_v7_defconfig
  - clang-16-integrator_defconfig
  - clang-16-keystone_defconfig
  - clang-16-lkftconfig
  - clang-16-lkftconfig-compat
  - clang-16-lkftconfig-kcsan
  - clang-16-lkftconfig-no-kselftest-frag
  - clang-16-lpc32xx_defconfig
  - clang-16-maple_defconfig
  - clang-16-mpc83xx_defconfig
  - clang-16-multi_v5_defconfig
  - clang-16-multi_v5_defconfig-65236a87
  - clang-16-mxs_defconfig
  - clang-16-nhk8815_defconfig
  - clang-16-omap1_defconfig
  - clang-16-omap2plus_defconfig
  - clang-16-orion5x_defconfig
  - clang-16-ppc64e_defconfig
  - clang-16-pxa910_defconfig
  - clang-16-s3c6400_defconfig
  - clang-16-s5pv210_defconfig
  - clang-16-sama5_defconfig
  - clang-16-shmobile_defconfig
  - clang-16-tinyconfig
  - clang-16-tqm8xx_defconfig
  - clang-16-u8500_defconfig
  - clang-16-vexpress_defconfig
  - clang-16-x86_64_defconfig
  - clang-nightly-allnoconfig
  - clang-nightly-at91_dt_defconfig
  - clang-nightly-axm55xx_defconfig
  - clang-nightly-bcm2835_defconfig
  - clang-nightly-cell_defconfig
  - clang-nightly-clps711x_defconfig
  - clang-nightly-davinci_all_defconfig
  - clang-nightly-defconfig
  - clang-nightly-defconfig-40bc7ee5
  - clang-nightly-exynos_defconfig
  - clang-nightly-footbridge_defconfig
  - clang-nightly-imx_v4_v5_defconfig
  - clang-nightly-imx_v6_v7_defconfig
  - clang-nightly-integrator_defconfig
  - clang-nightly-keystone_defconfig
  - clang-nightly-lkftconfig
  - clang-nightly-lpc32xx_defconfig
  - clang-nightly-maple_defconfig
  - clang-nightly-mpc83xx_defconfig
  - clang-nightly-multi_v5_defconfig
  - clang-nightly-multi_v5_defconfig-65236a87
  - clang-nightly-mxs_defconfig
  - clang-nightly-nhk8815_defconfig
  - clang-nightly-omap1_defconfig
  - clang-nightly-omap2plus_defconfig
  - clang-nightly-orion5x_defconfig
  - clang-nightly-ppc64e_defconfig
  - clang-nightly-pxa910_defconfig
  - clang-nightly-s3c6400_defconfig
  - clang-nightly-s5pv210_defconfig
  - clang-nightly-sama5_defconfig
  - clang-nightly-shmobile_defconfig
  - clang-nightly-tinyconfig
  - clang-nightly-tqm8xx_defconfig
  - clang-nightly-u8500_defconfig
  - clang-nightly-vexpress_defconfig
  - clang-nightly-x86_64_defconfig
  - gcc-11-allnoconfig
  - gcc-11-defconfig
  - gcc-11-dreamcast_defconfig
  - gcc-11-lkftconfig
  - gcc-11-lkftconfig-perf
  - gcc-11-microdev_defconfig
  - gcc-11-shx3_defconfig
  - gcc-11-tinyconfig
  - gcc-12-allnoconfig
  - gcc-12-ar7_defconfig
  - gcc-12-at91_dt_defconfig
  - gcc-12-ath79_defconfig
  - gcc-12-axm55xx_defconfig
  - gcc-12-bcm2835_defconfig
  - gcc-12-bcm47xx_defconfig
  - gcc-12-bcm63xx_defconfig
  - gcc-12-cavium_octeon_defconfig
  - gcc-12-cell_defconfig
  - gcc-12-clps711x_defconfig
  - gcc-12-davinci_all_defconfig
  - gcc-12-defconfig
  - gcc-12-defconfig-40bc7ee5
  - gcc-12-exynos_defconfig
  - gcc-12-footbridge_defconfig
  - gcc-12-imx_v4_v5_defconfig
  - gcc-12-imx_v6_v7_defconfig
  - gcc-12-integrator_defconfig
  - gcc-12-ixp4xx_defconfig
  - gcc-12-keystone_defconfig
  - gcc-12-lkftconfig
  - gcc-12-lkftconfig-64k_page_size
  - gcc-12-lkftconfig-armv8_features
  - gcc-12-lkftconfig-compat
  - gcc-12-lkftconfig-debug
  - gcc-12-lkftconfig-debug-kmemleak
  - gcc-12-lkftconfig-devicetree
  - gcc-12-lkftconfig-kasan
  - gcc-12-lkftconfig-kselftest
  - gcc-12-lkftconfig-kunit
  - gcc-12-lkftconfig-libgpiod
  - gcc-12-lkftconfig-no-kselftest-frag
  - gcc-12-lkftconfig-perf
  - gcc-12-lkftconfig-rcutorture
  - gcc-12-lpc32xx_defconfig
  - gcc-12-malta_defconfig
  - gcc-12-maple_defconfig
  - gcc-12-mpc83xx_defconfig
  - gcc-12-multi_v5_defconfig
  - gcc-12-multi_v5_defconfig-65236a87
  - gcc-12-mxs_defconfig
  - gcc-12-nhk8815_defconfig
  - gcc-12-omap1_defconfig
  - gcc-12-omap2plus_defconfig
  - gcc-12-orion5x_defconfig
  - gcc-12-ppc64e_defconfig
  - gcc-12-ppc6xx_defconfig
  - gcc-12-pxa910_defconfig
  - gcc-12-rt305x_defconfig
  - gcc-12-s3c6400_defconfig
  - gcc-12-s5pv210_defconfig
  - gcc-12-sama5_defconfig
  - gcc-12-shmobile_defconfig
  - gcc-12-tinyconfig
  - gcc-12-tqm8xx_defconfig
  - gcc-12-u8500_defconfig
  - gcc-12-vexpress_defconfig
  - gcc-8-allnoconfig
  - gcc-8-ar7_defconfig
  - gcc-8-at91_dt_defconfig
  - gcc-8-ath79_defconfig
  - gcc-8-axm55xx_defconfig
  - gcc-8-bcm2835_defconfig
  - gcc-8-bcm47xx_defconfig
  - gcc-8-bcm63xx_defconfig
  - gcc-8-cavium_octeon_defconfig
  - gcc-8-cell_defconfig
  - gcc-8-clps711x_defconfig
  - gcc-8-davinci_all_defconfig
  - gcc-8-defconfig
  - gcc-8-defconfig-40bc7ee5
  - gcc-8-defconfig-fe40093d
  - gcc-8-dreamcast_defconfig
  - gcc-8-exynos_defconfig
  - gcc-8-footbridge_defconfig
  - gcc-8-i386_defconfig
  - gcc-8-imx_v4_v5_defconfig
  - gcc-8-imx_v6_v7_defconfig
  - gcc-8-integrator_defconfig
  - gcc-8-ixp4xx_defconfig
  - gcc-8-keystone_defconfig
  - gcc-8-lpc32xx_defconfig
  - gcc-8-malta_defconfig
  - gcc-8-maple_defconfig
  - gcc-8-microdev_defconfig
  - gcc-8-mpc83xx_defconfig
  - gcc-8-multi_v5_defconfig
  - gcc-8-mxs_defconfig
  - gcc-8-nhk8815_defconfig
  - gcc-8-omap1_defconfig
  - gcc-8-omap2plus_defconfig
  - gcc-8-orion5x_defconfig
  - gcc-8-ppc64e_defconfig
  - gcc-8-ppc6xx_defconfig
  - gcc-8-pxa910_defconfig
  - gcc-8-rt305x_defconfig
  - gcc-8-s3c6400_defconfig
  - gcc-8-s5pv210_defconfig
  - gcc-8-sama5_defconfig
  - gcc-8-shmobile_defconfig
  - gcc-8-shx3_defconfig
  - gcc-8-tinyconfig
  - gcc-8-tqm8xx_defconfig
  - gcc-8-u8500_defconfig
  - gcc-8-vexpress_defconfig
  - gcc-8-x86_64_defconfig
  - gcc-9-allnoconfig
  - gcc-9-axs103_defconfig
  - gcc-9-defconfig
  - gcc-9-tinyconfig
  - gcc-9-vdk_hs38_smp_defconfig
  - rv32-clang-16-allnoconfig
  - rv32-clang-16-defconfig
  - rv32-clang-16-lkftconfig
  - rv32-clang-16-tinyconfig
  - rv32-clang-nightly-allnoconfig
  - rv32-clang-nightly-defconfig
  - rv32-clang-nightly-tinyconfig
  - rv32-gcc-11-lkftconfig


> > [1]: https://github.com/llvm/llvm-project/commit/5548843d692a92a7840f14=
002debc3cebcb3cdc3
> > [2]: https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git/l=
og/?h=3Dwip/b4/6-1-asssembler-target-llvm-17

[3] https://qa-reports.linaro.org/~anders.roxell/natan-6-1-asssembler-targe=
t-llvm-17/build/v6.1-6642-gb29a8d48035a/metadata/
[4] https://qa-reports.linaro.org/~anders.roxell/natan-6-1-asssembler-targe=
t-llvm-17/build/v6.1-6642-gb29a8d48035a/


> > Cheers,
> > Nathan


- Naresh
