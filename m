Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951BF5F3B36
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJDCQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJDCQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:16:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA203DF02
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:16:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d8-20020a25bc48000000b00680651cf051so11943535ybk.23
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=Qii+hgPKPKNgROLcY0ySesmuzhBUXysFitkb8xtJsts=;
        b=CVG1JMVAPk0ysGQVkFr+p8ZsSG43IQs1odaJHsS41NmEifn8mEBoyp2NENh/4lZhal
         lSRpr2RLbt+koG/YTzIGoaWzp4jHtqDcvehRIrB/dNnKA+a7bWVfpsXf/JkhU2FabjtZ
         +wYDhJ+E01ggYxT73DeYZo+eEPjRF4SULbqdP8ZfgPBhOLcBoom/19AzrUzXU+UD9+z5
         Q/y7duzXhRmWmOYBu7Kk8BnFTWiE9gOfL6M910w/wOiZ0PxxTVrMvAh0hxiud9lodUh7
         WkudOOrwHKYmYCGBpCug5XYs6skuBkoUNWCRVaTIClR/759qeXbfNy94YRRfJ0jwcBVr
         K0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=Qii+hgPKPKNgROLcY0ySesmuzhBUXysFitkb8xtJsts=;
        b=v/JsBFAwtS11/HC6Wr78kOOQAXBqnCPlKmTa06EqpbrZJxCdt8zaQSa2kz8gGI4Wzu
         fMej1DyB4O1AM3j2kp0HyJlWQ6gfJq9pnBjYjQIJ0VY9wgaaMlzct46uLeysy6egjFVY
         6NNyefllBa0KwKqqAugpxWzsNqhlzDi+x+6E9JLpLxOdgTyiTa+JtDxc2U/ybTmx1LSz
         ZKfWSH3U/VBiVnz2C8b5jZPDxapBYM53uy6+xVte6D1bGJ86segKabPxqJdhbtKtITRy
         hcPav85jtdMCwvGr3At73xydPOtljrAmjXJErZD2vRqyPU/OyqZb21CeGOjoBiU0N9/z
         7oIA==
X-Gm-Message-State: ACrzQf3MizKHy1LktmXUZnl7UGCqJ0pwD+xICGyUoZ0ENlPv0lB+eHGm
        5jmzOY+ugqikD8VQEOMDQ5Qw43ycKvk+
X-Google-Smtp-Source: AMsMyM4ocb0WPztz1ctwUeWWVnl3Ii+OXYn6QwPUb+UV6MBdJlEo5Djpx7XJRHKnq6NhDfZzb7JqSB4USi97
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a81:148f:0:b0:357:a69d:bb5f with SMTP id
 137-20020a81148f000000b00357a69dbb5fmr12937678ywu.495.1664849785102; Mon, 03
 Oct 2022 19:16:25 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:15:52 -0700
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
Message-Id: <20221004021612.325521-4-irogers@google.com>
Mime-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 03/23] perf expr: Remove jevents case workaround
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jevents.py no longer lowercases metrics and altering the case can cause
hashmap lookups to fail, so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index c6827900f8d3..aaacf514dc09 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -182,7 +182,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
 	char *old_key = NULL;
-	char *name, *p;
+	char *name;
 	int ret;
 
 	data_ptr = zalloc(sizeof(*data_ptr));
@@ -195,15 +195,6 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 		return -ENOMEM;
 	}
 
-	/*
-	 * The jevents tool converts all metric expressions
-	 * to lowercase, including metric references, hence
-	 * we need to add lowercase name for metric, so it's
-	 * properly found.
-	 */
-	for (p = name; *p; p++)
-		*p = tolower(*p);
-
 	/*
 	 * Intentionally passing just const char pointers,
 	 * originally from 'struct pmu_event' object.
-- 
2.38.0.rc1.362.ged0d419d3c-goog

