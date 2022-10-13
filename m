Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C715FE397
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJMU5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiJMU47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:56:59 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0609183E1E;
        Thu, 13 Oct 2022 13:56:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e129so2569284pgc.9;
        Thu, 13 Oct 2022 13:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwIrM6PqNMNs+23zGPNZGFODdHKdYKYXNnXBaYGk6no=;
        b=bZryOJi77Rv3rbKooYxAQa7v8FiSWMxEFBnfpNGhi/UpvldiklHZsUNGBGy9c/pFF9
         YxstqFBtH3jK3rya1kMqfUK0qpav7vzmKmxep7Lw4SOBJJ00EUlPRMh6FVEzQjIW3CtT
         SLiJb9Jz+STOPtU1r0PwvNr9OBUJ9ksD0g5hi0FAU+IgiNDd8bmW9VnXPjIMSsR7pqDX
         BmEWCrNikS98SJGVR9tRy+3GdJhkMHcL2nb6cnnr1lN+0TwP/TimWpSeY473ZRNHiL5E
         qTA7NteYyk3aWfg1q0gWW0Sucq4UhxV9Ocj3DYhGbGiczlxw7lNNOhlObZaEeMfZIAX/
         ru0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GwIrM6PqNMNs+23zGPNZGFODdHKdYKYXNnXBaYGk6no=;
        b=mvzlOSVTce/MK5uraBI7gW6bSMdsWbPnwFlkCrufBbKjHVJ70KKDFDJNKLi+qGFXyH
         uGUUZeP300AjWfsjz5X1tR4cCnlFQYTrcBo05C/h00DWrir2q2jTv6aarr6aR6W1x3JS
         gyyx7IOfo05BDebEtQEqpXq4Z1EslkDU9/AjF1rlpQqT2RSzUVqfLIRr89ARF8DeT3p/
         tq9romzbhoVV959b8AsPs0CFyq+lBnkMDswln+7VTiImfjYBOp2ZnZcP0DzRGShR7x18
         ZfXBAs/W0rXNXenWlH/ka5rTWD0rW9WWukt7fdxM6NFqL+xhlHgTkAtUd/vl2NckTqvy
         YaXQ==
X-Gm-Message-State: ACrzQf3CWzktkM+X/Nrrn2iGmp6wudjbUmhdTsfJmMmXf/ruBZbHDv2E
        oY9PkmqrkWCvWX2XxhfA0Q4=
X-Google-Smtp-Source: AMsMyM7xAyN+uhI+6X8HJo1C0MhAUgcRa1vJ71mGmzp52Dr9HbBuY1qszhhQ1UFwMmLH4X2d7NUsWg==
X-Received: by 2002:a63:a13:0:b0:440:a593:b79f with SMTP id 19-20020a630a13000000b00440a593b79fmr1478647pgk.557.1665694618187;
        Thu, 13 Oct 2022 13:56:58 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:b4de:68c7:333b:58ae])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7951a000000b005604c1a0fbcsm139964pfp.74.2022.10.13.13.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 13:56:57 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH] perf stat: Init aggr_map when reporting per-process stat
Date:   Thu, 13 Oct 2022 13:56:55 -0700
Message-Id: <20221013205655.401525-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <CAM9d7cjnAPhOPont3GHSwa9BhAsAFVvqAhFPsyAfQBR8ajrvag@mail.gmail.com>
References: <CAM9d7cjnAPhOPont3GHSwa9BhAsAFVvqAhFPsyAfQBR8ajrvag@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll merge this into the problematic commit.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4cb3ceeb7ba4..9d35a3338976 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1355,7 +1355,11 @@ static struct aggr_cpu_id perf_stat__get_cpu(struct perf_stat_config *config __m
 static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
 					      aggr_get_id_t get_id, struct perf_cpu cpu)
 {
-	struct aggr_cpu_id id = aggr_cpu_id__empty();
+	struct aggr_cpu_id id;
+
+	/* per-process mode - should use global aggr mode */
+	if (cpu.cpu == -1)
+		return get_id(config, cpu);
 
 	if (aggr_cpu_id__is_empty(&config->cpus_aggr_map->map[cpu.cpu]))
 		config->cpus_aggr_map->map[cpu.cpu] = get_id(config, cpu);
@@ -2120,11 +2124,9 @@ int process_stat_config_event(struct perf_session *session,
 	if (perf_cpu_map__empty(st->cpus)) {
 		if (st->aggr_mode != AGGR_UNSET)
 			pr_warning("warning: processing task data, aggregation mode not set\n");
-		return 0;
-	}
-
-	if (st->aggr_mode != AGGR_UNSET)
+	} else if (st->aggr_mode != AGGR_UNSET) {
 		stat_config.aggr_mode = st->aggr_mode;
+	}
 
 	if (perf_stat.data.is_pipe)
 		perf_stat_init_aggr_mode();
-- 
2.38.0.413.g74048e4d9e-goog

