Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EDB7328F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244845AbjFPHdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241982AbjFPHcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:32:48 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D356E30ED;
        Fri, 16 Jun 2023 00:32:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-54fb1bbc3f2so383599a12.0;
        Fri, 16 Jun 2023 00:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686900734; x=1689492734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zoV8AIWoN8isNFc8d/A+grHcBDoOF9LX+RgpFHY7YR4=;
        b=Z2NZjr4peOLLbax/erCsvvSUkW61U3Wq8uNLX2sXBySWtImwRKRH0BPrcEnGpbwDXG
         6Pftto2cm2AFVztDmaNBC5gb9cuZeNmceuYIcJfSEutJYwBJezb58Ds3dW7N1yo9ITHm
         XwLSGAwLHAlFLKGWKR8c1YreRTrosD+MQliMwJuDFEB8E7H0mzD4iGfOayrHAOls5/QG
         9A57CEWBjO4ly/HTqAM+hh6PKS9yK3jpAkfcl0deYvCVROCxv2jpaL9sviAtcHPxMTWL
         YjKJClSwAv4YpTupcMQoiOovak0K8ZVONLY8acUkCVxN5fqcFKx4ljnrlcnS1m/Ae5SX
         VhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686900734; x=1689492734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoV8AIWoN8isNFc8d/A+grHcBDoOF9LX+RgpFHY7YR4=;
        b=AStsXqnzFRoJHrATP2JVw2lDb4H2cWBrp4r94EsEbqIFDwddyGrnMRyIfmalBK7Uvu
         cpF27aM5axUmwUC4hVy1LEm1od+0H8gDDe7eeVk2D65F1jFyjn4JS2wpRRYFKG/vP64R
         KRuk6IqL4tnLIIYREN5lYQ3FdgNwCsMtH7BIM4umo4EvasYA5XRPzir0MEttGHhQFQW+
         w2xHrTCThc8Ium+K3U+XjhHZ6b4NjBLSZXEkAcTm9b/8z4b5zTmWK4yv/Cjsk/nTc5/O
         jQ4RmZARV3EdfOvR4oQfovfXxkKvJlBk4Bq1/AbaWMsWx75Xtf5nk8NHjhx2UbrPVPik
         oPhg==
X-Gm-Message-State: AC+VfDzNVLwTrCuM6FRP5KBYcrw7gdqsrME2vDZQA3W46GiaHMsTu6po
        UMyFbZWGzm7T5HjLlQDyloQ=
X-Google-Smtp-Source: ACHHUZ6VG9KqSQnMycbfj5H3s4+3soYIG04WTDN/O/m1MaTdO5/w88mHfwelO20VJZ3Dfm8f7zVuCA==
X-Received: by 2002:a17:90b:250:b0:25b:f764:580a with SMTP id fz16-20020a17090b025000b0025bf764580amr1100888pjb.12.1686900734082;
        Fri, 16 Jun 2023 00:32:14 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:6cbb:2c15:7306:b23])
        by smtp.gmail.com with ESMTPSA id gz10-20020a17090b0eca00b00256b67208b1sm715245pjb.56.2023.06.16.00.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 00:32:13 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/2] perf stat: Reset aggr stats for each run
Date:   Fri, 16 Jun 2023 00:32:10 -0700
Message-ID: <20230616073211.1057936-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When it runs multiple times with -r option, it missed to reset the
aggregation counters and the values were added up.  The aggregation
count has the values to be printed in the end.  It should reset the
counters at the beginning of each run.  But the current code does that
only when -I/--interval-print option is given.

Fixes: 91f85f98da7a ("perf stat: Display event stats using aggr counts")
Reported-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c87c6897edc9..e549862f90f0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -725,6 +725,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			all_counters_use_bpf = false;
 	}
 
+	evlist__reset_aggr_stats(evsel_list);
+
 	evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
 		counter = evlist_cpu_itr.evsel;
 
-- 
2.41.0.162.gfafddb0af9-goog

