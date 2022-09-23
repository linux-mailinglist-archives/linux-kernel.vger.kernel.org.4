Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B265E80C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiIWRc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiIWRcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:32:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E03151B02;
        Fri, 23 Sep 2022 10:32:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fv3so726023pjb.0;
        Fri, 23 Sep 2022 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=fR6Qn5t8q/W233LEaMYnwEm/k8WcsQCSexxbn0Oka8g=;
        b=CBp3fp1kj89uIt+Kqdc9A2OKnsqePyce9wUyH93zYf9WEs21ei/znvqFqg/AM/DqeS
         o6BQSjeAMdsxbti0rz0cKYWsJlVbpA+UVfAnlPhfZezna92pQ3apVB25JIZDNAK8x03T
         mCPqTFuy0hFPA3l0Qz2eS2N8pbBI12MkTMjLEoAonm/0mxHkAegX0D7028il0S8PLTxT
         O5vtZpVAdrpGWzmeWLlR2Ens+V4Fbyh/ZjCmtQ49v98G3IeJ4gF7mpdZwH/8MKDDdaB7
         m5WZLbS0zc/+pUBj1eK+7PYtadRiTQZIa56csi3UpiU+yKjkBhtR0I+Qvy2T16U+d5HD
         xc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=fR6Qn5t8q/W233LEaMYnwEm/k8WcsQCSexxbn0Oka8g=;
        b=VhvVC3E/WZ6SeBJflgYjYCwgnjgMO4eOdKbh1Fo2fTHk4GJjjurQHyn+sx5CNLIYlP
         98rTfwJTUrZ6NehxeyjXRupAqiMqa9iz7c7ZQnvyOm76WBs2FvWXeShO+wxA2HdblKYm
         bF69XvMLda3Qa2I+wCjyT18fFXs/dZIh4/XjfJmh4CXUEMYgtCYnNVdZ+mqrY1jvrF1P
         4DWFgpqKGkuuRA5xo4xS/agHmyLW0yQfI+LECqcty0++WyeWTYSaUg6O/4+uMGwf6+0m
         8fdhk0SvfahyTcIyTbRnrbzEnS7qavYegLmIMx5cDP+OyKg+pG6v6I4F0rAAC11+AzoG
         VXZQ==
X-Gm-Message-State: ACrzQf2JHPw90HHiYUOB13d8/TDovV+qVMdLfExHKXWLmVFdSpI/UVlV
        Iwx2F/NAZdLEWrB0gmQjTPOoUSVWHzo=
X-Google-Smtp-Source: AMsMyM5W9ZCou1732xAM0X728nc1lfnuXCIc/eOytGvUD9OCkOSKM/pMFmnPKFc7nCggcfSDqb0VAA==
X-Received: by 2002:a17:90b:3c90:b0:203:bf90:f78b with SMTP id pv16-20020a17090b3c9000b00203bf90f78bmr17636597pjb.138.1663954328271;
        Fri, 23 Sep 2022 10:32:08 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:c716:a857:50ee:f56e])
        by smtp.gmail.com with ESMTPSA id 9-20020a621409000000b0053e6eae9668sm6719499pfu.2.2022.09.23.10.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 10:32:07 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 4/4] perf annotate: Toggle full address <-> offset display
Date:   Fri, 23 Sep 2022 10:31:42 -0700
Message-Id: <20220923173142.805896-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220923173142.805896-1-namhyung@kernel.org>
References: <20220923173142.805896-1-namhyung@kernel.org>
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
2.37.3.998.g577e59143f-goog

