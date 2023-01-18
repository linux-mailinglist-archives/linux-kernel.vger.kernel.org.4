Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5212E67157C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjARHyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjARHxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:24 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E932F4FCE5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:24:26 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k135-20020a25248d000000b007d689f92d6dso10809342ybk.22
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g5ejasQrFsU/5gVpFRFubfv/+PZvkyzMvOtZ1k9Ls2g=;
        b=sg3ax46z3ITf8FSZP4v7C7ytnbVk7hIKtf93DfqvhuueGbIMI3vje4kCIkHKREXLTn
         s4sxOff7VissWFrsaAzuyDwqtHQJOt8dvzLjdWbCfWhoaCqkjwUW9mpZG+BXbM0Z53fc
         4TgqJGE3LUjS37rdL2Rb9gXQ336AMMMimusx1NBHUHXE4fE3Z+LbZzanir3vUTT36WBV
         dwOUKsJYKA5L1nJvNB7uuW8DhzjzzzQwGq2ntcyzqWVRZ8nZ6L0G1uIAqbks4iDCeahX
         snD5rDXsoyg3i8w94uHsaFMg9kPaoMxPx/QxSRl/nZMNnPhNNOY0PRkfgFFQH6+4PMjd
         +kPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g5ejasQrFsU/5gVpFRFubfv/+PZvkyzMvOtZ1k9Ls2g=;
        b=1vMfrbaiWsikOgbyl8MpAwv9ZYiDI2GOOIIr6HrBzLi1l1REK07V2br4Tq5gyuSrJe
         5WqZkRZmeVtXHXNysftmELh6yGfKkkDFfksU8kNPeLBmH+ReSk8xxOWJAuBqsfsrKUVW
         xDDFEqPiqlzu842JCGZPFw56Q968Y5nY4tjEYrg/ipvYGV0XUld4j5x6kju3OBZjMoqi
         DnpAqlkdkB2JDyTeAhP56BQXqnEtGb1bKim4VWnUQFjHMqiMzTXm9WONp3QPhH8i9qPc
         YwOUHjAHgcHEo8NYXabf5K/XwQrq8q8GcifGkFHP/UhZNFTQQ5HOf5+d5linLqwod9L7
         JmHQ==
X-Gm-Message-State: AFqh2kpUrUVz42UYBamuzkJAUwjfdDQkR12lX2Y2Fx6blsrD9nB0G52v
        mJtWk68VneGnvwq6M9e0Yr2DaxJDDTyc
X-Google-Smtp-Source: AMrXdXudsO9xpF3o4NoK3cPpdWKIYrYY2Om/KWhPomCdbcIY4lxaTSpifcV4AXwwjc93A1quEvO7d7CGh7z+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6cc7:ef8b:a10c:4c81])
 (user=irogers job=sendgmr) by 2002:a81:cc2:0:b0:4db:3866:6fa6 with SMTP id
 185-20020a810cc2000000b004db38666fa6mr716845ywm.44.1674026666209; Tue, 17 Jan
 2023 23:24:26 -0800 (PST)
Date:   Tue, 17 Jan 2023 23:24:09 -0800
Message-Id: <20230118072409.147786-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v3] perf script flamegraph: Avoid d3-flame-graph package dependency
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
        Martin Spier <spiermar@gmail.com>,
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
Debian [1]. If the template isn't installed then ask if it should be
downloaded from jsdelivr CDN. The downloaded HTML file is validated
against an md5sum. If the download fails, generate a minimal flame
graph with the javascript coming from links to jsdelivr CDN.

v3. Adds a warning message and quits before download in live mode.
v2. Change the warning to a prompt about downloading and add the
    --allow-download command line flag. Add an md5sum check for the
    downloaded HTML.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/scripts/python/flamegraph.py | 107 +++++++++++++++++++-----
 1 file changed, 85 insertions(+), 22 deletions(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index b6af1dd5f816..cf7ce8229a6c 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -19,12 +19,34 @@
 # pylint: disable=missing-function-docstring
 
 from __future__ import print_function
-import sys
-import os
-import io
 import argparse
+import hashlib
+import io
 import json
+import os
 import subprocess
+import sys
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
@@ -50,16 +72,6 @@ class FlameGraphCLI:
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
-
     @staticmethod
     def get_libtype_from_dso(dso):
         """
@@ -128,16 +140,63 @@ class FlameGraphCLI:
             }
             options_json = json.dumps(options)
 
+            template_md5sum = None
+            if self.args.format == "html":
+                if os.path.isfile(self.args.template):
+                    template = f"file://{self.args.template}"
+                else:
+                    if not self.args.allow_download:
+                        print(f"""Warning: Flame Graph template '{self.args.template}'
+does not exist. To avoid this please install a package such as the
+js-d3-flame-graph or libjs-d3-flame-graph, specify an existing flame
+graph template (--template PATH) or use another output format (--format
+FORMAT).""",
+                              file=sys.stderr)
+                        if self.args.input == "-":
+                            print("""Not attempting to download Flame Graph template as script command line
+input is disabled due to using live mode. If you want to download the
+template retry without live mode. For example, use 'perf record -a -g
+-F 99 sleep 60' and 'perf script report flamegraph'. Alternatively,
+download the template from:
+https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html
+and place it at:
+/usr/share/d3-flame-graph/d3-flamegraph-base.html""",
+                                  file=sys.stderr)
+                            quit()
+                        s = None
+                        while s != "y" and s != "n":
+                            s = input("Do you wish to download a template from cdn.jsdelivr.net? (this warning can be suppressed with --allow-download) [yn] ").lower()
+                        if s == "n":
+                            quit()
+                    template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
+                    template_md5sum = "143e0d06ba69b8370b9848dcd6ae3f36"
+
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
+                with urllib.request.urlopen(template) as template:
+                    output_str = "".join([
+                        l.decode("utf-8") for l in template.readlines()
+                    ])
+            except Exception as err:
+                print(f"Error reading template {template}: {err}\n"
+                      "a minimal flame graph will be generated", file=sys.stderr)
+                output_str = minimal_html
+                template_md5sum = None
+
+            if template_md5sum:
+                download_md5sum = hashlib.md5(output_str.encode("utf-8")).hexdigest()
+                if download_md5sum != template_md5sum:
+                    s = None
+                    while s != "y" and s != "n":
+                        s = input(f"""Unexpected template md5sum.
+{download_md5sum} != {template_md5sum}, for:
+{output_str}
+continue?[yn] """).lower()
+                    if s == "n":
+                        quit()
+
+            output_str = output_str.replace("/** @options_json **/", options_json)
+            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
+
             output_fn = self.args.output or "flamegraph.html"
         else:
             output_str = stacks_json
@@ -172,6 +231,10 @@ if __name__ == "__main__":
                         choices=["blue-green", "orange"])
     parser.add_argument("-i", "--input",
                         help=argparse.SUPPRESS)
+    parser.add_argument("--allow-download",
+                        default=False,
+                        action="store_true",
+                        help="allow unprompted downloading of HTML template")
 
     cli_args = parser.parse_args()
     cli = FlameGraphCLI(cli_args)
-- 
2.39.0.314.g84b9a713c41-goog

