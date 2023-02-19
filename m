Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400F169BF78
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjBSJay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBSJar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:30:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95775DBF9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:30:19 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o14-20020a25730e000000b009419f64f6afso2219572ybc.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZekM3DFhsGli0TNli/C0IYKvA9f7AyUZpwfMde3iUAk=;
        b=njwS0zdvPBr2f5Gwgx+MnFdMKJsacyJ3/qym2jLfPEHxAMivAGs+rlWWdk+Du+BWeG
         roLMmds7cxYanNraNuE8rI1XscoaMpSnYds3csTWiUZXGSDGsb+iX6X/mzHsk16/KvNg
         JIRRQggidvMZ9LijU87B8gNDY3B0npD5/KmjFMTlcvpZlx5GcIoFBSm4uQcG+OTZrVCB
         ryA5rcmtM4YDU3yMrGfDKb+E+nYgR15LIJmRsygIIdD202+A6TIyuwJoFUQHcUClbq2W
         k75D//NmRE3BNcT8UUVZbhzSfbsObFP7TGXybtoz712NdmByjrR0HfRP9//XsBj4ATZb
         B3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZekM3DFhsGli0TNli/C0IYKvA9f7AyUZpwfMde3iUAk=;
        b=fkIFPKKN1h2UsXuPX7h36j/deB/HdGMeN0ruy33kiSvEwH2LQv3GWCkfSbOwJavdYs
         JoHNi8WvkDYxmQNpaDwSA0n5RmBseG5fmqJZCuE+8r+c2/XVK+kJFtMaiMMxaUNqsofZ
         5MsC/tiqIS3j+zkN1ZB9wdLNRetgyr5NlEG2OGvnNQXAnjWZg71+1lE9vXmFG62ANZAi
         d9pfzOR0W0eMqVJAhoAu7wi2mmL5kwS4FzBXePV1z2TrQTpem6rT/56aU6bgT841gtYg
         J6yiaz6zUOahtWYA7SHWq5Gvz1fbu0P4FZ8BFXNviUpeJmcERHMJRUck9JXHfO/6h5LQ
         pZdA==
X-Gm-Message-State: AO0yUKUD9R4054MHU0ys3kU72ZqsCYWq3y3d/6hwLrNc0C/CP7zA/qq8
        2MhvjunU6Xo6f7w1ZeYczlMDgMDZi5PZ
X-Google-Smtp-Source: AK7set/0blmTCb8m5UP/yr2PteCnUmUmeiKnVL1fJQupnGlI6ozkeaWut2Dm6E94YEggDJE+VTHQSBLSDCod
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a81:8482:0:b0:533:a071:d7f8 with SMTP id
 u124-20020a818482000000b00533a071d7f8mr449175ywf.547.1676799016916; Sun, 19
 Feb 2023 01:30:16 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:06 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-10-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 09/51] perf pmu-events: Don't '\0' terminate enum values
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
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

Encoding enums like '1\0' wastes a byte and could be '1' (no '\0'
terminator) if the 0 case is '0', it also removes a branch for
decompressing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index dc0c56dccb5e..e82dff3a1228 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -54,6 +54,8 @@ _json_metric_attributes = [
     'metric_name', 'metric_group', 'metric_expr', 'desc',
     'long_desc', 'unit', 'compat', 'aggr_mode', 'event_grouping'
 ]
+# Attributes that are bools or enum int values, encoded as '0', '1',...
+_json_enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg']
 
 def removesuffix(s: str, suffix: str) -> str:
   """Remove the suffix from a string
@@ -360,7 +362,10 @@ class JsonEvent:
         # Convert parsed metric expressions into a string. Slashes
         # must be doubled in the file.
         x = x.ToPerfJson().replace('\\', '\\\\')
-      s += f'{x}\\000' if x else '\\000'
+      if attr in _json_enum_attributes:
+        s += x if x else '0'
+      else:
+        s += f'{x}\\000' if x else '\\000'
     return s
 
   def to_c_string(self, metric: bool) -> str:
@@ -690,16 +695,18 @@ static void decompress_event(int offset, struct pmu_event *pe)
 {
 \tconst char *p = &big_c_string[offset];
 """)
-  enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg']
   for attr in _json_event_attributes:
     _args.output_file.write(f'\n\tpe->{attr} = ')
-    if attr in enum_attributes:
-      _args.output_file.write("(*p == '\\0' ? 0 : *p - '0');\n")
+    if attr in _json_enum_attributes:
+      _args.output_file.write("*p - '0';\n")
     else:
       _args.output_file.write("(*p == '\\0' ? NULL : p);\n")
     if attr == _json_event_attributes[-1]:
       continue
-    _args.output_file.write('\twhile (*p++);')
+    if attr in _json_enum_attributes:
+      _args.output_file.write('\tp++;')
+    else:
+      _args.output_file.write('\twhile (*p++);')
   _args.output_file.write("""}
 
 static void decompress_metric(int offset, struct pmu_metric *pm)
@@ -708,13 +715,16 @@ static void decompress_metric(int offset, struct pmu_metric *pm)
 """)
   for attr in _json_metric_attributes:
     _args.output_file.write(f'\n\tpm->{attr} = ')
-    if attr in enum_attributes:
-      _args.output_file.write("(*p == '\\0' ? 0 : *p - '0');\n")
+    if attr in _json_enum_attributes:
+      _args.output_file.write("*p - '0';\n")
     else:
       _args.output_file.write("(*p == '\\0' ? NULL : p);\n")
     if attr == _json_metric_attributes[-1]:
       continue
-    _args.output_file.write('\twhile (*p++);')
+    if attr in _json_enum_attributes:
+      _args.output_file.write('\tp++;')
+    else:
+      _args.output_file.write('\twhile (*p++);')
   _args.output_file.write("""}
 
 int pmu_events_table_for_each_event(const struct pmu_events_table *table,
-- 
2.39.2.637.g21b0678d19-goog

