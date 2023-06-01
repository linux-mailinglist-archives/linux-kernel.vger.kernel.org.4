Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD1F71908D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjFAChE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFACgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:36:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957A6101
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:36:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb76a9831so462973276.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685587010; x=1688179010;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D1dYs8NsS8zSviHkbXQN/+l3Vz/vpBxXbApD/cmgUTQ=;
        b=3nBl5W23S2jMMqJOCr3anyDU3tdu89hKDJVizpYwQB67k66Fw36mUU4Va8PkwJn0yt
         gIluXi2w1ckpMwAafH4s0HGHP5i+7JtQhPNWt0jlXQk++f57KYtl4IQTTxRCkW4ilYb+
         CwZe+bldbWuxw3e9kaPc3fFA7hMjm/SfZp9pTbyHaDp+d0nh9D1lmuLBk+IHKzuJNOwN
         2uAwK+hQjQjFcIIaqLAqv+EGU4i2sxdkfjkk3hM4AaKxLus1fLERbk9kglh4215K7MPO
         NfBP409/YPZM6S/uFNzb67GCezlbFFH/PvzoaBtUXi2Cp2onzes6f0IxJRpkksAjSDQQ
         6bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685587010; x=1688179010;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1dYs8NsS8zSviHkbXQN/+l3Vz/vpBxXbApD/cmgUTQ=;
        b=gnrcoW7VxZ1IL6BjZsSVylH+bSPDcrKu/OZbN4dNm9HSXwjHvJF01c/h0Etn15Feuw
         4Dfhcltehjxr+JpvrvNewjyQ1xtgq+l+suzfotJosikCJnsb4in3aiNAlLcommi14iJz
         1VwxkoWGh0drFK+9+X7/h//Ax5thK14CfllqliyrEYO8h9Xsllkm8MhMXEM0aDzSjm1F
         JapeIAuAskJnWU1Wo1UO1pNisM7Ktk1bXv265s0YmjcVz9vxXfWTlZMg2xdvnQUP99bX
         LVbs8UXh/w/92lucY4TOUa7gweSedV9osP4j4ITMURhVwQ/4F6M5bHWBo4vddIf4x3VJ
         VmmQ==
X-Gm-Message-State: AC+VfDy3CY0wDJ1HJXUxNF0lz2P57O1dYl8aplf5NkOtodi+KG5pzgi0
        zOJDT5aRrcmq3aitBWrmSr1Q6pZq1q9S
X-Google-Smtp-Source: ACHHUZ5jEIfpSDW67W1Y/nhfP8jc7d4B85CfHRK1XD9m5MsTQPHlw7KFaIJn2zbNle7jN79NAZJ8ONtqAJqL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a344:94b4:9b8d:a089])
 (user=irogers job=sendgmr) by 2002:a05:6902:1022:b0:bb1:35e6:6c4 with SMTP id
 x2-20020a056902102200b00bb135e606c4mr2490459ybt.9.1685587009798; Wed, 31 May
 2023 19:36:49 -0700 (PDT)
Date:   Wed, 31 May 2023 19:36:43 -0700
Message-Id: <20230601023644.587584-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 1/2] perf pmu: Only warn about unsupported configs once
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
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
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

Avoid scanning format list for each event parsed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 5 +++++
 tools/perf/util/pmu.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0520aa9fe991..204ce3f02e63 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -934,6 +934,11 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
 {
 	struct perf_pmu_format *format;
 
+	if (pmu->formats_checked)
+		return;
+
+	pmu->formats_checked = true;
+
 	/* fake pmu doesn't have format list */
 	if (pmu == &perf_pmu__fake)
 		return;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 287f593b15c7..7a1535dc1f12 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -76,6 +76,11 @@ struct perf_pmu {
 	 * specific code.
 	 */
 	bool auxtrace;
+	/**
+	 * @formats_checked: Only check PMU's formats are valid for
+	 * perf_event_attr once.
+	 */
+	bool formats_checked;
 	/**
 	 * @max_precise: Number of levels of :ppp precision supported by the
 	 * PMU, read from
-- 
2.41.0.rc0.172.g3f132b7071-goog

