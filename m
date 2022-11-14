Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4982F628D00
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbiKNXDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbiKNXCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:02:38 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E9A1BE88;
        Mon, 14 Nov 2022 15:02:35 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 6so11574808pgm.6;
        Mon, 14 Nov 2022 15:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLjySvlGPKnVQ41FH3ZyjLNiZRwop922hNhTc7oubmw=;
        b=FaZabm5DuOJ6hbUuo766RDOgcgo+o1/sjEMrbcLhz4lgO60PfZOSeQsv/uyZZeNGLp
         EvRuZ2zhPm7Nrcrvl1v6cCUtBw1np5SvUWPBvalBi8pX5RrMI4jORhKZ2z264EvbOqxa
         EYvnyGHmiVUOTOISIRVqEJ5GqpoauJabnPWNYHVa5o6pj7sbgX0ANgmz60x3I5Z1YPoM
         95OnMYnisQii8xJQ5UDcXi7fMBs9L15T83Ri22X77SBThVFJ9q6D9iH3AlJfq80y2s3w
         2vttHGPNs+IqEpUHuC3aP5qtINeLHOMRq9ga8tKwyRufIlOJe7Euk+kR2Kr6I1XmFPxh
         CeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mLjySvlGPKnVQ41FH3ZyjLNiZRwop922hNhTc7oubmw=;
        b=3o0zkLHzcQX2QclwK01TeSUlaHAS2VLXs+dgNU6pzYi5Ajj7bXBhJTLiOJXXrPgPhb
         Bb5Rnt8jt5M0UlndRFtyK0sakr04fh4f2KG2gABe4QRmY2VQqgosCPTc/rgfM9zxTizF
         K20eXL+xpY4yTHDj4Zg3fPoH1PnPJy2UiHZvwb475d+YyvbIQjY3gArF5U3bZr3xyvTt
         Pz7D/GusU5JChaU/UE/Bsw8yrMHAjGW7fZSB2yoyxdYS/+NbF5LiQmHie0PwgVK/bnFa
         OE4OE9Wmb0ZxWvWyinzKHJYiAVpUGLf2iTtAi5rCxy5hN/ivGdZhoyaElsewRKMnKBGz
         7hKA==
X-Gm-Message-State: ANoB5plB8TQZCe/4rSV83dVCNqy0mLaKW4RNqOU87d4uDivFREOcVXLQ
        dTA6535Hd14m5DIpUkZnPm4=
X-Google-Smtp-Source: AA0mqf7Bu1Oc5MTf/iTmHgxsalOIz/2Ge//af4EOwZTu0AWWWH3MT1vIpcU2O+zuvhuVFPqJPqDPMA==
X-Received: by 2002:a63:2243:0:b0:457:f843:ffcd with SMTP id t3-20020a632243000000b00457f843ffcdmr13400685pgm.101.1668466954619;
        Mon, 14 Nov 2022 15:02:34 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:34 -0800 (PST)
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
Subject: [PATCH 03/19] perf stat: Split print_noise_pct() function
Date:   Mon, 14 Nov 2022 15:02:11 -0800
Message-Id: <20221114230227.1255976-4-namhyung@kernel.org>
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

Likewise, split print_noise_pct() for each output mode.  Although it's
a tiny function, more logic will be added soon so it'd be better split
it and treat it in the same way.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 281b811f8574..a230f65efa62 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -62,17 +62,36 @@ static void print_running(struct perf_stat_config *config,
 		print_running_std(config, run, ena);
 }
 
+static void print_noise_pct_std(struct perf_stat_config *config,
+				double pct)
+{
+	if (pct)
+		fprintf(config->output, "  ( +-%6.2f%% )", pct);
+}
+
+static void print_noise_pct_csv(struct perf_stat_config *config,
+				double pct)
+{
+	fprintf(config->output, "%s%.2f%%", config->csv_sep, pct);
+}
+
+static void print_noise_pct_json(struct perf_stat_config *config,
+				 double pct)
+{
+	fprintf(config->output, "\"variance\" : %.2f, ", pct);
+}
+
 static void print_noise_pct(struct perf_stat_config *config,
 			    double total, double avg)
 {
 	double pct = rel_stddev_stats(total, avg);
 
 	if (config->json_output)
-		fprintf(config->output, "\"variance\" : %.2f, ", pct);
+		print_noise_pct_json(config, pct);
 	else if (config->csv_output)
-		fprintf(config->output, "%s%.2f%%", config->csv_sep, pct);
-	else if (pct)
-		fprintf(config->output, "  ( +-%6.2f%% )", pct);
+		print_noise_pct_csv(config, pct);
+	else
+		print_noise_pct_std(config, pct);
 }
 
 static void print_noise(struct perf_stat_config *config,
-- 
2.38.1.493.g58b659f92b-goog

