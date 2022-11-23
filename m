Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8830636845
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiKWSFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239477AbiKWSDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:03:04 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F705AE52;
        Wed, 23 Nov 2022 10:02:31 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id q1so17382336pgl.11;
        Wed, 23 Nov 2022 10:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JY8VK7mm86rFloCYzzq/VVEp4y79oTf5pSVCAGXfaQ=;
        b=C3zIKkzcOV1TrjDmX6L0bR17gpwYhWEv+xiT26HBcW84xtlj6fhBFmAhqs/3COFcXC
         VTliI5vz+jWa/qL3CuqC093JzQaTYQxGRYsJeu5E2Vh0A6KPTTX9RK6v13oH7FxofezU
         ELMK78JeU0oKkj2ajvHSsRcYpyNJofsveA+3B59/AmnyY1QaxmIH7gnJpDe3QcjgadXd
         +st0ZbMXUBZIHN1Q1Zvdzag9tlDQl6Vi2la14+gtB3OrvY3AcudiCunKfvFclQNUCoCG
         r17Y0gOQnWapFlBkd5ZSyxrgB9j8Kdk8uJHxx5Jy5tSnwzgyI5AFZMQfVoldKaIW/wG1
         EmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6JY8VK7mm86rFloCYzzq/VVEp4y79oTf5pSVCAGXfaQ=;
        b=28iQmFTaojSpc/AkvzOwSBnydjfQBOOOo+qOqj2DuBT7E31E7d1/TrJYd/b1/SzkbO
         caM2ZnJK/EMRRITVrlfC3s9dn/wvUYM9i/Xb+NYgbHTSJjBmrkM5noig8YN3hM0Ko3S0
         ahye8tjiJTXm+LNziGUYM2PEXktPgXBgIZ2l11BV0Cw0TVa6jElgjIEX6AistyOvHRzx
         ANOZWXHdrFRuoHy9kov6evgicKRtzmZonlWY92Zs8Kg/0BY+QffqQ9MlhDtYMszb5BMy
         MuiXTGbOCgqFI4yagxDUBWXJxAIB39FxQR3B5w9w3PgJAHqllDmcCHy42spNB5NQO/OB
         7U2g==
X-Gm-Message-State: ANoB5pkG/Za2xy2rO1gKZG6mrG0HcnUV4b0IgTH/Gd32lJyJ1Cfh5C8j
        4N2KcX0ksfokdHOAc+JECJ0=
X-Google-Smtp-Source: AA0mqf7vcBxFMByPUU7rwlxMbnZhN96WF30PCK9tOW/rD2bjv+ZT9tMEToEQD6UGDRjeSpNlTKB+pg==
X-Received: by 2002:a63:ff5f:0:b0:46f:b6df:3107 with SMTP id s31-20020a63ff5f000000b0046fb6df3107mr8603480pgk.454.1669226550830;
        Wed, 23 Nov 2022 10:02:30 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:30 -0800 (PST)
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
Subject: [PATCH 14/15] perf stat: Rename "aggregate-number" to "cpu-count" in JSON
Date:   Wed, 23 Nov 2022 10:02:07 -0800
Message-Id: <20221123180208.2068936-15-namhyung@kernel.org>
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

As the JSON output has been broken for a little while, I guess there are
not many users.  Let's rename the field to more intuitive one. :)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 43640115454c..7a39a1a7261d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -281,19 +281,19 @@ static void print_aggr_id_json(struct perf_stat_config *config,
 
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
-		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
+		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"cpu-count\" : %d, ",
 			id.socket, id.die, id.core, nr);
 		break;
 	case AGGR_DIE:
-		fprintf(output, "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d, ",
+		fprintf(output, "\"die\" : \"S%d-D%d\", \"cpu-count\" : %d, ",
 			id.socket, id.die, nr);
 		break;
 	case AGGR_SOCKET:
-		fprintf(output, "\"socket\" : \"S%d\", \"aggregate-number\" : %d, ",
+		fprintf(output, "\"socket\" : \"S%d\", \"cpu-count\" : %d, ",
 			id.socket, nr);
 		break;
 	case AGGR_NODE:
-		fprintf(output, "\"node\" : \"N%d\", \"aggregate-number\" : %d, ",
+		fprintf(output, "\"node\" : \"N%d\", \"cpu-count\" : %d, ",
 			id.node, nr);
 		break;
 	case AGGR_NONE:
-- 
2.38.1.584.g0f3c55d4c2-goog

