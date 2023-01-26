Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2034667D431
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjAZSak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjAZSaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:30:39 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02FA4205
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:30:37 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so2652530wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d7P4qCEo/5JDkUBBb+m1P8s12F5oRB4XK3uHiTik8E0=;
        b=il9RJvvqhUetOHKTNzHiN3GRVUSiTZ62aVY9BTIIJPsuQJdbV0mu0AISF9+RkUVdPC
         oS2waNQcPsE8LEvsTJP5eOGVkwxUn5TDc4xq637vWnaCVcAXqmbea0zeTxmy/MgDCzFN
         +4/XTfKW6OLjUm6j6a1eRvJ0nWMLho2PEHoG5+YPvTZlc5AI618N88FkPl9k13KWrf2D
         gEJT9y8yk6Hq2jjfe75wN/tK+slpyn6j4A+Omw35Ww2/1J2JSAOfwqHlJ2q2fy1W+hvQ
         9L6Q0Aklbitq4Aj5GZJb4hA4x9aHahMfZ0E0IYA2rAzEmv4NQOaTEwfgJyznMD8PMuh5
         ec9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7P4qCEo/5JDkUBBb+m1P8s12F5oRB4XK3uHiTik8E0=;
        b=YmSt/xdpJLS71msHe0sOhI3TeEZmBRVwNYUmij2Vy2/Fb9j8UO9VcHwfsd8TQzDNil
         ZYEkRCa5aPLamJGYiLUSR3c9+l5E8sNytP0ATD03QbVAZ49LRzW6i0CKv+TQp6dxzqWb
         Yi1W4ypGYstsc0kx44Yk/Mmb/4M8/LpCgysfT9LxBr8VaR4lMtTa7meMIIq2vT3yOrZa
         46jcw3t/9SojwW6EsOlIZ0peiyYg0tJWtWsKWE9UnzWi7o8yttcgtHmvYKhTY0a41caQ
         2iBxayAoghCyhoj9OxXBCnP2z4T9rugVgpHwFWX0qbihubXAteP/1F7UqMgp6J7+Ynu3
         kDqw==
X-Gm-Message-State: AO0yUKVqfTMVcsQj+LNQ7V2teZXRchsFcQNRQ87k6yn00aMIHaySuqWG
        CPcK/1U5iW5ZJz+LsZ4Zy+ADBRUJ3M4/zOt+D0Djmg==
X-Google-Smtp-Source: AK7set9r9JUjD2WKgtAVmcXejBhSnECfzDx+EXqZ0is8wEvkTdoJ4WR0xVUelW8o9vV1Ix1FsGF1HYbQ6gyKKeLjoUI=
X-Received: by 2002:a5d:5341:0:b0:2bf:b79f:73f0 with SMTP id
 t1-20020a5d5341000000b002bfb79f73f0mr339744wrv.654.1674757836089; Thu, 26 Jan
 2023 10:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20230105090155.357604-1-irogers@google.com> <20230105090155.357604-4-irogers@google.com>
 <20230126014942.kuynrl56b2u4npj6@treble>
In-Reply-To: <20230126014942.kuynrl56b2u4npj6@treble>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 26 Jan 2023 10:30:24 -0800
Message-ID: <CAP-5=fVtzmJZXdnRaFEoHqGEtab1angyGCXQ=JTm6vbjME7Wrg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] objtool: Alter how HOSTCC is forced
To:     Josh Poimboeuf <jpoimboe@kernel.org>
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

On Wed, Jan 25, 2023 at 5:49 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Thu, Jan 05, 2023 at 01:01:55AM -0800, Ian Rogers wrote:
> > HOSTCC is always wanted when building objtool. Setting CC to HOSTCC
> > happens after tools/scripts/Makefile.include is included, meaning
> > flags are set assuming say CC is gcc, but then it can be later set to
> > HOSTCC which may be clang. tools/scripts/Makefile.include is needed
> > for host set up and common macros in objtool's Makefile. Rather than
> > override CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the
> > libsubcmd builds and the linkage step. This means the Makefiles don't
> > see things like CC changing and tool flag determination, and similar,
> > work properly.
>
> I'm having trouble parsing this last sentence, can you rephrase or
> restructure it?

It was restating what was happening, deleted.

> > To avoid mixing CFLAGS from different compilers just
> > the objtool CFLAGS are determined with the exception of
> > EXTRA_WARNINGS.
>
> I'm not really sure what this one means either.

Moved to an inline comment.

> > HOSTCFLAGS is added to these so that command line
> > flags can add to the CFLAGS.
>
> Overall this patch description is a big wall of dense text which I found
> hard to decipher.  Please split it up into paragraphs and make it more
> legible and logical.

Yes, I've deleted most of the text now. I'd been adding to it as v1
went to v2 and so on.

