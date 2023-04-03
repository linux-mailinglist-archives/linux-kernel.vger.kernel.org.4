Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D44F6D540E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjDCV7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjDCV7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:59:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5039E26A3;
        Mon,  3 Apr 2023 14:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9BC262D1C;
        Mon,  3 Apr 2023 21:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D0BC4339B;
        Mon,  3 Apr 2023 21:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680559153;
        bh=zgA6EyZzT8cJ+mkAi174ezLK/5e3y5TnYY1lxyMqOCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JrrBDQ1cVXWyXonJ6p6LUvENGBY3VAJGwKVnuTAJ1wWbwT559nlb4ueI3YQJOwyhb
         esgJLDHQEr56mQDNKaPSQGbyP1ZJnFeGcI6BfBPNfOi+Hu0eGYkunhl9gvQ4AEN5dZ
         JCztSFeABGafEtX0DS+GWfrxFY8nfjytOoWWFdSgURrfYZ99o6if5tdiIjlDMpt/IX
         i3ODIGEcZztJIxfJZWW8SkXa/p3G3ow5Ndiby9WMvup4Q1tKZm5l3aZjdfjEdWTXK3
         GxGaWEqCN2i10e7N62i0D3Odx9DtZ5Mj11dxPpacOjYzbs98Y6ZF4hwIWSGqU5+NTb
         fj42C0hy/VlUw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 908A24052D; Mon,  3 Apr 2023 18:59:10 -0300 (-03)
Date:   Mon, 3 Apr 2023 18:59:10 -0300
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
Message-ID: <ZCtMLkNL80EkPvB1@kernel.org>
References: <20230331202949.810326-1-namhyung@kernel.org>
 <20230331202949.810326-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331202949.810326-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 31, 2023 at 01:29:41PM -0700, Namhyung Kim escreveu:
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/print-events.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)

Add to add this to fix on Alma Linux 8, and scandirat isn't being found
on musl libc (Alpine Linux), probably we'll need some scaffolding...

- Arnaldo


diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 26a7e017c9284c01..28aa0b9300253d0a 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <fcntl.h>
 #include <sys/param.h>
+#include <unistd.h>
 
 #include <api/fs/tracing_path.h>
 #include <linux/stddef.h>
 
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> index 62e9ea7dcf40..26a7e017c928 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -4,6 +4,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <fcntl.h>
>  #include <sys/param.h>
>  
>  #include <api/fs/tracing_path.h>
> @@ -59,12 +60,20 @@ static const struct event_symbol event_symbols_tool[PERF_TOOL_MAX] = {
>  void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state)
>  {
>  	struct dirent **sys_namelist = NULL;
> +	char *events_path = get_tracing_file("events");
>  	int sys_items = tracing_events__scandir_alphasort(&sys_namelist);
> +	int events_fd = open(events_path, O_PATH);
> +
> +	put_tracing_file(events_path);
> +	if (events_fd < 0) {
> +		printf("Error: failed to open tracing events directory\n");
> +		return;
> +	}
>  
>  	for (int i = 0; i < sys_items; i++) {
>  		struct dirent *sys_dirent = sys_namelist[i];
>  		struct dirent **evt_namelist = NULL;
> -		char *dir_path;
> +		int dir_fd;
>  		int evt_items;
>  
>  		if (sys_dirent->d_type != DT_DIR ||
> @@ -72,22 +81,26 @@ void print_tracepoint_events(const struct print_callbacks *print_cb, void *print
>  		    !strcmp(sys_dirent->d_name, ".."))
>  			continue;
>  
> -		dir_path = get_events_file(sys_dirent->d_name);
> -		if (!dir_path)
> +		dir_fd = openat(events_fd, sys_dirent->d_name, O_PATH);
> +		if (dir_fd < 0)
>  			continue;
>  
> -		evt_items = scandir(dir_path, &evt_namelist, NULL, alphasort);
> +		evt_items = scandirat(events_fd, sys_dirent->d_name, &evt_namelist, NULL, alphasort);
>  		for (int j = 0; j < evt_items; j++) {
>  			struct dirent *evt_dirent = evt_namelist[j];
>  			char evt_path[MAXPATHLEN];
> +			int evt_fd;
>  
>  			if (evt_dirent->d_type != DT_DIR ||
>  			    !strcmp(evt_dirent->d_name, ".") ||
>  			    !strcmp(evt_dirent->d_name, ".."))
>  				continue;
>  
> -			if (tp_event_has_id(dir_path, evt_dirent) != 0)
> +			snprintf(evt_path, sizeof(evt_path), "%s/id", evt_dirent->d_name);
> +			evt_fd = openat(dir_fd, evt_path, O_RDONLY);
> +			if (evt_fd < 0)
>  				continue;
> +			close(evt_fd);
>  
>  			snprintf(evt_path, MAXPATHLEN, "%s:%s",
>  				 sys_dirent->d_name, evt_dirent->d_name);
> @@ -103,10 +116,11 @@ void print_tracepoint_events(const struct print_callbacks *print_cb, void *print
>  					/*long_desc=*/NULL,
>  					/*encoding_desc=*/NULL);
>  		}
> -		free(dir_path);
> +		close(dir_fd);
>  		free(evt_namelist);
>  	}
>  	free(sys_namelist);
> +	close(events_fd);
>  }
>  
>  void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
> -- 
> 2.40.0.348.gf938b09366-goog
> 

-- 

- Arnaldo
