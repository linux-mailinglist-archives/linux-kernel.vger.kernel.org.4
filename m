Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D588E64886C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiLIS0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLIS0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:26:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887B0389C0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:26:32 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso8584810pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 10:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y0tIk3sqFNpbfHpA1sauvw8a7wXa2Xcms6EuyEYhvRk=;
        b=ZAFgp4eeuB30KsOgzpkTWhKYP4oe59cgyqai7KuZpD1LLjw00yzO7fINeDtWdZaIz1
         N5s+469IBqPdFDVZhfH92bc4fyR1YWmFSToug5cPNFwqj46koW4vG3I8XPMeFZdaZhRf
         U93lqGZ5wfiQGH2ucaECSaiFfHxIze+3VIOr0yrEUmqJciGcmk7VyyTDS4FGQZvNDbbv
         qvjpLVp52U2y6qMVQ5az73XIluTz2Vx9fJrY04gsxKyHa4ODqS0IJfnUuqfF0HMqj98d
         gyaGfmunZHNABei21Bzs/q51SZiuQhRuQM1b+RRJUlPrR05BfymnfTIXVunt+036i0L8
         LTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0tIk3sqFNpbfHpA1sauvw8a7wXa2Xcms6EuyEYhvRk=;
        b=wtDqrfxP/wXTOgovpwA/sHEWAFl9eVhZc1ftirMrsH3dGHvhMMC5I2ZrGczXfb0coy
         kNjLQsy1wbk8jHZT1/y4368gPs6f5k18i6T6N95dKE7Xz94Q/WrHn7aB9b/qHJm8cRtz
         ztvl+VBJAT8D/QSNP7kXMSyD/jmIgxLNNfQTz1++R4EbtKzg/Fpsz9Mwc63B+Z4fe9s2
         TsEfRrnx6PuyYsyWxXCseKHe2enPaDYgYmYa9BrN2dMyw8yFihfmDb3xqeolVuzQr7lZ
         VkPSD1Q6f5kUuGPFiOeBydrazMbDkXEEUHtpYU3MaC+9hNlnfr46rxbiT07bob2XKyhv
         1KAw==
X-Gm-Message-State: ANoB5pnsCYELvHRPEXVYQY9RrGyPFJjs4dbhNvHx/j93R53gR6RThT1e
        7vQ/mCPRCkPYQwJJRq3xnBYdSILoL+Jg7JXzpy9Rkg==
X-Google-Smtp-Source: AA0mqf7Irxffe4OQflHuywnqDb6sN/nLBFJocgSX8td1o1PYS66eHUpd/ohf1Fhb2Uth0n8S14TGTCuoadwcmR6m4ys=
X-Received: by 2002:a17:90a:ab84:b0:213:343:9873 with SMTP id
 n4-20020a17090aab8400b0021303439873mr109320494pjq.102.1670610391716; Fri, 09
 Dec 2022 10:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20221122001125.765003-1-irogers@google.com> <20221122001125.765003-5-irogers@google.com>
In-Reply-To: <20221122001125.765003-5-irogers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 9 Dec 2022 10:26:20 -0800
Message-ID: <CAKwvOd=kgXmpfbVa1wiEvwL0tX3gu+dDTGi-HEiRXSojwCLRrg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] objtool: Alter how HOSTCC is forced
To:     Ian Rogers <irogers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 4:12 PM Ian Rogers <irogers@google.com> wrote:
>
> HOSTCC is always wanted when building objtool. Setting CC to HOSTCC
> happens after tools/scripts/Makefile.include is included, meaning
> flags are set assuming say CC is gcc, but then it can be later set to
> HOSTCC which may be clang. tools/scripts/Makefile.include is needed
> for host set up and common macros in objtool's Makefile. Rather than
> override CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the
> libsubcmd builds and the linkage step. This means the Makefiles don't
> see things like CC changing and tool flag determination, and similar,
> work properly. To avoid mixing CFLAGS from different compilers just
> the objtool CFLAGS are determined. HOSTCFLAGS is added to these so
> that command line flags can add to the CFLAGS.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/objtool/Makefile | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index 61a00b7acae9..e550a98e2dd9 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -2,16 +2,12 @@
>  include ../scripts/Makefile.include
>  include ../scripts/Makefile.arch
>
> -# always use the host compiler
> -AR      = $(HOSTAR)
> -CC      = $(HOSTCC)
> -LD      = $(HOSTLD)
> -
>  ifeq ($(srctree),)
>  srctree := $(patsubst %/,%,$(dir $(CURDIR)))
>  srctree := $(patsubst %/,%,$(dir $(srctree)))
>  endif
>
> +MAKE = make -S
>  LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
>  ifneq ($(OUTPUT),)
>    LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
> @@ -36,13 +32,20 @@ INCLUDES := -I$(srctree)/tools/include \
>             -I$(srctree)/tools/objtool/include \
>             -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
>             -I$(LIBSUBCMD_OUTPUT)/include
> -WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs

Looking closer at the V=1 diff in meld, I think this is dropping
EXTRA_WARNINGS.  I think you want to add those back to OBJTOOL_CFLAGS.

> -CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
> -LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
> +WARNINGS := -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
> +OBJTOOL_CFLAGS := -Werror $(WARNINGS) -g $(INCLUDES) $(LIBELF_FLAGS) $(HOSTCFLAGS)
> +OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD)
>
>  # Allow old libelf to be used:
>  elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
> -CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> +OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> +
> +# Always want host compilation.
> +HOST_OVERRIDES := CC="$(HOSTCC)" EXTRA_CFLAGS="$(OBJTOOL_CFLAGS)" \
> +                 LD="$(HOSTLD)" AR="$(HOSTAR)"
> +BUILD_HOST_OVERRIDES := CC="$(HOSTCC)" CFLAGS="$(OBJTOOL_CFLAGS)" \
> +                       LD="$(HOSTLD)" LDFLAGS="$(OBJTOOL_LDFLAGS)" \
> +                       AR="$(HOSTAR)"
>
>  AWK = awk
>  MKDIR = mkdir
> @@ -65,10 +68,11 @@ include $(srctree)/tools/build/Makefile.include
>
>  $(OBJTOOL_IN): fixdep FORCE
>         $(Q)$(CONFIG_SHELL) ./sync-check.sh
> -       $(Q)$(MAKE) $(build)=objtool
> +       $(Q)$(MAKE) $(build)=objtool $(BUILD_HOST_OVERRIDES)
> +
>
>  $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
> -       $(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
> +       $(QUIET_LINK)$(HOSTCC) $(OBJTOOL_IN) $(KBUILD_HOSTLDFLAGS) $(OBJTOOL_LDFLAGS) -o $@
>
>
>  $(LIBSUBCMD_OUTPUT):
> @@ -77,6 +81,7 @@ $(LIBSUBCMD_OUTPUT):
>  $(LIBSUBCMD): fixdep FORCE $(LIBSUBCMD_OUTPUT)
>         $(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
>                 DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= subdir= \
> +               $(HOST_OVERRIDES) \
>                 $@ install_headers
>
>  $(LIBSUBCMD)-clean:
> --
> 2.38.1.584.g0f3c55d4c2-goog
>


-- 
Thanks,
~Nick Desaulniers
