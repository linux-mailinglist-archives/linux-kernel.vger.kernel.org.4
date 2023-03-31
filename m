Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BA86D2973
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjCaU37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCaU3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:29:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04151A96F;
        Fri, 31 Mar 2023 13:29:53 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id z19so22399376plo.2;
        Fri, 31 Mar 2023 13:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680294593; x=1682886593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLhh5lXY8mRzGTGozorwCPHUrnN37AS+DlWp1fZ57Ms=;
        b=PvobSiVqjZzQJUcSIk/NI+SPYWuV2Nz3Hlt7g2jd0iCPqdnUnbU4PzRkNpdH8c+u+Y
         1cF6Dx8r6hPGf3zgke+nPrA38Mdn94Fd/UIUv4HagZUVxHlYCm9tpty+nCLy234NXqOB
         Ig4bFULimXNrEzcgbLkHvZw1u0qZUEjVcFVcL2MOX0aYd8mqv/8gX9+8Fv1VGS3itjwn
         c7KuhQuUAo6wVAYBnby5flX3cJwP7Cj9u/oX8s8ifF2r5FSFcnBHTXb+37aRDxA92QUd
         nOCPk7W1PiEEetdSDpEnQWM1MABcTe3PPeY/jDoonJEWRThpWnvSqHDsfURWjzogKkCG
         c2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680294593; x=1682886593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PLhh5lXY8mRzGTGozorwCPHUrnN37AS+DlWp1fZ57Ms=;
        b=RPOFpK+UKSl6sHW0u2BF6jcrc9RSongPPkH/g77e7r6CLKnZe/59dtfktRe/5z1a3C
         nPOb57BqZtl0D6RW29wZD7zoqi5TuCv0jiN73ppjv1+B4qFdK+VfrAlStB6dAfB3Kwhh
         P6EeVzmve3aXj3maK21HOwAmow09IdEG1yhcb4dS8P5ey1HME7f3r9NsfmM6cRvojry1
         P0+qIa3GNEmH2Ku77di5dWg0YsiXOVaNvbc1xis9IwKdWEHcZP/07uWCN1dfSjoQ0ov5
         LbYZEzlr/atA000fJJRdzeQC2+RAQeYBHkRhnodkVQohVuNXnS7BydVsR/67FKKSP76c
         pcXw==
X-Gm-Message-State: AAQBX9dcpHmGN0XMj+egaKuMz7tFugjQtteA83q6hXUcWPw+Z1Mfwldb
        YU9hKFJrbKo6P/p/TPlkGJc=
X-Google-Smtp-Source: AKy350btZovMwuvH45elymxAvNu1RTnI3xj0P4HEgarw/FzpW8DFFHE6reVTElr7E3AeK3aefC6mUA==
X-Received: by 2002:a17:903:2290:b0:1a1:a727:a802 with SMTP id b16-20020a170903229000b001a1a727a802mr11880427plh.19.1680294593101;
        Fri, 31 Mar 2023 13:29:53 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:44b0:5cfb:ad2c:e6f5:d42f])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001a1dc2be791sm1916803plo.259.2023.03.31.13.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:29:52 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 1/9] perf list: Use relative path for tracepoint scan
Date:   Fri, 31 Mar 2023 13:29:41 -0700
Message-Id: <20230331202949.810326-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331202949.810326-1-namhyung@kernel.org>
References: <20230331202949.810326-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/print-events.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 62e9ea7dcf40..26a7e017c928 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -4,6 +4,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <fcntl.h>
 #include <sys/param.h>
 
 #include <api/fs/tracing_path.h>
@@ -59,12 +60,20 @@ static const struct event_symbol event_symbols_tool[PERF_TOOL_MAX] = {
 void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	struct dirent **sys_namelist = NULL;
+	char *events_path = get_tracing_file("events");
 	int sys_items = tracing_events__scandir_alphasort(&sys_namelist);
+	int events_fd = open(events_path, O_PATH);
+
+	put_tracing_file(events_path);
+	if (events_fd < 0) {
+		printf("Error: failed to open tracing events directory\n");
+		return;
+	}
 
 	for (int i = 0; i < sys_items; i++) {
 		struct dirent *sys_dirent = sys_namelist[i];
 		struct dirent **evt_namelist = NULL;
-		char *dir_path;
+		int dir_fd;
 		int evt_items;
 
 		if (sys_dirent->d_type != DT_DIR ||
@@ -72,22 +81,26 @@ void print_tracepoint_events(const struct print_callbacks *print_cb, void *print
 		    !strcmp(sys_dirent->d_name, ".."))
 			continue;
 
-		dir_path = get_events_file(sys_dirent->d_name);
-		if (!dir_path)
+		dir_fd = openat(events_fd, sys_dirent->d_name, O_PATH);
+		if (dir_fd < 0)
 			continue;
 
-		evt_items = scandir(dir_path, &evt_namelist, NULL, alphasort);
+		evt_items = scandirat(events_fd, sys_dirent->d_name, &evt_namelist, NULL, alphasort);
 		for (int j = 0; j < evt_items; j++) {
 			struct dirent *evt_dirent = evt_namelist[j];
 			char evt_path[MAXPATHLEN];
+			int evt_fd;
 
 			if (evt_dirent->d_type != DT_DIR ||
 			    !strcmp(evt_dirent->d_name, ".") ||
 			    !strcmp(evt_dirent->d_name, ".."))
 				continue;
 
-			if (tp_event_has_id(dir_path, evt_dirent) != 0)
+			snprintf(evt_path, sizeof(evt_path), "%s/id", evt_dirent->d_name);
+			evt_fd = openat(dir_fd, evt_path, O_RDONLY);
+			if (evt_fd < 0)
 				continue;
+			close(evt_fd);
 
 			snprintf(evt_path, MAXPATHLEN, "%s:%s",
 				 sys_dirent->d_name, evt_dirent->d_name);
@@ -103,10 +116,11 @@ void print_tracepoint_events(const struct print_callbacks *print_cb, void *print
 					/*long_desc=*/NULL,
 					/*encoding_desc=*/NULL);
 		}
-		free(dir_path);
+		close(dir_fd);
 		free(evt_namelist);
 	}
 	free(sys_namelist);
+	close(events_fd);
 }
 
 void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
-- 
2.40.0.348.gf938b09366-goog

