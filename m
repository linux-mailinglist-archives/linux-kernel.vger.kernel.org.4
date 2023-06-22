Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1101573A6F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjFVRHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFVRG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:06:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7491B7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:06:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-513ea2990b8so713a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687453615; x=1690045615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgDsKIvWGO5gn/exYyUdan0EdWpwSIBfqo1P7aqIWXE=;
        b=7n6Db3cDup8SiTVfbFWDitZGZd1Ih5EpRY7no8Q080DrHg2IIeJAolKaQASpDLDpZs
         v9jF9hMMNV7eSmPTn/LkZrJbdpnwCxveLyQc2KF+rN/KkQSSF3nfLM7MrWZi10jbSWoc
         OTrREBezO68LcityxSKmHctOQd6PPnBa0nWelWhidSk7ivy5Kzrg+m4Mc9xZyDTPvH2r
         IVzrG0lTIUSt3YWJYzCR60qBb91uQsO33PMcNeiaQzcGic8YlinKOTLlvVSpdh/mCDXj
         4q4hk30K/UkPtEDHa2s43RPeITy7FkGOYiaO4dT77KCUodAVJt2x/ahYqUtQleaniJ6Z
         xrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687453615; x=1690045615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgDsKIvWGO5gn/exYyUdan0EdWpwSIBfqo1P7aqIWXE=;
        b=D8CDfJHkSMHAIRcJ8ygUuHd8za7EfAPpyr/UnzfpY/EKGO5GEvPa+sPdenJs2Q7Gr7
         gD5m5Neo5XeYVXwWR/ccS0BF8hqNztFAh1QFbU5vHFsTatWB4Za4NsdrETL5YoZFCISh
         LuQ40dnH09Uz+5kS86hcFhY4g3kbRX0D6T3s6J1fzERJDEB6n2Q3SZCP4QrWIE9lYbI4
         pmwSlzDIPpwf2+oq/DqfagbfvTN9c+Pe4len2XVit8NsfJyqX4Y9+LU8gJR82asCUvYY
         97gMJwvwH8Th8MhwyHOxpek9SkmZOgtrkHFg/LNDz5cKru9LZZ9BGtdMND3ktla7G3rz
         FTsA==
X-Gm-Message-State: AC+VfDyvZLJb4a9AgdNmayFSFNQFWA99Huxby5OOXJ1xNrbfmdsQTBY/
        j30fhIce9fSdLNBf4Pznj2Yoti+naTlDSsqYm87O9w==
X-Google-Smtp-Source: ACHHUZ6ktb/rssyE8rTUZJ2PZb/fhd5ss+nrO8ogXVAD2LHhw+MBFxQFKPTq+d7sqWXcSN3kMWM3MsaOiKVJUwKbmag=
X-Received: by 2002:a50:9fc4:0:b0:519:6a72:aeea with SMTP id
 c62-20020a509fc4000000b005196a72aeeamr810590edf.7.1687453614987; Thu, 22 Jun
 2023 10:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230409145358.2538266-1-masahiroy@kernel.org>
 <20230531213319.GA2201875@dev-arch.thelio-3990X> <20230602152519.GA3007575@dev-arch.thelio-3990X>
 <CAK7LNARjB8vgk-hsZmGqB0mwz=OBgyDtqBKJ2cueE+yQ02CQiA@mail.gmail.com>
