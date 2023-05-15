Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723F7704114
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343549AbjEOWpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjEOWph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:45:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67311DC63
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:45:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55a9614c154so216387777b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684190734; x=1686782734;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/L8bXT+0geh2otdU6iNl7MVNZkb5RxXc7Qeizh0qbl8=;
        b=ql0+WwRTH43ALwDQodzd0Zact93wOmtEipG5MitJpFVTS6r9eSDl5D0u5Ruo+95xdh
         5slEGVpdR3PZRG0tS3bQ0s5cvGpX/pp6YVRco9+ZxAPIE2QGJ00v35rQDcWldNz0Yip8
         AS6qMFuV+57KOf2SuL43ATXmhCRO69PEh+CGNB2xposgaAuoX7/sd9LRg5cYZtfWMuCU
         sZGdmcC8FC0JuaFC43uove9mK7YXhZJAgTj+6CE3JL03PRUSNkc6lrJlubATFZTXlV9L
         sNhR9PCjX7PLwaoHiZvSCpZbUHBatdzaNBUtn2JipXqsxCeOH1FpoehE2aQhHJCARQSP
         AOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684190734; x=1686782734;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/L8bXT+0geh2otdU6iNl7MVNZkb5RxXc7Qeizh0qbl8=;
        b=BYlkGroAa9DyaquoMqJSFBygnObVV1P+mdrwgxkhQh8fQK1vpCigXsi70QrX6uP8q3
         30deSxmhdsZ4EhCzgbkq7r3K8oAdVJXb5iS72MeQPxju/pe2s0XIeeWoy5ISsCeVUvgD
         K8WZu0QKe2R8vn68NZWA8jt3TllD/WOzqJle+g499SUTa6X0/czoypFp5KcPMUeZENfd
         uiB1Ym48yJtrtwGyixjEErCAatm9QynEK481uicHvWNafeaEL3BNlSXJAVe3ebBUvD2g
         G6My0uvyuuTx1AaVSiJtdfsdLa36CpiPvLQ62+WPeTVNh9pFYMqrresobCVWfIJ67tIM
         b6EA==
X-Gm-Message-State: AC+VfDyJpAPrHMJfzbG/1mW1rcJCXfQDQkyhky9YUvFKFk6+u5KbNkzA
        D4U3uI8lMssmO4uTgG8y+RPpS45PbNAf
X-Google-Smtp-Source: ACHHUZ5d2r+rfNcjfPvN8YeFUzhzCaEaysmKzJ6JUdPGlOSxkjs+f2+90E56eB1SX6H5aj7WU/7hPQlADpHm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:638e:7eff:a1d9:3b2b])
 (user=irogers job=sendgmr) by 2002:a81:4513:0:b0:55d:f929:418f with SMTP id
 s19-20020a814513000000b0055df929418fmr15952511ywa.1.1684190734487; Mon, 15
 May 2023 15:45:34 -0700 (PDT)
Date:   Mon, 15 May 2023 15:45:30 -0700
Message-Id: <20230515224530.671331-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1] perf metrics: Avoid segv with --topdown
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
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
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

Some metrics may not have a metric_group which can result in segvs
with "perf stat --topdown". Add a condition for the no metric_group
case.

Fixes: 1647cd5b8802 ("perf stat: Implement --topdown using json metrics")
Reported-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4e7d41d285b4..5e9c657dd3f7 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1672,7 +1672,7 @@ static int metricgroup__topdown_max_level_callback(const struct pmu_metric *pm,
 {
 	unsigned int *max_level = data;
 	unsigned int level;
-	const char *p = strstr(pm->metric_group, "TopdownL");
+	const char *p = strstr(pm->metric_group ?: "", "TopdownL");
 
 	if (!p || p[8] == '\0')
 		return 0;
-- 
2.40.1.606.ga4b1b128d6-goog

