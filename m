Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5240A67910A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjAXGfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjAXGez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:34:55 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9463D92C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:34:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k15-20020a5b0a0f000000b007eba3f8e3baso15243137ybq.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxI5oPJ3cq0K+5Os4jMfPPdT2CCa4+RQl8NewShLZ1k=;
        b=QcL+ZQJPpdPJeyeTX72i49hgimTb0fFpL+iy8cNYa14cICCBX6O6B5T0GphRgj9LEM
         J56k+rR4PbYalwXQ0bAd3urfnDGaJy28JKC9XMDWOqdIDRZnbVMZduQMe1fYHBZy3VXe
         cKVRmrM7kftixRvWRMmEzNqc0AQzvT2x0R1fiIGPcP/9iNioecViCLKnXLYVFF3VUa3c
         vD+itFUV5prKBRYb+EMXmJM0e+wEewImeOAjzjUR37J80RAKBVu72u9eWYgly+/+YX+4
         wi52tLNtDmJI2a1n7EoaInYb3e0iIOSOCliRoqXcbTiUmDKf4lMKR5zRsLcJlGlRASpa
         x98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxI5oPJ3cq0K+5Os4jMfPPdT2CCa4+RQl8NewShLZ1k=;
        b=F9wKFU+2DAKM+YTbuc4zoBL+iByWm+YuysoCTf0DAte3wGcvHfsduHKBvFFgh2wG0P
         pWrRQ2Ad/TIyvO7/QUmhFGElrrILuYnq12HU0qT3QVupYWxsG6SI0gsv3mHbT7bojhwp
         kG4EPDWpJH3YEM3mpWW/SHQOpc5CAQZ8tng7N7FsuzNvU4B8aAz1gVoVPDanrcc5Wq2b
         5R4/TRZdQEVbnhp6JalP+7R+0Z27iJmU0FpqGgtwa+3dVI34gbMo7JjjouAo0/67t3f7
         0e1M6Aaa5Zh/xKND0f2ZAJDKwdHLdsDrrP/kbnISjx4zEeoF34RiRass2q4BDoxbPy7x
         aOKg==
X-Gm-Message-State: AFqh2kqO1o3AImrhU1riMKUb6A9WNc69y3Fig+0b7if+UiJpXU2pCu4f
        kuTbzyFHMp7dOIbwtbAIJ8ZTSTLaf4Zd
X-Google-Smtp-Source: AMrXdXuYfN4d0MK2UH9HwYS5h5VOVVypdFuHlEkLzQbckgvPAZRQbPea4EAmOqVX6fYwt9MK+jMEfFLer4SI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:460d:1b4a:acb8:ae9a])
 (user=irogers job=sendgmr) by 2002:a25:1856:0:b0:732:edd2:4138 with SMTP id
 83-20020a251856000000b00732edd24138mr1978744yby.448.1674542073924; Mon, 23
 Jan 2023 22:34:33 -0800 (PST)
Date:   Mon, 23 Jan 2023 22:33:17 -0800
In-Reply-To: <20230124063320.668917-1-irogers@google.com>
Message-Id: <20230124063320.668917-9-irogers@google.com>
Mime-Version: 1.0
References: <20230124063320.668917-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v3 08/11] perf jevents: Combine table prefix and suffix writing
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
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

Combine into a single function to simplify, in a later change, writing
metrics separately.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 36 +++++++++++++-------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 4cdbf34b7298..5f8d490c7269 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -19,10 +19,10 @@ _sys_event_tables = []
 # JsonEvent. Architecture standard events are in json files in the top
 # f'{_args.starting_dir}/{_args.arch}' directory.
 _arch_std_events = {}
-# Track whether an events table is currently being defined and needs closing.
-_close_table = False
 # Events to write out when the table is closed
 _pending_events = []
+# Name of table to be written out
+_pending_events_tblname = None
 # Global BigCString shared by all structures.
 _bcs = None
 # Order specific JsonEvent attributes will be visited.
@@ -378,24 +378,13 @@ def preprocess_arch_std_files(archpath: str) -> None:
           _arch_std_events[event.metric_name.lower()] = event
 
 
-def print_events_table_prefix(tblname: str) -> None:
-  """Called when a new events table is started."""
-  global _close_table
-  if _close_table:
-    raise IOError('Printing table prefix but last table has no suffix')
-  _args.output_file.write(f'static const struct compact_pmu_event {tblname}[] = {{\n')
-  _close_table = True
-
-
 def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   """Add contents of file to _pending_events table."""
-  if not _close_table:
-    raise IOError('Table entries missing prefix')
   for e in read_json_events(item.path, topic):
     _pending_events.append(e)
 
 
-def print_events_table_suffix() -> None:
+def print_pending_events() -> None:
   """Optionally close events table."""
 
   def event_cmp_key(j: JsonEvent) -> Tuple[bool, str, str, str, str]:
@@ -407,17 +396,19 @@ def print_events_table_suffix() -> None:
     return (j.desc is not None, fix_none(j.topic), fix_none(j.name), fix_none(j.pmu),
             fix_none(j.metric_name))
 
-  global _close_table
-  if not _close_table:
+  global _pending_events
+  if not _pending_events:
     return
 
-  global _pending_events
+  global _pending_events_tblname
+  _args.output_file.write(
+      f'static const struct compact_pmu_event {_pending_events_tblname}[] = {{\n')
+
   for event in sorted(_pending_events, key=event_cmp_key):
     _args.output_file.write(event.to_c_string())
-    _pending_events = []
+  _pending_events = []
 
   _args.output_file.write('};\n\n')
-  _close_table = False
 
 def get_topic(topic: str) -> str:
   if topic.endswith('metrics.json'):
@@ -455,12 +446,13 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
   # model directory, reset topic
   if item.is_dir() and is_leaf_dir(item.path):
-    print_events_table_suffix()
+    print_pending_events()
 
     tblname = file_name_to_table_name(parents, item.name)
     if item.name == 'sys':
       _sys_event_tables.append(tblname)
-    print_events_table_prefix(tblname)
+    global _pending_events_tblname
+    _pending_events_tblname = tblname
     return
 
   # base dir or too deep
@@ -809,7 +801,7 @@ struct compact_pmu_event {
   for arch in archs:
     arch_path = f'{_args.starting_dir}/{arch}'
     ftw(arch_path, [], process_one_file)
-    print_events_table_suffix()
+    print_pending_events()
 
   print_mapping_table(archs)
   print_system_mapping_table()
-- 
2.39.0.246.g2a6d74b583-goog

