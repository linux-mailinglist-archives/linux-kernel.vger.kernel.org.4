Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E8E73BB38
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjFWPLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjFWPLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:11:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177212959
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:10:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bfec07e5eb0so1152809276.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687533039; x=1690125039;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbVKkaPWXAVNKNh1CW8R2oY532WwWiXP5nT3QKlBBnU=;
        b=vU5EMJOqgJyjuf6oMjP3eYqV5oZcVODZ2DycPDXEAR3DL4Uh3QlyZvy3EVx3Qfl10j
         1Y66GEKJEORy4XU2Ls2sXcoZw/hhvMoqjh8PoWCQGLDyoSejBP0fkcxUxOuFtN+FTGrh
         gWveHqtpFlKeruJfUPow/9m8m4rXSz5Z+Hr3UFl0VsohIZ1tVx581ZHeCsRKn+NYveYA
         KBk0wNh2IxFdeCmBY3i9yXpQ6o0569eVjqLgyCMHTCggK39f3Bl9tiu99mQiOVKApm4W
         Efoci3DdXd1iy2RsAmT/br3/843FEfpR/G/9QO3QQxABTu53SoHdWCVqvF6v2o5yXRFU
         4LIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533039; x=1690125039;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbVKkaPWXAVNKNh1CW8R2oY532WwWiXP5nT3QKlBBnU=;
        b=P+kYU6a8FynH0ZtejkCMfVC4BXEdnM5mWEgP9Xel2PC1Nl8fjsMoMD/1WWTEmGwFeW
         i8/zrwMuZ96Vn9pUZCIy9rUqtzz29loOIxO3kAG63mqbN2mQVq2QJwripf3RntlPLR27
         QWTvmIaIL8D0Td1ddPwk04WzYgBxxjn2JUCBBtXiB+sPoqBpJPOKvY55nAykat2cDEdv
         WMZnP8NCfGpzWhFLQA9c04h14fbi4lYXbNW6cnGT1QDbkUV3wR4uhlKdouVkGlXkwCiT
         yPFLO4Y1hh1cHAfV9OzDPkVxy2pv58JBMNP9s2PkrtDNPIgJKFpP/OaKhSLGymc9MRzn
         t1Mw==
X-Gm-Message-State: AC+VfDyy2swz8L5FU6yrEnaUlXBBqX+3Pe8ppSMfEZ92l0ZYFODvU/qx
        rNYlZCJkFa1VLrh1ursEYr5J+fpDVJZg
X-Google-Smtp-Source: ACHHUZ7Oj7PYMfj8umh+RnQOhnMUR+dcjSbU75/Urxl0UyXXlV6mPll8kv0KpVxT3g6YZTk5ZWmaJR+aRI3h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:d658:0:b0:bbb:8c13:ce26 with SMTP id
 n85-20020a25d658000000b00bbb8c13ce26mr9861677ybg.11.1687533039349; Fri, 23
 Jun 2023 08:10:39 -0700 (PDT)
Date:   Fri, 23 Jun 2023 08:10:06 -0700
In-Reply-To: <20230623151016.4193660-1-irogers@google.com>
Message-Id: <20230623151016.4193660-3-irogers@google.com>
Mime-Version: 1.0
References: <20230623151016.4193660-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 02/12] perf jevents: Support for has_event function
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the new has_event function in metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index af58b74d1644..85a3545f5b6a 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -408,6 +408,12 @@ def source_count(event: Event) -> Function:
   return Function('source_count', event)
 
 
+def has_event(event: Event) -> Function:
+  # pylint: disable=redefined-builtin
+  # pylint: disable=invalid-name
+  return Function('has_event', event)
+
+
 class Metric:
   """An individual metric that will specifiable on the perf command line."""
   groups: Set[str]
@@ -539,7 +545,7 @@ def ParsePerfJson(orig: str) -> Expression:
               r'Event(r"\1")', py)
   py = re.sub(r'#Event\(r"([^"]*)"\)', r'Literal("#\1")', py)
   py = re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
-  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count']
+  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'has_event']
   for kw in keywords:
     py = re.sub(rf'Event\(r"{kw}"\)', kw, py)
 
-- 
2.41.0.162.gfafddb0af9-goog

