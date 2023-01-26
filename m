Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEAB67D9BC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjAZXjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjAZXi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:38:56 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149C39EDD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:38:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o1-20020a252801000000b0080b8600bdc9so3596071ybo.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IwLDElolHzeZLKuISE9CI+5UsjDPN8soJqHYYoHyVfU=;
        b=mUVaju3nOKChRdBXbRrG511ZdgeydKkpFLygk8N9IPus6RUGwOirgTw3T6gdfTfzr2
         ri2wpt+PrZ42Xn071wp+LQhqH+elR/Nhbz7KYAQnHJlHyNNLoKZpCvvBG10Yl6WQp5aB
         c0RgZOrBDK8Uw0YakyZNIx9PANqn5sClNxkHQRGcotQ/ARkKa5jR0XxJTlVECLtXQWrB
         egfCOCLsUNdY589QTAYSBtfFFgAXhNKt8rbTYZVi6OPusPOvrIqGxaiKZ1+wMgAPfyFY
         7kjQdlvg8gkyYZkY2CDPI3EukUo8dYC249pP6eTQxENksi+EprnuE1duKfwv/RJUDlwJ
         NIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwLDElolHzeZLKuISE9CI+5UsjDPN8soJqHYYoHyVfU=;
        b=yC6TQ+INEneGIqIjVQ8mrjzRnJ/RVDpRxFboy3+2xgLnRaYwZKzAo4T6CeTHIALQzU
         Q26o9Py4h7Odg/M0EWYwnqUagmYrlm15jYSD+r0RqMkAvLiY/Rvyc/IywXpN9lOMsjpy
         Lm57uY2oVK3RRjfwkJQnTXxCv/DkF9bODnnQkWImMPH3Mglbb2kpKaUJi8zCiaQDGqyF
         hkDp4TTGpz9Gz1hn35NCliywWan5FBvqO/x+9ySaR9DLWAMYKqI3wT+p6O/p9tFbxSWW
         Gdy2c3JplIjih7HWcwGwS9khofYS/wnqenFflRSqvDswgD8Qm+65onlRVdMIUOSlj06r
         RF4A==
X-Gm-Message-State: AFqh2krVKSjCY3OVTLNWUJfBvLq0qVkEdm3HQqPZdzNioZO8fHULPysr
        9bVGaO4SEJFd20qVs/BxtGnOjwDJwUAK
X-Google-Smtp-Source: AMrXdXurlT/MBprPyUf0wEkWYa4By5hnxMjN10TK8OtYnoQ9X72UaUExeqjlvkTePRgt8wZMr3APhFQ44gi9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b9b8:6de0:39b3:4cf7])
 (user=irogers job=sendgmr) by 2002:a0d:f047:0:b0:4e0:c054:9c60 with SMTP id
 z68-20020a0df047000000b004e0c0549c60mr4471856ywe.490.1674776300084; Thu, 26
 Jan 2023 15:38:20 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:36:41 -0800
In-Reply-To: <20230126233645.200509-1-irogers@google.com>
Message-Id: <20230126233645.200509-12-irogers@google.com>
Mime-Version: 1.0
References: <20230126233645.200509-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v5 11/15] perf jevents: Add model list option
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

This allows the set of generated jevents events and metrics be limited
to a subset of the model names. Appropriate if trying to minimize the
binary size where only a set of models are possible.
---
 tools/perf/pmu-events/Build      |  3 ++-
 tools/perf/pmu-events/jevents.py | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 15b9e8fdbffa..a14de24ecb69 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -10,6 +10,7 @@ JEVENTS_PY	=  pmu-events/jevents.py
 ifeq ($(JEVENTS_ARCH),)
 JEVENTS_ARCH=$(SRCARCH)
 endif
+JEVENTS_MODEL ?= all
 
 #
 # Locate/process JSON files in pmu-events/arch/
@@ -23,5 +24,5 @@ $(OUTPUT)pmu-events/pmu-events.c: pmu-events/empty-pmu-events.c
 else
 $(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY) pmu-events/metric.py
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) pmu-events/arch $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
 endif
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 627ee817f57f..2bcd07ce609f 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -599,6 +599,8 @@ const struct pmu_events_map pmu_events_map[] = {
             else:
               metric_tblname = 'NULL'
               metric_size = '0'
+            if event_size == '0' and metric_size == '0':
+              continue
             cpuid = row[0].replace('\\', '\\\\')
             _args.output_file.write(f"""{{
 \t.arch = "{arch}",
@@ -888,12 +890,24 @@ def main() -> None:
           action: Callable[[Sequence[str], os.DirEntry], None]) -> None:
     """Replicate the directory/file walking behavior of C's file tree walk."""
     for item in os.scandir(path):
+      if _args.model != 'all' and item.is_dir():
+        # Check if the model matches one in _args.model.
+        if len(parents) == _args.model.split(',')[0].count('/'):
+          # We're testing the correct directory.
+          item_path = '/'.join(parents) + ('/' if len(parents) > 0 else '') + item.name
+          if 'test' not in item_path and item_path not in _args.model.split(','):
+            continue
       action(parents, item)
       if item.is_dir():
         ftw(item.path, parents + [item.name], action)
 
   ap = argparse.ArgumentParser()
   ap.add_argument('arch', help='Architecture name like x86')
+  ap.add_argument('model', help='''Select a model such as skylake to
+reduce the code size.  Normally set to "all". For architectures like
+ARM64 with an implementor/model, the model must include the implementor
+such as "arm/cortex-a34".''',
+                  default='all')
   ap.add_argument(
       'starting_dir',
       type=dir_path,
-- 
2.39.1.456.gfc5497dd1b-goog

