Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A297205ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjFBPZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjFBPZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:25:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E231BB;
        Fri,  2 Jun 2023 08:25:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D156A6144D;
        Fri,  2 Jun 2023 15:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2918C433D2;
        Fri,  2 Jun 2023 15:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685719522;
        bh=xVDKCfjsCg+1n/FNLK54gWXZMuHDGC90sLJZfdRFMUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNRdBD5eEyqjW8B0viTDU6QQplnykG3+ZMkX3HBcyC2rJERAwhGzhGlXqj03ASHF5
         MckpChXGNsLVNBOI28/Nc0jWGvprGzN3UoLfO/5M9/gVofCR+4kwFL34y2jz7Lx3sJ
         p7gjtq5FrsMt8HUof2OzEBcpfjOVGkpdo8QXy3K3rMIA3EK6vioTQDO8VYXgSjb69t
         BAF/NOsQvxyab+1cxNZXOfRoiljxpzxCO3Kgn5NhyWsSraWMA6Gb25kAN5lHRlxypl
         GvrDvv6ZlRBEvdtYvQRv4uHoJWr1et/zbaDRP7lL/55oDQToJJ+9NjaUw21bh6FE+Y
         IxcJOJzkEwZRA==
Date:   Fri, 2 Jun 2023 08:25:19 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] kbuild: add $(CLANG_CFLAGS) to KBUILD_CPPFLAGS
Message-ID: <20230602152519.GA3007575@dev-arch.thelio-3990X>
References: <20230409145358.2538266-1-masahiroy@kernel.org>
 <20230531213319.GA2201875@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7lDxHDkp7IDTfCY4"
