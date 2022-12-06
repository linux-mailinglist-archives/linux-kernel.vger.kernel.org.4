Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E26644843
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiLFPpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiLFPpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:45:04 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDCC25C5B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:45:02 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qk9so7223506ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 07:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgOFfxvfh7TFGI4CvAyyNWER4ioh3ESb5JjL5qSFoLA=;
        b=GeG2huumP18ntsJGiIopwDgsTEy232Wu4nvqgLfI8n5ddQCYeS4lufWehqLTLT8Wkj
         q0gnKWhs0vbEVaML5cDtF5S38tFIYwE0CZgHbyD9zv/5LjffigytFvSLof24pmhOWnVb
         I1PtBhrWKt8xU4y6TmawZuNfKOKxgBpFPmWtgaB+gONBo3Ik3+a0D4wm5Lid6YY5gxwL
         DE8ZGi/QajQjbhtO8XXi9EL1P5R/4So91awSzz1kH3YV754tJfA3dWc95fyr8cmRN8I0
         o5nDv7Fh3BIGgANceSVw4HD4REBlmS23zaekXA0wGZuxFHxqiX5HWLUKAtt7P1BKqFrz
         70fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgOFfxvfh7TFGI4CvAyyNWER4ioh3ESb5JjL5qSFoLA=;
        b=7U4sESgb4wtzTHc+Yu220X3EDMn9Tb5KEgWU2kf7EgzWbYddeJVlIzIYfi2JTE6NxO
         anKgeE7LHaqJgv31aS+SsAMh19FBuKtVbUMaFfAcDDepCF9/iS9V0Ew5f/IwoG6Z0A0Q
         QiU17fskwpaYNZvDDZtGSOF/w2UpxrQ1VAnoqYJ9zrAljOrf8bj9hrdyTIAVjTte9RHY
         vGN9QKnc7uaLseZ0PCwpUEhHTNkjaMuScTx8TGCYftLDL2rRU2V3zMo7lYjPzn7Py2LS
         G8airnEmQ3sbxmkUnpFnnsEKb65J3Jo25Izuhb3GAVywjKLO2E/kMIuCow1vENs61eto
         Aeuw==
X-Gm-Message-State: ANoB5pl3SEI7N0Tx7LzBlp2DsritUI9fUFHWb3KUatGmx5WiRxpGam1k
        fGovkrx9fZgONnoOlT/wOJ/RHMqiNnhCk5HiB5w=
X-Google-Smtp-Source: AA0mqf5aCtVuMLJOqFLprd9xLi6weyVrv8rS6A50nAVC6FEKyxvaQPE4WOQxLzfYzlkvXxs6FjEIuA==
X-Received: by 2002:a17:906:e296:b0:7c1:27a:7495 with SMTP id gg22-20020a170906e29600b007c1027a7495mr5211523ejb.7.1670341500986;
        Tue, 06 Dec 2022 07:45:00 -0800 (PST)
Received: from localhost.localdomain ([86.48.7.22])
        by smtp.gmail.com with ESMTPSA id vs21-20020a170907139500b007c0ae137404sm6595550ejb.97.2022.12.06.07.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:45:00 -0800 (PST)
From:   Petar Gligoric <petar.gligor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 2/3] perf script: task-analyzer add csv support
Date:   Tue,  6 Dec 2022 10:44:05 -0500
Message-Id: <20221206154406.41941-3-petar.gligor@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206154406.41941-1-petar.gligor@gmail.com>
References: <20221206154406.41941-1-petar.gligor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petar Gligoric <petar.gligoric@rohde-schwarz.com>

This patch adds the possibility to write the trace and the summary as csv files
to a user specified file. A format as such simplifies further data processing.
This is achieved by having ";" as separators instead of spaces and solely one
header per file.
Additional parameters are being considered, like in the normal usage of the
script. Colors are turned off in the case of a csv output, thus the highlight
option is also being ignored.

Usage:

