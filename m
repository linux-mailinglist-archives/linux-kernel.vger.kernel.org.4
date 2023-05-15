Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D140D7034BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbjEOQvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbjEOQvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:51:33 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE16559D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:51:25 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-643fdfb437aso48587502b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684169485; x=1686761485;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Zp9tRh+FO1zLUbEzGzOtScVTBYPqTpeZg2SlWORkVg=;
        b=fUe8uIYoq6QXxQg5ptSRPuQW8LfC3SYChEv+rjCssHCMF4bjAoiYHSvo8Ukijxpt/j
         RIs/zPmmbqVPinsh38wWKAXfG85D/dW/HUER8QIH9IHk/vMcMwOXB45y6r3pNaCgAXPA
         jmDzq26FxdpZ8aVT2YX40wcTgiBB36wGz2MkbOSHpMnwsgQVlHjkhM6Eczi4o/EQgSVq
         vwjzC3p7Z2bWwV09S8OAtHwrPpiIZouWtl3xbcrtnT875cqFbDl1+NSWu+7iGnroj0la
         agV4lHtAZi21D+iaDF1PrLXifCcIVFVUUH43Cx+1VUbqwzghglYTckKI8huWfjsDc231
         IqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169485; x=1686761485;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Zp9tRh+FO1zLUbEzGzOtScVTBYPqTpeZg2SlWORkVg=;
        b=Ag4phfSEZtoR6WEpY1QfzZgZAX8B2h4eT5dJWmvakVhgbEixgbgY8I/84wMGN/XTJj
         rcNJEalqNPUJ7vlvpkUjXmLkOTVn1IFC/K+t19FKLacQ4aaM+5lUuKAAW8XRnWZExzX0
         jZrWGNlaL6E6QUYQlRW6JwFIeslSsygqXlgauZwxqNa6cKSLVe9MVWlqa3bnENF+XCoH
         EXsVZ/YIzZdp71sFBsbgFKdPr5ZyGlGEoqBnvuBsv4PE58G6+XmhGjLIDrZ3Lv2AHrxM
         Mb5juTn22NHfu1fcyV9v9Xmz/dwIm4g7e/hJbsYxbnCrHj1ItYbXSzC8/0CNCAm3rcFM
         QpAA==
X-Gm-Message-State: AC+VfDxn3Wkz8J5c//wSDipQiBWa6PEMmlU0lTcABedIZ2krO+rHgpc6
        ofzcBh1Qx31PK65F2GuP0DlK5a7pYyPW
X-Google-Smtp-Source: ACHHUZ6bdv2ATRwMm73jY39auKUdui6mQ8hUAXxgBhGFpkDDF32OO7DEtBhPDyO5O60jrvxsshXXx4SLysWm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a38b:39c5:e0c6:e9f])
 (user=irogers job=sendgmr) by 2002:a63:2ccf:0:b0:52c:4e3e:24ef with SMTP id
 s198-20020a632ccf000000b0052c4e3e24efmr9462225pgs.2.1684169485265; Mon, 15
 May 2023 09:51:25 -0700 (PDT)
Date:   Mon, 15 May 2023 09:50:39 -0700
Message-Id: <20230515165039.544045-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v2] perf arm: Fix include path
From:   Ian Rogers <irogers@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Change "../cs-etm.h" to just "../../../util/cs-etm.h" as ../cs-etm.h
doesn't exist.

Suggested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 860a8b42b4b5..a9623b128ece 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -12,7 +12,7 @@
 #include "arm-spe.h"
 #include "hisi-ptt.h"
 #include "../../../util/pmu.h"
-#include "../cs-etm.h"
+#include "../../../util/cs-etm.h"
 
 struct perf_event_attr
 *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
-- 
2.40.1.606.ga4b1b128d6-goog

