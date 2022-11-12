Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1D0626698
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbiKLDXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiKLDXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:23:02 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DA16BDEF;
        Fri, 11 Nov 2022 19:23:01 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id g62so6401919pfb.10;
        Fri, 11 Nov 2022 19:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbEusILygfyXCEYiRvFZYs6C5FIrT8mquksHXk+bSQE=;
        b=nFWYLFCBnNJIWO0i7LwEHho/IHZxZr9ZFzjAaSJ0N103+jj0CMLjuhKLu8cWWS9oox
         i3mEVOCCFaBd05ZpkrIjuv0ljua8sjwbR26wry1ReovQUOhTBr77hZNPPuhjuL4KqCMd
         LaMtQPUb/BqSPJzKQvYWILGIFyHcryi4bbwM1MiGvs2oQUC8AEhxjd1awBVSRwLLKR6R
         34kNGr/yJvQ46fN04rkxH6NuLnW8TFLcdHUacFb4MHlgczWUiw13wYvChLtfoLXQBOFs
         +fxlDveeGlTqp6I/VPRZW6FHIoV8tAjmjF7xG1H2LOb5N7LL+Nu98j49F/kIznWdz1zb
         kKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QbEusILygfyXCEYiRvFZYs6C5FIrT8mquksHXk+bSQE=;
        b=gnF2yUYvZQ7LGprX0vSyrpFRhhnmr60i1EYV6nKEbtfE3r5BdxpaUB7X3ILGlcfK23
         DZ+WUVpps3MvAIR1SZOHoI9ynwBWTeGacwbQpXB3Fh+WyPDeArulZ3UQaTQFyb5texsu
         wA2EiZZXExK8SONf8wv7OBVjvOufPiUbBx0ynvutKwqUjPGlMkXJKwhiRznImcXV/vLr
         VM1lzaVN/CHUBD7WPthkyqeSoPnmrdhOsNPYB1y3KGCop8fBX7b2OfjUclR4BMORISWN
         K5MDsFK2YYiJmvoC3hUrAECbIWWl/d2mjoHprcsYySOsPjEE+8HhSuEuXADoZ6Lb2xW3
         6S6w==
X-Gm-Message-State: ANoB5pkHPmlSby5OjHPBfAULdrA9YXnZOsXMJNx2YWhZWgS4Aa070Bnu
        yUbssFDWCZhtrWoxUDRaFSE=
X-Google-Smtp-Source: AA0mqf4TAKxmdWaVyBAbpcpCh7pItq+ZzIqTMILvY2ViyogaqHH5IKQBfxf81ofFv/214ca8dHqVTQ==
X-Received: by 2002:a63:e60b:0:b0:470:3fc2:2b08 with SMTP id g11-20020a63e60b000000b004703fc22b08mr4006195pgh.162.1668223380465;
        Fri, 11 Nov 2022 19:23:00 -0800 (PST)
Received: from balhae.roam.corp.google.com ([2607:fb90:27dc:8408:33d7:3b01:eee1:84b])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b00186f0f59d1esm2434552plb.192.2022.11.11.19.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 19:23:00 -0800 (PST)
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
Subject: [PATCH 07/11] perf stat: Add header for interval in JSON output
Date:   Fri, 11 Nov 2022 19:22:40 -0800
Message-Id: <20221112032244.1077370-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221112032244.1077370-1-namhyung@kernel.org>
References: <20221112032244.1077370-1-namhyung@kernel.org>
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

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index dbd3ba380c9f..03d58277e8d6 100644
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
2.38.1.493.g58b659f92b-goog

