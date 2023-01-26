Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA12367C248
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 02:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbjAZBVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 20:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbjAZBVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 20:21:05 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28D364DB6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:20:34 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-507aac99fdfso3884007b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LYQmk36LwpH1amM5NS/JZnLvaK2yBpvx1p5Vz+enrHo=;
        b=g5kNYx2i/3N21JTuAlpQ2Fzr0z4yS5BF5bpwKl6uBD9aJAt61CO1Cxf2wOs6Z6Le4j
         woG9v16pTQyq6MRJ3l0+3Q8SwZomo4kn2dMJ78fwpX9TiUULdeKPKPQMgJLHQXfeSljh
         Tz8qAv3zT6uOZvOFT6MlpOMURNETaASAXkZOz5R0qIHG4KfR+qUenefEszI6IbhmlxAo
         DpbMgACRE0CV+GOVDn/CN0GOTKRfvezhoZgYafaFwo4iXRIsRJVYG9QTqaDNxbb/vvIh
         VahpBNlPSFCRJFvx7tii4AcdZRcpXXE8FeDomLyGIK6NHSUIJ2OeVzRVYe+oWOrxZQw+
         LZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYQmk36LwpH1amM5NS/JZnLvaK2yBpvx1p5Vz+enrHo=;
        b=uU+r72HbdQqGaGS/T5G3PmNanrxSpTpBuoIRxsKl//bu9wpqGzf5mW8Yotq24JHlQs
         Ai34joPs+MCxFwXMtq+EERmK/cZFNueUmPt6oAu3qZ9NBlCUHX6jDT5R3UVk5n6QvhUY
         +XGyKqJnpl1XMgqkP7bsaJW3U4azuR7rCJ92GiBDEImudN9Ipd4LHxDglSPk4ZP7A4Am
         4I3kJx374qRZDOcemIh8zl964CViMW6FWnTrgi+Wk+Sragf26znC0yQ8pyLZ0RH4ppgs
         uTTPIefcO2p4S8lSg7U4E6LB37T9hHmGHPLlqTwLbcO65uHPy62O7a3BzEm0LbKKNALm
         Qjkg==
X-Gm-Message-State: AFqh2kpp+/XMNvc/CAu1sRdwskWhtLIdsagQC6hJknl3a79OACBV0lNu
        JmL3lZ0o49LAb4XD4nX4ISVaJ1Kcy0o1
X-Google-Smtp-Source: AMrXdXtJyXEuVpA/fKT4Gs+OHOHp62Ve2MgKmevUrheQ5iCrugGv01d4Et9NsO/jcVDyYhqORA5ZqbJKTjoZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:568d:4d98:b468:b025])
 (user=irogers job=sendgmr) by 2002:a81:5c02:0:b0:4e2:db5a:2c2c with SMTP id
 q2-20020a815c02000000b004e2db5a2c2cmr4504216ywb.202.1674696032312; Wed, 25
 Jan 2023 17:20:32 -0800 (PST)
Date:   Wed, 25 Jan 2023 17:18:53 -0800
In-Reply-To: <20230126011854.198243-1-irogers@google.com>
Message-Id: <20230126011854.198243-12-irogers@google.com>
Mime-Version: 1.0
References: <20230126011854.198243-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v4 11/12] perf jevents: Add model list option
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

Signed-off-by: Ian Rogers <irogers@google.com>
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

