Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0679164CFED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 20:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbiLNTO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 14:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiLNTOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:14:22 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CC620347
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:14:21 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o5so834959wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1AwZaH5JIoKs86X8in+Ofgepd04rN9EuIQh7OlgsTXc=;
        b=bYeX2lMcH6vOsW+SAP/DbiKABbnuV1dhTBY4P5LY+HLxYAFm72PsD7U6Og+uAy0e0V
         EPos6EmkFTFH4rl/1jYyWBFaBYIMuxEA6tab5jvqgfIQroBUTlnO+jPH5N+cpGtH7Z1M
         sdyZF4YVwVGlfU7u9mUPKnpn9x0GH7b4jbQxJwW4pyaHNkT3uEf/wrsfT2/hs0Zt8Msx
         goJCbfT8NmjHyrJ37W0W/EcAr8a4hfk9su6s88otLjozes1wX+2atX2EKlyzO5P92o1O
         cYpMfN1aBtjGdkv2tYF/J3OQ8TfPMqxjNT4BbNn4TFqkGv85R9yCUxTechqo9XCRABaa
         lVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AwZaH5JIoKs86X8in+Ofgepd04rN9EuIQh7OlgsTXc=;
        b=OQjStQ8op5Nw6Eg8RYgcweFFX6eYDVzXm7OWBE5NQog9Cu7cVTOi7Xa2UOtCHri2Ct
         VdmChEwvF52el8biSxNfa2NiRoxwzFlk6TPJ+mA3KYF2RTg3mLqUx+GuY4Br7yGIr2My
         TIfoW2psmoyNDYJ8KCrxhCzAxRefanxXCWjKTWcawMaY1ypviHlsjU8axeMMJskA1Wa3
         pO2/zFGzu8eYRRmJwpORFVb2ReZ91+/IBPFKAIGRTdZ2phYuYK1c012vNoDbw+0mP6sG
         D8nra0Nz1PC1H4WApabhuMVEsquMQIJqkF6adGeC8YSXprDDnCQOVsFFcuOv/zMeW1IN
         GHkQ==
X-Gm-Message-State: AFqh2kpVmi8WQXBjM33W6L4I+1rK7QFX4ir0h0cpmNcoABzKTj5XEHcE
        vrNgnu9YBsyTjM+KP7m3BXa4bulH+FCmef34vKu+tw==
X-Google-Smtp-Source: AMrXdXvviWzSpjJF9LGtBqcCOf9kkJCtLsjUOn99v38MDVwK8l3jDE/7frHjgWzRAYXkQXsXRInjezwsrRqT1E9AI0s=
X-Received: by 2002:a05:6000:69b:b0:256:c249:b819 with SMTP id
 bo27-20020a056000069b00b00256c249b819mr9042wrb.654.1671045259498; Wed, 14 Dec
 2022 11:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20221122001125.765003-1-irogers@google.com> <20221122001125.765003-5-irogers@google.com>
 <CAKwvOd=kgXmpfbVa1wiEvwL0tX3gu+dDTGi-HEiRXSojwCLRrg@mail.gmail.com>
 <CAP-5=fUX2jYgKVrnFLH2MjhUXb_Y1KGdoonkeLE7AcB5gdtaVw@mail.gmail.com> <CAKwvOdmpfA0kqU9otkuXq-BkjuUtDiS+JANTEftpWBp-wJmdCg@mail.gmail.com>
In-Reply-To: <CAKwvOdmpfA0kqU9otkuXq-BkjuUtDiS+JANTEftpWBp-wJmdCg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Dec 2022 11:14:07 -0800
Message-ID: <CAP-5=fV6XPTXNi+5EamYKLQFP0VBGQWaHa3n+jNYGL9m6vz_dA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] objtool: Alter how HOSTCC is forced
To:     Nick Desaulniers <ndesaulniers@google.com>
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

