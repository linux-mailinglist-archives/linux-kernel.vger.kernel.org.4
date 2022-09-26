Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225A5EB1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiIZUId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiIZUIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:08:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8B07A511;
        Mon, 26 Sep 2022 13:08:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w10so7211300pll.11;
        Mon, 26 Sep 2022 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=Fx9hvwG/rasPOvbUmK3cj26jkXamy+G4vGSpbyVyxd0=;
        b=S36dYOwLYsE0JvmU6NwcdU+y2Wj6jnY2uJWyQkL/nm4S7U7W2f2QVAD6/5I4JeTvkr
         jqWwZY/InR5fNU5qCHXEV9prrEhOY0RRR6xv9TUXUxvsd+aFn1qDkdnzarrr4E92LqTJ
         fMGyj7LtyazBCjZl7hirW/X8KipqoDpgHGmLCEHevCqp9Q/a+Ygiib9Ve8+yK1fDd3F3
         U7zmWWheo86qV+JcDWxmGsNdzJ2HHuz98ej+UrjUwtv79elZwVbhegKRj/Ou3O3ShieR
         6gLIwuuiNuALekDzpHGy+LcE/a3mfG5kpQQwpFOvfG8lNsAKzO6j8699dVmPMpnspvM0
         ToMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=Fx9hvwG/rasPOvbUmK3cj26jkXamy+G4vGSpbyVyxd0=;
        b=VE+u/40YXCspeknk2yNPSB8KDMjeE0TgonunIN4/6EPV7s1Evwa8FQyAFmm1cNBXYo
         IqTrXb6fxS9K/YesIQ43s+8cS92ZUSWq240y7ah07wMmY4byQBk9Q535Jp6ywHSFhdBI
         lJ3Xn72w/O3VNrS5UEkc5rvd+aSDDnpd3e+eY72uWLpeEFxEiYZnLAqRhoaMyj5QwJSe
         MwFfY69UZNKuq2uV9B1ZA2Ej/pZINcL6vpqeRV4hETvuG1NanLV2wKp4ciwDfWIxNCwp
         8pWhs7rDV9xrZGS7sPKoqXOC435Xxlf9q+VZu0J/m90sU7r9q9KP1qGqGGBzLaZ8thaB
         uC4w==
X-Gm-Message-State: ACrzQf2K4U5hBWm/BRC1Xa7M6VIBINynNbZMpJOVEXNxM1T+4FKAFjCj
        BpjJBICjOELBYJ80sqBE0k8=
X-Google-Smtp-Source: AMsMyM6Z8B+WIxXnOWJgbwJpqmVL2pB56DWeCJG4au4tSxTDWeVurE1vE8ry6EWRw+zeYkMUKKAbGw==
X-Received: by 2002:a17:903:2345:b0:179:b6d0:f910 with SMTP id c5-20020a170903234500b00179b6d0f910mr22438500plh.6.1664222888196;
        Mon, 26 Sep 2022 13:08:08 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:2d32:19ce:817e:166])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78bd5000000b00540c24ba181sm12510148pfd.120.2022.09.26.13.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:08:07 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: [PATCH 6/6] perf stat: Don't compare runtime stat for shadow stats
Date:   Mon, 26 Sep 2022 13:07:57 -0700
Message-Id: <20220926200757.1161448-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220926200757.1161448-1-namhyung@kernel.org>
References: <20220926200757.1161448-1-namhyung@kernel.org>
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

Now it always uses the global rt_stat.  Let's get rid of the field from
the saved_value.  When the both evsels are NULL, it'd return 0 so remove
the block in the saved_value_cmp.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-shadow.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 99d05262055c..700563306637 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -35,7 +35,6 @@ struct saved_value {
 	int ctx;
 	int map_idx;
 	struct cgroup *cgrp;
-	struct runtime_stat *stat;
 	struct stats stats;
 	u64 metric_total;
 	int metric_other;
@@ -67,16 +66,6 @@ static int saved_value_cmp(struct rb_node *rb_node, const void *entry)
 	if (a->cgrp != b->cgrp)
 		return (char *)a->cgrp < (char *)b->cgrp ? -1 : +1;
 
-	if (a->evsel == NULL && b->evsel == NULL) {
-		if (a->stat == b->stat)
-			return 0;
-
-		if ((char *)a->stat < (char *)b->stat)
-			return -1;
-
-		return 1;
-	}
-
 	if (a->evsel == b->evsel)
 		return 0;
 	if ((char *)a->evsel < (char *)b->evsel)
@@ -120,7 +109,6 @@ static struct saved_value *saved_value_lookup(struct evsel *evsel,
 		.evsel = evsel,
 		.type = type,
 		.ctx = ctx,
-		.stat = st,
 		.cgrp = cgrp,
 	};
 
-- 
2.37.3.998.g577e59143f-goog

