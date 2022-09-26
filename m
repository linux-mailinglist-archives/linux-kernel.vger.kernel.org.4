Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193165EB1CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiIZUIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiIZUIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:08:04 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B2166A48;
        Mon, 26 Sep 2022 13:08:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso8003461pjm.5;
        Mon, 26 Sep 2022 13:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=9J94PVT0UfXD4DP+QaSiTx8HSwssHCBbfYg6tJw6jtI=;
        b=CazEgvwuWoudVIBWDJKNh4Labrt/0qoRvoaU5LZRYz6WTBocYco6GTrLvY+GvFBpvK
         Ba299cUT+AkPrHi4ioDf9Osd8D3DOaXT9aQnTKTSU1to7uSwJTSnR6xbfYoreWB1bKAo
         A+axZVHW4vbTC4NQk/68BwvtknseOWNa39Qv340JgziALvTvOwZ7+rtQtyd3R19hAMXr
         foJhs6W1NMiDOggyrVLW3a4+KtE8c3acGLuQOo/e0/PZW5I2FnogPXueudXs4utfo1JZ
         4z3m/g9lxqupxZ5uM595xktJ0RwvhUQ0nXmRKOHW+Ozvcq0VvLaOndNyutHi8HF1WIAo
         R9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=9J94PVT0UfXD4DP+QaSiTx8HSwssHCBbfYg6tJw6jtI=;
        b=VZg8Kydiy7svNoctsnfHzRRIw3isZbZqw+z9EZWjSWmBzTnk6nUG+A7dVLrm33kEFw
         66qyBqTmq0TgbmmYkN6038FTVLYBx7TXCpv4HeZkIp7+ue2cDJLESSm+1g4lm3AIUGpG
         prLxmeTubm7nOB+rKayTyUlyG6Js6ankEDGTro+GxsRluv2JqQ+Pifo9KIqWrLHNQ7pL
         7tZU/8mmA3unAtNWPEeQLt8QppLC54+h6hdl2iIdaVVqpKYYA1ZhqUkkcR4i8/E+P68q
         ruvKWCKHpSyx7N0Tkl1a1u9HfFVahbXkQkKEJmeFsRJbQcatB+beEuUewMxbtr/UfNJG
         IVGg==
X-Gm-Message-State: ACrzQf0a3EolOZo0QuYRigz6yvzlBgpLGAC0IAJMPyj5VrOhH/eUFWo9
        82tw3uMCIZGC+MlhfUwTVDE=
X-Google-Smtp-Source: AMsMyM4evfuPc9Hc5RUxXcJNvIBbJDZgE2qi2KOu+8k8Z0ahxoNasFuHVoTis1jxyra+z0VME/a2Uw==
X-Received: by 2002:a17:902:d708:b0:178:a2be:649b with SMTP id w8-20020a170902d70800b00178a2be649bmr24087297ply.121.1664222882853;
        Mon, 26 Sep 2022 13:08:02 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:2d32:19ce:817e:166])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78bd5000000b00540c24ba181sm12510148pfd.120.2022.09.26.13.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:08:02 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: [PATCH 2/6] perf stat: Don't call perf_stat_evsel_id_init() repeatedly
Date:   Mon, 26 Sep 2022 13:07:53 -0700
Message-Id: <20220926200757.1161448-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220926200757.1161448-1-namhyung@kernel.org>
References: <20220926200757.1161448-1-namhyung@kernel.org>
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

The evsel__reset_stat_priv() is called more than once if user gave -r
option for multiple run.  But it doesn't need to re-initialize the id.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 6bcd3dc32a71..e1d3152ce664 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -135,7 +135,6 @@ static void evsel__reset_stat_priv(struct evsel *evsel)
 	struct perf_stat_evsel *ps = evsel->stats;
 
 	init_stats(&ps->res_stats);
-	perf_stat_evsel_id_init(evsel);
 }
 
 static int evsel__alloc_stat_priv(struct evsel *evsel)
@@ -143,6 +142,7 @@ static int evsel__alloc_stat_priv(struct evsel *evsel)
 	evsel->stats = zalloc(sizeof(struct perf_stat_evsel));
 	if (evsel->stats == NULL)
 		return -ENOMEM;
+	perf_stat_evsel_id_init(evsel);
 	evsel__reset_stat_priv(evsel);
 	return 0;
 }
-- 
2.37.3.998.g577e59143f-goog

