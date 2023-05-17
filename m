Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5E0706CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjEQP3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjEQP2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:28:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D1A358B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:27:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba2b9ecfadaso1516116276.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684337236; x=1686929236;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xo70dYhEcfCgGbPC8sbOAVfsz7lHN99PYmfDYjMXA94=;
        b=gMdU4bD322wqDMNV9koAXPHXH4hb6CTWBdlu2bSu8PZ+49NpgyircVTQrcqIugyIE9
         nyRShtcUk5GWNZd+1iaoN0UTkPQ3vbFSuQSDAr8MhWFmYxWlh+gEkSBW658rmpymPsgV
         xaG1OZnEhLxZbcZ1KnsDoz99oXvcvrmpWy+Zn7MtLbAupJ6nK9jdn9AO48MAE+IqokpJ
         R+RYO9WY5SizzzLeVWGOirbQQATb4zhFKibq6cjI2NLHgpwd+965IGZB5eKftUCilKPG
         +OMQSZDvucSRQQSQRMZvMF8ZPs36QK28LgbyL46cLmkaOX9qKaNrHUDoQ3QE+Nc6LFMg
         a3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684337236; x=1686929236;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xo70dYhEcfCgGbPC8sbOAVfsz7lHN99PYmfDYjMXA94=;
        b=bSRdeRlevvAfwNu3FSxhQUAknStLTfYkZgA8HRwNU7DfyBhzeYZjrwvunp3Ytujxsv
         ygLZtBEMWq8jYOPSY6iZIBTXKJAVkK5ZdhJsBby2kz6jIr/3INe9j8Jf/7g0NwzWzHsv
         sGfFiEw+B8eps0gc6PR3vc/46VniZOI8lKfcZrRwUiPeUBnDO8yFRjZiOGfBAw4T7dxO
         UDhUMqa109mvff349IRn27b793ot5k6fO/Yc2CRrInf/nyWijU5JNHN7ZNs2rYtspz4s
         8T9dgWG5VZePhsRplHOxqXmhDSoQ+8198qTjufxBtQSU2X6ylriRj7WIpnHk6wsbFQ7x
         cYkA==
X-Gm-Message-State: AC+VfDwTDNQoh/5DN78PKeKcBt6uFJnrD1qUVGRQKa185yS3FBy3kGBK
        7zVXrG1yAlDMfZ32FV+od3LERta1vVaw
X-Google-Smtp-Source: ACHHUZ6Hm9l39kcH6VLHakbh3lCn8HOFPikxtQaLmOcYle3x646+kRdIUtZ54VrtsXlGYXuIPAgcM7d3A32z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a25:ab84:0:b0:ba8:337a:d8a3 with SMTP id
 v4-20020a25ab84000000b00ba8337ad8a3mr3114681ybi.11.1684337236726; Wed, 17 May
 2023 08:27:16 -0700 (PDT)
Date:   Wed, 17 May 2023 08:26:25 -0700
In-Reply-To: <20230517152626.563559-1-irogers@google.com>
Message-Id: <20230517152626.563559-15-irogers@google.com>
Mime-Version: 1.0
References: <20230517152626.563559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v2 14/15] perf jevents: Add support for metricgroup descriptions
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
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Metrics have a field where the groups they belong to are listed like
the following from
tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json:

        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
        "MetricName": "tma_frontend_bound",

The metric groups are shown in 'perf list' like the following where
TopdownL1 is a metric group:

TopdownL1:
  tma_backend_bound
       [This category represents fraction of slots where no uops are being
        delivered due to a lack of required resources for accepting new uops
        in the Backend]
  tma_bad_speculation
       [This category represents fraction of slots wasted due to incorrect
        speculations]
  tma_frontend_bound
       [This category represents fraction of slots where the processor's
        Frontend undersupplies its Backend]
  tma_retiring
       [This category represents fraction of slots utilized by useful work
        i.e. issued uops that eventually get retired]

This patch adds support for a new json file in each model directory
called metricgroups.json that comprises a dictionary containing
entries that map from a metric group to a description:

{
...
    "TopdownL1": "Metrics for top-down breakdown at level 1",
...
}

perf list is then updated to support this changing the above output
to:

