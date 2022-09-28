Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56615ED5E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiI1HWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiI1HWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:22:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F9FD2D54
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:22:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3515a8a6e06so51862927b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=YPZVPn/GTh1TFAuZs4AqHXTtAyJBnhTYkrO6EMpJe5g=;
        b=IF0rILXSsrUUJJljm0eQbbs72q4mFDg+n66vVVTg/HiaWGMF9Z2RabOCmtM37prxKt
         FMdtXGRXt76fteg0sfKEkHgDavX+CfIg0hcyKosCuGKS19dS6qHuyiL/YaXciyxcVO/2
         axqcNDhHvReYrBz3MRw/UKjJgE6+8szcvhppTtdPtvWFVzpMQnNqJhB8zhC/9UXkJ5tL
         hnj2m1UhMvLZ6gqfsQbcV3Sb7ksKuaGHyt0eNjkkcCf5kmwfgVDVBYeGmaWOsZ/75sm+
         b+JD8QG/zDeq4QFY2RXpjT6nk22OMlpuks+YB8B6FnZAv9iQpNFvbMbGVQBbk6aKdbGj
         Y5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=YPZVPn/GTh1TFAuZs4AqHXTtAyJBnhTYkrO6EMpJe5g=;
        b=uU7jyoovfdaI0/FmbPihl6TXrfCisQ0o60IeA06XQz64+hm6jVrCnytzvn6O/+Ui6h
         DJyukfSFgXpZPpQSfJRKe/UxAoBqNItQyFcgGlHya/lNssF+tFgRigMjKb+bMb9IemAG
         WeiYUUJjRJrZ8fAgCrKKj7tyBrdikUFo5NDbD7QgqMW9xsWwqI0dxDIrApFplR3hzVzH
         Nfg6p32HkNHKBPnpyrmWEK1rkMyGiMW/Yg4UHt+/g2sFeaV4rElO0GYIQpTnKtl1MeUP
         L8Z0K9MHGugx1uOrA1w8gbdf6l7v6QFuvfxrPiF2dZONuox56pxTjrx70ciAdiYBGyFy
         GrgQ==
X-Gm-Message-State: ACrzQf0vfsBIA2dmvG+WR7BsOEvNJyVfEr9mQzWHbjCRlTk7gLCpMUyW
        1gP6xCV0Jj2mUEFJzyhvJ7DUmVhwpnCp
X-Google-Smtp-Source: AMsMyM6WZhoDBs0nlE+B6MRvAzP4iw8WMDbSVU6/E3AHtH79AatyDR7f3lWD1YvhXfqr2e5wK35Zr8BPNXY1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7099:1ccb:612a:5ad6])
 (user=irogers job=sendgmr) by 2002:a25:4241:0:b0:6b4:bcc:609b with SMTP id
 p62-20020a254241000000b006b40bcc609bmr30680640yba.396.1664349734108; Wed, 28
 Sep 2022 00:22:14 -0700 (PDT)
Date:   Wed, 28 Sep 2022 00:21:44 -0700
In-Reply-To: <20220928072204.1613330-1-irogers@google.com>
Message-Id: <20220928072204.1613330-3-irogers@google.com>
Mime-Version: 1.0
References: <20220928072204.1613330-1-irogers@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Subject: [PATCH v1 02/22] perf expr: Remove jevents case workaround
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
2.37.3.998.g577e59143f-goog

