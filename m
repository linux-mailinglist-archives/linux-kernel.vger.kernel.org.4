Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D434640E2E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiLBTEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiLBTEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:04:52 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243EEE2545;
        Fri,  2 Dec 2022 11:04:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so9148417pjc.3;
        Fri, 02 Dec 2022 11:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GpCCioLM9L47vHsyUU0BFPjstz/YfKaTI+OyQ8H60AQ=;
        b=SBv7vN5F83mWZfY6RlGdDBnby3yPJ/hp3wy0pAFNvBUn87UE0bDK/Onk50IPd8skFi
         3LND9ztwqJgBiwNpR5auGoLGWI3oezYu6CKeOpeVM1INsclgFIK0Ft2ZjISzjXHK6tYX
         WyaDw2bj4Eab+EDabRP3jg2DA3uZAxJW0upZ9JdBYkTMjpAtJ4fKtR6zAZtX3Q22n3vf
         7gkM9e+4Nczz4zjRh6ItgIK+HbuRw2ZP+2Xju5R2z2ntrC1C2qFw1PXbQPrPDLgIGsdy
         kK0Up0g77AfQh1nZkNRLd9PP7GXrM1pZ+27ZI4yomDQirVs9jzk2ibxqhAeNeVlAThNF
         abqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpCCioLM9L47vHsyUU0BFPjstz/YfKaTI+OyQ8H60AQ=;
        b=wy7NtkBtpWliSHNMGAG0toubrYynTcfpNiBaoaD/Lvzdewu7lbS2SLmuloY2bv5wZv
         po9QqWTrMEalHaUfLx4EADrpF4BHThEcdEBF+yuogbQy94aXU8lwCkBjGYgthiw3/kBx
         7i+uBRpF+7btERp75LSQ+hIpPO1RPQ7VxOJPqZOAb7je68k6jP88KVyCne/RHnAOX2v3
         2SAsknek7y75Pn2aK382tVRipnBu6qAXV12ccx8CyMxKMCd8X2Wpnu0gHimcRsbv0MDj
         93/wD5KcnTsveXmOzVrnCWjsJxfORGjd38YDYZxK1Ii0bWQ4XgswpAV5ToMTFRmqlSWe
         oZYQ==
X-Gm-Message-State: ANoB5plkXle5nmUVzg5PStxwttakY0S6EpHv4A1L0ZsVQ07W/+a6K/J8
        yWrnpqJ6vxTOnCN74EBWNKUQG7DckU8=
X-Google-Smtp-Source: AA0mqf6oQPE3WCcPYd0XtRo7kWWXhwSYNADZG0hb0w7qUerD/Af0gDxpiWKSz7AWaJg8ATOU0uovxw==
X-Received: by 2002:a17:902:8503:b0:188:e49e:2668 with SMTP id bj3-20020a170902850300b00188e49e2668mr57385385plb.125.1670007891546;
        Fri, 02 Dec 2022 11:04:51 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:8a28:738d:8b4c:8dca])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902a70600b0018862bb3976sm5842570plq.308.2022.12.02.11.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 11:04:51 -0800 (PST)
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
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        "Wang, Weilin" <weilin.wang@intel.com>
Subject: [PATCH] perf stat: Fix multi-line metric output in JSON
Date:   Fri,  2 Dec 2022 11:04:47 -0800
Message-Id: <20221202190447.1588680-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
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

When a metric produces more than one values, it missed to print the opening
bracket.

Fixes: ab6baaae2735 ("perf stat: Fix JSON output in metric-only mode")
Reported-by: "Wang, Weilin" <weilin.wang@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
Weilin, could you please verify it fixes your problem?

 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index f1ee4b052198..8d0bdd57163d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -440,7 +440,7 @@ static void new_line_json(struct perf_stat_config *config, void *ctx)
 {
 	struct outstate *os = ctx;
 
-	fputc('\n', os->fh);
+	fputs("\n{", os->fh);
 	if (os->prefix)
 		fprintf(os->fh, "%s", os->prefix);
 	aggr_printout(config, os->evsel, os->id, os->nr);
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

