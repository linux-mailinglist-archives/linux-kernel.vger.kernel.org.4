Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23E1686C59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjBARC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjBARCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:02:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EA4F76A3;
        Wed,  1 Feb 2023 09:02:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB0B74B3;
        Wed,  1 Feb 2023 09:03:05 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.13.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E16AF3F64C;
        Wed,  1 Feb 2023 09:02:22 -0800 (PST)
Date:   Wed, 1 Feb 2023 17:02:16 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool: Fix HOSTCC flag usage
Message-ID: <Y9qbGHDBFtGoqnKK@FVFF77S0Q05N>
References: <20230126190606.40739-4-irogers@google.com>
 <167526879495.4906.2898311831401901292.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167526879495.4906.2898311831401901292.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just spotted this breaks cross-compiling; details below.

On Wed, Feb 01, 2023 at 04:26:34PM -0000, tip-bot2 for Ian Rogers wrote:
> The following commit has been merged into the objtool/core branch of tip:
> 
> Commit-ID:     93eacc15687a491a9cf829f94b6891bf544084f3
> Gitweb:        https://git.kernel.org/tip/93eacc15687a491a9cf829f94b6891bf544084f3
> Author:        Ian Rogers <irogers@google.com>
> AuthorDate:    Thu, 26 Jan 2023 11:06:06 -08:00
> Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
> CommitterDate: Mon, 30 Jan 2023 16:28:18 -08:00
> 
> objtool: Fix HOSTCC flag usage
> 
> HOSTCC is always wanted when building objtool. Setting CC to HOSTCC
> happens after tools/scripts/Makefile.include is included, meaning
> flags (like CFLAGS) are set assuming say CC is gcc, but then it can be
> later set to HOSTCC which may be clang. tools/scripts/Makefile.include
> is needed for host set up and common macros in objtool's
> Makefile. Rather than override the CC variable to HOSTCC, just pass CC
> as HOSTCC to the sub-makes of Makefile.build, the libsubcmd builds and
> also to the linkage step.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Link: https://lore.kernel.org/r/20230126190606.40739-4-irogers@google.com
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/Makefile | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index d54b669..29a8cd7 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -2,11 +2,6 @@
>  include ../scripts/Makefile.include
>  include ../scripts/Makefile.arch
>  
> -# always use the host compiler
> -AR	 = $(HOSTAR)
> -CC	 = $(HOSTCC)
> -LD	 = $(HOSTLD)

So as of this change, CC is now the cross-compiler CC ....

> -
>  ifeq ($(srctree),)
>  srctree := $(patsubst %/,%,$(dir $(CURDIR)))
>  srctree := $(patsubst %/,%,$(dir $(srctree)))
> @@ -34,13 +29,18 @@ INCLUDES := -I$(srctree)/tools/include \
>  	    -I$(srctree)/tools/objtool/include \
>  	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
>  	    -I$(LIBSUBCMD_OUTPUT)/include
> +# Note, EXTRA_WARNINGS here was determined for CC and not HOSTCC, it
> +# is passed here to match a legacy behavior.
>  WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
> -CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
> -LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
> +OBJTOOL_CFLAGS := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
> +OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
>  
>  # Allow old libelf to be used:
>  elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)

... and so as of this patch, this check uses the cross-compiler CC rather than
the HOSTCC (and IIUC the wrong CFLAGS too).

So that probably wants to be `$(HOSTCC) $(OBJTOOL_CFLAGS)` ?

The cross CC might not even have libelf in its header path ...

> -CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> +OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)

... which means that we might end up setting DLIBELF_USE_DEPRECATED when we
didn't mean to.

I saw this blowing up in some experiments with an arm64 objtool built on
x86_64, and I believe the reverse can also occur (i.e. building for x86_64 on
arm64).

As of this patch, I get a splat:

| [mark@lakrids:~/src/linux]% usekorg 12.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- tools/objtool/elf.o
|   CALL    scripts/checksyscalls.sh
|   DESCEND objtool
| <stdin>:1:10: fatal error: libelf.h: No such file or directory
| compilation terminated.
|   INSTALL libsubcmd_headers
|   CC      /home/mark/src/linux/tools/objtool/elf.o
| elf.c: In function ‘read_sections’:
| elf.c:273:2: error: ‘elf_getshnum’ is deprecated [-Werror=deprecated-declarations]
|   273 |  if (elf_getshdrnum(elf->elf, &sections_nr)) {
|       |  ^~
| In file included from /usr/include/gelf.h:32,
|                  from /home/mark/src/linux/tools/objtool/include/objtool/elf.h:10,
|                  from elf.c:22:
| /usr/include/libelf.h:310:12: note: declared here
|   310 | extern int elf_getshnum (Elf *__elf, size_t *__dst)
|       |            ^~~~~~~~~~~~
| elf.c:278:2: error: ‘elf_getshstrndx’ is deprecated [-Werror=deprecated-declarations]
|   278 |  if (elf_getshdrstrndx(elf->elf, &shstrndx)) {
|       |  ^~
| In file included from /usr/include/gelf.h:32,
|                  from /home/mark/src/linux/tools/objtool/include/objtool/elf.h:10,
|                  from elf.c:22:
| /usr/include/libelf.h:322:12: note: declared here
|   322 | extern int elf_getshstrndx (Elf *__elf, size_t *__dst)
|       |            ^~~~~~~~~~~~~~~
| cc1: all warnings being treated as errors
| make[3]: *** [/home/mark/src/linux/tools/build/Makefile.build:97: /home/mark/src/linux/tools/objtool/elf.o] Error 1
| make[2]: *** [Makefile:66: /home/mark/src/linux/tools/objtool/objtool-in.o] Error 2
| make[1]: *** [Makefile:73: objtool] Error 2
| make: *** [Makefile:1439: tools/objtool] Error 2

Thanks,
Mark.

> +
> +# Always want host compilation.
> +HOST_OVERRIDES := CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)"
>  
>  AWK = awk
>  MKDIR = mkdir
> @@ -61,12 +61,14 @@ export BUILD_ORC
>  export srctree OUTPUT CFLAGS SRCARCH AWK
>  include $(srctree)/tools/build/Makefile.include
>  
> -$(OBJTOOL_IN): fixdep FORCE
> +$(OBJTOOL_IN): fixdep $(LIBSUBCMD) FORCE
>  	$(Q)$(CONFIG_SHELL) ./sync-check.sh
> -	$(Q)$(MAKE) $(build)=objtool
> +	$(Q)$(MAKE) $(build)=objtool $(HOST_OVERRIDES) CFLAGS="$(OBJTOOL_CFLAGS)" \
> +		LDFLAGS="$(OBJTOOL_LDFLAGS)"
> +
>  
>  $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
> -	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
> +	$(QUIET_LINK)$(HOSTCC) $(OBJTOOL_IN) $(OBJTOOL_LDFLAGS) -o $@
>  
>  
>  $(LIBSUBCMD_OUTPUT):
> @@ -75,6 +77,7 @@ $(LIBSUBCMD_OUTPUT):
>  $(LIBSUBCMD): fixdep $(LIBSUBCMD_OUTPUT) FORCE
>  	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
>  		DESTDIR=$(LIBSUBCMD_OUTPUT) prefix= subdir= \
> +		$(HOST_OVERRIDES) EXTRA_CFLAGS="$(OBJTOOL_CFLAGS)" \
>  		$@ install_headers
>  
>  $(LIBSUBCMD)-clean:
