Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7422B626693
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiKLDW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbiKLDWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:22:52 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D845E6A748;
        Fri, 11 Nov 2022 19:22:49 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id m6so6454015pfb.0;
        Fri, 11 Nov 2022 19:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0CN9KCdpK4u7NxmO5wQL4MzpD0DAJLpwtVLTuJk4vQ=;
        b=Z6dvodBIXjUdb9tCj4aXWOPOdkT6GbCOJdmAA+/maqCO+IkBju69uWmjHhg+RlTHlG
         iksnmwtHfVk01EYI7MNg3xOJWbkl6xcXgUqjJIv9yR5gskNmuOE6K4rOOj6FaKgtZOsk
         2UmOFmfHZtrCo02fWNgzKBONepRjphNvMsQKBUZJIzfpwQT3IN7duWD+m7EcfcUzp2jY
         Z0usvoPV0eyQqUU1BbMJ9kpw5HL2ZUI52MRU8NK/wUJ+869v6mWV0b0ovqEwdwL2RG6X
         h3bS19nlYe6jihE7zldZG52zHgCjMB9cLUzARPYV5jYuVVjKjnawdPhKxwVS7iqnqTsw
         WXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r0CN9KCdpK4u7NxmO5wQL4MzpD0DAJLpwtVLTuJk4vQ=;
        b=BBL6VVVI/EJjc9MvetbuPJ3An1Lt3YtMUSrcVRT4NkXWI201CRWqCBuzX5ZIHo8mNv
         m5Y5zW+351PIFEiH1QlE0ACTCPwzTOxPxnbTdVBeHMoxMgqiGxPid9oSoXjza43eXpgp
         Cyx4dAIUlVY2Y4ljb6eEzY8zneoesF4lg0dOmHJXZf9KLgmgRd0IgC89pxewFV+OusQM
         iJwFou6VULSBrJ7cOR5Qd0pRZXXK3YiJuZNLdFDqBXDFjEdYCt60v3ThqpHo+og7yRCw
         SxVx09k2pCFezWFJM+5lnwqcICcm9TI+Lw29FrbzOv7ktA7Sy7Y2zkCeSdeHms0n80+K
         deGQ==
X-Gm-Message-State: ANoB5pmHIJjLa1uZbzuW2P6k6RC0VafkYLxFpE9Tb8aNpwwrHMxMDJh6
        x58W9KanV0avd5NsFrvUINI=
X-Google-Smtp-Source: AA0mqf6WbseI8lwrVZN4Mg12ZDBlO0Of0jKojxdS5T5uRPr839H1U+S2RGl5wT7sAdJ2ArseVRLknA==
X-Received: by 2002:a63:4a06:0:b0:46f:469a:249d with SMTP id x6-20020a634a06000000b0046f469a249dmr4158484pga.471.1668223369305;
        Fri, 11 Nov 2022 19:22:49 -0800 (PST)
Received: from balhae.roam.corp.google.com ([2607:fb90:27dc:8408:33d7:3b01:eee1:84b])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b00186f0f59d1esm2434552plb.192.2022.11.11.19.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 19:22:48 -0800 (PST)
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
Subject: [PATCH 01/11] perf stat: Fix crash with --per-node --metric-only in CSV mode
Date:   Fri, 11 Nov 2022 19:22:34 -0800
Message-Id: <20221112032244.1077370-2-namhyung@kernel.org>
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

The following command will get segfault due to missing aggr_header_csv
for AGGR_NODE:

  $ sudo perf stat -a --per-node -x, --metric-only true

Fixes: 86895b480a2f ("perf stat: Add --per-node agregation support")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 657434cd29ee..ea41e6308c50 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -534,7 +534,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 			[AGGR_CORE] = 2,
 			[AGGR_THREAD] = 1,
 			[AGGR_UNSET] = 0,
-			[AGGR_NODE] = 0,
+			[AGGR_NODE] = 1,
 		};
 
 		pm = config->metric_only ? print_metric_only_csv : print_metric_csv;
@@ -819,6 +819,7 @@ static int aggr_header_lens[] = {
 	[AGGR_SOCKET] = 12,
 	[AGGR_NONE] = 6,
 	[AGGR_THREAD] = 24,
+	[AGGR_NODE] = 6,
 	[AGGR_GLOBAL] = 0,
 };
 
@@ -828,6 +829,7 @@ static const char *aggr_header_csv[] = {
 	[AGGR_SOCKET] 	= 	"socket,cpus",
 	[AGGR_NONE] 	= 	"cpu,",
 	[AGGR_THREAD] 	= 	"comm-pid,",
+	[AGGR_NODE] 	= 	"node,",
 	[AGGR_GLOBAL] 	=	""
 };
 
-- 
2.38.1.493.g58b659f92b-goog

