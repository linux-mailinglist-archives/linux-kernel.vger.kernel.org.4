Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0F26D0DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjC3Siy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjC3Siv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:38:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DDDCDDF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:38:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3-20020a250b03000000b00b5f1fab9897so19729978ybl.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680201522;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hC7xphE3EtBy91WzkYCkbXWPSl9bqB8/LM63NgI7+lQ=;
        b=Rp86VjhTtbp93iE09qhyXe9tIWluG5P6cBEYlVqOaJnneDY20hKvd3bQaqaRnb4TOL
         vmzH/sXmFtdZxG2M+9Q++0uTit2Mu/bapyOpXpvkHUd+T0NMcTR94f5F6zm6UFge1eYR
         zUX6tYNfN9U12320yxDfWC//CYcw2oPGZWNGk4P3J27RPb2yTdhvemlTV5nlKXCR/jmI
         4ZXoeUYtFG843IZ/A9KeKUzFjGiYPwMhRj/WE4mOOa5QoN6KlzN9laV2rd5XJqPqSpYT
         HJdt1H2p6wVIk0W7+oHoK0Ev1GsjHNwHltRk5tRznUJzQb3sumyAOCQOQNsgxj/7L1Q4
         hy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201522;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hC7xphE3EtBy91WzkYCkbXWPSl9bqB8/LM63NgI7+lQ=;
        b=JQGYAqU+qPGbpvzrULv0+a0UvedqqWbgyGIPOO4Cc3DZ7rz0JKQljEGD4mez0nAfG+
         7Oy16Kr7koYR1g/7F2rfj2ObVi+Twtp12mBADzYjr+3I0mcoTq3l9iEnVmgCq7pbe67B
         Z5y55yLro1ky8IU4wJCoBXYSlXaHPkr8vm39Ql1yIv+rHBybZ9EXcEUnaCjAXbwhbtyN
         QvDcNjD0DQcMIsRgq/3nMFh6xeINNdPLYdfpKKWuyDroK5wjLWj5IC/nONyUYSpjb9qH
         QuQovPq0nwg1h1fXn5H/Erroixj+qlCS7XZ7rLKuIhWEyf7mIhE+ygZut416aV+GOrQe
         eVyA==
X-Gm-Message-State: AAQBX9eNvZCL2gGMhH2qJuUuyIms3jklctSAi9pUhmBhgtiiQtKmTpFf
        r9DfVfS77wlT7YK+YLsqzX5+NWGFeFLW
X-Google-Smtp-Source: AKy350abJFHAnAEKlC7Gh5kAzxSv64hHJ7ElsSSCg9WwTxhyjA3AqRNnx1ijXVWK301wTZltcyPsg2EuInve
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:11ea:eb75:e48c:2c04])
 (user=irogers job=sendgmr) by 2002:a81:af18:0:b0:541:7f7b:a2ff with SMTP id
 n24-20020a81af18000000b005417f7ba2ffmr12145934ywh.8.1680201522628; Thu, 30
 Mar 2023 11:38:42 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:38:25 -0700
Message-Id: <20230330183827.1412303-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 1/3] perf bench: Avoid NDEBUG warning
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
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With NDEBUG set the asserts are compiled out. This yields
"unused-but-set-variable" variables. Move these variables behind
NDEBUG to avoid the warning.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/find-bit-bench.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
index d103c3136983..7e25b0e413f6 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -61,7 +61,6 @@ static int do_for_each_set_bit(unsigned int num_bits)
 	double time_average, time_stddev;
 	unsigned int bit, i, j;
 	unsigned int set_bits, skip;
-	unsigned int old;
 
 	init_stats(&fb_time_stats);
 	init_stats(&tb_time_stats);
@@ -73,7 +72,10 @@ static int do_for_each_set_bit(unsigned int num_bits)
 			__set_bit(i, to_test);
 
 		for (i = 0; i < outer_iterations; i++) {
-			old = accumulator;
+#ifndef NDEBUG
+			unsigned int old = accumulator;
+#endif
+
 			gettimeofday(&start, NULL);
 			for (j = 0; j < inner_iterations; j++) {
 				for_each_set_bit(bit, to_test, num_bits)
@@ -85,7 +87,9 @@ static int do_for_each_set_bit(unsigned int num_bits)
 			runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
 			update_stats(&fb_time_stats, runtime_us);
 
+#ifndef NDEBUG
 			old = accumulator;
+#endif
 			gettimeofday(&start, NULL);
 			for (j = 0; j < inner_iterations; j++) {
 				for (bit = 0; bit < num_bits; bit++) {
-- 
2.40.0.348.gf938b09366-goog

