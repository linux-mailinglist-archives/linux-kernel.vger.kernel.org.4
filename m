Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832666F6076
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 23:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjECVPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 17:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECVPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 17:15:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783AA7DB3
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 14:15:19 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6433c243287so824054b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683148519; x=1685740519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYjtP3li0YbsLtcXNs0xFjnA+WYgqbtDXHiT1oW4NDY=;
        b=docRgF5zyfa+7Y6ccOS7qb1T9fJ9SlYg2Kv1APpVeNiflBC5ukHr73Q7ijWoV0+e/X
         txNUTFPPTTUaMh17LnTying/LiI0AX8TPYPUBzIz6L671QgK/Y16ycmz32N4p0/70XMT
         UdDlr+74E/0JtgxDy+dS1BY8eqrXgZ+7m3pIrYYY7262vuimF/0PSJ8hmbgIFzntaANL
         KoDYoSA1IMPhCm+rizxOvhAEfW4ZBEwPqBjWT6lJ+nvDo6Z5F1sgnKR+RE4ux0cOzVzr
         Al+2acKalI5Q+zy7Whlh+j36HkH2i4b9x24DvhFXtLGRKP3F5sq7/QmsA1pX2AfNOz4R
         KNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683148519; x=1685740519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYjtP3li0YbsLtcXNs0xFjnA+WYgqbtDXHiT1oW4NDY=;
        b=LsiuNtL+ZYQC57P1KItfevsEp+WElvnCDpX6dGdT0TP2KndJkNzOiJl1wARCKs/Hvk
         Zc1Y0TacZvI6GVmV9wfv+feOlmkyt50SKWCOfD5dH8wwSZPxbzg6yWAeGrOKfO239lSt
         Ed3b6taCdqRb02v7r8kHIBP2ODGGUwnF+cCoexsLqWbepWV3+UQu2Qnw/ZLMou4M08oB
         5NcSDQld9WjCo4iPcnY1mdgcAvmSUYwCfiKovkhUdl2aMS4rXfXbkOFIzV88rYlKTu4/
         DVyqFl6HnUiM9aeboC6hnXXIyorvZsnNeXt1KNNhzFbbD1c/GNGSMa+jlsUJHxW+TTJ5
         lMKg==
X-Gm-Message-State: AC+VfDzM6hqMO32gue/rOdNUPuEMZlUTxRD1ZCvvvVEnRRya6xbougWL
        Ns/nHD3Kv8gbsPR7WbjRGgDAdrDKavd33vniHx75jA==
X-Google-Smtp-Source: ACHHUZ5U/poytmr7W4I9OBSYuq6ZvY8N56EHNWjrIYjV6KtZBPuCRWT+cGN63oy63V+UV+Eqqh8+vWgPI8sZGGE1hKQ=
X-Received: by 2002:a05:6a21:9989:b0:ef:c5b6:b6b9 with SMTP id
 ve9-20020a056a21998900b000efc5b6b6b9mr28446452pzb.23.1683148518611; Wed, 03
 May 2023 14:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
 <20220919170828.3718437-1-ndesaulniers@google.com> <597ef55f-e7c1-ab60-b4aa-0071ff4b5e0e@collabora.com>
 <CAKwvOdmSrAxx-YY1Na3BSdYuxXCPKK+F0K5V6i+adTn_bVJEsw@mail.gmail.com> <89961dfc-d40f-78e4-5d34-b86b7d152182@collabora.com>
In-Reply-To: <89961dfc-d40f-78e4-5d34-b86b7d152182@collabora.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 May 2023 14:15:07 -0700
Message-ID: <CAKwvOd=4hBcU4fAkddU0b-GOZc9FzTZoj3PFW6ZZrX0jS8x+bg@mail.gmail.com>
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        regressions@lists.linux.dev,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        denys.f@collabora.com, ricardo.canuelo@collabora.com,
        kernelci@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 2:02=E2=80=AFPM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
