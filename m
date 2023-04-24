Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B916ED376
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjDXRZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDXRZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:25:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DAD61B3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:25:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C2A961E7D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 17:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334F9C433D2;
        Mon, 24 Apr 2023 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682357130;
        bh=EHA9lESPa693uKZf9sQH4aI6ok2NV47j4OsYsTRAfS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBCyAwqX0KJJrsGMJb0+oRTClQLgp5ElXRv3YRHfyzS06gifXa7yNSziT32Ea4S8s
         k8lglnBV6QK0e4CL0DjX1J8dgK23cQ8OxcsH7+OYv4A7uDSUNbK2ahqiCH6YVa87yV
         vc6eOES7w41E9pDK8OZ/1CPQ4QEiukjaEKmkBY8WK53PEOTYmdMoLf5xf+SXE2PqJi
         /1Ws4X2ffgNUPwpbigTlFQKz5+DhGNV8huNIkt/5TSL4zmrUzQUzw5hDe7DXmuJ9m2
         b0lTseqk7mHsDd7eIJ+lmqwOPo1Z+HD0IFExX+XhhCshi9gCPOahn4+eKVxM7QKVSE
         P4WW2L05+5P6g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 19BB9403C5; Mon, 24 Apr 2023 14:25:27 -0300 (-03)
Date:   Mon, 24 Apr 2023 14:25:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/1] perf evsel: Introduce evsel__name_is() method to
 check if the evsel name is equal to a given string
Message-ID: <ZEa7h8ZCAS+dHTBL@kernel.org>
References: <ZEGLM8VehJbS0gP2@kernel.org>
 <ZEGOJuJd4uLS2392@kernel.org>
 <ZEGSU5DrAODcLmc3@kernel.org>
 <7de5c749-5960-2fa1-d48a-be360b08d5e1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de5c749-5960-2fa1-d48a-be360b08d5e1@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 20, 2023 at 05:16:18PM -0400, Liang, Kan escreveu:
> 
> 
> On 2023-04-20 3:28 p.m., Arnaldo Carvalho de Melo wrote:
> > Em Thu, Apr 20, 2023 at 04:10:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Thu, Apr 20, 2023 at 03:57:55PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>> This makes the logic a bit clear by avoiding the !strcmp() pattern and
> >>> also a way to intercept the pointer if we need to do extra validation on
> >>> it or to do lazy setting of evsel->name via evsel__name(evsel).
> >>
> >> + this, looking if there are others...
> > 
> > Somehow the first message didn't go thru, so below is the combined
> > patch, this is an effort to avoid accessing evsel->name directly as the
> > preferred way to get an evsel name is evsel__name(), so looking for
> > direct access and providing accessors that avoid that.
> 
> One more
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 2260e27adf44..3a960a3f6962 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -467,7 +467,7 @@ static int evsel__strcmp(struct evsel *pos, char
> *evsel_name)
>  		return 0;
>  	if (evsel__is_dummy_event(pos))
>  		return 1;
> -	return strcmp(pos->name, evsel_name);
> +	return !evsel__name_is(pos, evsel_name);
>  }
> 
>  static int evlist__is_enabled(struct evlist *evlist)

Added
 
> > 
> > From e60455d6a4e35ba0c376966443294586a1adc3ec Mon Sep 17 00:00:00 2001
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date: Thu, 20 Apr 2023 15:54:11 -0300
> > Subject: [PATCH 1/1] perf evsel: Introduce evsel__name_is() method to check if
> >  the evsel name is equal to a given string
> > 
> > This makes the logic a bit clear by avoiding the !strcmp() pattern and
> > also a way to intercept the pointer if we need to do extra validation on
> > it or to do lazy setting of evsel->name via evsel__name(evsel).
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: "Liang, Kan" <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lore.kernel.org/lkml/ZEGLM8VehJbS0gP2@kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> With the above one,
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Added these extra ones and actually made evsel__name_is() use
evsel__name().

Does your reviewed-by stands after these extra changes?

Thanks,

- Arnaldo


diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 2260e27adf44c579..a0504316b06fbcba 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -467,7 +467,7 @@ static int evsel__strcmp(struct evsel *pos, char *evsel_name)
 		return 0;
 	if (evsel__is_dummy_event(pos))
 		return 1;
-	return strcmp(pos->name, evsel_name);
+	return !evsel__name_is(pos, evsel_name);
 }
 
 static int evlist__is_enabled(struct evlist *evlist)
@@ -1706,7 +1706,7 @@ struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str)
 	evlist__for_each_entry(evlist, evsel) {
 		if (!evsel->name)
 			continue;
-		if (strcmp(str, evsel->name) == 0)
+		if (evsel__name_is(evsel, str))
 			return evsel;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 81b854650160c2b0..356c07f03be6bfce 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -823,7 +823,7 @@ const char *evsel__name(struct evsel *evsel)
 
 bool evsel__name_is(struct evsel *evsel, const char *name)
 {
-	return !strcmp(evsel->name, name);
+	return !strcmp(evsel__name(evsel), name);
 }
 
 const char *evsel__group_pmu_name(const struct evsel *evsel)
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 31b1cd0935e277ba..dae81d8e1769c763 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2893,7 +2893,7 @@ static struct evsel *find_evsel(struct evlist *evlist, char *event_name)
 	full_name = !!strchr(event_name, ':');
 	evlist__for_each_entry(evlist, pos) {
 		/* case 2 */
-		if (full_name && !strcmp(pos->name, event_name))
+		if (full_name && evsel__name_is(pos->name, event_name))
 			return pos;
 		/* case 3 */
 		if (!full_name && strstr(pos->name, event_name)) {
