Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE5967C293
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 02:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjAZBtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 20:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAZBtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 20:49:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64847611F8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:49:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2F87616FD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EA1C433D2;
        Thu, 26 Jan 2023 01:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674697784;
        bh=mkXTZAlnUvQp4xBJz9AaQKaSqMGaCsbGS5FQIjxN6oY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jkpqxWDLvWazYFLkwTru4yD6TRaNks/ERH7h4Tl8NLPua2tImd9+ZWg4ryQKwHlOy
         +1+g3APugVqo6FdDJT420pPfKZRE2z6g44U/sdAflueoYKz3v0O+Q4blUW+AFfpoJ8
         kUq3EifCwZ8xcv1Wdn3SU8VP6xwEW+kSZ/vEWvr8ccgVAW7ZwsRZolunzvyYKMa85U
         wvgiQtARwVD7uaxvSRmt5CFskzxLZB7mxHYzRC7akAPpiFA5ibg79qx85/oSPKDTl/
         56c24l1WSWHIpzMwU1HfK8Nr1JKm0YIpp9qODTJdGE3J1ttaVfS+vE+iLqw+phWkzE
         UQsJavsZ0/jUw==
Date:   Wed, 25 Jan 2023 17:49:42 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 3/3] objtool: Alter how HOSTCC is forced
Message-ID: <20230126014942.kuynrl56b2u4npj6@treble>
References: <20230105090155.357604-1-irogers@google.com>
 <20230105090155.357604-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230105090155.357604-4-irogers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 01:01:55AM -0800, Ian Rogers wrote:
> HOSTCC is always wanted when building objtool. Setting CC to HOSTCC
> happens after tools/scripts/Makefile.include is included, meaning
> flags are set assuming say CC is gcc, but then it can be later set to
> HOSTCC which may be clang. tools/scripts/Makefile.include is needed
> for host set up and common macros in objtool's Makefile. Rather than
> override CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the
> libsubcmd builds and the linkage step. This means the Makefiles don't
> see things like CC changing and tool flag determination, and similar,
> work properly.

I'm having trouble parsing this last sentence, can you rephrase or
restructure it?

> To avoid mixing CFLAGS from different compilers just
> the objtool CFLAGS are determined with the exception of
> EXTRA_WARNINGS.

I'm not really sure what this one means either.

> HOSTCFLAGS is added to these so that command line
> flags can add to the CFLAGS.

Overall this patch description is a big wall of dense text which I found
hard to decipher.  Please split it up into paragraphs and make it more
legible and logical.

For example, un-jumble the ordering, with the background first, then the
problem(s), then the fix(es).  (At least three paragraphs)

If possible, the subject should describe the end result for the user,
something like

  objtool: Fix HOSTCFLAGS cmdline support

... unless I'm misunderstanding the point of the patch.

HOSTCFLAGS from the cmdline *used* to work, a git bisect shows it
stopped working with

  96f14fe738b6 ("kbuild: Rename HOSTCFLAGS to KBUILD_HOSTCFLAGS")

... so please add a "Fixes" tag for that commit.

> +MAKE = make -S

Why?

>  LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
>  ifneq ($(OUTPUT),)
>    LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
> @@ -37,12 +33,19 @@ INCLUDES := -I$(srctree)/tools/include \
>  	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
>  	    -I$(LIBSUBCMD_OUTPUT)/include
>  WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
> -CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
> -LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
> +OBJTOOL_CFLAGS := -Werror $(WARNINGS) -g $(INCLUDES) $(LIBELF_FLAGS) $(HOSTCFLAGS)

I *think* I understand the reason for the switch from KBUILD_HOSTCFLAGS
to HOSTCFLAGS -- because KBUILD_HOSTCFLAGS is defined in the top-level
kernel Makefile which isn't included here so it's undefined? -- but
regardless that should be called out more explicitly as a problem being
fixed in the commit log.

This issue really has me scratching my head, as I could have sworn
objtool was being built with -O2.

> +OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD)

Is there a reason to not include $(HOSTLDFLAGS) here?

>  # Allow old libelf to be used:
>  elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
> -CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> +OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> +
> +# Always want host compilation.
> +HOST_OVERRIDES := CC="$(HOSTCC)" EXTRA_CFLAGS="$(OBJTOOL_CFLAGS)" \
> +		  LD="$(HOSTLD)" AR="$(HOSTAR)"
> +BUILD_HOST_OVERRIDES := CC="$(HOSTCC)" CFLAGS="$(OBJTOOL_CFLAGS)" \
> +			LD="$(HOSTLD)" LDFLAGS="$(OBJTOOL_LDFLAGS)" \
> +			AR="$(HOSTAR)"

Maybe it depends on your perspective, but I'm thinking that some of
these aren't really overrides, but rather normal expected flags.  And
the distinction between these two variables is muddy: it's not only
Build vs non-Build, but also objtool vs libsubcmd.

How about just

  HOST_OVERRIDES := CC="$(HOSTCC) "LD="$(HOSTLD)" AR="$(HOSTAR)"

And then specifying the {EXTRA_}CFLAGS and LDFLAGS below where needed.

>  AWK = awk
>  MKDIR = mkdir
> @@ -65,10 +68,11 @@ include $(srctree)/tools/build/Makefile.include
>  
>  $(OBJTOOL_IN): fixdep FORCE
>  	$(Q)$(CONFIG_SHELL) ./sync-check.sh
> -	$(Q)$(MAKE) $(build)=objtool
> +	$(Q)$(MAKE) $(build)=objtool $(BUILD_HOST_OVERRIDES)
> +
>  
>  $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
> -	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
> +	$(QUIET_LINK)$(HOSTCC) $(OBJTOOL_IN) $(KBUILD_HOSTLDFLAGS) $(OBJTOOL_LDFLAGS) -o $@

Does KBUILD_HOSTLDFLAGS even work here?

-- 
Josh
