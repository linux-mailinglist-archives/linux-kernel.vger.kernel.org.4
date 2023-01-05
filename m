Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AC165E335
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjAEDEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjAEDEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:04:45 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D2911178
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:04:44 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-487b0bf1117so216594357b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 19:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lfkNLp5G5wuHv2XWWcgX8O/KJXZf1fcYl8/hPFMILT0=;
        b=DwzvpEzrUCyVoe99pSECCLFmrkStqGsbEM+qZOvLcYPEbAM6sHAlnMtuj4IVTj4CG9
         XymFGvFvyydvhs04qS/xBHcIVzVLJ6qfGb9tmbKq9qnVNUaonzTHEZv+0eixCiPIeIRt
         fHXrlHqtby4RIuQ8gp3knFd7VdOWixUUaKOWVVjHiOeVsiF+RR4/Jo+9ziTN8dJ4MuEj
         Jd5oi2nM6nW2muRVQ5BWFbXYKY9k5XBaWEj02OP2iwLtX2DzEPZtDypoUcTRyZ+Rh7r/
         qq4IdoKLw9LvpcUke2XolHKpu/g4Mju0uI79l09ljFhK9Zmj+ZRhJWvwZiew2Tswixlk
         vYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfkNLp5G5wuHv2XWWcgX8O/KJXZf1fcYl8/hPFMILT0=;
        b=J/bFJGxcU12DnffVJWP6Ki0iL9A+R6V/Hsw7/Fu9CgyV2dJMFH/BcF9QfqSmwCFCnk
         GHAEfRnuvi9ZS+xHk4Vb5eqLrJ6jM2G7qmVGRWGjamYdaymGwjON6CWeYBZf0pnJw6s+
         Zd8SH42n8Z+8j0y5A0+7MZguCMVxudQjL5/pGONApOu7ls6LpBdrVI2nKpNV1pF5Gghc
         Xd0DI8N28Ryg9sOhT1EFMRchS4++CVo3rjjBi2PLRifkTaf9J4RhqdWN4zWMm74mHdGu
         j7vPxUUqhxYfWHlpaM1EBsubN/aj0MO86x6RTpkIz6YEObdnYyl4J8v3LzPdG81MXyJq
         c/4g==
X-Gm-Message-State: AFqh2koH3rMFgilE7kzvTGFJM5Bz09zX3sq4bxPGQXQEyI9oxmRHJ2Cs
        8uxUoxllpAsmV4Mc6qdjAnkZ991yRVfL
X-Google-Smtp-Source: AMrXdXuisK5mAqlwmvkpFdxhPjG8DpYhx5FFU3xnFObYy1LV8aptLQvUkfB/FW5qEwEAzG/vzfyNqMD0xDoA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1e55:c3f8:c203:8c48])
 (user=irogers job=sendgmr) by 2002:a25:2fc5:0:b0:706:bafd:6f95 with SMTP id
 v188-20020a252fc5000000b00706bafd6f95mr4072901ybv.55.1672887883928; Wed, 04
 Jan 2023 19:04:43 -0800 (PST)
Date:   Wed,  4 Jan 2023 19:04:34 -0800
Message-Id: <20230105030434.255603-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1] perf script flamegraph: Avoid d3-flame-graph package dependency
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        996839@bugs.debian.org, Andreas Gerstmayr <agerstmayr@redhat.com>,
        Martin Spier <mspier@netflix.com>,
        Brendan Gregg <brendan@intel.com>
Cc:     Ian Rogers <irogers@google.com>
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

Currently flame graph generation requires a d3-flame-graph template to
be installed. Unfortunately this is hard to come by for things like
Debian [1]. If the template isn't installed warn and download it from
jsdelivr CDN. If downloading fails generate a minimal flame graph
again with the javascript coming from jsdelivr CDN.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/scripts/python/flamegraph.py | 63 ++++++++++++++++++-------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index b6af1dd5f816..808b0e1c9be5 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -25,6 +25,27 @@ import io
 import argparse
 import json
 import subprocess
+import urllib.request
+
+minimal_html = """<head>
+  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
+</head>
+<body>
+  <div id="chart"></div>
+  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
+  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
+  <script type="text/javascript">
+  const stacks = [/** @flamegraph_json **/];
+  // Note, options is unused.
+  const options = [/** @options_json **/];
+
+  var chart = flamegraph();
+  d3.select("#chart")
+        .datum(stacks[0])
+        .call(chart);
+  </script>
+</body>
+"""
 
 # pylint: disable=too-few-public-methods
 class Node:
@@ -50,15 +71,18 @@ class FlameGraphCLI:
         self.args = args
         self.stack = Node("all", "root")
 
-        if self.args.format == "html" and \
-                not os.path.isfile(self.args.template):
-            print("Flame Graph template {} does not exist. Please install "
-                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
-                  "package, specify an existing flame graph template "
-                  "(--template PATH) or another output format "
-                  "(--format FORMAT).".format(self.args.template),
-                  file=sys.stderr)
-            sys.exit(1)
+        if self.args.format == "html":
+            if os.path.isfile(self.args.template):
+                self.template = f"file://{self.args.template}"
+            else:
+                print(f"""
+Warning: Flame Graph template '{self.args.template}'
+does not exist, a template will be downloaded via http. To avoid this
+please install a package such as the js-d3-flame-graph or
+libjs-d3-flame-graph, specify an existing flame graph template
+(--template PATH) or another output format (--format FORMAT).
+""", file=sys.stderr)
+            self.template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
 
     @staticmethod
     def get_libtype_from_dso(dso):
@@ -129,15 +153,18 @@ class FlameGraphCLI:
             options_json = json.dumps(options)
 
             try:
-                with io.open(self.args.template, encoding="utf-8") as template:
-                    output_str = (
-                        template.read()
-                        .replace("/** @options_json **/", options_json)
-                        .replace("/** @flamegraph_json **/", stacks_json)
-                    )
-            except IOError as err:
-                print("Error reading template file: {}".format(err), file=sys.stderr)
-                sys.exit(1)
+                with urllib.request.urlopen(self.template) as template:
+                    output_str = '\n'.join([
+                        l.decode('utf-8') for l in template.readlines()
+                    ])
+            except Exception as err:
+                print(f"Error reading template {self.template}: {err}\n"
+                      "a minimal flame graph will be generated", file=sys.stderr)
+                output_str = minimal_html
+
+            output_str = output_str.replace("/** @options_json **/", options_json)
+            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
+
             output_fn = self.args.output or "flamegraph.html"
         else:
             output_str = stacks_json
-- 
2.39.0.314.g84b9a713c41-goog