On Wed, Dec 14, 2022 at 10:34 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Dec 14, 2022 at 10:25 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Fri, Dec 9, 2022 at 10:26 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Mon, Nov 21, 2022 at 4:12 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > HOSTCC is always wanted when building objtool. Setting CC to HOSTCC
> > > > happens after tools/scripts/Makefile.include is included, meaning
> > > > flags are set assuming say CC is gcc, but then it can be later set to
> > > > HOSTCC which may be clang. tools/scripts/Makefile.include is needed
> > > > for host set up and common macros in objtool's Makefile. Rather than
> > > > override CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the
> > > > libsubcmd builds and the linkage step. This means the Makefiles don't
> > > > see things like CC changing and tool flag determination, and similar,
> > > > work properly. To avoid mixing CFLAGS from different compilers just
> > > > the objtool CFLAGS are determined. HOSTCFLAGS is added to these so
> > > > that command line flags can add to the CFLAGS.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/objtool/Makefile | 27 ++++++++++++++++-----------
> > > >  1 file changed, 16 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> > > > index 61a00b7acae9..e550a98e2dd9 100644
> > > > --- a/tools/objtool/Makefile
> > > > +++ b/tools/objtool/Makefile
> > > > @@ -2,16 +2,12 @@
> > > >  include ../scripts/Makefile.include
> > > >  include ../scripts/Makefile.arch
> > > >
> > > > -# always use the host compiler
> > > > -AR      = $(HOSTAR)
> > > > -CC      = $(HOSTCC)
> > > > -LD      = $(HOSTLD)
> > > > -
> > > >  ifeq ($(srctree),)
> > > >  srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> > > >  srctree := $(patsubst %/,%,$(dir $(srctree)))
> > > >  endif
> > > >
> > > > +MAKE = make -S
> > > >  LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
> > > >  ifneq ($(OUTPUT),)
> > > >    LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
> > > > @@ -36,13 +32,20 @@ INCLUDES := -I$(srctree)/tools/include \
> > > >             -I$(srctree)/tools/objtool/include \
> > > >             -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
> > > >             -I$(LIBSUBCMD_OUTPUT)/include
> > > > -WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
> > >
> > > Looking closer at the V=1 diff in meld, I think this is dropping
> > > EXTRA_WARNINGS.  I think you want to add those back to OBJTOOL_CFLAGS.
> >
> > Thanks Nick! When I try this it causes new build failures.
> > Specifically EXTRA_WARNINGS includes things like -Wswitch-enum that
> > trigger:
>
> That's...unexpected. These warnings didn't exist when EXTRA_WARNINGS
> was being passed to the compiler for these...unless that wasn't the
> case?

I wasn't adding EXTRA_WARNINGS but they are set up here:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/tools/scripts/Makefile.include?id=630ae80ea1dd253609cb50cff87f3248f901aca3#n23

I've avoided in these changes passing through values from
Makefile.include to the subprocesses, like Makefile.build, as
Makefile.include makes choices based on the current flags like clang
and llvm, not those we override.

