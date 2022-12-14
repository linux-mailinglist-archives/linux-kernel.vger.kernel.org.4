Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D60164CF76
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbiLNSek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiLNSeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:34:36 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1DB24A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:34:34 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d82so5063176pfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q1lLeL3zoxrG+zW4O35zg0NsMGZip1ffQDIMVfHUyD8=;
        b=jJOWMRHBSzcPEjFGxcLozunq+G1nBBHRHqJ5zRlk0tZU9CXQsRbeEEU10Rfa62zG47
         AQ3rzmnHeNFY2L09upcixtG0bRm+3/0tf19muTsXngA0gx1qHaqzWB0Hn/26Hfpj9q08
         3zH4mFsPyl3id3WV3zSBtYv4RxRBNQrBE96r2PE1ZCc1ks0iQAavxMuZHppep0+YDu9H
         7tGWWK8cWOKN7MkBfCJa7r+sW+PwIiTApaNbWNTMbltui0h716D7g2HDlt9o/RRLgxxB
         gDH4Dj0VnR0XyrYTE6u0V97QSwV/12/nie2m7xINjzDaEvl/2uAC8b0WZGTgg7UHkMnM
         ciJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1lLeL3zoxrG+zW4O35zg0NsMGZip1ffQDIMVfHUyD8=;
        b=VzeCdGoaGl8TBUvsCrV531SV3E+1dljTaI8IMKJsX00NL73LWYdTwCyjZe+HAUK1OO
         A3zGEjeWSTZKCtzAQm9uO7/lsEldU5dW7/9XLrEsoGU/0sctQwEtP+OTg1O+wj5u9P5k
         DWk8eyL6wk+f0TZtXfIdUvpPzuy9BEZM25HnrnRrBzRZNPCP3n+Zx+Llje/UEVJ0rIxe
         N3jO//rIqrNSncBgGbgVyO09cs9Yw+17/mEwPYpm2ePYFEIbcmWlsGGD5ALsgRtk5f6u
         jIzG/0dYyX5rdLLghnHzeIZKcOOLrRwz7YHXcYNU2mydMsIaGRT1de2taY6PL6RVcVZQ
         MmqQ==
X-Gm-Message-State: AFqh2krf5M6fX77DWtvyIDz6Zv9LPetQSkP3599tziPk0/Y77bKQIi2L
        as7TLI8A5OCAMWlc2xck0DO4Dos25aNTSBqM7/768Q==
X-Google-Smtp-Source: AMrXdXtco2rVGP+uHuubf5DXng37yc9Y86G6/aj4M2JEwzEDmbhChwqwRXF+naIxjNgT6XJwy91dBaGZRtpKTu+JLos=
X-Received: by 2002:a63:4923:0:b0:481:87f6:29c7 with SMTP id
 w35-20020a634923000000b0048187f629c7mr45127pga.427.1671042873357; Wed, 14 Dec
 2022 10:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20221122001125.765003-1-irogers@google.com> <20221122001125.765003-5-irogers@google.com>
 <CAKwvOd=kgXmpfbVa1wiEvwL0tX3gu+dDTGi-HEiRXSojwCLRrg@mail.gmail.com> <CAP-5=fUX2jYgKVrnFLH2MjhUXb_Y1KGdoonkeLE7AcB5gdtaVw@mail.gmail.com>
In-Reply-To: <CAP-5=fUX2jYgKVrnFLH2MjhUXb_Y1KGdoonkeLE7AcB5gdtaVw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 14 Dec 2022 10:34:21 -0800
Message-ID: <CAKwvOdmpfA0kqU9otkuXq-BkjuUtDiS+JANTEftpWBp-wJmdCg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] objtool: Alter how HOSTCC is forced
To:     Ian Rogers <irogers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

On Wed, Dec 14, 2022 at 10:25 AM Ian Rogers <irogers@google.com> wrote:
>
> On Fri, Dec 9, 2022 at 10:26 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, Nov 21, 2022 at 4:12 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > HOSTCC is always wanted when building objtool. Setting CC to HOSTCC
> > > happens after tools/scripts/Makefile.include is included, meaning
> > > flags are set assuming say CC is gcc, but then it can be later set to
> > > HOSTCC which may be clang. tools/scripts/Makefile.include is needed
> > > for host set up and common macros in objtool's Makefile. Rather than
> > > override CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the
> > > libsubcmd builds and the linkage step. This means the Makefiles don't
> > > see things like CC changing and tool flag determination, and similar,
> > > work properly. To avoid mixing CFLAGS from different compilers just
> > > the objtool CFLAGS are determined. HOSTCFLAGS is added to these so
> > > that command line flags can add to the CFLAGS.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/objtool/Makefile | 27 ++++++++++++++++-----------
> > >  1 file changed, 16 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> > > index 61a00b7acae9..e550a98e2dd9 100644
> > > --- a/tools/objtool/Makefile
> > > +++ b/tools/objtool/Makefile
> > > @@ -2,16 +2,12 @@
> > >  include ../scripts/Makefile.include
> > >  include ../scripts/Makefile.arch
> > >
> > > -# always use the host compiler
> > > -AR      = $(HOSTAR)
> > > -CC      = $(HOSTCC)
> > > -LD      = $(HOSTLD)
> > > -
> > >  ifeq ($(srctree),)
> > >  srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> > >  srctree := $(patsubst %/,%,$(dir $(srctree)))
> > >  endif
> > >
> > > +MAKE = make -S
> > >  LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
> > >  ifneq ($(OUTPUT),)
> > >    LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
> > > @@ -36,13 +32,20 @@ INCLUDES := -I$(srctree)/tools/include \
> > >             -I$(srctree)/tools/objtool/include \
> > >             -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
> > >             -I$(LIBSUBCMD_OUTPUT)/include
> > > -WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
> >
> > Looking closer at the V=1 diff in meld, I think this is dropping
> > EXTRA_WARNINGS.  I think you want to add those back to OBJTOOL_CFLAGS.
>
> Thanks Nick! When I try this it causes new build failures.
> Specifically EXTRA_WARNINGS includes things like -Wswitch-enum that
> trigger:

