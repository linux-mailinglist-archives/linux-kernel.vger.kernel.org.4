Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1945C6A8BC4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCBWZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjCBWZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:25:48 -0500
Received: from mail-oi1-x24a.google.com (mail-oi1-x24a.google.com [IPv6:2607:f8b0:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029351EBDC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:25:48 -0800 (PST)
Received: by mail-oi1-x24a.google.com with SMTP id cb5-20020a056808320500b003848c5da32eso234569oib.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 14:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677795947;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dvqLbFbIa5Th4hLVJzIhGZ3VgrtC26zZgF3M8vwaoio=;
        b=rZijt3Yx2sv0qazNjKmSENaCWQCuL6oHZlInKQisJCAXXyB9MBoew7x24yXzFFX6/X
         fOLNPR4rafmVmS+2FYLhTMIhHiTK9tMZxKx4IjI17mq3VGV2WVOPSSUfLrz9pnPkW+Qn
         Xr/kUsibWvHj+pNRYUfqNCxhO92tr3UsOpw0C/Kv7PZmUAQP0i0u46TEbAqOV1yUTxzn
         Ic77SNqoY80nyCHMoi3tJ8OnegCAC8EoqIjm5lRLDoaiB8+Y0/Ea63LNEq3YIsOB47Jh
         T1wLvaqXTYe+Vw5nX+4KBclL42tHjdUkRVx1gf43glaD62/ZwQ+XHxoFKD6FdQRCan2f
         jrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677795947;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvqLbFbIa5Th4hLVJzIhGZ3VgrtC26zZgF3M8vwaoio=;
        b=l+AF4ifHLqyXoH5cdimwV4d8p7zuf6PGi9ZOuA/juXs9TUt4W9qnD62o+vog/H9f8b
         PqydA1LMlyxrdZYnXYPHjZxm2XVifYblqbtk5yaF1EBicrNe/GflQitamHzXZR/cBuj2
         V1menqs3OiZCEuDfy0mT6zRkYZk2OB3V4KEccLtGXORnwfCQkT1TKmInEihsIEICAsIv
         2wZL17AVwtIjlZJ8Q0VvAHYYz9lqIZBkJLjI9F3ycEkleo9lZxOEMI1BmIAHQx0+Fn3T
         ZlAkgHIcmnkt8etoRrKoE4FawVSFzmZLWYhG/CZUi1gbtoBCBWiVonkYF1bzJzHpGEDV
         NuDw==
X-Gm-Message-State: AO0yUKXhud3wgzSRZDHq4UfJmEE7h8tIBNM5vS5ml+adO0Qwrk5+P3te
        P0qg+ogv1aScfKzSWqokxebXx14HVkI1
X-Google-Smtp-Source: AK7set/77hq2nbjz3JZillK85E2ztOk6/zaHwTy51JirFxWAWfnzXGB75tCD+P3ovof7qkUcsCy8lqK3pepL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5f50:6ef4:b4d0:568e])
 (user=irogers job=sendgmr) by 2002:a05:6902:101:b0:a4e:4575:f3ec with SMTP id
 o1-20020a056902010100b00a4e4575f3ecmr5273607ybh.0.1677792363948; Thu, 02 Mar
 2023 13:26:03 -0800 (PST)
Date:   Thu,  2 Mar 2023 13:25:23 -0800
In-Reply-To: <20230302212531.1043318-1-irogers@google.com>
Message-Id: <20230302212531.1043318-3-irogers@google.com>
Mime-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 02/10] perf stat: Don't remove all grouped events when CPU
 maps disagree
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the events in an evlist's CPU map differ then the entire group is
removed. For example:

```
$ perf stat -e '{imc_free_running/data_read/,imc_free_running/data_write/,cs}' -a sleep 1
WARNING: grouped events cpus do not match, disabling group:
  anon group { imc_free_running/data_read/, imc_free_running/data_write/, cs }
```

Change the behavior so that just the events not matching the leader
are removed. So in the example above, just 'cs' will be removed.

Modify the warning so that it is produced once for each group, rather
than once for the entire evlist. Shrink the scope and size of the
warning text buffer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d70b1ec88594..5c12ae5efce5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -181,14 +181,13 @@ static bool cpus_map_matched(struct evsel *a, struct evsel *b)
 
 static void evlist__check_cpu_maps(struct evlist *evlist)
 {
-	struct evsel *evsel, *pos, *leader;
-	char buf[1024];
+	struct evsel *evsel, *warned_leader = NULL;
 
 	if (evlist__has_hybrid(evlist))
 		evlist__warn_hybrid_group(evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
-		leader = evsel__leader(evsel);
+		struct evsel *leader = evsel__leader(evsel);
 
 		/* Check that leader matches cpus with each member. */
 		if (leader == evsel)
@@ -197,19 +196,26 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 			continue;
 
 		/* If there's mismatch disable the group and warn user. */
-		WARN_ONCE(1, "WARNING: grouped events cpus do not match, disabling group:\n");
-		evsel__group_desc(leader, buf, sizeof(buf));
-		pr_warning("  %s\n", buf);
-
+		if (warned_leader != leader) {
+			char buf[200];
+
+			pr_warning("WARNING: grouped events cpus do not match.\n"
+				"Events with CPUs not matching the leader will "
+				"be removed from the group.\n");
+			evsel__group_desc(leader, buf, sizeof(buf));
+			pr_warning("  %s\n", buf);
+			warned_leader = leader;
+		}
 		if (verbose > 0) {
+			char buf[200];
+
 			cpu_map__snprint(leader->core.cpus, buf, sizeof(buf));
 			pr_warning("     %s: %s\n", leader->name, buf);
 			cpu_map__snprint(evsel->core.cpus, buf, sizeof(buf));
 			pr_warning("     %s: %s\n", evsel->name, buf);
 		}
 
-		for_each_group_evsel(pos, leader)
-			evsel__remove_from_group(pos, leader);
+		evsel__remove_from_group(evsel, leader);
 	}
 }
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

