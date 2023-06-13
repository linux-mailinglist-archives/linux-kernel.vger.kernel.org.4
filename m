Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC4872ECE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjFMU0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFMU0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:26:42 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FBC199E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:26:39 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f9b7de94e7so68631cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686687999; x=1689279999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MXw7AgKsvFMy/rEG8zyX+PB5rmlGQ9LjQTd+dl4O+8=;
        b=lUltOv572sTPL14yhqAPP//gpwwea0YBue5CxvuCnK0TEd91pumFfC59ni5dCSZlj0
         bGeoWu9B9eAdfl/ccIwNKuUuN17NtlShCMPv7KQMQKlMpw2/cF0CaEfZRO9/ZwWFd3Xt
         O39NEw126P0E3KhEaXwZQLT9Ru/7hBJ8FvjN3gNIGEy0IFm6rIB1ujF97g5sk9I567Lz
         nnLln+XSy5/9OG4TexiZFPgx8nQqSJhJK3yaEjpbCP/qSGPqZTft01cA3q/jgUgWwOje
         5QH6sr1LL1116EMSv4t4rGJ47QepHXF0JpC1sTHe16LzaFdylW93jjr/5KrXT5eXoSRQ
         ViwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687999; x=1689279999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MXw7AgKsvFMy/rEG8zyX+PB5rmlGQ9LjQTd+dl4O+8=;
        b=XKspLFaXjLl2NoIkzRabEJbWZKOs8jOVQhjMqdJK4WFnQOJQfguy/EbdZAteTJTBbU
         qSd6bT90y+P9gZUBdIInrY1/fsvvXbVQsfXU52+RXx0/AsmQxqPGnoSkDAG8FhmN1UZT
         KKuU6gN0hgG4DXwizEYWQehpsa6g3OzJbmeWs36ZRY4MRWtQKVoqSvr1pJIF+DMzGkON
         CJlO7hjrPN5xnPwqezeAn94cmdyjgZJdiQj1nVUXhCKLXuyI19/yPXosom+MLgF9p1n7
         f3x52Cya6KVr3W9ItFKehG925kXntUxzdJKkTno8yur1oIJgY/Jfux/i792puFaEd1G+
         YcXA==
X-Gm-Message-State: AC+VfDxIoWaVwm2pZh09y4QkRzDgPtk3+VPmiPNxTZnov1kqzGJ2BJG+
        gczOsNzXR81dPHgXvOMWENx7LTohLAa/mVZNZ9IQyQ==
X-Google-Smtp-Source: ACHHUZ4uQZuhSTOe4dTOs18MKUj5/O5R7ff8xb8zaTfOd0WzF7q+UubK+8ZgqTP3Yj/W6mlieKDKTPOispTcpb38SDE=
X-Received: by 2002:ac8:7e8b:0:b0:3f9:a986:f3a4 with SMTP id
 w11-20020ac87e8b000000b003f9a986f3a4mr47357qtj.25.1686687998646; Tue, 13 Jun
 2023 13:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230613182629.1500317-1-irogers@google.com> <ZIjGd79uWxgRF0og@kernel.org>
In-Reply-To: <ZIjGd79uWxgRF0og@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 13:26:27 -0700
Message-ID: <CAP-5=fVfHGm3hcJ=AMAGnhAA=bYSH47a77yw5-9N49RuuSw37A@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Avoid string for PE_BP_COLON, PE_BP_SLASH
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jun 13, 2023 at 11:26:29AM -0700, Ian Rogers escreveu:
> > There's no need to read the string ':' or '/' for PE_BP_COLON or
> > PE_BP_SLASH and doing so causes parse-events.y to leak memory.
> >
> > The original patch has a committer note about not using these tokens
> > presumably as yacc spotted they were a memory leak because no
> > %destructor could be run. Remove the unused token workaround as there
> > is now no value associated with these tokens.
>
> It looked like the compiler was the one warning (-Wother) about args not
> being used, didn't made it clear those were possible memory leaks :-\
>
>  util/parse-events.y:508.24-34: warning: unused value: $3 [-Wother]
>    508 | PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIF=
IER_BP opt_event_config
>
> Anyway, I'll apply and test your patch.
>
> - Arnaldo

