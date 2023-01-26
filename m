Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6395C67D9B8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjAZXie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjAZXi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:38:27 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC3642BDB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:38:01 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5062f3a2977so37768267b3.21
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FoTYT9Og9W7mOnq4wl24j8oeZ9sXDx0pwBnIKjojMSA=;
        b=ULUppHbH0Lds8PRb4HCInj6sdVtWfg1huViMQi1YE0ul63ee8883+M0MnHN4Us2V7i
         TmjI70t+lcCBgmZxtoL/jVWPJ6sNnKqitAyb4vnBVnY/dMkVpEDZBvCVPjCW3YmSEr4F
         AKZBMBxOLYx67TrJvqXkt8MfTBW1ftqkkF1sbbshp97ZvIv+FuvNWM5Pl0BCYc+fMQjF
         jG3XD5ioKeQ1A5FPzRWN6yoxg3PDQSVRSrZ9uTL5IG0keeoCO+uX8swHm+XxplFeE095
         9igTX6u9qNkN705TCI2pwnGERWhDZUmphBbqVscDIST1+JZmSqkpiApPjtWUTiwkTlXA
         dj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoTYT9Og9W7mOnq4wl24j8oeZ9sXDx0pwBnIKjojMSA=;
        b=BMoLbmo/zzqmkmWvfDhLvvmKqhLivpksYhHiPO4UH/VubrDUlq3apK0aBK25fUC808
         F9ESaLxaJHH0LoYy4hmANQjqwSvUBHFkXNO2NwnC11YPM41eiQ+NFkEcoNLCCtp5DlZT
         64eL792l6UtVyECvVWNcn45wmyAR1BDCJQeuP8EXtbG8Bt1lfPCE3a7vDM0vF53SIU+H
         AYXHC25mVw8CLI7PF3KOwYuP7SXfHEY0OeFB/3z5jVHEievi46aT9grSXZhBHN6Qpgug
         J8Q+F99fo3WBADfGSxcVDqGwhfXbQ1jzK1wzXYtV3SLE2CJxN+Bhgu/6fAsBPxebtAyR
         r6qQ==
X-Gm-Message-State: AO0yUKUwfNNj3aObuumBGNq5wWaazq4Gcs7gT5kNrNdWUp5gM6bSGfas
        qgJUxYkEt6v0f5l1TiGxgLBrV3uicRXB
X-Google-Smtp-Source: AK7set83ZU/+aIZhovn+Ujc40CNNaJnunjOMXWOZV5je7wWwRjnplJ+bu5E9859RuJWtZNCyTfNVH7wZOkFk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b9b8:6de0:39b3:4cf7])
 (user=irogers job=sendgmr) by 2002:a25:2f88:0:b0:80b:c194:655c with SMTP id
 v130-20020a252f88000000b0080bc194655cmr677594ybv.236.1674776278610; Thu, 26
 Jan 2023 15:37:58 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:36:38 -0800
In-Reply-To: <20230126233645.200509-1-irogers@google.com>
Message-Id: <20230126233645.200509-9-irogers@google.com>
Mime-Version: 1.0
References: <20230126233645.200509-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v5 08/15] perf jevents: Combine table prefix and suffix writing
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
2.39.1.456.gfc5497dd1b-goog

