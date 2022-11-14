Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3C5628B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbiKNVIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiKNVI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:08:27 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449D7B5D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:08:24 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i19-20020a63e913000000b004705d1506a6so6390324pgh.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAjkIdGz/j9kJ1xDL5dYREJTueL8AT+RXQYxwRGY3ak=;
        b=FQaZu3Cbsd2gHnYi5Gx+2DWoUegFSW+qx8oogpEOsCl0/itsxpNpL6S4L435rIus3u
         q6b3Ob2ArneyTeF0HA+YgEFmbvuDtumr1ySUmpoIIs10e/TfKb/wxXOvpbDlrTyhbOhq
         XHOyWp/5FngUxk72sQjlstVXlwRWYDUyo3omNZgRnkD0XaUi4OGDXcIMbYfJjvKLlzGe
         ymzdCAvMa9dZG53WnXm49bUsYWPufMfzD355LyDc/gdh2TuDHlhuiUwmEjUjeeYOijs2
         1HIlBxJy6UzLN9xOmiR/Hyk0xKXUFEsAbmRtdqoOUfJSCQkucg8x5AqsWJXJhRpCRS/q
         HPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAjkIdGz/j9kJ1xDL5dYREJTueL8AT+RXQYxwRGY3ak=;
        b=WJ59a0rcHtY+LEuB0YdDCY6CjoNKQ3cPnZRyRK4Sjgj7iCNgusisvZOtXsQe8pwJlg
         IWB3uBigYm6TpCAU+jCIJ1NVJ4ytCxA5KDPOW1qGSeQH5sgK8j1AreI2FwjOv3gzyoN4
         a6IXSEKCxEntvsrVYkYVcf+ZY0A39IK/5IyX8RzV4F6V7imVpamXcXDoyvFiJL3A7hzq
         K9Iin48My5n7zYBMlzIu0Y1AqeILXh076zLWrqoSv6hQ4j8UURCkgAawToygSETUNqD+
         63FVOXqgapAzBS0kZuerKSbPFA25s4oO+z/5+Yjy0GZ73zosrOWD86/knSoxQbxoNVaS
         V9DA==
X-Gm-Message-State: ANoB5pm/0qZXlrojApMiw9f/PottB/WKzNQoYmIVCZwazqnbBfxmtSev
        JH9cyPEpRWG/R9Q2fkBhVbWSUpWy/yht
X-Google-Smtp-Source: AA0mqf6QC+uDVb70Ja2JWAOwMKIY4s1K9yHM1jmnHAtZGlRo7JIauPQOl9tuqc43FoffxWFIbjbvw08OzAag
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a17:90b:2415:b0:212:cf2e:2b0b with SMTP id
 nr21-20020a17090b241500b00212cf2e2b0bmr15213568pjb.169.1668460104133; Mon, 14
 Nov 2022 13:08:24 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:07:17 -0800
In-Reply-To: <20221114210723.2749751-1-irogers@google.com>
Message-Id: <20221114210723.2749751-5-irogers@google.com>
Mime-Version: 1.0
References: <20221114210723.2749751-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v3 04/10] perf tracepoint: Sort events in iterator
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In print_tracepoint_events use tracing_events__scandir_alphasort and
scandir alphasort so that the subsystem and events are sorted and
don't need a secondary qsort. Locally this results in the following
change:

...
   ext4:ext4_zero_range                               [Tracepoint event]
-  fib6:fib6_table_lookup                             [Tracepoint event]
   fib:fib_table_lookup                               [Tracepoint event]
+  fib6:fib6_table_lookup                             [Tracepoint event]
   filelock:break_lease_block                         [Tracepoint event]
...

ie fib6 now is after fib and not before it. This is more consistent
with how numbers are more generally sorted, such as:

...
  syscalls:sys_enter_renameat                        [Tracepoint event]
  syscalls:sys_enter_renameat2                       [Tracepoint event]
...

