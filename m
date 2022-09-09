Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A162C5B4334
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiIIXuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIIXua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:50:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7509E6CD29;
        Fri,  9 Sep 2022 16:50:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so6809263pjm.1;
        Fri, 09 Sep 2022 16:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=uqNGHBaxQiO3zHKtcKrEz0wmZHMWANgckYzO3CzGdLY=;
        b=E+ZKmg2n23E0vzSyOd6haKeLiJoq7hROyUB1hus9euLbLbgHjyt1Se2cg3/2WGdDb0
         73cnIqDzadw8Pxl05oYweYWCeVXaIMq4a33rVU0Rd1SotvMxbYUtv/RY3DAVvWGfEtUM
         pVYQmJ4jCQDukIhnVT57O/22OGzpaS2CDZKLNKFOb5j0wIaKAt8NzZkWHpvHB6KMxq6R
         /LBHYpQXN7I3t5Xp2Jv4VmBF8dfNc5DB3uhEJBbvxqHtYcjOHNpuCUFxcpjR+CCEroXp
         kvc8o/WN2kdHUsN6rQEZNK4Qmc05IPscQT/Xd4ogRdkDmf5jIuQowfqF2Meyo0IsB07/
         Vscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=uqNGHBaxQiO3zHKtcKrEz0wmZHMWANgckYzO3CzGdLY=;
        b=fjmvQvFLnOQ1WB5MQyEnOr9A0W8EJzFS1dD0jp7Ynom4D5cRU6aaBgtZH9qho3JgkY
         GpyAgNSY6srGXFo86x/+W95OegUwF8LN6xDRut9gFbYzJbAPCLCcY0S36YMGMsX4U9tB
         1HxcQdBrXA8DCH4AEcMtTNMkkmuU51z4iy3DnSYPmupECUPUZiAg/6j5ZJD3DL3fEXfd
         7UxuX/YgmG2l7iCeMzGMC+T1PcMJCnyPRINx/ppiSVv6jBswnM323giTZs6GFXvjC9w7
         4dTiBregErgXMOBOE2yKHsO11heXU4uL+/yYKgBQfRzUl6gdxHLQwT0G8FNDPX7Qdyc7
         N4ug==
X-Gm-Message-State: ACgBeo3Dvql0r3kxFmJYhPrZVvyItgu4roLuQKC9L/7h5l+JpIpTX6E0
        d9Xu76qrzUK0sEis9fqvR6s=
X-Google-Smtp-Source: AA6agR6O38xvUzMJViUv8mpOAoSfybwwUUcAGWtU1G5Cv1HulnR03mkMyWepqKTDUPUmTAqPOCj+hw==
X-Received: by 2002:a17:903:120a:b0:172:5a63:7442 with SMTP id l10-20020a170903120a00b001725a637442mr16182615plh.55.1662767427814;
        Fri, 09 Sep 2022 16:50:27 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:f2b:e437:9e3e:53ec])
        by smtp.gmail.com with ESMTPSA id r16-20020aa79630000000b0053e75395705sm305837pfg.127.2022.09.09.16.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 16:50:27 -0700 (PDT)
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
        Stephane Eranian <eranian@google.com>
Subject: [PATCH] perf record: Fix a segfault in record__read_lost_samples()
Date:   Fri,  9 Sep 2022 16:50:24 -0700
Message-Id: <20220909235024.278281-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When it fails to open events record__open() returns without setting the
session->evlist.  Then it gets a segfault in the function trying to read
lost sample counts.  You can easily reproduce it as a normal user like:

  $ perf record -p 1 true
  ...
  perf: Segmentation fault
  ...

Skip the function if it has no evlist.  And add more protection for evsels
which are not properly initialized.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
I didn't add a Fixes tag as it's not sent to Linus yet.
But in case you want it.

  Fixes: a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")

 tools/perf/builtin-record.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 9df77b81a3bb..fe34d5db23bd 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1888,6 +1888,10 @@ static void record__read_lost_samples(struct record *rec)
 	struct perf_record_lost_samples *lost;
 	struct evsel *evsel;
 
+	/* there was an error during record__open */
+	if (session->evlist == NULL)
+		return;
+
 	lost = zalloc(PERF_SAMPLE_MAX_SIZE);
 	if (lost == NULL) {
 		pr_debug("Memory allocation failed\n");
@@ -1899,6 +1903,8 @@ static void record__read_lost_samples(struct record *rec)
 	evlist__for_each_entry(session->evlist, evsel) {
 		struct xyarray *xy = evsel->core.sample_id;
 
+		if (xy == NULL || evsel->core.fd == NULL)
+			continue;
 		if (xyarray__max_x(evsel->core.fd) != xyarray__max_x(xy) ||
 		    xyarray__max_y(evsel->core.fd) != xyarray__max_y(xy)) {
 			pr_debug("Unmatched FD vs. sample ID: skip reading LOST count\n");
-- 
2.37.2.789.g6183377224-goog