> For example, un-jumble the ordering, with the background first, then the
> problem(s), then the fix(es).  (At least three paragraphs)
>
> If possible, the subject should describe the end result for the user,
> something like
>
>   objtool: Fix HOSTCFLAGS cmdline support
>
> ... unless I'm misunderstanding the point of the patch.

The patch is trying to fix the Makefile. Setting "CC=$(HOSTCC)" was
just wrong as apparent from looking at the behavior of
tools/scripts/Makefile.include. Some of that persists after this
change with WARNINGS, as now noted in a comment. A side effect of
fixing the Makefile is to make HOSTCFLAGS work, but I suspect with the
variable renames this may not be working. I'll leave that for yourself
and Nick. I told Nick I'd take a look at this as I saw the wrong use
of libsubcmd's headers and that was something I wanted to clean up
having done similar in tools/perf, along with the whole removal of
tools/lib/traceevent from Linux 6.2.

> HOSTCFLAGS from the cmdline *used* to work, a git bisect shows it
> stopped working with
>
>   96f14fe738b6 ("kbuild: Rename HOSTCFLAGS to KBUILD_HOSTCFLAGS")
>
> ... so please add a "Fixes" tag for that commit.

Left off, see later.

> > +MAKE = make -S
>
> Why?

Cruft, removed.

> >  LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
> >  ifneq ($(OUTPUT),)
> >    LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
> > @@ -37,12 +33,19 @@ INCLUDES := -I$(srctree)/tools/include \
> >           -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
> >           -I$(LIBSUBCMD_OUTPUT)/include
> >  WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
> > -CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
> > -LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
> > +OBJTOOL_CFLAGS := -Werror $(WARNINGS) -g $(INCLUDES) $(LIBELF_FLAGS) $(HOSTCFLAGS)
>
> I *think* I understand the reason for the switch from KBUILD_HOSTCFLAGS
> to HOSTCFLAGS -- because KBUILD_HOSTCFLAGS is defined in the top-level
> kernel Makefile which isn't included here so it's undefined? -- but
> regardless that should be called out more explicitly as a problem being
> fixed in the commit log.

I was matching tools/perf, I've switched back to KBUILD_HOSTCFLAGS in
v4. There's some higher logic at play with these variable names and
I'm not aware of it so I'll leave it to be fixed if necessary later.

> This issue really has me scratching my head, as I could have sworn
> objtool was being built with -O2.
>
> > +OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD)
>
> Is there a reason to not include $(HOSTLDFLAGS) here?

Done as KBUILD_HOSTLDFLAGS as I don't see HOSTLDFLAGS set anywhere.

> >  # Allow old libelf to be used:
> >  elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
> > -CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> > +OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> > +
> > +# Always want host compilation.
> > +HOST_OVERRIDES := CC="$(HOSTCC)" EXTRA_CFLAGS="$(OBJTOOL_CFLAGS)" \
> > +               LD="$(HOSTLD)" AR="$(HOSTAR)"
> > +BUILD_HOST_OVERRIDES := CC="$(HOSTCC)" CFLAGS="$(OBJTOOL_CFLAGS)" \
> > +                     LD="$(HOSTLD)" LDFLAGS="$(OBJTOOL_LDFLAGS)" \
> > +                     AR="$(HOSTAR)"
>
> Maybe it depends on your perspective, but I'm thinking that some of
> these aren't really overrides, but rather normal expected flags.  And
> the distinction between these two variables is muddy: it's not only
> Build vs non-Build, but also objtool vs libsubcmd.
>
> How about just
>
>   HOST_OVERRIDES := CC="$(HOSTCC) "LD="$(HOSTLD)" AR="$(HOSTAR)"
>
> And then specifying the {EXTRA_}CFLAGS and LDFLAGS below where needed.

Done.

> >  AWK = awk
> >  MKDIR = mkdir
> > @@ -65,10 +68,11 @@ include $(srctree)/tools/build/Makefile.include
> >
> >  $(OBJTOOL_IN): fixdep FORCE
> >       $(Q)$(CONFIG_SHELL) ./sync-check.sh
> > -     $(Q)$(MAKE) $(build)=objtool
> > +     $(Q)$(MAKE) $(build)=objtool $(BUILD_HOST_OVERRIDES)
> > +
> >
> >  $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
> > -     $(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
> > +     $(QUIET_LINK)$(HOSTCC) $(OBJTOOL_IN) $(KBUILD_HOSTLDFLAGS) $(OBJTOOL_LDFLAGS) -o $@
>
> Does KBUILD_HOSTLDFLAGS even work here?

Removed, albeit now to be part of OBJTOOL_LDFLAGS as your earlier
comment requested.

Thanks,
Ian

> --
> Josh