In-Reply-To: <CAK7LNARjB8vgk-hsZmGqB0mwz=OBgyDtqBKJ2cueE+yQ02CQiA@mail.gmail.com>
From:   Fangrui Song <maskray@google.com>
Date:   Thu, 22 Jun 2023 10:06:42 -0700
Message-ID: <CAFP8O3J1aiAgKzZ82erJseb_wwU7F2=+T0xCZ0BbcFKJOAQfUg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add $(CLANG_CFLAGS) to KBUILD_CPPFLAGS
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 3, 2023 at 9:33=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> On Sat, Jun 3, 2023 at 12:25=E2=80=AFAM Nathan Chancellor <nathan@kernel.=
org> wrote:
> >
> > On Wed, May 31, 2023 at 02:33:23PM -0700, Nathan Chancellor wrote:
> > > Hi Masahiro,
> > >
> > > On Sun, Apr 09, 2023 at 11:53:57PM +0900, Masahiro Yamada wrote:
> > > > When preprocessing arch/*/kernel/vmlinux.lds.S, the target triple i=
s
> > > > not passed to $(CPP) because we add it only to KBUILD_{C,A}FLAGS.
> > > >
> > > > As a result, the linker script is preprocessed with predefined macr=
os
> > > > for the build host instead of the target.
> > > >
> > > > Assuming you use an x86 build machine, compare the following:
> > > >
> > > >  $ clang -dM -E -x c /dev/null
> > > >  $ clang -dM -E -x c /dev/null -target aarch64-linux-gnu
> > > >
> > > > There is no actual problem presumably because our linker scripts do=
 not
> > > > rely on such predefined macros, but it is better to define correct =
ones.
> > > >
> > > > Move $(CFLAGS_CFLAGS) to KBUILD_CPPFLAGS, so that all *.c, *.S, *.l=
ds.S
> > > > will be processed with the proper target triple.
> > > >
> > > > Reported-by: Tom Rini <trini@konsulko.com>
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > ---
> > > >
> > > >  scripts/Makefile.clang | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > > > index 70b354fa1cb4..93ca059cc3b8 100644
> > > > --- a/scripts/Makefile.clang
> > > > +++ b/scripts/Makefile.clang
> > > > @@ -38,6 +38,5 @@ CLANG_FLAGS       +=3D -Werror=3Dunknown-warning-=
option
> > > >  CLANG_FLAGS        +=3D -Werror=3Dignored-optimization-argument
> > > >  CLANG_FLAGS        +=3D -Werror=3Doption-ignored
> > > >  CLANG_FLAGS        +=3D -Werror=3Dunused-command-line-argument
> > > > -KBUILD_CFLAGS      +=3D $(CLANG_FLAGS)
> > > > -KBUILD_AFLAGS      +=3D $(CLANG_FLAGS)
> > > > +KBUILD_CPPFLAGS    +=3D $(CLANG_FLAGS)
> > > >  export CLANG_FLAGS
> > > > --
> > > > 2.37.2
> > > >
> > >
> > > I am doubling back to this change, as the lack of '--target' in
> > > KBUILD_CPPFLAGS is now an active bug with clang-17 due to a new chang=
e
> > > that rejects '-mbig-endian' and '-mlittle-endian' when not supported =
by
> > > the target, which breaks the arm64 vDSO build when preprocessing its
> > > linker script:
> > >
> > >   # Turn on CONFIG_CPU_BIG_ENDIAN in menuconfig
> > >   $ make -skj"$(nproc)" ARCH=3Darm64 LLVM=3D1 O=3Dbuild mrproper virt=
config menuconfig arch/arm64/kernel/vdso/
> > >   ...
> > >   clang: error: unsupported option '-mbig-endian' for target 'x86_64-=
pc-linux-gnu'
> > >   make[3]: *** [.../scripts/Makefile.build:387: arch/arm64/kernel/vds=
o/vdso.lds] Error 1
> > >   ...
> > >
> > >   https://github.com/llvm/llvm-project/commit/d81ce04587c006b67311989=
56c522c93d0df1050
> > >   https://github.com/ClangBuiltLinux/linux/issues/1859
> > >
> > > This change resolves that issue. I was able to figure out why those n=
ew
> > > warnings appeared for ARCH=3Dmips, it is the shell invocation for
> > > CHECKFLAGS. The following diff resolves it for me:
> > >
> > > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > > index a7a4ee66a9d3..ef7b05ae92ce 100644
> > > --- a/arch/mips/Makefile
> > > +++ b/arch/mips/Makefile
> > > @@ -346,7 +346,7 @@ KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-table=
s
> > >  KBUILD_LDFLAGS               +=3D -m $(ld-emul)
> > >
> > >  ifdef CONFIG_MIPS
> > > -CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null=
 | \
> > > +CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -d=
M -E -x c /dev/null | \
> > >       grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
> > >       sed -e "s/^\#define /-D'/" -e "s/ /'=3D'/" -e "s/$$/'/" -e 's/\=
$$/&&/g')
> > >  endif
> > >
> > > I will run this change plus that diff through my build matrix to see =
if
> > > any other issues pop up. If not, I will respond with some tags and
> > > perhaps this could be taken as a fix for 6.4 so that it could
> > > potentially be backported?
> >
> > I found two more issues lurking in PowerPC. I have attached suggested
> > patches for all the issues I have uncovered to this email, please feel
> > free to use them or do something different if you feel there is a bette=
r
> > fix. With those issues resolved in one way or another, consider the
> > original change:
> >
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> >
> > If it would work better for you, I am more than happy to take over this
> > series as well.
> >
> > Cheers,
> > Nathan
>
> Thanks. All the three patches look good to me.
>
> I will apply them, then mine on top.

Drive-by reply from
https://github.com/ClangBuiltLinux/continuous-integration2/pull/585

Hi Masahiro, one nit:) If the patch still has time to adjust the
commit message, perhaps consider replacing

-target aarch64-linux-gnu with --target=3Daarch64-linux-gnu

as the former is a deprecated driver option since Clang 3.x (long time ago)=
.

> Assuming you use an x86 build machine, compare the following:

You may drop "Assuming you use an x86 build machine" and add
--target=3Dx86_64-linux-gnu to the `clang -dM -E -x c /dev/null` command
:)


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
