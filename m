Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692C9614C04
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiKANsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiKANsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:48:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA226144;
        Tue,  1 Nov 2022 06:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C03461225;
        Tue,  1 Nov 2022 13:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC07C433C1;
        Tue,  1 Nov 2022 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667310514;
        bh=4zGhVDzrhZqHoaFUVOpPlmh8pfQtAUkt30QT/bMRjM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=huayVJFL+SLzOacxRHKmYJOkjnnZLs1ERqTtrW6FrTcsufVJi+zQhqqhNAh9tZgJ3
         i9qwnqHI7+kiIFoAiUggjbyi8r+HKg83Pr2uyFOSXUn8nLhsgLhHP7C/Z2VCxjE9IA
         Z/ww7dPeWMjrdWWcFRwDjBEoN8ghrjEVaG0EL/6XqM6OSuzELbf5uscVDR6Nmmvn8C
         QCy1KuNK6FKIMFTqJZilCA3Id9gNEHpz8/CRVP0Xkknd2pehbh9bqxUFqLpUhrPb8w
         wqyQva+prqLcI0FXNmmDTufLfEZO4DEVhHOwXfwQw8TC4WmIvnlKikofbctM+1RE8L
         AN5+1qpUHRbuA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 1/3] tools/perf: Fix to avoid crashing if DW_AT_decl_file is NULL
Date:   Tue,  1 Nov 2022 22:48:30 +0900
Message-Id: <166731051077.2100653.15626653369345128302.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <166731050151.2100653.8202870942871353491.stgit@devnote3>
References: <166731050151.2100653.8202870942871353491.stgit@devnote3>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since Clang generates the DWARF5 which will set DW_AT_decl_file
as 0, dwarf_decl_file() thinks that is invalid and returns NULL.
In that case the perf probe will crash by SIGSEGV because it
doesn't expect the NULL decl_file.

This adds checks of the return value of dwarf_decl_file() to avoid
such SEGV with clang DWARF5 file.

Without this, perf probe crashes like below;
 $ ./perf probe -k $BIN_PATH/vmlinux -s $SRC_PATH -L vfs_read:10
 Segmentation fault

With this, perf probe just warns it;
 $ ./perf probe -k $BIN_PATH/vmlinux -s $SRC_PATH -L vfs_read:10
 Debuginfo analysis failed.
   Error: Failed to show lines.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Update patch description.
---
 tools/perf/util/dwarf-aux.c    |    7 ++++++-
 tools/perf/util/probe-finder.c |   29 +++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 609ca1671501..406b7bdc851a 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -137,7 +137,7 @@ int cu_find_lineinfo(Dwarf_Die *cu_die, Dwarf_Addr addr,
 	}
 
 out:
-	return *lineno ?: -ENOENT;
+	return (*lineno && *fname) ? *lineno : -ENOENT;
 }
 
 static int __die_find_inline_cb(Dwarf_Die *die_mem, void *data);
@@ -874,6 +874,11 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 		cu_die = dwarf_diecu(rt_die, &die_mem, NULL, NULL);
 		dwarf_decl_line(rt_die, &decl);
 		decf = dwarf_decl_file(rt_die);
+		if (!decf) {
+			pr_debug2("Failed to get the declared file name of %s\n",
+				  dwarf_diename(rt_die));
+			return -EINVAL;
+		}
 	} else
 		cu_die = rt_die;
 	if (!cu_die) {
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 50d861a80f57..1aa8fcc41c76 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1063,6 +1063,7 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 	struct dwarf_callback_param *param = data;
 	struct probe_finder *pf = param->data;
 	struct perf_probe_point *pp = &pf->pev->point;
+	const char *fname;
 
 	/* Check tag and diename */
 	if (!die_is_func_def(sp_die) ||
@@ -1070,12 +1071,17 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 		return DWARF_CB_OK;
 
 	/* Check declared file */
-	if (pp->file && strtailcmp(pp->file, dwarf_decl_file(sp_die)))
+	fname = dwarf_decl_file(sp_die);
+	if (!fname) {
+		pr_warning("A function DIE doesn't have decl_line. Maybe broken DWARF?\n");
+		return DWARF_CB_OK;
+	}
+	if (pp->file && fname && strtailcmp(pp->file, fname))
 		return DWARF_CB_OK;
 
 	pr_debug("Matched function: %s [%lx]\n", dwarf_diename(sp_die),
 		 (unsigned long)dwarf_dieoffset(sp_die));
-	pf->fname = dwarf_decl_file(sp_die);
+	pf->fname = fname;
 	if (pp->line) { /* Function relative line */
 		dwarf_decl_line(sp_die, &pf->lno);
 		pf->lno += pp->line;
@@ -1134,6 +1140,7 @@ struct pubname_callback_param {
 static int pubname_search_cb(Dwarf *dbg, Dwarf_Global *gl, void *data)
 {
 	struct pubname_callback_param *param = data;
+	const char *fname;
 
 	if (dwarf_offdie(dbg, gl->die_offset, param->sp_die)) {
 		if (dwarf_tag(param->sp_die) != DW_TAG_subprogram)
@@ -1143,9 +1150,11 @@ static int pubname_search_cb(Dwarf *dbg, Dwarf_Global *gl, void *data)
 			if (!dwarf_offdie(dbg, gl->cu_offset, param->cu_die))
 				return DWARF_CB_OK;
 
-			if (param->file &&
-			    strtailcmp(param->file, dwarf_decl_file(param->sp_die)))
-				return DWARF_CB_OK;
+			if (param->file) {
+				fname = dwarf_decl_file(param->sp_die);
+				if (!fname || strtailcmp(param->file, fname))
+					return DWARF_CB_OK;
+			}
 
 			param->found = 1;
 			return DWARF_CB_ABORT;
@@ -1779,7 +1788,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
 		}
 		/* Verify the lineno and baseline are in a same file */
 		tmp = dwarf_decl_file(&spdie);
-		if (!tmp || strcmp(tmp, fname) != 0)
+		if (!tmp || (fname && strcmp(tmp, fname) != 0))
 			lineno = 0;
 	}
 
@@ -1889,10 +1898,14 @@ static int line_range_search_cb(Dwarf_Die *sp_die, void *data)
 	struct dwarf_callback_param *param = data;
 	struct line_finder *lf = param->data;
 	struct line_range *lr = lf->lr;
+	const char *fname;
 
 	/* Check declared file */
-	if (lr->file && strtailcmp(lr->file, dwarf_decl_file(sp_die)))
-		return DWARF_CB_OK;
+	if (lr->file) {
+		fname = dwarf_decl_file(sp_die);
+		if (!fname || strtailcmp(lr->file, fname))
+			return DWARF_CB_OK;
+	}
 
 	if (die_match_name(sp_die, lr->function) && die_is_func_def(sp_die)) {
 		lf->fname = dwarf_decl_file(sp_die);

