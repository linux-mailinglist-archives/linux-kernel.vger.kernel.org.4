Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E7670CB61
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjEVUlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjEVUlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:41:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D10B9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:41:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-564f6099813so28504147b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684788092; x=1687380092;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDof+QoJIpcW+bcC8mIq1dIhSy6Tx4m7myi7gPf3qCM=;
        b=hL4XZqmAmsZBqISb5cs2SY76dW2m/n3/dRqTTMYPVdlAsjXvYxhCKl/wYIuYN5dH1y
         M/Zgkcj29Ps7yZkdxvqlqLB071q0vvvwDPGSr8posF4+n+m/gUhclexIkD3Olk2KeqQV
         pTVYcM1HHnrL4uS435VahAb4o4/PTyTyKImzzctxQZvjJGnw4XTMrdTRjjKdnyjt0ZLi
         TIAogLgYmgvk031sY5cMg+7HCGNuWb8K3lzAN+pNqd33I//tCNpkQTjvyPsw67LorTaF
         hdFLUxCf9oAxG+uLPCDIzzVkbJwxtYLshP/HM2YZJzL+KgSUM1yh/o0jmt3XpS5ll4w6
         ztZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788092; x=1687380092;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDof+QoJIpcW+bcC8mIq1dIhSy6Tx4m7myi7gPf3qCM=;
        b=QH5InQzPF+XQ2D0k8YeiqtJvoV9crjkBngTkzQqvMLghZmcD+GG5l1XBgERUJ4FJv9
         sSdtFa4nCVo70aStzkJkGdcwPXOMBAGllccocvrQsPDOKqbN+Lrg8jWRl5i+MLjemCwu
         qGPITIaybATvrO2OPAy4D5HDQaR3Lwxfnn6UVQtypuaQVa+btGlLgpzPuV2VWIdsJMtA
         BVZAlsg/mOYDY3FgmPrI6rxnFaQhco2f0rWE3SAP6lki9Cpjg3nRVH/jk+w4rFeE6WTE
         +vE+Dbi6928Zj78WKnNxzK4vvbuU544pTETy/3TyFxJUQEPicOxzBPpWM5Q5T9ebR+Uu
         UPlQ==
X-Gm-Message-State: AC+VfDxOZ3uPfX3PgIxYAxgaWbjvj35Djpdy6cJhuU1ttzcohqPN2WFi
        HRJjqQmqlJ3c4qSAYWLDKb12k5TfMiOC
X-Google-Smtp-Source: ACHHUZ6Ij6MmJUxaDx9xqk58WsfpUW60Sf6BCP5q+Vjx4RkK5eARDpLpq/+ExNmPLc2gquPDbKFREdVnHLrA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:33a6:6e42:aa97:9ab4])
 (user=irogers job=sendgmr) by 2002:a81:ad09:0:b0:559:e97a:cb21 with SMTP id
 l9-20020a81ad09000000b00559e97acb21mr7115495ywh.9.1684788092608; Mon, 22 May
 2023 13:41:32 -0700 (PDT)
Date:   Mon, 22 May 2023 13:40:47 -0700
In-Reply-To: <20230522204047.800543-1-irogers@google.com>
Message-Id: <20230522204047.800543-4-irogers@google.com>
Mime-Version: 1.0
References: <20230522204047.800543-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 3/3] perf test: Add build tests for BUILD_BPF_SKEL
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
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests with and without generating vmlinux.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/make | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 8dd3f8090352..775f374d9345 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -69,6 +69,8 @@ make_clean_all      := clean all
 make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
 make_nondistro      := BUILD_NONDISTRO=1
+make_bpf_skel       := BUILD_BPF_SKEL=1
+make_gen_vmlinux_h  := BUILD_BPF_SKEL=1 GEN_VMLINUX_H=1
 make_no_libperl     := NO_LIBPERL=1
 make_no_libpython   := NO_LIBPYTHON=1
 make_no_scripts     := NO_LIBPYTHON=1 NO_LIBPERL=1
@@ -136,6 +138,8 @@ endif
 run += make_python_perf_so
 run += make_debug
 run += make_nondistro
+run += make_build_bpf_skel
+run += make_gen_vmlinux_h
 run += make_no_libperl
 run += make_no_libpython
 run += make_no_scripts
-- 
2.40.1.698.g37aff9b760-goog

