Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9163B74364F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjF3IAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF3IAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:00:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39751713;
        Fri, 30 Jun 2023 01:00:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-311099fac92so1884303f8f.0;
        Fri, 30 Jun 2023 01:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688112031; x=1690704031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A8FnmCCz7avUcOjil/VxXP8BWdBesWE35fMFLOG+zfM=;
        b=Te325GePj1V1DJnW6/YqZe1cLLVmY/Hl2Ra5DOMFH+AjsljkDe4GLJAt4HetxmZHMG
         6hs/f1VsVvrIYwzh8woH4s4CLvmCXQonD9nEtonuErVhrIAynjnJrDH6zV2Qa+aP3Tsx
         6bDH4fQxifehCTpjAGFMiuL0DExhIB/L/j2F2Kn429qHTD4SE/DYv/7qcUW+p/pl7skM
         7X010/U3/9T9pHV93kdyQj+4UuIaBDnrALr8p+CxkYL5xhYxyY1Uyj/ST2WjikErWJnM
         7raHWYrjWxcvodxUyZD2b+L543eQsnLFK6duFl5QjbblakfIt6+voogdwemA6DxlPs6W
         gv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688112031; x=1690704031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8FnmCCz7avUcOjil/VxXP8BWdBesWE35fMFLOG+zfM=;
        b=QBQAvgT1e1dr3DGF+3V5ID9RFceSOtsGiyCzOoHfAsjkw6Jzk37jlL6RI5mh0qSjNq
         eaP6p9kYr1b704KEAHa8pmXO4oeG8l/25kUBzq9nANx3nq6Fk8Bm/by9pDVD0IlKO1Ww
         JGj6Ivf2WHjMUUH7Bjixb5t3WeXXjgbye5jjpca4FXn8NZsfta7pYstQ7hi/pGYaf6IG
         jecrY8Pfbwj9O6tGd/NhyIl1kz2/WFlkdCwlpPuJBdjjWE1GKFjIAPZmTdoCNsES/ofr
         aApClYAp/ekIAvFti/bE+8fsMzQVPdS8HgpkAQhgu+2qyCwXtkWTMZPmFIYFthuJS3w1
         LaYA==
X-Gm-Message-State: ABy/qLapLlKM9cTZAahy1bg5WaO+B333jWeYk07OW3Z8ui6MX1I9H0s2
        NpoUlvREgYwJJEqGlfwWhrE=
X-Google-Smtp-Source: APBJJlHceyknYZd/od2MM2r7dprrhRcaPC788isslwGOi7QoNWp5Krq7bfc6DIEfs4QylAsf1IV+0w==
X-Received: by 2002:adf:fd43:0:b0:313:f18d:1f2c with SMTP id h3-20020adffd43000000b00313f18d1f2cmr1640240wrs.38.1688112031114;
        Fri, 30 Jun 2023 01:00:31 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t15-20020a0560001a4f00b00313f676832bsm11422388wry.93.2023.06.30.01.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:00:30 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf/benchmark: Fix spelling mistake "synchronious" -> "synchronous"
Date:   Fri, 30 Jun 2023 09:00:29 +0100
Message-Id: <20230630080029.15614-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in an option description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/bench/sched-seccomp-notify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/sched-seccomp-notify.c b/tools/perf/bench/sched-seccomp-notify.c
index eac4ef60090f..2e8205c61141 100644
--- a/tools/perf/bench/sched-seccomp-notify.c
+++ b/tools/perf/bench/sched-seccomp-notify.c
@@ -33,7 +33,7 @@ static bool sync_mode;
 static const struct option options[] = {
 	OPT_U64('l', "loop",	&loops,		"Specify number of loops"),
 	OPT_BOOLEAN('s', "sync-mode", &sync_mode,
-		    "Enable the synchronious mode for seccomp notifications"),
+		    "Enable the synchronous mode for seccomp notifications"),
 	OPT_END()
 };
 
-- 
2.39.2

