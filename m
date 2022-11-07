Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807FB620137
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiKGVdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiKGVdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:33:24 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD79328;
        Mon,  7 Nov 2022 13:33:23 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id k22so11912408pfd.3;
        Mon, 07 Nov 2022 13:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OYL7vpqm8L3ADcCJc6hKNFYnwJB/S0aPLCXr3zst78=;
        b=CESh0/ZbpAqv78rvTm8npz/mdldte6JqrpQpXmkhJ2wRVcw0OaAFcL7610kd1GdKl8
         AZCMrJ9+Fs+7tIV9NG0S4KQq/FViPJ+GxPNZg5ErU7py8WNJmC716PJCcJ3NKBDpkVC0
         xTzO6S6hKRmmYXSM5FtGZYrsRN6DufyRAY9noU6V7TwryqQRIz7PAiORUIAZwdCOGtRG
         TQZE32AFfYDUYjXo5n+KUygsPtM/N/UdLqjpylqsmJqrf7h0JP3WScHuthqjjoywNV5i
         GG2fqxjkgycjEBQsNbmHSCwgfzuhZYojwxUFKW94EHDJAjtXmLofBafb/AdjMS5CfY+m
         /D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7OYL7vpqm8L3ADcCJc6hKNFYnwJB/S0aPLCXr3zst78=;
        b=Gsk8NJHsaKlyseXSHVyi43sTCcqumycHxBkRHw55Dj7H7zF0hr1dXbzXx2xFzG+dwA
         aR9BwCA1noYhTuiTqIBqtlkC6HqUDyFSbdemfNVL3wCNztLM27imDn8vwJVbaXsCAVfj
         Ul8KlujcZkT3hb330FYjWm1jqcUsrFjRanVL70M7QWMTiVyTFtwQlQOdF89GM8RBlOOc
         Cm5BCPMRCH7MEUYvWFIulfn/5MJaaRM5eGifBz+VJypjhXpj9tFsMeCEaVNiSKZhAJC+
         yHKGnsijxjN/mEht8tKyKQL5qLXCz4lo10GxFDk6lp4+rmbLlgesAwcyxueEidAmCWXa
         vUzw==
X-Gm-Message-State: ACrzQf2pj+rdmyjVSS5yGMXW6hKeUqWXliPXxlozkPb/bTnsybCkTAn5
        PlUTxi332PrXWA5EEI6u/lU=
X-Google-Smtp-Source: AMsMyM4u9NO1JFKWbXomkYIi87uIFh6amlEwYP336vQAVT1rKngy/BkfKMLL3jc/+8xl8wSXW1Ii1A==
X-Received: by 2002:a65:6950:0:b0:439:51cd:8b8b with SMTP id w16-20020a656950000000b0043951cd8b8bmr45185677pgq.230.1667856802573;
        Mon, 07 Nov 2022 13:33:22 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5850:5958:9c77:f623])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b0017f5ba1fffasm5366413pln.297.2022.11.07.13.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:33:22 -0800 (PST)
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
Subject: [PATCH 3/9] perf stat: Clear screen only if output file is a tty
Date:   Mon,  7 Nov 2022 13:33:08 -0800
Message-Id: <20221107213314.3239159-4-namhyung@kernel.org>
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

The --interval-clear option makes perf stat to clear the terminal at
each interval.  But it doesn't need to clear the screen when it saves
to a file.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 17d656566cd9..d4936a502560 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -892,7 +892,7 @@ static void print_interval(struct perf_stat_config *config,
 	FILE *output = config->output;
 	static int num_print_interval;
 
-	if (config->interval_clear)
+	if (config->interval_clear && isatty(fileno(output)))
 		puts(CONSOLE_CLEAR);
 
 	if (!config->iostat_run && !config->json_output)
-- 
2.38.1.431.g37b22c650d-goog

