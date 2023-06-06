Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A074724CE4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbjFFTQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237630AbjFFTP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9644C1992
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:15:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8AFE63081
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 19:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B88AC433D2;
        Tue,  6 Jun 2023 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686078934;
        bh=oDfcC99H7vL4Ph3/RETkW7NPppuo29jYZmhGR4hW7I0=;
        h=Date:From:To:Cc:Subject:From;
        b=qLQHN19tTxoYONb6oCJkxwQuZG5qvi1k/kmzTS8nY2Qnnop+MkOH/F0VGO/kG+uoZ
         1MKE+8mupT15VCTjLwKtQ/H79M3caQp6/XF81haR4ldQLyDIFL06aiFRBPMAoNRNBm
         J2jDR3p8o+nLTX8WvX4i3HGJWoa27GFG28O9x5LDjVPVuIdb9pH9q7dzmVnErDLta8
         2HfNtBpfpqGOciYJKbeAjveHNmlJhfenGKvuJjVV7LnxiZBO/hPZZgAV6+so+ruIhC
         EEiEEFCbEVayBxjoiyD9apGWvLvnsnL81IZtepc2PY6KgfkzsumWR0SWjdAplUL07K
         Y6hcD0a26Q17Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7136A40692; Tue,  6 Jun 2023 16:15:31 -0300 (-03)
Date:   Tue, 6 Jun 2023 16:15:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf script: Fix allocation of evsel->priv related to
 per-event dump files
Message-ID: <ZH+F0wGAWV14zvMP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm carrying this in my perf-tools-next, please ack :-)

- Arnaldo

---

When printing output we may want to generate per event files, where the
--per-event-dump option should be used, creating perf.data.EVENT.dump
files instead of printing to stdout.

The callback thar processes event thus expects that evsel->priv->fp
should point to either the per-event FILE descriptor or to stdout.

The a3af66f51bd0bca7 ("perf script: Fix crash because of missing
evsel->priv") changeset fixed a case where evsel->priv wasn't setup,
thus set to NULL, causing a segfault when trying to access
evsel->priv->fp.

But it did it for the non --per-event-dump case by allocating a 'struct
perf_evsel_script' just to set its ->fp to stdout.

Since evsel->priv is only freed when --per-event-dump is used, we ended
up with a memory leek, detected using ASAN.

Fix it by using the same method as perf_script__setup_per_event_dump(),
and reuse that static 'struct perf_evsel_script'.

Also check if evsel_script__new() failed.

Fixes: a3af66f51bd0bca7 ("perf script: Fix crash because of missing evsel->priv")
Reported-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 70549fc93b125394..b02ad386a55baf07 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2410,6 +2410,9 @@ static int process_sample_event(struct perf_tool *tool,
 	return ret;
 }
 
+// Used when scr->per_event_dump is not set
+static struct evsel_script es_stdout;
+
 static int process_attr(struct perf_tool *tool, union perf_event *event,
 			struct evlist **pevlist)
 {
@@ -2418,7 +2421,6 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	struct evsel *evsel, *pos;
 	u64 sample_type;
 	int err;
-	static struct evsel_script *es;
 
 	err = perf_event__process_attr(tool, event, pevlist);
 	if (err)
@@ -2428,14 +2430,13 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	evsel = evlist__last(*pevlist);
 
 	if (!evsel->priv) {
-		if (scr->per_event_dump) {
+		if (scr->per_event_dump) { 
 			evsel->priv = evsel_script__new(evsel, scr->session->data);
-		} else {
-			es = zalloc(sizeof(*es));
-			if (!es)
+			if (!evsel->priv)
 				return -ENOMEM;
-			es->fp = stdout;
-			evsel->priv = es;
+		} else { // Replicate what is done in perf_script__setup_per_event_dump()
+			es_stdout.fp = stdout;
+			evsel->priv = &es_stdout;
 		}
 	}
 
@@ -2741,7 +2742,6 @@ static int perf_script__fopen_per_event_dump(struct perf_script *script)
 static int perf_script__setup_per_event_dump(struct perf_script *script)
 {
 	struct evsel *evsel;
-	static struct evsel_script es_stdout;
 
 	if (script->per_event_dump)
 		return perf_script__fopen_per_event_dump(script);
-- 
2.37.1

