Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0983636812
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbiKWSCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239343AbiKWSCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:17 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5011893CC7;
        Wed, 23 Nov 2022 10:02:17 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so2526037pjc.2;
        Wed, 23 Nov 2022 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XCyVoN2CehHx7RpmSNkS0ILYMPbGDge+MWsh49BZP0=;
        b=RA6XwERAQ9oFGKRK9FwW2+BAXVuDXEcWwE98pPTTLsUP3d/uoo+JL//dsBAHnjn4YX
         r41ok0+UGjJ+K1LT5J3SdMujw8e0BulQwi3Lcb3Cp/GjmqYJqO+VDT9wAJbV6d2rnYju
         WGmkHN/N3eh3XepR7sYmi6x7gzb9c6dF8l5NxzN+k5SNSS8FLJHyg1lVrz/g/wzFltnh
         Im0n53P1/kfTNowa3pf9fMXGAqer8r/eGnrCNNalZx1GRcURXPsVDNkgjBkgqeEE1Roa
         r7RGzZB0EBZB5KcoNvu04H65LpGejG3zpHEBgWxJ3xdOiFHXNdAquYcJMz4e7Gb2nJBJ
         7rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/XCyVoN2CehHx7RpmSNkS0ILYMPbGDge+MWsh49BZP0=;
        b=e6dLkJ91kdtIrZ9W4/ilx+sXFmQpIFW+eIWnVluRccnPgYzpAwAyQNK4FfamAFVCXD
         2xnQyZo8krq0baUDbZKbrqCqeWKRd6PD29SD1AOsWxbroEN/b1OXtr4BE+RVkMsRCkdw
         zJM7IHrvm8fUiOqpRsXrIrr7g/uSR21oSmLMI6S8ao0pFjcr58qD1P1pvuygkIufPEKH
         s1B8NQ692n8qbFAQMAfSofTaqLLqqQ+u63tN996qNQY4ayI8BRWxwESKRevfRwno3Vgc
         Pi96Y8wUOjXYLpnTB+65RvH32KAhmRphUm6/74HMLfD6CqhBj/8fYCkkM7SLd70BYw/L
         k1sg==
X-Gm-Message-State: ANoB5pnQWiWIRqDivTc3GoytDahG87olscMZq9tb6T1Qph548Vgn5soc
        podUpHuoBe7IO7VODbZ/eGU=
X-Google-Smtp-Source: AA0mqf59GDhKSyTePcmHXcmPXPe4IwSZ8QKzZBWKzqgEWXanTT2rXLZgYVVcUunvq1wvsC06q3C0fg==
X-Received: by 2002:a17:902:6847:b0:183:6555:38ef with SMTP id f7-20020a170902684700b00183655538efmr13403292pln.157.1669226536694;
        Wed, 23 Nov 2022 10:02:16 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:16 -0800 (PST)
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
Subject: [PATCH 04/15] perf stat: Use scnprintf() in prepare_interval()
Date:   Wed, 23 Nov 2022 10:01:57 -0800
Message-Id: <20221123180208.2068936-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221123180208.2068936-1-namhyung@kernel.org>
References: <20221123180208.2068936-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should not use sprintf() anymore.  Let's pass the buffer size and use the
safer scnprintf() instead.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 15c88b9b5aa3..744b7a40f59a 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1073,23 +1073,23 @@ static void print_metric_headers(struct perf_stat_config *config,
 }
 
 static void prepare_interval(struct perf_stat_config *config,
-			     char *prefix, struct timespec *ts)
+			     char *prefix, size_t len, struct timespec *ts)
 {
 	if (config->iostat_run)
 		return;
 
 	if (config->csv_output)
-		sprintf(prefix, "%lu.%09lu%s", (unsigned long) ts->tv_sec,
-				 ts->tv_nsec, config->csv_sep);
+		scnprintf(prefix, len, "%lu.%09lu%s",
+			  (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
 	else if (!config->json_output)
-		sprintf(prefix, "%6lu.%09lu ", (unsigned long) ts->tv_sec,
-				 ts->tv_nsec);
+		scnprintf(prefix, len, "%6lu.%09lu ",
+			  (unsigned long) ts->tv_sec, ts->tv_nsec);
 	else if (!config->metric_only)
-		sprintf(prefix, "{\"interval\" : %lu.%09lu, ", (unsigned long)
-				 ts->tv_sec, ts->tv_nsec);
+		scnprintf(prefix, len, "{\"interval\" : %lu.%09lu, ",
+			  (unsigned long) ts->tv_sec, ts->tv_nsec);
 	else
-		sprintf(prefix, "{\"interval\" : %lu.%09lu}", (unsigned long)
-				 ts->tv_sec, ts->tv_nsec);
+		scnprintf(prefix, len, "{\"interval\" : %lu.%09lu}",
+			  (unsigned long) ts->tv_sec, ts->tv_nsec);
 }
 
 static void print_header_interval_std(struct perf_stat_config *config,
@@ -1390,7 +1390,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 
 	if (interval) {
 		prefix = buf;
-		prepare_interval(config, prefix, ts);
+		prepare_interval(config, buf, sizeof(buf), ts);
 	}
 
 	print_header(config, _target, evlist, argc, argv);
-- 
2.38.1.584.g0f3c55d4c2-goog

