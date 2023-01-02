Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AC265B44F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbjABPgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjABPgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:36:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE3A5FC6;
        Mon,  2 Jan 2023 07:36:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B38B6B80D3E;
        Mon,  2 Jan 2023 15:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A2FC433EF;
        Mon,  2 Jan 2023 15:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672673760;
        bh=4/As87h7nXDCo+gH2bpoZk9UnCj5V3In3mYM7gziX7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJ3Qj4fQyUL/IZhrvgSGrFsBNhN24gp0Yh5NEiEZytLS+VFdi1RCpJxB7Pey14NsN
         6xaeW9w76SCPTwttFtwnqS7udaxncLrAi3RU/tL4RaexrM40axYzBZrk0BHrI3xtWv
         nhUoYM2LL2mvJTFgPu7460wc0Mu+PGOPi3U6uaYLOrPY+4qppI5EBI+iMIPfOV/SW8
         G7hkpuJo1OtSKKm53z5BiSXueI3/oco0bgeY5SkC9LtVR9/eI1hv5thT3ZBDF390p+
         l+RXdWm6gqGbC128MubfyCH5iZyZoBne7aloV5ntUhImB/QCw0mz2Mx9ghl8COV9Mp
         v4eeC/XmHEHEA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1864A40468; Mon,  2 Jan 2023 12:35:58 -0300 (-03)
Date:   Mon, 2 Jan 2023 12:35:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        yaowenbin <yaowenbin1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf tui: don't ignore job control
Message-ID: <Y7L53knoZpMIO3z/@kernel.org>
References: <CAM9d7ciuh1H2Mfx5ToYGT1fOm8E3jrQhkzg304JKDd7BhT=h5g@mail.gmail.com>
 <0354dcae23a8713f75f4fed609e0caec3c6e3cd5.1672174189.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0354dcae23a8713f75f4fed609e0caec3c6e3cd5.1672174189.git.nabijaczleweli@nabijaczleweli.xyz>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 27, 2022 at 09:57:40PM +0100, Ahelenia Ziemiańska escreveu:
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
> ---
> Yeah, somehow I didn't hit that in my tests, but it was relatively easy
> to trigger when I tried. A full partial write retry loop is an overkill
> here, I think, and few other places in perf actually try to resubmit
> partial writes, so.

We've been with this problem since forever, so I'll apply it to
perf/core, i.e. for the next merge window, ok?

- Arnaldo
 
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
>  	/* reset abort key so that it can get Ctrl-C as a key */
>  	SLang_reset_tty();
>  	SLang_init_tty(0, 0, 0);
> +	SLtty_set_suspend_state(true);
>  
>  	return map_symbol__tui_annotate(&he->ms, evsel, hbt, opts);
>  }
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index b72ee6822222..2479e6d42e7c 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3010,6 +3010,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
>  	/* reset abort key so that it can get Ctrl-C as a key */
>  	SLang_reset_tty();
>  	SLang_init_tty(0, 0, 0);
> +	SLtty_set_suspend_state(true);
>  
>  	if (min_pcnt)
>  		browser->min_pcnt = min_pcnt;
> @@ -3682,6 +3683,7 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
>  	/* reset abort key so that it can get Ctrl-C as a key */
>  	SLang_reset_tty();
>  	SLang_init_tty(0, 0, 0);
> +	SLtty_set_suspend_state(true);
>  
>  	memset(&action, 0, sizeof(action));
>  
> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> index 47d2c7a8cbe1..50d45054ed6c 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
> @@ -166,6 +166,7 @@ void run_script(char *cmd)
>  	printf("\033[c\033[H\033[J");
>  	fflush(stdout);
>  	SLang_init_tty(0, 0, 0);
> +	SLtty_set_suspend_state(true);
>  	SLsmg_refresh();
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
>  	exit(0);
>  }
>  
> +static void ui__sigcont(int sig)
> +{
> +	static struct termios tty;
> +
> +	if (sig == SIGTSTP) {
> +		while (tcgetattr(SLang_TT_Read_FD, &tty) == -1 && errno == EINTR)
> +			;
> +		while (write(SLang_TT_Read_FD, PERF_COLOR_RESET, sizeof(PERF_COLOR_RESET) - 1) == -1 && errno == EINTR)
> +			;
> +		raise(SIGSTOP);
> +	} else {
> +		while (tcsetattr(SLang_TT_Read_FD, TCSADRAIN, &tty) == -1 && errno == EINTR)
> +			;
> +		raise(SIGWINCH);
> +	}
> +}
> +
>  int ui__init(void)
>  {
>  	int err;
> @@ -136,6 +155,7 @@ int ui__init(void)
>  	err = SLang_init_tty(-1, 0, 0);
>  	if (err < 0)
>  		goto out;
> +	SLtty_set_suspend_state(true);
>  
>  	err = SLkp_init();
>  	if (err < 0) {
> @@ -150,6 +170,8 @@ int ui__init(void)
>  	signal(SIGINT, ui__signal);
>  	signal(SIGQUIT, ui__signal);
>  	signal(SIGTERM, ui__signal);
> +	signal(SIGTSTP, ui__sigcont);
> +	signal(SIGCONT, ui__sigcont);
>  
>  	perf_error__register(&perf_tui_eops);
>  
> -- 
> 2.30.2
> 



-- 

- Arnaldo
