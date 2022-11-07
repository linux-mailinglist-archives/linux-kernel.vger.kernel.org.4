Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9575D62013C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiKGVeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiKGVdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:33:45 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EAACFC;
        Mon,  7 Nov 2022 13:33:28 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y203so11915803pfb.4;
        Mon, 07 Nov 2022 13:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWSDNfZ2wImW4xPzQ9jDtU6vpg7XH7BhaLU95Jwpr2Y=;
        b=BqNGbFdHwFQxBhVekowAdOUNERDGn2+AWTAyyiZCzt5B/9GCH0SUZ66R7ZrHk9eGZf
         BfkM9JDgUIkojWuYTxAGCA0Lpd4t21URmF/n/ybGbQaCggsJgy6F7/EbwPflwodxtq9Q
         8queCZb++T6Aqvi9QoVSdlpoua1q/gjjTpRJuVuq8M4f6JO5KPxJboIil3/T0bbZ3imc
         7M6KNqczmjl/QRcX3jMKvHFQA+rtlEsdd+LMI59y49ANRrEv3Wdswe6XfrUQku825XaL
         PPObpYYXhLJE3ocialaJlNqBvAnxLpmAkDSRCqva3pCXPoviaatiREdqAAsJK1/FLa08
         yq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mWSDNfZ2wImW4xPzQ9jDtU6vpg7XH7BhaLU95Jwpr2Y=;
        b=qYiBIrbG+w+dSjXp3xiEsesSVaNlwoEU32EtRqdQMyWRwFtN5accz9nlui58vssFJM
         qQB3a9l/0Eakq9r4UvIey2nCDWuSnoNv6HesZNhb1urN3lSB7qek3ooNBdXO54byxZkq
         f0hG9TNo6h1Y9k0ofQtY7aCsXYsjZYrck8ur345gglh3rdg1kLjA8PnXfk00KeMq8h8q
         ypGmX4GVXOjZu1F81oCXVEVXQe68j5mDhz+ZRJlI2TQTBO/itaQgRTmjGzxuJMOlTQzq
         XpuWeO3ewE0ibObd6t8bO9SbuPkyZyqNz355OenoRE9BJPND6bIFg2roOKvtgs7Fwzlp
         A2hw==
X-Gm-Message-State: ACrzQf0mbs/Dl82bhzwvLopK6HzJ6RMAT3pzODQ2sNqbqo6KqeyjOPsj
        11LLWGqi9AsriLERay+ExJ8=
X-Google-Smtp-Source: AMsMyM4UMw5+jK5rXwMAVsrZfuKsU/79gy9ULlxBwiDvQnSFIwfSmVlXu/h/0M+nmXPBq3RQki89eQ==
X-Received: by 2002:a62:860b:0:b0:56d:a2be:ebe4 with SMTP id x11-20020a62860b000000b0056da2beebe4mr873244pfd.28.1667856807633;
        Mon, 07 Nov 2022 13:33:27 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5850:5958:9c77:f623])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b0017f5ba1fffasm5366413pln.297.2022.11.07.13.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:33:27 -0800 (PST)
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
        James Clark <james.clark@arm.com>
Subject: [PATCH 7/9] perf stat: Add header for interval in JSON output
Date:   Mon,  7 Nov 2022 13:33:12 -0800
Message-Id: <20221107213314.3239159-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221107213314.3239159-1-namhyung@kernel.org>
References: <20221107213314.3239159-1-namhyung@kernel.org>
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

It missed to print a matching header line for intervals.

Before:
  # perf stat -a -e cycles,instructions --metric-only -j -I 500
  {"unit" : "insn per cycle"}
  {"interval" : 0.500544283}{"metric-value" : "1.96"}
  ^C

After:
  # perf stat -a -e cycles,instructions --metric-only -j -I 500
  {"unit" : "sec"}{"unit" : "insn per cycle"}
  {"interval" : 0.500515681}{"metric-value" : "2.31"}
  ^C

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 25f67fb37f6d..aab2576bd40f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -860,6 +860,10 @@ static void print_metric_headers(struct perf_stat_config *config,
 		if (!config->iostat_run)
 			fputs(aggr_header_csv[config->aggr_mode], config->output);
 	}
+	if (config->json_output) {
+		if (config->interval)
+			fputs("{\"unit\" : \"sec\"}", config->output);
+	}
 	if (config->iostat_run)
 		iostat_print_header_prefix(config);
 
-- 
2.38.1.431.g37b22c650d-goog

