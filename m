Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2785B43D3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 05:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIJDW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 23:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIJDWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 23:22:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BC2ACA21;
        Fri,  9 Sep 2022 20:22:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fv3so3157371pjb.0;
        Fri, 09 Sep 2022 20:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=ivEe/6CaBN4d6CdnY/1R094xJCrtyZ2lPrVGrUZlaug=;
        b=ALgm0Bc5vcMIbXQqcq/u8v6dLZMEXvyhaPcdt1Nxig9D1n7YEoxWTzXmvu8RrtPcBI
         xLvLLaan7pRJ3LebnXKDqi+MTjOSjyilEdt19i/7JynI9m9mLDApEYPQSnEFGoozTtuo
         msZC8R+LdMxXMzOa1o8rWtIpr+211hBcDaTbrB0yBGdawg8kHJKKKMUOf7e9/pdd+7MV
         QMdCldBvtThdGHkcyokWjmaYN2w2sJk4yiZxfgaEgHOJs/Vt7qyvocnaRpwKEZgD6x71
         H2mRmD0p/esVGv2vpI6FCdpmYnCk/sLLhTY94k/54grrsQwvGQXd83C/b7nUG7w+YEw5
         2Knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=ivEe/6CaBN4d6CdnY/1R094xJCrtyZ2lPrVGrUZlaug=;
        b=dQY4kDhlHuaxMuqGJFLqdgY2vnrZufaE5pBx5y7f//r+e3QfYrOFpdOkHoK0mx3jdg
         fnU0ZAtSaBu+7m3y6yFnLbE9++VGbnETLGFk2dIN+kOvDqdcIQbJEgFDPcmoDcB0+ZNj
         CBuZvw5Np9JcFzVrMrk5CK4/PNf1P26kd1+eYu7w27L0lMPk30l34dVlb7R8OhFbLeVG
         nhBH+DRd7iILlArOdBWtqWqZpRJW1KbppAB4imV2NqWtQcaLGu634sSaNsOdj6AmVnl9
         liSt7eTVv67tkJNPY9mn0Z77AfErNSUJoBmOCBuAcMXei4XRkTmG9hac/JyZ9b0LClV5
         q04w==
X-Gm-Message-State: ACgBeo0bNamC84cY0VUDcxRpXx0c5I9ZMTlGOGHZK1zrB+m/zPbq9rEH
        2QdK3HL/DHhj6idom2YTTD80V5cCMiQ=
X-Google-Smtp-Source: AA6agR4UlCdUed7bcQ2yu9e3yvtEmOIHrSUxSZZuiLBWlKJXXrlST52P1qyFBnABTiFjkdOOPzcq5g==
X-Received: by 2002:a17:90b:4c91:b0:202:a345:b771 with SMTP id my17-20020a17090b4c9100b00202a345b771mr1933115pjb.128.1662780143480;
        Fri, 09 Sep 2022 20:22:23 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:b593:d80c:9f14:83ba])
        by smtp.gmail.com with ESMTPSA id nh12-20020a17090b364c00b002006428f01esm1095780pjb.55.2022.09.09.20.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 20:22:22 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH] perf annotate: Toggle full address <-> offset display
Date:   Fri,  9 Sep 2022 20:22:20 -0700
Message-Id: <20220910032220.132500-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle 'f' key to toggle the display offset and full address.  Obviously
it only works when users set to see disassembler output ('o' key).  It'd
be useful when users want to see the full virtual address in the TUI
annotate browser.

Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c |  6 +++++-
 tools/perf/util/annotate.c        | 19 ++++++++++++++++++-
 tools/perf/util/annotate.h        |  4 +++-
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 9bc1076374ff..725662e21b23 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -805,7 +805,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"r             Run available scripts\n"
 		"p             Toggle percent type [local/global]\n"
 		"b             Toggle percent base [period/hits]\n"
-		"?             Search string backwards\n");
+		"?             Search string backwards\n"
+		"f             Toggle showing offsets to full address\n");
 			continue;
 		case 'r':
 			script_browse(NULL, NULL);
@@ -912,6 +913,9 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			hists__scnprintf_title(hists, title, sizeof(title));
 			annotate_browser__show(&browser->b, title, help);
 			continue;
+		case 'f':
+			annotation__toggle_full_addr(notes, ms);
+			continue;
 		case K_LEFT:
 		case K_ESC:
 		case 'q':
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5bc63c9e0324..db475e44f42f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2239,7 +2239,10 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	}
 
 	args.ms = *ms;
-	notes->start = map__rip_2objdump(ms->map, sym->start);
+	if (notes->options && notes->options->full_addr)
+		notes->start = map__objdump_2mem(ms->map, ms->sym->start);
+	else
+		notes->start = map__rip_2objdump(ms->map, ms->sym->start);
 
 	return symbol__disassemble(sym, &args);
 }
@@ -2762,6 +2765,8 @@ void annotation__update_column_widths(struct annotation *notes)
 {
 	if (notes->options->use_offset)
 		notes->widths.target = notes->widths.min_addr;
+	else if (notes->options->full_addr)
+		notes->widths.target = BITS_PER_LONG / 4;
 	else
 		notes->widths.target = notes->widths.max_addr;
 
@@ -2771,6 +2776,18 @@ void annotation__update_column_widths(struct annotation *notes)
 		notes->widths.addr += notes->widths.jumps + 1;
 }
 
+void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *ms)
+{
+	notes->options->full_addr = !notes->options->full_addr;
+
+	if (notes->options->full_addr)
+		notes->start = map__objdump_2mem(ms->map, ms->sym->start);
+	else
+		notes->start = map__rip_2objdump(ms->map, ms->sym->start);
+
+	annotation__update_column_widths(notes);
+}
+
 static void annotation__calc_lines(struct annotation *notes, struct map *map,
 				   struct rb_root *root,
 				   struct annotation_options *opts)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 3cbd883e4d7a..8934072c39e6 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -88,7 +88,8 @@ struct annotation_options {
 	     show_nr_jumps,
 	     show_minmax_cycle,
 	     show_asm_raw,
-	     annotate_src;
+	     annotate_src,
+	     full_addr;
 	u8   offset_level;
 	int  min_pcnt;
 	int  max_lines;
@@ -325,6 +326,7 @@ void annotation__compute_ipc(struct annotation *notes, size_t size);
 void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym);
 void annotation__update_column_widths(struct annotation *notes);
 void annotation__init_column_widths(struct annotation *notes, struct symbol *sym);
+void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *ms);
 
 static inline struct sym_hist *annotated_source__histogram(struct annotated_source *src, int idx)
 {
-- 
2.37.2.789.g6183377224-goog

