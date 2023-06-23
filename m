Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC3173ADD1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjFWAdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjFWAdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:33:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CBD2110
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:33:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb2202e0108so106355276.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687480420; x=1690072420;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbVKkaPWXAVNKNh1CW8R2oY532WwWiXP5nT3QKlBBnU=;
        b=AaRCTITJKd9HyDi4SyAE/11tiqMEY/RRlh2AKpVdV4m4I/mGJRBzN5uOtRHffP2gpU
         uhtqai3wOKIcBOeWqBr4hU8ghT1WeLkBTFWVCx1WDxubDNjZcBaS2eZM9s5pCoPjo9z9
         1QRp2q4qcMyG9zi5uPkOldRzCsPWh5MiXq+as/4S/5Id6M7HDEWFGJGHG65YTRVTN/8J
         f4zh5bPwNTm1moYu4njWQJSd54ouaTpQDH+gfsUsAweAGCWPRTNvijMDkDqH5+ceQguu
         kl+qQQo8H+wmQ8rXnKQuAGeKIeRwZCLavQ9Lp6JKrW88SzkvG/NdYigpVkEkvd17L+gP
         t9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687480420; x=1690072420;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbVKkaPWXAVNKNh1CW8R2oY532WwWiXP5nT3QKlBBnU=;
        b=doOXXRdMhvBRZ8lhTMcbFiOgL78g0Pmkp3vW3+MnoOkijRur8p7Dt9RTMAr7r63X0N
         JNDYM8+ws7T0Jchr4Gfg3FLrlI5ikTejRWfSct2/swfygI8JmRok3x2dOJC2LFnnR+xM
         9IpUbKrcsWBZ6C/xy4BPiqAk8HTUdIJA2jfPhBZcn4LTiZGUt/mgJkqQnWpSbKuJKST/
         bSFdk2GPLEd58i6yJd1SSfcu3MZE9fpR+r3fSLlsMzozN+HQHX2r8Q2k36IX/rGhI+2M
         1U2Lkg/Dr1SBdFAjeh9Dm+85YcpuDYoiIzTHofEhC+WmJz5dJV069yl9Mrd49Rk6z2+8
         a1Zw==
X-Gm-Message-State: AC+VfDwjdqzgl6/In6rr0wTbjCIDyc4EI3YA9K1Li65uvOqRnv+VDz9o
        LMkteXu1IwZelW/TntN+pTjXBzsxGaXo
X-Google-Smtp-Source: ACHHUZ6OJjD/teA9FBh+MFiVaUrzMx+E2xx2BI4tAwweZAbRn/r2rD6fOAUB3scwLjT71V+K06EFs3vEs4pt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a05:6902:1363:b0:bea:918f:2ef6 with SMTP
 id bt3-20020a056902136300b00bea918f2ef6mr2524024ybb.0.1687480419806; Thu, 22
 Jun 2023 17:33:39 -0700 (PDT)
Date:   Thu, 22 Jun 2023 17:33:02 -0700
In-Reply-To: <20230623003312.3981075-1-irogers@google.com>
Message-Id: <20230623003312.3981075-3-irogers@google.com>
Mime-Version: 1.0
References: <20230623003312.3981075-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 02/12] perf jevents: Support for has_event function
From:   Ian Rogers <irogers@google.com>
To:     eter Zijlstra <peterz@infradead.org>,
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