Write standard task to csv file:
$ perf script report tasks-analyzer --csv <file>
write limited output to csv file in nanoseconds:
$ perf script report tasks-analyzer --csv <file> --ns --limit-to-tasks 1337

Write summary to a csv file:
$ perf script report tasks-analyzer --csv-summary <file>
Write summary to csv file with additional schedule information:
$ perf script report tasks-analyzer --csv-summary <file> --summary-extended

Write both summary and standard task to a csv file:
$ perf script report tasks-analyzer --csv --csv-summary

The following examples illustrate what is possible with the CSV output.  The
first command sequence will record all scheduler switch events for 10 seconds,
the task-analyzer calculates task information like runtimes as CSV.  A small
python snippet using pandas and matplotlib will visualize the most frequent
task (e.g. kworker/1:1) runtimes - each runtime as a bar in a bar chart:

$ perf record -e sched:sched_switch -a -- sleep 10
$ perf script report tasks-analyzer --ns --csv tasks.csv
$ cat << EOF > /tmp/freq-comm-runtimes-bar.py
  import pandas as pd
  import matplotlib.pyplot as plt

  df = pd.read_csv("tasks.csv", sep=';')
  most_freq_comm = df["COMM"].value_counts().idxmax()
  most_freq_runtimes = df[df["COMM"]==most_freq_comm]["Runtime"]
  plt.title(f"Runtimes for Task {most_freq_comm} in Nanoseconds")
  plt.bar(range(len(most_freq_runtimes)), most_freq_runtimes)
  plt.show()
$ python3 /tmp/freq-comm-runtimes-bar.py

As a seconds example, the subsequent script generates a pie chart of all
accumulated tasks runtimes for 10 seconds of system recordings:

$ perf record -e sched:sched_switch -a -- sleep 10
$ perf script report tasks-analyzer --csv-summary task-summary.csv
$ cat << EOF > /tmp/accumulated-task-pie.py
  import pandas as pd
  from matplotlib.pyplot import pie, axis, show

  df = pd.read_csv("task-summary.csv", sep=';')
  sums = df.groupby(df["Comm"])["Accumulated"].sum()
  axis("equal")
  pie(sums, labels=sums.index);
  show()
EOF
$ python3 /tmp/accumulated-task-pie.py

A variety of other visualizations are possible in matplotlib and other
environments. Of course, pandas, numpy and co. also allow easy statistical
analysis of the data!

Signed-off-by: Petar Gligoric <petar.gligoric@rohde-schwarz.com>
Signed-off-by: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/scripts/python/task-analyzer.py | 274 ++++++++++++++-------
 1 file changed, 185 insertions(+), 89 deletions(-)

diff --git a/tools/perf/scripts/python/task-analyzer.py b/tools/perf/scripts/python/task-analyzer.py
index f74abe50f3b2..52e8dae9b1f0 100755
--- a/tools/perf/scripts/python/task-analyzer.py
+++ b/tools/perf/scripts/python/task-analyzer.py
@@ -156,6 +156,18 @@ def _parse_args():
         help="always, never or auto, allowing configuring color output"
             " via the command line",
     )
+    parser.add_argument(
+        "--csv",
+        default="",
+        help="Write trace to file selected by user. Options, like --ns or --extended"
+            "-times are used.",
+    )
+    parser.add_argument(
+        "--csv-summary",
+        default="",
+        help="Write summary to file selected by user. Options, like --ns or"
+            " --summary-extended are used.",
+    )
     args = parser.parse_args()
     args.tid_renames = dict()
 
@@ -275,7 +287,6 @@ class Timespans(object):
 
 
 
-
 class Summary(object):
     """
     Primary instance for calculating the summary output. Processes the whole trace to
@@ -327,7 +338,7 @@ class Summary(object):
                 sum(db["inter_times"].values()) - 4 * decimal_precision
                 )
             _header += ("Max Inter Task Times",)
-        print(fmt.format(*_header))
+        fd_sum.write(fmt.format(*_header) +  "\n")
 
     def _column_titles(self):
         """
