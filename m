Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F676E3874
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjDPNCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjDPNCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:02:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC07819B9;
        Sun, 16 Apr 2023 06:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AD0460C95;
        Sun, 16 Apr 2023 13:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F34CC433D2;
        Sun, 16 Apr 2023 13:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681650169;
        bh=D3wy4kwpYEcnvQj/DKBp/Hq76nY/CXZPNCXOrIibLCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Un3l3D3xgYAMWSddL2GeWG8Y3LD4HC3NFNMrx1dRHGwOdznt7jdMJhKELlvIdxPyW
         KBdJ1QPSPeB+4rxMyty4HsmSO9oYSoE9rXgB95yaghcgI4ZGMttCQyHPJF2NwZ/ymH
         l4yhK7PE6SPHHoolR3MFWhWQtuXzm60ABVe6MPMsim9zPGgPmcBmA6h1XpTqipfmzm
         ODwTfGXrMy/dzPmmnux4tBBpAh9CBHzX5muBLBY67UHn9A+ff75HpHvMMq4ae8NTfP
         t3JZvIkUeLk0UdvWC7HrHbZ3i/XrOlJ/Qk0tEVCrg1Wd2gxyTfqA7l1QyXiTPs+3Cc
         7921zRW5bxGPQ==
Received: by mail-ot1-f51.google.com with SMTP id 39-20020a9d04aa000000b006a1370e214aso9245624otm.11;
        Sun, 16 Apr 2023 06:02:49 -0700 (PDT)
X-Gm-Message-State: AAQBX9egqWrnJdC0yEn4b4IEF+fWmoOoaBh/I7yp/z9Vb3Lai0vm3QSy
        iI0Z8ok0Tqd77hvoKSIti2T5/a8A6L2kaBDRZaw=
X-Google-Smtp-Source: AKy350asvMZybXnMTiMzrhCi04P+dV9lupbZkct2X70VIIPJHBHL6CfYbZrmmKagvzwZVMmz4lAwLL/CIw60sfCgFkE=
X-Received: by 2002:a9d:77d1:0:b0:6a4:279d:aab5 with SMTP id
 w17-20020a9d77d1000000b006a4279daab5mr2778407otl.1.1681650168906; Sun, 16 Apr
 2023 06:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230401170117.1580840-1-masahiroy@kernel.org> <20230403144758.GA3460665@dev-arch.thelio-3990X>
In-Reply-To: <20230403144758.GA3460665@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 16 Apr 2023 22:02:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQsgB-SC2t+9ZpDwJbME+BVt+Gur1ydTnHfBfMAfn_y0w@mail.gmail.com>
Message-ID: <CAK7LNAQsgB-SC2t+9ZpDwJbME+BVt+Gur1ydTnHfBfMAfn_y0w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: clang: do not use CROSS_COMPILE for target triple
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 11:48=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Sun, Apr 02, 2023 at 02:01:17AM +0900, Masahiro Yamada wrote:
> > The target triple is overridden by the user-supplied CROSS_COMPILE,
> > but I do not see a good reason to support it. Users can use a new
> > architecture without adding CLANG_TARGET_FLAGS_*, but that would be
> > a rare case.
> >
> > Use the hard-coded and deterministic target triple all the time.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> I know of one bug where the value of '--target' matters:
>
> https://github.com/ClangBuiltLinux/linux/issues/1244


I did not look into it closely, but if we say
"
Using either CROSS_COMPILE=3Dpowerpc64-linux-gnu- or
CROSS_COMPILE=3Dpowerpc-linux-gnu- fixes it.
Using KCFLAGS=3D-v reveals that powerpc64le-linux-gnu-as is not getting
the endianness information.
", why didn't we fix it like the following?


 diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
 index 70b354fa1cb4..8dda7dc69c93 100644
 --- a/scripts/Makefile.clang
 +++ b/scripts/Makefile.clang
 @@ -6,7 +6,7 @@ CLANG_TARGET_FLAGS_arm64        :=3D aarch64-linux-gnu
  CLANG_TARGET_FLAGS_hexagon     :=3D hexagon-linux-musl
  CLANG_TARGET_FLAGS_m68k                :=3D m68k-linux-gnu
  CLANG_TARGET_FLAGS_mips                :=3D mipsel-linux-gnu
 -CLANG_TARGET_FLAGS_powerpc     :=3D powerpc64le-linux-gnu
 +CLANG_TARGET_FLAGS_powerpc     :=3D powerpc64-linux-gnu
  CLANG_TARGET_FLAGS_riscv       :=3D riscv64-linux-gnu
  CLANG_TARGET_FLAGS_s390                :=3D s390x-linux-gnu
  CLANG_TARGET_FLAGS_x86         :=3D x86_64-linux-gnu



We do not need to test all possible target triples.
We can just use the one that is known to work.


Anyway, I will apply this patch. Thanks.


>
> This was fixed in LLVM 12.0.0. We are not testing this in our CI though,
> so we would not get bit by this (we could bump the minimum supported
> version of LLVM to 12.0.0 for this, we have talked recently about doing
> it for other reasons).
>
> I guess I cannot really think of a good reason not to do this aside from
> that; the target triple should only affect code generation, rather than
> tool selection (i.e., this does not take away the ability to use a
> custom set of binutils with clang).
>
> However, Nick is currently OOO and I would like his opinion voiced
> before we commit to this. Consider this a tentative:
>
> Acked-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> >
> >  scripts/Makefile.clang | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > index 70b354fa1cb4..9076cc939e87 100644
> > --- a/scripts/Makefile.clang
> > +++ b/scripts/Makefile.clang
> > @@ -13,15 +13,11 @@ CLANG_TARGET_FLAGS_x86            :=3D x86_64-linux=
-gnu
> >  CLANG_TARGET_FLAGS_um                :=3D $(CLANG_TARGET_FLAGS_$(SUBAR=
CH))
> >  CLANG_TARGET_FLAGS           :=3D $(CLANG_TARGET_FLAGS_$(SRCARCH))
> >
> > -ifeq ($(CROSS_COMPILE),)
> >  ifeq ($(CLANG_TARGET_FLAGS),)
> > -$(error Specify CROSS_COMPILE or add '--target=3D' option to scripts/M=
akefile.clang)
> > +$(error add '--target=3D' option to scripts/Makefile.clang)
> >  else
> >  CLANG_FLAGS  +=3D --target=3D$(CLANG_TARGET_FLAGS)
> > -endif # CLANG_TARGET_FLAGS
> > -else
> > -CLANG_FLAGS  +=3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
> > -endif # CROSS_COMPILE
> > +endif
> >
> >  ifeq ($(LLVM_IAS),0)
> >  CLANG_FLAGS  +=3D -fno-integrated-as
> > --
> > 2.37.2
> >



--=20
Best Regards
Masahiro Yamada
