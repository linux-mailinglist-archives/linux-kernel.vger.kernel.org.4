Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A6366869C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjALWKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjALWKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:10:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628935AC6B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:00:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t13-20020a056902018d00b0074747131938so20788338ybh.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hUFqBM73Q9lYPdMltK2ThCupgV9eep/CgOS8HVgc6fI=;
        b=GAdw1Ka7cnbJBk//dl51ObqXXMMvDDovB1M6ELGF0LEwS3tdMa09jt7nUW+Z1IVbOQ
         gQswghN2Hiez2FrURXEWkZCSk6DafmoNLtZFfDO2k0YytwL0xUYSNh6BwREORVGcUelk
         j+V2eyneWxjqEWQ7MxTjskkl5BGL4f5n0MJjUcBMW2Eqed9DY1+OEl7UWdQ8MqSos4ym
         mVLInsDDZOo7qpz+mM7NMbd2P8HQkPgMURuc0X4u5SEQIxk69lTrVdz9HJyfghPvtyLN
         Gcbr17/y+EU5MTwuUv5cXjJWkBltiyG6r1OU0lnO21VqZN74F3ht2MERDZNCAgBMhExN
         Wl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUFqBM73Q9lYPdMltK2ThCupgV9eep/CgOS8HVgc6fI=;
        b=WPQc6fRncmXCMX7mtloHFB74zyY41sExfszSVuQCJ8FZvtvsKLz6B1ICOB7Ma25CH8
         Gho8f7fiM+DKDewJmG3Mro8TNLaxHhvzEwpOxJYWu22jmUeDTId91yB8QOoHN95VD2kz
         6zOyWMt6Wqqj54+Mg03v4ybu5Xx37mUyp2XYFMOFi2XWrItjRodM2mjVMdmwXKmbzCQo
         8Q4B/QF4Np1xTQOpJ7IVw4CkgLPYYzms18H3B7Aiy9ETwjruX7Bdjyhj77vUMEKMWZY2
         6vsnEEYbVVap9nO8NUU9UAM5eOQQizm908Z5+9HwZewv0lQO7cWuim4yeFkiUApF6Bk+
         hnOg==
X-Gm-Message-State: AFqh2kpvaiTrHL+DWb9mIq/6nqlTHPfNuBR5+cKE5UIIIHavxTwBE4/q
        eHEB+Mtuf0QiBI79c04lxDcKHNkVhQ+R
X-Google-Smtp-Source: AMrXdXu7a+gPhbmbHAxwKTFuua6NBcl4OGgBsjJcylZB/1GuBpnOuQHXwpPlkQFnObaoDsz47eX0okUgZ18g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fa4e:1fbc:95a:3ea6])
 (user=irogers job=sendgmr) by 2002:a81:88c5:0:b0:3ad:436f:4e6d with SMTP id
 y188-20020a8188c5000000b003ad436f4e6dmr2361136ywf.412.1673560837616; Thu, 12
 Jan 2023 14:00:37 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:00:24 -0800
Message-Id: <20230112220024.32709-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2] perf script flamegraph: Avoid d3-flame-graph package dependency
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

v2. Change the warning to a prompt about downloading and add the
    --allow-download command line flag. Add an md5sum check for the
    downloaded HTML.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/scripts/python/flamegraph.py | 96 +++++++++++++++++++------
 1 file changed, 74 insertions(+), 22 deletions(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index b6af1dd5f816..086619053e4e 100755
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
@@ -128,16 +140,52 @@ class FlameGraphCLI:
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
@@ -172,6 +220,10 @@ if __name__ == "__main__":
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

