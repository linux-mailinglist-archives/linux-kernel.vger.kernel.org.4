Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75C2628D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbiKNXE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbiKNXD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:03:29 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7A51C933;
        Mon, 14 Nov 2022 15:02:50 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h14so11705809pjv.4;
        Mon, 14 Nov 2022 15:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dj8iIW6Moofk4jxR56ZsoVFULFdU2ag6CE3awXc28Rc=;
        b=GlPXquPr/Ffvox+CyOypFSRLgTJtFCM69J4Fcnu8bHgNvm8LOdWgtdsBQJfj+4cBDP
         i7sT51MOc3MVuGENMx5j6UmpuT9CmzahltE3yCcgNaUhAFhYRf6y8zBgL70oBQOZTfCj
         FIZ/BizgnfXRgvkFFWslH48d0mj4JvM3o8IE65s+tOcij8F0EuVtiSYE8qhVvSWs2hoy
         4el0nKkH5j53B5knLlMitO8qKIUXbdMlExlX1w8+2AmMbLMTYeZIdxMF5ziEGi3q2EhD
         MV1xjF/k98DjcExBb0S7rumweMGwPCS0u/6RM05YvRurZ8giL4phO2QOk/zuvzwMb9ZC
         u6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dj8iIW6Moofk4jxR56ZsoVFULFdU2ag6CE3awXc28Rc=;
        b=XFayzyY9EZKyG18EPnpIT3vr6esgFGEDmsaW/+eBDQU0vZmP2pBjWbqbWy+tmfH65H
         +D8MOe6MFuU3AJpR0vtWu0FhD8zwuZGNVX5DTxIGlmQhaFm0ljFlTETvV/CpzyQC+Ano
         r2CWIvwRYqVuTOLts0u13ecYkniAjdY+ykC2gsp+D8yM3X2j0utRYD1C9D8jY43dR0rL
         7T8IBP4XRscp788HK82tyQyCnoT2GfUobYAi6KncT4qDGD8aXR9dfLnVtRSdBYZWcHt5
         CchCoCoQxrFoObqPXH2hlCzvf6uxYxl5MzJpdYS+qBm1MZF0HVdM1m6LpFM+u4R5pZ+7
         TxjQ==
X-Gm-Message-State: ANoB5plvxxfs19SAMGX93MVF2Ox9yMGRkoywXy93cj7WYUTF2e04d49u
        h2rFytLzfUsfAhLigLO7t2k=
X-Google-Smtp-Source: AA0mqf4KjGcj8maOHGHDnGzpz0rniCOrXm2bPXvBRC4E1kFIRbtVH0/jrvLIfhtKPj2mnuQPdjvtxA==
X-Received: by 2002:a17:902:c211:b0:188:a6ea:27a1 with SMTP id 17-20020a170902c21100b00188a6ea27a1mr1234620pll.164.1668466970017;
        Mon, 14 Nov 2022 15:02:50 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:49 -0800 (PST)
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 13/19] perf stat: Remove impossible condition
Date:   Mon, 14 Nov 2022 15:02:21 -0800
Message-Id: <20221114230227.1255976-14-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221114230227.1255976-1-namhyung@kernel.org>
References: <20221114230227.1255976-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print would run only if metric_only is not set, but it's already in a
block that says it's in metric_only case.  And there's no place to change
the setting.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index f983432aaddd..cc8bb6d07dcb 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1292,9 +1292,6 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 			num_print_iv = 0;
 		if (config->aggr_mode == AGGR_GLOBAL && prefix && !config->iostat_run)
 			fprintf(config->output, "%s", prefix);
-
-		if (config->json_output && !config->metric_only)
-			fprintf(config->output, "}");
 	}
 
 	switch (config->aggr_mode) {
-- 
2.38.1.493.g58b659f92b-goog