That's...unexpected. These warnings didn't exist when EXTRA_WARNINGS
was being passed to the compiler for these...unless that wasn't the
case?

>
> ```
> check.c:1312:10: error: 14 enumeration values not explicitly handled
> in switch: 'INSN_JUMP_DYNAMIC',
> 'INSN_JUMP_DYNAMIC_CONDITIONAL', 'INSN_CALL_DYNAMIC'... [-Werror,-Wswitch-enum]
>        switch (insn->type) {
>                ^~~~~~~~~~
> check.c:2620:11: error: enumeration value 'OP_SRC_CONST' not
> explicitly handled in switch [-Werror,-
> Wswitch-enum]
>                switch (op->src.type) {
>                        ^~~~~~~~~~~~
> check.c:3447:11: error: 5 enumeration values not explicitly handled in
> switch: 'INSN_BUG', 'INSN_NOP
> ', 'INSN_TRAP'... [-Werror,-Wswitch-enum]
>                switch (insn->type) {
>                        ^~~~~~~~~~
> check.c:3647:11: error: 9 enumeration values not explicitly handled in
> switch: 'INSN_CONTEXT_SWITCH'
> , 'INSN_BUG', 'INSN_STAC'... [-Werror,-Wswitch-enum]
>                switch (insn->type) {
>                        ^~~~~~~~~~
> check.c:4008:10: error: 9 enumeration values not explicitly handled in
> switch: 'INSN_CONTEXT_SWITCH'
> , 'INSN_BUG', 'INSN_STAC'... [-Werror,-Wswitch-enum]
>        switch (insn->type) {
>                ^~~~~~~~~~
> check.c:4173:11: error: 15 enumeration values not explicitly handled
> in switch: 'INSN_JUMP_CONDITION
> AL', 'INSN_JUMP_UNCONDITIONAL', 'INSN_JUMP_DYNAMIC_CONDITIONAL'...
> [-Werror,-Wswitch-enum]
>                switch (insn->type) {
>                        ^~~~~~~~~~
> 6 errors generated.
> ```
>
> What should the next step be? Land this or add EXTRA_WARNINGS and fix
> all the issues?

Up to Josh. I think the first 3 patches are ready to go.

>
> Thanks,
> Ian
>
> > > -CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
> > > -LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
> > > +WARNINGS := -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
> > > +OBJTOOL_CFLAGS := -Werror $(WARNINGS) -g $(INCLUDES) $(LIBELF_FLAGS) $(HOSTCFLAGS)
> > > +OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD)
> > >
> > >  # Allow old libelf to be used:
> > >  elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
> > > -CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> > > +OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> > > +
> > > +# Always want host compilation.
> > > +HOST_OVERRIDES := CC="$(HOSTCC)" EXTRA_CFLAGS="$(OBJTOOL_CFLAGS)" \
> > > +                 LD="$(HOSTLD)" AR="$(HOSTAR)"
> > > +BUILD_HOST_OVERRIDES := CC="$(HOSTCC)" CFLAGS="$(OBJTOOL_CFLAGS)" \
> > > +                       LD="$(HOSTLD)" LDFLAGS="$(OBJTOOL_LDFLAGS)" \
> > > +                       AR="$(HOSTAR)"
> > >
> > >  AWK = awk
> > >  MKDIR = mkdir
> > > @@ -65,10 +68,11 @@ include $(srctree)/tools/build/Makefile.include
> > >
> > >  $(OBJTOOL_IN): fixdep FORCE
> > >         $(Q)$(CONFIG_SHELL) ./sync-check.sh
> > > -       $(Q)$(MAKE) $(build)=objtool
> > > +       $(Q)$(MAKE) $(build)=objtool $(BUILD_HOST_OVERRIDES)
> > > +
> > >
> > >  $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
> > > -       $(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
> > > +       $(QUIET_LINK)$(HOSTCC) $(OBJTOOL_IN) $(KBUILD_HOSTLDFLAGS) $(OBJTOOL_LDFLAGS) -o $@
> > >
> > >
> > >  $(LIBSUBCMD_OUTPUT):
> > > @@ -77,6 +81,7 @@ $(LIBSUBCMD_OUTPUT):
> > >  $(LIBSUBCMD): fixdep FORCE $(LIBSUBCMD_OUTPUT)
> > >         $(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
> > >                 DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= subdir= \
> > > +               $(HOST_OVERRIDES) \
> > >                 $@ install_headers
> > >
> > >  $(LIBSUBCMD)-clean:
> > > --
> > > 2.38.1.584.g0f3c55d4c2-goog
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
