Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C436F2214
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347269AbjD2BaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjD2BaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:30:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A00E7A;
        Fri, 28 Apr 2023 18:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A96F61592;
        Sat, 29 Apr 2023 01:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C46C4339B;
        Sat, 29 Apr 2023 01:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682731804;
        bh=H1cUVZloMIMgPmyVATWNTj1bXJbmgcmWRMx4csgzg9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VruZ9vwomrjap0GaYFrqDzIJX9CjBi7wGIWNr+9ZNlTauB7K3vwwL698PvA2nQvVg
         XRt5btcIG4aWmkRxtGYqHJuzO/xuXZTlWxCkq0SXWIcd59qWS254KsYQmP2LTx9d3R
         1J05jNZIpioTdJr7eH4rULGzKVOR1ph5PBfKfa6SqoGLYbbYX3aSm6CngFqT38ZvzF
         oW65Q49XxT+GiZ3cI7FdXGjtxkiLJ31OCaf5jkf4o1R7Fq0mEY+OgYAihE+r9/OdvB
         Gx1gB9Nd47GiHC8jspgk1b0BTj6HI4wfZZjxIgN3+isunZuyfX6LOcqwzoCfGgI/tx
         jbw9Y+NoUUswA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BA120403B5; Fri, 28 Apr 2023 22:30:01 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:30:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf list: Fix memory leaks in
 print_tracepoint_events()
Message-ID: <ZExzGWIm98lfPUKI@kernel.org>
References: <20230427230502.1526136-1-namhyung@kernel.org>
 <CAP-5=fUYfVDfi_+JGqU=o_TcPRNVboMwZewuhU6q+K3md6nUkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUYfVDfi_+JGqU=o_TcPRNVboMwZewuhU6q+K3md6nUkA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 27, 2023 at 05:27:50PM -0700, Ian Rogers escreveu:
> On Thu, Apr 27, 2023 at 4:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It should free entries (not only the array) filled by scandirat()
> > after use.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
 

Thanks, applied the series.

- Arnaldo

> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/print-events.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> > index d416c5484cd5..0a97912fd894 100644
> > --- a/tools/perf/util/print-events.c
> > +++ b/tools/perf/util/print-events.c
> > @@ -83,11 +83,11 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
> >                 if (sys_dirent->d_type != DT_DIR ||
> >                     !strcmp(sys_dirent->d_name, ".") ||
> >                     !strcmp(sys_dirent->d_name, ".."))
> > -                       continue;
> > +                       goto next_sys;
> >
> >                 dir_fd = openat(events_fd, sys_dirent->d_name, O_PATH);
> >                 if (dir_fd < 0)
> > -                       continue;
> > +                       goto next_sys;
> >
> >                 evt_items = scandirat(events_fd, sys_dirent->d_name, &evt_namelist, NULL, alphasort);
> >                 for (int j = 0; j < evt_items; j++) {
> > @@ -98,12 +98,12 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
> >                         if (evt_dirent->d_type != DT_DIR ||
> >                             !strcmp(evt_dirent->d_name, ".") ||
> >                             !strcmp(evt_dirent->d_name, ".."))
> > -                               continue;
> > +                               goto next_evt;
> >
> >                         snprintf(evt_path, sizeof(evt_path), "%s/id", evt_dirent->d_name);
> >                         evt_fd = openat(dir_fd, evt_path, O_RDONLY);
> >                         if (evt_fd < 0)
> > -                               continue;
> > +                               goto next_evt;
> >                         close(evt_fd);
> >
> >                         snprintf(evt_path, MAXPATHLEN, "%s:%s",
> > @@ -119,9 +119,13 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
> >                                         /*desc=*/NULL,
> >                                         /*long_desc=*/NULL,
> >                                         /*encoding_desc=*/NULL);
> > +next_evt:
> > +                       free(evt_namelist[j]);
> >                 }
> >                 close(dir_fd);
> >                 free(evt_namelist);
> > +next_sys:
> > +               free(sys_namelist[i]);
> >         }
> >
> >         free(sys_namelist);
> > --
> > 2.40.1.495.gc816e09b53d-goog
> >

-- 

- Arnaldo