>
> Hi Nick,
>
> On 28/04/23 22:57, Nick Desaulniers wrote:
> > On Thu, Apr 27, 2023 at 4:54=E2=80=AFAM Shreeya Patel
> > <shreeya.patel@collabora.com> wrote:
> >> Hi Nick,
> >>
> >> On 19/09/22 22:38, Nick Desaulniers wrote:
> >>> cc-ifversion is GCC specific. Replace it with compiler specific
> >>> variants. Update the users of cc-ifversion to use these new macros.
> >>>
> >>> Link: https://github.com/ClangBuiltLinux/linux/issues/350
> >>> Link: https://lore.kernel.org/llvm/CAGG=3D3QWSAUakO42kubrCap8fp-gm1ER=
JJAYXTnP1iHk_wrH=3DBQ@mail.gmail.com/
> >>> Suggested-by: Bill Wendling <morbo@google.com>
> >>> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> >>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >> KernelCI found this patch causes a regression in the
> >> baseline.logintest on qemu_arm-virt-gicv3-uefi [1],
> >> see the bisection report for more details [2].
> >>
> >> Let me know if you have any questions.
> >>
> >>
> >> [1] https://linux.kernelci.org/test/case/id/644596a0beca2ead032e8669/
> > Hi Shreeya,
> > Thanks for the report.
> >
> > When I click the above link, then click `multi_v7_defconfig+debug` to
> > get the config necessary to reproduce, I get an HTTP 404.
> > https://storage.kernelci.org/mainline/master/v6.3/arm/multi_v7_defconfi=
g+debug/gcc-10/kernel.config
> >
> > Same for zImage
> > https://storage.kernelci.org/mainline/master/v6.3/arm/multi_v7_defconfi=
g+debug/gcc-10/zImage
>
> Apologies for the broken links. We will try to fix the important ones if
> we can but in the meantime,
> following is the correct link that you can refer.
>
> config :-
> https://storage.kernelci.org/mainline/master/v6.3/arm/multi_v7_defconfig+=
debug/gcc-10/config/kernel.config
>
> zImage :-
> https://storage.kernelci.org/mainline/master/v6.3/arm/multi_v7_defconfig+=
debug/gcc-10/kernel/zImage
>
> If you notice, they are present under the kernel directory and same way
> you can find links for other kernel
> builds if you'd like to check them out.
>
> > If I click on the log
> > https://storage.kernelci.org/mainline/master/v6.3/arm/multi_v7_defconfi=
g+debug/gcc-10/lab-collabora/baseline-qemu_arm-virt-gicv3-uefi.txt
> > It looks like the machine powered up, then powered off. Is the test
> > actually failing?
>
> I recommend checking the html logs from the kernelci dashboard.
> Also, FYI baseline.login test failure means that the device failed to
> boot which I think is causing by the issues that you pointed out.
>
> <3>[    0.417001][    T1] UBSAN: array-index-out-of-bounds in
> ../arch/arm/mach-sunxi/mc_smp.c:811:29
>
> And potentially another issue with ftrace
>
> <4>[    0.000000][    T0] WARNING: CPU: 0 PID: 0 at
> kernel/trace/ftrace.c:2176 ftrace_bug+0x340/0x3b4
>
>
> Let me know if you need more information from my side to reproduce this
> on your end.
>
>
> Thanks,
> Shreeya Patel

Hi Shreeya,
I may need your help to reproduce the failure.

$ wget https://storage.kernelci.org/mainline/master/v6.3/arm/multi_v7_defco=
nfig+debug/gcc-10/config/kernel.config
-O .config
$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- make -j128 olddefconfig a=
ll -s
<launch qemu>
/ # mount -t proc /proc
/ # cat /proc/version
Linux version 6.3.0 (root@61385772abae) (arm-linux-gnueabihf-gcc
(Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian)
2.35.2) #2 SMP Wed May  3 21:10:27 UTC 2023

I was able to boot the resulting kernel to a command line.  Perhaps
there's something about the userspace image that tickles this? Can you
supply the rootfs that's used in testing?