Content-Disposition: inline
In-Reply-To: <20230531213319.GA2201875@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7lDxHDkp7IDTfCY4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 31, 2023 at 02:33:23PM -0700, Nathan Chancellor wrote:
> Hi Masahiro,
> 
> On Sun, Apr 09, 2023 at 11:53:57PM +0900, Masahiro Yamada wrote:
> > When preprocessing arch/*/kernel/vmlinux.lds.S, the target triple is
> > not passed to $(CPP) because we add it only to KBUILD_{C,A}FLAGS.
> > 
> > As a result, the linker script is preprocessed with predefined macros
> > for the build host instead of the target.
> > 
> > Assuming you use an x86 build machine, compare the following:
> > 
> >  $ clang -dM -E -x c /dev/null
> >  $ clang -dM -E -x c /dev/null -target aarch64-linux-gnu
> > 
> > There is no actual problem presumably because our linker scripts do not
> > rely on such predefined macros, but it is better to define correct ones.
> > 
> > Move $(CFLAGS_CFLAGS) to KBUILD_CPPFLAGS, so that all *.c, *.S, *.lds.S
> > will be processed with the proper target triple.
> > 
> > Reported-by: Tom Rini <trini@konsulko.com>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> > 
> >  scripts/Makefile.clang | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > index 70b354fa1cb4..93ca059cc3b8 100644
> > --- a/scripts/Makefile.clang
> > +++ b/scripts/Makefile.clang
> > @@ -38,6 +38,5 @@ CLANG_FLAGS	+= -Werror=unknown-warning-option
> >  CLANG_FLAGS	+= -Werror=ignored-optimization-argument
> >  CLANG_FLAGS	+= -Werror=option-ignored
> >  CLANG_FLAGS	+= -Werror=unused-command-line-argument
> > -KBUILD_CFLAGS	+= $(CLANG_FLAGS)
> > -KBUILD_AFLAGS	+= $(CLANG_FLAGS)
> > +KBUILD_CPPFLAGS	+= $(CLANG_FLAGS)
> >  export CLANG_FLAGS
> > -- 
> > 2.37.2
> > 
> 
> I am doubling back to this change, as the lack of '--target' in
> KBUILD_CPPFLAGS is now an active bug with clang-17 due to a new change
> that rejects '-mbig-endian' and '-mlittle-endian' when not supported by
> the target, which breaks the arm64 vDSO build when preprocessing its
> linker script:
> 
>   # Turn on CONFIG_CPU_BIG_ENDIAN in menuconfig
>   $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 O=build mrproper virtconfig menuconfig arch/arm64/kernel/vdso/
>   ...
>   clang: error: unsupported option '-mbig-endian' for target 'x86_64-pc-linux-gnu'
>   make[3]: *** [.../scripts/Makefile.build:387: arch/arm64/kernel/vdso/vdso.lds] Error 1
>   ...
> 
>   https://github.com/llvm/llvm-project/commit/d81ce04587c006b6731198956c522c93d0df1050
>   https://github.com/ClangBuiltLinux/linux/issues/1859
> 
> This change resolves that issue. I was able to figure out why those new
> warnings appeared for ARCH=mips, it is the shell invocation for
> CHECKFLAGS. The following diff resolves it for me:
> 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index a7a4ee66a9d3..ef7b05ae92ce 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -346,7 +346,7 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>  KBUILD_LDFLAGS		+= -m $(ld-emul)
>  
>  ifdef CONFIG_MIPS
> -CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
> +CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
>  	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
>  	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
>  endif
> 
> I will run this change plus that diff through my build matrix to see if
> any other issues pop up. If not, I will respond with some tags and
> perhaps this could be taken as a fix for 6.4 so that it could
> potentially be backported?

I found two more issues lurking in PowerPC. I have attached suggested
patches for all the issues I have uncovered to this email, please feel
free to use them or do something different if you feel there is a better
fix. With those issues resolved in one way or another, consider the
original change:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

If it would work better for you, I am more than happy to take over this
series as well.

Cheers,
Nathan

--7lDxHDkp7IDTfCY4
Content-Type: application/mbox
Content-Disposition: attachment;
	filename="kbuild-move-clang_flags-to-kbuild_cppflags.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom 0e9dca3d943bd5b0926bae2405c13af878e0e53e Mon Sep 17 00:00:00 2001=0A=
=46rom: Nathan Chancellor <nathan@kernel.org>=0ADate: Thu, 1 Jun 2023 11:38=
:24 -0700=0ASubject: [PATCH 1/3] mips: Include KBUILD_CPPFLAGS in CHECKFLAG=
S invocation=0A=0AA future change will move CLANG_FLAGS from KBUILD_{A,C}FL=
AGS to=0AKBUILD_CPPFLAGS so that '--target' is available while preprocessin=
g.=0AWhen that occurs, the following error appears when building ARCH=3Dmip=
s=0Awith clang (tip of tree error shown):=0A=0A  clang: error: unsupported =
option '-mabi=3D' for target 'x86_64-pc-linux-gnu'=0A=0AAdd KBUILD_CPPFLAGS=
 in the CHECKFLAGS invocation to keep everything=0Aworking after the move.=
=0A=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A arch/mi=
ps/Makefile | 2 +-=0A 1 file changed, 1 insertion(+), 1 deletion(-)=0A=0Adi=
ff --git a/arch/mips/Makefile b/arch/mips/Makefile=0Aindex a7a4ee66a9d3..ef=
7b05ae92ce 100644=0A--- a/arch/mips/Makefile=0A+++ b/arch/mips/Makefile=0A@=
@ -346,7 +346,7 @@ KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-tables=0A KB=
UILD_LDFLAGS		+=3D -m $(ld-emul)=0A =0A ifdef CONFIG_MIPS=0A-CHECKFLAGS +=
=3D $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \=0A+CHECKFLAGS =
+=3D $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/nul=
l | \=0A 	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \=0A 	sed -e "s/^\#=
define /-D'/" -e "s/ /'=3D'/" -e "s/$$/'/" -e 's/\$$/&&/g')=0A endif=0A-- =
=0A2.41.0=0A=0A=0AFrom 69c854476d412c3faff5ec59a57f0907f26c4f3b Mon Sep 17 =
00:00:00 2001=0AFrom: Nathan Chancellor <nathan@kernel.org>=0ADate: Thu, 1 =
Jun 2023 11:46:33 -0700=0ASubject: [PATCH 2/3] powerpc/vdso: Include CLANG_=
FLAGS explicitly in ldflags-y=0A=0AA future change will move CLANG_FLAGS fr=
om KBUILD_{A,C}FLAGS to=0AKBUILD_CPPFLAGS so that '--target' is available w=
hile preprocessing.=0AWhen that occurs, the following error appears when bu=
ilding the compat=0APowerPC vDSO:=0A=0A  clang: error: unsupported option '=
-mbig-endian' for target 'x86_64-pc-linux-gnu'=0A  make[3]: *** [.../arch/p=
owerpc/kernel/vdso/Makefile:76: arch/powerpc/kernel/vdso/vdso32.so.dbg] Err=
or 1=0A=0AExplicitly add CLANG_FLAGS to ldflags-y, so that '--target' will =
always=0Abe present.=0A=0ASigned-off-by: Nathan Chancellor <nathan@kernel.o=
rg>=0A---=0A arch/powerpc/kernel/vdso/Makefile | 2 +-=0A 1 file changed, 1 =
insertion(+), 1 deletion(-)=0A=0Adiff --git a/arch/powerpc/kernel/vdso/Make=
file b/arch/powerpc/kernel/vdso/Makefile=0Aindex 4c3f34485f08..23d3caf27d6d=
 100644=0A--- a/arch/powerpc/kernel/vdso/Makefile=0A+++ b/arch/powerpc/kern=
el/vdso/Makefile=0A@@ -54,7 +54,7 @@ KASAN_SANITIZE :=3D n=0A KCSAN_SANITIZ=
E :=3D n=0A =0A ccflags-y :=3D -fno-common -fno-builtin=0A-ldflags-y :=3D -=
Wl,--hash-style=3Dboth -nostdlib -shared -z noexecstack=0A+ldflags-y :=3D -=
Wl,--hash-style=3Dboth -nostdlib -shared -z noexecstack $(CLANG_FLAGS)=0A l=
dflags-$(CONFIG_LD_IS_LLD) +=3D $(call cc-option,--ld-path=3D$(LD),-fuse-ld=
=3Dlld)=0A # Filter flags that clang will warn are unused for linking=0A ld=
flags-y +=3D $(filter-out $(CC_AUTO_VAR_INIT_ZERO_ENABLER) $(CC_FLAGS_FTRAC=
E) -Wa$(comma)%, $(KBUILD_CFLAGS))=0A-- =0A2.41.0=0A=0A=0AFrom 47317bd7ecfa=
3fc46e4d754fef3b826b8d310084 Mon Sep 17 00:00:00 2001=0AFrom: Nathan Chance=
llor <nathan@kernel.org>=0ADate: Thu, 1 Jun 2023 12:50:39 -0700=0ASubject: =
[PATCH 3/3] kbuild: Add CLANG_FLAGS to as-instr=0A=0AA future change will m=
ove CLANG_FLAGS from KBUILD_{A,C}FLAGS to=0AKBUILD_CPPFLAGS so that '--targ=
et' is available while preprocessing.=0AWhen that occurs, the following err=
ors appear multiple times when=0Abuilding ARCH=3Dpowerpc powernv_defconfig:=
=0A=0A  ld.lld: error: vmlinux.a(arch/powerpc/kernel/head_64.o):(.text+0x12=
d4): relocation R_PPC64_ADDR16_HI out of range: -4611686018409717520 is not=
 in [-2147483648, 2147483647]; references '__start___soft_mask_table'=0A  l=
d.lld: error: vmlinux.a(arch/powerpc/kernel/head_64.o):(.text+0x12e8): relo=
cation R_PPC64_ADDR16_HI out of range: -4611686018409717392 is not in [-214=
7483648, 2147483647]; references '__stop___soft_mask_table'=0A=0ADiffing th=
e .o.cmd files reveals that -DHAVE_AS_ATHIGH=3D1 is not present=0Aanymore, =
because as-instr only uses KBUILD_AFLAGS, which will no longer=0Acontain '-=
-target'.=0A=0AMirror Kconfig's as-instr and add CLANG_FLAGS explicitly to =
the=0Ainvocation to ensure the target information is always present.=0A=0AS=
igned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A scripts/Makefi=
le.compiler | 2 +-=0A 1 file changed, 1 insertion(+), 1 deletion(-)=0A=0Adi=
ff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler=0Aindex 7a=
a1fbc4aafe..437013f8def3 100644=0A--- a/scripts/Makefile.compiler=0A+++ b/s=
cripts/Makefile.compiler=0A@@ -38,7 +38,7 @@ as-option =3D $(call try-run,\=
=0A # Usage: aflags-y +=3D $(call as-instr,instr,option1,option2)=0A =0A as=
-instr =3D $(call try-run,\=0A-	printf "%b\n" "$(1)" | $(CC) -Werror $(KBUI=
LD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))=0A+	printf "%b\=
n" "$(1)" | $(CC) -Werror $(CLANG_FLAGS) $(KBUILD_AFLAGS) -c -x assembler-w=
ith-cpp -o "$$TMP" -,$(2),$(3))=0A =0A # __cc-option=0A # Usage: MY_CFLAGS =
+=3D $(call __cc-option,$(CC),$(MY_CFLAGS),-march=3Dwinchip-c6,-march=3Di58=
6)=0A-- =0A2.41.0=0A=0A
--7lDxHDkp7IDTfCY4--
