Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64B764AF02
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 06:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiLMFGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 00:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiLMFFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:05:19 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466371EC7B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:02:36 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3d3769a8103so157900317b3.17
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFoUQZBIucfBHAzpZJT/16yExsgKsGPFpGFVDTFI4pg=;
        b=Hykjn0YnZLB3e/W/M5ftjBk9hwanekR9hHKWeQOpHf9tKvhLm6AZNZDmkd4/NFAf25
         yaemlLwxvCESBXC9dGW4Zxgkyy+cv0vxBY5LiOeuFMR010snN1MowWY+jAByoeUdtNML
         iSME37bprX3dSNrQ/tBAHgzu7x1rvv7dkgO175shpNCH0tKrWkOAYCvsLbTDXeTHRe9i
         mLuWmua3QlI8w2jF6CC+jt6gNgnTxrVDaxvF8D9kUPLE6e1kliKN+Jpp/o0RzhtpodfJ
         4zj+o/5rBPzWkqyEUr7q2g3h1IL1nik+ahzHd4VL59+Kr3x+D6YSXu/n1jDOukXFC9Pe
         Bp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFoUQZBIucfBHAzpZJT/16yExsgKsGPFpGFVDTFI4pg=;
        b=uPb+mbdfZSQiNMPThsdwxXFAj7A7a5GnyKJCb06lXECSMPmGayIyor2Z/Uw45p1dT7
         8+/wEzCvods/v/gQ3OqyCmsIbskRf6hkBlxFvkYBvPT5xfxJhCfEDtYBX7qR5owN283X
         /etu/6fr1x0NudTQA/bSuo1YfiyLv4Sj9b6a97Xh1AZAdEx9A4nMObaXfZt7IRxlolYC
         sYxie2WY8PwAxkeAkl9nKk/HnU9CovbhH0HEf7Y/pDWAK4t6oEdZM8wruRkhlIMHwaOt
         GHEIs6rRc4bveTARftWTo9jpc3sOP3yQ/e3DcSQXPx9sdB9Sxq7/gyoPZEvzkdetOMvL
         B+2A==
X-Gm-Message-State: ANoB5pkrryQJrDkZHSIMqI6Wk5HDIaGzr8EvKH25DVOTYJTODac+3GlQ
        bgcQYE0qg8EUQHgHU97S3mgPxXVTpNPM
X-Google-Smtp-Source: AA0mqf6VW0VD1o3v3B/fECqbV2MLOC6uD9t9z8sOMvlDeV6Poor8q8adLTZM2LUOhP9KIV9JrkilsnWjwDuv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6b9f:864c:28da:e99b])
 (user=irogers job=sendgmr) by 2002:a0d:e5c4:0:b0:388:7d2:566f with SMTP id
 o187-20020a0de5c4000000b0038807d2566fmr18942255ywe.346.1670907755509; Mon, 12
 Dec 2022 21:02:35 -0800 (PST)
Date:   Mon, 12 Dec 2022 21:00:43 -0800
In-Reply-To: <20221213050043.1199380-1-irogers@google.com>
Message-Id: <20221213050043.1199380-10-irogers@google.com>
Mime-Version: 1.0
References: <20221213050043.1199380-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Subject: [PATCH v1 9/9] perf jevents: Add model list option
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
        SPF_HELO_NONE,SPF_PASS,URIBL_SBL_A,USER_IN_DEF_DKIM_WL autolearn=ham
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
 tools/perf/pmu-events/Build      | 3 ++-
 tools/perf/pmu-events/jevents.py | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

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
index c98443319145..e9eba51e8557 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -886,12 +886,16 @@ def main() -> None:
           action: Callable[[Sequence[str], os.DirEntry], None]) -> None:
     """Replicate the directory/file walking behavior of C's file tree walk."""
     for item in os.scandir(path):
+      if (len(parents) == 0 and item.is_dir() and _args.model != 'all' and
+          'test' not in item.name and item.name not in _args.model.split(',')):
+        continue
       action(parents, item)
       if item.is_dir():
         ftw(item.path, parents + [item.name], action)
 
   ap = argparse.ArgumentParser()
   ap.add_argument('arch', help='Architecture name like x86')
+  ap.add_argument('model', help='Model such as skylake, normally "all"', default='all')
   ap.add_argument(
       'starting_dir',
       type=dir_path,
-- 
2.39.0.rc1.256.g54fd8350bd-goog

