Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2BF74BCC6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 10:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGHILm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 04:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHILl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 04:11:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0A41FC6;
        Sat,  8 Jul 2023 01:11:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-992e22c09edso291002666b.2;
        Sat, 08 Jul 2023 01:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688803899; x=1691395899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8JsdPx2PtCEj+8E+tenBNbAlijTmNN2EqyVkNdLKfmA=;
        b=rztSuS3v+nITm9k3tsJpLSvmzVE3zy9CxeLeSXc2C6hpHHlu2JWiOTJmiANEYXz9pa
         iPNmy94s66MAl+pmwGTHc1dkeRYJxxQDbXmcWl6fhLsOIuSdIlWd5Bfw6O2nJGkl0U+/
         CYuYrEq4hj9/MHupnUWYHz7Ygb+LIigJ1xJmhiWGLaBlhPq2lURUNwgb413C3KSfORZw
         1FBMHI9eN/zKizPlb5EFvAReSLChWeiyq3/pOvs94erbRLbyUlygcSf19EZItjuW0nOI
         KJ0/ocl1jx9c1QMuqqhkaPT80vfWEANYQOUVPEv4EuTgVONyi0KDN7TCGXv5e/po78KZ
         F7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688803899; x=1691395899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JsdPx2PtCEj+8E+tenBNbAlijTmNN2EqyVkNdLKfmA=;
        b=bUcnoeMY4piGJZY48ju6Wvt+NPrJVu+gIqRzQAXXWcIilUkxSX12ojVGH7oCqbFWLk
         O9nME9jlHPx+rzVDWW/9875PUulfQE6w2LsT+JgXqJQyc2Xk7sspx8+21rVHHidAfcV4
         ajmyajA+f/4bhQwbsivBBMY1vs+LeV0DJRpWL08E5afMkKdDGL5I3L3q2CflbmCopIuf
         xBgUC1UW5j5uBSSk1kqHRPJ/AIly93pp0EULnWaaSEb9/jmxFlwIlnziLeQ/A0bMS44X
         9qF/mQzh6+8Fub70wJFQcCbvVODIty2rNAJRQu/FZguA7lRaW/FNchzHZFCwXQfocOey
         ny7w==
X-Gm-Message-State: ABy/qLbvquXMrTXvhtW2PcJsxAvn6o1or2Ckaq0emN5C5k/Rnq2Kb+1H
        sU8s/Cs4ShPu9VJT2HsSqtVLsoKXZ2Qhrw==
X-Google-Smtp-Source: APBJJlE4SRjJJSfqI47lKi2L1n2FIAQTgGAQPjLr+o2ro9brA/66+l23EdfRFaJ7W2iUuGXDneiVYA==
X-Received: by 2002:a17:906:79c4:b0:982:9daf:9fcf with SMTP id m4-20020a17090679c400b009829daf9fcfmr5197948ejo.66.1688803898582;
        Sat, 08 Jul 2023 01:11:38 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id cw23-20020a170906c79700b0098963eb0c3dsm3152939ejb.26.2023.07.08.01.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 01:11:38 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] perf/core: Use local64_try_cmpxchg in perf_swevent_set_period
Date:   Sat,  8 Jul 2023 10:10:57 +0200
Message-ID: <20230708081129.45915-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use local64_try_cmpxchg instead of local64_cmpxchg (*ptr, old, new) == old
in perf_swevent_set_period.  x86 CMPXCHG instruction returns success in ZF
flag, so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

No functional change intended.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 kernel/events/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 78ae7b6f90fd..f84e2640ea2f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9595,16 +9595,16 @@ u64 perf_swevent_set_period(struct perf_event *event)
 
 	hwc->last_period = hwc->sample_period;
 
-again:
-	old = val = local64_read(&hwc->period_left);
-	if (val < 0)
-		return 0;
+	old = local64_read(&hwc->period_left);
+	do {
+		val = old;
+		if (val < 0)
+			return 0;
 
-	nr = div64_u64(period + val, period);
-	offset = nr * period;
-	val -= offset;
-	if (local64_cmpxchg(&hwc->period_left, old, val) != old)
-		goto again;
+		nr = div64_u64(period + val, period);
+		offset = nr * period;
+		val -= offset;
+	} while (!local64_try_cmpxchg(&hwc->period_left, &old, val));
 
 	return nr;
 }
-- 
2.41.0

