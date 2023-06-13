Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E89572F0BA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjFMXyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjFMXyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:54:22 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F38131
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:54:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57008cbc58aso172277b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686700460; x=1689292460;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ODADh2/mryUBDglURqREmr6yodTQNUKqEDhn1SIiUKE=;
        b=1+a4OAzheaxWB6Fs48FVvZhPMlhRhcAEKc+wZFy2mYaROQ4/CIjOqFzXHUiDSulmZB
         okFdkxxSPhuwilNsWXqXOqcPgenucYnXrD9w0q57jtsob59xLOuW604UojdeMWqzhmW8
         20HzmDMmHF6XylCkrKZ7n16H8+OnQMH2cSKgRxrVN4bPfx0Gj9d0G029yVzRSbz50ynD
         gs3ot1rGqtxLVQxK1hWyU7JBEzoe9tYoQWf9XqyM1kI2dGENMym0mkFvdDFTS8m8DoWY
         slKSQA1RpFGDM5gYMyLDziVJYn+AbUctI34bB5QPNUHAVqb+dYsoD/kEx/NxwWsNm1K8
         K2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686700460; x=1689292460;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ODADh2/mryUBDglURqREmr6yodTQNUKqEDhn1SIiUKE=;
        b=lQklEeKzsgLnRYgvgJ7nEv1jNuha4ZigZuNzN9zb286bsWDfJ75k/bnIbnILjBese/
         8DO3xomOr3kzsEmZdjLbQVtx+gETJQSfniatn74F+wQA33a4y0NaDCC9KVdd+w9nghLm
         ABTmxTw8mZtScA1btHFL10e9CVfvWiNW0VPCkcJ71RFNWxGDWcV67BxAHgQI6lyodTft
         22hd0tI6bY8GbpSyJ8zzsABdNftNQvmEo7LtqEsxnU+t8reBcWGpORA84f5KBF+nX6dY
         O7ntEYlQXUF6JIQMjjaWucvSAFJpq59yqiy6oGHBuvXl/LmWEIips2FAYRo8P1OIznlA
         3zHA==
X-Gm-Message-State: AC+VfDzTjLtgQGZmJhDu2OjK0p48cQpjykJEd5tFZQ8zPrS0H5VFvJWk
        yEkqZk3Fgi7HjXEV7PxU425Nw5ynxgW+
X-Google-Smtp-Source: ACHHUZ4U/uezOjHFsiCHbijXEkHpLrUfWwcLpnZve1AsG4fg3JDmGads4DZMgM7+ZV1AQboeZXDXd32zmYT3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:760e:823d:517d:3f56])
 (user=irogers job=sendgmr) by 2002:a81:b641:0:b0:56c:e6fa:6ce9 with SMTP id
 h1-20020a81b641000000b0056ce6fa6ce9mr125243ywk.8.1686700460239; Tue, 13 Jun
 2023 16:54:20 -0700 (PDT)
Date:   Tue, 13 Jun 2023 16:54:16 -0700
Message-Id: <20230613235416.1650755-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1] perf tool x86: Fix perf_env memory leak
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
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Found by leak sanitizer:
```
==1632594==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 21 byte(s) in 1 object(s) allocated from:
    #0 0x7f2953a7077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x556701d6fbbf in perf_env__read_cpuid util/env.c:369
    #2 0x556701d70589 in perf_env__cpuid util/env.c:465
    #3 0x55670204bba2 in x86__is_amd_cpu arch/x86/util/env.c:14
    #4 0x5567020487a2 in arch__post_evsel_config arch/x86/util/evsel.c:83
    #5 0x556701d8f78b in evsel__config util/evsel.c:1366
    #6 0x556701ef5872 in evlist__config util/record.c:108
    #7 0x556701cd6bcd in test__PERF_RECORD tests/perf-record.c:112
    #8 0x556701cacd07 in run_test tests/builtin-test.c:236
    #9 0x556701cacfac in test_and_print tests/builtin-test.c:265
    #10 0x556701cadddb in __cmd_test tests/builtin-test.c:402
    #11 0x556701caf2aa in cmd_test tests/builtin-test.c:559
    #12 0x556701d3b557 in run_builtin tools/perf/perf.c:323
    #13 0x556701d3bac8 in handle_internal_command tools/perf/perf.c:377
    #14 0x556701d3be90 in run_argv tools/perf/perf.c:421
    #15 0x556701d3c3f8 in main tools/perf/perf.c:537
    #16 0x7f2952a46189 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58

SUMMARY: AddressSanitizer: 21 byte(s) leaked in 1 allocation(s).
```

Fixes: daea405f5f06 ("perf tool x86: Consolidate is_amd check into single function")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/env.c b/tools/perf/arch/x86/util/env.c
index 33b87f8ac1cc..3e537ffb1353 100644
--- a/tools/perf/arch/x86/util/env.c
+++ b/tools/perf/arch/x86/util/env.c
@@ -13,7 +13,7 @@ bool x86__is_amd_cpu(void)
 
 	perf_env__cpuid(&env);
 	is_amd = env.cpuid && strstarts(env.cpuid, "AuthenticAMD") ? 1 : -1;
-
+	perf_env__exit(&env);
 ret:
 	return is_amd >= 1 ? true : false;
 }
-- 
2.41.0.162.gfafddb0af9-goog