> >
> > ```
> > check.c:1312:10: error: 14 enumeration values not explicitly handled
> > in switch: 'INSN_JUMP_DYNAMIC',
> > 'INSN_JUMP_DYNAMIC_CONDITIONAL', 'INSN_CALL_DYNAMIC'... [-Werror,-Wswitch-enum]
> >        switch (insn->type) {
> >                ^~~~~~~~~~
> > check.c:2620:11: error: enumeration value 'OP_SRC_CONST' not
> > explicitly handled in switch [-Werror,-
> > Wswitch-enum]
> >                switch (op->src.type) {
> >                        ^~~~~~~~~~~~
> > check.c:3447:11: error: 5 enumeration values not explicitly handled in
> > switch: 'INSN_BUG', 'INSN_NOP
> > ', 'INSN_TRAP'... [-Werror,-Wswitch-enum]
> >                switch (insn->type) {
> >                        ^~~~~~~~~~
> > check.c:3647:11: error: 9 enumeration values not explicitly handled in
> > switch: 'INSN_CONTEXT_SWITCH'
> > , 'INSN_BUG', 'INSN_STAC'... [-Werror,-Wswitch-enum]
> >                switch (insn->type) {
> >                        ^~~~~~~~~~
> > check.c:4008:10: error: 9 enumeration values not explicitly handled in
> > switch: 'INSN_CONTEXT_SWITCH'
> > , 'INSN_BUG', 'INSN_STAC'... [-Werror,-Wswitch-enum]
> >        switch (insn->type) {
> >                ^~~~~~~~~~
> > check.c:4173:11: error: 15 enumeration values not explicitly handled
> > in switch: 'INSN_JUMP_CONDITION
> > AL', 'INSN_JUMP_UNCONDITIONAL', 'INSN_JUMP_DYNAMIC_CONDITIONAL'...
> > [-Werror,-Wswitch-enum]
> >                switch (insn->type) {
> >                        ^~~~~~~~~~
> > 6 errors generated.
> > ```
> >
> > What should the next step be? Land this or add EXTRA_WARNINGS and fix
> > all the issues?
>
> Up to Josh. I think the first 3 patches are ready to go.

Note, the first patch is already in Arnaldo's tree:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=630ae80ea1dd253609cb50cff87f3248f901aca3
and shows up in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/tools/lib/subcmd/Makefile?id=630ae80ea1dd253609cb50cff87f3248f901aca3

Thanks,
Ian



> >
> > Thanks,
> > Ian
> >
> > > > -CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
> > > > -LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
> > > > +WARNINGS := -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
> > > > +OBJTOOL_CFLAGS := -Werror $(WARNINGS) -g $(INCLUDES) $(LIBELF_FLAGS) $(HOSTCFLAGS)
> > > > +OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD)
> > > >
> > > >  # Allow old libelf to be used:
> > > >  elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
> > > > -CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> > > > +OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> > > > +
> > > > +# Always want host compilation.
> > > > +HOST_OVERRIDES := CC="$(HOSTCC)" EXTRA_CFLAGS="$(OBJTOOL_CFLAGS)" \
> > > > +                 LD="$(HOSTLD)" AR="$(HOSTAR)"
> > > > +BUILD_HOST_OVERRIDES := CC="$(HOSTCC)" CFLAGS="$(OBJTOOL_CFLAGS)" \
> > > > +                       LD="$(HOSTLD)" LDFLAGS="$(OBJTOOL_LDFLAGS)" \
> > > > +                       AR="$(HOSTAR)"
> > > >
> > > >  AWK = awk
> > > >  MKDIR = mkdir
> > > > @@ -65,10 +68,11 @@ include $(srctree)/tools/build/Makefile.include
> > > >
> > > >  $(OBJTOOL_IN): fixdep FORCE
> > > >         $(Q)$(CONFIG_SHELL) ./sync-check.sh
> > > > -       $(Q)$(MAKE) $(build)=objtool
> > > > +       $(Q)$(MAKE) $(build)=objtool $(BUILD_HOST_OVERRIDES)
> > > > +
> > > >
> > > >  $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
> > > > -       $(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
> > > > +       $(QUIET_LINK)$(HOSTCC) $(OBJTOOL_IN) $(KBUILD_HOSTLDFLAGS) $(OBJTOOL_LDFLAGS) -o $@
> > > >
> > > >
> > > >  $(LIBSUBCMD_OUTPUT):
> > > > @@ -77,6 +81,7 @@ $(LIBSUBCMD_OUTPUT):
> > > >  $(LIBSUBCMD): fixdep FORCE $(LIBSUBCMD_OUTPUT)
> > > >         $(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
> > > >                 DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= subdir= \
> > > > +               $(HOST_OVERRIDES) \
> > > >                 $@ install_headers
> > > >
> > > >  $(LIBSUBCMD)-clean:
> > > > --
> > > > 2.38.1.584.g0f3c55d4c2-goog
> > > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