> > I was able to boot ARCH=3Darm defconfig with CC=3Darm-linux-gnueabihf-g=
cc
> > (Debian 10.2.1-6) in QEMU just fine.  So I'm going to need some more
> > information to help reproduce what specifically is failing.
> >
> > Linux version 6.3.0 (root@61385772abae) (arm-linux-gnueabihf-gcc
> > (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian)
> > 2.35.2) #1 SMP Fri Apr 28 17:19:59 UTC 2023
> >
> > ---
> >
> > It does look like UBSAN is flagging an array OOB:
> >
> > <3>[    0.417001][    T1] UBSAN: array-index-out-of-bounds in
> > ../arch/arm/mach-sunxi/mc_smp.c:811:29
> >
> > And potentially another issue with ftrace
> >
> > <4>[    0.000000][    T0] WARNING: CPU: 0 PID: 0 at
> > kernel/trace/ftrace.c:2176 ftrace_bug+0x340/0x3b4
> >
> >
> >
> >> [2] https://groups.io/g/kernelci-results/message/40804
> >>
> >>
> >> Thanks,
> >> Shreeya Patel
> >>
> >> #regzbot introduced: 88b61e3bff93
> >>
> >>> ---
> >>> Changes v3 -> v4:
> >>> * Split into its own patch again from series, as per Masahiro.
> >>> * Rebase on top of b0839b281c427e844143dba3893e25c83cdd6c17 and updat=
e
> >>>     clang -Wformat logic in scripts/Makefile.extrawarn, as per Masahi=
ro.
> >>>
> >>>    Documentation/kbuild/makefiles.rst          | 29 ++++++++++++-----=
----
> >>>    Makefile                                    |  6 ++---
> >>>    drivers/gpu/drm/amd/display/dc/dml/Makefile |  2 +-
> >>>    scripts/Makefile.compiler                   | 10 ++++---
> >>>    scripts/Makefile.extrawarn                  |  4 +--
> >>>    5 files changed, 29 insertions(+), 22 deletions(-)
> >>>
> >>> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuil=
d/makefiles.rst
> >>> index 11a296e52d68..ee7e3ea1fbe1 100644
> >>> --- a/Documentation/kbuild/makefiles.rst
> >>> +++ b/Documentation/kbuild/makefiles.rst
> >>> @@ -682,22 +682,27 @@ more details, with real examples.
> >>>        In the above example, -Wno-unused-but-set-variable will be add=
ed to
> >>>        KBUILD_CFLAGS only if gcc really accepts it.
> >>>
> >>> -    cc-ifversion
> >>> -     cc-ifversion tests the version of $(CC) and equals the fourth p=
arameter
> >>> -     if version expression is true, or the fifth (if given) if the v=
ersion
> >>> -     expression is false.
> >>> +    gcc-min-version
> >>> +     gcc-min-version tests if the value of $(CONFIG_GCC_VERSION) is =
greater than
> >>> +     or equal to the provided value and evaluates to y if so.
> >>>
> >>>        Example::
> >>>
> >>> -             #fs/reiserfs/Makefile
> >>> -             ccflags-y :=3D $(call cc-ifversion, -lt, 0402, -O1)
> >>> +             cflags-$(call gcc-min-version, 70100) :=3D -foo
> >>>
> >>> -     In this example, ccflags-y will be assigned the value -O1 if th=
e
> >>> -     $(CC) version is less than 4.2.
> >>> -     cc-ifversion takes all the shell operators:
> >>> -     -eq, -ne, -lt, -le, -gt, and -ge
> >>> -     The third parameter may be a text as in this example, but it ma=
y also
> >>> -     be an expanded variable or a macro.
> >>> +     In this example, cflags-y will be assigned the value -foo if $(=
CC) is gcc and
> >>> +     $(CONFIG_GCC_VERSION) is >=3D 7.1.
> >>> +
> >>> +    clang-min-version
> >>> +     clang-min-version tests if the value of $(CONFIG_CLANG_VERSION)=
 is greater
> >>> +     than or equal to the provided value and evaluates to y if so.
> >>> +
> >>> +     Example::
> >>> +
> >>> +             cflags-$(call clang-min-version, 110000) :=3D -foo
> >>> +
> >>> +     In this example, cflags-y will be assigned the value -foo if $(=
CC) is clang
> >>> +     and $(CONFIG_CLANG_VERSION) is >=3D 11.0.0.
> >>>
> >>>        cc-cross-prefix
> >>>        cc-cross-prefix is used to check if there exists a $(CC) in pa=
th with
> >>> diff --git a/Makefile b/Makefile
> >>> index 298f69060f10..411c8480b37e 100644
> >>> --- a/Makefile
> >>> +++ b/Makefile
> >>> @@ -790,7 +790,6 @@ KBUILD_CFLAGS +=3D $(stackp-flags-y)
> >>>
> >>>    KBUILD_CFLAGS-$(CONFIG_WERROR) +=3D -Werror
> >>>    KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) +=3D -Wno-array-bounds
> >>> -KBUILD_CFLAGS +=3D $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROU=
GH)
> >>>
> >>>    ifdef CONFIG_CC_IS_CLANG
> >>>    KBUILD_CPPFLAGS +=3D -Qunused-arguments
> >>> @@ -972,7 +971,6 @@ ifdef CONFIG_CC_IS_GCC
> >>>    KBUILD_CFLAGS +=3D -Wno-maybe-uninitialized
> >>>    endif
> >>>
> >>> -ifdef CONFIG_CC_IS_GCC
> >>>    # The allocators already balk at large sizes, so silence the compi=
ler
> >>>    # warnings for bounds checks involving those possible values. Whil=
e
> >>>    # -Wno-alloc-size-larger-than would normally be used here, earlier=
 versions
