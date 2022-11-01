Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BF0614C08
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKANtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiKANs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:48:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D2264DD;
        Tue,  1 Nov 2022 06:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F888B81D62;
        Tue,  1 Nov 2022 13:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54230C433D6;
        Tue,  1 Nov 2022 13:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667310533;
        bh=7VJv3LGZx07VjYJ8GyNu8FKNv+xMB492/CTyp64BuOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hwd+Yw8MpOsHmSZ4yG1Ti+9ZcyBR3m7xB/BNx7L4eJ+57fGLTX0XOrowBOXYOA0IE
         3XKHk5F1gidLkZgpMSqMlfz7UrDwdCbfekHg4Omt2us97FGGJB7KcRymBY+W1qztng
         eekNOzJ5FtbvZpAyM3kDb2YUyeqnsXTx4UZBWx7qbGWURD08VU1LJrPjUdRMDFkbZZ
         1y6vV9CzRMJOWxVPhFcdeM2WllDY/2PKZM/hZqShYYXU5vJ1DC2NfG8tEBd+B4PZoa
         oCCp9aMKaxSyqMvU1WQM+9Hm+itF8n39T4Ji2huVNhYOKjbTi6vWfCe+sPbunPSyWx
         sknxwDr6XsLhQ==
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
Subject: [PATCH v2 3/3] tools/perf: Fix to get declared file name from clang DWARF5
Date:   Tue,  1 Nov 2022 22:48:49 +0900
Message-Id: <166731052936.2100653.13380621874859467731.stgit@devnote3>
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

Fix to get the declared file name even if it uses file index 0
in DWARF5, using custom die_get_decl_file() function.

Actually, the DWARF5 standard says file index 0 of the
DW_AT_decl_file is invalid(*), but there is a discussion and
maybe this will be updated. Anyway, the clang generates such
DWARF5 file for the linux kernel. Thus it must be handled.

Without this, the perf probe returns an error;
 $ ./perf probe -k $BIN_PATH/vmlinux -s $SRC_PATH -L vfs_read:10
 Debuginfo analysis failed.
   Error: Failed to show lines.

With this, it can handle the case correctly;
 $ ./perf probe -k $BIN_PATH/vmlinux -s $SRC_PATH -L vfs_read:10
 <vfs_read@$SRC_PATH/fs/read_write.c:10>

      11         ret = rw_verify_area(READ, file, pos, count);
      12         if (ret)
                          return ret;

