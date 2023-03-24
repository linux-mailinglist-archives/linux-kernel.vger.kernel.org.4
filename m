Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706356C863E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjCXTyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCXTyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:54:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F1719C54;
        Fri, 24 Mar 2023 12:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69969B825F8;
        Fri, 24 Mar 2023 19:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31BCC433A1;
        Fri, 24 Mar 2023 19:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679687658;
        bh=/qBMaNf2uyTNrEhxXPzBWpqskPlVDXXWaE1a7Spl8og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUI7997CfkwHW/tpwqGpap88f1/mnco4Lmt9No4R+YQ0pfiCXVKlHhuHpjGHD455O
         3MyNK4t6qifiCBHxt/iq/2NoOU8tYaStg4q0wRK+st02XtJzTwFBqrUKn0vP8VvLgN
         Uj8Rjh0kQvpyDi7s9jngnS0Z/yNUwyyXiV9REBxTpOakXx237RStN23FdQXaHVpqkW
         7iiD1oT4V7nTABXAftJhTpEbylJZy1Lpq1PbRNKpPewMF5wH4QodtCWCnrpiMzssyf
         Wak03vmRDbakybRCcdSnLyBb9yVAp2lHJhULw+Bpsma97g80hTn9RGXP7NCcnNVHAO
         uVKtoSWgkMeAw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 53D514052D; Fri, 24 Mar 2023 16:54:15 -0300 (-03)
Date:   Fri, 24 Mar 2023 16:54:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf lock contention: Fix msan issue in
 lock_contention_read()
Message-ID: <ZB3/52fEm7/5w72q@kernel.org>
References: <20230324001922.937634-1-namhyung@kernel.org>
 <CAP-5=fWPDSy31BLtxvJAsRq2pwnhKHN8T-CYckv=tELGCO9p0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWPDSy31BLtxvJAsRq2pwnhKHN8T-CYckv=tELGCO9p0w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 23, 2023 at 11:50:57PM -0700, Ian Rogers escreveu:
> On Thu, Mar 23, 2023 at 5:19 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I got a report of a msan failure like below:
> >
> >   $ sudo perf lock con -ab -- sleep 1
> >   ...
> >   ==224416==WARNING: MemorySanitizer: use-of-uninitialized-value
> >       #0 0x5651160d6c96 in lock_contention_read  util/bpf_lock_contention.c:290:8
> >       #1 0x565115f90870 in __cmd_contention  builtin-lock.c:1919:3
> >       #2 0x565115f90870 in cmd_lock  builtin-lock.c:2385:8
> >       #3 0x565115f03a83 in run_builtin  perf.c:330:11
> >       #4 0x565115f03756 in handle_internal_command  perf.c:384:8
> >       #5 0x565115f02d53 in run_argv  perf.c:428:2
> >       #6 0x565115f02d53 in main  perf.c:562:3
> >       #7 0x7f43553bc632 in __libc_start_main
> >       #8 0x565115e865a9 in _start
> >
> > It was because the 'key' variable is not initialized.  Actually it'd be set
> > by bpf_map_get_next_key() but msan didn't seem to understand it.  Let's make
> > msan happy by initializing the variable.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/bpf_lock_contention.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> > index 235fc7150545..5927bf0bd92b 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> > @@ -249,7 +249,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
> >  int lock_contention_read(struct lock_contention *con)
> >  {
> >         int fd, stack, err = 0;
> > -       struct contention_key *prev_key, key;
> > +       struct contention_key *prev_key, key = {};
> >         struct contention_data data = {};
> >         struct lock_stat *st = NULL;
> >         struct machine *machine = con->machine;
> > --
> > 2.40.0.348.gf938b09366-goog
> >

-- 

- Arnaldo
