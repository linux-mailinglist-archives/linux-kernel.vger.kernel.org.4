Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AAE66851A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbjALVLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjALVLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:11:22 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C88F6ECAC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:55:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e3so10091837wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1l2nJvkOMhf/Q6N3HmLSKyOtgxFfcSynbTgFlzQDiFk=;
        b=i7zPfI1s6CYytk6lWGPrP8CLKhu5KppwB4Hin/v8r4IXv34PypNj92GKWH1EOSRi4p
         4oraSwQAEm4b+M15QRiIqoEKTna1YolT16s/BMD4AsIPQqG9wVIuNSH58/r+iZQoBIVG
         6mwkTRKJx1TPRFlQyVl+gy3wuKXpz5mLkbJlqaWftImBj3KWxYeqE5qntpqRNAsz9kI3
         qTpaYV/QRsYLkei4Z8FK21P2zzwwTOLEkpQPUQxQXo8hRg1DLsnyNxa5jXpza5fTj+Hj
         o/U9rW5lGJ5Zq7ca7PsohBTZwsWbM09H1ERgOjdN9auI7jxsuHpim3TE/JBvk6aMu1eD
         ID4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1l2nJvkOMhf/Q6N3HmLSKyOtgxFfcSynbTgFlzQDiFk=;
        b=mqMxNoCYtqmDxyzJ0jXpXLdZCHpUVs1IIQ/d1rqhxCg/yya+F7ndmBJxT+KbBzvUjH
         vxfoHqC2d83DXWkkTkGOztaSuUash6H6uTAdVlTuOLa+IX4gjBCCIANqTueBjGS9TR7h
         1l4DTgMzFIOZJzBK7ybRM90AFC+Ka8+XuD+sSsfz3hzLLiActljtcPZUsvzsLow2HR3+
         d0e2aV8BrVx2lri9CSS1voPJIOJpkdBk29Sq/N9mx/nNMnbKm8RFgx1wwJN7x8rdZhq1
         ZQVnxXKqu+9YsrfX7D6W5O40swBZINmqAjWOUM62gSACeN7hxTcgBv8UdqKvHR/MH9nV
         ZLKA==
X-Gm-Message-State: AFqh2kpgvBeuP2KCt33J6ETJ5ZtQaslzu5FtCyqjjRUAfTtOkaVsCrzc
        AautQssJhKwjY76NpLX9MteL4ewSEcy4geeoDTqaHQ==
X-Google-Smtp-Source: AMrXdXsYwjPZS4ox+2H3rYj/QQgBSwzO3H4oIQRT2gZTOuh5fIi6BNpysWWO7nt1I1ptsE2hVc85zlMZnIjIGDNHEQY=
X-Received: by 2002:a05:6000:12cb:b0:28c:459a:d5d with SMTP id
 l11-20020a05600012cb00b0028c459a0d5dmr1888523wrx.654.1673556897672; Thu, 12
 Jan 2023 12:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20230105090155.357604-1-irogers@google.com> <20230105090155.357604-2-irogers@google.com>
 <Y8BsqN/HfOf+vKZP@fjasle.eu>
In-Reply-To: <Y8BsqN/HfOf+vKZP@fjasle.eu>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 12 Jan 2023 12:54:45 -0800
Message-ID: <CAP-5=fVEcuWbfO2NoTPanUmXXF6bejnN1s8Lm704P8TvKc1yKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] objtool: Install libsubcmd in build
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
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

On Thu, Jan 12, 2023 at 12:32 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Thu, Jan 05, 2023 at 01:01:53AM -0800 Ian Rogers wrote:
> > Including from tools/lib can create inadvertent dependencies. Install
> > libsubcmd in the objtool build and then include the headers from
> > there.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  tools/objtool/Build    |  2 --
> >  tools/objtool/Makefile | 33 +++++++++++++++++++++++++--------
> >  2 files changed, 25 insertions(+), 10 deletions(-)
> >
> [...]
> > diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> > index a3a9cc24e0e3..fd9b3e3113c6 100644
> > --- a/tools/objtool/Makefile
> > +++ b/tools/objtool/Makefile
> > @@ -12,9 +12,15 @@ srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> >  srctree := $(patsubst %/,%,$(dir $(srctree)))
> >  endif
> >
> > -SUBCMD_SRCDIR                = $(srctree)/tools/lib/subcmd/
> > -LIBSUBCMD_OUTPUT     = $(or $(OUTPUT),$(CURDIR)/)
> > -LIBSUBCMD            = $(LIBSUBCMD_OUTPUT)libsubcmd.a
> > +LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
> > +ifneq ($(OUTPUT),)
> > +  LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
> > +else
> > +  LIBSUBCMD_OUTPUT = $(CURDIR)/libsubcmd
> > +endif
> > +LIBSUBCMD_DESTDIR = $(LIBSUBCMD_OUTPUT)
>
> Hi Ian,
>
> Is there a reason for distinguishing between $(LIBSUBCMD_DESTDIR) and
> $(LIBSUBCMD_OUTPUT)?

I believe the naming aligns with their use when passed to the
corresponding sub-make variable, so "DESTDIR=$(LIBSUBCMD_DESTDIR)". It
is possible to do other this, a slightly different convention is in
some BPF related code:
https://lore.kernel.org/lkml/20230112004024.1934601-1-irogers@google.com/

Thanks,
Ian

> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
