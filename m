Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DA8728BB1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbjFHXYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjFHXYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:24:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B51E30D5;
        Thu,  8 Jun 2023 16:24:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-652dd220d67so1170519b3a.3;
        Thu, 08 Jun 2023 16:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686266644; x=1688858644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjeLkyzQBXDMmpW+mv6gsgImE+Yu4bQUfqrg+TqZuYQ=;
        b=ibE9O4dYS1ra4OHX4kutCOvMuID0Kg1allAnNGKK7d7R/qu9abP0f7h2svtYDkhnMm
         bdABXieXA739dpn2o0zTSAI/NcVbO6gashW4K3+EaLqhPjZ7nlPCaa5kYKJoKokOBnBK
         terliYL8Lw+RoQyGSt6I7CkUnbKfM31IgCkrLXF6TwMYtDDbU1A2yWk0OsDHnSBl1tQo
         XJnrwA0ubqGIeM3nIL97/sC7E5L0vXSC5wXWXw6QlDkdGc3PqKy+JTdEgOoc/ZdqibjV
         qfEdUgInntX6zr3dnUHX7YM16yzZmGG/uNYwyaV+0v7HabN+o1lJ50dpgR367Qa2LESD
         Zg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266644; x=1688858644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kjeLkyzQBXDMmpW+mv6gsgImE+Yu4bQUfqrg+TqZuYQ=;
        b=ABVrpVPtxUpHTVgRULyoxpMxJY9hG+215P/TNsxvfqQwczsgxWHUharX7ik2pfQ/VH
         s55bj0mqKDbKeHI5yhw0Mm8G95sIYNnq3n+6FxNHi9OuYObrVHbi2b56SnCiQkD2cWhn
         chIT3evKABCWUhIFVXsVH5E3CkP8HQX3zbibbXZKA8nVfqtkL5fVO5w923++IMeVJYnW
         R76W9yT53E8miOWbNA1sM16lO98e81IyTbRVdsQVMMddmR6a5N6SN3qSw0lN4sS12I2A
         M4mZ2kIeEAHqxdrGC+eTBVt1Hx84kuBH0y0CFQMQgaSnimuGR0ZoQw/RBwZvae5v+9R1
         UfTg==
X-Gm-Message-State: AC+VfDwj2PBAWDhit9gAeUCnRl2F+70FGbnpkweJdQ8v4b4uQ5P/5W/s
        heY2E3apjs1sUdyqraF5mMg=
X-Google-Smtp-Source: ACHHUZ56HF4mrC1wuxfo6zs6P/vtng2zGHyWFeNeC9/6vGJOUA7S0uNad0wr6sX9JS52h9bU+59DLQ==
X-Received: by 2002:a05:6a21:7883:b0:10f:be0:4dce with SMTP id bf3-20020a056a21788300b0010f0be04dcemr9864782pzc.8.1686266644383;
        Thu, 08 Jun 2023 16:24:04 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:c14c:6e39:cb7d:ad66])
        by smtp.gmail.com with ESMTPSA id e18-20020a656792000000b0053f1d55676fsm1618203pgr.2.2023.06.08.16.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 16:24:04 -0700 (PDT)
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
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 2/3] perf list: Check arguments to show libpfm4 events
Date:   Thu,  8 Jun 2023 16:23:59 -0700
Message-ID: <20230608232400.3056312-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230608232400.3056312-1-namhyung@kernel.org>
References: <20230608232400.3056312-1-namhyung@kernel.org>
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

From: Ian Rogers <irogers@google.com>

This is particularly useful for tests.

  $ perf list pfm

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-list.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 03b5d26b2489..7fec2cca759f 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -15,6 +15,7 @@
 #include "util/pmu.h"
 #include "util/debug.h"
 #include "util/metricgroup.h"
+#include "util/pfm.h"
 #include "util/string2.h"
 #include "util/strlist.h"
 #include "util/strbuf.h"
@@ -457,7 +458,11 @@ int cmd_list(int argc, const char **argv)
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
 
@@ -539,7 +544,12 @@ int cmd_list(int argc, const char **argv)
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
2.41.0.162.gfafddb0af9-goog

