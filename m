Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34506D545C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjDCWAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjDCWAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:00:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA75213D;
        Mon,  3 Apr 2023 15:00:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A90362D1C;
        Mon,  3 Apr 2023 22:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D0CC4339B;
        Mon,  3 Apr 2023 22:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680559252;
        bh=Ai14S18Aw5qGByQF2yt3KwWQBo/ayAzmSSgBWfeh7a0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=snIVzn+DwYAEZr/oKAFa0eEATL2NAEMhlAkJfaK/e+H1OGPebIUvaisxdLaLw1i1s
         0Gk1WgFtJiEG1jyC/yazT1fYS7znH9CtvCXNToCjHijO4jLM5HfRllAGszBy7kG0NU
         e8FkLXaTeIOTFzROuVuYBPNvcFzDNX4HnYiQyj2cHNAGJjemmeUpaQrobPXsx6U0rB
         s/yAY6LGHlfsMoJKP0qTd1+LkVW/bbBvpEjuRSboyx1SxDGMyjws51AcESgreMDaMT
         V+w1WNuM6xxBQFja6VBN5gKkZBRyr3X/miGTeo/IR33v4zww6zCfG1UcqFlpCWJTVz
         DpFRjPOcsB1sg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5C5FD4052D; Mon,  3 Apr 2023 19:00:49 -0300 (-03)
Date:   Mon, 3 Apr 2023 19:00:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 1/9] perf list: Use relative path for tracepoint scan
Message-ID: <ZCtMkejMly5W534I@kernel.org>
References: <20230331202949.810326-1-namhyung@kernel.org>
 <20230331202949.810326-2-namhyung@kernel.org>
 <ZCtMLkNL80EkPvB1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCtMLkNL80EkPvB1@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 03, 2023 at 06:59:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Mar 31, 2023 at 01:29:41PM -0700, Namhyung Kim escreveu:
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/print-events.c | 26 ++++++++++++++++++++------
> >  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> Add to add this to fix on Alma Linux 8, and scandirat isn't being found
> on musl libc (Alpine Linux), probably we'll need some scaffolding...

Some discussion about this for some other project:

https://gitlab.com/apparmor/apparmor/-/merge_requests/107
 
> - Arnaldo
> 
> 
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> index 26a7e017c9284c01..28aa0b9300253d0a 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -6,6 +6,7 @@
>  #include <string.h>
>  #include <fcntl.h>
>  #include <sys/param.h>
> +#include <unistd.h>
>  
>  #include <api/fs/tracing_path.h>
>  #include <linux/stddef.h>
>  
> > diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> > index 62e9ea7dcf40..26a7e017c928 100644
> > --- a/tools/perf/util/print-events.c
> > +++ b/tools/perf/util/print-events.c
> > @@ -4,6 +4,7 @@
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > +#include <fcntl.h>
> >  #include <sys/param.h>
> >  
> >  #include <api/fs/tracing_path.h>
> > @@ -59,12 +60,20 @@ static const struct event_symbol event_symbols_tool[PERF_TOOL_MAX] = {
> >  void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state)
> >  {
> >  	struct dirent **sys_namelist = NULL;
> > +	char *events_path = get_tracing_file("events");
> >  	int sys_items = tracing_events__scandir_alphasort(&sys_namelist);
> > +	int events_fd = open(events_path, O_PATH);
> > +
> > +	put_tracing_file(events_path);
> > +	if (events_fd < 0) {
> > +		printf("Error: failed to open tracing events directory\n");
> > +		return;
> > +	}
> >  
> >  	for (int i = 0; i < sys_items; i++) {
> >  		struct dirent *sys_dirent = sys_namelist[i];
> >  		struct dirent **evt_namelist = NULL;
> > -		char *dir_path;
> > +		int dir_fd;
> >  		int evt_items;
> >  
> >  		if (sys_dirent->d_type != DT_DIR ||
> > @@ -72,22 +81,26 @@ void print_tracepoint_events(const struct print_callbacks *print_cb, void *print
> >  		    !strcmp(sys_dirent->d_name, ".."))
> >  			continue;
> >  
> > -		dir_path = get_events_file(sys_dirent->d_name);
> > -		if (!dir_path)
> > +		dir_fd = openat(events_fd, sys_dirent->d_name, O_PATH);
> > +		if (dir_fd < 0)
> >  			continue;
> >  
> > -		evt_items = scandir(dir_path, &evt_namelist, NULL, alphasort);
> > +		evt_items = scandirat(events_fd, sys_dirent->d_name, &evt_namelist, NULL, alphasort);
> >  		for (int j = 0; j < evt_items; j++) {
> >  			struct dirent *evt_dirent = evt_namelist[j];
> >  			char evt_path[MAXPATHLEN];
> > +			int evt_fd;
> >  
> >  			if (evt_dirent->d_type != DT_DIR ||
> >  			    !strcmp(evt_dirent->d_name, ".") ||
> >  			    !strcmp(evt_dirent->d_name, ".."))
> >  				continue;
> >  
> > -			if (tp_event_has_id(dir_path, evt_dirent) != 0)
> > +			snprintf(evt_path, sizeof(evt_path), "%s/id", evt_dirent->d_name);
> > +			evt_fd = openat(dir_fd, evt_path, O_RDONLY);
> > +			if (evt_fd < 0)
> >  				continue;
> > +			close(evt_fd);
> >  
> >  			snprintf(evt_path, MAXPATHLEN, "%s:%s",
> >  				 sys_dirent->d_name, evt_dirent->d_name);
> > @@ -103,10 +116,11 @@ void print_tracepoint_events(const struct print_callbacks *print_cb, void *print
> >  					/*long_desc=*/NULL,
> >  					/*encoding_desc=*/NULL);
> >  		}
> > -		free(dir_path);
> > +		close(dir_fd);
> >  		free(evt_namelist);
> >  	}
> >  	free(sys_namelist);
> > +	close(events_fd);
> >  }
> >  
> >  void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
> > -- 
> > 2.40.0.348.gf938b09366-goog
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
