Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBDD679102
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjAXGeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjAXGdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:33:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A7270E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:33:40 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n8-20020a258d08000000b007facaf67acfso15360012ybl.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hrci0aclnx4SG+PNpXqw0jPdCljnIUPBJgDYHtxS7o0=;
        b=Hq3ZVOfWgQqRxIWOB+4FxzvfjRtmy1GopQXMkZsA+8+YeJ4Kyn9Q2gtCQyXTsDrqSA
         GDlfFRdm9ok8WRhvj7gZXRmLB2QS21ITqQCXHZd+DRlzxXHEF3oIupQ+Zi31Hx7hTcgP
         s+cEiozK6W2l20afcqO/w9AFEFT+t0fM3XuR2PURu1RpwCbUqe/hzjWRkN3cpxH6pHq4
         45/mp5qA9LnQrQNZGSH6joiDY2pmW/0U/qIiqM7m5CU4W/pzWRQx5KHHzxxYS9pAnvsH
         ugUG1ti08N9rx/um64P55QJ5chI/hwwrRDeIA6hZVKYy+7uM0D2WKbeJxU5NXP7jaN0u
         RwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hrci0aclnx4SG+PNpXqw0jPdCljnIUPBJgDYHtxS7o0=;
        b=etfoxKo9PqnnbaaeUA5vJxTLsLYIa8F/ncBsZB0rXzZ34FPxZWX7ElcoD2f5MMXVa7
         /KYHPWc3YMA7jsfXEftPU6zLYeFO3dHAgncYUV5NNHmXk9LVGlPNv+NmbMySGSlFxwnJ
         4/fGtf/NJS+lgKdQJZaPmMEXWm4sgznMhOvdUMI9ceu2TVmV59cvlFVue4PbYEyqkD4M
         B+n9IaYs1OPr3XVb8dTIbI3nb/kAEtQ2yfCDnjyG7QMXQ0RmBRJxYpKkZBmq2dh86l22
         qEts1qkVr9430E6RMVGzfzJW9lvFLt90j7QfxrqyTtNYvBuxAGBrjSu4zXv+cAHpbOtg
         WQUA==
X-Gm-Message-State: AFqh2koDoKX5onxrXV2OcWViAznzER7XA6wBhfsIELzTQAp032Ut+lC8
        UivrxQLZR/7vFW2Me4tZqdl7Z0XPwCpd
X-Google-Smtp-Source: AMrXdXu/x9zI4gILr9Z+vr39HcNqbhqNUx4RCSSwOXbXohCgJM662wC7GgX3/GUniaakconhQSEM2n5yKhzP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:460d:1b4a:acb8:ae9a])
 (user=irogers job=sendgmr) by 2002:a0d:fe03:0:b0:470:533:cb89 with SMTP id
 o3-20020a0dfe03000000b004700533cb89mr3590620ywf.81.1674542019513; Mon, 23 Jan
 2023 22:33:39 -0800 (PST)
Date:   Mon, 23 Jan 2023 22:33:10 -0800
In-Reply-To: <20230124063320.668917-1-irogers@google.com>
Message-Id: <20230124063320.668917-2-irogers@google.com>
Mime-Version: 1.0
References: <20230124063320.668917-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v3 01/11] perf jevents metric: Correct Function equality
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
2.39.0.246.g2a6d74b583-goog