TopdownL1: [Metrics for top-down breakdown at level 1]
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c                | 11 ++++--
 tools/perf/pmu-events/empty-pmu-events.c |  5 +++
 tools/perf/pmu-events/jevents.py         | 49 +++++++++++++++++++++++-
 tools/perf/pmu-events/pmu-events.h       |  2 +
 4 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index c6bd0aa4a56e..e8520a027b45 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -192,9 +192,14 @@ static void default_print_metric(void *ps,
 		if (group && print_state->metricgroups) {
 			if (print_state->name_only)
 				printf("%s ", group);
-			else if (print_state->metrics)
-				printf("\n%s:\n", group);
-			else
+			else if (print_state->metrics) {
+				const char *gdesc = describe_metricgroup(group);
+
+				if (gdesc)
+					printf("\n%s: [%s]\n", group, gdesc);
+				else
+					printf("\n%s:\n", group);
+			} else
 				printf("%s\n", group);
 		}
 		zfree(&print_state->last_metricgroups);
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index e74defb5284f..a630c617e879 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -420,3 +420,8 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn __maybe_unused, void *data __m
 {
 	return 0;
 }
+
+const char *describe_metricgroup(const char *group __maybe_unused)
+{
+	return NULL;
+}
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 487ff01baf1b..8fca7c9adee0 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -37,6 +37,8 @@ _pending_metrics = []
 _pending_metrics_tblname = None
 # Global BigCString shared by all structures.
 _bcs = None
+# Map from the name of a metric group to a description of the group.
+_metricgroups = {}
 # Order specific JsonEvent attributes will be visited.
 _json_event_attributes = [
     # cmp_sevent related attributes.
@@ -512,6 +514,17 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if not item.is_file() or not item.name.endswith('.json'):
     return
 
+  if item.name == 'metricgroups.json':
+    metricgroup_descriptions = json.load(open(item.path))
+    for mgroup in metricgroup_descriptions:
+      assert len(mgroup) > 1, parents
+      description = f"{metricgroup_descriptions[mgroup]}\\000"
+      mgroup = f"{mgroup}\\000"
+      _bcs.add(mgroup)
+      _bcs.add(description)
+      _metricgroups[mgroup] = description
+    return
+
   topic = get_topic(item.name)
   for event in read_json_events(item.path, topic):
     if event.name:
@@ -548,7 +561,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
   # Ignore other directories. If the file name does not have a .json
   # extension, ignore it. It could be a readme.txt for instance.
-  if not item.is_file() or not item.name.endswith('.json'):
+  if not item.is_file() or not item.name.endswith('.json') or item.name == 'metricgroups.json':
     return
 
   add_events_table_entries(item, get_topic(item.name))
@@ -911,6 +924,38 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data)
 }
 """)
 
+def print_metricgroups() -> None:
+  _args.output_file.write("""
+static const int metricgroups[][2] = {
+""")
+  for mgroup in sorted(_metricgroups):
+    description = _metricgroups[mgroup]
+    _args.output_file.write(
+        f'\t{{ {_bcs.offsets[mgroup]}, {_bcs.offsets[description]} }}, /* {mgroup} => {description} */\n'
+    )
+  _args.output_file.write("""
+};
+
+const char *describe_metricgroup(const char *group)
+{
+        int low = 0, high = ARRAY_SIZE(metricgroups) - 1;
+
+        while (low <= high) {
+                int mid = (low + high) / 2;
+                const char *mgroup = &big_c_string[metricgroups[mid][0]];
+                int cmp = strcmp(mgroup, group);
+
+                if (cmp == 0) {
+                        return &big_c_string[metricgroups[mid][1]];
+                } else if (cmp < 0) {
+                        low = mid + 1;
+                } else {
+                        high = mid - 1;
+                }
+        }
+        return NULL;
+}
+""")
 
 def main() -> None:
   global _args
@@ -993,7 +1038,7 @@ struct compact_pmu_event {
 
   print_mapping_table(archs)
   print_system_mapping_table()
-
+  print_metricgroups()
 
 if __name__ == '__main__':
   main()
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 3549e6971a4d..8cd23d656a5d 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -93,4 +93,6 @@ const struct pmu_metrics_table *find_sys_metrics_table(const char *name);
 int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data);
 int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data);
 
+const char *describe_metricgroup(const char *group);
+
 #endif
-- 
2.40.1.606.ga4b1b128d6-goog

