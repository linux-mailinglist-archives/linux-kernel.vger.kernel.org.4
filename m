Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97BA656E9D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 21:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiL0UYW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Dec 2022 15:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiL0UYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 15:24:21 -0500
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7F3F15;
        Tue, 27 Dec 2022 12:24:20 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id j28so7239125ila.9;
        Tue, 27 Dec 2022 12:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYIWCf/X/Ha6fzlOLJLrAZYz4Dy2m9LBU9hsQfnPLuM=;
        b=TIskR3Jjj8/kBB0knoI1q5fq9KAbhwDP1tnbdfq+QomShd4+FEip6YP0R4rCEpSRh7
         KwqPn4M8/wOL9XfPgLt+GVQOwBahuBWmTx93EW9jxI9Z0ZOYFiUmRsM+DxlNsMOblCn5
         X2pIJ6BHxZ9l51OwYh23jam45fUKGmd+jQ1xv9gL33toIQW4JkuvybSXT5uodvrvHNRw
         Ep8hTAWylgQsTYfvzE5EnsLeBrrm/H2z7cgeI7Vl6OmrLlPPMHrxx5c/Lzm2eE/XekxP
         fltya2cISo+hcxbigFua7eVBV1udbTr/4O76ce9u8W2Z4oxmlcN8izBJrpfZRloQn2kA
         6xeQ==
X-Gm-Message-State: AFqh2krm+vzAdLhHErFj1XqhjBbfiarZZxB32kp04s+AlwP3V75K/wyq
        w4rf1/XxYLaAa7CL5qhLXnE72eXEHyVKqur5DX8=
X-Google-Smtp-Source: AMrXdXu5ah4PmdOmI0U7aT/d7+iZsd0E6schiX4tuXFhPmzimqU3nPQeedgtbyQPTCyYmiBMReoJQX4xE3P1KeQkcJo=
X-Received: by 2002:a92:d811:0:b0:303:7c99:eb78 with SMTP id
 y17-20020a92d811000000b003037c99eb78mr1832673ilm.88.1672172659361; Tue, 27
 Dec 2022 12:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20221226193517.qynxfceqgzvr4qwu@tarta.nabijaczleweli.xyz>
In-Reply-To: <20221226193517.qynxfceqgzvr4qwu@tarta.nabijaczleweli.xyz>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 27 Dec 2022 12:24:07 -0800
Message-ID: <CAM9d7ciuh1H2Mfx5ToYGT1fOm8E3jrQhkzg304JKDd7BhT=h5g@mail.gmail.com>
Subject: Re: [PATCH] perf tui: don't ignore job control
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        yaowenbin <yaowenbin1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hello,

On Mon, Dec 26, 2022 at 11:35 AM Ahelenia Ziemiańska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> In its infinite wisdom, by default, SLang sets susp undef,
> and this can only be un-done by calling SLtty_set_suspend_state(true).
> After every SLang_init_tty().
>
> Additionally, no provisions are made for maintaining the teletype
> attributes across suspend/continue (outside of curses emulation mode(?!),
> which provides full support, naturally), so we need to save and restore
> the flags ourselves. We need to also re-draw the screen, and raising
> SIGWINCH, shockingly, Just Works.
>
> The correct solution would be to Not Use SLang, but as a stop-gap,
> this makes TUI perf report usable.
>
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Cool, this makes Ctrl-Z and then 'fg' work.  But it comes with the
color for a selected line depending on the timing.  Maybe we can
reset the color before going to the background?

Thanks,
Namhyung


> ---
>  tools/perf/ui/browsers/annotate.c |  1 +
>  tools/perf/ui/browsers/hists.c    |  2 ++
>  tools/perf/ui/browsers/scripts.c  |  1 +
>  tools/perf/ui/tui/setup.c         | 19 +++++++++++++++++++
>  4 files changed, 23 insertions(+)
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
> index a3b8c397c24d..4211a161458a 100644
> --- a/tools/perf/ui/tui/setup.c
> +++ b/tools/perf/ui/tui/setup.c
> @@ -2,6 +2,7 @@
>  #include <signal.h>
>  #include <stdbool.h>
>  #include <stdlib.h>
> +#include <termios.h>
>  #include <unistd.h>
>  #include <linux/kernel.h>
>  #ifdef HAVE_BACKTRACE_SUPPORT
> @@ -122,6 +123,21 @@ static void ui__signal(int sig)
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
> @@ -136,6 +152,7 @@ int ui__init(void)
>         err = SLang_init_tty(-1, 0, 0);
>         if (err < 0)
>                 goto out;
> +       SLtty_set_suspend_state(true);
>
>         err = SLkp_init();
>         if (err < 0) {
> @@ -150,6 +167,8 @@ int ui__init(void)
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
