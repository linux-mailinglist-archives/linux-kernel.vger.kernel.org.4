Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC072C811
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbjFLOU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbjFLOTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:19:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C208310E5;
        Mon, 12 Jun 2023 07:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A919629D9;
        Mon, 12 Jun 2023 14:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B4FC433D2;
        Mon, 12 Jun 2023 14:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579375;
        bh=I81TzEEgr+iBFB3ggd2UL+vncAhncisVZbGJOGh0RRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFrCXo3NnehbDQTt94MUBI906ZZIB3NYaX8zxjZrQ9ZxY8WwDtPNEbSONSBp6hcm7
         zmsOOaOKrNtUI5j+V+te64yG5JjYwLcWICWIR4ovL+HGfD48fHkxdZ0gySUxgx93pu
         xGJWyyGm/W9I2nmW3BqcKTkt29GueQGpaII/o1Za5LZ2nxP7RyUdo7kAy0GTL7r6u+
         7rgikP3g46SvJDvDSFNkWwGxWU3CBS+MUpilEj1FvAKP9a4fC15eRf737X8SG3XI6g
         qbPvtNPEm8W32Rkj5mpgVuKzW9Bs6PQF3Lh3BRRKIoeJX8fnl7sQCOsJLwWOHQHWci
         QSWrVnILnHcyA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8847C40692; Mon, 12 Jun 2023 11:16:13 -0300 (-03)
Date:   Mon, 12 Jun 2023 11:16:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [PATCH v2 26/26] perf hist: Fix srcline memory leak
Message-ID: <ZIcorZVu1z8jaPL/@kernel.org>
References: <20230608232823.4027869-1-irogers@google.com>
 <20230608232823.4027869-27-irogers@google.com>
 <ZIcoJytUEz4UgQYR@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIcoJytUEz4UgQYR@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 12, 2023 at 11:13:59AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jun 08, 2023 at 04:28:23PM -0700, Ian Rogers escreveu:
> > srcline isn't freed if it is SRCLINE_UNKNOWN. Avoid strduping in this
> > case as such strdups are redundant and leak memory.
> 
> The patch is ok as its what the rest of the code is doing, i.e. strcmp()
> to check if a srcline is the unknown one, but how about the following
> patch on top of yours?

[acme@quaco perf-tools-next]$ strings ~/bin/perf | grep '??:0'
??:0
SRCLINE_UNKNOWN ((char *) "??:0")
[acme@quaco perf-tools-next]$
 
> From 5163e54c1ed3d476f6b4e7f938861039bd4eec7c Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Mon, 12 Jun 2023 11:10:46 -0300
> Subject: [PATCH 1/1] perf srcline: Optimize comparision against
>  SRCLINE_UNKNOWN
> 
> This is a string constant that gets returned and then strcmp() around,
> we can instead just do a pointer comparision.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-diff.c    | 4 ++--
>  tools/perf/util/block-info.c | 4 ++--
>  tools/perf/util/hist.c       | 2 +-
>  tools/perf/util/map.c        | 2 +-
>  tools/perf/util/sort.c       | 2 +-
>  tools/perf/util/srcline.c    | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index eec89567ae483604..e8a1b16aa5f83f4f 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -1378,8 +1378,8 @@ static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
>  	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
>  				he->ms.sym);
>  
> -	if ((strncmp(start_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0) &&
> -	    (strncmp(end_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)) {
> +	if (start_line != SRCLINE_UNKNOWN &&
> +	    end_line != SRCLINE_UNKNOWN) {
>  		scnprintf(buf, sizeof(buf), "[%s -> %s] %4ld",
>  			  start_line, end_line, block_he->diff.cycles);
>  	} else {
> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
> index 08279b1b65e5a4b0..fe4c17248799f0a2 100644
> --- a/tools/perf/util/block-info.c
> +++ b/tools/perf/util/block-info.c
> @@ -296,8 +296,8 @@ static int block_range_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>  	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
>  				he->ms.sym);
>  
> -	if ((strncmp(start_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0) &&
> -	    (strncmp(end_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)) {
> +	if (start_line != SRCLINE_UNKNOWN) &&
> +	    end_line != SRCLINE_UNKNOWN) {
>  		scnprintf(buf, sizeof(buf), "[%s -> %s]",
>  			  start_line, end_line);
>  	} else {
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 0a10bcc6ec95b5e0..3dc8a4968beb9c01 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -484,7 +484,7 @@ static int hist_entry__init(struct hist_entry *he,
>  			goto err_infos;
>  	}
>  
> -	if (he->srcline && strcmp(he->srcline, SRCLINE_UNKNOWN)) {
> +	if (he->srcline && he->srcline != SRCLINE_UNKNOWN) {
>  		he->srcline = strdup(he->srcline);
>  		if (he->srcline == NULL)
>  			goto err_rawdata;
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index c77e2fce6a379e7f..f30d34903aa4eabe 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -496,7 +496,7 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
>  
>  	if (dso) {
>  		char *srcline = map__srcline(map, addr, NULL);
> -		if (strncmp(srcline, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)
> +		if (srcline != SRCLINE_UNKNOWN)
>  			ret = fprintf(fp, "%s%s", prefix, srcline);
>  		zfree_srcline(&srcline);
>  	}
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 047c3606802f5b7f..6aa1c7f2b4448b30 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -643,7 +643,7 @@ static char *hist_entry__get_srcfile(struct hist_entry *e)
>  
>  	sf = __get_srcline(map__dso(map), map__rip_2objdump(map, e->ip),
>  			 e->ms.sym, false, true, true, e->ip);
> -	if (!strcmp(sf, SRCLINE_UNKNOWN))
> +	if (sf == SRCLINE_UNKNOWN)
>  		return no_srcfile;
>  	p = strchr(sf, ':');
>  	if (p && *sf) {
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index b8e596528d7e7e5e..48a04f42b308b080 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -809,7 +809,7 @@ void zfree_srcline(char **srcline)
>  	if (*srcline == NULL)
>  		return;
>  
> -	if (strcmp(*srcline, SRCLINE_UNKNOWN))
> +	if (*srcline != SRCLINE_UNKNOWN)
>  		free(*srcline);
>  
>  	*srcline = NULL;
> -- 
> 2.39.2
> 
>  
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/hist.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index 77cb2cc83bb9..cc6f7f51faa5 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -484,7 +484,7 @@ static int hist_entry__init(struct hist_entry *he,
> >  			goto err_infos;
> >  	}
> >  
> > -	if (he->srcline) {
> > +	if (he->srcline && strcmp(he->srcline, SRCLINE_UNKNOWN)) {
> >  		he->srcline = strdup(he->srcline);
> >  		if (he->srcline == NULL)
> >  			goto err_rawdata;
> > -- 
> > 2.41.0.162.gfafddb0af9-goog
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