@@ -336,34 +347,58 @@ class Summary(object):
         values are being displayed in grey. Thus in their format two additional {},
         are placed for color set and reset.
         """
+        separator, fix_csv_align = _prepare_fmt_sep()
         decimal_precision, time_precision = _prepare_fmt_precision()
-        fmt = " {{:>{}}}".format(db["task_info"]["pid"])
-        fmt += " {{:>{}}}".format(db["task_info"]["tid"])
-        fmt += " {{:>{}}}".format(db["task_info"]["comm"])
-        fmt += " {{:>{}}}".format(db["runtime_info"]["runs"])
-        fmt += " {{:>{}}}".format(db["runtime_info"]["acc"])
-        fmt += " {{:>{}}}".format(db["runtime_info"]["mean"])
-        fmt += " {{:>{}}}".format(db["runtime_info"]["median"])
-        fmt += " {{:>{}}}".format(db["runtime_info"]["min"] - decimal_precision)
-        fmt += " {{:>{}}}".format(db["runtime_info"]["max"] - decimal_precision)
-        fmt += " {{}}{{:>{}}}{{}}".format(db["runtime_info"]["max_at"] - time_precision)
+        fmt = "{{:>{}}}".format(db["task_info"]["pid"] * fix_csv_align)
+        fmt += "{}{{:>{}}}".format(separator, db["task_info"]["tid"] * fix_csv_align)
+        fmt += "{}{{:>{}}}".format(separator, db["task_info"]["comm"] * fix_csv_align)
+        fmt += "{}{{:>{}}}".format(separator, db["runtime_info"]["runs"] * fix_csv_align)
+        fmt += "{}{{:>{}}}".format(separator, db["runtime_info"]["acc"] * fix_csv_align)
+        fmt += "{}{{:>{}}}".format(separator, db["runtime_info"]["mean"] * fix_csv_align)
+        fmt += "{}{{:>{}}}".format(
+            separator, db["runtime_info"]["median"] * fix_csv_align
+        )
+        fmt += "{}{{:>{}}}".format(
+            separator, (db["runtime_info"]["min"] - decimal_precision) * fix_csv_align
+        )
+        fmt += "{}{{:>{}}}".format(
+            separator, (db["runtime_info"]["max"] - decimal_precision) * fix_csv_align
+        )
+        fmt += "{}{{}}{{:>{}}}{{}}".format(
+            separator, (db["runtime_info"]["max_at"] - time_precision) * fix_csv_align
+        )
 
         column_titles = ("PID", "TID", "Comm")
         column_titles += ("Runs", "Accumulated", "Mean", "Median", "Min", "Max")
-        column_titles += (_COLORS["grey"], "At", _COLORS["reset"])
+        column_titles += (_COLORS["grey"], "Max At", _COLORS["reset"])
 
         if args.summary_extended:
-            fmt += " {{:>{}}}".format(db["inter_times"]["out_in"] - decimal_precision)
-            fmt += " {{}}{{:>{}}}{{}}".format(
-                db["inter_times"]["inter_at"] - time_precision
+            fmt += "{}{{:>{}}}".format(
+                separator,
+                (db["inter_times"]["out_in"] - decimal_precision) * fix_csv_align
+            )
+            fmt += "{}{{}}{{:>{}}}{{}}".format(
+                separator,
+                (db["inter_times"]["inter_at"] - time_precision) * fix_csv_align
+            )
+            fmt += "{}{{:>{}}}".format(
+                separator,
+                (db["inter_times"]["out_out"] - decimal_precision) * fix_csv_align
+            )
+            fmt += "{}{{:>{}}}".format(
+                separator,
+                (db["inter_times"]["in_in"] - decimal_precision) * fix_csv_align
+            )
+            fmt += "{}{{:>{}}}".format(
+                separator,
+                (db["inter_times"]["in_out"] - decimal_precision) * fix_csv_align
             )
-            fmt += " {{:>{}}}".format(db["inter_times"]["out_out"] - decimal_precision)
-            fmt += " {{:>{}}}".format(db["inter_times"]["in_in"] - decimal_precision)
-            fmt += " {{:>{}}}".format(db["inter_times"]["in_out"] - decimal_precision)
 
             column_titles += ("Out-In", _COLORS["grey"], "Max At", _COLORS["reset"],
                         "Out-Out", "In-In", "In-Out")
-        print(fmt.format(*column_titles))
+
+        fd_sum.write(fmt.format(*column_titles) + "\n")
+
 
     def _task_stats(self):
         """calculates the stats of every task and constructs the printable summary"""
@@ -414,39 +449,53 @@ class Summary(object):
             self._calc_alignments_summary(align_helper)
 
     def _format_stats(self):
+        separator, fix_csv_align = _prepare_fmt_sep()
         decimal_precision, time_precision = _prepare_fmt_precision()
-        fmt = " {{:>{}d}}".format(db["task_info"]["pid"])
-        fmt += " {{:>{}d}}".format(db["task_info"]["tid"])
-        fmt += " {{:>{}}}".format(db["task_info"]["comm"])
-        fmt += " {{:>{}d}}".format(db["runtime_info"]["runs"])
-        fmt += " {{:>{}.{}f}}".format(db["runtime_info"]["acc"], time_precision)
-        fmt += " {{}}{{:>{}.{}f}}".format(db["runtime_info"]["mean"], time_precision)
-        fmt += " {{:>{}.{}f}}".format(db["runtime_info"]["median"], time_precision)
-        fmt += " {{:>{}.{}f}}".format(
-            db["runtime_info"]["min"] - decimal_precision, time_precision
-            )
-        fmt += " {{:>{}.{}f}}".format(
-            db["runtime_info"]["max"] - decimal_precision, time_precision
-            )
-        fmt += " {{}}{{:>{}.{}f}}{{}}{{}}".format(
-            db["runtime_info"]["max_at"] - time_precision, decimal_precision
+        len_pid = db["task_info"]["pid"] * fix_csv_align
+        len_tid = db["task_info"]["tid"] * fix_csv_align
+        len_comm = db["task_info"]["comm"] * fix_csv_align
+        len_runs = db["runtime_info"]["runs"] * fix_csv_align
+        len_acc = db["runtime_info"]["acc"] * fix_csv_align
+        len_mean = db["runtime_info"]["mean"] * fix_csv_align
+        len_median = db["runtime_info"]["median"] * fix_csv_align
+        len_min = (db["runtime_info"]["min"] - decimal_precision) * fix_csv_align
+        len_max = (db["runtime_info"]["max"] - decimal_precision) * fix_csv_align
+        len_max_at = (db["runtime_info"]["max_at"] - time_precision) * fix_csv_align
+        if args.summary_extended:
+            len_out_in = (
+                db["inter_times"]["out_in"] - decimal_precision
+            ) * fix_csv_align
+            len_inter_at = (
+                db["inter_times"]["inter_at"] - time_precision
+            ) * fix_csv_align
+            len_out_out = (
+                db["inter_times"]["out_out"] - decimal_precision
+            ) * fix_csv_align
+            len_in_in = (db["inter_times"]["in_in"] - decimal_precision) * fix_csv_align
+            len_in_out = (
+                db["inter_times"]["in_out"] - decimal_precision
+            ) * fix_csv_align
+
+        fmt = "{{:{}d}}".format(len_pid)
+        fmt += "{}{{:{}d}}".format(separator, len_tid)
+        fmt += "{}{{:>{}}}".format(separator, len_comm)
+        fmt += "{}{{:{}d}}".format(separator, len_runs)
+        fmt += "{}{{:{}.{}f}}".format(separator, len_acc, time_precision)
+        fmt += "{}{{}}{{:{}.{}f}}".format(separator, len_mean, time_precision)
+        fmt += "{}{{:{}.{}f}}".format(separator, len_median, time_precision)
+        fmt += "{}{{:{}.{}f}}".format(separator, len_min, time_precision)
+        fmt += "{}{{:{}.{}f}}".format(separator, len_max, time_precision)
+        fmt += "{}{{}}{{:{}.{}f}}{{}}{{}}".format(
+            separator, len_max_at, decimal_precision
         )
         if args.summary_extended:
-            fmt += " {{:>{}.{}f}}".format(
-                db["inter_times"]["out_in"] - decimal_precision, time_precision
-            )
-            fmt += " {{}}{{:>{}.{}f}}{{}}".format(
-                db["inter_times"]["inter_at"] - time_precision, decimal_precision
-            )
-            fmt += " {{:>{}.{}f}}".format(
-                db["inter_times"]["out_out"] - decimal_precision, time_precision
-            )
-            fmt += " {{:>{}.{}f}}".format(
-                db["inter_times"]["in_in"] - decimal_precision, time_precision
-            )
-            fmt += " {{:>{}.{}f}}".format(
-                db["inter_times"]["in_out"] - decimal_precision, time_precision
+            fmt += "{}{{:{}.{}f}}".format(separator, len_out_in, time_precision)
+            fmt += "{}{{}}{{:{}.{}f}}{{}}".format(
+                separator, len_inter_at, decimal_precision
             )
+            fmt += "{}{{:{}.{}f}}".format(separator, len_out_out, time_precision)
+            fmt += "{}{{:{}.{}f}}".format(separator, len_in_in, time_precision)
+            fmt += "{}{{:{}.{}f}}".format(separator, len_in_out, time_precision)
         return fmt
 
 
@@ -467,13 +516,15 @@ class Summary(object):
 
 
     def print(self):
-        print("\nSummary")
         self._task_stats()
-        self._print_header()
-        self._column_titles()
         fmt = self._format_stats()
+
+        if not args.csv_summary:
+            print("\nSummary")
+            self._print_header()
+        self._column_titles()
         for i in range(len(self._body)):
-            print(fmt.format(*tuple(self._body[i])))
+            fd_sum.write(fmt.format(*tuple(self._body[i])) + "\n")
 
 
 
@@ -531,37 +582,45 @@ def _filter_non_printable(unfiltered):
 
 
 def _fmt_header():
-    fmt = "{{:>{}}}".format(LEN_SWITCHED_IN)
-    fmt += " {{:>{}}}".format(LEN_SWITCHED_OUT)
-    fmt += " {{:>{}}}".format(LEN_CPU)
-    fmt += " {{:>{}}}".format(LEN_PID)
-    fmt += "  {{:>{}}}".format(LEN_TID)
-    fmt += "  {{:>{}}}".format(LEN_COMM)
-    fmt += " {{:>{}}}".format(LEN_RUNTIME)
-    fmt += " {{:>{}}}".format(LEN_OUT_IN)
+    separator, fix_csv_align = _prepare_fmt_sep()
+    fmt = "{{:>{}}}".format(LEN_SWITCHED_IN*fix_csv_align)
+    fmt += "{}{{:>{}}}".format(separator, LEN_SWITCHED_OUT*fix_csv_align)
+    fmt += "{}{{:>{}}}".format(separator, LEN_CPU*fix_csv_align)
+    fmt += "{}{{:>{}}}".format(separator, LEN_PID*fix_csv_align)
+    fmt += "{}{{:>{}}}".format(separator, LEN_TID*fix_csv_align)
+    fmt += "{}{{:>{}}}".format(separator, LEN_COMM*fix_csv_align)
+    fmt += "{}{{:>{}}}".format(separator, LEN_RUNTIME*fix_csv_align)
+    fmt += "{}{{:>{}}}".format(separator, LEN_OUT_IN*fix_csv_align)
     if args.extended_times:
-        fmt += " {{:>{}}}".format(LEN_OUT_OUT)
-        fmt += " {{:>{}}}".format(LEN_IN_IN)
-        fmt += " {{:>{}}}".format(LEN_IN_OUT)
+        fmt += "{}{{:>{}}}".format(separator, LEN_OUT_OUT*fix_csv_align)
+        fmt += "{}{{:>{}}}".format(separator, LEN_IN_IN*fix_csv_align)
+        fmt += "{}{{:>{}}}".format(separator, LEN_IN_OUT*fix_csv_align)
     return fmt
 
 
 def _fmt_body():
+    separator, fix_csv_align = _prepare_fmt_sep()
     decimal_precision, time_precision = _prepare_fmt_precision()
-    fmt = "{{}}{{:{}.{}f}}".format(LEN_SWITCHED_IN, decimal_precision)
-    fmt += " {{:{}.{}f}}".format(LEN_SWITCHED_OUT, decimal_precision)
-    fmt += " {{:{}d}}".format(LEN_CPU)
-    fmt += " {{:{}d}}".format(LEN_PID)
-    fmt += "  {{}}{{:{}d}}{{}}".format(LEN_TID)
-    fmt += "  {{}}{{:>{}}}".format(LEN_COMM)
-    fmt += " {{:{}.{}f}}".format(LEN_RUNTIME, time_precision)
+    fmt = "{{}}{{:{}.{}f}}".format(LEN_SWITCHED_IN*fix_csv_align, decimal_precision)
+    fmt += "{}{{:{}.{}f}}".format(
+        separator, LEN_SWITCHED_OUT*fix_csv_align, decimal_precision
+    )
+    fmt += "{}{{:{}d}}".format(separator, LEN_CPU*fix_csv_align)
+    fmt += "{}{{:{}d}}".format(separator, LEN_PID*fix_csv_align)
+    fmt += "{}{{}}{{:{}d}}{{}}".format(separator, LEN_TID*fix_csv_align)
+    fmt += "{}{{}}{{:>{}}}".format(separator, LEN_COMM*fix_csv_align)
+    fmt += "{}{{:{}.{}f}}".format(separator, LEN_RUNTIME*fix_csv_align, time_precision)
     if args.extended_times:
-        fmt += " {{:{}.{}f}}".format(LEN_OUT_IN, time_precision)
-        fmt += " {{:{}.{}f}}".format(LEN_OUT_OUT, time_precision)
-        fmt += " {{:{}.{}f}}".format(LEN_IN_IN, time_precision)
-        fmt += " {{:{}.{}f}}{{}}".format(LEN_IN_OUT, time_precision)
+        fmt += "{}{{:{}.{}f}}".format(separator, LEN_OUT_IN*fix_csv_align, time_precision)
+        fmt += "{}{{:{}.{}f}}".format(separator, LEN_OUT_OUT*fix_csv_align, time_precision)
+        fmt += "{}{{:{}.{}f}}".format(separator, LEN_IN_IN*fix_csv_align, time_precision)
+        fmt += "{}{{:{}.{}f}}{{}}".format(
+            separator, LEN_IN_OUT*fix_csv_align, time_precision
+        )
     else:
-        fmt += " {{:{}.{}f}}{{}}".format(LEN_OUT_IN, time_precision)
+        fmt += "{}{{:{}.{}f}}{{}}".format(
+            separator, LEN_OUT_IN*fix_csv_align, time_precision
+        )
     return fmt
 
 
@@ -571,7 +630,8 @@ def _print_header():
             "Time Out-In")
     if args.extended_times:
         header += ("Time Out-Out", "Time In-In", "Time In-Out")
-    print(fmt.format(*header))
+    fd_task.write(fmt.format(*header) + "\n")
+
 
 
 def _print_task_finish(task):
@@ -583,7 +643,6 @@ def _print_task_finish(task):
     in_in = -1
     in_out = -1
     fmt = _fmt_body()
-
     # depending on user provided highlight option we change the color
     # for particular tasks
     if str(task.tid) in args.highlight_tasks_map:
@@ -612,16 +671,22 @@ def _print_task_finish(task):
         out_out = timespan_gap_tid.out_out
         in_in = timespan_gap_tid.in_in
         in_out = timespan_gap_tid.in_out
+
+
     if args.extended_times:
-        print(fmt.format(c_row_set, task.time_in(), task.time_out(), task.cpu, task.pid,
-                        c_tid_set, task.tid, c_tid_reset, c_row_set, task.comm,
+        line_out = fmt.format(c_row_set, task.time_in(), task.time_out(), task.cpu,
+                        task.pid, c_tid_set, task.tid, c_tid_reset, c_row_set, task.comm,
                         task.runtime(time_unit), out_in, out_out, in_in, in_out,
-                        c_row_reset))
+                        c_row_reset) + "\n"
     else:
-        print(fmt.format(c_row_set, task.time_in(), task.time_out(), task.cpu, task.pid,
-                        c_tid_set, task.tid, c_tid_reset, c_row_set, task.comm,
-                        task.runtime(time_unit), out_in, c_row_reset))
-
+        line_out = fmt.format(c_row_set, task.time_in(), task.time_out(), task.cpu,
+                        task.pid, c_tid_set, task.tid, c_tid_reset, c_row_set, task.comm,
+                        task.runtime(time_unit), out_in, c_row_reset) + "\n"
+    try:
+        fd_task.write(line_out)
+    except(IOError):
+        # don't mangle the output if user SIGINT this script
+        sys.exit()
 
 def _record_cleanup(_list):
     """