and so an improvement over the qsort approach.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print-events.c | 108 +++++++++++----------------------
 1 file changed, 37 insertions(+), 71 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index c4d5d87fae2f..fefc025bc259 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -66,26 +66,21 @@ static int cmp_string(const void *a, const void *b)
 void print_tracepoint_events(const char *subsys_glob,
 			     const char *event_glob, bool name_only)
 {
-	DIR *sys_dir, *evt_dir;
-	struct dirent *sys_dirent, *evt_dirent;
-	char evt_path[MAXPATHLEN];
-	char *dir_path;
-	char **evt_list = NULL;
-	unsigned int evt_i = 0, evt_num = 0;
-	bool evt_num_known = false;
-
-restart:
-	sys_dir = tracing_events__opendir();
-	if (!sys_dir)
-		return;
-
-	if (evt_num_known) {
-		evt_list = zalloc(sizeof(char *) * evt_num);
-		if (!evt_list)
-			goto out_close_sys_dir;
-	}
+	struct dirent **sys_namelist = NULL;
+	bool printed = false;
+	int sys_items = tracing_events__scandir_alphasort(&sys_namelist);
+
+	for (int i = 0; i < sys_items; i++) {
+		struct dirent *sys_dirent = sys_namelist[i];
+		struct dirent **evt_namelist = NULL;
+		char *dir_path;
+		int evt_items;
+
+		if (sys_dirent->d_type != DT_DIR ||
+		    !strcmp(sys_dirent->d_name, ".") ||
+		    !strcmp(sys_dirent->d_name, ".."))
+			continue;
 
-	for_each_subsystem(sys_dir, sys_dirent) {
 		if (subsys_glob != NULL &&
 		    !strglobmatch(sys_dirent->d_name, subsys_glob))
 			continue;
@@ -93,69 +88,40 @@ void print_tracepoint_events(const char *subsys_glob,
 		dir_path = get_events_file(sys_dirent->d_name);
 		if (!dir_path)
 			continue;
-		evt_dir = opendir(dir_path);
-		if (!evt_dir)
-			goto next;
 
-		for_each_event(dir_path, evt_dir, evt_dirent) {
-			if (event_glob != NULL &&
-			    !strglobmatch(evt_dirent->d_name, event_glob))
+		evt_items = scandir(dir_path, &evt_namelist, NULL, alphasort);
+		for (int j = 0; j < evt_items; j++) {
+			struct dirent *evt_dirent = evt_namelist[j];
+			char evt_path[MAXPATHLEN];
+
+			if (evt_dirent->d_type != DT_DIR ||
+			    !strcmp(evt_dirent->d_name, ".") ||
+			    !strcmp(evt_dirent->d_name, ".."))
 				continue;
 
-			if (!evt_num_known) {
-				evt_num++;
+			if (tp_event_has_id(dir_path, evt_dirent) != 0)
+				continue;
+
+			if (event_glob != NULL &&
+			    !strglobmatch(evt_dirent->d_name, event_glob))
 				continue;
-			}
 
 			snprintf(evt_path, MAXPATHLEN, "%s:%s",
 				 sys_dirent->d_name, evt_dirent->d_name);
-
-			evt_list[evt_i] = strdup(evt_path);
-			if (evt_list[evt_i] == NULL) {
-				put_events_file(dir_path);
-				goto out_close_evt_dir;
+			if (name_only)
+				printf("%s ", evt_path);
+			else {
+				printf("  %-50s [%s]\n", evt_path,
+				       event_type_descriptors[PERF_TYPE_TRACEPOINT]);
 			}
-			evt_i++;
+			printed = true;
 		}
-		closedir(evt_dir);
-next:
-		put_events_file(dir_path);
+		free(dir_path);
+		free(evt_namelist);
 	}
-	closedir(sys_dir);
-
-	if (!evt_num_known) {
-		evt_num_known = true;
-		goto restart;
-	}
-	qsort(evt_list, evt_num, sizeof(char *), cmp_string);
-	evt_i = 0;
-	while (evt_i < evt_num) {
-		if (name_only) {
-			printf("%s ", evt_list[evt_i++]);
-			continue;
-		}
-		printf("  %-50s [%s]\n", evt_list[evt_i++],
-				event_type_descriptors[PERF_TYPE_TRACEPOINT]);
-	}
-	if (evt_num && pager_in_use())
+	free(sys_namelist);
+	if (printed && pager_in_use())
 		printf("\n");
-
-out_free:
-	evt_num = evt_i;
-	for (evt_i = 0; evt_i < evt_num; evt_i++)
-		zfree(&evt_list[evt_i]);
-	zfree(&evt_list);
-	return;
-
-out_close_evt_dir:
-	closedir(evt_dir);
-out_close_sys_dir:
-	closedir(sys_dir);
-
-	printf("FATAL: not enough memory to print %s\n",
-			event_type_descriptors[PERF_TYPE_TRACEPOINT]);
-	if (evt_list)
-		goto out_free;
 }
 
 void print_sdt_events(const char *subsys_glob, const char *event_glob,
-- 
2.38.1.431.g37b22c650d-goog

