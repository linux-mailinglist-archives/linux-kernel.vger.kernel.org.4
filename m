Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339326538C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiLUWgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiLUWgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:36:06 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2D426FA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:35:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 195-20020a2505cc000000b0071163981d18so7377ybf.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p9uUKF5YT7W7omOcdy9d3QDDHSBY8arxpPiHsWUJZko=;
        b=QWG7vv893Fsft377ZiIohUY3mci0ZHvboSz90Qtk5dlscqS3WtTs9bp3VkqZ8fFUfb
         uC9G5MVVReAD5r/ifHRJ0SqT/QYETEqHYXJaIxUkVaFwdkc69sayzhiCJraFZPxuFcJY
         c1w4TdXEu2yhQvUg2SoLqtib0bpQonLrkWT6CAZH27GXwAjADBWQmQxNe7J+JXjSXXFl
         NHOLtAzOlq+3T3YdK7g0Iwsq4iuy+l6VIsoYY0PfeNbSBAxMYFgNKM7AbiZ/AAZiPTP/
         /AdtRUYS1O89JYKyxQ4dIN0DHdnJMVqdne2EqrrR8xlBgs+Fz/a8EqhT2/cTM4ZspvM1
         1BOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9uUKF5YT7W7omOcdy9d3QDDHSBY8arxpPiHsWUJZko=;
        b=iBJ8XSILh9QMPmKrRdG5658pbYx5U8f6UkPTtKz94WGRpFOKr7tG9bcNdzJ9xmGtPw
         Wnu7Yz46zSGCox63XsnhFDbaC8+Muz/HGJgBEAH50viHVCtnJ+P4CV7MkSMPCDWcpIVG
         s+mffTLYOQcocZxbhxdN9dQ1zZYhxttBI6+nEz6bFm2B/CGjXw/L9Iznco57q+yLhLMn
         t5Us77X974ZD8ugkJxEj4J+gBsDfTHJD8MwgY88JcIWAUJW5mVvZT3BBd2LxPNjr7JFv
         1LjAjVlkuucA5hVNAB7UwJUjJOyjAespCK93C3h68ODoQ9bhpLRjSScsUpuwSC3u34QN
         CRlQ==
X-Gm-Message-State: AFqh2koKIDI7aQfNWmMGVgqAmQuoEgvk8BS54nxH8K2JenuOH3jrEv8B
        KpPlDs50cXxAGnimsZCJFcgy69ijKYMe
X-Google-Smtp-Source: AMrXdXvNtX43k+EPvJLZ0aSkd2dIE7T4zDEJjE4B+TFFw+ofvO7b8R813qBnWYQ66EFhBrUxEvMDZT7JHCtT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:62bd:f120:1fd8:1d21])
 (user=irogers job=sendgmr) by 2002:a25:23d8:0:b0:6fb:67c7:33e1 with SMTP id
 j207-20020a2523d8000000b006fb67c733e1mr415565ybj.255.1671662140943; Wed, 21
 Dec 2022 14:35:40 -0800 (PST)
Date:   Wed, 21 Dec 2022 14:34:20 -0800
In-Reply-To: <20221221223420.2157113-1-irogers@google.com>
Message-Id: <20221221223420.2157113-10-irogers@google.com>
Mime-Version: 1.0
References: <20221221223420.2157113-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 9/9] perf jevents: Add model list option
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
2.39.0.314.g84b9a713c41-goog