@@ -733,10 +798,19 @@ def _argument_filter_sanity_check():
         )
     if args.time_limit and (args.summary or args.summary_only or args.summary_extended):
         sys.exit("Error: Cannot set time limit and print summary")
-
+    if args.csv_summary:
+        args.summary = True
+        if args.csv == args.csv_summary:
+            sys.exit("Error: Chosen files for csv and csv summary are the same")
+    if args.csv and (args.summary_extended or args.summary) and not args.csv_summary:
+        sys.exit("Error: No file chosen to write summary to. Choose with --csv-summary "
+        "<file>")
+    if args.csv and args.summary_only:
+        sys.exit("Error: --csv chosen and --summary-only. Standard task would not be"
+            "written to csv file.")
 
 def _argument_prepare_check():
-    global time_unit
+    global time_unit, fd_task, fd_sum
     if args.filter_tasks:
         args.filter_tasks = args.filter_tasks.split(",")
     if args.limit_to_tasks:
@@ -769,6 +843,21 @@ def _argument_prepare_check():
         time_unit = "ms"
 
 
+    fd_task = sys.stdout
+    if args.csv:
+        args.stdio_color = "never"
+        fd_task = open(args.csv, "w")
+        print("generating csv at",args.csv,)
+
+    fd_sum = sys.stdout
+    if args.csv_summary:
+        args.stdio_color = "never"
+        fd_sum = open(args.csv_summary, "w")
+        print("generating csv summary at",args.csv_summary)
+        if not args.csv:
+            args.summary_only = True
+
+
 def _is_within_timelimit(time):
     """
     Check if a time limit was given by parameter, if so ignore the rest. If not,
@@ -801,10 +890,17 @@ def _prepare_fmt_precision():
     decimal_precision = 6
     time_precision = 3
     if args.ns:
-       decimal_precision = 9
-       time_precision = 0
+     decimal_precision = 9
+     time_precision = 0
     return decimal_precision, time_precision
 
+def _prepare_fmt_sep():
+    separator = " "
+    fix_csv_align = 1
+    if args.csv or args.csv_summary:
+        separator = ";"
+        fix_csv_align = 0
+    return separator, fix_csv_align
 
 def trace_unhandled(event_name, context, event_fields_dict, perf_sample_dict):
     pass
-- 
2.30.2

