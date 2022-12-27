Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E37656FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiL0VV5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Dec 2022 16:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiL0VVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:21:53 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BCFCEE;
        Tue, 27 Dec 2022 13:21:53 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id z144so7463965iof.3;
        Tue, 27 Dec 2022 13:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IOlYy/Vocy0JZQbLzUBtMxAfR7MFOMbrfriVQcYrhU=;
        b=wCy9OejD7/KXS0Vy64FsQx6Oz6Rdwhniv3/CkV+TMhdgsz8z0tY5Ebk4fjHy1yi7IC
         fFJlx+Y9aSqQaHaq1boEIn54kvAY5McLYQiIX9KhvBmMyhJawMsRiI1w2C/V2AXDmdy/
         KpFUVPTc6mdq1SYl16n4UVLXz1nBD9DPeZjTqEy/YfFAQO57nbE4RNG02jZVAO3834LO
         0lJakp1q/CuAah19fTmCJ7Sp4CaUvC9dUtHCqzxWOtEs61Ys6iwUuEtUbDAxSfz733S7
         3SVuZyTPNA5Xpy1WNLGmgMWAPAjrbVpkSGSWI5DxpvnjM5T4OV6Tub+WSsUHnQ6/gdQF
         Zc5g==
X-Gm-Message-State: AFqh2krZXC+j4Ut/kwFxPfdvDCoF3n4z5DAhHsQ8GHQiP+XStVCQ0qRT
        estzLVPXhoSu3zq6YUi+3Pj3LJm3AkKcxu1yT/Q5rydjEI8=
X-Google-Smtp-Source: AMrXdXs9p5FP7edkZzTihAMnTd3KX9qI2wAD+xhTAgcpjCzXCjoOnToomJ4PuYxyn8AaCtpD0G4S+Xr8Ub4TsGr8ex8=
X-Received: by 2002:a02:6005:0:b0:38a:3421:f2cb with SMTP id
 i5-20020a026005000000b0038a3421f2cbmr1577188jac.308.1672176112197; Tue, 27
 Dec 2022 13:21:52 -0800 (PST)
MIME-Version: 1.0
References: <CAM9d7ciuh1H2Mfx5ToYGT1fOm8E3jrQhkzg304JKDd7BhT=h5g@mail.gmail.com>
 <0354dcae23a8713f75f4fed609e0caec3c6e3cd5.1672174189.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <0354dcae23a8713f75f4fed609e0caec3c6e3cd5.1672174189.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 27 Dec 2022 13:21:40 -0800
Message-ID: <CAM9d7ciUsjNGQcM4fMMGomVheV9vNCiiH87p0=a-goCYmSqFOQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf tui: don't ignore job control
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 12:57 PM Ahelenia Ziemiańska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> In its infinite wisdom, by default, SLang sets susp undef,
> and this can only be un-done by calling SLtty_set_suspend_state(true).
> After every SLang_init_tty().
>
> Additionally, no provisions are made for maintaining the teletype
> attributes across suspend/continue (outside of curses emulation mode(?!),
> which provides full support, naturally), so we need to save and restore
> the flags ourselves, as well as reset the text colours when going under.
> We need to also re-draw the screen, and raising SIGWINCH, shockingly,
> Just Works.
>
> The correct solution would be to Not Use SLang, but as a stop-gap,
> this makes TUI perf report usable.
>
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
> Yeah, somehow I didn't hit that in my tests, but it was relatively easy
> to trigger when I tried. A full partial write retry loop is an overkill
> here, I think, and few other places in perf actually try to resubmit
> partial writes, so.
>
>  tools/perf/ui/browsers/annotate.c |  1 +
>  tools/perf/ui/browsers/hists.c    |  2 ++
>  tools/perf/ui/browsers/scripts.c  |  1 +
>  tools/perf/ui/tui/setup.c         | 22 ++++++++++++++++++++++
>  4 files changed, 26 insertions(+)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index c03fa76c02ff..6a4ffbf66c7f 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -942,6 +942,7 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>         /* reset abort key so that it can get Ctrl-C as a key */
>         SLang_reset_tty();
>         SLang_init_tty(0, 0, 0);
> +       SLtty_set_suspend_state(true);
>
>         return map_symbol__tui_annotate(&he->ms, evsel, hbt, opts);
>  }
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index b72ee6822222..2479e6d42e7c 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3010,6 +3010,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
>         /* reset abort key so that it can get Ctrl-C as a key */
>         SLang_reset_tty();
>         SLang_init_tty(0, 0, 0);
> +       SLtty_set_suspend_state(true);
>
>         if (min_pcnt)
>                 browser->min_pcnt = min_pcnt;
> @@ -3682,6 +3683,7 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
>         /* reset abort key so that it can get Ctrl-C as a key */
>         SLang_reset_tty();
>         SLang_init_tty(0, 0, 0);
> +       SLtty_set_suspend_state(true);
>
>         memset(&action, 0, sizeof(action));
>
> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> index 47d2c7a8cbe1..50d45054ed6c 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
> @@ -166,6 +166,7 @@ void run_script(char *cmd)
>         printf("\033[c\033[H\033[J");
>         fflush(stdout);
>         SLang_init_tty(0, 0, 0);
> +       SLtty_set_suspend_state(true);
>         SLsmg_refresh();
>  }
>
> diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
> index a3b8c397c24d..09524ba04975 100644
> --- a/tools/perf/ui/tui/setup.c
> +++ b/tools/perf/ui/tui/setup.c
> @@ -2,12 +2,14 @@
>  #include <signal.h>
>  #include <stdbool.h>
>  #include <stdlib.h>
> +#include <termios.h>
>  #include <unistd.h>
>  #include <linux/kernel.h>
>  #ifdef HAVE_BACKTRACE_SUPPORT
>  #include <execinfo.h>
>  #endif
>
> +#include "../../util/color.h"
>  #include "../../util/debug.h"
>  #include "../../perf.h"
>  #include "../browser.h"
> @@ -122,6 +124,23 @@ static void ui__signal(int sig)
>         exit(0);
>  }
>
> +static void ui__sigcont(int sig)
> +{
> +       static struct termios tty;
> +
> +       if (sig == SIGTSTP) {
> +               while (tcgetattr(SLang_TT_Read_FD, &tty) == -1 && errno == EINTR)
> +                       ;
> +               while (write(SLang_TT_Read_FD, PERF_COLOR_RESET, sizeof(PERF_COLOR_RESET) - 1) == -1 && errno == EINTR)
> +                       ;
> +               raise(SIGSTOP);
> +       } else {
> +               while (tcsetattr(SLang_TT_Read_FD, TCSADRAIN, &tty) == -1 && errno == EINTR)
> +                       ;
> +               raise(SIGWINCH);
> +       }
> +}
> +
>  int ui__init(void)
>  {
>         int err;
> @@ -136,6 +155,7 @@ int ui__init(void)
>         err = SLang_init_tty(-1, 0, 0);
>         if (err < 0)
>                 goto out;
> +       SLtty_set_suspend_state(true);
>
>         err = SLkp_init();
>         if (err < 0) {
> @@ -150,6 +170,8 @@ int ui__init(void)
>         signal(SIGINT, ui__signal);
>         signal(SIGQUIT, ui__signal);
>         signal(SIGTERM, ui__signal);
> +       signal(SIGTSTP, ui__sigcont);
> +       signal(SIGCONT, ui__sigcont);
>
>         perf_error__register(&perf_tui_eops);
>
> --
> 2.30.2
>
