Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354EE728BCB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbjFHXaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbjFHX3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:29:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3233586
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:29:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-569fee67d9dso24997827b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266979; x=1688858979;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFeBvXSDSdHQDEP4y6c+chE/HON9+ZqSLzpectqZUCI=;
        b=CLN02UU5+WWzs/zPaD+MM1F2zbmnBKDuiddMFb9fykdDg8v+BAKC13PIbVSZQ6g9ly
         oTUlgCMkciNJoajBVI0uGTHyF/vmH7VJ4+Sb5R4dLOQkddMLf1VuCqiFZwdxSuAItV4L
         DxWB+919dwyqi59uSrIKdxJN5rQTc15QIw+PQ6PuSrI7oqBp/YHq7dWYhAtlfld5BbNk
         sAHJvW+pf00vZhaCk85of58remxSTvBSBHGMPn4FXEcFieVNaE+1T8cIn9DiOzGn+jNb
         tUbPL+XZ2UiXIVrWL8Xyw+Lh+o3cdPXrehaQmYAr5NmvLNK9padtYiFhZACY7jOfLEPT
         qJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266979; x=1688858979;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFeBvXSDSdHQDEP4y6c+chE/HON9+ZqSLzpectqZUCI=;
        b=IQ3+5u0aaQSqflNFQ5UMNbxPe1p6v/8DwM29Cr9VzQveqe+vt1Lcn9K1Mes5jCL1mA
         NKr5t7cX6FUTE3xxCR3OTJ7wZarc4rFedcdTLzTDv4rB6UCIK8G5XO4xwnjLOfmU5KEz
         t8L743cnAHW/aP0Cl5eTtEnMgZ900lEqrDn8fXKIuE/3T4WXXZqMxnvRMxbDUrXpJPoi
         S4DTgYjhD/kKnxV6mUgIwjpbcOS3QO9PlGXNIdkoKu5wpP03J+6rHcnU7jzDUq0Z2YYh
         tyzTNWyi6kJ4JVE/lWIMpN1bR8HTdD0YYOtbJfuto+zgV7IWzjTMwLJo1i/WRrgLJJpZ
         hrgg==
X-Gm-Message-State: AC+VfDwvx/sm4peh6bsRhOlW5vRkkHkR4vjDLzflqj4DFxB2BHAGXKbq
        KyQPxgImBnY+DUuKBa1zmcyBpFIuCvrL
X-Google-Smtp-Source: ACHHUZ5/rW08nMMKbcCklsjhO+BefYDtbEPUgG16zWlSlryuKZJhC19hBweHC5TODNtYqaCE3NLDu2QjlebL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a05:690c:2901:b0:55d:9e7c:72c0 with SMTP
 id eg1-20020a05690c290100b0055d9e7c72c0mr648209ywb.0.1686266978828; Thu, 08
 Jun 2023 16:29:38 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:08 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-12-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 11/26] perf stat: Avoid evlist leak
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
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free evlist before overwriting in "perf stat report" mode. Detected
using leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c87c6897edc9..fc615bdeed4f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2427,6 +2427,7 @@ static int __cmd_report(int argc, const char **argv)
 
 	perf_stat.session  = session;
 	stat_config.output = stderr;
+	evlist__delete(evsel_list);
 	evsel_list         = session->evlist;
 
 	ret = perf_session__process_events(session);
-- 
2.41.0.162.gfafddb0af9-goog