> >>> @@ -984,8 +982,8 @@ ifdef CONFIG_CC_IS_GCC
> >>>    # ignored, continuing to default to PTRDIFF_MAX. So, left with no =
other
> >>>    # choice, we must perform a versioned check to disable this warnin=
g.
> >>>    # https://lore.kernel.org/lkml/20210824115859.187f272f@canb.auug.o=
rg.au
> >>> -KBUILD_CFLAGS +=3D $(call cc-ifversion, -ge, 0901, -Wno-alloc-size-l=
arger-than)
> >>> -endif
> >>> +KBUILD_CFLAGS-$(call gcc-min-version, 90100) +=3D -Wno-alloc-size-la=
rger-than
> >>> +KBUILD_CFLAGS +=3D $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROU=
GH)
> >>>
> >>>    # disable invalid "can't wrap" optimizations for signed / pointers
> >>>    KBUILD_CFLAGS       +=3D -fno-strict-overflow
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gp=
u/drm/amd/display/dc/dml/Makefile
> >>> index cb81ed2fbd53..d70838edba80 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> >>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> >>> @@ -34,7 +34,7 @@ dml_ccflags :=3D -mhard-float -maltivec
> >>>    endif
> >>>
> >>>    ifdef CONFIG_CC_IS_GCC
> >>> -ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> >>> +ifneq ($(call gcc-min-version, 70100),y)
> >>>    IS_OLD_GCC =3D 1
> >>>    endif
> >>>    endif
> >>> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> >>> index 94d0d40cddb3..9d18fb91890e 100644
> >>> --- a/scripts/Makefile.compiler
> >>> +++ b/scripts/Makefile.compiler
> >>> @@ -61,9 +61,13 @@ cc-option-yn =3D $(call try-run,\
> >>>    cc-disable-warning =3D $(call try-run,\
> >>>        $(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip $(=
1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
> >>>
> >>> -# cc-ifversion
> >>> -# Usage:  EXTRA_CFLAGS +=3D $(call cc-ifversion, -lt, 0402, -O1)
> >>> -cc-ifversion =3D $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ] && =
echo $(3) || echo $(4))
> >>> +# gcc-min-version
> >>> +# Usage: cflags-$(call gcc-min-version, 70100) +=3D -foo
> >>> +gcc-min-version =3D $(shell [ $(CONFIG_GCC_VERSION) -ge $(1) ] && ec=
ho y)
> >>> +
> >>> +# clang-min-version
> >>> +# Usage: cflags-$(call clang-min-version, 110000) +=3D -foo
> >>> +clang-min-version =3D $(shell [ $(CONFIG_CLANG_VERSION) -ge $(1) ] &=
& echo y)
> >>>
> >>>    # ld-option
> >>>    # Usage: KBUILD_LDFLAGS +=3D $(call ld-option, -X, -Y)
> >>> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> >>> index 6ae482158bc4..5769c1939d40 100644
> >>> --- a/scripts/Makefile.extrawarn
> >>> +++ b/scripts/Makefile.extrawarn
> >>> @@ -48,7 +48,7 @@ else
> >>>    ifdef CONFIG_CC_IS_CLANG
> >>>    KBUILD_CFLAGS +=3D -Wno-initializer-overrides
> >>>    # Clang before clang-16 would warn on default argument promotions.
> >>> -ifeq ($(shell [ $(CONFIG_CLANG_VERSION) -lt 160000 ] && echo y),y)
> >>> +ifneq ($(call clang-min-version, 160000),y)
> >>>    # Disable -Wformat
> >>>    KBUILD_CFLAGS +=3D -Wno-format
> >>>    # Then re-enable flags that were part of the -Wformat group that a=
ren't
> >>> @@ -56,7 +56,7 @@ KBUILD_CFLAGS +=3D -Wno-format
> >>>    KBUILD_CFLAGS +=3D -Wformat-extra-args -Wformat-invalid-specifier
> >>>    KBUILD_CFLAGS +=3D -Wformat-zero-length -Wnonnull
> >>>    # Requires clang-12+.
> >>> -ifeq ($(shell [ $(CONFIG_CLANG_VERSION) -ge 120000 ] && echo y),y)
> >>> +ifeq ($(call clang-min-version, 120000),y)
> >>>    KBUILD_CFLAGS +=3D -Wformat-insufficient-args
> >>>    endif
> >>>    endif
> >
> >



--=20
Thanks,
~Nick Desaulniers
