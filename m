Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BFD60B674
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiJXS6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiJXS6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:58:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55F0B8C1A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:37:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 204-20020a2510d5000000b006be7970889cso9905439ybq.21
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzKQRTEXGqt08SGBdEhLKezf4NlN9FWNmZKirRw+wNE=;
        b=j+74AYOxCaajozdBfiO5kv/80FZYXYndelThFiPyXfTn5d+15h0iTwKi762lYKKt3M
         wXCC92m2LibdA4uqtYnNfy0lNPA1tSrSqmtmmO/doOPBrPkkUDb1C+6ElrbnmtRX6M5R
         Fe4V2jfcpE6ePzNLE+3Q84vJggdtywVZ5+x9VA7CLp2obDtqoh5VLeHIPpob6Jn8w+Ql
         10SMYYl33WZclEXBIpVktcohFEvcfz1wo01/cPGUwMJ93DIY41SmmQ9P9CV7Z9X3QhGp
         KZqbj05kQPns4meT8vTk/c7Ym60Ec3DoHoiaqN39sC/PReynUtjWH61qFKOotqnS6Nw9
         pgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzKQRTEXGqt08SGBdEhLKezf4NlN9FWNmZKirRw+wNE=;
        b=mqmM+Zo9zzVYoVFTxwUGgeRwEF0iDGDMrtQzTpb+mkhGKQsFcuFki9BUpSFHPn2yyt
         0euEsEI7MfdbQKIYm5c6hD0Ccfb0oivATdS1lUSLeXHPqTRM14qbKkn13LyS1fC5XVZF
         xCHgZPX+eNCaHO2G17SHBwt6IBpLBV7R90bxQUNMwHMS18xMTJDXmybPjuAlIqrWz4cg
         RNEIMQng5D6TKafXrapSzn64qqosnQrxfyUq04r1sDC3Rusr+7W8NzlraK/RN0aEmYBd
         SgUYA0EL4zlekJPJ8jXCHujB+v5WKyAXqf1L9AJd6mHBIFMzyjE0QwGBMI6nPYJiRRP1
         eLzA==
X-Gm-Message-State: ACrzQf1+aQa7/5PCKsbSd4uAeUu2WNCTs2Um9O83zyBVkr8TMNGczXxJ
        yrweYbHYi+ymoUknR4Yj7OCvklvX/lS0
X-Google-Smtp-Source: AMsMyM5XYqtNgXUFd1h7brKL0bHrVRyG5HrQ1WbR+O1JB2SeqeRi637dBIgo+oclvIQ4a6cQ5REYI+m+j9z8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a25:dd2:0:b0:6c0:7938:5b43 with SMTP id
 201-20020a250dd2000000b006c079385b43mr30564176ybn.280.1666632998495; Mon, 24
 Oct 2022 10:36:38 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:22 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-8-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 7/8] perf top: Use sig_atomic_t to avoid UB
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
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

Use sig_atomic_t for variables written/accessed in signal
handlers. This is undefined behavior as per:
https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 4b3ff7687236..bb5bd241246b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -87,8 +87,8 @@
 #include <linux/ctype.h>
 #include <perf/mmap.h>
 
-static volatile int done;
-static volatile int resize;
+static volatile sig_atomic_t done;
+static volatile sig_atomic_t resize;
 
 #define HEADER_LINE_NR  5
 
-- 
2.38.0.135.g90850a2211-goog

