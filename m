Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9B95BF017
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiITW2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiITW22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:28:28 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ABA5AC61;
        Tue, 20 Sep 2022 15:28:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p18so3818090plr.8;
        Tue, 20 Sep 2022 15:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=b0TwgF3e0WmdwRlV5PKHLE+xmbYkh0/m4EttPyhr+E0=;
        b=HlV0+lH1QZgu796UDU4yLSyJ7iocKW/S8GpT8Sc7Hs2XlbBfchHAhUg3Fm132U+CWP
         o/ySjOm31HhLyhyDa1BpX7qs3Q8SicFwM362/EHf1HsHJYfK/I8P/ALt6bZupCXtK3Ga
         gExBwkIqXQsQSM/GYoPtuuX3EdAOunMmXnsAY+4cQrgkas08L4ioY2kOTiFnM+U1cEf0
         GTHQuZallARZIHy/htRYxt+28KfMTclOLO4hyOHbJTZfEFGxwHGY1FKsKH0yQ9I1Wpj6
         G9biBzhY8a0wIc+ugVvgtjV6gNdal78i+mWPUSrETTPNVNbfnNM4ygpw4ResVwq4zgK/
         bYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=b0TwgF3e0WmdwRlV5PKHLE+xmbYkh0/m4EttPyhr+E0=;
        b=R4gyLe9cXKlQAA6pR3jOgfXT90iX3yikW/g9yzSm6Rd7hwuZl4nLS8fOJIRU6Bo3Sa
         xTFntB1+k6NjhWx8uWVZhVOrl7TptpfYjKSVA++A4WJ0egN9U0T/Rj482c5IC+f4DVai
         l/AE96xICyGku4k04rHILuAMfefOBAFE3PvZry9YOb/6Qx3hdZXHb3BCvS5bpY0uA0Dj
         Ubsu4fOqVDHw+cCVdySCARdb8n0FslXtphJo2tfr8kvAigFWnP+tUTHsmzFcehk9jQ4m
         7oKszbfkPeKCXCJJ204KkXOELfT9gpyceOVevked0VGTTEIGP7Y4UOKGUWZLj5prwUGt
         QJWg==
X-Gm-Message-State: ACrzQf3Y4yHk1h6dUxRjOosGvb1L+mHQbpIJ0+8v70PCbhpMxsKCK5ha
        lv9FD6WoU1PczASVE69lHLE=
X-Google-Smtp-Source: AMsMyM5mFC+q9FD4rTBHntYv6fD1RBkL6p3RhT1hCJCet3QaVOsFjBwL+b3IiOPowyWqFcdAHMtzTA==
X-Received: by 2002:a17:90b:180d:b0:202:7cf6:9f9b with SMTP id lw13-20020a17090b180d00b002027cf69f9bmr6254518pjb.160.1663712906910;
        Tue, 20 Sep 2022 15:28:26 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:7c7c:fcc0:e49a:4079])
        by smtp.gmail.com with ESMTPSA id c6-20020a170903234600b0017680faa1a8sm413083plh.112.2022.09.20.15.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 15:28:26 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v2 2/2] perf record: Save DSO build-ID for synthesizing
Date:   Tue, 20 Sep 2022 15:28:22 -0700
Message-Id: <20220920222822.2171056-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220920222822.2171056-1-namhyung@kernel.org>
References: <20220920222822.2171056-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When synthesizing MMAP2 with build-id, it'd read the same file repeatedly as
it has no idea if it's done already.  Maintain a dsos to check that and skip
the file access if possible.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2 change)
 * Remove perf_event__synthesize_{start,stop} and use machine->dsos  (Adrian)

 tools/perf/util/synthetic-events.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 289ea17ac5f7..cccd293b5312 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -364,11 +364,14 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
 }
 
 static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
+					     struct machine *machine,
 					     bool is_kernel)
 {
 	struct build_id bid;
 	struct nsinfo *nsi;
 	struct nscookie nc;
+	struct dso *dso = NULL;
+	struct dso_id id;
 	int rc;
 
 	if (is_kernel) {
@@ -376,6 +379,18 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 		goto out;
 	}
 
+	id.maj = event->maj;
+	id.min = event->min;
+	id.ino = event->ino;
+	id.ino_generation = event->ino_generation;
+
+	dso = dsos__findnew_id(&machine->dsos, event->filename, &id);
+	if (dso && dso->has_build_id) {
+		bid = dso->bid;
+		rc = 0;
+		goto out;
+	}
+
 	nsi = nsinfo__new(event->pid);
 	nsinfo__mountns_enter(nsi, &nc);
 
@@ -391,12 +406,16 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 		event->header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
 		event->__reserved_1 = 0;
 		event->__reserved_2 = 0;
+
+		if (dso && !dso->has_build_id)
+			dso__set_build_id(dso, &bid);
 	} else {
 		if (event->filename[0] == '/') {
 			pr_debug2("Failed to read build ID for %s\n",
 				  event->filename);
 		}
 	}
+	dso__put(dso);
 }
 
 int perf_event__synthesize_mmap_events(struct perf_tool *tool,
@@ -507,7 +526,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 		event->mmap2.tid = pid;
 
 		if (symbol_conf.buildid_mmap2)
-			perf_record_mmap2__read_build_id(&event->mmap2, false);
+			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
 
 		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
 			rc = -1;
@@ -690,7 +709,7 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 			memcpy(event->mmap2.filename, pos->dso->long_name,
 			       pos->dso->long_name_len + 1);
 
-			perf_record_mmap2__read_build_id(&event->mmap2, false);
+			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
 		} else {
 			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
 			event->mmap.header.type = PERF_RECORD_MMAP;
@@ -1126,7 +1145,7 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 		event->mmap2.len   = map->end - event->mmap.start;
 		event->mmap2.pid   = machine->pid;
 
-		perf_record_mmap2__read_build_id(&event->mmap2, true);
+		perf_record_mmap2__read_build_id(&event->mmap2, machine, true);
 	} else {
 		size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
 				"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
-- 
2.37.3.968.ga6b4b080e4-goog

