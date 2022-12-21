Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577326538B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbiLUWep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbiLUWei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:34:38 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6250D2BC0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:34:37 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id t15-20020a17090a4e4f00b00225a7107898so2586pjl.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSNQl52T6aONyRJU3JLzaiDjv/uDuW/eBBmo/7p1gyM=;
        b=hWrFQqbUjVIgEbk5/HxS/gkX6UYWMxIViM61QrBDErGTC0CBNoIoSRAGz4VBIy+Jr7
         JswhbaKF216kLto8y6J0fNHcsV3xpaxqEJUkJbD+LHzyL6/kkMwmt8zPho3uLPm5a1tU
         7T0VUBlzwmSB8KANwYWZ61vZ432nW1Ri7IIk/cr49jkIDjO4Oxy7NlMPIhaxhInVLxGy
         ltZAVnrt/pg51qXbCr0/25IVChcILeO1bWJ/6ep813uuo6FrGRblDVK16UPmaEFBryDQ
         ofPEuG9v8tmkKCKD09he2BxVBvloOkyTcDODFbe2QSWp7KFy4BP1B8TDzbO7Dja+3Obs
         xBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSNQl52T6aONyRJU3JLzaiDjv/uDuW/eBBmo/7p1gyM=;
        b=EeIzNo+n6aT0FkViy5jb0WfpwQsr4DITm1mgIwLUdv9Xo3FOCNnmDynHgZnN4LQx/U
         lFMpBPhQxGq6W8iPFIURAcGNsurhJsFXMq9JXeIJBPgBSXYZ82PWoYmlHGd3CGtoYPuO
         oVSskOHyv4NJp7QCHcvcp8hlip70V/2RuW0n68E13w1vAxLUDIxSl8N6UPk+n9MTlhdw
         zcJ7NLlKuhctmIeS21D+EfOYQFOGbsQQbMvqUJEYLIFwDa4bw5ImHPYeHpaUY2Wfpmx1
         JjckEg5e5sNjYHyrpjtFRUGrX4lox7kWSgVMISJktEu4VFvxsiMkKboQdAysSmbbFxPW
         N5dw==
X-Gm-Message-State: AFqh2kpNg6ZLkjMECdioIAhDgtJinbaQ6JGKb5/ATbOXgX8G4fEetWsr
        bdjHAQCSUmgVP4+SEN48h6CSR4d3F9HU
X-Google-Smtp-Source: AMrXdXv2jCTZRqgvHNw/zlM6+eqhzbGTGQXu+45bytWBX9fVfz/bcWmBaNU4rA3CFSzsBRM24pb0+K70sXOG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:62bd:f120:1fd8:1d21])
 (user=irogers job=sendgmr) by 2002:aa7:8ecc:0:b0:57c:ec11:dc0a with SMTP id
 b12-20020aa78ecc000000b0057cec11dc0amr247300pfr.40.1671662076792; Wed, 21 Dec
 2022 14:34:36 -0800 (PST)
Date:   Wed, 21 Dec 2022 14:34:12 -0800
In-Reply-To: <20221221223420.2157113-1-irogers@google.com>
Message-Id: <20221221223420.2157113-2-irogers@google.com>
Mime-Version: 1.0
References: <20221221223420.2157113-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 1/9] perf jevents metric: Correct Function equality
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

rhs may not be defined, say for source_count, so add a guard.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 4797ed4fd817..2f2fd220e843 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -261,8 +261,10 @@ class Function(Expression):
 
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Function):
-      return self.fn == other.fn and self.lhs.Equals(
-          other.lhs) and self.rhs.Equals(other.rhs)
+      result = self.fn == other.fn and self.lhs.Equals(other.lhs)
+      if self.rhs:
+        result = result and self.rhs.Equals(other.rhs)
+      return result
     return False
 
 
-- 
2.39.0.314.g84b9a713c41-goog

