Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7416538BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiLUWgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbiLUWfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:35:37 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD6614D04
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:35:17 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z8-20020aa79588000000b00576e8050ec9so14918pfj.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pC6isRrZQJBTPK0pkg9ElG5ABnt5NfeUEOm6zvm9c6s=;
        b=bxVJqQOTiX9f1tA62gviN0yBaRAZx1IjeakOqrQFWy2XrypXLEa6yhuzevo6tTduWZ
         nVo63HkbDpt6HVpwdMZEOYanE067vmvtTb92yMQ5dsCQ2/p8BEs9vU501nD4zwfhSUZ7
         BqL74ZB3n8EIVrew/Y06Vl+ylDsgyaQrtLG0Jz3uPMRnKdbOC89aArgZL+96t0UZL+wH
         +cd6Mjd3fNDMP7YupeYkgP4xnramou5By08FKVzeZMsOdTYGWfUnRXPLybP8FMusBtqo
         vCaLhWwRUeTd3HCG1bNDlsE6h0xFWmvkF/xxKZ/u6q633Xxgh/nx8SSuk9qlZZRQRVh8
         JhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pC6isRrZQJBTPK0pkg9ElG5ABnt5NfeUEOm6zvm9c6s=;
        b=tVpz28tdYsWLegv4oTU8SosQGYJTddX9I/JaRc0tToAcIdb5rODPwSiN7BogP2gow3
         u4Cj3JT5+8z0hFpBVQik+2RmV/2vHmHRMPw6HQXLyf1lrGo622D5OqjrgLt8Goz1pwgA
         HTAx8/jqJbrAtujjV338XNz+JMlBAQcg1IXFbdau5MCokrn7Gh27cZra1+ELnRPAw37N
         +2eccsA2cyQE9G/VeYOX5er7xQ0nBG0xaFAWdfle0fZRSHicrVnYMcxlL3nsRXHTySQR
         GQqsU5cmJZFI0PhHnihCwhat3KLZaMd6CX4Kw3jGF+K0mw02D7BYMpim/4ZgmTGtAs+6
         BK2g==
X-Gm-Message-State: AFqh2kpoPJkNAn5BXMNjL2h+SBk+I5ZBGQGc7/oYApwIclij4g/xbHNa
        CRtHPtoeUay/9j+/NOBnGR8r5wzsnIGE
X-Google-Smtp-Source: AMrXdXvZgXgBm+ynSwUWG/YkqiQEqVQKEBGGCqm8lB+5EeVkLFjGgB4/0yy2i9dKPCb+QTfGBMBczDHbBr0U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:62bd:f120:1fd8:1d21])
 (user=irogers job=sendgmr) by 2002:a17:902:e045:b0:191:7ec:8236 with SMTP id
 x5-20020a170902e04500b0019107ec8236mr319004plx.38.1671662116379; Wed, 21 Dec
 2022 14:35:16 -0800 (PST)
Date:   Wed, 21 Dec 2022 14:34:17 -0800
In-Reply-To: <20221221223420.2157113-1-irogers@google.com>
Message-Id: <20221221223420.2157113-7-irogers@google.com>
Mime-Version: 1.0
References: <20221221223420.2157113-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 6/9] perf jevents: Combine table prefix and suffix writing
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
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_SBL_A,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index ee3d4cdf01be..7b9714b25d0a 100755
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
@@ -376,24 +376,13 @@ def preprocess_arch_std_files(archpath: str) -> None:
           _arch_std_events[event.name.lower()] = event
 
 
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
@@ -405,17 +394,19 @@ def print_events_table_suffix() -> None:
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
@@ -453,12 +444,13 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
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
@@ -802,7 +794,7 @@ struct compact_pmu_event {
   for arch in archs:
     arch_path = f'{_args.starting_dir}/{arch}'
     ftw(arch_path, [], process_one_file)
-    print_events_table_suffix()
+    print_pending_events()
 
   print_mapping_table(archs)
   print_system_mapping_table()
-- 
2.39.0.314.g84b9a713c41-goog

