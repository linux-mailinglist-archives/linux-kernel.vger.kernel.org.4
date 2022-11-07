Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8112A62013D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiKGVeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiKGVdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:33:46 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD1F2195;
        Mon,  7 Nov 2022 13:33:29 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso182795pjn.0;
        Mon, 07 Nov 2022 13:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3kWpBC1NLbl49EVyM6kuTlOZ/tQuDbS9uiyiK9Bcd8=;
        b=FcSbzoNLCo8OoQLRTy1AojjTte1miTZf2JSnw5QprLwVDsrGsELCcwIEOdIuBoGpuI
         v5+QS0SkLzYXJtsLG8JJ19RCg1oSgUJNg6OMEKclucZVbPXotCqihsfZWk9GZfFgIqWG
         0Tl69ccf++bhhstTYh68opUzCqfz0nKNORwqH72toYynd+9Jvq6gLdU+gMo7f7qyAQuh
         5G+CqBcYQ/S6LR6b0mn8ceudSUEWwh0AXmK31d4feFd0YjHjQpivKkBuzRUyNhc4EFiv
         wCaAwr6Q2pvBvaNONSW5yJSEmo4bYtd8WrOoqJLnYK/xo4Z/eGoOTlgvZa8MJpV7pZu9
         HUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F3kWpBC1NLbl49EVyM6kuTlOZ/tQuDbS9uiyiK9Bcd8=;
        b=x4KYb1PdRWFTJFwHweqkRg2bJdPCyxNasrfpt8O8tTyvHeoi6n5JOiPNMnsjfVlLbV
         G8uiFLTnhPMQlufccdSENX4Z+1kUQeqsg2W96qtfR3UZ/WJ9nApnyTNXU5Qge13mYk6N
         2OhkxzedUVuuqiP0Ije5l9SfcWkiO5ylRyz91VYjo2Li0t1InFsCdd2Rsn9meL90t1Kp
         3E72IveYcUFRIqPanYGUEpZgNfjaWrkFiWQh2M1DjLkjnT5R7lx0HrWkJDPuel3SDEzB
         Ykc/KhlZ8uG9IMwcL7ZWtTOSKJ3Owso+1JfPIMPo/85mc4Zeiq8QjWZKygEg3R0LRTo4
         rYEQ==
X-Gm-Message-State: ACrzQf1/Fwohts8nM9NW4IcMleU+elBHttkM3z9HpsiqbtnPUbFa0eBz
        eBcPoblCH/eMIGPuExFthQM=
X-Google-Smtp-Source: AMsMyM5fLV37+O7kmaviYn3MmW+LUXgk4eB5+qxKrSreo0uaQHUHcCC7GfzhORwSE+ongdf/sXPXUA==
X-Received: by 2002:a17:902:e846:b0:187:2127:cbb with SMTP id t6-20020a170902e84600b0018721270cbbmr44249969plg.125.1667856808976;
        Mon, 07 Nov 2022 13:33:28 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5850:5958:9c77:f623])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b0017f5ba1fffasm5366413pln.297.2022.11.07.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:33:28 -0800 (PST)
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
Subject: [PATCH 8/9] perf stat: Fix condition in print_interval()
Date:   Mon,  7 Nov 2022 13:33:13 -0800
Message-Id: <20221107213314.3239159-9-namhyung@kernel.org>
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

The num_print_interval and config->interval_clear should be checked
together like other places like later in the function.  Otherwise,
the --interval-clear option could print the headers for the CSV or
JSON output unnecessarily.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index aab2576bd40f..a10af26c26ab 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -902,8 +902,8 @@ static void print_interval(struct perf_stat_config *config,
 		sprintf(prefix, "{\"interval\" : %lu.%09lu}", (unsigned long)
 				 ts->tv_sec, ts->tv_nsec);
 
-	if ((num_print_interval == 0 && !config->csv_output && !config->json_output)
-			 || config->interval_clear) {
+	if ((num_print_interval == 0 || config->interval_clear) &&
+			!config->csv_output && !config->json_output) {
 		switch (config->aggr_mode) {
 		case AGGR_NODE:
 			fprintf(output, "#           time node   cpus");
-- 
2.38.1.431.g37b22c650d-goog

