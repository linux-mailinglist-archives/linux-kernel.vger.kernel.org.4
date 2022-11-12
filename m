Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE49762669A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiKLDXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiKLDXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:23:10 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A6D73430;
        Fri, 11 Nov 2022 19:23:04 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id m6so6454301pfb.0;
        Fri, 11 Nov 2022 19:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCrq93Ou9ulSTWplOyqr42G3tytqfI7Ze+qFafkY6Oc=;
        b=YzWwQaPHElVm0LGJ3HDfNkJ7OIvk7JmJcJ/5EuT2mwrgKGzvhiOv8qaFFA1M5Qs5Qb
         9mhboMBUNGaoDbX/9KE147crGSUvxQHeMJRk0uSUAoSv7Z/aTk/3fkTpvvVFkKflixez
         1QzQTdf5VInC8BHMH9LemeD3/a01k4YbHwdqs05qt9bPZ4ikmvi7g5AtubpcNpApamQO
         8Uo1+hlOgjTBfwZAFuNReZX9A0JFPCu/w+5iKwCk87Zau8eej0p+MkQ2otIeC8Nid2b6
         +amaAlsYlKrZ82qOis65OGP8cjYW399KLOegR1osuGkxPaWkFOv1J5PV0tm/lHKZAh/6
         LOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OCrq93Ou9ulSTWplOyqr42G3tytqfI7Ze+qFafkY6Oc=;
        b=syTIBWQdky/2D6xrTM/TBkwZjwjZ/3iRV0CJJuUHnN+Df+vwXVl0fVclYRYtr+LsUt
         UyWNAZWR8SAgL6TFb4wKRZcVxMT70UDe3HuiG48PraEfxrvlTvfX9VMl2lt2QaD3O1K2
         tOiI6OOuhIE6POip2ZeYYp/krTwNNXNvRONS3PGr08hmto6UxbImEmUk7MNGTcYVx+aj
         Vupni0km338W6660biubtdubDPqSu87fuDkGCbSx8AFyRUmjCyra1a2CWbL4lHYOl4Fc
         iK0GG76yWcPaqGencM043UKeXW54CF/rV+xXO8OnU9Tp8GWG3Wyh4IBzHJEgjYlJ8GJN
         g1+w==
X-Gm-Message-State: ANoB5pmQqzHrchE7BCWlSed+Q1/sEnPbyCaXp7ZqdzbVfW89rYMiAe0/
        /lztqYmEge+MeqNmVPxKDv7+49duyWM=
X-Google-Smtp-Source: AA0mqf4L1FzcVUO4d9VOppXXk7KZZsA3YcMh1DLLbkLM7f2Z9sDfi23myHfupcj8C0rgtudGiQ/5iA==
X-Received: by 2002:a63:4b18:0:b0:470:48c0:f37a with SMTP id y24-20020a634b18000000b0047048c0f37amr4073123pga.83.1668223384064;
        Fri, 11 Nov 2022 19:23:04 -0800 (PST)
Received: from balhae.roam.corp.google.com ([2607:fb90:27dc:8408:33d7:3b01:eee1:84b])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b00186f0f59d1esm2434552plb.192.2022.11.11.19.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 19:23:03 -0800 (PST)
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
Subject: [PATCH 09/11] perf stat: Consolidate condition to print metrics
Date:   Fri, 11 Nov 2022 19:22:42 -0800
Message-Id: <20221112032244.1077370-10-namhyung@kernel.org>
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

The pm variable holds an appropriate function to print metrics for CSV
anf JSON already.  So we can combine the if statement to simplify the
code a little bit.  This also matches to the above condition for non-CSV
and non-JSON case.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 5f4fb0bd4037..ce81798b5864 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -600,9 +600,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 			pm(config, &os, NULL, NULL, "", 0);
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
-		if (config->csv_output)
-			pm(config, &os, NULL, NULL, "", 0);
-		else if (config->json_output)
+		if (config->csv_output || config->json_output)
 			pm(config, &os, NULL, NULL, "", 0);
 		return;
 	}
-- 
2.38.1.493.g58b659f92b-goog