Thanks, I couldn't repro the problem but I know that's because I don't
have your full container set up. Given my ignorance please help me fix
the commit message, or I can update it in a v2 set, or possibly we'll
need to bring back the unused logic.

Ian

>
> > Fixes: f0617f526cb0 ("perf parse: Allow config terms with breakpoints")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.h | 4 ----
> >  tools/perf/util/parse-events.l | 4 ++--
> >  tools/perf/util/parse-events.y | 9 ---------
> >  3 files changed, 2 insertions(+), 15 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-eve=
nts.h
> > index 5fdc1f33f57e..b0eb95f93e9c 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -228,10 +228,6 @@ void parse_events_error__handle(struct parse_event=
s_error *err, int idx,
> >  void parse_events_error__print(struct parse_events_error *err,
> >                              const char *event);
> >
> > -static inline void parse_events_unused_value(const void *x __maybe_unu=
sed)
> > -{
> > -}
> > -
> >  #ifdef HAVE_LIBELF_SUPPORT
> >  /*
> >   * If the probe point starts with '%',
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-eve=
nts.l
> > index 7629af3d5c7c..99335ec586ae 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -315,13 +315,13 @@ r0x{num_raw_hex}        { return str(yyscanner, P=
E_RAW); }
> >        * are the same, so trailing context can be used disambiguate the=
 two
> >        * cases.
> >        */
> > -":"/{modifier_bp}    { return str(yyscanner, PE_BP_COLON); }
> > +":"/{modifier_bp}    { return PE_BP_COLON; }
> >       /*
> >        * The slash before memory length can get mixed up with the slash=
 before
> >        * config terms. Fortunately config terms do not start with a num=
eric
> >        * digit, so trailing context can be used disambiguate the two ca=
ses.
> >        */
> > -"/"/{digit}          { return str(yyscanner, PE_BP_SLASH); }
> > +"/"/{digit}          { return PE_BP_SLASH; }
> >  "/"/{non_digit}              { BEGIN(config); return '/'; }
> >  {num_dec}            { return value(yyscanner, 10); }
> >  {num_hex}            { return value(yyscanner, 16); }
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-eve=
nts.y
> > index 0c3d086cc22a..9f28d4b5502f 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -80,8 +80,6 @@ static void free_list_evsel(struct list_head* list_ev=
sel)
> >  %type <str> PE_LEGACY_CACHE
> >  %type <str> PE_MODIFIER_EVENT
> >  %type <str> PE_MODIFIER_BP
> > -%type <str> PE_BP_COLON
> > -%type <str> PE_BP_SLASH
> >  %type <str> PE_EVENT_NAME
> >  %type <str> PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
> >  %type <str> PE_DRV_CFG_TERM
> > @@ -510,9 +508,6 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_C=
OLON PE_MODIFIER_BP opt_event
> >       struct list_head *list;
> >       int err;
> >
> > -     parse_events_unused_value(&$3);
> > -     parse_events_unused_value(&$5);
> > -
> >       list =3D alloc_list();
> >       ABORT_ON(!list);
> >       err =3D parse_events_add_breakpoint(_parse_state, list,
> > @@ -531,8 +526,6 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_eve=
nt_config
> >       struct list_head *list;
> >       int err;
> >
> > -     parse_events_unused_value(&$3);
> > -
> >       list =3D alloc_list();
> >       ABORT_ON(!list);
> >       err =3D parse_events_add_breakpoint(_parse_state, list,
> > @@ -550,8 +543,6 @@ PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP o=
pt_event_config
> >       struct list_head *list;
> >       int err;
> >
> > -     parse_events_unused_value(&$3);
> > -
> >       list =3D alloc_list();
> >       ABORT_ON(!list);
> >       err =3D parse_events_add_breakpoint(_parse_state, list,
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
>
> --
>
> - Arnaldo
