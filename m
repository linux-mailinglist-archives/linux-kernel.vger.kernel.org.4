Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D478367C23C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 02:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbjAZBTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 20:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjAZBTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 20:19:15 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED97861D53
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:19:14 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5065604854eso3742637b3.16
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+u1pVwNx8YIp+mc14zUC+ZcmzjCMVQKlou80yZYqsbw=;
        b=OuJQEMGcjCRTQw5UQ1ZQzjv+z2xhVN1lULZdKwin2IH1/QyPC8VIC1Gg3jqImYyW9c
         R8pR8BxKGestrduQkLk3Iht5Xu3z3ZLvfCNomo1mwvWlN+F/Q6M42RsmyMDVGr1/LXQV
         ybsazzJchbK3NRH1IEx2ErPDiktwoCEIhz3Yco3W1UWbFNzbPyIIeC7wCwUDfjTeCejA
         Nz/EUS7q/DrycNausmVoWMJqsc1yb40KBpyApgEP62+M+iZ9GHgG0aWHwDVYPVtsjZ+C
         oxQ5DBv+lx3Jmm+Zh9OS9ln1af2XHtfAE7QlBnJn39mDcV5SpdE3WdLS9z7KGUCNv47v
         Oauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+u1pVwNx8YIp+mc14zUC+ZcmzjCMVQKlou80yZYqsbw=;
        b=gsYedq68BTU6GIcIv0bRtZ7NB53laRZRdD8HszmihpOXC6YJ3Bax1nu0S7hhRe8d20
         Lm9yzHviMKpFnC9ZlC3aGk6spPr9XFdr5PamEbr3BFdtk/gPI9bWU9m/ESl6p97uBINq
         UaBz0rL04KjhWldSZFJIVTLczDKGYcWfE5cCSTsfvWYlyfdsSEhBmjvfqkenXJmcHSWJ
         n4PSJVWi5CSgsXWf3mPw6sNWn9xuQNSUAruKJd6x2S8dQbEdVqYcGu8Yq7C0x0yloe1P
         YEM8DcaCm+0LdZfiGI01XYY6DfWDOihKnIuHmDDTarICyGNeZYxn8mBWSqXIN/LlUda4
         BwGg==
X-Gm-Message-State: AO0yUKWexRX6NHrHrIYBPy7/9XNKbqChL1RgJBqWBZQvUzKyh9pbbTdx
        fogyzMlhPLfsoCj2/tJfyySyd8LbtVBa
X-Google-Smtp-Source: AK7set9Jn0idMZk3grwkylaxn390n+wWJqHqiG9FwwDRdG90HD+eREktCgKloDte62f3k3u8VVMiomHck39J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:568d:4d98:b468:b025])
 (user=irogers job=sendgmr) by 2002:a0d:f304:0:b0:508:3e6d:8ac1 with SMTP id
 c4-20020a0df304000000b005083e6d8ac1mr127538ywf.207.1674695954541; Wed, 25 Jan
 2023 17:19:14 -0800 (PST)
Date:   Wed, 25 Jan 2023 17:18:43 -0800
In-Reply-To: <20230126011854.198243-1-irogers@google.com>
Message-Id: <20230126011854.198243-2-irogers@google.com>
Mime-Version: 1.0
References: <20230126011854.198243-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v4 01/12] perf jevents metric: Correct Function equality
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

rhs may not be defined, say for source_count, so add a guard.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
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
2.39.1.456.gfc5497dd1b-goog

