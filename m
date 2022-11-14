Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E95628D01
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbiKNXDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237904AbiKNXCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:02:44 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9975519025;
        Mon, 14 Nov 2022 15:02:36 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 62so3234502pgb.13;
        Mon, 14 Nov 2022 15:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd5GkeCeE0yxKOMovgVohdgD8iFx/xVnrv4/oHPrZuI=;
        b=R9Jluqc3uYSYzKHR1fx/DQAfhMUewFc9fiC60GFBxnsjXYZkyw27kmZxriO1IPJEyG
         4e+CztJ/pkBanz8uQhHc5ZYf3wPQb+H+NfCf5EXu/ZYroj3hs5NM9BaXzsl74zxFuo6P
         QUEw43FDRea5+HjJG0Jcj4Hvk5D7McLUPVRo9n0t78TfDN3OtQa8DWIetDNZJn5FvqQw
         z6MjJhqvXl2W4ZG1ORqTp6VDgzllTvfeDP56yHVB09PiL+b57k2cJ31Alr0srHUTCrnZ
         gdB4DbQYSq3CSECBSNk2MxLkogktK+VOSo8R+zvEQdFIPdPNTOCmcwRTwTFJ+2eBvbr8
         gSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nd5GkeCeE0yxKOMovgVohdgD8iFx/xVnrv4/oHPrZuI=;
        b=fz+8AvgpflIzVwencr46DblQV5RF4HKFpBYASRGhNYo45MthjTgnJLyOJ3Imbzxbje
         Bz1WbDyxIWet23c7xoeNLAPK39g6gT/y8pZ1gAAyUOGKM1qRWjkMyZltX7DfF3bq0Xkb
         QGjbrr7558MYaTUXVyiGFPlyy2zTzXpIHnEL7wUC3mK4j3lBBD/bReQ6jLs9813ppyU5
         hm891Uw+HObcyqO0F121MAn6spW+ch1Ep5id4evubM+mmPpFlusgjz8ii2n6ZTT5RNwS
         n7+21LmnjYE9rF15nzDBrJ+IDLDr6i9tpHgd1tEXyXLan0bpJ+rvQHXYxX65SPCek+YF
         G5oQ==
X-Gm-Message-State: ANoB5plBcDihdRWkT/sOSDr0pGdyVRVkO08NZ1Ojatk4giaxwJIYB/PT
        SNT7spFELdJDgkpRRswya1LvC/aZ99g=
X-Google-Smtp-Source: AA0mqf7OP9dojr16cGBTHkCZ+Hv6y6Eosc1LsmryTspfVc5G6F5LDBkolGXcJQAgMZoJBnas3JvU9w==
X-Received: by 2002:a63:ce04:0:b0:46b:2493:14ad with SMTP id y4-20020a63ce04000000b0046b249314admr13671274pgf.274.1668466956065;
        Mon, 14 Nov 2022 15:02:36 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:35 -0800 (PST)
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
Subject: [PATCH 04/19] perf stat: Split print_cgroup() function
Date:   Mon, 14 Nov 2022 15:02:12 -0800
Message-Id: <20221114230227.1255976-5-namhyung@kernel.org>
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

Likewise, split print_cgroup() for each output mode.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a230f65efa62..af2a561eb20c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -106,15 +106,32 @@ static void print_noise(struct perf_stat_config *config,
 	print_noise_pct(config, stddev_stats(&ps->res_stats), avg);
 }
 
+static void print_cgroup_std(struct perf_stat_config *config, const char *cgrp_name)
+{
+	fprintf(config->output, " %s", cgrp_name);
+}
+
+static void print_cgroup_csv(struct perf_stat_config *config, const char *cgrp_name)
+{
+	fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
+}
+
+static void print_cgroup_json(struct perf_stat_config *config, const char *cgrp_name)
+{
+	fprintf(config->output, "\"cgroup\" : \"%s\", ", cgrp_name);
+}
+
 static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
 {
 	if (nr_cgroups) {
 		const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
 
 		if (config->json_output)
-			fprintf(config->output, "\"cgroup\" : \"%s\", ", cgrp_name);
+			print_cgroup_json(config, cgrp_name);
+		if (config->csv_output)
+			print_cgroup_csv(config, cgrp_name);
 		else
-			fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
+			print_cgroup_std(config, cgrp_name);
 	}
 }
 
-- 
2.38.1.493.g58b659f92b-goog