(* DWARF5 specification 2.14 says "The value 0 indicates that no
source file has been specified.")
(**
http://wiki.dwarfstd.org/index.php?title=DWARF5_Line_Table_File_Numbers)

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Update description so that it is clang version of DWARF5.
---
 tools/perf/util/dwarf-aux.c    |   47 +++++++++++++++++++++++++++-------------
 tools/perf/util/dwarf-aux.h    |    3 +++
 tools/perf/util/probe-finder.c |   14 ++++++------
 3 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 216fc3d959e8..30b36b525681 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -123,7 +123,7 @@ int cu_find_lineinfo(Dwarf_Die *cu_die, Dwarf_Addr addr,
 	if (die_find_realfunc(cu_die, addr, &die_mem)
 	    && die_entrypc(&die_mem, &faddr) == 0 &&
 	    faddr == addr) {
-		*fname = dwarf_decl_file(&die_mem);
+		*fname = die_get_decl_file(&die_mem);
 		dwarf_decl_line(&die_mem, lineno);
 		goto out;
 	}
@@ -486,6 +486,19 @@ static int die_get_decl_fileno(Dwarf_Die *pdie)
 		return -ENOENT;
 }
 
+/* Return the file name by index */
+static const char *die_get_file_name(Dwarf_Die *dw_die, int idx)
+{
+	Dwarf_Die cu_die;
+	Dwarf_Files *files;
+
+	if (idx < 0 || !dwarf_diecu(dw_die, &cu_die, NULL, NULL) ||
+	    dwarf_getsrcfiles(&cu_die, &files, NULL) != 0)
+		return NULL;
+
+	return dwarf_filesrc(files, idx, NULL, NULL);
+}
+
 /**
  * die_get_call_file - Get callsite file name of inlined function instance
  * @in_die: a DIE of an inlined function instance
@@ -495,18 +508,22 @@ static int die_get_decl_fileno(Dwarf_Die *pdie)
  */
 const char *die_get_call_file(Dwarf_Die *in_die)
 {
-	Dwarf_Die cu_die;
-	Dwarf_Files *files;
-	int idx;
-
-	idx = die_get_call_fileno(in_die);
-	if (idx < 0 || !dwarf_diecu(in_die, &cu_die, NULL, NULL) ||
-	    dwarf_getsrcfiles(&cu_die, &files, NULL) != 0)
-		return NULL;
-
-	return dwarf_filesrc(files, idx, NULL, NULL);
+	return die_get_file_name(in_die, die_get_call_fileno(in_die));
 }
 
+/**
+ * die_get_decl_file - Find the declared file name of this DIE
+ * @dw_die: a DIE for something declared.
+ *
+ * Get declared file name of @dw_die.
+ * NOTE: Since some version of clang DWARF5 implementation incorrectly uses
+ * file index 0 for DW_AT_decl_file, die_get_decl_file() will return NULL for
+ * such cases. Use this function instead.
+ */
+const char *die_get_decl_file(Dwarf_Die *dw_die)
+{
+	return die_get_file_name(dw_die, die_get_decl_fileno(dw_die));
+}
 
 /**
  * die_find_child - Generic DIE search function in DIE tree
@@ -790,7 +807,7 @@ static int __die_walk_funclines_cb(Dwarf_Die *in_die, void *data)
 	}
 
 	if (addr) {
-		fname = dwarf_decl_file(in_die);
+		fname = die_get_decl_file(in_die);
 		if (fname && dwarf_decl_line(in_die, &lineno) == 0) {
 			lw->retval = lw->callback(fname, lineno, addr, lw->data);
 			if (lw->retval != 0)
@@ -818,7 +835,7 @@ static int __die_walk_funclines(Dwarf_Die *sp_die, bool recursive,
 	int lineno;
 
 	/* Handle function declaration line */
-	fname = dwarf_decl_file(sp_die);
+	fname = die_get_decl_file(sp_die);
 	if (fname && dwarf_decl_line(sp_die, &lineno) == 0 &&
 	    die_entrypc(sp_die, &addr) == 0) {
 		lw.retval = callback(fname, lineno, addr, data);
@@ -873,7 +890,7 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 	if (dwarf_tag(rt_die) != DW_TAG_compile_unit) {
 		cu_die = dwarf_diecu(rt_die, &die_mem, NULL, NULL);
 		dwarf_decl_line(rt_die, &decl);
-		decf = dwarf_decl_file(rt_die);
+		decf = die_get_decl_file(rt_die);
 		if (!decf) {
 			pr_debug2("Failed to get the declared file name of %s\n",
 				  dwarf_diename(rt_die));
@@ -928,7 +945,7 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 
 				dwarf_decl_line(&die_mem, &inl);
 				if (inl != decl ||
-				    decf != dwarf_decl_file(&die_mem))
+				    decf != die_get_decl_file(&die_mem))
 					continue;
 			}
 		}
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 7ee0fa19b5c4..7ec8bc1083bb 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -50,6 +50,9 @@ int die_get_call_lineno(Dwarf_Die *in_die);
 /* Get callsite file name of inlined function instance */
 const char *die_get_call_file(Dwarf_Die *in_die);
 
+/* Get declared file name of a DIE */
+const char *die_get_decl_file(Dwarf_Die *dw_die);
+
 /* Get type die */
 Dwarf_Die *die_get_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem);
 
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 1aa8fcc41c76..54b49ce85c9f 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -763,7 +763,7 @@ static int find_best_scope_cb(Dwarf_Die *fn_die, void *data)
 
 	/* Skip if declared file name does not match */
 	if (fsp->file) {
-		file = dwarf_decl_file(fn_die);
+		file = die_get_decl_file(fn_die);
 		if (!file || strcmp(fsp->file, file) != 0)
 			return 0;
 	}
@@ -1071,7 +1071,7 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 		return DWARF_CB_OK;
 
 	/* Check declared file */
-	fname = dwarf_decl_file(sp_die);
+	fname = die_get_decl_file(sp_die);
 	if (!fname) {
 		pr_warning("A function DIE doesn't have decl_line. Maybe broken DWARF?\n");
 		return DWARF_CB_OK;
@@ -1151,7 +1151,7 @@ static int pubname_search_cb(Dwarf *dbg, Dwarf_Global *gl, void *data)
 				return DWARF_CB_OK;
 
 			if (param->file) {
-				fname = dwarf_decl_file(param->sp_die);
+				fname = die_get_decl_file(param->sp_die);
 				if (!fname || strtailcmp(param->file, fname))
 					return DWARF_CB_OK;
 			}
@@ -1750,7 +1750,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
 			goto post;
 		}
 
-		fname = dwarf_decl_file(&spdie);
+		fname = die_get_decl_file(&spdie);
 		if (addr == baseaddr) {
 			/* Function entry - Relative line number is 0 */
 			lineno = baseline;
@@ -1787,7 +1787,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
 			}
 		}
 		/* Verify the lineno and baseline are in a same file */
-		tmp = dwarf_decl_file(&spdie);
+		tmp = die_get_decl_file(&spdie);
 		if (!tmp || (fname && strcmp(tmp, fname) != 0))
 			lineno = 0;
 	}
@@ -1902,13 +1902,13 @@ static int line_range_search_cb(Dwarf_Die *sp_die, void *data)
 
 	/* Check declared file */
 	if (lr->file) {
-		fname = dwarf_decl_file(sp_die);
+		fname = die_get_decl_file(sp_die);
 		if (!fname || strtailcmp(lr->file, fname))
 			return DWARF_CB_OK;
 	}
 
 	if (die_match_name(sp_die, lr->function) && die_is_func_def(sp_die)) {
-		lf->fname = dwarf_decl_file(sp_die);
+		lf->fname = die_get_decl_file(sp_die);
 		dwarf_decl_line(sp_die, &lr->offset);
 		pr_debug("fname: %s, lineno:%d\n", lf->fname, lr->offset);
 		lf->lno_s = lr->offset + lr->start;

