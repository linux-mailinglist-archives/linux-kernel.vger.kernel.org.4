Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F8F62669B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiKLDXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiKLDXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:23:20 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4C3748CD;
        Fri, 11 Nov 2022 19:23:06 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 78so5781157pgb.13;
        Fri, 11 Nov 2022 19:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTFTOX/kprKoP+hImIdGvwpMnAr8GQwZEs5VpSrhOZY=;
        b=RugQCGv9Xqv2uGNErew1QtbUd7y3ngz5R+GUbaiYIxZW+RYvuEGSw3Kk6fAiUxZJZe
         yCiP0naoiBrkrJm+iFN3MCruAbKF4ngD20W88QHLfLQciob32aQCuKuls5lAHzISjqYL
         zAS6aXI/UPdzpjgXErhGaw5pf30z/JcrjbsWrmpx3iGDneLxDa87rYkLyfCB/9fMTmX8
         wFkvuTdaVXSVftpB4ty3ifxJkbqLwALdW9Xo4fgm3+kyE7zuws/pqBZazHKgZde9UmjA
         6caTpcpBgqTLkHSNXrKv1aJXMrEhjWAaPnjJn2Nmoc2oGiYKkPybfJ6LRLofgDb7HSKk
         XS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VTFTOX/kprKoP+hImIdGvwpMnAr8GQwZEs5VpSrhOZY=;
        b=dz/FZLyQVpL7puluQrgD/1gipo4Yj/3d+t4mjPkpW85ykcqKcTOSh/DK+yXtRjDKFy
         zIXzxKuWyes5elCz6N9NPa3vSf8P9lEO3eOxjCIGupY1Nw2QQr3i2tQqPlTRfvsKQ/Fd
         RjAkoo2s7pR3O43l3P0I+ePG/5sMzDZx/NGEQns59FcWfTOF2mZdh7BiDi1aQ1sl39Op
         dwybLF7WXI6+jL6MxtijKagy5WdNavQhCM86KOJTx86fI88hlwoXJBH9kvxUr9vSJ/bQ
         PGPziWha4wHML5VCAZPvG4Oxbk7f1Vc1cgShpXY3mnAKk2aN10vFxk013XxyZyCmEyGY
         KYzA==
X-Gm-Message-State: ANoB5pnMOSpZaCbInxN5/5EVBjE0AP5Ro3b70rpYwUptERpCI5mcLWW3
        nUG/kZzOAQavlaT6n6X3LeA=
X-Google-Smtp-Source: AA0mqf7MGykr+gff36idH8uHk/rYBzEV+NaBMn/3OfmY/vqd8SjZDTtAgy5RPH+z57E90p0dThubaQ==
X-Received: by 2002:a63:d057:0:b0:46e:be03:d9b2 with SMTP id s23-20020a63d057000000b0046ebe03d9b2mr3991257pgi.406.1668223385890;
        Fri, 11 Nov 2022 19:23:05 -0800 (PST)
Received: from balhae.roam.corp.google.com ([2607:fb90:27dc:8408:33d7:3b01:eee1:84b])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b00186f0f59d1esm2434552plb.192.2022.11.11.19.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 19:23:05 -0800 (PST)
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
Subject: [PATCH 10/11] perf stat: Fix summary output in CSV with --metric-only
Date:   Fri, 11 Nov 2022 19:22:43 -0800
Message-Id: <20221112032244.1077370-11-namhyung@kernel.org>
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

It should not print "summary" for each event when --metric-only is set.

Before:
  $ sudo perf stat -a --per-socket --summary -x, --metric-only true
   time,socket,cpusGhz,insn per cycle,branch-misses of all branches,
       0.000709079,S0,8,0.893,2.40,0.45,
  S0,8,         summary,         summary,         summary,         summary,         summary,0.893,         summary,2.40,         summary,         summary,0.45,

After:
  $ sudo perf stat -a --per-socket --summary -x, --metric-only true
   time,socket,cpusGHz,insn per cycle,branch-misses of all branches,
       0.000882297,S0,8,0.598,1.64,0.64,
           summary,S0,8,0.598,1.64,0.64,

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ce81798b5864..96bb7a42fd41 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -549,7 +549,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 	}
 
 	if (!config->no_csv_summary && config->csv_output &&
-	    config->summary && !config->interval) {
+	    config->summary && !config->interval && !config->metric_only) {
 		fprintf(config->output, "%16s%s", "summary", config->csv_sep);
 	}
 
@@ -732,8 +732,13 @@ static void print_aggr(struct perf_stat_config *config,
 	 * Without each counter has its own line.
 	 */
 	for (s = 0; s < config->aggr_map->nr; s++) {
-		if (prefix && metric_only)
-			fprintf(output, "%s", prefix);
+		if (metric_only) {
+			if (prefix)
+				fprintf(output, "%s", prefix);
+			else if (config->summary && !config->no_csv_summary &&
+				 config->csv_output && !config->interval)
+				fprintf(output, "%16s%s", "summary", config->csv_sep);
+		}
 
 		first = true;
 		evlist__for_each_entry(evlist, counter) {
-- 
2.38.1.493.g58b659f92b-goog

