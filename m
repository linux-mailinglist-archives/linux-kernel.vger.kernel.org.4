Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C119867D9AD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjAZXhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjAZXhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:37:11 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7095253B1D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:37:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b201-20020a2534d2000000b0080b87d910a2so3602435yba.21
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ExyRpkcDLmvPbAA8QgL36/HbLE4lSe5Woy02Q1CnQZ0=;
        b=b7HSkW9BPwilG22qgpz9e/XOczfoW9yCKXfLOvRsQ9wBfqrGhxw2TaKrwXSt1PVsdd
         M84LPosr6r3kuqQWcN/LiSEFmX+TevYFm1LpD7/Li9Wl50Vsaf3LCddQumROgGmGUQQo
         epcbUYKS1qYwHxdY3eYWhKb5WXtHQlyT4DGWMlEDAMRxU6fx9f/ndV3g1nvwZ0EbCP4u
         7PWHk+CStL2Y52640ZelIpaMIrqnKYJMMCSRgY4Yf4cjgJ/FlSpmQMgJ2ek0reIkgHqU
         qVc2P92NXw7JlhdQKxeHJhHhZGm/8MMORkIPhEqswrvqLVXc9MnbKxUzglvGNAe127by
         LbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExyRpkcDLmvPbAA8QgL36/HbLE4lSe5Woy02Q1CnQZ0=;
        b=doQcFD9mojNjKTen28N97TLD1+ulB1Mgt0zrc8XOWerNck32C/8wpjFvv8j1WVP93f
         oC6a5m5jEuzkP3Imi9Q//3+Ieslscd9iHeD8RlnrfszHCDaeom+iz9pDXxEIKlU7kizO
         4b61lRKjyy23aU1a9PcBlxIMbmU7W18JtJLIMcfClBT997PR0DVH/4mJEwKa2JnTYmum
         rEaz32I2XdbVdVb4GsD8RQub3MtuZwwWnK5DrcAUKxInI4g966CvY61+gPgyc0S6aGGr
         NkDI74ydOJErAJU1ut9dS5QyTMtIDv8GrYOLbYVIjNmMuqf3g9Y2Rt5uOJc3DqrV6lRH
         BN0Q==
X-Gm-Message-State: AFqh2krZ7xJFOjJZbTCJGlCKlDAFqsQQ4R+35sEOC2M6XvcaLqwoCPjk
        KlSNRm5dOf8a21Y1USFFfQrShhkLeR5y
X-Google-Smtp-Source: AMrXdXuVZJSXhsLBJF4s+rqkvT9ejKCkIXS7lhPHPbiIAmWd7TUMwVa2Yo0mIGWQgyijPi/6uHMwa59GCZY/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b9b8:6de0:39b3:4cf7])
 (user=irogers job=sendgmr) by 2002:a81:ed4:0:b0:4dd:c62f:d65a with SMTP id
 203-20020a810ed4000000b004ddc62fd65amr3419482ywo.427.1674776225629; Thu, 26
 Jan 2023 15:37:05 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:36:31 -0800
In-Reply-To: <20230126233645.200509-1-irogers@google.com>
Message-Id: <20230126233645.200509-2-irogers@google.com>
Mime-Version: 1.0
References: <20230126233645.200509-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v5 01/15] perf jevents metric: Correct Function equality
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

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
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

