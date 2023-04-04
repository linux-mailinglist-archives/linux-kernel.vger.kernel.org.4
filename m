Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA536D6A4B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbjDDRTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbjDDRTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:19:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A37D1989
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:19:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 205-20020a2503d6000000b00b7411408308so32285151ybd.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680628748;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nGBT7J3oxLrG5QlbQBZ8ar3G9Xp4yDpuulB1s81czW0=;
        b=LiBYzhWDYHduL8RDjlTCgCej44cBeYg5yDH294/Bm6SOX/UwkJHyFMjHqHLQckj9tJ
         ajqbzPP4APlekP8ORSlTD8dGfj0xIUk9L+F0SMG05QeUa+KdEwpI9dwxtimwR6M/K8tp
         Bmu7GomNrjrKWfWKsfLce6YKwRztSfrzoJzzYnNmkur0xzXZ6/AO6JDeguhsrXcAUV0Y
         H2FjPNiXFkJDTPv/fxBh8tNLSqc+iiiKJypLr2qPu4DGP6hhVr1y4lATuJDS0bu55RTP
         d+iBTQcLAbRWN75bXasqq+bpqIzRVvlv6k6PNlrMwy35zwoZW3x5hCDFCV0JArAa89/Q
         3CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628748;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGBT7J3oxLrG5QlbQBZ8ar3G9Xp4yDpuulB1s81czW0=;
        b=DNAYiGbY6D+u3XH/ssCyumoM/IJCboOwi7+kYVQKPohZmAW6R727prqQ/d2QHKGHnz
         pI0sihdw32A6nd8YPXERYGxGGduJXQ9zFHq0JXyJezT/6aAs+6SUnLGooEnQnVmdxhYv
         XwzuzblHlLX9x0/c5/oxQ8J1w2Yx45SStAzwhNY6Xkaqrg/oX2Cn/OQXIq4hBrbbLdoP
         r8c3AWa7b8opVREUsoWn8k9bd5JPhNy+oD5HZDjD7cZM2q6Vk2vS/E9nrq78f3ecN161
         6dTo307YDOnXp9h/WRgtVmX9JDUgSizmEJYDzifuQLUOG+Dw7JC97jtrBkwr/SE2o68C
         Y3xA==
X-Gm-Message-State: AAQBX9fZP5SOuyLorM+tcDbqTn+3vU3vIujUzSTeydCp/7wb2o51oLcx
        Hb++qvpDzgL0b0+QAri3Ctd9F0EtK6sG
X-Google-Smtp-Source: AKy350bgvTjKs5YgA/5EtiXu6Vb2/j9rN2qxfJT/xXdB7KcDKJSGeK6tv3dXeWjYQNUekPpAn3Hx8uC9b7Ye
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a051:e074:d6f:dc29])
 (user=irogers job=sendgmr) by 2002:a81:b309:0:b0:545:7b92:2890 with SMTP id
 r9-20020a81b309000000b005457b922890mr1981501ywh.7.1680628748706; Tue, 04 Apr
 2023 10:19:08 -0700 (PDT)
Date:   Tue,  4 Apr 2023 10:19:05 -0700
Message-Id: <20230404171905.415910-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v1] perf list: Allow listing of just libpfm4 events
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

If libpfm4 is supported then add 'perf list pfm' to list just the
libpfm4 events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 76e1d31a68ee..a60fe91d4b40 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -15,6 +15,7 @@
 #include "util/pmu-hybrid.h"
 #include "util/debug.h"
 #include "util/metricgroup.h"
+#include "util/pfm.h"
 #include "util/string2.h"
 #include "util/strlist.h"
 #include "util/strbuf.h"
@@ -452,7 +453,11 @@ int cmd_list(int argc, const char **argv)
 		OPT_END()
 	};
 	const char * const list_usage[] = {
+#ifdef HAVE_LIBPFM
+		"perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|event_glob|pfm]",
+#else
 		"perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|event_glob]",
+#endif
 		NULL
 	};
 
@@ -529,7 +534,12 @@ int cmd_list(int argc, const char **argv)
 			default_ps.metricgroups = true;
 			default_ps.metrics = false;
 			metricgroup__print(&print_cb, ps);
-		} else if ((sep = strchr(argv[i], ':')) != NULL) {
+		}
+#ifdef HAVE_LIBPFM
+		else if (strcmp(argv[i], "pfm") == 0)
+			print_libpfm_events(&print_cb, ps);
+#endif
+		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			char *old_pmu_glob = default_ps.pmu_glob;
 
 			default_ps.event_glob = strdup(argv[i]);
-- 
2.40.0.577.gac1e443424-goog

