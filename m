Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2AE628D11
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbiKNXEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbiKNXDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:03:34 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D201CFF7;
        Mon, 14 Nov 2022 15:02:53 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 136so11594080pga.1;
        Mon, 14 Nov 2022 15:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CC4R4Flp577u4yBTPLbgmfpC6msSDOQY4vvA3zFzeIk=;
        b=OpbUbMzrJ8W7hEVVcarvOE/Z8N5O0xLRBWVksEFDk8w+TmJUJBuN7uh2O91GlRulr9
         Y2IWMKcTFhkUJVhxbibOpSAC9wSL+q3XdteqCdY8u8o9aNDbzpwNn+xgkqKMhE6JndJj
         eOLIaHKCo2mvZiryqz3tOJulC6MyA4FCMFkL3E9SH2uiGApf51qv63f2cZWG13Pe3+QK
         i+nI4G51mlF6aviVMx2E+auRZwyelGJYQTvR6mROKPlNiGKVqbxki4RHOlSejc+59vAo
         1z/22iOILU0/QO6CvQvdtmYQa9FihbnrwI9Hw3RMQssFYVfki/0k3EimJYaukpIJ+Hm2
         NVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CC4R4Flp577u4yBTPLbgmfpC6msSDOQY4vvA3zFzeIk=;
        b=FLZ43eGwYjYJgWQKjEzH2VhAcrC6JTFWKfEPmhGDlFEj0e6cmocBThXDIhgjpDrGd3
         +ovbKxjhFDHhUMFdpAIAFVQO/AhfRYpZX8xTo/AN+Fmr+CWR+BlUGyKn3XbSAmYyLMac
         iLXTac3QBTRS2Z4i9Tt+VPnx4aBDwLpCxjSV/v1kae4TEYU42+nBtC/O3lV2px297b7d
         1rqTTmvix5eJL+EeRhMU7zp69Ex6g5nx6GtcSI0r8xf5969axUsWbStb+MGbuAJu9NXA
         Shil0WDqrc7zsgxS2/j/GxhDPOmGDREfNbcztHKnRo7FxfxVmXWb0rv4zvW96KwO14zI
         bpcw==
X-Gm-Message-State: ANoB5plIkkGPXiuMxoS/UcB5Xr4PZSTWtG84bDFEqJbtkkd8CwN2bS++
        hchXiUBnz1azcVXL6bR8XhM=
X-Google-Smtp-Source: AA0mqf5hzDcsrFIeUhbK0dTdZ8XNjWXv/awUwAeKsZK5xa/ZU7fjI05cMw5hnDlDVLXV/742hiYHLQ==
X-Received: by 2002:a63:1b25:0:b0:459:5fef:a491 with SMTP id b37-20020a631b25000000b004595fefa491mr13869341pgb.150.1668466973275;
        Mon, 14 Nov 2022 15:02:53 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:52 -0800 (PST)
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
Subject: [PATCH 15/19] perf stat: Move condition to print_footer()
Date:   Mon, 14 Nov 2022 15:02:23 -0800
Message-Id: <20221114230227.1255976-16-namhyung@kernel.org>
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

Likewise, I think it'd better to have the control inside the function, and keep
the higher level function clearer.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index f97817628478..73cf898060c0 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1205,6 +1205,9 @@ static void print_footer(struct perf_stat_config *config)
 	double avg = avg_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
 	FILE *output = config->output;
 
+	if (config->interval || config->csv_output || config->json_output)
+		return;
+
 	if (!config->null_run)
 		fprintf(output, "\n");
 
@@ -1359,8 +1362,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		break;
 	}
 
-	if (!interval && !config->csv_output && !config->json_output)
-		print_footer(config);
+	print_footer(config);
 
 	fflush(config->output);
 }
-- 
2.38.1.493.g58b659f92b-goog

