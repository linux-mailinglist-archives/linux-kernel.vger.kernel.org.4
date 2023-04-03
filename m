Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA00F6D5107
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjDCSvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjDCSvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:51:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594221BF3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:51:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p12-20020a25420c000000b00b6eb3c67574so29470090yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 11:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680547869;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zmvecUsjGJ3uQX4+hCp+ChLUFFiWRrJfULKli9lejus=;
        b=iXo7QaNo7lnOjhuvr+4xOEIYEqW7I9EsV4BAyp/h+u2o41YXT2LF59fdegZdawF79t
         /1LwgYO0ezXbRnLVMZt1vnM8W4k+0+powZif1XQ1cXcMmiT/hiws6AD36Xpb42VB7VzW
         KM/d48roEnbsgARsOlph0g+J/27ipAnZbko/Bba12bUvySpl0Ahh5qkYGDbyeoLCY/l8
         6+RDpSewGYErIp4oCCT7jpmDeNOh91QPk0VKF7LCmUz1x1Ql9C99XEyaw1LTnnU/5uHB
         OpwsNgiMh0mchCzgxjDkr9NVi1ibnsZ4uZJmCEVLw41BjKKwvjX608qJRdnrjIqDhO/+
         qo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680547869;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zmvecUsjGJ3uQX4+hCp+ChLUFFiWRrJfULKli9lejus=;
        b=D51CfLRDvKtBDB7tJUXPqQ7nO5h5W9dZW1bG0FU2erzhr72NdiYZF13Wnp48Kekcm6
         SkYpi8OBErSMEoQOa86+oq2ztPAa9hCPAHxsr+0Mcdp58KiIxgO8jF3FrYLAdeLBo+Ej
         COLn8DlI1g1ZEpqzCDuZg8pzc1P/J1SAozfDe2AX7le1xm6f81XPzgTPeoFWwoLovnkz
         I8NiAQMJuFTxAsIKOBTDiCQ7xFCF7af4zu+qjR+HaC/Q346FJqFcj+AR8Vjo22jOXI63
         e6VErlV/+j03D0H5gy/Kyd8jP+6Ge1I9CZ8btHd2UDW9x0PYnDyYV5V5jgb+XW1bXn2z
         X9ow==
X-Gm-Message-State: AAQBX9cU88zHvOQfzdYebmL2Nwt9hCVqflrOAPlWRnxEXdeAguPyOZBz
        hQ62/qTnivqVAI80BY0s1Ncyj4yGCyeB
X-Google-Smtp-Source: AKy350Z3AzvX8rv+NPBE59yNqtlhNqwWuGbBM5SLWa6awSTFI6hjDHet4AqJQ1+HUHoSonOM+YbqTAoPUdiV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9dc:a977:817d:341])
 (user=irogers job=sendgmr) by 2002:a81:ac08:0:b0:544:8ac7:2608 with SMTP id
 k8-20020a81ac08000000b005448ac72608mr17860232ywh.6.1680547869643; Mon, 03 Apr
 2023 11:51:09 -0700 (PDT)
Date:   Mon,  3 Apr 2023 11:50:57 -0700
Message-Id: <20230403185057.1844232-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1] perf jit: Fix a few memory leaks
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        Yuan Can <yuancan@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/genelf_debug.c | 48 +++++++++++++++++++++++++---------
 tools/perf/util/jitdump.c      |  7 ++++-
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
index dd40683bd4c0..bdcd37c34b64 100644
--- a/tools/perf/util/genelf_debug.c
+++ b/tools/perf/util/genelf_debug.c
@@ -87,6 +87,12 @@ buffer_ext_init(struct buffer_ext *be)
 	be->max_sz = 0;
 }
 
+static void
+buffer_ext_exit(struct buffer_ext *be)
+{
+	free(be->data);
+}
+
 static inline size_t
 buffer_ext_size(struct buffer_ext *be)
 {
@@ -494,21 +500,26 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	buffer_ext_init(&da);
 
 	ret = jit_process_debug_info(code_addr, debug, nr_debug_entries, &dl, &da, &di);
-	if (ret)
-		return -1;
+	if (ret) {
+		ret = -1;
+		goto out;
+	}
+
 	/*
 	 * setup .debug_line section
 	 */
 	scn = elf_newscn(e);
 	if (!scn) {
 		warnx("cannot create section");
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	d = elf_newdata(scn);
 	if (!d) {
 		warnx("cannot get new data");
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	d->d_align = 1;
@@ -521,7 +532,8 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	shdr = elf_getshdr(scn);
 	if (!shdr) {
 		warnx("cannot get section header");
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	shdr->sh_name = 52; /* .debug_line */
@@ -536,13 +548,15 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	scn = elf_newscn(e);
 	if (!scn) {
 		warnx("cannot create section");
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	d = elf_newdata(scn);
 	if (!d) {
 		warnx("cannot get new data");
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	d->d_align = 1;
@@ -555,7 +569,8 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	shdr = elf_getshdr(scn);
 	if (!shdr) {
 		warnx("cannot get section header");
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	shdr->sh_name = 64; /* .debug_info */
@@ -570,13 +585,15 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	scn = elf_newscn(e);
 	if (!scn) {
 		warnx("cannot create section");
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	d = elf_newdata(scn);
 	if (!d) {
 		warnx("cannot get new data");
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	d->d_align = 1;
@@ -589,7 +606,8 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	shdr = elf_getshdr(scn);
 	if (!shdr) {
 		warnx("cannot get section header");
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	shdr->sh_name = 76; /* .debug_info */
@@ -603,7 +621,11 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	 */
 	if (elf_update(e, ELF_C_WRITE) < 0) {
 		warnx("elf_update debug failed");
-		return -1;
+		ret = -1;
 	}
-	return 0;
+out:
+	buffer_ext_exit(&dl);
+	buffer_ext_exit(&di);
+	buffer_ext_exit(&da);
+	return ret;
 }
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 0e033278fa12..28e49502db5e 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -235,9 +235,11 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 	 */
 	strcpy(jd->dir, name);
 	dirname(jd->dir);
+	free(buf);
 
 	return 0;
 error:
+	free(buf);
 	funlockfile(jd->in);
 	fclose(jd->in);
 	return retval;
@@ -523,7 +525,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 
 	ret = perf_event__process_mmap2(tool, event, &sample, jd->machine);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = jit_inject_event(jd, event);
 	/*
@@ -532,6 +534,8 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 	if (!ret)
 		build_id__mark_dso_hit(tool, event, &sample, NULL, jd->machine);
 
+out:
+	free(event);
 	return ret;
 }
 
@@ -874,6 +878,7 @@ jit_process(struct perf_session *session,
 	}
 
 	nsinfo__put(jd.nsi);
+	free(jd.buf);
 
 	return ret;
 }
-- 
2.40.0.348.gf938b09366-goog

