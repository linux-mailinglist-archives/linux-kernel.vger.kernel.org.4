Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D067C703693
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbjEORLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243750AbjEORLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:11:13 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D55D2F6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:09:20 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f396606ab0so1533061cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684170559; x=1686762559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0PeA7ujYYgxSXoyC9eiQQBWl9vgJ+rCpIFecGKmOls=;
        b=lFswleopbZAF56AgWeJ/aIsT8ffuFtsjaVsMd05nRtHSYuBXDKSWokFVrCw9fo1tiG
         lGbnYNLFOdP/aNFbooqX7bkECDXejVfpB5qWhW3nHjz22Sag3fXeQFwcxYHq/naJ2fvS
         RSgp6UZm9bLkA8Wo7yA+drqPTSyJmhQNuqk+GV9HYlGvlv5jJUTtRXyRb5OvSzcBvc8p
         eyOFU/hRjcn94OfWYEyUw1qxlgieyHAMP5CgorgqBd+GDEQ0HRWmS954yXpot70hPmkT
         GXPdcRNdrQ8tWHpkmUfxfgnUuVlJADD9m9kHV0q9ICkpOMWGBMiLKhRFWnhbzaHT9Mwe
         c1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684170559; x=1686762559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0PeA7ujYYgxSXoyC9eiQQBWl9vgJ+rCpIFecGKmOls=;
        b=Vlu9ISnrYVSCIv4nCAwzGiw/JQ5sftZBbT1YARFH5f0XohgKvkE/w4bmSNfZRabAhN
         arytpstLPDJ3Q4lShJfWCwDiPk048oeuzK0sa607kpawUmmWXZWpvy9Nh6MqLLsD1gdC
         uYkiDRmRx1oFhnNV0dz4Dls38dKp5+vCL2kxX9TAmufJXjFNw+NZDyWJEfxg2Pr9cQxC
         G/9aGHvcXhiQVRe21hibyWKMNZo584mWnA31t9lduxSQY6rZZCCM/oW3btgFmVQTo/C8
         sJ5YYrPm4mPsTRpyzUlDlFuP5334wX/Vfqcwec9u6NcZcG4WakAEDLwEXUZePk3gYZbh
         GlRg==
X-Gm-Message-State: AC+VfDzwcTnyDROk/27X/R+0Kh1PryuYtkAfyq3RuE9OWnQ4IfEq82wz
        rAr3xp9+gIbrwHmkpNbS8LGrSD2VeqB9d1cwITxk5Q==
X-Google-Smtp-Source: ACHHUZ666klK+U41GWeIY8V+KewLdgQxSQLSVByptztatJnvlDI5JGSC4AZ4GyTlvU5l08BEcyv7hPkBcHKDKa8P8a0=
X-Received: by 2002:a05:622a:10:b0:3e8:684b:195d with SMTP id
 x16-20020a05622a001000b003e8684b195dmr89692qtw.10.1684170559350; Mon, 15 May
 2023 10:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230511062725.514752-1-namhyung@kernel.org> <20230511062725.514752-3-namhyung@kernel.org>
In-Reply-To: <20230511062725.514752-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 15 May 2023 10:09:08 -0700
Message-ID: <CAP-5=fV+LFcMRwHPZUrq=MpOZVp8Q+4vEVKGTQg3rLREfJsg1w@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf annotate browser: Add '<' and '>' keys for navigation
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
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

On Wed, May 10, 2023 at 11:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The hists__find_annotations() allow to move to next or previous symbols
> for annotation using the arrow keys.  But TUI annotate_browser__run()
> uses the RIGHT key as ENTER to handle jump/call instructions.  That
> makes the navigation to the next function impossible.
>
> I'd like to change it back to move the next symbol but I'm afraid if
> some users get confused.  So I added a new pair of keys to handle that.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-annotate.c     | 4 +++-
>  tools/perf/ui/browsers/annotate.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.=
c
> index 63cdf6ea6f6d..425a7e2fd6fb 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -342,7 +342,7 @@ static void hists__find_annotations(struct hists *his=
ts,
>                 notes =3D symbol__annotation(he->ms.sym);
>                 if (notes->src =3D=3D NULL) {
>  find_next:
> -                       if (key =3D=3D K_LEFT)
> +                       if (key =3D=3D K_LEFT || key =3D=3D '<')
>                                 nd =3D rb_prev(nd);
>                         else
>                                 nd =3D rb_next(nd);
> @@ -378,9 +378,11 @@ static void hists__find_annotations(struct hists *hi=
sts,
>                                         return;
>                                 /* fall through */
>                         case K_RIGHT:
> +                       case '>':
>                                 next =3D rb_next(nd);
>                                 break;
>                         case K_LEFT:
> +                       case '<':
>                                 next =3D rb_prev(nd);
>                                 break;
>                         default:
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index 12c3ce530e42..70bad42b807b 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -781,9 +781,9 @@ static int annotate_browser__run(struct annotate_brow=
ser *browser,
>                         ui_browser__help_window(&browser->b,
>                 "UP/DOWN/PGUP\n"
>                 "PGDN/SPACE    Navigate\n"
> +               "</>           Move to prev/next symbol\n"
>                 "q/ESC/CTRL+C  Exit\n\n"
>                 "ENTER         Go to target\n"
> -               "ESC           Exit\n"
>                 "H             Go to hottest instruction\n"
>                 "TAB/shift+TAB Cycle thru hottest instructions\n"
>                 "j             Toggle showing jump to target arrows\n"
> @@ -913,6 +913,8 @@ static int annotate_browser__run(struct annotate_brow=
ser *browser,
>                         annotation__toggle_full_addr(notes, ms);
>                         continue;
>                 case K_LEFT:
> +               case '<':
> +               case '>':
>                 case K_ESC:
>                 case 'q':
>                 case CTRL('c'):
> --
> 2.40.1.521.gf1e218fcd8-goog
>
