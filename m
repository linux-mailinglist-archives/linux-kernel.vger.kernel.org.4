Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C7E67D9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjAZXjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjAZXjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:39:40 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39686E434
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:39:05 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-509ab88f98fso28377377b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yQHRXERZFizphhJ63mW6mIE9BNCBXqYeW1Mn7KMwfU=;
        b=Y/sQCucBClKQsTlXfwP8ONsiTL9RBPVsVmQF37414RJnG7UMV4/CLL3uZgMmJMXlNI
         bmcqCC6rD4WN3YgsoeoeLzw8JmATIoAQDNMUufDoROLYDCNnC2CJ6kutrZrVTpofZUPb
         Rtvndbylyci2/1G8lrvGJRIbW/Oh8eZ3fFBgdOrVGger8kG8DIrc0JHOj9P1vAjFUywa
         seo641oGr/QFHGj4MNa0LJYVvArR5kd8jFfji8UmGXmYyDiBIXi7XL8HXfoJyISEJOr4
         7vkN1CEc6H95EKbtasAdsf/amK+ceYtHrq6/lI0J4iqtFjcBun8/pqQviQk6V/ay37zd
         YebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yQHRXERZFizphhJ63mW6mIE9BNCBXqYeW1Mn7KMwfU=;
        b=3Jk8Q2f0NR0GKIxbdJjRG5o+m8MTzzbTtzhIwGT4s4aXPguwCOueLvs1CchEVGrvYQ
         DJnhxku8pmKeRziWw2p+oHqg0vmYE6sbWrkGKW+ajhuKj/EtsXJdPRru5p71EJhcxiS+
         43868BN3V+fQOoDVr0ThVQbWpnjh+4Nb8pOwfe+I+6vNi9vqiHFme5T2Yy/wMcff8CHJ
         ziPf8gQQhX8EacV6V8kyu9JqLOoAxwL+2CWHxSpyiUN/0VPPxotY85f/qEe6sb98SssQ
         NHd+I5wWGovb7FmGapxOmQSjQHmqX4dM+TEE1ImHVDwLsrQCS8kvFJn9HvR/1dPwxcsR
         ZqYg==
X-Gm-Message-State: AFqh2koFug+A85X5+HLk/br8R5zQ3IwWNPj6/ceJn+gW5QDJw2XiJoSt
        q2ODAd5IMjwU86A4xsERMUsEDYWtmcRO
X-Google-Smtp-Source: AMrXdXvjSOd1GSGigNKbLZhLK5pRh1N/XxjXT7JcXzHRlezRc4DR2tD5b4t3IXtvKemh8xSO34tQlBHylaTn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b9b8:6de0:39b3:4cf7])
 (user=irogers job=sendgmr) by 2002:a25:24c4:0:b0:803:197f:3f41 with SMTP id
 k187-20020a2524c4000000b00803197f3f41mr2749703ybk.489.1674776330013; Thu, 26
 Jan 2023 15:38:50 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:36:45 -0800
In-Reply-To: <20230126233645.200509-1-irogers@google.com>
Message-Id: <20230126233645.200509-16-irogers@google.com>
Mime-Version: 1.0
References: <20230126233645.200509-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v5 15/15] perf jevents: Run metric_test.py at compile-time
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a target that generates a log file for running metric_test.py and
make this a dependency on generating pmu-events.c. The log output is
displayed if the test fails like (the test was modified to make it
fail):

```
  TEST    /tmp/perf/pmu-events/metric_test.log
F......
======================================================================
FAIL: test_Brackets (__main__.TestMetricExpressions)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tools/perf/pmu-events/metric_test.py", line 33, in test_Brackets
    self.assertEqual((a * b + c).ToPerfJson(), 'a * b + d')
AssertionError: 'a * b + c' != 'a * b + d'
- a * b + c
?         ^
+ a * b + d
?         ^

----------------------------------------------------------------------
Ran 7 tests in 0.004s

FAILED (failures=1)
make[3]: *** [pmu-events/Build:32: /tmp/perf/pmu-events/metric_test.log] Error 1
```

However, normal execution will just show the TEST line.

This is roughly modeled on fortify testing in the kernel lib directory.

Modify metric_test.py so that it is executable. This is necessary when
PYTHON isn't specified in the build, the normal case.

Use variables to make the paths to files clearer and more consistent.
---
 tools/perf/pmu-events/Build          | 13 +++++++++++--
 tools/perf/pmu-events/metric_test.py |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 tools/perf/pmu-events/metric_test.py

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a14de24ecb69..150765f2baee 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -6,6 +6,11 @@ JDIR_TEST	=  pmu-events/arch/test
 JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
 			find $(JDIR_TEST) -name '*.json')
 JEVENTS_PY	=  pmu-events/jevents.py
+METRIC_PY	=  pmu-events/metric.py
+METRIC_TEST_PY	=  pmu-events/metric_test.py
+EMPTY_PMU_EVENTS_C = pmu-events/empty-pmu-events.c
+PMU_EVENTS_C	=  $(OUTPUT)pmu-events/pmu-events.c
+METRIC_TEST_LOG	=  $(OUTPUT)pmu-events/metric_test.log
 
 ifeq ($(JEVENTS_ARCH),)
 JEVENTS_ARCH=$(SRCARCH)
@@ -18,11 +23,15 @@ JEVENTS_MODEL ?= all
 #
 
 ifeq ($(NO_JEVENTS),1)
-$(OUTPUT)pmu-events/pmu-events.c: pmu-events/empty-pmu-events.c
+$(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 else
-$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY) pmu-events/metric.py
+$(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)
+
+$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
 endif
diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
old mode 100644
new mode 100755
index e4c792428277..40a3c7d8b2bc
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -1,3 +1,4 @@
+#!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 import unittest
 from metric import Constant
-- 
2.39.1.456.gfc5497dd1b-goog

